Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58C314B6D;
	Tue, 18 Nov 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463802; cv=none; b=Whvoi4qLRQkvCXsSiyEgSYH/DoUBcGN7RQP+Wkpi7QsgJ4ca9TYazy9iTP3DZN6hfOBjrMzy7xAWBbgWpjgLQTWh09yOC5H7Z2AHt4bVH+4I1GcIbN2mhiNwAF+ws4tbWyEYDbEU2wtPYSAkhQ8bahfFPo3LDTS7nCtDUaHN3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463802; c=relaxed/simple;
	bh=jisAGFCHJK0LwGpz+zsikyimRU+OHDsc2kEwJIkv2e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ19LaKBu7mSojlnatfV3jp4TTZA33fKHr8t6rXaBMvsxqkw5ydF7zWh8jKL3iedU78HmxxAcfmjW2TOG/MSLkVosTKDf3wRSHn/C8MZMW9RgoZNEge7E8hKJQ302JA2GGFcDwjBWIJ5MNOWOSUpWIU7ovdXImvDy3lYfHbVx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kT0w/pYe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kT0w/pYe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eutwvmf1cUvRAiETZ2QkQIobb+TPHlTNm40TDuuj8fw=; b=kT0w/pYejSU8Mq8rPn139ZaJmZ
	0nWXEj8q0DTE7E4FLz7iOg+O99t1rd5ykIwspC9CNeKbVYioSrwcbERY0FkIVctW1hQA9EYgiTyJa
	8+O2wKUmSbgIveGTTWytm/ecWvF5wrpHdG/q8QL3hSQtDjAds7ph4vvEMQEvuAVn4/BJsKEXx/JxF
	wqOSITh/V+ZmhKkX24vrEbMdI9TxMaPBHEg+8envR7ZpXQNps1G+D4xxEdpKoSdeZjQzqnm5LdZ1Y
	b+zQI20PySaHoEVMOvdZVQ6XsRJ90hSIoPvK6zaJgnYBCXc1+07siXUHtpgv47LG/0bsU71/xbJsw
	jAf5Zcjg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLIck-00000009SlY-03R2;
	Tue, 18 Nov 2025 10:07:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D5B3230029E; Tue, 18 Nov 2025 12:03:09 +0100 (CET)
Date: Tue, 18 Nov 2025 12:03:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
Message-ID: <20251118110309.GP3245006@noisy.programming.kicks-ass.net>
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>

On Wed, Nov 12, 2025 at 04:05:26PM +0800, Dapeng Mi wrote:

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f6a08c73f783..77d3af5959c1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11964,7 +11964,7 @@ static int cpu_clock_event_add(struct perf_event *event, int flags)
>  
>  static void cpu_clock_event_del(struct perf_event *event, int flags)
>  {
> -	cpu_clock_event_stop(event, flags);
> +	cpu_clock_event_stop(event, flags | PERF_EF_UPDATE);
>  }
>  
>  static void cpu_clock_event_read(struct perf_event *event)
> @@ -12043,7 +12043,7 @@ static int task_clock_event_add(struct perf_event *event, int flags)
>  
>  static void task_clock_event_del(struct perf_event *event, int flags)
>  {
> -	task_clock_event_stop(event, PERF_EF_UPDATE);
> +	task_clock_event_stop(event, flags | PERF_EF_UPDATE);
>  }

I think it can both just be: PERF_EF_UPDATE. The only pmu::del() caller
hands in flags=0, but if there were to be flags added, we'd have to
audit all del methods anyway.

Also, the few comments we do have already note that ->del() must do
->stop(EF_UPDATE).
