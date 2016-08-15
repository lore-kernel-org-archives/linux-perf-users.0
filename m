From: Andi Kleen <andi@firstfloor.org>
Subject: Re: usability issues with inlining and backtraces
Date: Mon, 15 Aug 2016 10:13:24 -0700
Message-ID: <87mvkeymyz.fsf@tassilo.jf.intel.com>
References: <3421510.JYGX19gbWH@milian-kdab2>
	<3237195.qkayrO3A0T@milian-kdab2> <16720652.kfi49F7aVl@milian-kdab2>
	<4329099.drS591pfTr@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46685 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbcHORN0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 15 Aug 2016 13:13:26 -0400
In-Reply-To: <4329099.drS591pfTr@milian-kdab2> (Milian Wolff's message of
	"Mon, 15 Aug 2016 13:32:24 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@redhat.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:

> On Monday, August 15, 2016 11:32:33 AM CEST Milian Wolff wrote:
>> On Monday, June 13, 2016 6:07:13 PM CEST Milian Wolff wrote:
>> > Ping?
>> > 
>> > Andi, I'd be very interested in your answers on my questions below. Most
>> > notably, `srcline` with `--call-graph ...,address` seems to be highly
>> > buggy
>> > for me.
>> 
>> Reping again.
>> 
>> Andi, or anyone else - I would really appreciate some more feedback on my
>> questions below.
>> 
>> I esp. wonder how to leverage srcline and addresses in the call-graph, as
>> that has the potential to greatly increase perf's value to me.
>
> OK, I have found at least two culprits that partially explain the behavior.
>
> On one hand, I'm simply missing debug information for some libraries, such as 
> libm, libc etc. pp. Due to that, the addr2line step fails and sym+offset is 
> displayed.
>
> On the other hand, there seems to be a bug in perf: 
>
> When hist_entry__get_srcline calls get_srcline I see from debug output
>
> he->ip=307e, sym=main -> rip_obj2dump=40307e -> mandelbrot.h:39
>
> But in callchain_list__sym_name, I see:
>
> cl->ip=40373d, sym=main -> rip_obj2dump=80373d-> main+8390413
>
> So it seems like the callchain_list is missing a normalization step that is 
> applied to the IP addresses stored in hist_entry. Can someone point me into 
> the right direction?
>
> If I change callchain_list__sym_name to pass cl->ip - cl->ms.map->start to 
> map__rip_2objdump this feature works much better for me, but I doubt that this 
> is the correct fix.

Yes it's something like that. Namhyung or Jiri probably know
what the right fix would be.

-Andi
