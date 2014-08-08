From: taeung <treeze.taeung@gmail.com>
Subject: About use of dlsym()
Date: Fri, 08 Aug 2014 15:29:26 +0900
Message-ID: <53E46E46.5000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:41054 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbaHHG3b (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 8 Aug 2014 02:29:31 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so6760037pac.17
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Aug 2014 23:29:30 -0700 (PDT)
Received: from [192.168.1.215] ([106.245.241.10])
        by mx.google.com with ESMTPSA id zq5sm1801738pbb.37.2014.08.07.23.29.29
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 23:29:29 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello, perf hackers :-)

I'm beginner in perf.
I'm analysing the sequence of function call and how it was written to 
update 'report' of gtk view.

This is a thread of a command 'perf report --gtk'

1. run_argv()
(in main of perf.c:534)

2. handle_internal_command()
(in run_argv of perf.c:420 )
So far, I've thought this process is to filter what command and option is

3. cmd_report()
(in run_builtin of perf.c:319) by function pointer

4. setup_browser()
(in cmd_report of builtin-report.c:750)

5. setup_gtk_browser()
(in setup_browser of ui/setup.c:74)

6. perf_gtk__init()
(in setup_gtk_browser of ui/setup.c:32)

about number 6, I have a question.

In setup_gtk_browser of ui/setup.c: 28 ~ 32,

  28         perf_ui_init = dlsym(perf_gtk_handle, "perf_gtk__init");
  29         if (perf_ui_init == NULL)
  30                 goto out_close;
  31
  32         if (perf_ui_init() == 0)
  33                 return 0;
  34

Why not call directly 'perf_gtk__init()' ?
Why call the function by function pointer(perf_ui_init) after it is 
gotten by 'dlsym()' ?
Why use 'dlsym()' ?
Is it better than calling directly the function ?

- Taeung -
