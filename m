Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CA12C466;
	Fri, 24 May 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559831; cv=none; b=PHttadKKZaVawMw3UlOxjqH3ebEIfYqHVkoYJ4L7Z5weUCInG++YF9fImKlf2WDFwtXmEVwljQPpoCej6mlZ8H5Df6VeNgtYHzPAHGDZyh9DYmEjAMA9et41BUXAyOK6sjwwnzD99fqPZ5JnGabXxfAcy3aRVggMLnMDz7hOL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559831; c=relaxed/simple;
	bh=GAlzwlQOD1Sk8N6PRgb6Q9JatX+C4h7JsGn1KatYt3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAQ8GfbzRxNqG5lrwyPgMdFXDRqyytR9CqAqeJ99TufzpcvMBdDrJbIp7u8B5tUdRTiky4a2gsfCsXEXcNWdN7FfUs6WG5ATUU+ghjw60Am+COLzMsFbbZ0IqcSCj+73y8CsZdOO+DOn5H+6MtI25Waf9C6A4PM0Ofs93BeIID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57852015f19so1499786a12.1;
        Fri, 24 May 2024 07:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716559828; x=1717164628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4BCz6AMR+p4pjnNjlT2dYabrA3IFmEG66/vZYA0VK8=;
        b=rFImpfdk7/sln3CfSZXVre+qjJqvupyrtpywPGeFWjK9yHU5pcHvlLU0pcF6EhwhJq
         YMKLvrxz+/tguc4aGv2ZC4UalkVT6Z2rmshCTK3EHFPGDmadl5a/TkGlWew7471o1PK3
         uEZVDGr6bYt2QPY4VK1xke5V0y7/C8YHJVKhE6QzmcW/BuVCGtZJCOMBpqZDCSEVC5+d
         1LZqN85gsS74qPC5WJ9R0bMMZgRPe0iAytpVNX03b4Y6sU8AfezQCsqo2E9nMbm2+YMs
         tqEf7HaiSq5q7YsbX3mOx/8+kstBYXqca9nqcCSoyDuLlHW3AmWjvaese4sFFj6RZ1bk
         fXTA==
X-Forwarded-Encrypted: i=1; AJvYcCUow00LT6wTselz88TN4QaFzUAAYHGN47wZiDHiIBx8IC7eGDfOszWPzPHptQMcdIH0JPzcXrYxsjrZyM5jnDkT+elqYA7shvvJDMhQrKYA5EMilRzXP0Y/MvCtoifb5OhmcR5GAESu1jFboWBZiw==
X-Gm-Message-State: AOJu0YxeBR4IyzXUimt5FCY/ZbA2dOvRm+dO53OZODVJ1DoPNYcQqT14
	fKnC/s5pOAAHvFqsUKbBQTUgLZOW6ArPPDGZEZb09q5J/EPkZ0ry
X-Google-Smtp-Source: AGHT+IFHXBDLAJjViFEsNbKr2wJ20cISr9KVjGUHeVjhX3Wg8qPQoA8SS7XsQ/cwsQ0tvkPtvnSbEQ==
X-Received: by 2002:a50:8d4c:0:b0:572:3fac:e085 with SMTP id 4fb4d7f45d1cf-57843f1589fmr4900893a12.13.1716559828072;
        Fri, 24 May 2024 07:10:28 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785233c3c7sm1757666a12.10.2024.05.24.07.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:10:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sandipan.das@amd.com,
	Peter Zijlstra <peterz@infradead.org>,
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
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf/x86/amd: Warn only on new bits set
Date: Fri, 24 May 2024 07:10:20 -0700
Message-ID: <20240524141021.3889002-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Warning at every leaking bits can cause a flood of message, triggering
vairous stall-warning mechanisms to fire, including CSD locks, which
makes the machine to be unusable.

Track the bits that are being leaked, and only warn when a new bit is
set.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/events/amd/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 1fc4ce44e743..df0ba2382d13 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -941,11 +941,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
 static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	static atomic64_t status_warned = ATOMIC64_INIT(0);
+	u64 reserved, status, mask, new_bits;
 	struct perf_sample_data data;
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled = 0, idx;
-	u64 reserved, status, mask;
 	bool pmu_enabled;
 
 	/*
@@ -1010,7 +1011,11 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	 * the corresponding PMCs are expected to be inactive according to the
 	 * active_mask
 	 */
-	WARN_ON(status > 0);
+	if (status > 0) {
+		new_bits = atomic64_fetch_or(status, &status_warned) ^ atomic64_read(&status_warned);
+		// A new bit was set for the very first time.
+		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
+	}
 
 	/* Clear overflow and freeze bits */
 	amd_pmu_ack_global_status(~status);
-- 
2.43.0

