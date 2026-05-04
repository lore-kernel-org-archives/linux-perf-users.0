Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042B1DE3B7
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 03:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777866697; cv=none; b=VJng+Iehzrf3pbaR6ePYgJyZJh/3Y5vKUvuT/d+y3UchM9qyv8WjqP2sS4ZmL9oieW2wmpfVBZh4ej8W8off4RbYObriXjBI+QKpwiwKGJ0lnkiRiK12gMQimkeFjmQTOJreCsgkKG5RJpmB/LGor2w9nkcWEUr5DuwgM3rVkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777866697; c=relaxed/simple;
	bh=H+thyKmtM5shs0xAxTpCV2B5F/02Wnm/zzHMxxnv094=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVpU/7gqGcJ9nAxIzouZPOSteufTcKm5QUG8T6outp1LlKLA2yzjjQRf9JlNjmvOiQBXq5UZFZBIQuQWbKYjr0qqC2+iBVDZ95VEazclLUxqa/hN0tbvYaEhWZhhVJ8w/KmPwKjzO8FDEEF13DvVSJwaRZy3IBB9IPeGx92MMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R6abS6yQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6abS6yQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so5904604eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 03 May 2026 20:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777866695; x=1778471495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhGEmXHAygOw6kB0SM38jqU6mcvyiIgEl6cFd3wTMu8=;
        b=R6abS6yQykUzkeP5b5oJfxBqKuARB/ypQPlu2LpmAyHzSu+8Ct8nAybrnd3WvtTHNa
         yEaET5wknE7Bk6M5r9Pi18moN8FagxXD2xZOfmH9JZ31LYYyWT+O30RZSVQ/Ie/zFVnV
         P9qs5967iauxtZC3BLnCr21CYhJXuCVLYf8m+ccUMGbHKfziOBqYsee8m1fFllZjtWcb
         MqS+1IDYsMpU6VM2knVtfNMQKhrhHQ7jXueewlzeLvgAkZPqRU2G5jQD/99RK64ct100
         ZJ5vNXy0JrjQAAz5deLgu54mXQqaHx10gQrOWMdDYwfm01RkIM0Ms6BKu9DGEc79WBWU
         ijKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777866695; x=1778471495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RhGEmXHAygOw6kB0SM38jqU6mcvyiIgEl6cFd3wTMu8=;
        b=NumrFC4t4GpHwnlvbvQmQtZ4XO9ej2JJVpZgvwyiyNTW5yt1FLUnIdBle2XWDQ1kwQ
         m2Yy0kAPxTVyrUoxCnpa6YWJOtJe2Ybg98NG0L9C0qHMCA3Fqw8LD2k+M/sQCWNAsbf3
         zl8f024fHQUff99DYdccaJ2aijRpnsVta7PTK9sTfXpOczgErmKl7WCuDNlmX+/cAVYr
         ZbII0LOqYXnhVJcQarQpWxilYT9aWPf2fV7CkIX4RewK8eQIhYLUheOcr1V4FaPZHlJw
         U6CUSeBG0/+4gb8gr3ywlXisYTjZtqz14s9FBq5zmCLxvc3ooPT2IxPHWUancHcmi7/b
         xcKA==
X-Forwarded-Encrypted: i=1; AFNElJ/v0x617SkcsnCp7lfFrL8ie0BQY9B9lY/Aac0GO0ucrOL+BNp5WfdgEl64z9A07CEtJLY3vqxa6aYsmWH0qvFE@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/5ISCgmB9c71up1u/H1QbBGtwPpFLiVvXc2wHsEFeg2evSk1
	oRse7/Q0h0Pkls7I+CyY3mCiDVdGChJ8VFu4UIxb3PhHgBqpaR0P4oYSHBNMJLFJaUpWpTDdU6H
	NDfPhVTKmPg==
