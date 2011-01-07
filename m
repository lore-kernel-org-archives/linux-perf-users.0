From: Ingo Molnar <mingo@elte.hu>
Subject: Re: perf timechart broken
Date: Fri, 7 Jan 2011 13:33:12 +0100
Message-ID: <20110107123312.GC20761@elte.hu>
References: <201101071104.37576.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:45301 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab1AGMdU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 7 Jan 2011 07:33:20 -0500
Content-Disposition: inline
In-Reply-To: <201101071104.37576.trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>, Arjan van de Ven <arjan@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>


(Cc:-ed Arjan and Frederic too.)

* Thomas Renninger <trenn@suse.de> wrote:

> Hi,
> 
> Latest x86 tip has another perf timechart issue introduce
> by latest commits.
> 
> ./perf timechart
> gives me:
> "no trace data in the file"
> 
> I reverted  the latest changes and things seem to break
> between d854861c4292a4e675a5d3bfd862c5f7421c81e8
> and
> 69aad6f1ee69546dea8535ab8f3da9f445d57328
> (linux-2.6-x86 tree ids)
> 
> Be aware that ./perf timechart is currently broken
> and segfaults on idle events (in 2.6.36 and 2.6.37).
> I submitted a patch to stable@ but it did not get accepted,
> becaust it's not mainline yet.
> I concentrated on my latest patches instead of making sure
> the tiny fix gets into 2.6.37 first.
> 
> Ingo: It's a bit late for 2.6.37, if there is any chance
> to still get it in, the patch below is against linus master...
> otherwise I'll submit it for stable 36+37 asap.
> 
> Anyway to test above regression this mail is about, first
> apply below patch otherwise you get a segfault if idle
> (power_start/end) events got logged.
> 
> Thanks,
> 
>    Thomas
> 
> ---
> perf timechart: Fix segfault on cpu idle (power_start/end) events
> 
> power_end event does not have type and other attributes and thus does
> not match struct power_event.
> Another struct could be created, but data.cpu is fine for fixing the segfault
> and will work as long as C-states got initiated on the same CPU the idle state
> takes place which is the case for all recent HW.
> 
> The power_start/end events get deprecated anyway, thus this is an easy,
> riskless and sufficient solution for the segfault problem.
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: mingo@elte.hu
> CC: arjan@linux.intel.com
> 
> ---
>  tools/perf/builtin-timechart.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index 9bcc38f..b3028eb 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -502,7 +502,7 @@ static int process_sample_event(event_t *event, struct perf_session *session)
>  			c_state_start(pe->cpu_id, data.time, pe->value);
>  
>  		if (strcmp(event_str, "power:power_end") == 0)
> -			c_state_end(pe->cpu_id, data.time);
> +			c_state_end(data.cpu, data.time);
>  
>  		if (strcmp(event_str, "power:power_frequency") == 0)
>  			p_state_change(pe->cpu_id, data.time, pe->value);

-- 
Thanks,

	Ingo
