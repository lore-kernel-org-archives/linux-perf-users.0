From: Pavel Emelyanov <xemul@parallels.com>
Subject: Re: [CRIU] Periodic checkpointing (using perf and signals?)
Date: Wed, 17 Jul 2013 19:57:11 +0400
Message-ID: <51E6BED7.20402@parallels.com>
References: <51E6BBC0.1080102@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:58100 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab3GQP5Q (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 17 Jul 2013 11:57:16 -0400
In-Reply-To: <51E6BBC0.1080102@codeaurora.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christopher Covington <cov@codeaurora.org>
Cc: linux-perf-users@vger.kernel.org, criu@openvz.org

On 07/17/2013 07:44 PM, Christopher Covington wrote:
> Hi,
> 
> I'm interested in taking checkpoints of processes from fast systems like
> hardware and restoring them on really slow software models for performance
> analysis.

Great idea! I will add it on http://criu.org/Usage_scenarios :)

> So far I've been able to save and restore checkpoints on the
> different systems using CRIU. Now I'm looking for some way to trigger the
> checkpointing. One basic use case might be to take a process that runs for say
> 100M instructions and take a checkpoint every 10M instructions to be restored
> as 10 parallel runs of the model.
> 
> I'm thinking of trying to use performance counters to trigger such behavior.
> Does perf already have support for triggering things like this?

I'm not 100% sure, but I've seen examples of python plugins for perf. From
these examples, I believe that it's possible to write a plugin, that will run
some code after noticing 100M instructions.

> If not, I'm
> thinking of trying to work in the ability to send a signal, like stop, to the
> process of interest once the specified count, such as 10M instructions, has
> been reached. CRIU or a wrapper could then wait for process of interest to
> stop, take the checkpoint, let the process continue, and then wait for it to
> stop again or exit. Would such an approach make sense?

It makes perfect sense! Several things to note from my side.

1. It's perfect case where the --track-mem + --prev-images-dir options should be
used. It will help subsequent dumps take MUCH less time, since with them CRIU 
will not take full task dump, but instead will only grab what has changed since
last dump.

2. Current version of CRIU doesn't work with stopped tasks. We're currently
developing it and this functionality will be available with v0.7 only. However,
I think it's OK just to start "criu dump" command after perf trigger. The dump
would work on a process that has done slightly more than 10M instructions, but
that would be the same in case you send it STOP signal.

> Thanks,
> Christopher

Thanks,
Pavel
