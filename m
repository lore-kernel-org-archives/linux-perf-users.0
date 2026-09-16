Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97A3C7DEB;
	Wed, 16 Sep 2026 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551168; cv=none; b=bzLXr/2yC55O31o3Ex9g3hHY9/qjHGjMoLWoHv6G5C+3GWPbTbapW+Ad7J5+r7Qg83F46LlUcfXlhWHn6dk0Xm7jpqVNYCkn71SJPA6+3vsL0qa7WbZcHPbh+AdQEBqZLlCQzZm9NyKM0JmBW0zo4zfO89+W/EXJu6VeL0SF+j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551168; c=relaxed/simple;
	bh=b3NCirUEtJnLQDmZkIzshRIX7pBLeLpmt2X1ANZ0eZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbDcTmTntNLBHeo2QjTWjZECXub2500RbqNx0d3au9fjpYmGw2V4VAkGGCOQ0Pw0+LpdMEI6r5qaF5F89PKz9skaeXnWiTLQZnDJsAthq1PKGTOkjvNfOSP+Oaftv1+0yTpKhvVvVNtmgXfo0p9B55AOdXT3t3Bzkkj0nE1/h34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JlaU7BJL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JlaU7BJL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ciewj2gOiLgMag1VFzW5WcAVHylGN6jD6YHgsVPZK+s=; b=JlaU7BJLpWBCqSYOX9eYvvADjg
	5/a8Vt8ojffo44p/81S+2OghVYF8OfZ8xrMXQPSht5iHnQqoYLSgH3aG2YP8MrAHhWTVjniOvcGli
	DAoxYAJbrDEvDj8kB3jwGaedneGpLPVg+ktvOTUxpGoEXLPRnNk2/1JOfkkMSsNMSMREkaqqczq9i
	PAV2Bcz1m7w5GWVjxLiKqPpTHdOuWUVbL6A1R1CkyyjLPx7/CNI1G41NdFLO596Jv7ckV3/Xu0h3j
	szTN5DTc5JjjHvTeyKVQCUwPGXWn8GJyWg1xBKExPTJNh3vCh0AhljDvt8WvTXt/5MPB1PRuNircL
	WGM+CIMA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6m03-00000007h3H-1YH4;
	Wed, 16 Sep 2026 09:32:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D06FC3012C6; Wed, 16 Sep 2026 11:32:17 +0200 (CEST)
Date: Wed, 16 Sep 2026 11:32:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, tglx@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, seanjc@google.com,
	kai.huang@intel.com, radu@rendec.net, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd: Move NMI latency window to last-resort
 suppression
Message-ID: <20260916093217.GH4121339@noisy.programming.kicks-ass.net>
References: <20260916065723.1976131-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916065723.1976131-1-guanghuifeng@linux.alibaba.com>

On Wed, Sep 16, 2026 at 02:57:23PM +0800, Guanghui Feng wrote:
> The upstream amd_pmu_adjust_nmi_window() mitigation claims every NMI
> that arrives within a 100ms window opened after a PMC overflow. When no
> counter overflowed, the handler still returns NMI_HANDLED, which makes
> the NMI dispatch path take its "handled" exit. Everything that comes
> after the perf handler is then skipped: the NMI reason port, which may
> hold a latched SERR#/IOCHK# error, and all NMI_UNKNOWN handlers, such
> as hpwdt. As a result unrelated NMIs are silently dropped for the whole
> duration of the window.
> 
> Stop claiming NMIs from within the perf handler. When no counter
> overflowed there is nothing to claim, so always report NMI_DONE and let
> the remaining NMI sources be probed first. Defer the window check to the
> very end of the dispatch path, where it is used only as a last resort.
> 
> Introduce perf_nmi_window_active(), which reports whether the latency
> window opened by the last PMC overflow on this CPU is still open. It is
> called from unknown_nmi_error() only after all NMI_LOCAL handlers, the
> reason port and all NMI_UNKNOWN handlers failed to identify the NMI.
> Only then is the bogus "unknown NMI" report suppressed. A __weak
> fallback in arch/x86/kernel/nmi.c always returns false, so non-AMD
> platforms are unaffected.
> 
> nmi_stats.unknown is still incremented before the suppression, so the
> dropped NMIs remain observable through debugfs.

So the point was that AMD hardware was generating these 'spurious' PMIs
quite frequently, and hitting the reason port at any frequency from
multiple CPUs is a massive performance problem.

How are you not re-introducing that?
