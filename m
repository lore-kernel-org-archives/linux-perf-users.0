From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/3] perf: Clean up power events
Date: Tue, 4 Jan 2011 08:11:49 +0100
Message-ID: <20110104071149.GA13299@elte.hu>
References: <1294073445-14812-1-git-send-email-trenn@suse.de>
 <1294073445-14812-3-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:35455 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897Ab1ADHMF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Jan 2011 02:12:05 -0500
Content-Disposition: inline
In-Reply-To: <1294073445-14812-3-git-send-email-trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: j-pihet@ti.com, linux-kernel@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Arjan van de Ven <arjan@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, rjw@sisk.pl, linux-perf-users@vger.kernel.org


* Thomas Renninger <trenn@suse.de> wrote:

>  	if (hlt_use_halt()) {
>  		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
> +		trace_cpu_idle(1, smp_processor_id());

Could we please also (in a separate followup patch) mark all the 'old' tracepoints 
as obsolete, via a comment in the source code - and also add an entry into 
Documentation/feature-removal-schedule.txt? Such things tend to get forgotten with 
time.

Thanks,

	Ingo
