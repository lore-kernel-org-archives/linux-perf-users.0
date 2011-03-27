From: David Ahern <dsahern@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Sat, 26 Mar 2011 21:59:01 -0600
Message-ID: <4D8EB605.7070407@gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>	<AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>	<4D8DE695.3000606@gmail.com>	<AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>	<4D8DF6E4.1070804@gmail.com> <AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63791 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab1C0D7D (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 26 Mar 2011 23:59:03 -0400
Received: by gyd10 with SMTP id 10so600530gyd.19
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Mar 2011 20:59:01 -0700 (PDT)
In-Reply-To: <AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: zhao bao <baozhao@gmail.com>
Cc: linux-perf-users@vger.kernel.org



On 03/26/11 10:13, zhao bao wrote:
> Follow your guide, I git the latest kernel and compiled the perf tools
> , then perf script works.
> But I found the outputed address is  instruction address, not the
> address caused  the page  fault. Can I get these addresses with perf
> tool?
> [root@localhost lab]# /root/bin/perf  script
>            hello 30242 [000] 48324.304652: page-faults:
> c05b6d35 clear_user ([kernel.kallsyms])
>            hello 30242 [000] 48324.304684: page-faults:
> c05b6d35 clear_user ([kernel.kallsyms])
>            hello 30242 [000] 48324.304701: page-faults:
> c05b68a0 __copy_to_user_ll ([kernel.kallsyms])
>            hello 30242 [000] 48324.304746: page-faults:
> 870 _start (/lib/ld-2.13.so)
>            hello 30242 [000] 48324.304750: page-faults:
> 4920 _dl_start (/lib/ld-2.13.so)
>            hello 30242 [000] 48324.304753: page-faults:
> 17acb __i686.get_pc_thunk.bx (/lib/ld-2.13.so)
>            hello 30242 [000] 48324.304755: page-faults:
> 4939 _dl_start (/lib/ld-2.13.so)
>            hello 30242 [000] 48324.304765: page-faults:
> a790 _dl_setup_hash (/lib/ld-2.13.so)
>            hello 30242 [000] 48324.304768: page-faults:
> 14480 _dl_sysdep_start (/lib/ld-2.13.so)
>            hello 30242 [000] 48324.304771: page-faults:
> 14560 _dl_sysdep_start (/lib/ld-2.13.so)
>            hello 30242 [000] 48324.304774: page-faults:
> 159e0 brk (/lib/ld-2.13.so)

Without callchains it shows the IP when the event triggered. If you want
more detail try adding -g to perf-record to get callchains.
