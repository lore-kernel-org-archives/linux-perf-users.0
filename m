From: zhao bao <baozhao@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Sun, 27 Mar 2011 00:13:08 +0800
Message-ID: <AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>
	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>
	<AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
	<4D8DE695.3000606@gmail.com>
	<AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>
	<4D8DF6E4.1070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55648 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab1CZQNK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 26 Mar 2011 12:13:10 -0400
Received: by yia27 with SMTP id 27so784313yia.19
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Mar 2011 09:13:09 -0700 (PDT)
In-Reply-To: <4D8DF6E4.1070804@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

> You can compile latest perf userpsace and it should work with files from
> older kernels.
>
> David
>

Follow your guide, I git the latest kernel and compiled the perf tools
, then perf script works.
But I found the outputed address is  instruction address, not the
address caused  the page  fault. Can I get these addresses with perf
tool?
[root@localhost lab]# /root/bin/perf  script
           hello 30242 [000] 48324.304652: page-faults:
c05b6d35 clear_user ([kernel.kallsyms])
           hello 30242 [000] 48324.304684: page-faults:
c05b6d35 clear_user ([kernel.kallsyms])
           hello 30242 [000] 48324.304701: page-faults:
c05b68a0 __copy_to_user_ll ([kernel.kallsyms])
           hello 30242 [000] 48324.304746: page-faults:
870 _start (/lib/ld-2.13.so)
           hello 30242 [000] 48324.304750: page-faults:
4920 _dl_start (/lib/ld-2.13.so)
           hello 30242 [000] 48324.304753: page-faults:
17acb __i686.get_pc_thunk.bx (/lib/ld-2.13.so)
           hello 30242 [000] 48324.304755: page-faults:
4939 _dl_start (/lib/ld-2.13.so)
           hello 30242 [000] 48324.304765: page-faults:
a790 _dl_setup_hash (/lib/ld-2.13.so)
           hello 30242 [000] 48324.304768: page-faults:
14480 _dl_sysdep_start (/lib/ld-2.13.so)
           hello 30242 [000] 48324.304771: page-faults:
14560 _dl_sysdep_start (/lib/ld-2.13.so)
           hello 30242 [000] 48324.304774: page-faults:
159e0 brk (/lib/ld-2.13.so)
