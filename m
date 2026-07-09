Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CA3D9688;
	Thu,  9 Jul 2026 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580756; cv=none; b=MqN6gG5oRq+5bab4hkTJ2150bNWh/Z8awOFh0IXDUiJfLE96r0FRzk2RvFYypahjpyToOXHKfW3K7nDiakC8Bu2mT4Y1rrSh/rxkvOCeXwmxeJ0KIgVWYiXpDbbIKIpBKqxBkMrkYeWWIcv7+k0+8/z/GGzl2RqqwKurefJZtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580756; c=relaxed/simple;
	bh=mrhNEzl7W/egHgJ8zsEgpuxSV8Byrc9uTeNV/MadR7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUJxMPc0LEZcFM/QTdRmB5kMpp34aO4/z5cBiNLnIw19DTJjfSF2zdX2jbFvuQoq/3gyQ9GiIBS00KjXYFysBAIVMZCyb9+L6pnhLxnwib0rkIy1b5JFDONzrFU/4Z2mpBC1zX0vOhxYtwGCrgI2E5EVdUSpu4Z4gzyL8gW3qAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjdvmg5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjdvmg5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D5F1F000E9;
	Thu,  9 Jul 2026 07:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580755;
	bh=06KFrRP09lmFPMgPDgvkEBmrQMQY2ieXFJFSdC7dk8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vjdvmg5z9QsEjrV6BIrKsTIsanKicsWF4JaDVlpOns4nHWpxDySc527SIgrMKt2EQ
	 MaUPAjqlIdXdpj73aFpSbdnlZ96qSnwP1Om8amN+VwRgNzIYE3zPQUxYJpcSgsatwS
	 UuP7jbSfF3ANoFZNOTjv86NFTJ7cgE+5FtmFS9ilDeBA7CIsJUrjg/+3b++KmG12RT
	 cV/0EbIJ9siZ6SxOXJniwPeA16gVqTvj/3kmNXKL9N8KRttSiKn6a3GYpoxm8HRlhm
	 tZs7HkLKMrI7TZNgQ2GRPpYAHIG2DSBoBsBMNx10fTsNka8h7DHBXYREss2pIGL8JA
	 gIdeDGh+QNyrA==
Date: Thu, 9 Jul 2026 00:05:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 14/21] perf annotate-arm64: Support load instruction
 tracking
Message-ID: <ak9IUXwJdB2Tdfjb@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-15-wutengda@huaweicloud.com>
 <20260701041445.091681F000E9@smtp.kernel.org>
 <93084002-9ae9-4f8f-a17d-9f580a2d3f2c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93084002-9ae9-4f8f-a17d-9f580a2d3f2c@huaweicloud.com>

On Wed, Jul 01, 2026 at 04:37:52PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/7/1 12:14, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [Medium] Missing invalidation of the destination register on type resolution failure during load instruction tracking.
> > - [Medium] The data type profiling logic ignores the second destination register of load pair (ldp) instructions, leading to stale state retention.
> > --
> > 
> > commit 579f01582f34ef50d993c4cb489f025353f8dbcc
> > Author: Tengda Wu <wutengda@huaweicloud.com>
> > 
> > perf annotate-arm64: Support load instruction tracking
> > 
> > This commit extends update_insn_state_arm64() to handle LDR instructions.
> > It tracks register state changes when data is loaded from memory to registers,
> > supporting signed offset, pre-index, and post-index addressing modes.
> > 
> >> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> >> index 48b1c94273eb6..b48545f35620c 100644
> >> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> >> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> > 
> > [ ... ]
> > 
> >> +static void update_load_insn_state(struct type_state *state,
> >> +				   struct disasm_line *dl,
> >> +				   struct annotated_op_loc *src,
> >> +				   struct annotated_op_loc *dst)
> >> +{
> >> +	struct type_state_reg *tsr;
> >> +	struct type_state_reg src_tsr;
> >> +	Dwarf_Die type_die;
> >> +	u32 insn_offset = dl->al.offset;
> >> +	int reg_offset;
> >> +	int sreg = src->reg1;
> >> +	int dreg = dst->reg1;
> > 
> > [Severity: Medium]
> > Does this ignore the second destination register for load pair (ldp)
> > instructions?

Right, I think it's better to check "ldr" for this function.  Maybe you
can add another function for "ldp" to invalidate both registers for now.

Thanks,
Namhyung

