Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691341;
	b=2Er+pXgUbtPvzlHAYUUg9HukeLrZr6r9bc9uRte7Y3h5kYi5Sp1dnvJVwNl7Cu4RcfXg
	 4zlUYW8ae6C2kET3E62zvqIE2rw4P7ELh1Y8t3581F/nD3K4DJ4J2QiHpNIwrD1wpUBV6
	 eFYMkX7Gxye1Bjj54ykH0tiaiKnNopaubnRlzGvvE41zRyaKcKBTkFWPMwYWtsW7brh/G
	 uSsffXTa0noPNR2ngwQDBBIn5jA0uCGvtyOdW324eTg776QavBmwSRMwWx9ySmczKo7dI
	 l6HV4pmBUxF02z3jH+sLqvGM5dIF+kVgsntE1cOCbAL9i/k7LRYGSQK55C7Rb/kn8NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691341;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/kQXicVqSPGn/VkwwLnYSrjADMOXvvKsHTowWZrwqDo=;
	b=ntFf2MhNA+n8/2dZARPL3xP4mM98RDFGc7FlNOTyRLBebRCcUYODDleSa3XcgOCHJ3wL
	 Wep9Q7877+fgM0Rm+3oEhQ/wfc/R1n0fnghvXhz+6XxJAaffTjNA6UkDxL/XYrE2mJ5uq
	 ONjPhT4OvV1DNMhvz9p/7JwUtjfXItrdk6KBrOY9GuQunmEwTSeemUj/oK8Vwe5N1bvvZ
	 Gzjfc56A/GCubDwRY30UlMo2edEqZts/PFfgYvMYQVA793U3YizxEk6PMoKJ2pZf35L3e
	 67FogJNtHHZ5oZiCdCWIU+IJm2xvX3B/H0VdKWww3tmkenS16RLsycX2lVzybjkkp9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K65Clxbr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B257606A324;
	Tue,  3 Nov 2026 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K65Clxbr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1991F000C1;
	Tue,  3 Nov 2026 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793691340;
	bh=/kQXicVqSPGn/VkwwLnYSrjADMOXvvKsHTowWZrwqDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K65Clxbrdc64/02z6dd49q17Axcq3jIlV9mM2ZN8OZ/RRH0TmQzoNyU7ckt9mqFCw
	 Wjfs6HSkxG7DsnwjdkqgYddXD0skESri46eRDgL4EBdGFnztFCXnv0Oxw31h2z52W0
	 F7U9T1Ul1xNyQprq3c7vcEpaWAv8ezdf0CXmZsO38DFjfWyJU2VczyNBqyBpxVvELZ
	 mwYSZuWzPDwdrji3ZVj6eJKsp1nC9lOlZBFUVPnusBRb2MC/TcChe2gunQRgGg3w87
	 ZY9vfiQ4O4MLiSrP92vdNwWchDtgrZYgG8kgtZYis3y5CznuddtYvGixdj1Ed/oU8m
	 RAW74/eS7BoYw==
Date: Mon, 2 Nov 2026 23:35:38 -0800
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
Message-ID: <aumOys6T9Kbd-dR3@z2>
References: <20261005201010.36493-1-yzhao62@ncsu.edu>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005201010.36493-1-yzhao62@ncsu.edu>

Hello,

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

Sorry for the delay, but can you please rebase it onto the current
perf-tools-next?  It doesn't apply anymore..

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
