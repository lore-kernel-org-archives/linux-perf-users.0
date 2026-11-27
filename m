Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772141;
	b=VpEX72xb8qWELCOKcOhLBgWSU7sPcA19ONcnElrsmBAnWJNlPhQrTgnsD+0Ah4Pfam9Q
	 5yF1ggAO81i1cYrbsSabEJb3IaxJRZpvDo+LS9z/OAvMie1E9ZSJuNKEw7Uvf3yFg/tAw
	 5ErsDRKtiN5Itb+fPNnbRZ9ppwSFla/bAGPLlc2LvG2pfcO0/qBmvxyqJ7F3YtngSsYR2
	 mKAIDbCBUKcb0U1gs84M22b35678WdukjRwcGk95NbDilznPn/tYf27vqQlMj1cbjDF1b
	 PJAYrDF9CrDRbPaRRnxyRWTCaqzvWvUKBY06NOLnqDIDrZSMGfdM3aJDmPx5Gnefldg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772141;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UvLzrTmk+6Nauu67F3mOfFQL7HsGllDtYs6mRj6kuZI=;
	b=4v8KuJhFxEviWZuyytujcX9rOZD+lG00bAX9AaPVyBuf0fjjsh5r16Ss4926AI1IFFF2
	 +YIfQsp3dqDwfvWOcFCjpaHddUWqxP2XClgc3h5X4yp2pA0rsKkylYFqmJi6W4Hxc/xVK
	 JgRQom7WVuPWW7k65NSdoJbON5jk+NgLh1JUTC4FB0wd+4EcyTOHLAPG0sP1t1llZACA0
	 02olJIUQVVB8rU71JAYvxPAjpYbgE0uslZ38CD5wR327YhLf4uVXWpc4mhepIwTAEGSs2
	 4+9UlzJtw4KmYaHijmJ79rfK/MbjhDnUHBZN21vSyohMRIlAnRJAFjCHgJJowJHTkfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PmJGNSyU;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C59606A326;
	Fri, 27 Nov 2026 09:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C59606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PmJGNSyU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UvLzrTmk+6Nauu67F3mOfFQL7HsGllDtYs6mRj6kuZI=; b=PmJGNSyU7+PyzS1E3hUaY4GIlU
	gYvfgChUAkTduIe6rEB6tRw47J7s/iDwHjMJP0N542MYeAT27uI/+70xyUJwWONzuiTw3KORRw4dZ
	A2m1/a+ocZrIp/m11kf5ZLASjDtgQS3oq8zYcrYkSr2V3mk5K2uJHdgbjvUPkXuZS1caIVqg6r9Ir
	Q9Wp6HK5iwMypucx8SqojYavVNv1hBaCMFnsXdIte8toRo3nplRCfBbxBpsOL40PMe76V5S4F1W1f
	CIeWw5bAEaprCsBGj2a+zyIjur2Q1XCC/wIlgvowhX+YPe4rF/q0YacgDl14sA4nVLTCfNNRSARNs
	bXrtc6jw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsMi-00000007WVl-1QpT;
	Fri, 27 Nov 2026 09:35:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 122BE30027B; Fri, 27 Nov 2026 10:35:35 +0100 (CET)
Date: Fri, 27 Nov 2026 10:35:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Jiwoo Kim <arpe1618@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel: Don't allow extended register sampling
 for BTS events
Message-ID: <20261127093535.GO49833@noisy.programming.kicks-ass.net>
References: <20261114062249.1301-1-arpe1618@gmail.com>
 <7f5430f2-4220-4d96-b4f7-af667fb14dde@linux.intel.com>
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
In-Reply-To: <7f5430f2-4220-4d96-b4f7-af667fb14dde@linux.intel.com>

On Fri, Nov 27, 2026 at 02:12:42PM +0800, Mi, Dapeng wrote:
> Hi Peter,
> 
> Could you please review this patch? If it can be merged in the 7.4 release
> cycle, then no backport is needed. Thanks.

Done.
