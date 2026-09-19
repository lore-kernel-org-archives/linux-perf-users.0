Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22E2C15A0;
	Sat, 19 Sep 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789839711; cv=none; b=Ts81Bbt6KhzCc+4qY9gVxAQl8EpACbB1xldFZrdOJQMyIkZ5Xywu6l/6+4MML9/C50tHTf/P3VJNL/GiemU5pZhhCRDEFcFQfAp9pHUyJCiHTwIVxm0vvHrOmExijF4h/h1wViKrdOvqKvOX5UYoisD/A4+mzlWfiCi8rXvtFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789839711; c=relaxed/simple;
	bh=/5CQfcQ/zVHloFdkLHFmPmEKp+spsSfOo7qRntDD58k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vti4yVZZhU5R6e7twOp6rpZ3yaIHV/d5DP4nHvCy3wpk3/5EMnozpRfSCiZ9FCucS8zyg1zaetO659lXESbmUfb/jJqAU8xsG/03N550Bx8ksc1U1n1F30K05LSBZhy230yRvLOn4UcATPn+EOKM4T5Se+sPgG75ZhGX6h/ydPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ1oWJLG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ1oWJLG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA30A1F000FF;
	Sat, 19 Sep 2026 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789839710;
	bh=rt1ngzsEC91Xl99ToiwedFB2NPixEdDOoeHFAj65WUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RJ1oWJLGL9wJeCPZnT6D8HEqDlzh/0ogLYDRqv3NsTE9KDD7ljYwThrefrM3nywZ6
	 p42hh8Qw9Bdo55j8VlBgsgde3i5jXUtokv8+gHNzurkqTdIL+ji/jc9D6b1rXBBnhf
	 8DyJanEY46793Q3rHo4eCTSOUWqfTDNdPJFvLOP1TGnEtqyM/la2KM9wH7mmbSMeyj
	 9EhQyxWO0J3/eLwGz5iURUNoTBWe453QIUtIoPRRnDSDDReggJsE4xwvgD9SzmeksD
	 txNVisUt/e8FTfUk73+JiOscXLzzNVCVEAw6LivAywEN0w+AJ6tYkXi6QWG08jN3Hm
	 IZ6Dt+s9wbaww==
Date: Sat, 19 Sep 2026 10:41:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Melo <arnaldo.melo@gmail.com>
Cc: Tengda Wu <wutengda@huaweicloud.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, james.clark@linaro.org,
	xueshuai@linux.alibaba.com, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 00/26] perf arm64: Support data type profiling
Message-ID: <aq7JXGyhWM5M6ubi@z2>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <aq41dlDILyJlw-77@z2>
 <EC6E525E-387A-493A-B720-80E6FB38B05B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EC6E525E-387A-493A-B720-80E6FB38B05B@gmail.com>

On Sat, Sep 19, 2026 at 08:22:01AM -0300, Arnaldo Melo wrote:
> 
> 
> On September 19, 2026 4:10:46 AM GMT-03:00, Namhyung Kim <namhyung@kernel.org> wrote:
> >Hello,
> >
> >On Wed, Sep 16, 2026 at 01:29:14AM +0000, Tengda Wu wrote:
> >> This patch series implements data type profiling support for arm64,
> >> enabling 'perf annotate --data-type' to resolve memory locations and
> >> variable types on arm64 platforms.
> >> 
> >> The main changes since v5 include:
> >> v5: https://lore.kernel.org/all/cover.1788872630.git.wutengda@huaweicloud.com/
> >> 
> >> * __get_dwarf_regnum_arm64 optimization: compute directly based on character
> >>   judgment, avoiding strtol calls. (Ian Rogers)
> >> 
> >> * extract_op_location_arm64 issue fix: support parsing instructions such as
> >>   'cmp x0, x1, lsl #3'.
> >> 
> >> * Instruction tracking part, fixing issues pointed out by Sashiko, including:
> >>   - adding TSR_KIND_POINTER handling for ldr.
> >>   - premature returns in add and ldr causing percpu handling to be skipped.
> >>   - adding a reg != -1 check for stack type propagation, etc.
> >> 
> >> Patch organization
> >> ==================
> >> 
> >> The series is organized as follows:
> >> 
> >> 1. Fix disassembly mismatches (Patches 01-02)
> >>    Current perf annotate supports three disassembly backends: llvm,
> >>    capstone, and objdump. On arm64, inconsistencies between the output
> >>    of these backends (specifically llvm/capstone vs. objdump) often
> >>    prevent the tracker from correctly identifying registers and offsets.
> >>    These patches resolve these mismatches, ensuring consistent instruction
> >>    parsing across all supported backends.
> >> 
> >> 2. Infrastructure for arm64 operand parsing (Patches 03-09)
> >>    These patches establish the necessary infrastructure for arm64-specific
> >>    operand handling. This includes implementing new callbacks and data
> >>    structures to manage arm64's unique addressing modes and register sets.
> >>    This foundation is essential for the subsequent type-tracking logic.
> >> 
> >> 3. ARM SPE event handling (Patches 10-11)
> >>    Patch 10 automatically deduplicates overlapping ARM SPE events (e.g.,
> >>    l1d-miss, tlb-access) in 'perf annotate' by retaining only the
> >>    "instructions" event when data type profiling is enabled. Patch 11
> >>    defaults  the synthesized event period to 1 for ARM SPE to fix zero
> >>    'Percent' values in annotate output.
> >
> >Thanks for working on this!
> >
> >I think it's ready to merge up to this point. 
> 
> You mean patches 1-11? 

Yes.

Thanks,
Namhyung

