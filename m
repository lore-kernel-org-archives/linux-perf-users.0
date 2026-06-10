Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05122D781B
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112907; cv=none; b=NfpLeyQIqH0AhAu6WfS8Ux1UAF7BS2KGi7OJVvDdZdoKdStC+l9hPenEB1MbdFVC9450c459bQGO1kEwRZL5rveNiDiAS58kwkKc9SdH/EDaOSSObaOSqm+UJxzpupifuXi1WMexPignaN6VzJQzPDpcEBlTBDLJepkhBcngSjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112907; c=relaxed/simple;
	bh=fPNA7xxEcyLNduJYaPo7nRUDXEgh0ata/81jzJzBMF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KboC3+elNxprMorUDQ6mh0kdpeum7f4Ey+fLQ2KbYZpn68/ocyHSb+xpzPbcGyUOlxbMfGx8hmmFSBoQg4K/nJFvKK6REn4DRJUFpHmHlzrixdcR7eVM3pZ2dogPjm867DoFSjqAp1GVJ7JGjMHQZxMwlHfXMEFBG1YklEa+HUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VEMdUq0M; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VEMdUq0M"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-842446a3851so3417319b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781112904; x=1781717704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7BLkgXTqKvHg4zposqfH/BelDZtbPAFFq1l9yrt8MNQ=;
        b=VEMdUq0M78g35mGfNVuPe6Perezh1K/eH1Pd+RLiQuqv9/Eu9aOQMtpAECIKLsG3Yy
         1hOzgEKMRkmKNMnmWWgshfmwCGRWQ14A3QRbwc7eKa4pip/2foETufpwTPLslctaplLZ
         yeqGujKfVpEdsHzoBRun0ZqgAm7zBWIpPunfXb0OP48QhCi+Jg1C+CZkxiyTrE3/SZRf
         fcN/1f5F1VV8jtbqGkxuX8YSsY8Rs9x/48m0MWIx8nFn2gwAt/QIZxQAhLMB7snwC/6V
         Z3uOx4pMxiNtZL/I5PXprHxDLn/myuW8jqUiJTcCDtAu0Z/I0Fl2BtKxmhdVwaJmaY9s
         lX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112904; x=1781717704;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BLkgXTqKvHg4zposqfH/BelDZtbPAFFq1l9yrt8MNQ=;
        b=ZJwUDL49fz69vtXjvKXwcjN7At2uc1TZHQxOVsX2erPSRPp4ddGlC8nfQHiju/uMD9
         kfoTLlGOlt9xtOpVuULeBShBSNU1myvxS4CuNTmTCC8gdzGdqI2cTNwkaEes8mYP7bXZ
         ZsvcABKysxFz1sFxJJrOkP54Ltm//iJo6tZnA6m8APePRR6ExjJLv2Fldoqz324VFt6+
         YE10ibcjwrW+iBrce7GiSVmuW8zuMxUnQrYvfibE6RVGbejCErnf1Yxip+dBeho+zdea
         nGY+6ATPVq6U90P6cqe2G8I/k43+etdWHPWxuhGf9QXdf58ZsFn0ZdzLZ6fGvYeZkapA
         5Ewg==
X-Forwarded-Encrypted: i=1; AFNElJ9Covm2Kkt6SdMPfT3xFfJzWUCD10CQbjDUhbpyWxQXMcX//SS5z5cidc9c1f/1RzuXr1/vR61TH+0oVUeNElcb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy903jAbf+EOqiMf01h7ov4r3FokruVpdcf66BlvbaI+30omUXk
	/F6TeG0VQj7WA8xCTrhDqjx34u1JGlZCCGQlZRqyYUyKGHlRpzjEzmllSgTJzHO5rWL1SQnT6a0
	t7AtWPw==
X-Received: from pfr9.prod.google.com ([2002:a05:6a00:94c9:b0:842:3697:8685])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21c5:b0:831:7f71:c810
 with SMTP id d2e1a72fcca58-842b0f9455fmr26982078b3a.35.1781112903891; Wed, 10
 Jun 2026 10:35:03 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:35:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610173501.3557522-1-ctshao@google.com>
Subject: [PATCH] perf stat: Fix false NMI watchdog warning in aggregation modes
From: Chun-Tse Shao <ctshao@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

In aggregation modes (e.g. --per-socket, --per-die, etc.), a
counter might not be scheduled or counted on specific aggregate
groups if it was not assigned to the CPUs belonging to those
groups. However, the printout() check triggers the
"print_free_counters_hint" logic unconditionally for any
supported counter with a missing count. This results in a false
"Some events weren't counted. Try disabling the NMI watchdog"
warning.

This warning was originally introduced in commit 02d492e5dcb7
("perf stat: Issue a HW watchdog disable hint").

To fix this, add the helper evsel__should_run_on_aggr() to
verify if the counter was supposed to run on the aggregate CPU
ID before triggering the hint. Additionally, correctly handle
per-thread/per-process execution (which uses a dummy CPU map
with a single -1 entry) by immediately returning true,
ensuring legitimate warnings are still reported.

Example before/after:

$ perf stat -M lpm_miss_lat --metric-only --per-socket -a -- sleep 1

Before:
 Performance counter stats for 'system wide':

       ns  lpm_miss_lat_rem ns  lpm_miss_lat_loc
S0      126                202.3               207.9
S1      126                231.9               259.3

       1.006029831 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog

After:
 Performance counter stats for 'system wide':

       ns  lpm_miss_lat_rem ns  lpm_miss_lat_loc
S0      126                202.3               207.9
S1      126                231.9               259.3

       1.006029831 seconds time elapsed

Assisted-by: Gemini:gemini-next
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/stat-display.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 2b69d238858c..e50557964916 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -792,6 +792,28 @@ static bool evlist__has_hybrid_pmus(struct evlist *evlist)
 	return false;
 }
 
+static bool evsel__should_run_on_aggr(struct perf_stat_config *config,
+				      struct evsel *counter,
+				      const struct aggr_cpu_id *id)
+{
+	struct perf_cpu cpu;
+	unsigned int idx;
+
+	if (!config->aggr_map || !config->aggr_get_id)
+		return true;
+
+	perf_cpu_map__for_each_cpu(cpu, idx, counter->core.cpus) {
+		struct aggr_cpu_id own_id;
+
+		if (cpu.cpu < 0)
+			return true;
+
+		own_id = config->aggr_get_id(config, cpu);
+		if (aggr_cpu_id__equal(id, &own_id))
+			return true;
+	}
+	return false;
+}
 static void printout(struct perf_stat_config *config, struct outstate *os,
 		     double uval, u64 run, u64 ena, double noise, int aggr_idx)
 {
@@ -822,7 +844,8 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 		if (counter->supported) {
 			if (!evlist__has_hybrid_pmus(counter->evlist)) {
-				config->print_free_counters_hint = 1;
+				if (evsel__should_run_on_aggr(config, counter, &os->id))
+					config->print_free_counters_hint = 1;
 			}
 		}
 	}
-- 
2.54.0.1099.g489fc7bff1-goog

