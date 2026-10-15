Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61648423C;
	Thu, 15 Oct 2026 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105898; cv=none; b=YE/+/FD/Kj/NiAagXm8u/YAI3BeFc7T2cK8vKc6lKYEi+5GFi/QAFYgEneRPefSFKs3l3u6+ozmTz1pz45Wf8YgepBFes/C30YQBoVdmScqrq/79sNpVoaJMz7pexIJI+wgjbReGNrpaGAmEKLjF05sYnOWJ+AH1moVfxJWvWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105898; c=relaxed/simple;
	bh=NAIo/2YcyZFL5NtiS3TqpOIIaOn5HOhc6x/wvmXtl1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANHRRuXRYpO1FTDwSNMuJqR6n3mX6keet7NIKNfeGUxvpbAvRyntgrc9F0eMcz4JLnrnrPfXTIhBhEP0D2MVs+2zHESadHZ1NaZdeksssOFElOWixGhoWkKPhGGXdKxdpx6hw/k5mfcC0GmrNKrx1zyZLHIZmYOPj7WniNmtrZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8yU+xdx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8yU+xdx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED61D1F000C4;
	Thu, 15 Oct 2026 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792105895;
	bh=RxoqlIYKMUuTmPwGfKdmwoZV0q0YLjuY5kJYKg5ZpZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J8yU+xdxaMLO5YuemA2Qh2SEXJcsKedetvTpmDN4d8TnIOeQQKqIO7+pytIFhyB1/
	 EvpEpmhH7X3md8rn/8EhEacX3ghIdv21dIefE2VVUzcbNkcOQaIjfMX7SdY1Uhq9mB
	 BxDLhUSC69f1/mUBYgvxxPfxicqRin/T0OTHokET9JindAdmckMgqkfo/ZA2sq7B5w
	 iO+mCtnoV502t8hggBGtS7d+US5VxnKZ5JEqUZdvNJkDechwBmHUIqhldcyAihM8JG
	 pODmSwmkwoVf+ABmxWo2OxjQ2E5KxNGprqCpQh04fv2Q/GVcEmr75wkkOAvER7Yj44
	 NLKnq3UolgpJg==
Date: Thu, 15 Oct 2026 16:11:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 00/15] perf annotate arm64: Support instruction
 tracking for data type profiling
Message-ID: <atFdpZG-b2JPS1St@google.com>
References: <cover.1791629326.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1791629326.git.wutengda@huaweicloud.com>

Hello,

