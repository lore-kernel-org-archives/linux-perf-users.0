Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4D1C7B68;
	Tue,  1 Oct 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791846; cv=none; b=q7gzpeEFCgiI2tyHtAlVUADKZFfClxLeeRcrzYzND+Ez/oggiyaeQn9mNh1TAvmYo+Zfcqp0PQ5U0ZlG1DavnF2AooexeR15UUnyxvYG2vh7RJ0c+CR2DoxC86/IP+YWl/cvsBjnXRS60c4l1zUKCtmPkEnxcPEcf7DHjPsCPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791846; c=relaxed/simple;
	bh=1Dx1gN2k2nOa+Rt58OoTR5fnHwu54Rev2gCbVCrJ/SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sATl43EtzFTRi3HO2SjUqgOUV1c3I/BMVzMcqhZWCmWAjl1L3qWmtOUpm4u0uaw2sqNPmqh1JEqKjr5jM3ffVJQrnSC4dabiA0Umyg2ONYROR4K9zcQYtWsKGXdTJxqhkALVzuOf3I2dgkdTD3z+XXcihS50gUG0t9SPl3NEHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so1222951466b.1;
        Tue, 01 Oct 2024 07:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791843; x=1728396643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dj68yZiPQBnR0TH4Q75P/Z/Ts9MBPlWW2+d5H/Vz/dQ=;
        b=DgYwmK1CxTifHlhrZfaNaaf6aJg8jeAmpSj/zynKEZaHO8pd3uotl8Cm+lp4sJBTEC
         afad4rsGyQ2YKmt/jQlJoCLKJlTS14wGT4EmufkNBIzpFha4wGXOmHvYIQo3G6fTx3oK
         wM2fw7m2ts6cirx4AO70Wi4pKl5eXgw54sHjTOrB3YFVGKmRxQDYeyCPDYAmcONzj3mj
         5k8KVmfmg4bIzzO2y3B7jPlSk5JevKX8NomDHg0aagrh1s+9ZtfvkZ+MwfhCXO+NzJGr
         2eKcck9RaGx7Hial8WsJdqW2DW3zNnwNRVDLTw8JcWAwTn7OK5IAPkpaf9QBSumF/Rkf
         0e1A==
X-Forwarded-Encrypted: i=1; AJvYcCUK0U0QjkFXwyXH+dNZyCoxBnNfeKF3De7t1VCxb2RYRi11/6iyDARi3cLFZqVqhKExITSYQ8hx9S0IB7k=@vger.kernel.org, AJvYcCVlIqAxMgAnqjAv2YeF6pi3yj9nY2XgHpuF+DPxFzI6bA4IHfCH68PjyePKGbfuS/v9KV2TsyY8cfkCJVCKqTk3QA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7bKPmx8zgNr7PqaaL1OkbXKaUZem33ofL2tdLtB6p5QDYFL1j
	NpItXi+n0FFea/mA3WnbJpsWlb67cNqLP/RqJ6Trnf7Ew3yieJul
X-Google-Smtp-Source: AGHT+IEy67YIdI755Oqs8rPTmChwJf8ZQTep1dLvkKsmi5Q7cC9i/FmdAOAo/KcaOUC8fEAgoK93Uw==
X-Received: by 2002:a17:906:478b:b0:a8d:65f4:c7c6 with SMTP id a640c23a62f3a-a967c0853ddmr377768066b.24.1727791842477;
        Tue, 01 Oct 2024 07:10:42 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c58edsm712566666b.46.2024.10.01.07.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 07:10:41 -0700 (PDT)
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
Subject: [PATCH RESEND v3] perf/x86/amd: Warn only on new bits set
Date: Tue,  1 Oct 2024 07:10:19 -0700
Message-ID: <20241001141020.2620361-1-leitao@debian.org>
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
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
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

