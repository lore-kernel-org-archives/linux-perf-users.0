From: Martin Ichilevici de Oliveira <martin.i.oliveira@gmail.com>
Subject: Re: Event not supported
Date: Wed, 19 Feb 2014 08:38:17 -0300
Message-ID: <CAOanW0OiK8QTgLxajx=pEaW4XWD94hnNUOf=-e=Y1ch2LA9j3A@mail.gmail.com>
References: <CAOanW0NszteQapi6MzaUhkPpYA6yAe+bTc8Vkz033MDA3ynd_w@mail.gmail.com>
 <5303A4CF.3060200@gmail.com> <CAOanW0OsZXZU7Os=VrxA=s7SwRo+gK0qtpNjbX7E84fgL0swxg@mail.gmail.com>
 <5303B986.2070801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:62982 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaBSLi6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 19 Feb 2014 06:38:58 -0500
Received: by mail-ie0-f178.google.com with SMTP id ar20so134440iec.23
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2014 03:38:57 -0800 (PST)
In-Reply-To: <5303B986.2070801@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Manu,

Thank you very much for the reference and code. I checked my cpu and
the Northbridge performance counter flag is set. So my processor does
support profiling NB events. The question now is why it's saying it's
not.

I realized that perf support for NB events was in fact only added on
linux 3.9 [1], so I upgraded both my kernel and perf to 3.11. So
that's out.

The only thing I can think of is the the simple case that I'm just
using the wrong command. As I said, I'm not entirely sure how to use
unit masks. Can you please confirm that my usage is correct?

Do you have any other ideas on what might be the issue?

Thank you,
Martin

[1]: https://github.com/torvalds/linux/commit/e259514eef764a5286873618e34c560ecb6cff13

On Tue, Feb 18, 2014 at 4:50 PM, Manuel Selva <selva.manuel@gmail.com> wrote:
> CPUID is an X86 instruction: http://en.wikipedia.org/wiki/CPUID used to get
> information about the CPU. The Core performance counter extensions is
> mentioned on the wikipedia page.
>
> You'll need to write assembly code to use this instruction or use cpuid.h.
> Here is an example of using this instruction from a previous answer on this
> list:
>
> #include <cpuid.h>
> #include <stdio.h>
> int main()
> {
>         unsigned a, b, c, d;
>         /* check __get_cpuid_max here */
>         __cpuid(10, a, b, c, d);
>         printf("eax: %x ebx %x ecx %x edx %x\n", a, b, c, d);
>         int i;
>         for (i = 0; i < 10; i++)
>                 if (b & (1 << i))
>                         printf("event %d not supported\n", i);
>         return 0;
> }
>
>
> Manu
