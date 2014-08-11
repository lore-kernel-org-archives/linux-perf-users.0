From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: About use of dlsym()
Date: Mon, 11 Aug 2014 16:25:22 +0900
Message-ID: <874mxjh4il.fsf@sejong.aot.lge.com>
References: <53E46E46.5000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from lgeamrelo02.lge.com ([156.147.1.126]:36262 "EHLO
	lgeamrelo02.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbaHKHZZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 11 Aug 2014 03:25:25 -0400
In-Reply-To: <53E46E46.5000700@gmail.com> (taeung's message of "Fri, 08 Aug
	2014 15:29:26 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: taeung <treeze.taeung@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Hi taeung,

On Fri, 08 Aug 2014 15:29:26 +0900, taeung wrote:
> Hello, perf hackers :-)
>
> I'm beginner in perf.
> I'm analysing the sequence of function call and how it was written to
> update 'report' of gtk view.
>
> This is a thread of a command 'perf report --gtk'
>
> 1. run_argv()
> (in main of perf.c:534)
>
> 2. handle_internal_command()
> (in run_argv of perf.c:420 )
> So far, I've thought this process is to filter what command and option is
>
> 3. cmd_report()
> (in run_builtin of perf.c:319) by function pointer
>
> 4. setup_browser()
> (in cmd_report of builtin-report.c:750)
>
> 5. setup_gtk_browser()
> (in setup_browser of ui/setup.c:74)
>
> 6. perf_gtk__init()
> (in setup_gtk_browser of ui/setup.c:32)
>
> about number 6, I have a question.
>
> In setup_gtk_browser of ui/setup.c: 28 ~ 32,
>
>  28         perf_ui_init = dlsym(perf_gtk_handle, "perf_gtk__init");
>  29         if (perf_ui_init == NULL)
>  30                 goto out_close;
>  31
>  32         if (perf_ui_init() == 0)
>  33                 return 0;
>  34
>
> Why not call directly 'perf_gtk__init()' ?
> Why call the function by function pointer(perf_ui_init) after it is
> gotten by 'dlsym()' ?
> Why use 'dlsym()' ?
> Is it better than calling directly the function ?

It was because many perf users wanted to reduce dependency in the main
perf binary as they hardly/never use the GTK ui.  Although it can be
disabled with NO_GTK2=1 when invoking make, they're just too lazy to do
that. :)

Please see https://lkml.org/lkml/2013/8/4/154 .

Thanks,
Namhyung
