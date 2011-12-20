From: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: [PATCH] perf: add ability to record event period
Date: Tue, 20 Dec 2011 15:20:19 -0200
Message-ID: <20111220172019.GE28058@infradead.org>
References: <1324391565-1369947-1-git-send-email-avagin@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40573 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab1LTRUe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Dec 2011 12:20:34 -0500
Content-Disposition: inline
In-Reply-To: <1324391565-1369947-1-git-send-email-avagin@openvz.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andrew Vagin <avagin@openvz.org>
Cc: linux-kernel@vger.kernel.org, a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu, asharma@fb.com, devel@openvz.org, dsahern@gmail.com, linux-perf-users@vger.kernel.org

Em Tue, Dec 20, 2011 at 05:32:45PM +0300, Andrew Vagin escreveu:
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 766fa0a..f8fd14f 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -700,6 +700,7 @@ const struct option record_options[] = {
>  	OPT_BOOLEAN('d', "data", &record.opts.sample_address,
>  		    "Sample addresses"),
>  	OPT_BOOLEAN('T', "timestamp", &record.opts.sample_time, "Sample timestamps"),
> +	OPT_BOOLEAN('P', "period", &record.opts.period, "Sample period"),
>  	OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
>  		    "don't sample"),
>  	OPT_BOOLEAN('N', "no-buildid-cache", &record.no_buildid_cache,

You forgot to update the tools/perf/Documentation/perf-record.txt tho.

I'm doing this for you this time, please take that into account next
time.

Regards and thanks for iterating thru this and working on perf!

- Arnaldo
