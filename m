From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Re: Translation to File name in sys_enter_open
Date: Tue, 7 Apr 2015 17:10:21 +0530
Message-ID: <CAGAANTWMC=drNiWJ=6SG_p_EAqSytS0mA2JMsp042LA6oeW6HQ@mail.gmail.com>
References: <CAGAANTWqLq4j-2rn=FPxOYw-dgG-2ed-JZfiQy76zB7WU4iA4Q@mail.gmail.com>
	<CAL2Y34Cb7YEkwJ24K9gCpN4cWDBxsrU=0HQOYXtEXihLUmdpsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:32997 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbDGLkW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Apr 2015 07:40:22 -0400
Received: by oblw8 with SMTP id w8so33827865obl.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2015 04:40:21 -0700 (PDT)
In-Reply-To: <CAL2Y34Cb7YEkwJ24K9gCpN4cWDBxsrU=0HQOYXtEXihLUmdpsw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Elazar Leibovich <elazar.leibovich@ravellosystems.com>
Cc: linux-perf-users@vger.kernel.org

Thank you Elazar.
BTW i found a way to achieve this other way. By enabling kprobe event
on function 'getname' which returns file name, this function is called
by do_sys_open, so i enabled sampling on sys_enter_open, getname,
sys_exit_open therefore getname between them gives file name.

On 6 April 2015 at 22:51, Elazar Leibovich
<elazar.leibovich@ravellosystems.com> wrote:
> I don't think you really can do that in the general case. I guess that
> you can check the CWD of the running process, and calculate the
> absolute path from it. Though, of course, you don't know the exact
> state of the filesystem when the event occured.
>
> On Mon, Apr 6, 2015 at 1:08 PM, sahil aggarwal <sahil.agg15@gmail.com> wrote:
>> Hi
>>
>> I enabled sampling on tracepoint sys_enter_open but filename field
>> returned is address to filename as being passed to the system call,
>> how i can translate this to actual file name while reading ring
>> buffer.? How perf is doing it.?
>>
>> Thanks
>> Regards
>> Sahil
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
