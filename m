Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED806259CB9
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475302; cv=none; b=NcpeoxXAlhoj5jPvUus2tK5Gcg4HWfyeIN3k1fkquqtzLsAXXK5H6ZByhi8YWJLyslXuv+C5pkK9VZPBNukuePBDXO7izdgPq6ir3YXeZxt7Q/BSL914/uUSDt3s7g2/jIw8xvQgOnImHd8m92ubw4P9nwzBjCrJsNWVN7vYX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475302; c=relaxed/simple;
	bh=gXTJnen5/k7cpoZ23BuEhZhJsM3pfjzHd8tKam8f0t0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AXRF8NPCWfiXUCVR6HIkuNBJ2DiXBxypE/nIBs2QyybNbDIj1tJPvC5J3/kpzhCEzn0xfcr+0T0Uwl33dEE8sA4wxcDvEFP4G71QWXbE8u/ckrf/DClvukr982yn9UQ+V0+Bt1Ja9l7UBHleGB1yBKVrntHRH6rADg3sy+UUgw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQZJ18q7; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQZJ18q7"
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4abb12861cfso47280381cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 13:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753475300; x=1754080100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DDk9iD/I/15mfC7z2yZd+qqbmK63SyY3qkF61lMO7hw=;
        b=QQZJ18q71Swn3pn1i+Rxe4kyr4ifU70cZoNXfZx4nppzyaXlkn9HHNkRvBhpjzkyBd
         MjCELuAKoFziwzwk16CJrFgPcifgqsPnQ6TpcUehkCWiSpxeNsZIZ5ipqZ2SCaFmKE5a
         Joj4wE7ulu9aHYczwY1SAf4eLZr1KNRp1PLmNLeiet/5cH9owYhHbOSu6/rFnQXzpG0P
         DWpOBjkytPV+dUcTZ3GjKjxy/kiw1V/VE2RSnznpcLDutkxlvUp+y/kv9K3caDVm2THW
         djNyanHBrOT2ZeLzLrom5COxtMJxSredNvktV5xA1z2GbF+2bQzOjUgY1+tWrBaHTIhQ
         2t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753475300; x=1754080100;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDk9iD/I/15mfC7z2yZd+qqbmK63SyY3qkF61lMO7hw=;
        b=MHzRteD13FpsIctMR5zqKHa9yTXVlgImGDfXtCKT4IFKI6vqfOJV4Mxid7/uVhhOjB
         qZ+GFLaQBP4QRUV+sxjbTw9y4aoGMF7uTx6V+ZZR58zdXmdQ3L9y7lH9mSGi/0y2+y3v
         whFFDT/XcG+ysctD8P/PfYhTFUbD4F5ps9x6VD36YXyGWUuyHtwXRJfw7k+vS8F5qtlf
         AmnEOaKXom7PJ+oLrjp7u6YeG2rjj0Z6hgez7T7lkndB/2frIfHBaeDHMrblUhTuyKmf
         2cFpabdv0AThaZSzsfzlMws2m3binQoZMZ85IR48G7mIv2NbXuHzhswx5qQawH4royMq
         XYYw==
X-Forwarded-Encrypted: i=1; AJvYcCW0w0izYncy959V01abzRQA/Ekp8njIEJLJZPOrTyik15zKMVMCUBF3Ht98Rti3pvJDgzI7gu3dHLq9JO+ggUA/@vger.kernel.org
X-Gm-Message-State: AOJu0YxUPwbCEQnVA5BFSx5acBt6j31aPCTzeXEv8ybCCAhOKJyU9Goy
	9opLcSVHNDW3EpnGlwjgsGBNgPWxbDBz5l8ZMmlFrMoq5GMRRpQR/rQWnuw6gA3jDx8gDdOJsXI
	FvxDiJq60dA==
X-Google-Smtp-Source: AGHT+IGoW369nQimnMdyOQv3l2inVS2nmeFQHd5UQmHCGbQIndLINbr8efAQFTdyc+N3SnK/40By8NreEylV
X-Received: from qtei9.prod.google.com ([2002:a05:622a:8c9:b0:4ab:cacc:4c68])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:570a:0:b0:4ab:6b08:9dc1
 with SMTP id d75a77b69052e-4ae8ef9bea7mr50798341cf.19.1753475299804; Fri, 25
 Jul 2025 13:28:19 -0700 (PDT)
Date: Fri, 25 Jul 2025 20:28:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725202809.1230085-1-zecheng@google.com>
Subject: [PATCH v1 0/6] perf tools: Some improvements on data type profiler
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I've identified several missing data type annotations within the perf
tools when annotating the Linux kernel. This patch series improves the
coverage and correctness of data type annotations.

Here's a breakdown of the changes:

Patches 1 and 2 fixes direct type matching from DWARF. They fix cases
with intrusive linked lists (e.g, sched_balance_update_blocked_averages)
where type information was previously missed.

Patch 3 utilizes this to better determine the types of stack
variables for instruction tracking.

Patch 4 skips annotations for lea instructions, as these do not involve
memory access.

Patches 5 and 6 implement a basic idea for register offset tracking
based on arithmetic operations. While this feature has known limitations
and may regress in rare cases compared to the original, it generally
improves offset tracking in most scenarios.

Note: I will be communicating from a new email address, zli94@ncsu.edu,
as I will soon lose access to my current email account.

Thanks,
Zecheng

Zecheng Li (6):
  perf dwarf-aux: Use signed comparison in match_var_offset
  perf dwarf-aux: More accurate variable type match for breg
  perf dwarf-aux: Better type matching for stack variables
  perf annotate: Skip annotating data types to lea instructions
  perf dwarf-aux: Find pointer type to a type
  perf annotate: Track arithmetic instructions on pointers

 tools/perf/arch/x86/annotate/instructions.c | 109 ++++++++++++++++-
 tools/perf/util/annotate-data.c             |  14 ++-
 tools/perf/util/annotate-data.h             |   6 +
 tools/perf/util/annotate.c                  |   5 +
 tools/perf/util/dwarf-aux.c                 | 125 ++++++++++++++++++--
 tools/perf/util/dwarf-aux.h                 |   4 +
 6 files changed, 247 insertions(+), 16 deletions(-)

-- 
2.50.1.470.g6ba607880d-goog

