Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2A236453;
	Wed,  7 Oct 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388963; cv=none; b=EtZE83ZaUvaHU8vt93+jIfi7oiq0v0B5wFIVQMvN/wSmTD/LC1JwU4wSng10KGBycGtZ2NJDTesWzZ7mW7KkBXrQdz39WNKymceR4U1vGvm8zapE4sFzU3l/W/o1OtUwn9AswTXfOXiQCBLzQC7crXPY+gGaAFQPWzzV1d04Lg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388963; c=relaxed/simple;
	bh=9GECcxbMuUFlAVYPEjNajH+dCdXjTa3sDAPijy+QbZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrKvyLpJOPi4NZ9B7ltg4X6BXPm/EQJYcympSrOhGUWLG3bzy8j3Ra4UmmRbDsUaciee5yKcISo0GwsedsZ2fSAj4NkuHaD8arUAiZ/fo7v2HjZWiOQlA3GCeidBIZMRKSFtHdHNPSz3F+30395rDGbZQYz37ffOmo61ge0cgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjdtGVUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjdtGVUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8740F1F00898;
	Wed,  7 Oct 2026 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791388962;
	bh=6MOF3KyMvHRNsPR6jgOpcgG89Un1WX6KNhSE1MqNCds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZjdtGVUOiyzAAq17IgPrn9nYudrHwWmJnPUTrMmtavRJYO+8pj5dBMNvkYLDrx/kO
	 ojzwfSkSj8VPHBPb8q3HSjPVlnrE5uPrfU9sxNEmd5xL4QIKdUtSUfPSVuhaA9949r
	 iri6hmm+GV23Qi9Og4sWLIjVmsNpcCCyhH6fLfTQ4gbv9iCbaKAVEJaPfHNCBLCrGW
	 61PVIlkygcDu7F0MowsqIMf7RXwqolXyhzw6WqOKrS8AS7aCx734faArtHB9naQS0P
	 ZyUmBMo7Fb+E1Oi8PCrf/XAZiANDXBst/RUg7TMzIZKLLtEVkymWCwMBLld+IB5Mg2
	 RvAhqbZInAQkg==
Date: Wed, 7 Oct 2026 09:02:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yanbo Zhao <yzhao62@ncsu.edu>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] perf annotate: Data type profiling support for
 C++ classes and virtual calls
Message-ID: <asZtHmjHDA--hXVM@google.com>
References: <20261005201010.36493-1-yzhao62@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005201010.36493-1-yzhao62@ncsu.edu>

Hello Yanbo,

On Mon, Oct 05, 2026 at 04:10:07PM -0400, Yanbo Zhao wrote:
> Hello,
> 
> Data type profiling currently only understands C struct/union types.
> For C++ workloads, member accesses through base class subobjects
> cannot be resolved, and virtual function calls (indirect calls through
> the vtable) lose the return type of the callee: the register holding
> the returned value becomes unknown, which matters when it's used
> directly to access memory like 'p->next()->val' where no DWARF
> variable describes the temporary.
> 
> This series extends data type profiling to C++:
> 
> Patch 1 introduces die_is_compound_type() covering DW_TAG_class_type
> as well and accepts DW_TAG_inheritance in the offset-based member
> lookup so that it descends into base class subobjects.  It handles
> empty base classes, members placed in the tail padding of a base and
> virtual base classes.
> 
> Patch 2 adds the DWARF helpers for virtual calls: the vtable slot index
> of a virtual function, the virtual function at a slot of a class
> (following the primary base class chain), and the class of the vtable
> pointer at an offset of a type.
> 
> Patch 3 tracks the vtable pointer and the virtual function pointer
> loaded from it in the x86 instruction tracking, and resolves the
> return type of 'call *N(%reg)' and 'call *%reg' through them.
> 
> Tested on x86-64 with GCC 15 (-O2 -g) using small programs covering
> single/multiple inheritance, empty base optimization, tail padding
> reuse, virtual inheritance, direct calls through the vtable and the
> speculatively devirtualized form.  In all cases the access to the
> returned pointer after a virtual call is annotated with the right type
> and member, e.g.:
> 
>   movq    (%rbp), %rax           # data-type: struct Node +0 (_vptr.Node)
>   movq    (%rax), %rax
>   cmpq    %r14, %rax
>   je      0x1240
>   movq    %rbp, %rdi
>   callq   *%rax
>   addq    8(%rax), %r12          # data-type: struct Node +0x8 (val)
> 
> The existing results for C code are unchanged and the added cost on
> the common path (a pointer dereference) is a tag check on the resolved
> member type.

