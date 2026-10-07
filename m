Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A03D5668
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791389652; cv=pass; b=XDwhVdPuU+MMmBeiM9fQa4x9akiQIOQOYvOe8k/WU/MAaFa4XJ8LwrxW+Xffo6jm1dItK8B8VtP3rJfudGeemVQeQOlMCujBKxYsUK16QT3y+yKzNnVcHY6/mCZ94+HIKOK0SmUfPhHJ+bTCmS62surnYLysoTZ3MU7vXoSvrl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791389652; c=relaxed/simple;
	bh=WKUs52uoC9EQE/UJ+NNwRhWd//Mj9ebAmu+GkM0uTyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlGXJ4GKP0FVO4UaYDSgJMk2tYuqQwCD5i28J2L8F6gql5uuzlmX9PlhtaXqxxTTpluVU6qEDAlcR6GfBlE+Z6HedNCu2QV0RPiLaGFz7s5/mB7vuuU428Z9Dm5anuKp452gIdxG43zukWdkCTWSCMBPOVladkbVZgCyFGsmPTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=XYDMKc+O; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="XYDMKc+O"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1906119a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Oct 2026 09:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791389648; cv=none;
        d=google.com; s=arc-20260327;
        b=IRTgZfFyNYnz5Cox7VWTWX8QjCSeYSWewgEF/9pj8R/ak24GI0E/5Pu2E8OMRE9pko
         Yvj1FuMGwcNOb4LHb7Xweg72kSi2kq27CQ7Nb5EtlGvrRnC8ynVzeiB4u+8dxQa8WNki
         uUip6OtUdaMStFAAd1u60/DT5gAg1oZ2UkVbmLGLHqE92S5thQTCaZo9sd29pVSTcK9I
         d3FC4tU03CUT1H0mkDGJRwZVHlt2pQLZqHec1NphLGjuwExn4MF4XH+np1/JwOM74K/g
         fvzVTWblW01Hadbp8TJ7u9vZB3xcqiDOdAiWHq1tsfRAl/9Z61qJ0OCB+/Jw0Tpxy/xT
         jDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EwTAWcr73xgYfBX4GXvfxHil13WRE/QVYtr1aSJOR0E=;
        fh=oQjnPkyZM/SZp3GcyAAkqNNB60liF4Px0OY+lxCnlE0=;
        b=TFX/pgMI22IbpdW076aYWNt2ofbw2kqnRhiqrR9GP37mrZD+PQeNDtu1gEYQRPTbpQ
         0sECXaSFAtBlSnvmvG5hZCedzZndoxfJdvBPvsDSHJYOMjYS4779SCbhZDzu6qcUjbuv
         eWKl2O+qXVvT2x7WjstNMkrJgddiYPTtYvn6uqNFk3pnrxdxiaLH40shv9ZVctBChRaP
         MLCpxA6e4M3CPxChgVDcNM/TaGTxYRIOxRoyLzTzDCccbyZ183z/LF7EEzjqKg9wEO89
         Cu1vqihRugoUjvzLyoAqwjlNJzlsNsZ+y7+2vT+LPwITtSO9izN5NpLOxa81WLJ6qpnV
         fX2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1791389648; x=1791994448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EwTAWcr73xgYfBX4GXvfxHil13WRE/QVYtr1aSJOR0E=;
        b=XYDMKc+OVqGBL+kUUjz7NUE9PqyzwZz6FMFAKkP9g4HZ+gcg/Z/mfMcz6JypcInRDV
         ZcxpznonHMVQJGGT4Rw5SWplchPNIvThDD/4YTF31+KJ0ZXsdjSslFH0L1e5mATI5y0D
         r5wNEDXZCpNkx0snySTjbyWL0FGGHD+wJNnSixo1k2KoSb8rWGpSr32Sl30Ha3yM0f0i
         BI/Tq52wJ4HxmKdOSjnQncXZiFnZ+l7Zo1JIZ5U9AK8TbtvD/lUKL7TspRDWMSOZyyue
         rPsNb4a6uveq73rICQn7X797FCMEzUeCXRqj992Rv34k6E3/PYY5oVlGu4hPBTlry7zR
         T7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791389648; x=1791994448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EwTAWcr73xgYfBX4GXvfxHil13WRE/QVYtr1aSJOR0E=;
        b=g+UUmumK1zB9SNYMRslm93H1jT6RFNny8T5KTin/5SLREvi9AsxlkkDH1LqcBKbq40
         IdeOWX3A0jcdRIGypaa328kMlofa+mH06Z3J6r+CiL7iBP4YxoHGOCvmQ8TvnhVPrZ53
         Rt4RaUzz5ZkNFeIxCRdJq/F9DHd7QPGGvpc5oCSHAbdToX6lqhdJ8NJXQFr/DQWg3KWh
         +2+NfVAehExQ1CQ5qX8UP47kvhzqs3vAe6cfTrtaVEoMir3GrAoxdGs26oac38FjT0Ru
         tAt2Y+QSV3amWG9J3cytkU3Ir9aBXeR3TqEr9xN8zhCbIDpbzw8QcVD3bt01f51h/Fmo
         jEyg==
