Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C835CB6B;
	Fri, 16 Oct 2026 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150118; cv=none; b=C3u8U30v1qgWQEumDXteH7UhGInkxZiNyN1qcrWRb7oeriI/lrp1iz38QF/4H2octpH6qJKRGFjHSYp/gJL6sTA9CdIDaT+0XszpvZDmKFXWfjl6dUvP3LXodV5qG9bdBgQ7YelctvQzHMQa7yHzVstQ7keujLoYvTMGZ4s2d6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150118; c=relaxed/simple;
	bh=Ur1oPaD8LRczsarB1wT8feo/Dghof+BJ3vmBEhzAEl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWczBb+sZUeuGpIku9HjKDMruqCo0IFjKtMMxIVZAXq1dXfhpfQRsH2K3zZ0sRVvjRHTYFH4165/FlVZAKt5guGQ9rKA9TwFCdheZ9158Ia2gRSrnZAVX1yhtONCl+FrPHimRp0jQ3WOiM33sNnau4+ntHVclc9eaTwD4SRBGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=EYCUaFKo; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="EYCUaFKo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1792149662;
	bh=eBxHgvw1bnsluoyWzXeY/eOCvQ6gAdG+35WYGC0Ze7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EYCUaFKoTMp0TvU3zfDhqCONxeK7m9S/MlyX0epIq2OOvQUuqldhSECiLInTGmnX7
	 Jt0mSNTy4PhFUezlKwW/EmUSnCJNMsfQnmPa/KxrDdqnd7vv8vsvl2QGat2He0Pl7+
	 /DJ7VCnt78xxH4A97H2Ge0fzyMx758GtZSk4ozP4=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 9B7E5FB63C;
	Fri, 16 Oct 2026 11:21:02 +0000 (UTC)
Date: Fri, 16 Oct 2026 11:20:58 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf c2c: Fix memory leaks on output fields
Message-ID: <atIImjxxXKUO2os8@shell.ilvokhin.com>
References: <20261015233237.542258-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015233237.542258-1-namhyung@kernel.org>

On Thu, Oct 15, 2026 at 04:32:37PM -0700, Namhyung Kim wrote:
> The perf_hpp_list was not freed after use.  Let's add it for the main
> c2c hists list in perf c2c report and a local list in print_pareto().
> 
> Previously it was detected by ASAN like below.
> 
>   =================================================================
>   ==42183==ERROR: LeakSanitizer: detected memory leaks
> 
>   Indirect leak of 1064 byte(s) in 7 object(s) allocated from:
>       #0 0x7f17334ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 61e8165ca90f7a4f06b73f064a938c76deaae079)
>       #1 0x0000005fa099 in zalloc  ../../lib/zalloc.c:8
>       #2 0x0000004faf6d in get_format  tools/perf/builtin-c2c.c:1978
>       #3 0x0000004fb45e in c2c_hists__init_output  tools/perf/builtin-c2c.c:2004
>       #4 0x0000004fb7de in __hpp_list__parse  tools/perf/builtin-c2c.c:2047
>       #5 0x0000004fbae9 in hpp_list__parse  tools/perf/builtin-c2c.c:2085
>       #6 0x0000004fee13 in print_pareto  tools/perf/builtin-c2c.c:2563
>       #7 0x0000004ffcd7 in perf_c2c__hists_fprintf  tools/perf/builtin-c2c.c:2708
>       #8 0x000000500ab5 in perf_c2c_display  tools/perf/builtin-c2c.c:2949
>       #9 0x0000005045c3 in perf_c2c__report  tools/perf/builtin-c2c.c:3522
>       #10 0x000000505caa in cmd_c2c  tools/perf/builtin-c2c.c:3676
>       #11 0x0000005df50e in run_builtin  tools/perf/perf.c:383
>       #12 0x0000005df9b1 in handle_internal_command  tools/perf/perf.c:436
>       #13 0x0000005dfd7f in run_argv  tools/perf/perf.c:480
>       #14 0x0000005e02d6 in main  tools/perf/perf.c:581
>       #15 0x7f1729450680 in __libc_start_call_main (/lib64/libc.so.6+0x3680) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
>       #16 0x7f1729450797 in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so.6+0x3797) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
>       #17 0x000000409c34 in _start (tools/perf/perf+0x409c34) (BuildId: 36a64600776d92e4ab7dfd5ca20c92280d72a645)
> 
>   SUMMARY: AddressSanitizer: 1064 byte(s) leaked in 7 allocation(s).
> 
> Fixes: c75540e3160f ("perf c2c report: Add dimension support")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
