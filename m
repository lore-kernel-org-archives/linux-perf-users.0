Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093629;
	b=Iz221sl8NuzHKkGPhfsYCZxwpmfecln4++ruYW5NF1FP7e+YEukZzO+8R+NQ9Xkle8kk
	 Xcx8OdEKPTt5nHN7cjsCjnktLaumNEgdORjO4pykBTGpRZOUyFGi9iuC+Zwn4rX/Xa2pv
	 SFvCs7Ks1DCQISJz5+3+MuL0d7dbE+q+k+V9YMaxt3QoDvXNYs5/bFVtW2/+PLGRUTrP+
	 VPCgSGYX9gnqO5PcpFpcLo46IfXhwEjtkPozOYXHTHerI7L0m+etMjDxQt/Dj6WX/5RXW
	 R6A2e4yzgt8wWMVbl6lVolb7FyvLHbS9T4OrOGnT8+btAyFPD7EwgW8L7WpzKTZDz3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093629;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=gEaTen27ph55nBTeO68F2SWgSFJkMvItpOwkdYmik9w=;
	b=aZ0YzsxBAGLbUUuMg2WkYiWAJ/pnphSZqWTNyRxQq96pd/ULkn42sfUKL3qY2L9rFzR2
	 yp++eJ/S2hJx3rtHYfY75IghU4m5o6a6nlT8txm8nFyCjCFtKUUdmU0xJbyfL1lhfz5Tl
	 OUfMWbpkfwf3E1X9+Vwr6S5OnNy2Kw2ggJdD/Q8A2urwxT1H59fNFD3SzTWXTPN1Hn5XH
	 7+GRRiJvnpgPh70fn6wj1Wq4eSezNx3fXgwRCzx1npg7MxGmfiUSlqaEUUVPUrhnLVDpU
	 MOP5S658x8Fq14EEGGtdDQOSQXcZM9DoloDexb0/x46TM1zYVcqNtmWB74tPYmTq44w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MubOrsr6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=H1lmNkTP;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7487606A324;
	Thu, 19 Nov 2026 13:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7487606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=MubOrsr6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=H1lmNkTP
Date: Thu, 19 Nov 2026 14:07:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795093626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gEaTen27ph55nBTeO68F2SWgSFJkMvItpOwkdYmik9w=;
	b=MubOrsr6ULHvBTDL73wqsbymWvymwp4iF458yUK/D8EINQArUJ7YolMrtuaLMfSMkDel1S
	ry9uV/1svF9tBFXtAvmaGdwU8HOQnYvQ+nHFLTZ/UF1bjbTXZ/q2ZJM8gVXbXvJriNnwZM
	44UZ1AyLKlthHKTO6Ac71KXNyglQWCSqDtouJDpRz6bOtH/uZBcaIA+3L1B47ng8gZ3y6s
	pXWl1EoAxHu3Sh3lNojgigmKP2E1wxP9UlBUgl2Dn36GL1fClzn8KDO1ycVOZfgdLpnKq4
	Czd3DDQXsOaWNLnfcAK0771ccU2IqlaTocKMcY313/2LaTedHofpMNxBGxz83A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795093626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gEaTen27ph55nBTeO68F2SWgSFJkMvItpOwkdYmik9w=;
	b=H1lmNkTPqFTDA3QzqZtmZ8PGFQUI+leEEty9xlYitIWg5hmOVZsSuNHVWpWfm+sk9H+EJL
	93vWq2Egv/RjpbAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Message-ID: <20261119130704.A5iZtay-@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261119121143.pJrJE7qs@linutronix.de>
 <cc76ea5a-545a-4560-a039-ceed1de7ff3e@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc76ea5a-545a-4560-a039-ceed1de7ff3e@huaweicloud.com>

On 2026-11-19 20:17:20 [+0800], Tengda Wu wrote:
> There is a test case, see this:
> https://lore.kernel.org/all/d1b24bbf-9111-4766-87c8-ff97adcac727@huaweicloud.com/

Now I remember. Would it make sense to include it to
	tools/testing/selftests/perf_events/sigtrap_threads.c

?

> Thanks,
> Tengda

Sebastian
