From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH 1/1] Fix number of events displayed in header
Date: Tue, 20 Mar 2012 16:42:41 -0300
Message-ID: <20120320194241.GA24870@infradead.org>
References: <1332271396-21756-1-git-send-email-ashay.r@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38033 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab2CTTms (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Mar 2012 15:42:48 -0400
Content-Disposition: inline
In-Reply-To: <1332271396-21756-1-git-send-email-ashay.r@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ashay Rane <ashay.r@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Ashay Rane <ashay.rane@tacc.utexas.edu>

Em Tue, Mar 20, 2012 at 02:23:16PM -0500, Ashay Rane escreveu:
> From: Ashay Rane <ashay.rane@tacc.utexas.edu>

Too short a changeset comment, please elaborate.

The change at least would have to be changed from

"Events: %llu", total_period

to 

"Total period: %llu", total_period

To be consistent in what we call "Events", i.e. right now it is telling
the number of PERF_RECORD_SAMPLE events, with your change it would be
showing the sum of the periods in all samples.

- Arnaldo
 
> Signed-off-by: Ashay Rane <ashay.rane@tacc.utexas.edu>
> ---
>  tools/perf/builtin-report.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 25d34d4..58a20cf 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -202,11 +202,9 @@ static size_t hists__fprintf_nr_sample_events(struct hists *self,
>  					      const char *evname, FILE *fp)
>  {
>  	size_t ret;
> -	char unit;
> -	unsigned long nr_events = self->stats.nr_events[PERF_RECORD_SAMPLE];
> +	u64 total_period = self->stats.total_period;
>  
> -	nr_events = convert_unit(nr_events, &unit);
> -	ret = fprintf(fp, "# Events: %lu%c", nr_events, unit);
> +	ret = fprintf(fp, "# Events: %llu", total_period);
>  	if (evname != NULL)
>  		ret += fprintf(fp, " %s", evname);
>  	return ret + fprintf(fp, "\n#\n");
> -- 
> 1.7.4.1
