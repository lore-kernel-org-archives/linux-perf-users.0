From: Lin Ming <minggr@gmail.com>
Subject: Re: perf trace cannot work with software events ?
Date: Sat, 26 Mar 2011 17:28:54 +0800
Message-ID: <AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48218 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab1CZJ2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 26 Mar 2011 05:28:55 -0400
Received: by iyb14 with SMTP id 14so1323489iyb.19
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Mar 2011 02:28:55 -0700 (PDT)
In-Reply-To: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: zhao bao <baozhao@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Sat, Mar 26, 2011 at 4:04 PM, zhao bao <baozhao@gmail.com> wrote:
> =A0Hi, =A0I want to trace page faults in my program. The result I wan=
ted like this:
> =A01st page fault at addrA.
> =A02nd page fault at addrB.
> =A03rd page fault at addrC
> =A0...
>
> =A0Perf seems providing this function, but I can't get what I want.
> =A0I use Perf on Fedora 14(kernel 2.6.35). The following is what I ha=
ve
> done in my machine.
> Thanks for help in advance.
>
> [root@localhost lab]# perf record -R -c 1 =A0-d =A0-e =A0faults ./hel=
lo

It's used to trace kernel space page faults, not for userspace code.

Lin Ming

> hello,world
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.010 MB perf.data (~418 samples) ]
>
> [root@localhost lab]# perf trace
> =A0Fatal: no event_list!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