X-Forwarded-Encrypted: i=1; AKwUvBz/+bpYKGRNvr8FIsGvVSDgG0BLtAOlmV6SNfqRUqfL0+g4rTWppeuq8LAlAHz4/JslekkuIrhrotRn6+STPgKE@vger.kernel.org
X-Gm-Message-State: AFq9FYKGoWEI3PIhyycYz9bg0Ieg/CclrVbdgr60TgdCb6N5rAmyLzlS
	uHKAo4rryediCrxRl//vbJiS/78rw1VArvGl3RT5Y9LCQ1TuJTAR3VRvScnrrWpNiyM28bKR4rW
	iEcR0Dr9eCFqPlrAcNpLXCLp8mjsrJHNMqeJ/scuP
X-Gm-Gg: AYBFou1VFwp3waIDakVgFBQ0ISvKNjdWpe88K/FR3wdIycL5lb+qgau/VyYcrHWRDeK
	nC8+86OzT/KYHwdiMqPBCU8Rrn88Fd29HWnKdUwH996JO6T5CFUCEAj+b3cMsL06NW3BMfsRvWV
	NVMaf/aFAndLbM6h/rzUMu7ao/0uR1OMaSstUAhNdbCAym64jIyMVnFIvEsc3/ErF4qTGzqv7dl
	YDQaP1vpuzT9XNmt0NMxnJ/QLr/p+JnYemwRNAovyIJ1HKVTHelId35XhMEkwKrEdOBEr4tEHHL
	Eca1DL89xujVYXZoWlAfH+66ScaqnbdvS0vtHQ2PEDZGJNHF8gXjbuac+JJtOlYwaPBStgVC6me
	3HURKPlIM3vI=
X-Received: by 2002:a17:90b:57ce:b0:3a4:fa1a:2b1d with SMTP id
 98e67ed59e1d1-3a8a1c3ac39mr2165844a91.62.1791389647673; Wed, 07 Oct 2026
 09:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005201010.36493-1-yzhao62@ncsu.edu> <asZtHmjHDA--hXVM@google.com>
In-Reply-To: <asZtHmjHDA--hXVM@google.com>
From: Yanbo Zhao <yzhao62@ncsu.edu>
Date: Wed, 7 Oct 2026 12:13:56 -0400
X-Gm-Features: AclHuK8WLqUQRQdipFXa86JF-X-263W7GTyonNnwLbJjjvdD0ud2BwBbpNpZiYA
Message-ID: <CA+J8viZkWZy=UfDg1aX9KDGmkJp_+V6MCWP8UZ9zYPU89+cSLA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] perf annotate: Data type profiling support for C++
 classes and virtual calls
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

Thanks very much for your review and help!

Best,
Yanbo

