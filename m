Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A313D255;
	Fri,  5 Jul 2024 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166320; cv=none; b=k56OJOMSdcXuT724s+ZwCBpvE2EhCFIisPfZbP5sB3UPX2VvJIjyVVCwJfs1IiNk/YW8Nj7FRlH2DCBt/lAIkOef2ZL4CZJO1oWwlQ2etmLntUXIged0WJuPNoITzF/G0BqiiAuJRO6NyeS1VHVYwFFDWO1RW9UNa4P0Ye1UqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166320; c=relaxed/simple;
	bh=4ImrnyqTvPba+DMBzQ4Kkh1BflmwGeqxSdDIBOiSQUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs8kw3MrGRUdq6OoLiORDdj6P/hZIdXk0/3zz5RsyYaBAxZMCByxVWYam0KMyMBW0l2U0ZOFdWbsvgZ3rItrfTuCeTiYhpcThQf6FClnA0EJDjJLuXOd5nw5k8we71HWICIp/9fILTlMDnQUKlfuzkOyTuMZStY0UpVJiJ4xuHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alht0ozq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+vONn4+D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alht0ozq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+vONn4+D"
Date: Fri, 5 Jul 2024 09:58:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720166316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCY7yZZwyN+ysp/NN8fZkJk3/f/V7n3voKumAItmdZU=;
	b=alht0ozqQ1rz2JFPzUcW/xBNC6D4RZmVEdFHMK8zn6/vtv3HZ7bl8K1sjBqeTqqC89ugJ5
	/hoVpALRgGeQxxAz+83h5HOQErzhm9aV92vyUYdMyk4pZhtT7apHkoJJ/2vveSODNuDKQx
	dkTfo1tjR3Q1SWm/puBNoVP8H7urXubtnA3K4OHQCBHjC5zro2HChpuyISAO91hP1muoY5
	ZSVHH/6KtcZ2FSMU/d/V5YGWJ4zbRaXUvxBgjt9w1Op8QlqRD/e1rZ/pI5ByNNCujpcmPh
	+vDLsjqXXLrETWvGDJ9osUGKUu9T5DEGCgjYuYPLiWIAfveLarCziHUy5ohT8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720166316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCY7yZZwyN+ysp/NN8fZkJk3/f/V7n3voKumAItmdZU=;
	b=+vONn4+DVjCKhPr85b0+eyR5WP4Zm+8dwZfLow4KcknrBok4DvlGX4kkmDH1uneS1ggk7r
	pVO9U5KCJ6C9qiBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/6] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <20240705075834._PXZSK5P@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
 <20240705075511.GX11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240705075511.GX11386@noisy.programming.kicks-ass.net>

On 2024-07-05 09:55:11 [+0200], Peter Zijlstra wrote:
> 
> 
> Thanks, I'll go queue it for perf/core once the robot gets back to me on
> the current pile.

Thank you.

Sebastian
