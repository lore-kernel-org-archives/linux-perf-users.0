From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Perf report --percentage
Date: Sat, 11 Jun 2016 17:31:48 +0900
Message-ID: <20160611083148.GA13968@danjae.aot.lge.com>
References: <6076A35470B38B408600AA0E3B4A31E767471A9E@ORSMSX114.amr.corp.intel.com>
 <1936512.XMEGsyMYkf@agathebauer>
 <6076A35470B38B408600AA0E3B4A31E767471E8A@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34041 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcFKIcY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 11 Jun 2016 04:32:24 -0400
Received: by mail-pf0-f169.google.com with SMTP id 62so30363618pfd.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jun 2016 01:32:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6076A35470B38B408600AA0E3B4A31E767471E8A@ORSMSX114.amr.corp.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Sebastian, Shiny" <shiny.sebastian@intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hello,

On Wed, Jun 08, 2016 at 04:21:43PM +0000, Sebastian, Shiny wrote:
> Thanks Milian. I added -g graph,0 and it did add lot more percentages - it's still not adding up though.
> 
> #perf report -C 1 --no-children -g graph,0

I think it's because you used -C option to restrict samples only from
cpu 1.  One way to check this is adding 'cpu' to sort keys and compare
sample count and callchain count.

What is the result of this command?

  # perf report -C 1 --no-children -g graph,0,count -n -s +cpu


Thanks,
Namhyung


> output: 
> -   19.84%  fio          [kernel.kallsyms]  [k] _raw_spin_unlock_irqrestore
>    - _raw_spin_unlock_irqrestore
>       + 7.88% hv_ringbuffer_write
>       + 4.88% scsi_end_request
>       + 3.43% mix_pool_bytes
>       + 0.92% aio_complete
>       + 0.85% blk_run_queue
>       + 0.80% scsi_put_command
>       + 0.37% dio_bio_end_aio
>       + 0.35% do_blockdev_direct_IO
>       + 0.07% dio_complete
>       + 0.07% scsi_run_queue
>       + 0.06% __blockdev_direct_IO
>       + 0.05% scsi_io_completion
>       + 0.04% bio_endio
>       + 0.02% add_timer_randomness
>       + 0.02% vmbus_sendpacket_mpb_desc
>       + 0.01% hrtimer_start_range_ns
> 
> 
> Thanks,
> Shiny
