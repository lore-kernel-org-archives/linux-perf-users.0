Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE91DED77;
	Wed, 16 Apr 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818816; cv=none; b=Hmqlc5GUQLFsmTWUQhAIXWU4yRrTg+ElQv3YMVCmkdy8RvwSEnVaQZvAztvQuO+DtLWaDEdAKy+f8VCLtapeiATCSEHczrgE+sxMfyISmAaSK/mOYUkt/srKKoiie4kHAEV6RIFMxpUPh+UKdsjP5qlN3ZTDE8py5Jo8LcXsXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818816; c=relaxed/simple;
	bh=VfjgEWFmV6CLXB2K2kzdThxJHGiOePGkoKvS0rVg7Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmaBJD7Y0p1MFqdZzpRA285BFUD05wJQfbhFEN9LCFTnh+7HC27wlkevEpr1CzX2mrX53eFusdoPyB4/GdqF71AIlsSj6rHM5uVkuEB80lslYZ1+yLSgm6IseMAde0k87KtIzhebhvFcLSOOirwg/8mTYR8njcqY70NIgshgQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hM/T2hte; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hM/T2hte"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=o5Hon3H0PxmfTZFD7Em3kHBT5tAZzPwrDBlRxLSdjEI=; b=hM/T2htekA8TlucdcxatxFAesT
	sPHSgRzwSkSLRuRzXdMsVJbfX1BLdFa1P9hpylWHerEH3jQYZXwpn1VgTglxKXCDMuTBjvF6oGcs2
	MssmwdxY3dV7OQsBvgZwL+oDD2+zUtnk69Z+LpOhi3wJb/d83dTgQXODnfUHNZqL0eNUgkiECus55
	ia9E3Q4cQVKxbhfJ0aeiSZ3ByzAGN22EzIZnOZhaL/Wbl8ziRocpuVuD4eot+qSp+/cm5HoQkqeAZ
	7qvbZD8HStEyn8w0h5miaNBC4mbZYR2ojwEz8MhEmrhsp5z3p0kG5LwHVFKZQ2gA7yoo4b9pIRpkT
	9XftLpjQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u554q-0000000A7zA-2Rae;
	Wed, 16 Apr 2025 15:53:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BF2E93003C4; Wed, 16 Apr 2025 17:53:27 +0200 (CEST)
Date: Wed, 16 Apr 2025 17:53:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 16/22] perf/core: Support to capture higher width
 vector registers
Message-ID: <20250416155327.GD17910@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-17-dapeng1.mi@linux.intel.com>
 <20250415143626.GF4031@noisy.programming.kicks-ass.net>
 <26799b7e-c3a6-4de2-afd1-7bda0639fa37@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26799b7e-c3a6-4de2-afd1-7bda0639fa37@linux.intel.com>

On Wed, Apr 16, 2025 at 02:42:12PM +0800, Mi, Dapeng wrote:

> Just think twice, using bitmap to represent these extended registers indeed
> wastes bits and is hard to extend, there could be much much more vector
> registers if considering AMX.

*Groan* so AMX should never have been register state :-(


> Considering different arch/HW may support different number vector register,
> like platform A supports 8 XMM registers and 8 YMM registers, but platform
> B only supports 16 XMM registers, a better way to represent these vector
> registers may add two fields, one is a bitmap which represents which kinds
> of vector registers needs to be captures. The other field could be a u16
> array which represents the corresponding register length of each kind of
> vector register. It may look like this.
> 
> #define    PERF_SAMPLE_EXT_REGS_XMM    BIT(0)
> #define    PERF_SAMPLE_EXT_REGS_YMM    BIT(1)
> #define    PERF_SAMPLE_EXT_REGS_ZMM    BIT(2)

>     __u32    sample_regs_intr_ext;
>     __u16    sample_regs_intr_ext_len[4];
>     __u32    sample_regs_user_ext;
>     __u16    sample_regs_user_ext_len[4];
> 
> 
> Peter, how do you think this? Thanks.

I'm not entirely sure I understand.

How about something like:

	__u16 sample_simd_reg_words;
	__u64 sample_simd_reg_intr;
	__u64 sample_simd_reg_user;

Then the simd_reg_words tell us how many (quad) words per register (8 for
512) and simd_reg_{intr,user} are a simple bitmap, one bit per actual
simd reg.

So then all of XMM would be:

  words = 2;
  intr = user = 0xFFFF;

(16 regs, 128 wide)

Whereas ZMM would be:

  words = 8
  intr = user = 0xFFFFFFFF;

(32 regs, 512 wide)


Would this be sufficient? Possibly we can split the words thing into two
__u8, but does it make sense to ask for different vector width for
intr and user ?
