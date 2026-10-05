Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D62F6577
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231029; cv=none; b=RN+CYbWG5BJm+5Yx8Jit7mZUrMzxtveeYrV9qstn+Ch3Gjlvjhc7xO1tkvZfiaAXCGcnkkFqa39TogqfKpxdpHk8jk4l5IvQixvxQks0LtoVYYuAlCf42b4BpBziy1phJxNjrMJT+bPtMNp1H5qAKu52bvDSl4R/x5rYKGT4JRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231029; c=relaxed/simple;
	bh=UpAx9mLMIpL3rMBCNwzW5Dq33W6KjPFsFmFYIjlffmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNhgHq3OPkehvUWbVsdUcq9e7VkhNweuoToxTD9dDy0gVLLeEAjLuSnbIjlZcT5SVJSaQMN6IJs1VVMurxq9MCMtAVsI+avNJey9GtqFVNN8JFUcDOzCGBpuSvNXwet/pVy6IkWU7/U24Xw0Bt3zhtzfTyC9cFYEiGKW/koLqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=DQqDnFr5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="DQqDnFr5"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53505bc6524so15176781cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Oct 2026 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1791231025; x=1791835825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ooRBrlgG/+LZ8y1btseMmgSzmfpeb0S+Qh8lEsQpK0=;
        b=DQqDnFr52RXFZp45HmrNUBkycqnJbXlyrZZEvStaXLSTg5/xciMn0488fPNTEPUBZg
         VQ1qcLyLtET7q8MpcG3pMU5QdVlTRqrtt7QIrTbOHzyl5Minxu9MwGRdPWu0eYxAj97J
         dzmOqF5FsbUwDDHQi4ddLPRcXHrnPkc9tt/idfr7mWYPc1pz77eQYmkqp8HzKdoGuCQL
         mXbnSyHuuennKBLysLyd2CZYQ8rw9JWaM/KFe2pGv6qp+l9XOpHm08kSgP4/lAEa9nuw
         1vDmGnvcZcZcsGj9k/zWLrMxpTWQL6xVwDV8lhXmMFXQe5FGm8szhdZt/ds8njV8Zsxh
         AjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791231025; x=1791835825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ooRBrlgG/+LZ8y1btseMmgSzmfpeb0S+Qh8lEsQpK0=;
        b=Rsk32oKfl+GU0SVxqUb85S8AjzV+lZR9x082aqfjtGj9Bx1WHzg5ntiijFqarjHccH
         FvTVSYmf4ctwRgjbqMKGng7skXxrDLc01p/ljRniex4wuZLCHpqnn5p+YHQYMCoo/XhS
         HZfNl/C2DmWSHk8XMgZUtdG1pswVMktdE2dESJDYAqvyr/O9WTwkmGxNEXZnhNVuCuVM
         CS5i4S9Zw1HYJuxokiEUpaYNGrdbOXTquHSCsMYB6uxOQsT7Wqecv4+mrbynWJIVx6X5
         s9R7K+K5gj6FiRQBV4wbgCaxDaGSDvCMImfZuEn3AmkX1fe5S8GBKuzUHqizsZzS/eKZ
         WoWA==
X-Forwarded-Encrypted: i=1; AKwUvBzKOliqPVILPSZbosfR4M5S7+nkkp7s5v/Ym3VyEGR9imualT4V378X/2u9kJvs/3/74OmxVg7FTEKDbR9sYNCe@vger.kernel.org
X-Gm-Message-State: AFuF++mUrVSllbVNEZzl0SYVZE88vOXtgJOp/R9fTX2JH0ngEl+BeHjp
	B5ahM2S+mC7/O8CFlEe8Mxxc9W2p1BdpTisXBr7mRoweoPPoRcM6dha/kDm+1eBe8g==
