From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] perf stat: clarify unsupported events from uncounted
 events
Date: Fri, 27 May 2011 14:25:25 -0300
Message-ID: <20110527172525.GA10352@ghostprotocols.net>
References: <1306515106-11967-1-git-send-email-dsahern@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54941 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab1E0RZd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 May 2011 13:25:33 -0400
Content-Disposition: inline
In-Reply-To: <1306515106-11967-1-git-send-email-dsahern@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, fweisbec@gmail.com, paulus@samba.org, tglx@linutronix.de

Em Fri, May 27, 2011 at 10:51:46AM -0600, David Ahern escreveu:
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index f79bb2c..57eccf1 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -61,6 +61,7 @@ struct perf_evsel {
>  		off_t		id_offset;
>  	};
>  	struct cgroup_sel	*cgrp;
> +	int supported;
>  };

Can you make this be just a 'bool'?

- Arnaldo