On Tue, Oct 13, 2026 at 01:27:58PM +0000, Tengda Wu wrote:
> This series adds arm64 support to perf's data type profiling by
> implementing instruction tracking for the arm64 architecture.
> 
> Patches 01-11 of v6 have already been merged. This version only
> contains the remaining instruction tracking part, renumbered from 01.
> 
> The main changes since v6 include:
> v6: https://lore.kernel.org/all/cover.1789521520.git.wutengda@huaweicloud.com/
> 
>   * Rebase on the latest tree, since flex array support patches have been
>     merged recently.
>   * Invalidate lifetime in propagate_load_reg_state(). (Sashiko)
>   * Remove the has_reg_type() guard in update_store_insn_state() to avoid
>     skipping the stack state invalidation logic. (Sashiko)
>   * Fix the issue where TSR_KIND_PERCPU_BASE fails to retry as expected. (Sashiko)
> 
> Patch organization
> ==================
> 
>   Patches 1-3:   Shared infrastructure. Extract invalidate_reg_state() as
>                  a common helper, add the arch_get_reg_offset() helper for
>                  computing operand base offsets, and wire up the arm64
>                  entry points (arch_supports_insn_tracking(),
>                  init_type_state(), and update_insn_state_arm64()).
> 
>   Patches 4-6:   Core instruction tracking for arm64: function return
>                  types after calls, load instructions (ldr/ldp and their
>                  addressing modes), and store instructions (str/stp).
> 
>   Patches 7-9:   Shared data structure improvements and an x86 fix.
>                  Expand type_state_reg.imm_value to u64 so 64-bit
>                  addresses can be tracked, preserve imm_value for stack
>                  variables, and delete stale stack state on store of an
>                  untracked register on x86.
> 
>   Patches 10-15: Remaining arm64 patterns: stack variable tracking,
>                  'mov' (register and immediate forms), 'add' member
>                  address calculation, 'adrp' global variable tracking,
>                  per-cpu variable access, and 'mrs sp_el0' to resolve the
>                  'current' pointer.
> 
> Each patch's type profiling results are as follows:
> 
> Patch | Feature                    | no_sym | no_var | no_typeinfo | bad_offset | insn_track | ok(%)
> ------+----------------------------+--------+--------+-------------+------------+------------+------
> base  | baseline                   | 6      | 493    | -           | -          | -          | 56.2%
> 0002  | enable insn tracking       | 6      | 42     | 437         | 2          | 12         | 57.2%
> 0005  | support 'load' insn        | 6      | 42     | 398         | 1          | 52         | 60.7%
> 0006  | support 'store' insn       | 6      | 42     | 398         | 1          | 52         | 60.7%
> 0010  | support stack variable     | 6      | 42     | 391         | 1          | 59         | 61.3%
> 0011  | support 'mov' insn         | 6      | 42     | 372         | 3          | 76         | 62.8%
> 0012  | support 'add' insn         | 6      | 42     | 318         | 7          | 126        | 67.2%
> 0013  | support 'adrp' insn        | 6      | 42     | 238         | 8          | 205        | 74.2%
> 0014  | support per-cpu variable   | 6      | 42     | 233         | 8          | 210        | 74.6%
> 0015  | support 'mrs' insn         | 6      | 42     | 230         | 8          | 213        | 74.9%
> 
> Testing
> =======
> 
> Tested on arm64 (all passed):
> 
>   # perf test -v "perf data type profiling tests"
>   81: perf data type profiling tests                                                                  : Ok
> 
>   === Test Summary ===
>   Passed main tests : 1
>   Passed subtests   : 0
>   Skipped tests     : 0
>   Failed tests      : 0
> 
> Tested on x86. The profiling results show no change before/after applying
> this patch series:
> 
>   before : total 880, ok 711 (80.8%), bad 169 (19.2%)
>   after  : total 880, ok 711 (80.8%), bad 169 (19.2%)
> 
> Changelog
> =========
> v6 -> v7:
>   - v6: https://lore.kernel.org/all/cover.1789521520.git.wutengda@huaweicloud.com/
>   - Invalidate lifetime in propagate_load_reg_state().
>   - Remove the has_reg_type() guard in update_store_insn_state().
>   - Fix the issue where TSR_KIND_PERCPU_BASE fails to retry as expected.
> 
> Please let me know if you have any feedback.

Thanks a lot for your work!  Assuming you'll fix the issues from Sashiko
in the next version, you can add my:

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
 

> Tengda Wu (15):
>   perf annotate-data: Extract invalidate_reg_state() as a common helper
>   perf annotate-arm64: Enable instruction tracking support
>   perf annotate-data: Add arch_get_reg_offset helper
>   perf annotate-arm64: Track return type after call instructions
>   perf annotate-arm64: Support load instruction tracking
>   perf annotate-arm64: Support store instruction tracking
>   perf annotate-data: Expand type_state_reg imm_value to u64
>   perf annotate-data: Track imm_value for stack variables
>   perf annotate-x86: Delete stale stack state on store of untracked
>     register
>   perf annotate-arm64: Support stack variable tracking
>   perf annotate-arm64: Support 'mov' instruction tracking
>   perf annotate-arm64: Support 'add' instruction tracking
>   perf annotate-arm64: Support 'adrp' instruction to track global
>     variables
>   perf annotate-arm64: Support per-cpu variable access tracking
>   perf annotate-arm64: Support 'mrs' instruction to track 'current'
>     pointer
> 
>  .../perf/util/annotate-arch/annotate-arm64.c  | 750 ++++++++++++++++++
>  tools/perf/util/annotate-arch/annotate-x86.c  |  38 +-
>  tools/perf/util/annotate-data.c               | 209 ++++-
>  tools/perf/util/annotate-data.h               |  14 +-
>  4 files changed, 963 insertions(+), 48 deletions(-)
> 
> 
> base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
> -- 
> 2.34.1
> 
