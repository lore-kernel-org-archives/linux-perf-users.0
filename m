Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE352D29CF
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379380; cv=none; b=nslH9d34Hnd0AZvv7bqF6SKrWDgzLJZzu/gESXmZDSVR8lXluikEXeGtXiCXzV8uKFOa53qp7vXZw/G83u/Zh4LpkL/2lNDqIb60z2s2UJdUlRbrbp7J0/BwQUtTgZllCo36bAakBK7eFJgseR83v5HCPJ2MHzjRM4V7/mKKiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379380; c=relaxed/simple;
	bh=pvxznkq+hys8zJblp1ZOrrG5LoBUEn/OVvQS34+ip3s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TWlFw1R4SVsR+44t9a4JqdnMFLlAnaCoRARkNmT9JWIbrANK5syLztl+4rvqEL7kBbwHAvPPCAmvXrxiEQa0i2PnOdLXAyALiItvx4Y1EKvu4HoZqdwyA1Pm9H1ZrubUyT7zBQmN2632QIkiR5GaBu/acPsJ65b1AzEn549acp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pR+LTfhs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pR+LTfhs"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-73970e51ba2so106388067b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379377; x=1760984177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0/qg8oAdK+icXcLp4Gfs1VZU8AuNfndJBKFEhRGQ/aM=;
        b=pR+LTfhsxi1h9bcN9IniIPV3MfP4tKve7Qt4jA9gcAv8XTPNd2sQ09FyRMr/plVgIc
         ZKxrdTjhAKYx+H/pf33ZEVu6MLSSXWLPW0vAPcuTRlqRN6qc0s6XICevrHJThJcakcvh
         ptrERB0MNjkyYVQ2kz4v5QlhQ0N/FKsloeu6espROcALjsdw8ZnVjPY4EdFSymdkCBXr
         IA29wt0BQU9W97vQ8V2a8jQY20DoqmuVLzhURQlMoI/fFVMqw2AFo4gJ7YBlv7JFDdAe
         UY8aNCsLjKxIvJmZeCJT1Nw+FnB/IrXnQ6QW2lV8z6DG+DgV0q0tuy6FQgtZBbIDJRko
         Nmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379377; x=1760984177;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/qg8oAdK+icXcLp4Gfs1VZU8AuNfndJBKFEhRGQ/aM=;
        b=gqwPFcTDV1MrWw3xmayvRYQlHIrPBAvPyyw2iAIKaQN+lRxWbvECMLiYoNbqssY8gg
         kaVzVmOTa50+opgv4a5nomTaKhZqpvdm/1tl7Fxm9f+iVN9ieeLx2CL7wkjxAW1ECECG
         tCZxrSqYVPtlXmtSJRJYJ2HQcMP1KunRVYXeNdEJZdXUH9aah3Km60/GjQ1zl8edMztI
         Rh6EeqhaAbbV3GH6DRcBUV8VBzA1cnGdjQJ14qZsXK98r9V/cF2WzcXJACaCAlMvv9HU
         pzftKn5FV2eCVHSPrJk//o/Jd/a94zXoW0l+sAaYSrXRCEEFOr0sOMcA+taDqC2LaQY3
         qVcA==
X-Forwarded-Encrypted: i=1; AJvYcCU6du9K4OkV7hY/IYumWRNx9V94pWWeU9zqDkThJl8hzNgKbR0r+w17i2SNgRLorg3KbDbttJGsSSbYbiQWx9tj@vger.kernel.org
X-Gm-Message-State: AOJu0YyVdV9M7XJqrJ5NAxUolpQwdt6Zq/Mj+UXg03L3cEIcyOmP+nce
	AEfscXS52J+8ZBL0QHWbWhqe/v2iVT6M+grUPC3e9JXe9eDHjyKnEuFigX+t3jbXfeWq+Ua/Fms
	Lv4cvCeTWLw==
