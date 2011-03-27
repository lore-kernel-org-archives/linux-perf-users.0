From: zhao bao <baozhao@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Sun, 27 Mar 2011 15:44:12 +0800
Message-ID: <AANLkTi=JefJqiUdvZ+r+sS25+bbDG_c6M8825xKpSUnu@mail.gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>
	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>
	<AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
	<4D8DE695.3000606@gmail.com>
	<AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>
	<4D8DF6E4.1070804@gmail.com>
	<AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com>
	<4D8EB605.7070407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:41015 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab1C0HoO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 27 Mar 2011 03:44:14 -0400
Received: by yia27 with SMTP id 27so885866yia.19
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Mar 2011 00:44:13 -0700 (PDT)
In-Reply-To: <4D8EB605.7070407@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

2011/3/27 David Ahern <dsahern@gmail.com>:
>
>
> On 03/26/11 10:13, zhao bao wrote:
>> Follow your guide, I git the latest kernel and compiled the perf too=
ls
>> , then perf script works.
>> But I found the outputed address is =C2=A0instruction address, not t=
he
>> address caused =C2=A0the page =C2=A0fault. Can I get these addresses=
 with perf
>> tool?
>> [root@localhost lab]# /root/bin/perf =C2=A0script
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
652: page-faults:
>> c05b6d35 clear_user ([kernel.kallsyms])
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
684: page-faults:
>> c05b6d35 clear_user ([kernel.kallsyms])
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
701: page-faults:
>> c05b68a0 __copy_to_user_ll ([kernel.kallsyms])
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
746: page-faults:
>> 870 _start (/lib/ld-2.13.so)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
750: page-faults:
>> 4920 _dl_start (/lib/ld-2.13.so)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
753: page-faults:
>> 17acb __i686.get_pc_thunk.bx (/lib/ld-2.13.so)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
755: page-faults:
>> 4939 _dl_start (/lib/ld-2.13.so)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
765: page-faults:
>> a790 _dl_setup_hash (/lib/ld-2.13.so)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
768: page-faults:
>> 14480 _dl_sysdep_start (/lib/ld-2.13.so)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
771: page-faults:
>> 14560 _dl_sysdep_start (/lib/ld-2.13.so)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hello 30242 [000] 48324.304=
774: page-faults:
>> 159e0 brk (/lib/ld-2.13.so)
>
> Without callchains it shows the IP when the event triggered. If you w=
ant
> more detail try adding -g to perf-record to get callchains.
>
Thanks for your kind reply.I am sorry  for misleading you.

The address I want is the value stored  in X86 CR2 register when page
fault  occurs, Does perf provide these  information?

Another question.
I find  a new utility called 'trace' mentioned in
http://lwn.net/Articles/415728/  which provides I want (trace report
-p). But I git the tip tree,  and make -j install in   tools/perf
directory,  I couldn't find trace utility. Where is the trace utility?
