From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Accessing sample data (like period) for trace events from python
 scripts
Date: Wed, 17 Aug 2016 12:05:53 +0900
Message-ID: <20160817030553.GB8981@sejong>
References: <12483222.2TZrqxLJ8H@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:60696 "EHLO
	lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbcHQDGw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Aug 2016 23:06:52 -0400
In-Reply-To: <12483222.2TZrqxLJ8H@agathebauer>
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Hi Milian,

On Tue, Aug 16, 2016 at 08:42:01PM +0200, Milian Wolff wrote:
> Hey all,
> 
> It doesn't seem to be possible to access the period, tid and various other 
> sample fields from a python (and perl?) script using `perf script`. My use-
> case would be analyzing a perf data file created by perf inject
> --sched-stat.

I think you can access param_dict["sample"]["period"].

Thanks,
Namhyung


> 
> I have hacked something together locally in python_process_tracepoint, but 
> wonder what an upstreamable version should look like:
> 
> - I simply added the sample data to the dict, like is done in 
> python_process_general_event
> 
> - Alternatively, one could think of more `common_period(context)` functions. 
> If that is preferable, I could add the sample to the scripting_context and 
> make that work.
> 
> Please advise the path forward, I'm willing to send a patch upstream to make 
> it work.
> 
> Cheers
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
