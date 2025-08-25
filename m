Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56A3287512
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151663; cv=none; b=XZkA8ZNQVmUB4nuThjzJrX4MZukg8GDV+c4qJxqCp9RbErc0o1KpE8qJQqyFhCGJ6+MiAw2G0l7kNg8621cF1TpQlFlArHoTfuhb/mbNHqZ5jBvXY5XaCTAv5Ica91o1ekgL8FBnxWJXBhCZpT9n4pucMWQCVvhcMChef6I0ZmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151663; c=relaxed/simple;
	bh=HcmjyPq+HJ69UUE8MXp8+eJ0FnVp+I6KpsIJwz1NOGU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iE8CcSD2WGjmMn85ylteyGab7nKGQH5oG3ARPVGEIfaTUeyIPM6711M4nPTQzgoSvnbHovDVbcOAFDqIAEQCZUifwI7TUgpvCH2nmdFgDsGnO4f/dnnhQz5obTPxWVgBbxy/wNMlmqDyaszY8FpZjDywzrnDtFdstr+9ULpfeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgB2lfcA; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgB2lfcA"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e870676ac0so1161501985a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151661; x=1756756461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FDZ7rBECUpjb0yUDRUfPXJKV4c4fG0Ag2lJMPqsfsyY=;
        b=QgB2lfcAt7Ochqb0xQu+38tez+ONBRDTdrluaIGNvbjLSRTj4lg/0zWsi2R9HGp5iN
         ksvgjUMxx85ptckWyZpsTqjmLs5ZTP53OpT5E5Et2UauPNwOvSOCpGAvI+skJmNDAFQE
         sShA94jA4FQC/+DTA0C68JTTzEes0nQSun2NVda5rTnVi0nbuICl5cGz/F27BAiM7VH5
         F2XCcUF7iDfIs6igJTyBtqvx079OwpHRjgDZUI97TF5TgQjK7DfT55SN/RZCuAe6lTMa
         XqFdVECcVOsqZY5FKijFb8KeqBZosBMink+YpBsomBH8YGqNqyw/05nvZBPVOa1K0yPJ
         cOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151661; x=1756756461;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDZ7rBECUpjb0yUDRUfPXJKV4c4fG0Ag2lJMPqsfsyY=;
        b=rsJ/Hj7y+43caB71UJYQIDwokr3F8QKRL45K0YsFwKya5CflIovoUv5Mkz1+xynJ4P
         FXgC2RntduyDOhbW6is/T8nj8ExXdQ8t0aDmXqfc9IPJpAHI+4tneyBj42qHr6tnmIMK
         +gRui2b/KixjsN8tBZIbUdm+cnviuNa66kb5bUwFwSs0c2/HRAIxb0zdZJa7IdAownNG
         x6YXuY/F0GuZmOqO9yUu9Ukn6xN5m7oBJj5mZCVoVcZzg1JbdeZkMQhcEbawzMudrOxV
         Q/yn4Asr5dJrgXzT7ajOmM9fmprH37iJyogbzou+VXyluVsV6A2fu+tbZzyCuEtttHti
         DcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR/8+C/r+DXqCWiUlv/sFkwkFEey+BuljSkiOshrc1G9C4JiYRZFCpVmg/15Xd9ss82Fxa1MmRKReCg304USnD@vger.kernel.org
X-Gm-Message-State: AOJu0YyaEILHbJB205vevxdp4P6vKnbRxMaVcRuhlM8I4uMsjiNZCN3K
	kVYsjjp2y2kepo53xvpMOt6uutYZngvTuYL2I7cnHZc+aXvX1X7a8w7z6MMmAIulqp9umpPQymz
	0+ZLpxkvfig==
X-Google-Smtp-Source: AGHT+IFjfzhnSD4J6UI06bC9yT857vkVXOFiqMoQtCRwEtvPZj6aVMZXK+c3UV3wlvT3QXsIw6EeINIRV0cZ
X-Received: from qknpb12.prod.google.com ([2002:a05:620a:838c:b0:7e6:5fba:1a9c])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:45a8:b0:7f4:34c8:18e6
 with SMTP id af79cd13be357-7f434c81979mr93003685a.38.1756151660706; Mon, 25
 Aug 2025 12:54:20 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:54:02 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195412.223077-1-zecheng@google.com>
Subject: [PATCH v2 00/10] perf tools: Some improvements on data type profiler
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've identified several missing data type annotations within the perf
tools when annotating the Linux kernel. This patch series improves the
coverage and correctness of data type annotations.

Here's a breakdown of the changes:

Patches 1-3 fix type matching from DWARF. They address cases with
negative offsets (e.g., from intrusive linked lists) and distinguish
DWARF expressions for variable value or address.

Patch 4 skips annotations for LEA instructions in x86, as these do not
involve memory access.

Patches 5-7 implement a basic approach for register offset tracking
based on add, sub, and lea operations. The register is invalidated when
an unsupported arithmetic instruction on that register is encountered.
While this feature has known limitations and may regress in rare cases
compared to the original, it generally improves offset tracking in most
scenarios.

Patch 8 skips check_variable when the type is found directly by
register, since sufficient checking is already performed in
match_var_offset. check_variable lacks some DWARF information to
correctly determine if a variable is valid.

Patch 9 fixes __die_find_scope_cb for namespaces. I found this issue
when trying to annotate a Rust program. The Die for a namespace doesn't
have a PC range, so it would be skipped. Therefore, we should check a
namespace's siblings and children.

Patch 10 implements support for DW_OP_piece. Currently, it is allowed in
check_allowed_ops but is handled like other single location expressions.
We should split any expression containing DW_OP_piece into multiple
parts and handle them separately.

I have tested each patch on a vmlinux and manually checked the results.
After applying all patches, there are less missing or incorrect
annotations. No obvious regressions were observed.

v2:
1. update the match_var_offset function signature to s64
2. correct the comment for is_breg_access_indirect. Use simpler logic to
match the expressions we support.
3. add is_reg_var_addr to indicate whether a register holds an address
of the variable. This defers the type dereference logic to
update_var_state.
4. invalidate register state for unsupported instructions.
5. include two new patches related to improving data type profiler.

v1: https://lore.kernel.org/linux-perf-users/20250725202809.1230085-1-zecheng@google.com/

Zecheng Li (10):
  perf dwarf-aux: Use signed variable types in match_var_offset
  perf dwarf-aux: More accurate variable type match for breg
  perf dwarf-aux: Better variable collection for insn tracking
  perf annotate: Skip annotating data types to lea instructions
  perf dwarf-aux: Find pointer type to a type
  perf annotate: Track arithmetic instructions on pointers
  perf annotate: Invalidate register states for unsupported instructions
  perf dwarf-aux: Skip check_variable for die_find_variable_by_reg
  perf dwarf-aux: fix __die_find_scope_cb for namespaces
  perf dwarf-aux: support DW_OP_piece expressions

 tools/perf/arch/x86/annotate/instructions.c | 155 +++++++-
 tools/perf/util/annotate-data.c             |  35 +-
 tools/perf/util/annotate-data.h             |   6 +
 tools/perf/util/annotate.c                  |  18 +
 tools/perf/util/dwarf-aux.c                 | 372 ++++++++++++++++----
 tools/perf/util/dwarf-aux.h                 |   8 +-
 6 files changed, 519 insertions(+), 75 deletions(-)

-- 
2.51.0.261.g7ce5a0a67e-goog

