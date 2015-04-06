From: Elazar Leibovich <elazar.leibovich@ravellosystems.com>
Subject: Re: Translation to File name in sys_enter_open
Date: Mon, 6 Apr 2015 20:21:39 +0300
Message-ID: <CAL2Y34Cb7YEkwJ24K9gCpN4cWDBxsrU=0HQOYXtEXihLUmdpsw@mail.gmail.com>
References: <CAGAANTWqLq4j-2rn=FPxOYw-dgG-2ed-JZfiQy76zB7WU4iA4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34130 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbDFRVk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 6 Apr 2015 13:21:40 -0400
Received: by iedfl3 with SMTP id fl3so30005094ied.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Apr 2015 10:21:39 -0700 (PDT)
In-Reply-To: <CAGAANTWqLq4j-2rn=FPxOYw-dgG-2ed-JZfiQy76zB7WU4iA4Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: sahil aggarwal <sahil.agg15@gmail.com>
Cc: linux-perf-users@vger.kernel.org

I don't think you really can do that in the general case. I guess that
you can check the CWD of the running process, and calculate the
absolute path from it. Though, of course, you don't know the exact
state of the filesystem when the event occured.

On Mon, Apr 6, 2015 at 1:08 PM, sahil aggarwal <sahil.agg15@gmail.com> wrote:
> Hi
>
> I enabled sampling on tracepoint sys_enter_open but filename field
> returned is address to filename as being passed to the system call,
> how i can translate this to actual file name while reading ring
> buffer.? How perf is doing it.?
>
> Thanks
> Regards
> Sahil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
