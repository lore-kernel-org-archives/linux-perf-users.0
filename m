Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420475;
	b=AZ1YtX4MOs3xX2BKGaySB/DPNlILmADmaDUmBikBi1oIeYQ6O2/6gtRy1fs5Ezv26645
	 B+2MOOrTYnAkr8qs5pl2NyFB5GDMFDonESZtNd8TsvSXoGW6kexHCRQOdhn9/3ujD9TkF
	 NjG0sb3xpVwju4nf2iNFyFhlRU0rebBh7HyrZugUXGeShW6CEcnm20Wq4RvjCAyFSsesp
	 gBSfO/FLzDHFYWaGphYYCQ2QjozOEcp2LxPSG4Gwhv8ZBQppmDPDZ1JPU9DnY2CitzQZZ
	 UBajbNU0BNQuQntmXlHdhl9+YlEr/wwj7fH1SbZZLvsRnq0pelcDDa+rVY719iIYwDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420475;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=+/KiLr1wIKGKGYDSudAYugppGPr4EtiHZsMpl0wxwyE=;
	b=K5QIV2d3cTET5myu0cqqml+CkOFBJhFw7hNosOeS0YSoqSRqxVzhaq6s1aR6whznSFpu
	 LInSS2cYj3dXHU9KgqM2vyPABeFnpv14bwEqOIj20G6RGo0HEWrKQjcsfYhcLOkFODZE8
	 PPY2f7UjxckKg65jmaJed9ADnpcXVTSnqXXmQijzi8OjtDuVgYXyEot3rTEveUo6pVrAt
	 gMTD2mpDL6IMxf68awFtTtMKdfyWhlWOt7+3akL7FX8T+DRiuxqTvAOuA0Z5cFNhAT+Jn
	 q+ZBIrhOb6eQZZ9Gq0aImivj4a5Yacq2l9zGUOP/1Kxp5bz/abR7GgFv+KYj9HFC76Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=l+eOP98p;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DHJX2ElB;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2B606A31A;
	Mon, 23 Nov 2026 07:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EA2B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=l+eOP98p;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=DHJX2ElB
Date: Mon, 23 Nov 2026 08:54:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795420472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/KiLr1wIKGKGYDSudAYugppGPr4EtiHZsMpl0wxwyE=;
	b=l+eOP98p6gGBiHldkCRAXI0H3Eim96W3QLnk1HVA3s3egYgeV4XrK3bdEEMCI+eF+NJ8Nv
	ktAwAthvJpvU2yV9BU+A26pTfDk1SIvkk54fF2jYwtudhTjsW3TXnvR8G4EypEzKavCKkJ
	uiSjdR1Ir7ZmjNqaFtfNS/8MIX/huzAS3e2R7Ba64U1Zd+ANvG73sI0Of680qWwyqeNdOM
	17Fo+DEusNb2/m34wcQrkEiPyqVHqWOkO6X/fnBHGYS0c6OT0wNYeFpGBtqpX6PNN0FzXN
	CrzuSglTHEqm+1lcxj9WJ37NHZhzg+h6UbTmtdWTqpp9QA6hzeIO8RqIZCRCfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795420472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/KiLr1wIKGKGYDSudAYugppGPr4EtiHZsMpl0wxwyE=;
	b=DHJX2ElBa6q6Vjhsw3hJLiGgXr/vsuQtGR/mXxuC/arSw1FCxE+Hz0TylbdQwjQFIs0ah+
	cKNqG+fKy7w+g/BA==
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
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261123075430.z5pZwrvc@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
 <20261120172831.5XwELZY5@linutronix.de>
 <90ab8953-a2e8-432f-a338-ce216136e22d@huaweicloud.com>
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
In-Reply-To: <90ab8953-a2e8-432f-a338-ce216136e22d@huaweicloud.com>

On 2026-11-23 09:17:28 [+0800], Tengda Wu wrote:
> 
> Sorry for the late reply. No AI involved, this was produced by running
> syzkaller. I've turned it into C code.

Thank you for clarifying.

> Tengda

Sebastian
