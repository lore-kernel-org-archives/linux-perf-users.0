Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789858;
	b=U5m+C+N8W6G9NWkkE/N+UYRuiqN2GeafBszrCHynnGP0IBDyAFn7OM8xgdmpLdb+pJws
	 7P2fT9pr5E7Jgp/0O9paiE2bmQVIyoiPLN3pirZhxB6e+eUsAVkC7ELIBGOZaEMjYuiWm
	 97UEe7Xa4rQXVa3twINBlVKJKoL6f5wU2jcY1e+TVkqVzSM/a2/v84RF68VfznmHaH3A+
	 zhjBN5evs4iL+5T0zo0EwsAj3RykyKzVmJpULcoNnng3VsdALjXgGh5PQA/v79NqHN5b/
	 TnQe8SNCX0bEPjEw8R5eeMey6ZNoIqyI6Bly0ASAOZqGpvYXx3JZmvX95l0FD3/p81g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789858;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/Ear0TtjhlAiqS6CrqG+r0TTFWuCTgvxoaHllRwPv7Y=;
	b=2wP092kcdtIr0UTqV/wrkND0DHaP0lqcCth8pTfApqehtd+iHGXAmAqh3RU03shs2iAH
	 ckLvNfRJyyBytHonUu6tFu2f7AmWpz0Fj11S0KBjkUq1+YJqzyayMLh77S1sXZqKgrmZU
	 ePgc2gNzkp4MKQnJlXapnOpJF90Po/MnQb6UnMOsGJMTEyc2IOOXlnGB1MNWgosC4ew5c
	 JoU7cx0CuyaMH/rHkWqc36P3sP/A1J/S8SH5w2vcxKq9O184xN7/Lk2zZtPcUFzu0hWAt
	 9aaceU7crLYx4fSKCCl+aIWReo4Vmhwlj1FssVP/IogVgmFdhiSuW/rdT0zZ4/OTqEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMQlj24t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E35606A31A;
	Fri, 23 Oct 2026 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMQlj24t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924671F01825;
	Fri, 23 Oct 2026 21:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789858;
	bh=/Ear0TtjhlAiqS6CrqG+r0TTFWuCTgvxoaHllRwPv7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nMQlj24t2G/JJHM133MVIE/WBHt/3jffoG0pURfV2wduSnEh9LpfciTqHpSQzgStq
	 W6Vud3ipt5HSfLLWtFVs+txhLCIgEyp+tqaSrUaVkPAVe4zjXyDrEJKSebhx2evvWE
	 RsIdg2nUbCW1+pmRa0W0q+4jSxJmAHHmNLN2NugASuVdaKiebXwQhIAOTOl5qngXGG
	 Sgi1QHF6DIMhNiVUhioECgY57pfW4j4XcgktKlS59Nity32VENkBK6Q+8x1OfVtfON
	 tb2UWePfnSwkgDCwfiDdgxSFxDVPyCxmNRZ3wMhcQiwFOk9C+E/L16TyqVrKlIyoXf
	 I/PkC+Xo3pHNg==
Date: Fri, 23 Oct 2026 18:10:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
	xueshuai@linux.alibaba.com, Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev, Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v8 00/15] perf annotate arm64: Support instruction
 tracking for data type profiling
Message-ID: <atvNXkeWyJCGMrbF@phoenix2>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <18de9e8f-3709-4bc9-b11b-3813e1ba98b7@huaweicloud.com>
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
In-Reply-To: <18de9e8f-3709-4bc9-b11b-3813e1ba98b7@huaweicloud.com>

On Wed, Oct 21, 2026 at 10:25:40AM +0800, Tengda Wu wrote:
> Hi,
> 
> On 2026/10/20 21:44, Tengda Wu wrote:
> > This series adds arm64 support to perf's data type profiling by
> > implementing instruction tracking for the arm64 architecture.
> > 
> > The main changes since v7 include:
> > v7: https://lore.kernel.org/all/cover.1791629326.git.wutengda@huaweicloud.com/
> > 
> >   * Patch 02: Minor optimizations to update_insn_state_arm64 to facilitate
> >     future extension, including:
> >     - Encapsulating call instruction handling into update_call_insn_state()
> >     - Encapsulating invalidate dst regs handling into invalidate_unhandled_insn_regs()
> >     - Renaming is_readonly_branch_or_cmp() to is_readonly_insn()
> >     No functional changes.
> > 
> >   * Fix issues raised by Sashiko:
> >     - Patch 06: Complete the status register invalidation logic for
> >       exclusive stores.
> >     - Patch 13 & 15: Complete the lifetime invalidation logic for adrp
> >       and mrs instructions.
> >     Regarding the status register invalidation issue for instructions
> >     such as cas/swp as well, we plan to support this incrementally
> >     after the relevant instructions are refined; this patch temporarily
> >     ignores and does not handle it (a TODO marker has already been
> >     reserved in patch 02)
> > 
> > Patch organization
> > ==================
> > 
> >   Patches 1-3:   Shared infrastructure. Extract invalidate_reg_state() as
> >                  a common helper, add the arch_get_reg_offset() helper for
> >                  computing operand base offsets, and wire up the arm64
> >                  entry points (arch_supports_insn_tracking(),
> >                  init_type_state(), and update_insn_state_arm64()).
> > 
> >   Patches 4-6:   Core instruction tracking for arm64: function return
> >                  types after calls, load instructions (ldr/ldp and their
> >                  addressing modes), and store instructions (str/stp).
> > 
> >   Patches 7-9:   Shared data structure improvements and an x86 fix.
> >                  Expand type_state_reg.imm_value to u64 so 64-bit
> >                  addresses can be tracked, preserve imm_value for stack
> >                  variables, and delete stale stack state on store of an
> >                  untracked register on x86.
> > 
> >   Patches 10-15: Remaining arm64 patterns: stack variable tracking,
> >                  'mov' (register and immediate forms), 'add' member
> >                  address calculation, 'adrp' global variable tracking,
> >                  per-cpu variable access, and 'mrs sp_el0' to resolve the
> >                  'current' pointer.
> > 
> 
> Just a quick note that this version of the patch series has addressed or
> clarified all the Sashiko review comments. I would appreciate it if you
> could take a look when you get a chance.

Merged now, test built and pushed to perf-tools-next/perf-tools-next for
further build testing with linux-next, early next week I intend to push
it out to Linus for 7.4.

- Arnaldo