Thanks for working on this!

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> Changes in v3:
> - Rebased onto the current perf-tools-next.
> 
> Patch 1:
> - No change.
> 
> Patch 2:
> - Check the value of DW_AT_virtuality instead of its presence (Sashiko,
>   Namhyung).
> - Bound the base class walks in die_find_virtual_func() and
>   die_get_vptr_class() with MAX_TYPE_CHASE (Sashiko, Namhyung).
> 
> Patch 3:
> - Check !src->multi_regs when loading a function pointer from the
>   vtable and when marking a register as the vtable pointer (Sashiko,
>   Namhyung).
> - Set ops->target.multi_regs in call__parse() so that an indirect call
>   with an index register is not resolved by the displacement alone.
> 
> The recursion depth limit in __die_find_member_offset_cb() reported
> for the patch 1 will be sent as a separate patch on top of this series
> as discussed.
> 
> Changes in v2:
> 
> Patch 1:
> - Explain DW_TAG_inheritance with an example DWARF in the commit
>   message (Namhyung).
> - Skip virtual base classes whose location is a runtime expression
>   instead of falling back to offset 0 (Sashiko).
> - Match a base class in the offset lookup only if it actually has a
>   member at the offset, to handle empty base optimization and tail
>   padding reuse where a member of the derived class shares the offset
>   with the base (Sashiko).
> - Keep looking at the next sibling in fill_member_name() when an
>   anonymous child (base class) has nothing at the offset.
> 
> Patch 2:
> - Drop the non-existent DW_AT_vtable_elem_index and the DW_LANG_*
>   fallback macros (Namhyung).
> - Drop cu_get_language(), cu_is_cplusplus(), die_get_base_class(),
>   die_get_parent() and die_find_member_by_offset() which are not
>   needed anymore (Namhyung).
> - Document that die_get_vtable_index() returns the vtable slot index
>   and that GCC and Clang both emit the index as DW_OP_constu
>   (Namhyung, Sashiko).
> - Fix die_find_virtual_func() to return the function DIE instead of
>   the DW_TAG_inheritance DIE when found in a base class (Sashiko).
> - Follow only the primary base class chain in die_find_virtual_func()
>   since non-primary bases have their own secondary vtables, and skip
>   an empty base at offset 0 which is not the primary base.
> - Add die_get_vptr_class() to find the class of the vtable pointer
>   through base class subobjects, and die_is_vtbl_ptr_type() to
>   identify the vtable pointer by its type ('__vtbl_ptr_type').
> 
> Patch 3:
> - Remove the receiver ('this' pointer) register update after the call
>   which was dead code and not needed, and the arg0_reg field (Sashiko,
>   Namhyung).  The 'this' pointer lives in a callee-saved register or
>   on the stack across the call and DWARF location lists cover it.
> - Handle 'call *%reg' by tracking the function pointer loaded from the
>   vtable as TSR_KIND_VFUNC_PTR with its return type (Sashiko).  This
>   form is common due to speculative devirtualization by GCC.
> - Strip the leading '*' of an indirect call operand in call__parse()
>   instead of extract_reg_offset() so that both forms are parsed.
> - Ignore void virtual functions instead of aborting (Namhyung).
> - Keep the existing pointer dereference branch and its fall-through
>   intact; the vtable pointer is detected from the resolved member
>   type there instead of a separate lookup before it.
> - Treat the new register kinds as pointers when saved to the stack.
> 
> v2: https://lore.kernel.org/r/20260930210038.196928-1-yzhao62@ncsu.edu
> v1: https://lore.kernel.org/r/20260821050207.4517-1-yzhao62@ncsu.edu
> 
> Thanks,
> Yanbo
> 
> Yanbo Zhao (3):
>   perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
>   perf dwarf-aux: Add C++ vtable helpers
>   perf annotate: Resolve C++ virtual function calls in x86 insn tracking
> 
>  tools/perf/util/annotate-arch/annotate-x86.c |  77 ++++-
>  tools/perf/util/annotate-data.c              |  61 ++--
>  tools/perf/util/annotate-data.h              |   4 +
>  tools/perf/util/disasm.c                     |   7 +
>  tools/perf/util/dwarf-aux.c                  | 282 ++++++++++++++++++-
>  tools/perf/util/dwarf-aux.h                  |  21 ++
>  6 files changed, 426 insertions(+), 26 deletions(-)
> 
> base-commit: 1dc462fc214907671600172280c2e79ef9fe6fcf
> -- 
> 2.53.0
> 
