Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793730163;
	b=vHH8PCa2e2uekrgne7HhSEOSTN+AyVC5bNlqaUxt+LwZ2k05f2SRI7P/j+TyplR/3Ssp
	 yy5L2VAfJfhPqL0Em76x7VQkNRtRF1OhdFrnwr3zuFCAslH9KnCbNasiAZFoLHYrzhklQ
	 zlWosXhX0cmsnQ939LmLuld4S6WsIZV1ls80gIgXJ4i5k6R1b/zR6Pl7ByYGihHJflgwh
	 IK7hZNFxlBcoHQC+YYs0BEXmmeWa1ZTp9N+9lhnn4MAUZjUVmYAOFrzUcaXwdKWcrzBnd
	 nVNdA6zzseGxz5d+K7hfTeWOcyvCFYI1Dot5zH2IeI4SI9IujRkGhBbh66AeyViaXlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=En9AyB2znnRelP1c9QrC2zvMZFWfC683T9atn6DwxoQ=;
	b=gBgiq5fO6pEC7xnd7X7PSURYU9eSinOK1uc/PTl33nWbmXPesy/tif5u6g7FHNpCSJWe
	 VJCL7tjA6epu+Y6aeIRmzyyvc1CCxE6W+G1T27On5upDQqPEpI9ZebgoryQ81U04GVmib
	 u7FrtCG1ziNvCXXRu6K5C1b2UmXa8CyXUMoZ7lVQ1tSmNOoQzOg/ol0S7crQVfKXZdkOg
	 G22XCDd6+rtaK+EVxg993PYnrCz03QSGpB2rIi7GhSWgCVpNPwkVpgO66bAYA23h8LW5A
	 gZGxuuzz8klA231NEdMnduGL5CjDTZTDqK+lF5MY3oiGaZiWUQo50sFMWuulNmJVaTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ncsu.edu;
	spf=pass smtp.mailfrom=ncsu.edu;
	dkim=pass header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b=MCzOHnuT;
	arc=fail smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F83606A326
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 18:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F83606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b=MCzOHnuT
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-677af43eed4so3436104d50.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 10:22:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793730161; cv=none;
        d=google.com; s=arc-20260327;
        b=M0/MEsG+N5YQxvVKIyLNjKqRtg7FXREuIUX6/T30Td5QqcNEK068gZOgDH4vVQnVJK
         qbPO+5+nrzkzZe5RSvScs1YQ36ejMiccwUF3EI3qAUm/VJjFRzeKe8a0aX4V18cHSj9+
         cqFgBkyo8urYNhIlgEnw5qzmzSOQl0Vn1+QuqfRX/waPAQUbO+HZ+/oAYo9tLeGA4b4n
         +qOYu0d1PWouJ+wZH6ZaTfBlX/ceuZvqVajOEtnzy6pgsHwZTxlWeVvbzXeOpAyPURMY
         tqnRCSR2i0iTiw22X/2f5Nm5ARnnox88rurXKfDDxFuHu6ti0XTe2LTObzB5/dDMo1tN
         vyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=En9AyB2znnRelP1c9QrC2zvMZFWfC683T9atn6DwxoQ=;
        fh=5zDf1eKie0kYU6zlBT9uJMZ34H2t6zwdZZ7j3lAswu4=;
        b=q4CKEplO/mFS3xnbAbsc8ETaGLya3qWo6G9OG+Ii8ss4efxCfSQjv53e6bYfAliNix
         YYxwDnBwaQEWi/1o1u/OyHhtDT9k3crOVyp/vWpVBLNxcxt6YBAHe+/knlPPOwKTipWI
         UPRdfStiJzfGVvHRlts0Mwu1SkHSZCvGvoX8GQyB0DY396TjCsa7DZMdnIfmgIF85gun
         qe8NLn/4IEjvK+PNyx8eE5e9KVNYMN+3zfMUCJ+0JUaGSC4mgfHqWcUyHNzJ4kpOwUZ2
         5ilrDZTwhGP+Mol5Hts8w+fF8Ovsw4XbVh5C9DGi/Okl9FIsV1AJumfvyCUjA3sEfypC
         AQYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1793730161; x=1794334961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=En9AyB2znnRelP1c9QrC2zvMZFWfC683T9atn6DwxoQ=;
        b=MCzOHnuTcVZJW7wk0XU/FdFZNHjYWYqW5A4DmANd9bARPZBSDUjZyiz1GmPSHS4tBv
         r/l4GdUwPVPJybIjdsjpRe/DbXwjGNvmSs7gJe19W2Ty/8/uCxfYsUFBBGaRkPPzWYsv
         2Gcbup26dwY/jspsPUh3MX+BuUEp41nirZEenx3z484AQdJFO5iZC+LK9AubpQse+e0Y
         DQ9dsFsPHap/z1NkrnrGi9ImzuCOSLg8pvV8Q1qacgFTXXCbM9ur9xOs9gb41JmHicVR
         aI5dxgSuy9vz5wRnaHT4jvo0xLqZXTNQstofVd1SD9uREaSrA9Y+H/jJGpIGSDD3edsv
         oF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730161; x=1794334961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=En9AyB2znnRelP1c9QrC2zvMZFWfC683T9atn6DwxoQ=;
        b=Z3H5lqO6sALI6TTfLcmS+3XbfXjSsioX88sA2+tdltD+nm6n6KWIFt+zwbyehnt0bs
         t4KJGXLoIrnVg1FaJlPJjtJFZNqToOqSxfAJ0LTsi8HthYDk6Ilh/FK6ZT5muQE7kv4k
         ncocrmhxQrHK/vcSDyuUG5wTgcRHgXcW/mYkWntGT8BzvAURsS3GmHT5tFJoqaCD4kG9
         xVXSEHosuGxEqi73EQtpsxpWOShrGt0YRJTO9tQ3trmMPe/fm9KjiahQIPBoF/GureAh
         cu/PQ+fQvldX/gEqo+RrxneMMf0wSONI+e9g/CVOeP1dChixPFdY/QiHjGhgTmxACwMm
         bHTw==
