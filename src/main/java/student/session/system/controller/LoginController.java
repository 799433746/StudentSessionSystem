package student.session.system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import student.session.system.form.UserForm;
import student.session.system.user.User;
import student.session.system.user.UserType;

@Controller
public class LoginController extends BasicController
{


    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(Model model, UserForm userForm, RedirectAttributes attributes)
    {
        User user = new User(userForm);
        if (!user.isValid())
        {
            model.addAttribute("isValid", false);
            return "home";
        }

        if (userDAO.findByUserName(user.getUserName()) == null)
        {
            model.addAttribute("isExist", false);
            return "home";
        }
        if (!userDAO.findByUserName(user.getUserName()).getUserPassword().equals(user.getUserPassword()))
        {
            model.addAttribute("isWrong", true);
            return "home";
        }
        user = userDAO.findByUserName(user.getUserName());
        if (user.getUserIdentity() == UserType.TEACHER)
            return "redirect:/teacher/" + user.getUserName();

        else if (user.getUserIdentity() == UserType.STUDENT)
            return "redirect:/student/" + user.getUserName();

        else if(user.getUserIdentity()==UserType.ADMIN)
            return "redirect:/admin";
        else
            return "redirect:/login";

    }
}
