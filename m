From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: PEBS event monitoring
Date: Thu, 29 Nov 2012 16:06:55 +0900
Message-ID: <87hao8q44w.fsf@sejong.aot.lge.com>
References: <50B6FBD0.1010406@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:58845 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab2K2HG5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Nov 2012 02:06:57 -0500
In-Reply-To: <50B6FBD0.1010406@core.kaist.ac.kr> (Chulmin Kim's message of
	"Thu, 29 Nov 2012 15:08:16 +0900")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chulmin Kim <cmkim@core.kaist.ac.kr>
Cc: linux-perf-users@vger.kernel.org

Hi Chulmin,

On Thu, 29 Nov 2012 15:08:16 +0900, Chulmin Kim wrote:
> Hi, all.
>
> Sorry for consecutive basic questions.
>
> I am about to use PEBS monitoring of Intel CPU. (westmere)
>
> Let me elaborate pfmon example a bit.
>
>  %  pfmon --smpl-module=pebs -einstructions_retired --inv=1
> --counter-mask=1 --long-smpl-periods=2660000 -uk -- foo
>  # counts   %self    %cum          code addr
>      1976  70.67%  70.67% 0x00000000004005e9
>       710  25.39%  96.07% 0x00000000004005f1
>        61   2.18%  98.25% 0x00000000004005e0
>        21   0.75%  99.00% 0x00000000004005ed
>        10   0.36%  99.36% 0x00000000004005f4
>         2   0.07%  99.43% 0xffffffff80583110
>         2   0.07%  99.50% 0xffffffff8024b4f8
>
> As shown in the above,
> I want to get the count number attached with address information.
>
> While the example is only for retired instruction event, I want the same
> thing for memory event (mem_load_retired) using Perf.
>
> Is there any guide for this issue?

Is this what you're looking for? (FYI, it's not merged yet)

https://lkml.org/lkml/2012/11/21/295

Thanks,
Namhyung
