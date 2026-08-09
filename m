Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F83AE19D
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259733; cv=none; b=oe7TRvAdgKe7egREYASxwoT7/tgPBMGdt40VDxmTLe+yJFQDEK4vgwLuchJy/utIhhNaR9GJR/gKXRTxjkFS02CAVsdgKer1QooWowI0OZqhtz5uvqDODQGJbtl3l0UsEGsICabxHDnz6NRaQ4hwt4vtmUADr2HU0PEfAopaqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259733; c=relaxed/simple;
	bh=WqXvWR2hCxFvOgd+6gdprd/n6snSgyVLotq2AlUBaqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c86p0WB/Mvcp0kvjeNHPGM+Iz2oIEB0c19yjmWrCtIjJemWkhan/UjHL203ArOSTLBpE5hya7R8Q1fIF856g3AA/Iz+bsWIJ4jZJFbWrPkblQg3SKcVzyvKepO93fBQS1BjtLEmjaybXNIv9oYrojKK3RHAXcOWH1g1Odxnjcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIO30/1F; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIO30/1F"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so1600142a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259731; x=1786864531; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGltuG+0CYnELP248yw/EDAEAytweOI4Owg75trfZt0=;
        b=PIO30/1FKFlokpDXke58LSvXU6Dq5q99fBGf/V2F6X0TFOBnmBwYFMecEfpXMGVJu7
         haBq3/3TqZHEcryQXpY0IikuAbIDhRzMqbJ1hRUSBKY5dFjQQmQIh2wEK696b2LMz1eQ
         qLoV7mEgJCSnZQpN8vL8smU0cHl8A14ydJCmbUqNpVMKBu/dSZ2nBtYpe/n4th5SNMln
         e+caEObgFsS6nB3Kza4hyXjdBCBXSlqHZJZ4E2rFZgejLOgXD5wIngpQMG18q0E5+kE7
         fDEdLPU2WSevrdapKmDkKvcTltR7Qy39itZWfIzXbsXUDjgi2Cz96YI2LlPRCNkMQyFA
         EE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259731; x=1786864531;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGltuG+0CYnELP248yw/EDAEAytweOI4Owg75trfZt0=;
        b=HRzxCEP4uv+t+tBrm0Fvh4S+zRX9CwR33Dagiu9Hqh7YAO36yULYHMfx4tmqQD+FHi
         3kDU9IYCgeCUi8iARUkOcLtzFtf8TxIDpWT8YNM7Gz57BuksXfsH53u3WTdQF1VkKhnL
         9UTsFIsKDwvCsUlz4GBpwhic6POgF+7RMKR+9Xhv8eA18lJUWxaNurljqAJVJmyXWuBy
         VZyh3CPpq/xycLxe/cH3pzK/AuOW9YMAdV7OPbWC2w6xD1mJnbBTfRhYhI5H2ytQkLTS
         XCk4kGPjwrA23cOd1Dk0wxrnKzMeFaP0Xh/QE19uixfqry1SB/3tskPMDmNdIZdv7mM4
         C8uw==
X-Forwarded-Encrypted: i=1; AHgh+RrHZhhRAlAVM4I312yQnu4MAHxcLOiAyaHrVY58n53dtsEkLEK6u5UyVvnhYbfeZa6DpmOoNCXjasPOQ9hum6hg@vger.kernel.org
X-Gm-Message-State: AOJu0YxXI0GKFolkS9wHHqwh/Q3vhxDdtqnSoLM7LKYbh80NBnso73+j
	OjB+/Ivp2RbdCfHIgdfCOeaArVnA6/u1u+T8tZIjHcxCHNdOcrtCP8TaROrP4WtOR9rap+OWktn
	+z9V2MoT/tw==
X-Received: from dlbdm7.prod.google.com ([2002:a05:7022:6b87:b0:141:c12:d053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:730e:b0:3c3:791e:5e0c
 with SMTP id adf61e73a8af0-3cbce8e5348mr13746989637.19.1786259731293; Sun, 09
 Aug 2026 00:15:31 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:54 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-16-irogers@google.com>
Subject: [PATCH v3 15/15] perf synthetic-events: Fix divide by zero in perf_event__synthesize_threads
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

If scandir() finds no matching tasks in /proc, n is 0. If thread_nr is > 1,
we bypass the single-thread fast path and then clamp thread_nr to n, making
it 0. This results in a divide by zero when calculating num_per_thread.

Handle n <= 1 early to use the single-thread fast path and prevent the
crash.

Fixes: 340b47f510bb ("perf top: Implement multithreading for perf_event__synthesize_threads")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3583a60cc487..0c150193cca8 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1175,7 +1175,7 @@ int perf_event__synthesize_threads(const struct perf_tool *tool,
 	else
 		thread_nr = nr_threads_synthesize;
 
-	if (thread_nr <= 1) {
+	if (thread_nr <= 1 || n <= 1) {
 		err = __perf_event__synthesize_threads(tool, process,
 						       machine,
 						       needs_mmap, mmap_data,
-- 
2.55.0.679.g6767b8d81c-goog

