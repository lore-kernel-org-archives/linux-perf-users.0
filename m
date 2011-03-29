From: David Ahern <dsahern@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Tue, 29 Mar 2011 14:05:33 -0600
Message-ID: <4D923B8D.1020204@gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com> <AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com> <AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com> <AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com> <4D8DE695.3000606@gmail.com> <AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com> <4D8DF6E4.1070804@gmail.com> <AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com> <4D8EB605.7070407@gmail.com> <AANLkTi=JefJqiUdvZ+r+sS25+bbDG_c6M8825xKpSUnu@mail.gmail.com> <4D8FA787.7020308@gmail.com> <AANLkTinvS527WGa7+tYo7pqgZj1dSviY0HrLo=2XGqT-@mail.gmail.com> <loom.20110329T185259-431@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47251 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab1C2UFz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Mar 2011 16:05:55 -0400
Received: by pvg12 with SMTP id 12so84168pvg.19
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2011 13:05:54 -0700 (PDT)
In-Reply-To: <loom.20110329T185259-431@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: baozhao <baozhao@gmail.com>
Cc: linux-perf-users@vger.kernel.org



On 03/29/11 10:55, baozhao wrote:
> zhao bao <baozhao <at> gmail.com> writes:
> 
> 
>> I applyed this patch in the builtin-script.c , recompile and install
>> it. But I found it still doesn't  show any CR2 address info. The patch
>> seems to list a addr column, but perf script still work as before.
> 
>  Hi, I think I find the problem.
> In builtin-script.c,   array output_fields should also be
> changed,PERF_OUTPUT_ADDR should added to  [PERF_TYPE_SOFTWARE],  am I
> right?

The defaults do need to better detect when it exists. Until then you can
add addr to the --fields option.


> 
> static u64 output_fields[PERF_TYPE_MAX] = {
>        ....
>       [PERF_TYPE_SOFTWARE] = PERF_OUTPUT_COMM | PERF_OUTPUT_TID | \
>                               PERF_OUTPUT_CPU | PERF_OUTPUT_TIME | \
>                               PERF_OUTPUT_EVNAME | PERF_OUTPUT_SYM | \
>                               PERF_OUTPUT_ADDR,
> 
> 
> Here is the output:
> [root@localhost lab]#  /root/bin/perf script
>           hello  2229 [000]  1339.388865: page-faults: 0x804963c
>   c05ccbb3 clear_user ([kernel.kallsyms])
>           hello  2229 [000]  1339.388898: page-faults: 0x670834
>  c05ccbb3 clear_user ([kernel.kallsyms])
>           hello  2229 [000]  1339.388915: page-faults: 0xbf905d6b
>    c05cc70c __copy_to_user_ll ([kernel.kallsyms])
>           hello  2229 [000]  1339.388945: page-faults: 0x652870
>       870 _start (/lib/ld-2.13.so)
>           hello  2229 [000]  1339.388950: page-faults: 0x656920
>      4920 _dl_start (/lib/ld-2.13.so)
>           hello  2229 [000]  1339.388954: page-faults: 0x669acb
>     17acb __i686.get_pc_thunk.bx (/lib/ld-2.13.so)
>           hello  2229 [000]  1339.388958: page-faults: 0x66fe54
>      4939 _dl_start (/lib/ld-2.13.so)

And per another thread we can look at converting the sample addresses to
symbols/dsos.

David


> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
