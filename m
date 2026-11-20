Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191971;
	b=tQcsFnzutOX0B/Rdg40zsnm2CleLlddRXbYtFgQBVvzBGsZrtLQjgZWF5Og8kz51/Pbg
	 EKoD2+/x7A2aKRc/H3yKatxTYjEzMyvxTfNGZJeNYmaLNNF8SyyyAkHcBFClnkowSCUqw
	 l89zc5iLeblrqd5xlZx/+aUu+mSDBhWnF3yjtkN4cbpIlara9naNesViO2Zq/H3DjQnWp
	 jTUT6DzPrKernCuTSoM5K1KXHuO7pqb929Q8N/4aRZU7ONLShyiTSqj5qZh4GFDm9c/Kz
	 20M4ruDbLRHDrRsO6+Fw1DHJgVPdMj6fX+Qd3xaiZsMyMGcOkQryqjpwDBczxZ8ThCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191971;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=tXWIJv4qjD/Y+wnUGevMsKa02kFWR43jw02le9o0IIs=;
	b=p5KKcsT+FLldH1lk6lKwtibFaBtkn+KSmkI9KPjreO6efDRD0X0q3Gobt5BjogvUofEZ
	 eZrZ4kO6QUyAEck0N6jPEnBDFsiVBtZcF/qsA7ajsSJ90gkU8qjASZuIKKuepEn3CitcF
	 jdVnHIwH6n30Vpaevke4CCqFMuqo52/lG8qTJU6JpUftw+j25OuS6N17G8fx98xrDTGKz
	 VHTKTowf83TDWg7VqhIuiJG2IDqqHzBBvzRrs4U2JMjbSZsiuLBTp9A5N+X1Z1mqdI1qU
	 6YlSRfRn0a2MolrlmEqr7+KK3jJYUd7XyY3wWTB2VgDtFutTfOL0JUDKUrZM9fSgqgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nbdx7sUK;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5D60A2605;
	Fri, 20 Nov 2026 16:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15D5D60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nbdx7sUK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tXWIJv4qjD/Y+wnUGevMsKa02kFWR43jw02le9o0IIs=; b=nbdx7sUKgZ5hLtAtoXeHQF2ANy
	loHhcPDT3U7hrV64xM6pKIOS9k+gnOV/xHTgteNB49cBObu21RX4gx3t1oEMNMdTPVuYpQEq/SOf0
	v7qQHffzCSrvv5F18lrfbijZhOWhQqqhpKeQEprSx/VYPz3DApAYre1cpF9souib4AFApHEcf7Q11
	qIlRjw8b6NpNdjEx0rVZUsfLmIlkSksGm/t5l0en81ZSmtJ8eptPrlbq43k+UeJi58Vp7YJJUn/u5
	kWs1lxoBP3JwZFwOVIbNuRpwXEkoa4pFnUxd4XEoF/p8ucc9S605pY71dtIEVAFBvjBOR3yLXzXC/
	Hy18jCAg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURR7-00000007rpm-1hcb;
	Fri, 20 Nov 2026 16:26:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E6F443008D6; Fri, 20 Nov 2026 17:26:04 +0100 (CET)
Date: Fri, 20 Nov 2026 17:26:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120160140.GR2668804@noisy.programming.kicks-ass.net>

On Fri, Nov 20, 2026 at 05:01:40PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 20, 2026 at 04:49:59PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-11-20 16:44:57 [+0100], Peter Zijlstra wrote:
> > > Some key ingredient is missing here. Is this some software event that is
> > > missing recursion checks?
> > If you navigate to
> > 	https://lore.kernel.org/all/29aa123c-36a2-460f-b76b-a8dfe1eb542f@huaweicloud.com/
> > and /PoC then you find what I used for testing.
> 
> Right, it had to be a tracepoint :/ Let me go puzzle.

Argh, yes. The recursion is per context {task,bh,irq,nmi} which isn't
sufficient for this case.

Also, sending signals on software events seems utterly insane. But I
don't support we can go limit that now :-(