X-Google-Smtp-Source: AGHT+IGmawFyWoNjo6JcSeaJjkr1v2ihHwbOqDATGMekNk/mLFvkC0XXAqSxtfJUXsgPuBCOL8tUfu61vrww
X-Received: from ybbdu5.prod.google.com ([2002:a05:6902:2585:b0:eb8:8612:62c7])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:e0a:b0:781:64f:2b16
 with SMTP id 00721157ae682-781064f3482mr191682757b3.56.1760379376990; Mon, 13
 Oct 2025 11:16:16 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:15:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-1-zecheng@google.com>
Subject: [PATCH v4 0/9] perf tools: Some improvements on data type profiler
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've identified several missing data type annotations within the perf
tools when annotating the Linux kernel. This patch series improves the
coverage and correctness of data type annotations.

Some patches from the previous version of this series were
cherry-picked. This revision adds new improvements based on feedback and
further development.

Here's a breakdown of the changes in this revision:

Patch 1 skips annotations for LEA instructions in x86, as these do not
involve memory access. It now returns NO_TYPE.

Patches 2 implements the TSR_KIND_POINTER to represent registers holding
memory addresses of the type. We are using the size of void* to get the
pointer size. This could be improved to use an architecture dependent
pointer size, but may require more work.

Patches 3-5 implement a basic approach for register offset tracking that
supports add, sub, and lea operations. The register state is invalidated
when an unsupported arithmetic instruction is encountered. This revision
uses TSR_KIND_POINTER to avoid finding the pointer type in DWARF and
preserves the pointer offset information in the stack state.

Patches 6-8 split patch 8 from v2 with some minor improvements. It skips
check_variable when the type is found directly by register, since
sufficient checking is already performed in match_var_offset.
check_variable lacks some DWARF information to correctly determine if a
variable is valid. I also found it is able to find members for
typedef'd types so I preserve them in match_var_offset.

Patch 9 implements support for DW_OP_piece. Currently, this is allowed
in check_allowed_ops but is handled like other single location
expressions. This patch splits any expression containing DW_OP_piece
into multiple parts and handle them separately.

I have tested each patch on a vmlinux and manually checked the results.
After applying all patches, there are less missing or incorrect
annotations. No obvious regressions were observed.

v4:
Merged patch in v3:
perf annotate: Rename TSR_KIND_POINTER to TSR_KIND_PERCPU_POINTER

Updated patches 1-5 based on the feedback from Namhyung.

v3:
https://lore.kernel.org/all/20250917195808.2514277-1-zecheng@google.com/
Merged patches in v2:

perf dwarf-aux: Use signed variable types in match_var_offset
perf dwarf-aux: More accurate variable type match for breg
perf dwarf-aux: Better variable collection for insn tracking
perf dwarf-aux: Skip check_variable for die_find_variable_by_reg

v2:
https://lore.kernel.org/all/20250825195412.223077-1-zecheng@google.com/
1. update the match_var_offset function signature to s64
2. correct the comment for is_breg_access_indirect. Use simpler logic to
match the expressions we support.
3. add is_reg_var_addr to indicate whether a register holds an address
of the variable. This defers the type dereference logic to
update_var_state.
4. invalidate register state for unsupported instructions.
5. include two new patches related to improving data type profiler.

v1:
https://lore.kernel.org/linux-perf-users/20250725202809.1230085-1-zecheng@google.com/

Zecheng Li (9):
  perf annotate: Skip annotating data types to lea instructions
  perf annotate: Track address registers via TSR_KIND_POINTER
  perf annotate: Track arithmetic instructions on pointers
  perf annotate: Save pointer offset in stack state
  perf annotate: Invalidate register states for untracked instructions
  perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
  perf dwarf-aux: Preserve typedefs in match_var_offset
  perf annotate: Improve type comparison from different scopes
  perf dwarf-aux: Support DW_OP_piece expressions

 tools/perf/arch/x86/annotate/instructions.c | 183 +++++++++++++-
 tools/perf/util/annotate-data.c             | 102 ++++++--
 tools/perf/util/annotate-data.h             |  14 +-
 tools/perf/util/annotate.c                  |  20 ++
 tools/perf/util/dwarf-aux.c                 | 266 +++++++++++++++-----
 tools/perf/util/dwarf-aux.h                 |   2 +-
 6 files changed, 493 insertions(+), 94 deletions(-)

-- 
2.51.0

