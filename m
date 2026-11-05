Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902806;
	b=GoY7A9EeC/gVSdGFJYXyunm0ghFZYfIMi9fjXZqFZmSfWqApLItrltNcb6KaJQ2mVQqj
	 VRXWRHovnumRYSZ/h7uDteZ1gy4oQQDJjlzaGMfBUWF+ZUxDcinJX8e3IyLWaG19pQ1OE
	 Yl2IdvZyDuV/OmMNehWWk2F42+a4fBrmKcpM42roqe3GHqSUz1gm8A82u7QO0L87PY2OP
	 ouqsq/p9tj3UArMMA08YVemJa9xBzu0MaQFPLZePj47Zeno/6LA4rtT0skoQ530iWisOX
	 K5xgejPveXWOORUuVPM2L5MWj6K/ZgqDJNu5+h0duCd3/vkWctLT2m5EdPpsy/ZSKLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L0ljk8FeWO73U6WHA6b1Ojbu1WCEtX4eQz7Lmk/w0NI=;
	b=xkkre48NRzQ3ipfdT2JKoAScVn3SP8TCrG8RtQ34XD8KCG0d4FMlj0PiLuDwM7h2t1AL
	 ampsQoTBqjar/VOPX85O3nqXQB0kTF6ypWtvvmVB26fMbnK6O7Og7LURKV2PesOaWilZu
	 rhXaC5EFQliN2KxvL9lfhCO7gBItswg0eLKmYcgKA3WnFW3IL346u6Kay0UaPKVpVu+pg
	 mMP2ILnXeFXjBDbamkYhKaa6ULt02+D2N3W8A7s4QWsdrlPWAvRaiEvseN7PSvOX//ljK
	 Rej5O0IIe5rTXPHn/9oU2Pg6R4b96znvnIiMg2ZL/N3y7peV7FOQ2iIvvc6KocpLZyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ncsu.edu;
	spf=pass smtp.mailfrom=ncsu.edu;
	dkim=pass header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b="AUaZj/ud";
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BC606A31B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 18:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E67BC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ncsu.edu header.i=@ncsu.edu header.a=rsa-sha256 header.s=google header.b=AUaZj/ud
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8871ada1a26so20417857b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1793902804; x=1794507604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0ljk8FeWO73U6WHA6b1Ojbu1WCEtX4eQz7Lmk/w0NI=;
        b=AUaZj/udV+tvdslwuwNIBg2igr6ITKGZr7xZzIIyaKic4LViHzO7tWxVdeMCK80ja4
         iEfeaIZeHCp932r15tl+3I6uu+CqP7S6qxJH8vmNDAVemW3GPdiU3032doUjTUYVBSQW
         rn6FmPVoPmZxKyYbjHotlFeJYZkOTSEtb2XMAGrrbCFkyV7KfI0v1fmB8anh/njpsisq
         K8heM4bLSrkwbpJP5eJLI304zeqjBwrhqjUwAKwV6A98HIYjseAJSbvDWAmwPipP2rzk
         PQ1EovzbWVuA7HW4uXJEEcPa6blSZ2ulnZXxsJgWTVDjf0vz7x2pczjYMRKsVaXP/rs/
         w4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902804; x=1794507604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0ljk8FeWO73U6WHA6b1Ojbu1WCEtX4eQz7Lmk/w0NI=;
        b=yAf3kcLvRB5qgfkCyrgrYTiUQNSlk6hmfX8c3PTYnNkTTOZjGy/XJf4cEoZ6CAJPev
         6GZ9p7d1iUJMd4wEmtik73+htuPDK0sMV/vaZTGySI6RniWP83LMY9SpQdlIjnhAVloj
         3ooX14EW/aA0eG2LY6MABjlR3rxYvsq9dobDJgYsW9JnHnLOM+rhxm77szJ5HK3wpCMD
         yZhmgd33kj9UFhUVvu5OfcaxIpCD0jKXDfr2jX6V/cDCIJhD/Aahz9zjWPEHR8MixgQP
         f83t2k7iFclkJrpEcqeSWUbs45h6wDHJWeony+RS9HTXjgxQ9/UTuEoouw3n0ZmgYFUy
         MT1Q==