On Wed, Oct 7, 2026 at 12:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello Yanbo,
>
> On Mon, Oct 05, 2026 at 04:10:07PM -0400, Yanbo Zhao wrote:
> > Hello,
> >
> > Data type profiling currently only understands C struct/union types.
> > For C++ workloads, member accesses through base class subobjects
> > cannot be resolved, and virtual function calls (indirect calls through
> > the vtable) lose the return type of the callee: the register holding
> > the returned value becomes unknown, which matters when it's used
> > directly to access memory like 'p->next()->val' where no DWARF
> > variable describes the temporary.
> >
> > This series extends data type profiling to C++:
> >
> > Patch 1 introduces die_is_compound_type() covering DW_TAG_class_type
> > as well and accepts DW_TAG_inheritance in the offset-based member
> > lookup so that it descends into base class subobjects.  It handles
> > empty base classes, members placed in the tail padding of a base and
> > virtual base classes.
> >
> > Patch 2 adds the DWARF helpers for virtual calls: the vtable slot index
> > of a virtual function, the virtual function at a slot of a class
> > (following the primary base class chain), and the class of the vtable
> > pointer at an offset of a type.
> >
> > Patch 3 tracks the vtable pointer and the virtual function pointer
> > loaded from it in the x86 instruction tracking, and resolves the
> > return type of 'call *N(%reg)' and 'call *%reg' through them.
> >
> > Tested on x86-64 with GCC 15 (-O2 -g) using small programs covering
> > single/multiple inheritance, empty base optimization, tail padding
> > reuse, virtual inheritance, direct calls through the vtable and the
> > speculatively devirtualized form.  In all cases the access to the
> > returned pointer after a virtual call is annotated with the right type
> > and member, e.g.:
> >
> >   movq    (%rbp), %rax           # data-type: struct Node +0 (_vptr.Nod=
e)
> >   movq    (%rax), %rax
> >   cmpq    %r14, %rax
> >   je      0x1240
> >   movq    %rbp, %rdi
> >   callq   *%rax
> >   addq    8(%rax), %r12          # data-type: struct Node +0x8 (val)
> >
> > The existing results for C code are unchanged and the added cost on
> > the common path (a pointer dereference) is a tag check on the resolved
> > member type.
>
> Thanks for working on this!
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
> >
> > Changes in v3:
> > - Rebased onto the current perf-tools-next.
> >
> > Patch 1:
> > - No change.
> >
> > Patch 2:
> > - Check the value of DW_AT_virtuality instead of its presence (Sashiko,
> >   Namhyung).
> > - Bound the base class walks in die_find_virtual_func() and
> >   die_get_vptr_class() with MAX_TYPE_CHASE (Sashiko, Namhyung).
> >
> > Patch 3:
> > - Check !src->multi_regs when loading a function pointer from the
> >   vtable and when marking a register as the vtable pointer (Sashiko,
> >   Namhyung).
> > - Set ops->target.multi_regs in call__parse() so that an indirect call
> >   with an index register is not resolved by the displacement alone.
> >
> > The recursion depth limit in __die_find_member_offset_cb() reported
> > for the patch 1 will be sent as a separate patch on top of this series
> > as discussed.
> >
> > Changes in v2:
> >
> > Patch 1:
> > - Explain DW_TAG_inheritance with an example DWARF in the commit
> >   message (Namhyung).
> > - Skip virtual base classes whose location is a runtime expression
> >   instead of falling back to offset 0 (Sashiko).
> > - Match a base class in the offset lookup only if it actually has a
> >   member at the offset, to handle empty base optimization and tail
> >   padding reuse where a member of the derived class shares the offset
> >   with the base (Sashiko).
> > - Keep looking at the next sibling in fill_member_name() when an
> >   anonymous child (base class) has nothing at the offset.
> >
> > Patch 2:
> > - Drop the non-existent DW_AT_vtable_elem_index and the DW_LANG_*
> >   fallback macros (Namhyung).
> > - Drop cu_get_language(), cu_is_cplusplus(), die_get_base_class(),
> >   die_get_parent() and die_find_member_by_offset() which are not
> >   needed anymore (Namhyung).
> > - Document that die_get_vtable_index() returns the vtable slot index
> >   and that GCC and Clang both emit the index as DW_OP_constu
> >   (Namhyung, Sashiko).
> > - Fix die_find_virtual_func() to return the function DIE instead of
> >   the DW_TAG_inheritance DIE when found in a base class (Sashiko).
> > - Follow only the primary base class chain in die_find_virtual_func()
> >   since non-primary bases have their own secondary vtables, and skip
> >   an empty base at offset 0 which is not the primary base.
> > - Add die_get_vptr_class() to find the class of the vtable pointer
> >   through base class subobjects, and die_is_vtbl_ptr_type() to
> >   identify the vtable pointer by its type ('__vtbl_ptr_type').
> >
> > Patch 3:
> > - Remove the receiver ('this' pointer) register update after the call
> >   which was dead code and not needed, and the arg0_reg field (Sashiko,
> >   Namhyung).  The 'this' pointer lives in a callee-saved register or
> >   on the stack across the call and DWARF location lists cover it.
> > - Handle 'call *%reg' by tracking the function pointer loaded from the
> >   vtable as TSR_KIND_VFUNC_PTR with its return type (Sashiko).  This
> >   form is common due to speculative devirtualization by GCC.
> > - Strip the leading '*' of an indirect call operand in call__parse()
> >   instead of extract_reg_offset() so that both forms are parsed.
> > - Ignore void virtual functions instead of aborting (Namhyung).
> > - Keep the existing pointer dereference branch and its fall-through
> >   intact; the vtable pointer is detected from the resolved member
> >   type there instead of a separate lookup before it.
> > - Treat the new register kinds as pointers when saved to the stack.
> >
> > v2: https://lore.kernel.org/r/20260930210038.196928-1-yzhao62@ncsu.edu
> > v1: https://lore.kernel.org/r/20260821050207.4517-1-yzhao62@ncsu.edu
> >
> > Thanks,
> > Yanbo
> >
> > Yanbo Zhao (3):
> >   perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
> >   perf dwarf-aux: Add C++ vtable helpers
> >   perf annotate: Resolve C++ virtual function calls in x86 insn trackin=
g
> >
> >  tools/perf/util/annotate-arch/annotate-x86.c |  77 ++++-
> >  tools/perf/util/annotate-data.c              |  61 ++--
> >  tools/perf/util/annotate-data.h              |   4 +
> >  tools/perf/util/disasm.c                     |   7 +
> >  tools/perf/util/dwarf-aux.c                  | 282 ++++++++++++++++++-
> >  tools/perf/util/dwarf-aux.h                  |  21 ++
> >  6 files changed, 426 insertions(+), 26 deletions(-)
> >
> > base-commit: 1dc462fc214907671600172280c2e79ef9fe6fcf
> > --
> > 2.53.0
> >
