From: taeung <treeze.taeung@gmail.com>
Subject: Re: About use of dlsym()
Date: Tue, 12 Aug 2014 14:51:22 +0900
Message-ID: <53E9AB5A.9040709@gmail.com>
References: <53E46E46.5000700@gmail.com> <874mxjh4il.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:40379 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbaHLFv0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Aug 2014 01:51:26 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so12504743pad.27
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Aug 2014 22:51:25 -0700 (PDT)
Received: from [192.168.1.215] ([106.245.241.10])
        by mx.google.com with ESMTPSA id jr5sm13255552pbc.75.2014.08.11.22.51.24
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Aug 2014 22:51:25 -0700 (PDT)
In-Reply-To: <874mxjh4il.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Thanks, Namhyung Kim

I've understood what you mean.
And I've read the patch which you told me.

There are the different between current version and the patch.
In current version, 'perfgtk', gtkstub.c aren't used.
and GUI_OBJS was changed into GTK_OBJS.

I thought about the reason why DL(Dynamic Library) is used instead of  
several ways of the patch.
But I need to look over more..

Thank you, again.

- Taeung -

On 08/11/2014 04:25 PM, Namhyung Kim wrote:
> Hi taeung,
>
> On Fri, 08 Aug 2014 15:29:26 +0900, taeung wrote:
>> Hello, perf hackers :-)
>>
>> I'm beginner in perf.
>> I'm analysing the sequence of function call and how it was written to
>> update 'report' of gtk view.
>>
>> This is a thread of a command 'perf report --gtk'
>>
>> 1. run_argv()
>> (in main of perf.c:534)
>>
>> 2. handle_internal_command()
>> (in run_argv of perf.c:420 )
>> So far, I've thought this process is to filter what command and option is
>>
>> 3. cmd_report()
>> (in run_builtin of perf.c:319) by function pointer
>>
>> 4. setup_browser()
>> (in cmd_report of builtin-report.c:750)
>>
>> 5. setup_gtk_browser()
>> (in setup_browser of ui/setup.c:74)
>>
>> 6. perf_gtk__init()
>> (in setup_gtk_browser of ui/setup.c:32)
>>
>> about number 6, I have a question.
>>
>> In setup_gtk_browser of ui/setup.c: 28 ~ 32,
>>
>>   28         perf_ui_init = dlsym(perf_gtk_handle, "perf_gtk__init");
>>   29         if (perf_ui_init == NULL)
>>   30                 goto out_close;
>>   31
>>   32         if (perf_ui_init() == 0)
>>   33                 return 0;
>>   34
>>
>> Why not call directly 'perf_gtk__init()' ?
>> Why call the function by function pointer(perf_ui_init) after it is
>> gotten by 'dlsym()' ?
>> Why use 'dlsym()' ?
>> Is it better than calling directly the function ?
> It was because many perf users wanted to reduce dependency in the main
> perf binary as they hardly/never use the GTK ui.  Although it can be
> disabled with NO_GTK2=1 when invoking make, they're just too lazy to do
> that. :)
>
> Please see https://lkml.org/lkml/2013/8/4/154 .
>
> Thanks,
> Namhyung