X-Gm-Gg: AYBFou1AjAD9c7q8/vIgNdqnYq5UsrbQql+RoP5GzxwDbpET9241s0V6dUsLjNid9Ct
	bEcGFhHn/WKl5OckSftKPOx4Nz10AGurG/AhjdiWUY92Cii5MbHScG7iOx/Ot4gWEziobLkFmL0
	yeAWrKgHG2d7TzVtIccn5qQNwyX/BZZ0g1PJvWUfvFV6YtFotqUUtBMxa6miimXXjOmxc0VqEHy
	7bZknMnzrKYtcynsJ6Ge2YVxZdkInUHX2LdqtrEsOmIf0+f9O+XBOCiiz65XXX4j3HHUI+VwtRz
	EKnaxCLiSd+0P5rQai9id0iczVSD2x+6iOyuA5yH91GLN9LNWzuh7KTqcNLY/sSOEeUVmL4elZ4
	BLgAO7lIPEc9vwuXWCYcpvyv9eV3UoId7y2lKwPtFlHdMT/HK61p7YOtqHCvBNJgQwWFC7xzYcp
	FcZ/dyqAfIgIv5biMkAztTN3FPWZO7+FJSeWix0P1iRKCH0CEzrNqh0TLQKYVhaJdbX6nbFSh4v
	lTJE+uftIfwQSK9CNRqH1DaKnTbIFPmmll6FGONj4CAcshut99y+iMKw1CHFQB3Agk=
X-Received: by 2002:a05:622a:260e:b0:533:8dbc:1fb5 with SMTP id d75a77b69052e-5353f2018ddmr13658111cf.4.1791231024971;
        Mon, 05 Oct 2026 13:10:24 -0700 (PDT)
Received: from flag-System-Product-Name.tail132f98.ts.net ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398a9c92csm106693991cf.11.2026.10.05.13.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:10:22 -0700 (PDT)
From: Yanbo Zhao <yzhao62@ncsu.edu>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yanbo Zhao <yzhao62@ncsu.edu>
Subject: [PATCH v3 0/3] perf annotate: Data type profiling support for C++ classes and virtual calls
Date: Mon,  5 Oct 2026 16:10:07 -0400
Message-ID: <20261005201010.36493-1-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Data type profiling currently only understands C struct/union types.
For C++ workloads, member accesses through base class subobjects
cannot be resolved, and virtual function calls (indirect calls through
the vtable) lose the return type of the callee: the register holding
the returned value becomes unknown, which matters when it's used
directly to access memory like 'p->next()->val' where no DWARF
variable describes the temporary.

This series extends data type profiling to C++:

Patch 1 introduces die_is_compound_type() covering DW_TAG_class_type
as well and accepts DW_TAG_inheritance in the offset-based member
lookup so that it descends into base class subobjects.  It handles
empty base classes, members placed in the tail padding of a base and
virtual base classes.

Patch 2 adds the DWARF helpers for virtual calls: the vtable slot index
of a virtual function, the virtual function at a slot of a class
(following the primary base class chain), and the class of the vtable
pointer at an offset of a type.

Patch 3 tracks the vtable pointer and the virtual function pointer
loaded from it in the x86 instruction tracking, and resolves the
return type of 'call *N(%reg)' and 'call *%reg' through them.

Tested on x86-64 with GCC 15 (-O2 -g) using small programs covering
single/multiple inheritance, empty base optimization, tail padding
reuse, virtual inheritance, direct calls through the vtable and the
speculatively devirtualized form.  In all cases the access to the
returned pointer after a virtual call is annotated with the right type
and member, e.g.:

  movq    (%rbp), %rax           # data-type: struct Node +0 (_vptr.Node)
  movq    (%rax), %rax
  cmpq    %r14, %rax
  je      0x1240
  movq    %rbp, %rdi
  callq   *%rax
  addq    8(%rax), %r12          # data-type: struct Node +0x8 (val)

The existing results for C code are unchanged and the added cost on
the common path (a pointer dereference) is a tag check on the resolved
member type.

Changes in v3:
- Rebased onto the current perf-tools-next.

Patch 1:
- No change.

Patch 2:
- Check the value of DW_AT_virtuality instead of its presence (Sashiko,
  Namhyung).
