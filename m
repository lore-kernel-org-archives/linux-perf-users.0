From: Kumar Ranjit-B04060 <B04060@freescale.com>
Subject: perf trace
Date: Mon, 18 Apr 2011 03:43:22 +0000
Message-ID: <8CB5FB7FBAFD274A8E92A53BBAFE339D0BB25C@039-SN1MPN1-003.039d.mgd.msft.net>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
 <AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>
 <AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>
 <AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
 <4D8DE695.3000606@gmail.com>
 <AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>
 <4D8DF6E4.1070804@gmail.com>
 <AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com>
 <4D8EB605.7070407@gmail.com>
 <AANLkTi=JefJqiUdvZ+r+sS25+bbDG_c6M8825xKpSUnu@mail.gmail.com>
 <4D8FA787.7020308@gmail.com>
 <AANLkTinvS527WGa7+tYo7pqgZj1dSviY0HrLo=2XGqT-@mail.gmail.com>
 <loom.20110329T185259-431@post.gmane.org> <4D923B8D.1020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.183]:3473
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752016Ab1DRDnZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 17 Apr 2011 23:43:25 -0400
In-Reply-To: <4D923B8D.1020204@gmail.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, baozhao <baozhao@gmail.com>

Hi David
I need to generate instruction trace for Freescale e500mc core. Please tell me whether I can use perf for that. 
If yes then please tell me some steps to do that.
Regards
Ranjit

-----Original Message-----
From: linux-perf-users-owner@vger.kernel.org [mailto:linux-perf-users-owner@vger.kernel.org] On Behalf Of David Ahern
Sent: Wednesday, March 30, 2011 1:36 AM
To: baozhao
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Fwd: perf trace cannot work with software events ?



On 03/29/11 10:55, baozhao wrote:
> zhao bao <baozhao <at> gmail.com> writes:
> 
> 
>> I applyed this patch in the builtin-script.c , recompile and install 
>> it. But I found it still doesn't  show any CR2 address info. The 
>> patch seems to list a addr column, but perf script still work as before.
> 
>  Hi, I think I find the problem.
> In builtin-script.c,   array output_fields should also be
> changed,PERF_OUTPUT_ADDR should added to  [PERF_TYPE_SOFTWARE],  am I 
> right?

The defaults do need to better detect when it exists. Until then you can add addr to the --fields option.


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

And per another thread we can look at converting the sample addresses to symbols/dsos.

David


> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-perf-users" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
