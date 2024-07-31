Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C8442C;
	Wed, 31 Jul 2024 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440830; cv=none; b=TwV/VBAzYNbmULwp7ZcCvwycJ+4jwo+nm+tpk0Qdf3vtut0hC2VEnqDCh3p1b93tSC+Z3qf+N8kmMIYsAoW3Hg2WtqeGpp7+fNd+xysD+xMtWcQcjl+Ge2WaFkgevXdPjeKsZx8GDCn1YEcpz/W01fj6qfoLefTOsH/55ny6t+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440830; c=relaxed/simple;
	bh=feyrEY1Zfg+dmjT7MCG3bYo1GNCkft3KyTakTg2uJLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJr7eYwf+1qjox12Vz1uHzDTAQAVaeCx/3cofvleuEJ4IdydtP4fvQP3nMkys71VSd4CzMWbEMhP9RqJUEBP7DcTQ28FCzH7Buih1VgyF8YEFGCn7q4lbTIMSnvu+HytyrWNLjRieVb8nSiBGTK7ZuCMj1LNu+ciLWGQ+HVouTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f035ae1083so76272701fa.3;
        Wed, 31 Jul 2024 08:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722440827; x=1723045627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDrQe4dUw5iS9NUlEReAh4/Dypu40sTXmpRUhGMtdTk=;
        b=l+mkJiJ5CIhvnpVgSnrZ+iNoMegQWNcaf1PuEMk9zX2iw1mM2UYYNjzUZblFmMJRrK
         wZeAfBrqCQtVmZ8aBACqTZ1jwj6PsL31wyB/z0srjJlXJw+sStoWhQFEJuO633RI00YG
         kJBut4w1oOks7GIkPs2y53fRekQGMHgyT2FV4xsciF7/rGA4x3HE2ujiG29lWil3FD7/
         zEOS/SKI42QGgaB1LSg8D8xNFq1n7+soLsBpVhr0VvjJ3BBO1wrvqDnc/wiP+LtITFA9
         2oXReKHY/KtzNFAlAnYFWbnRcO8oxWoU2vDcVHOXLX4OW5SlaaszTPsb+6erT/nmkZIX
         hZHw==
X-Forwarded-Encrypted: i=1; AJvYcCWIzWz2mRlxn2sBSZQsv7tfmGq532/fycAmJFjXX0xR1HBuQ2Ps2f9KJNGJvPDi9K7pNS1BxRbz5Ea2zsSfkXyf38KuS7/A4epZBYOuRZocj749Hz7sqKKUPU0CadUeJZ36EwEeFicmXvQKe6L+ag==
X-Gm-Message-State: AOJu0YwCMeZ87MLig1pVbG6GSsAHy4qwmmN0h6KWTg6oh2PymjJCMBe/
	vurEGFj1JjICdPIe2y/Hs6qLQp5btxxvcm93v9GLxquBSE/OVzHs
X-Google-Smtp-Source: AGHT+IEkL2sKgObtAnB7hlXPafPNKdyFIgqibAZUbddLBSfCRZ1aY2oOibJ3CK6qpYUGVjh1Wrmvhw==
X-Received: by 2002:a2e:924c:0:b0:2ef:20ae:d11c with SMTP id 38308e7fff4ca-2f12edfb4damr96155701fa.8.1722440826404;
        Wed, 31 Jul 2024 08:47:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b0395sm8918585a12.20.2024.07.31.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:47:05 -0700 (PDT)
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
Subject: [PATCH v2] perf/x86/amd: Warn only on new bits set
Date: Wed, 31 Jul 2024 08:46:51 -0700
Message-ID: <20240731154651.1555511-1-leitao@debian.org>
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
v2:
  * Improved the patch description, getting the benefits in words.

v1:
  * https://lore.kernel.org/all/20240524141021.3889002-1-leitao@debian.org/


 arch/x86/events/amd/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 920e3a640cad..577158d0c324 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -943,11 +943,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
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
@@ -1012,7 +1013,11 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
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

