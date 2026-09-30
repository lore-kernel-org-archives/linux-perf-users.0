Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23E2D3A75
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802057; cv=none; b=X1vd869diSY8AI/GfRmwMD48Vd7DLzfr5iHF/s7RiwbcQLqjg8qLEXdnBHlsV2dTjDQLw7jo5CPADIiepXkAWLJFG63415RYXQP1ciVCPmn4YtcXPbUAfH2DLGssN+DIYJWh9IOlPT7EEk2a8MGdKPUtCJ72zS7qAtm4wRWWcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802057; c=relaxed/simple;
	bh=Nt2Zt2tAorHSDhzt5C55ZPuqJBlHslyhuetXMrZ/IPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUaD6HEAog1ka3oWvhMg1SQIEvevr5A3gvbl+k8A7kDrhY+vztUlhFeoVJRfhQjqbAK1OwzV4svTKGg7iZ0NQFo7F4gxWkvbwxmqrMtou5eDDbaQ6dnrLJZIODmCM42CNs2mF9gcEQrbPniiC+CD6lHBNKJmsVvTWx+6tyPz2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=aT7Mnlsa; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="aT7Mnlsa"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93a40a9a01aso17814785a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1790802053; x=1791406853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0AJ+oQEBC5GzEDlhFKDUyUWhaXmDQG+4qYkmuNuAgo=;
        b=aT7MnlsauLxbVoBA/dkIIIZdv4z3apw09/zfQLNS5UDQAtnh88MmiuplJAyxgZjYOo
         E0yFw0DMUK1bIdrAiwKd+Lqk8rqzhztaVmee97I7M0e+QulzHHPEOCxLBFYlLhBEi+5W
         xqo1b8aOAVFi03/quxrhus0a4mVLU4Nd7LJ4W/dWJE1PEpv/z01ccr+qly47+by3I17i
         Muaew6oUT//juqXADg5gMIJQySfF1lV+Uu13qTb64aFcV8Stl25QmTpa5ZoY57tU8dcc
         r+2aQ3sR3cu2szkM4aqotVE/MvG559FM66KKPvQJOu1gbwGnzgRJjhh29hm5LbbplqqK
         abJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790802053; x=1791406853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0AJ+oQEBC5GzEDlhFKDUyUWhaXmDQG+4qYkmuNuAgo=;
        b=m43QxF+ehjA4pHZKfF6ZoSK5kjm3ainFEAMSgk2g2O27ZpMu1Wg0XKM/fmmisgYa3c
         kKNjX/6n567sVQOgS94sRsSdT4emI5Z7mmPK0/U4oxJADloC/fv1kTrgfOlc1Rm29Joc
         alEf7MPNL0kitXDrE3pveWrIMlWOM8Opi/o5kwGpsl+3zIriG4KQ2U0adux91vAhexB0
         XpoO3OwP2kqvnBLoJrva9Wl32jlN3q/pZ+X5sYzqRHG2VoWCCL8mDMqLK7H6MpBwFCe6
         wIAtNnFgMYJURMzZd7O30GTz9lMK7qQpdAOhBswJvKLXvdCra3hPUr3Zos5j9PGkQZOA
         ovYw==
X-Forwarded-Encrypted: i=1; AKwUvBxM6ieLmIeHNos55YhIdk6HLCeFhtJMSVkmIgmdbGeC5VKeJUTSQYyn3Pcc+hXASGR71zimWAcNVNFVrbjdPL6p@vger.kernel.org
X-Gm-Message-State: AFuF++ldoaMKR04DFqGIv44/wIEzDYKPp6dekrG8HWMrFLGYk3fTxlaF
	clhrEQSMciGHrwv8a8Lo894ZIsvTrV1OFeKb+Y9dnTdR60Uk9TW+yQbhp2j2D9nSuw==
X-Gm-Gg: AYBFou2/g7HrxEJ7Y2clucHUhMH591fFpNcsPlQuzmQ1gjyN6TTopbMQ89wY6XMPP32
	6ndpAbU8IaafLKEhOFiKket/K5toPA5p2ZN9v+JEduLTJkuyQEi0bn+26283jRvOwxvBZK/8ZyD
	/PSyivabCpnQyEMPo4S2AJm8JFC/205/nE73jCrRMy8s0M6E3xxQmyfGpi65pe6JbOY0u5cyN3h
	RWltCwM8F38PhJGQIsGmRr5SKNlqTQCWquLh6iIXmB7EJoXzjf3X/DoREdLDK/TN67SwnSZm0Lu
	7RBGI3iFID+4k1H6xITFPLchpNJPf0Lqw857JhL6GgVeBUkPxvGVBuu2WjAmlTcMAeYWC/hZKIi
	EwHfWlp46LWgxirHUKWACdzMgpFR/UtlBP09XF8rsK4xGRqc2xaQit3Hh/aIJq1r731Fm5aRq9L
	SkyxFV4qIIPlYtrJeTG/ya/3ovzWToxfxBhSsJFOUCPk7j7UHH3khCRyPWMc5q2zQBZ1g+02kWe
	pblg/Ccks6iaarolYjkQ6tn4JlimFhLP7YVj3jwyc1utgV5cEOoWz0OkrBGaIuIKMo=
X-Received: by 2002:a05:620a:2956:b0:93c:6e1d:96b0 with SMTP id af79cd13be357-93cb5abb8bemr179840885a.17.1790802051649;
        Wed, 30 Sep 2026 14:00:51 -0700 (PDT)
Received: from flag-System-Product-Name.tail132f98.ts.net ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a579d8sm8580336d6.38.2026.09.30.14.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 14:00:51 -0700 (PDT)
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
Subject: [PATCH v2 0/3] perf annotate: Data type profiling support for C++ classes and virtual calls
Date: Wed, 30 Sep 2026 17:00:35 -0400
Message-ID: <20260930210038.196928-1-yzhao62@ncsu.edu>
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

v1: https://lore.kernel.org/r/20260821050207.4517-1-yzhao62@ncsu.edu

Thanks,
Yanbo

Yanbo Zhao (3):
  perf dwarf-aux: Add die_is_compound_type() to handle C++ class types
  perf dwarf-aux: Add C++ vtable helpers
  perf annotate: Resolve C++ virtual function calls in x86 insn tracking

 tools/perf/util/annotate-arch/annotate-x86.c |  76 +++++-
 tools/perf/util/annotate-data.c              |  61 +++--
 tools/perf/util/annotate-data.h              |   4 +
 tools/perf/util/disasm.c                     |   5 +
 tools/perf/util/dwarf-aux.c                  | 265 ++++++++++++++++++-
 tools/perf/util/dwarf-aux.h                  |  21 ++
 6 files changed, 406 insertions(+), 26 deletions(-)

base-commit: 45d15e89a783a0a279b7a54f9018c230127380d7
-- 
2.53.0