- Bound the base class walks in die_find_virtual_func() and
  die_get_vptr_class() with MAX_TYPE_CHASE (Sashiko, Namhyung).

Patch 3:
- Check !src->multi_regs when loading a function pointer from the
  vtable and when marking a register as the vtable pointer (Sashiko,
  Namhyung).
- Set ops->target.multi_regs in call__parse() so that an indirect call
  with an index register is not resolved by the displacement alone.

The recursion depth limit in __die_find_member_offset_cb() reported
for the patch 1 will be sent as a separate patch on top of this series
as discussed.

Changes in v2:

Patch 1:
- Explain DW_TAG_inheritance with an example DWARF in the commit
  message (Namhyung).
- Skip virtual base classes whose location is a runtime expression
  instead of falling back to offset 0 (Sashiko).
- Match a base class in the offset lookup only if it actually has a
  member at the offset, to handle empty base optimization and tail
  padding reuse where a member of the derived class shares the offset
  with the base (Sashiko).
- Keep looking at the next sibling in fill_member_name() when an
  anonymous child (base class) has nothing at the offset.

Patch 2:
- Drop the non-existent DW_AT_vtable_elem_index and the DW_LANG_*
  fallback macros (Namhyung).
- Drop cu_get_language(), cu_is_cplusplus(), die_get_base_class(),
  die_get_parent() and die_find_member_by_offset() which are not
  needed anymore (Namhyung).
- Document that die_get_vtable_index() returns the vtable slot index
  and that GCC and Clang both emit the index as DW_OP_constu
  (Namhyung, Sashiko).
- Fix die_find_virtual_func() to return the function DIE instead of
  the DW_TAG_inheritance DIE when found in a base class (Sashiko).
- Follow only the primary base class chain in die_find_virtual_func()
  since non-primary bases have their own secondary vtables, and skip
  an empty base at offset 0 which is not the primary base.
- Add die_get_vptr_class() to find the class of the vtable pointer
  through base class subobjects, and die_is_vtbl_ptr_type() to
  identify the vtable pointer by its type ('__vtbl_ptr_type').

Patch 3:
- Remove the receiver ('this' pointer) register update after the call
  which was dead code and not needed, and the arg0_reg field (Sashiko,
  Namhyung).  The 'this' pointer lives in a callee-saved register or
  on the stack across the call and DWARF location lists cover it.
- Handle 'call *%reg' by tracking the function pointer loaded from the
  vtable as TSR_KIND_VFUNC_PTR with its return type (Sashiko).  This
  form is common due to speculative devirtualization by GCC.
- Strip the leading '*' of an indirect call operand in call__parse()
  instead of extract_reg_offset() so that both forms are parsed.
- Ignore void virtual functions instead of aborting (Namhyung).
- Keep the existing pointer dereference branch and its fall-through
  intact; the vtable pointer is detected from the resolved member
  type there instead of a separate lookup before it.
- Treat the new register kinds as pointers when saved to the stack.

v2: https://lore.kernel.org/r/20260930210038.196928-1-yzhao62@ncsu.edu
v1: https://lore.kernel.org/r/20260821050207.4517-1-yzhao62@ncsu.edu

Thanks,
Yanbo

Yanbo Zhao (3):
  perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
  perf dwarf-aux: Add C++ vtable helpers
  perf annotate: Resolve C++ virtual function calls in x86 insn tracking

 tools/perf/util/annotate-arch/annotate-x86.c |  77 ++++-
 tools/perf/util/annotate-data.c              |  61 ++--
 tools/perf/util/annotate-data.h              |   4 +
 tools/perf/util/disasm.c                     |   7 +
 tools/perf/util/dwarf-aux.c                  | 282 ++++++++++++++++++-
 tools/perf/util/dwarf-aux.h                  |  21 ++
 6 files changed, 426 insertions(+), 26 deletions(-)

base-commit: 1dc462fc214907671600172280c2e79ef9fe6fcf
-- 
2.53.0

