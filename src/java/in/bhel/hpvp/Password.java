/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package in.bhel.hpvp;

/**
 *
 * @author 6207537
 */
public class Password
{
  public Password() {}  

  public String getPassword(String user)
  {
    if (user.equals("technicalbid"))
      return "1234567";
    if (user.equals("pricebid")) {
      return "1234567";
    }
    return "1234567";
  }
}