X-Forwarded-Encrypted: i=1; AL+hErE+wdclJRwMzn3FKS4PV5USPOiKQIeCQXQiomRsO7feCb4ONBpo45TcyOVePTbBhyH9h6SMNFN+Frc9lUgASHsA@vger.kernel.org
X-Gm-Message-State: APuU4Z/uBfTM1ZBVYQWuMrdjLWDG9CWiTp9PutKPKQZYbzOubpD0B7kQ
	E08RU1AY4jooYhA+WsA5f3C0iojWtE8uFsze8l6tpBOsNSI/eawG612cgQ7MVwflkA==
X-Gm-Gg: AYBFou0kIzMI5MlsuGQiWzbXiMzOcNfeRcfot8WNg2xx5bTRq+o8l6BXgUb79b65daO
	leukBx6/FofNy7ZEJCLqU4yKxgvuxyQsgpO8XUJ8dTp9ZT4auLN7a+2u+XD1+fjdWl+3VHg5OQD
	71doeD5riSMs38fU0r/U0oTKxh6qmwJ+g/l8PRQA79q7WyZ1YdLr8cm6FVR1YLOuyTz+zcpGkCR
	l/REaW5V2yIu2xqZ5Jo5/72rnXlGTZBruzS6tHhF4OGHMyS+UPUV/nK2v8lfSw8PZEpA546ldmp
	5WH24lCn0FRJbqkNLAkL/jbnzfdIXe3eaV1bxZJbkOFczRv7EVzxq4niugCNSBbT9zFy5k60hoW
	39yW9toMyNH0t5czKwHj1BykD+fiIcPsBkLikCeiqptL5ykvjxaQMjP6g9hwgvl4tN/uBn5H9Ls
	/gAtL2MUo3exT4Eq/a170tIDjxMfcIJ1XjJl0rPNfQPhpdxx/WNWwMhY79HTgm0soum9UasPnS0
	1FakGv1H8xzJLw1GCU9hCoWVP1IBqd80iIrhjOikk3AqhydrYy1oh9LF7pO1BLHSumw3eKxZ45N
	kjR1BjECCMm2IRTrb5ZaCn9KHr+KaSTn+z8A1eoOZkddwEprstDcopFODWEiq/4Coya3KbfdJxh
	4E6RzzLfTXdQqZDmA/h9d
X-Received: by 2002:a05:690c:c50d:b0:896:5874:6d0a with SMTP id 00721157ae682-8b2b672150amr120482977b3.40.1793902803487;
        Thu, 05 Nov 2026 10:20:03 -0800 (PST)
Received: from flag-System-Product-Name.tail132f98.ts.net ([136.61.118.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f2d5dsm1492287b3.2.2026.11.05.10.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:20:02 -0800 (PST)
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
Subject: [PATCH v5 0/3] perf annotate: Data type profiling support for C++ classes and virtual calls
Date: Thu,  5 Nov 2026 13:19:46 -0500
Message-ID: <20261105181949.43198-1-yzhao62@ncsu.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
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

Changes in v5:
- Bound the recursion into base classes in __die_find_member_offset_cb()
  with MAX_TYPE_CHASE in patch 1 (Sashiko, Namhyung).  The callback
  argument is now a struct carrying the offset, the nesting depth and
  an overflow flag; when the limit is reached the search stops and
  die_get_member_type() / die_get_vptr_class() fail instead of using
  a wrong DIE.  This replaces the separate patch mentioned in v3/v4.
- Dropped the Reviewed-by on patch 1 because of the change; patches 2
  and 3 are unchanged except for the new callback argument in
  die_get_vptr_class() and keep it.

Changes in v4:
- Rebased onto the current perf-tools-next (v7.4-rc1 based) to resolve
  the conflicts with the arm64 instruction tracking series.  Patch 3
  now uses the common invalidate_reg_state() helper and keeps the
  TSR_KIND_CONST / TSR_KIND_GLOBAL_ADDR handling in set_stack_state().
  No functional change.
- Add Reviewed-by from Namhyung.

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

v4: https://lore.kernel.org/r/20261103155650.269973-1-yzhao62@ncsu.edu
v3: https://lore.kernel.org/r/20261005201010.36493-1-yzhao62@ncsu.edu
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
 tools/perf/util/dwarf-aux.c                  | 316 ++++++++++++++++++-
 tools/perf/util/dwarf-aux.h                  |  21 ++
 6 files changed, 457 insertions(+), 29 deletions(-)


base-commit: 29fd95dbd25cda35ac1e38d096a85809e952274b
-- 
2.53.0

