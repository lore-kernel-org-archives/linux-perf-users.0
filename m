Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AA43ABD;
	Tue,  6 Aug 2024 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963547; cv=none; b=qxVRa2yUOxHsv3nveH7WSKxHIP11bjkQ5s0LJL1GBoHNY/z0iJ+gQNutRXg6e1XlcQ9M8lVXRtiPoWkeDza6rWUydsB+6hzfN/8sCziiFX3jiYkggJBsyOZnFZXPEYC7p/IVFrkSVpUx8BOlHTNWN0qSr/fIYWnZXRXQ5LREVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963547; c=relaxed/simple;
	bh=qvV8JGLW2dG3LsVakdiuL3cEqYYt8wgtT64hscNRGjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oByqB3UTNqfPffGDEM93ipKhwq5uGWJ7hLIB9wHuAyad+XTYnlAJt1Ge35cLs9f9SWpBeaWDMkcXAbuZz8GxpYpKkjYWzey4ZxjyBAEBYtIWGcTwvrXwUzS79pBAJH1LqUF96Q6XJVkjdd/q/s0maaJkoV6QFy+PW3NWjpXtGs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so120909866b.2;
        Tue, 06 Aug 2024 09:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722963544; x=1723568344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LP89uLPrkrqKPZrtmF0GkPrurXotyMbv3q8lZc21hMg=;
        b=kT5D+hxxzw4n844Y8/ZMO/TrRT5dOQbS1OxxqdEO/LiwL78s3j5xzdIE4OM0pa5MVa
         0UT+RGef28K2ZmWJEVJHRSEHdfhtX8GWnbd1wocfD3pGVSf+T7S1Vr1UTO3fmGWOm+Wq
         Qb9lVw/vu2WVqvv5+okG6KuzpXW5H0RWH98+3+Trg++WYGupOfqNr2aPNYi+UeDp/sWN
         TpZDSpUVWBnYVD5Vw4FrLtfAHIhlUreOzTZ65eaYHm/mJxnFAzvBtQhXzliMCKfRyvuD
         694slJwJnAuZYoBOlHAbT2g3HWiF0KAx6v6Pnv1fZHBxlp+LwFx3VaLNVIu5pN3tqWQQ
         TuQw==
X-Forwarded-Encrypted: i=1; AJvYcCVhJdKhie2Ktd3CM1/Go6MNC+eDpoFsw0f39HkZ/g0hS7n6ALCeICWWZ88XQ0acJIo+WMxrGWx6ODKdM7fKknhLPw==@vger.kernel.org, AJvYcCWr9+NCqxz0o8B8HxXwTvTFKB8GiQJFwZHxJ4hQw6pN0KWexJTmuCYuZhAiOSsmAqbb8pLlG39F1lKdhG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5hQXnRkQMZmFrOvGqSr3WIv2uFbFWI6t7SdFnPmA/IFET5+Z
	CVqmghpO6qGfgT00ZO5KapRVgpmo61lAVzSlymm4z9xP0+7I6iKL
X-Google-Smtp-Source: AGHT+IHAbswMI9BxH8YR9ZDX8JQAr+8YnEzv06RoxpEPlxTeePo/ZszVLZvNdGIUGgyoaZrjQSFGHg==
X-Received: by 2002:a17:906:da8a:b0:a77:dd1c:6274 with SMTP id a640c23a62f3a-a7dc5124d64mr849584566b.69.1722963544050;
        Tue, 06 Aug 2024 09:59:04 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d433e8sm561863966b.135.2024.08.06.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 09:59:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: leit@meta.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sandipan Das <sandipan.das@amd.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v3] perf/x86/amd: Warn only on new bits set
Date: Tue,  6 Aug 2024 09:58:48 -0700
Message-ID: <20240806165848.3397232-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Warning at every leaking bits can cause a flood of message, triggering
various stall-warning mechanisms to fire, including CSD locks, which
makes the machine to be unusable.

Track the bits that are being leaked, and only warn when a new bit is
set.

That said, this patch will help with the following issues:

1) It will tell us which bits are being set, so, it is easy to
   communicate it back to vendor, and to do a root-cause analyzes.

2) It avoid the machine to be unusable, because, worst case
   scenario, the user gets less than 60 WARNs (one per unhandled bit).

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:
v3:
 * Avoid potential false reporting when concurrent execution occurs on
   different CPUs (Paul E. McKenney)

v2:
  * Improved the patch description, getting the benefits in words.
  * https://lore.kernel.org/all/20240731154651.1555511-1-leitao@debian.org/

v1:
  * https://lore.kernel.org/all/20240524141021.3889002-1-leitao@debian.org/


 arch/x86/events/amd/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 920e3a640cad..b4a1a2576510 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -943,11 +943,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	static atomic64_t status_warned = ATOMIC64_INIT(0);
+	u64 reserved, status, mask, new_bits, prev_bits;
 	struct perf_sample_data data;
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled = 0, idx;
-	u64 reserved, status, mask;
 	bool pmu_enabled;
 
 	/*
@@ -1012,7 +1013,12 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	 * the corresponding PMCs are expected to be inactive according to the
 	 * active_mask
 	 */
-	WARN_ON(status > 0);
+	if (status > 0) {
+		prev_bits = atomic64_fetch_or(status, &status_warned);
+		// A new bit was set for the very first time.
+		new_bits = status & ~prev_bits;
+		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
+	}
 
 	/* Clear overflow and freeze bits */
 	amd_pmu_ack_global_status(~status);
-- 
2.43.5

