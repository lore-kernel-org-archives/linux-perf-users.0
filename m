Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8D38239D
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214999; cv=none; b=EVmvBbZqalvuTBrDRlr7rZQmlsfAVaAWhw4/eJI+SyoutPdhiQtcDNbUWxpLAXxxwG1gsBwdeAZTR7onsEs1MgtRcT93HFbKsJmWatu4etXM/Bnof8qooHAVqBBgTxxy0d1y2ySE+mRqVmL9z3kuiamJYVdBjCeH8gyNTx3x0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214999; c=relaxed/simple;
	bh=8+AFBCqV50CvAzgL/OeyVKcvwuj1ZADaaBB8nMZQAJ0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N2ziLp6IKQ3NDhRhCk5T0aaO4QT/jXhS8ibpkiFmJQ3I8brBq3l5D+ReLpn2yMEwSGBhrxWPyDq+Y/wHLEseuKTaxNSLD9RaxjjnhslfTvAyGWlZHFJiADBnMjXcC6l/tntq9+hB3rFYnwdBgqzfxtKr7bej8L7OqJFNl9w8x1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JerskMXy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JerskMXy"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8421ffff8a3so415240b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781214996; x=1781819796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G0lIB6DRyNVYwbBUxfsPqRD5ne6WkZNtjn+NqllxKh0=;
        b=JerskMXy3iZnW5aQod8QvwWHfFFVoDLtbRtGcfKcD0wg4ournZmwl1GSXmmoVRcwJt
         Su81GxR3eTNEc4+zKOy3Z2VvGpknidkJfC/7MzgrCSJLb3GnCyI7K8/2ckHKki8FZWBV
         7ZVelNMOM9kiFDuIWY41UKtyDuMc1qMvlC4XnjgxYewLuiOIUKOFfZZzjgB2CWs9soTn
         P1oNW2t9/8uR4HM5PE1jNF8UpF/J2yD4yR4wkH6tlYPyIRjMhf146d9DUHAizZdxqZQh
         ebMmpUlHMI/C51T6CTPL5zOnfPLzW5yyjPg7LNTqXkXvZcaiO7jGLglChmvVyS4bsvc/
         0ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781214996; x=1781819796;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0lIB6DRyNVYwbBUxfsPqRD5ne6WkZNtjn+NqllxKh0=;
        b=KNdaDZYJUvMVY4iSt6wfvQ+2Ce4PKhzCekJYNux/jNqTiLtSsZaIM/worF55RuCdKw
         0XH+6cvPmTA/SdFnwZ7PEibbNm4ODf9+bx7Rd3nS3WKSLDjvlv9vrMN2MF9gBLfojuW2
         ir+h03TQnPUjwmN2xmqiNBLRJj3b7ecnfehFHDIt665P4x5+P6QeJDAc37Bf6YAbYvSC
         lEs9Pp3+alF21FP6Y95I03YM/uIR0sY/7adQ3hsnlaW5PMy75sGRhPoUtk5vgMX+WuS0
         LQGLXZQxV+4tAw/AWMR9ylwRGqxwEJ6bdDKQlYctXWEiDQexx7kwI++x1g0LkV/wQZEF
         Pqfw==
X-Forwarded-Encrypted: i=1; AFNElJ9MYcSZl3ltd8c/o0bSa42TTlhyL/NSrN8xbhC4C+aRkd9LxYDx0YD5b7jTQeqJFKB1IJlHZpGXMSJQpM1FPRg8@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBTIR/FLcHAvG0vSxzolTiaC7R6x7PEcb/ahd8KH1WmTbfytk
	33i74TzZb+jtXXb7xRpLasC3D7U+hcQVxgJiMwBg7sN5qm67/kdeiistHsIQdzyzJzEMEjvebFY
	vU57PAw==
X-Received: from pfbk12.prod.google.com ([2002:a05:6a00:b00c:b0:82f:d8c0:fef8])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3ccc:b0:83e:2c38:f5d5
 with SMTP id d2e1a72fcca58-84336a8c7a3mr5110885b3a.28.1781214996216; Thu, 11
 Jun 2026 14:56:36 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:56:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611215632.562900-1-ctshao@google.com>
Subject: [PATCH v2] perf stat: Fix false NMI watchdog warning in aggregation modes
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

Furthermore, the NMI watchdog only reserves performance counters
on core PMUs. Uncore PMU events (e.g. CHA, IMC) are not affected
by the NMI watchdog, but their failures also falsely triggered
this warning.

This warning was originally introduced in commit 02d492e5dcb7
("perf stat: Issue a HW watchdog disable hint").

To fix this, restrict setting of print_free_counters_hint to
only trigger for core PMU events by checking counter->pmu and
counter->pmu->is_core.

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
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 2b69d238858c..0a5750bb59fa 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -821,9 +821,9 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		ok = false;
 
 		if (counter->supported) {
-			if (!evlist__has_hybrid_pmus(counter->evlist)) {
+			if (!evlist__has_hybrid_pmus(counter->evlist) &&
+			    counter->pmu && counter->pmu->is_core)
 				config->print_free_counters_hint = 1;
-			}
 		}
 	}
 
-- 
2.54.0.1136.gdb2ca164c4-goog

