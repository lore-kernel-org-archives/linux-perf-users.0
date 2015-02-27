From: Benjamin Moody <benjamin.moody@gmail.com>
Subject: Re: Bizarre results from perf event API
Date: Fri, 27 Feb 2015 21:41:59 +0000
Message-ID: <CAAk6P0XwbxpGtC=_0LFgHUVKB29TRPDB+Lt4J1OesEopTJDyyw@mail.gmail.com>
References: <CAAk6P0UvfKGhaFJKKdRkVcZbx+XNoJLGgKtw3f-hVuNfGSjNDQ@mail.gmail.com>
	<54E7D3B3.7020108@gmail.com>
	<CAAk6P0X5N3pvEjaEy-v6mHy7+fg3pdLyeRYR2VGm2wuqPYeOZw@mail.gmail.com>
	<54EBD21F.3030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34167 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbbB0VmA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Feb 2015 16:42:00 -0500
Received: by igal13 with SMTP id l13so3619565iga.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2015 13:41:59 -0800 (PST)
In-Reply-To: <54EBD21F.3030101@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Using this program, with the original 'mystat' program:

> #include <stdlib.h>
> #include <stdio.h>
> #include <time.h>
>
> main ()
> {
>          int i;
>
>          fork();
>          fork();
>
>          for (i = 0; i < 100000000; i++) {
>                  asm("nop");
>                  asm("nop");
>                  asm("nop");
>                  asm("nop");
>                  asm("nop");
>                  asm("nop");
>                  asm("nop");
>          }
>          wait(NULL);
>          wait(NULL);
>          wait(NULL);
>          wait(NULL);
> }

I consistently get a result of slightly over 1 billion instructions
(whereas perf stat gives the correct result of around 4 billion.)  I
get the same results on several systems, including:

  2.6.32-504.8.1.el6.x86_64 on a single-core Athlon
  2.6.32-431.17.1.el6.x86_64 on an 8-core Xeon
  3.10.0-123.13.2.el7.x86_64 on an 8-core Opteron
  3.16.0-0.bpo.4-amd64 on a 2-core Athlon

Will try to test with a newer kernel when I have a chance.

Benjamin
