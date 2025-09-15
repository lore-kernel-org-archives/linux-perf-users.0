Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E0A2FC003
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932512; cv=none; b=O1np4zQmz25LMS58oROGhJerIWVCalhs9RUc7atV7Sp81iv8qPUZHhZ8Jq0UZty5oWj5NGfmnFpzeTMndLVhyHKEww/E25+OVgGGtCpVp9LD8t2qXJTjipZA/aD68Z4Ls7cCUiPjD00INtlk+BPwEE0STzD4ByebI73GA0xaMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932512; c=relaxed/simple;
	bh=GnPRJr8bD302g1idVWf4TFYMS+bTOr0gFLqD/VElnlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwwa3FclbsV18nT5KZBmg2wasWARbJ0dNqXMpAqs0wijRnCzwYLtKonvSJPzzQRwt5adNNPCkD/00JgqEd6CBRpt9i20SOhGFo9NCQ/S46HBrYA+x3lo/cri/poTe8N1Rl49G/qPoNGlEAZ14NQhHJI+F0lCtBqt5nQLWn5LL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uA5pgx7j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uA5pgx7j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UgxAjeqJy1+oB7bCgdA2gcYmn4AIRVZ9GkWi6fbS6G8=; b=uA5pgx7jxIHyBFy30qLsN861Et
	FLj7Z8T9JS/hr3Orow3hv8aF9jbHkQ/qBqwU4mAMJbnYqRKuzm75faBzrQwVNH0O62LPllDoEWbon
	JG9zJTuiHgyRX0Gg9CBlPJxMH5KKf4K7OKRY4BGUc457bFljzQsz/pUR7hhkgR3PzSfoPAvAWgCST
	tU/cVVOIvEg5nsRN7yTN9pWLFekUABB2W5V5gPaTkVMhwD1zvA1chvKQS4HJbpv1ZCZWqW0+w5ztQ
	ypMBjcpJD5ldPZBPsnDoF5px/4JLHx1EKPmrhhQ8IlUj9yFTzn8WRxI7QNMH0QAk+puVGlFF7Z3U+
	HQ373aNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy6Y7-0000000D6F7-0mUn;
	Mon, 15 Sep 2025 10:35:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A7674302E03; Mon, 15 Sep 2025 12:35:06 +0200 (CEST)
Date: Mon, 15 Sep 2025 12:35:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will@kernel.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org,
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, kees@kernel.org, masahiroy@kernel.org,
	aliceryhl@google.com, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, xur@google.com,
	ruanjinjie@huawei.com, gshan@redhat.com, maz@kernel.org,
	suzuki.poulose@arm.com, zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com, dianders@chromium.org,
	gautam@linux.ibm.com, arnd@arndb.de, zhao.xichao@vivo.com,
	rppt@kernel.org, lihuafei1@huawei.com, coxu@redhat.com,
	jpoimboe@kernel.org, yaozhenguo1@gmail.com,
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org,
	wangjinchao600@gmail.com, yury.norov@gmail.com,
	thorsten.blum@linux.dev, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
Message-ID: <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
 <aMfpwYPX6_i6ROOY@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMfpwYPX6_i6ROOY@willie-the-truck>

On Mon, Sep 15, 2025 at 11:26:09AM +0100, Will Deacon wrote:

>   | If all CPUs are hard locked up at the same time the buddy system
>   | can't detect it.
> 
> Ok, so why is that limitation acceptable? It looks to me like you're
> removing useful functionality.

Yeah, this. I've run into this case waaay too many times to think it
reasonable to remove the perf/NMI based lockup detector.