X-Received: from dlaj22.prod.google.com ([2002:a05:701b:2816:b0:12c:211d:3e86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a:b0:128:cf75:42a3
 with SMTP id a92af1059eb24-12dfd81a314mr3130544c88.21.1777866694911; Sun, 03
 May 2026 20:51:34 -0700 (PDT)
Date: Sun,  3 May 2026 20:51:21 -0700
In-Reply-To: <20260425020529.3246331-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425020529.3246331-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504035125.1851720-1-irogers@google.com>
Subject: [PATCH v3 0/4] perf tools: Add inject --aslr feature and prerequisite
 robustness fixes
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series introduces the new 'perf inject --aslr' feature to remap
virtual memory addresses or drop physical memory event leaks when profile
record data is shared between machines. Bundled with this feature are two 
independent, critical bug fixes inside core event dispatching tools that
harden perf session analysis against dynamic crashes and callchain mapping
failures.

--- Core Feature: 'perf inject --aslr' (Patches 3 and 4)

Transferring perf.data files across environments introduces a potential leak
of virtual address footprints, weakening Address Space Layout Randomization 
(ASLR) on the originating machine. To mitigate this, we introduce the --aslr
flag into perf inject. Unknown or unhandled events are dropped conservatively,
while handled samples and branch loops undergo systematic virtual memory offset
obfuscation.

To ensure comprehensive memory and error-path safety, the ASLR tool implements:
- Machine namespaces ('struct machines') to safely interleave host mappings and 
  unprivileged guest (KVM) memory regions without boundary leakages.
- Multi-map anchor key matching ( anchored by DSO, invariant offsets, and PID)
  resolving overlapping split-map lookups.
- Subtraction-based bounds check equations to mathematically secure branch stack
  loops against integer overflows.
- Secure u64 dynamic buffer calculations on userspace stack and hardware tracing
  payloads to prevent wrap-around heap overflows.
- Clean, error-checked skip advancement loops (skipn) past dynamic AUX streams in 
  piped records to maintain stream reader sync.
- Robust OOM fallback rollbacks of transient dictionary keys to guarantee 
  dictionary hashmap integrity on failures.

Verification is reinforced in Patch 4 with a new comprehensive POSIX shell 
suite ('inject_aslr.sh'), hardened against SIGPIPE signal exits with stream
consuming awk loops and robust 'set -o pipefail' assertions.

--- Prerequisite Bug Fixes (Patches 1 and 2)

During development, two core event delegation issues were identified and 
resolved to prevent crashes and data-loss during analysis:

1. perf sched: 'timehist' registers standard MMAP, COMM, EXIT, and FORK stubs,
   but completely omitted registering MMAP2 callbacks. Because modern environments 
   output maps primarily via MMAP2 frames, this caused timehist sessions to silently 
   drop shared library mappings, causing dynamic callchain symbol resolutions to
   fail. Patch 1 corrects this by properly registering perf_event__process_mmap2.

2. perf tool: Patch 2 fixes missing copies of schedstat callbacks inside delegated 
   wrapper tools (which caused segfaults on NULL stubs) and properly initializes/copies
   the 'dont_split_sample_group' grouping parameters to prevent stack garbage from 
   triggering silent non-leader events drops during split deliver streams.

Ian Rogers (4):
  perf sched: Add missing mmap2 handler in timehist
  perf tool: Fix missing schedstat delegates and dont_split_sample_group
    in delegate_tool
  perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses
  perf test: Add inject ASLR test

 tools/perf/builtin-inject.c           |   18 +-
 tools/perf/builtin-sched.c            |    1 +
 tools/perf/tests/shell/inject_aslr.sh |  423 +++++++++
 tools/perf/util/Build                 |    1 +
 tools/perf/util/aslr.c                | 1157 +++++++++++++++++++++++++
 tools/perf/util/aslr.h                |   10 +
 tools/perf/util/tool.c                |    6 +
 7 files changed, 1615 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h

-- 
2.54.0.545.g6539524ca2-goog

