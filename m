Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33E2DD608;
	Mon,  8 Dec 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765183834; cv=none; b=uyryhW0Soq0lnd8VopgAA69CNEkNnxk6BsG4b6w42hTrkQ9fLImUyFHdZ0W+vPPXyhIbo6vn06dZR7HJqWUGeCz/Wq5EMAxAUsYGkL9NX1ry/t7M1sv4TcmvBfZFytekqJ9MCkBLMrcDIZOo+ZJSKh2fLyCGd18gdwikAY6ddDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765183834; c=relaxed/simple;
	bh=gP9IZub1CXFwc8U+XH0DbSLtta3vvhcnMY1BjJzMxc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw1G8xYXP6ui75Z41swdPGXfFaAH0QvEDwYsBIUb7Hlq8uyAg5Q3w7OLba9o9dByB5YFy9YRmRoV1lfVae2Zz36xzM1ZmsLVbCyrWjol8e9NcXB+SCQDIaA9YQQRfALrawUElJ5hjOWeiVbrgjtLFcO/DVQ+4M805WfhMzbXSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YrQAqzWJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YrQAqzWJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=za4eJfAzfcigSmbD2HxrnUJ9fQifoichO9AYM9rALrE=; b=YrQAqzWJJSk5v/6k67tUAr1Zzf
	2xURg4yRkL+7ONvyuY3rMk1wk8aUbmQqxpWv3hlb2TXB93RAbZ6r7JN58014KqXCpxKml0//SxXTY
	RZhPOR0TC18m6Kc3QSHFozU/lz42BWWBCCvyvwT7iM+9gy4cp0lKbs4REIEpK1YSBu0x/kFWKyie1
	1ah9l/qnB9X69DYJJMGd7p3kCDjFAUG6VLw9GEVHLE8kNI1EU5mFPwmQbbpAEo/0viwLmYWNi7Gvh
	g2Gp2otsyXbPKenfke2hsomjpjH879yrbWCN5yg5jMGP2QTLvu9pJ9ZJ026YADLhWt6Uf9CJozrWP
	eGaeYs+Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSWwn-00000009YKT-2ETq;
	Mon, 08 Dec 2025 08:50:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 80E7B30301A; Mon, 08 Dec 2025 09:50:20 +0100 (CET)
Date: Mon, 8 Dec 2025 09:50:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v5 16/19] perf/x86: Activate back-to-back NMI detection
 for arch-PEBS induced NMIs
Message-ID: <20251208085020.GA3707891@noisy.programming.kicks-ass.net>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-17-dapeng1.mi@linux.intel.com>
 <20251205123940.GY2528459@noisy.programming.kicks-ass.net>
 <5e808ff0-0107-4085-a1ab-ea1cfed4e0ca@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e808ff0-0107-4085-a1ab-ea1cfed4e0ca@linux.intel.com>

On Mon, Dec 08, 2025 at 02:46:44PM +0800, Mi, Dapeng wrote:

> This change only take effects for arch-PEBS. For the legacy PEBS, the
> "handled" would still be added 1 unconditionally even the *_drain_pebs()
> helpers always return 0.
> 
>     /*
>      * PEBS overflow sets bit 62 in the global status register
>      */
>     if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long
> *)&status)) {
>         u64 pebs_enabled = cpuc->pebs_enabled;
> 
>         handled++;
>         x86_pmu_handle_guest_pebs(regs, &data);
>         static_call(x86_pmu_drain_pebs)(regs, &data);
> 

Oh gawd. Please don't do that. If you change the calling convention of
that function, please have it be used consistently.

