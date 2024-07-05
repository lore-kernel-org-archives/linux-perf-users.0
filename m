Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2333C7;
	Fri,  5 Jul 2024 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160207; cv=none; b=VNtXGecP48Q2YUEI6DF8ZrMHm0lvEsQItOrCh3baUmG6ZUlDATcbzlikTbdSBEzmKCZ6CFYKbaUG2KM/a/V83MRGTtGCXF3OKPPW4+34kUm/tunK0z44tU+Z259pIWj5qUAdoPmHr4U6VWsDwfjjEVq1XvECh6L2iHsPEch8u54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160207; c=relaxed/simple;
	bh=TA7sbhheusdNUAcIVC8U9Bq3HsNMIWB6nMpEUQqhE7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj9l0X+rIqAm5IidvA85CI3Lp7Ny1HB0f+bMtEWKd1OKC8fU8FuUjU7FwtvzzAMup+g/FlQvkBz8dEinRZtRrUyXul5n21aQOo5zivW5AlSrhkVaR1JHrpeLJXIwgwVWlxQAlLPdVDeyQPy+IKla+1i43goqJaUWOO1R9CQ/dIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFVSrLXI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tD2NYAYf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFVSrLXI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tD2NYAYf"
Date: Fri, 5 Jul 2024 08:16:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720160204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TA7sbhheusdNUAcIVC8U9Bq3HsNMIWB6nMpEUQqhE7s=;
	b=gFVSrLXIE9k7N83kWVUzJAQK4Gpj7nBm0lnuBLYzj4UiXT9rQX2I3PsMgbMdXv01HH/RAv
	PHrh33XUjZBvWZHPrxxrrzyWAgTkeaYEgnn5DhTu0FQcjt9O+fzm5W47SOIxsbmGix6cDT
	AuK1WKZ05QL+n1Bbvbe+AUHRqcRDv7iOPJAODN2UxIkIVfjrjJjG9VvkrE0O/A1oELOyKT
	O9t3+4fISj9aha/D2WBcHOkxN3oTa/MZoFuUfgMfBSUnQ9W5MWoXAm652tuXZlINuDp1AZ
	Yzh8xg3lfZIXP7pGj8Yast62FArPEC/nO8tcUemLjaOg8WpWz2z4MIgfbVQ3wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720160204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TA7sbhheusdNUAcIVC8U9Bq3HsNMIWB6nMpEUQqhE7s=;
	b=tD2NYAYfpC8/ZuoZLIX2ee/dzSah9/BvI5lTMSn/Tw1Ku+3+uo2HlBizJjZGW45MsOaIe/
	W6XgnESb7MfLutBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/6] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <20240705061642.1HDrwozC@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
 <Zob7zlMJy2Q_d_Fn@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zob7zlMJy2Q_d_Fn@x1>

On 2024-07-04 16:45:18 [-0300], Arnaldo Carvalho de Melo wrote:
> Were should I apply this patch? The v4 series was applied to
> linux-rt-devel/linux-6.10.y-rt IIRC

Revert the v4 series, apply this one. Wait a few hours and there should
be a new RT release with this done ;)

> - Arnaldo

Sebastian
