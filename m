Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D53803C6;
	Thu, 12 Mar 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304937; cv=none; b=svPLqH2++7aomi2wSbjsnuMZI4JDBvGBL9eEF1fdAkpDbNwf+wNaO0L5fLTQ4S9a/kL5hGxzZcpr/xMkTw5A6121WRxHvl3mYcwepAyxJxJBf88ODFlVuFM8/UaD7r0rngvD9Bn0Lomm7aAu9JazaXkqFllCAIwaDHN6kGqhLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304937; c=relaxed/simple;
	bh=7Yl1h1d5S4mBr/vVQhSgY2mIV+t74mQCbavC8mnnTww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLalOhYFRwxvKd7ZDzdHvq7Z7LlU+kQ4erkVMKq0p0MjaJMl5oB9btz3fzvLfMOwILCgYncEBD74VKIrjzgSlTldptUOfEdxbLDti3tbgG9Jyt2ayRP2i+acikbekdq8xuIFVV6tKNP+oyfviUvwebr/nOp6Ct+AhANGVqyzRBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jzQv+jn8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jzQv+jn8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tz/07VYj1tmxkAlvtxiiXGWBC64dXdguGGCNPJikL/s=; b=jzQv+jn8PstRxxNmNbwRhn4npc
	om33skHpkvncngB3d6X786QO0YyesV0delGpgO/cYgc8i8E0jFAH605KQU57ik8/Tl0nqLEztJ/a0
	97gei82XyAQrmde0VAoorvNCwzY3O3+LIdgqwduKMKL1oVy5G2ZWo898ks0AaAijjb6VN1bby0Bgm
	WCT+QAMfCPWXwMOYzqIH/k79vFP4CyJFAAKPSG4srxpr0hSrRVCfAnATWXVqQi9zTVS/BBbtph9dY
	WS4jipl/BoBG6JQU1PSJlTqr6+OhRhELLWpScdYh9g8zct5F6KYgyQabAURSS3leO9JXDgoSg3Mh2
	ctvaTP5g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0bcN-00000000lXg-3bNs;
	Thu, 12 Mar 2026 08:42:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA943301150; Thu, 12 Mar 2026 09:42:06 +0100 (CET)
Date: Thu, 12 Mar 2026 09:42:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
Subject: Re: [RESEND Patch 1/2] perf/x86/intel: Only check GP counters for
 PEBS constraints validation
Message-ID: <20260312084206.GF606826@noisy.programming.kicks-ass.net>
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
 <c718111d-b836-4e03-b42c-5b86d409b6bc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c718111d-b836-4e03-b42c-5b86d409b6bc@linux.intel.com>

On Thu, Mar 12, 2026 at 04:28:45PM +0800, Mi, Dapeng wrote:
> Hi Peter,
> 
> Could you please review and merge this change? This change suppose to be
> low risky. Without this change, the dynamic constraints check would trigger
> false positive on DMR/NVL. Thanks.

Ah, so I have it in queue/perf/core, it didn't have no Fixes on so I
didn't think it urgent.