X-Forwarded-Encrypted: i=1; AKwUvByNjULqxqPY2MebnsuxLEVcAyTkJKQ+xqqVItfERnBj+ENC07rMa33rt+rWSZl3rcy2uXQNb0bI8sfjEDLNyAzj@vger.kernel.org
X-Gm-Message-State: APuU4Z/sj5i7GhUTV6/B6nefHwZm3jyikqFsST1AKaE/ImTfbkhfYMvt
	83dBKyRrwqgg23rBfvOE8PGNBUU6581Fw+nUNowro8BXoM4p8lwyleq9uH9Z8p7VmFE32cnSrXb
	JZ3FTBa7nbXvHyj99RA9HMsLQv86eqSFWEBALLl5vCxQnndTqpML/4YrF
X-Gm-Gg: AYBFou2OOQYrIB4zuDT3xocq9LdfcwWKmr2DXQqWC0f0EpLapJqPyeNWcMZdG56gP0C
	ecYXNtVQhB1DUs/YYto1V9wuXLh81v6Ql2LOdiznTATBXlqm+STrPHdAdnHqxyVcIuJlPzPnljq
	LoBBuddjztDCbSUzTBoqtXvh1pWxBBhiTYK6kHRAj5qB9+oOe1G7kt+kHxsrrqstf+IeMBxoHZa
	JNx3eH6+lTpswhN1yzTHp1fosUJM6XeSkQ8cTKZUQMxhR+R0+eu4hOIqe96TT8zsNc3jgUtv4Az
	cck8psEF9/ixNVlj271LELZ1E3UeLlYXJ+4dbW1JoIvXLLilXuPVKhv1ysGW4WBrtQ1fb/+eQdb
	vkKLKGEL/GzClIKCbxq+dprWWy4iNXuByt987d38xdzpXc+/+IZ7XaS50YHp4etRijYcO9EKx75
	6HDIMlnHAw8yPWvw==
X-Received: by 2002:a05:690e:bc2:b0:674:6809:6f15 with SMTP id
 956f58d0204a3-67ba49deb64mr10772962d50.0.1793730161161; Tue, 03 Nov 2026
 10:22:41 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005201010.36493-1-yzhao62@ncsu.edu> <aumOys6T9Kbd-dR3@z2>
In-Reply-To: <aumOys6T9Kbd-dR3@z2>
From: Yanbo Zhao <yzhao62@ncsu.edu>
Date: Tue, 3 Nov 2026 13:22:29 -0500
X-Gm-Features: AclHuK9uXC0wBQ6jPFx3njHcynFvn0XL8F8jdZutMY6Kqbgw1fcU4mgs47rLdx8
Message-ID: <CA+J8viYXEbmmKqAB1Dkppmrs2KYR1Fap8Kz2gWNgJqfGY0QR2w@mail.gmail.com>
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

HI Namhyung,

I have sent the V4 patches rebased to the current commit. Could you
please review it?

Best,
Yanbo


On Tue, Nov 3, 2026 at 2:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
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
> Sorry for the delay, but can you please rebase it onto the current
> perf-tools-next?  It doesn't apply anymore..
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
