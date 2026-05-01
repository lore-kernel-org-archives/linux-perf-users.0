Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73233F9F2E
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659097; cv=none; b=VBD8DOBHQG5pj/0kU4ipeBvHsgIYgC4y9PCYjLTz6Nlb4h8ds4pvsYS7gtNMiDdjQB6O7inUzDsdjfWsY2rkLV+aVGwAHShel9x0eWiVVyeLfnCFWxejcYZrPSjrRppmHac3rHU9QuAXdtI++z1tA4yOYP4AnHGt1+lPB8mSxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659097; c=relaxed/simple;
	bh=9fej4kK9wp2U/ETbC8DTi3SuVPO684HWUe3Zrf83Nzg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p31zgfGE7iMPBKPCSHykOJnRDXVaitNB/Ciddd/84pXWbwDALNnntw/U6NzP/gnFy6Au2X2KaPtk7M47ame8tL54xO6hiN/xKjoU22NgaPvEhac7R0zso9DdZVYSHU1wVBke2DrCfA2KflQ9HPtDqNRSnQyKlf7JZ2wRpXvyX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ItlyKTIv; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ItlyKTIv"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c91ef7009so8766629c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659093; x=1778263893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j1vpqXUUQ6QQX+eD5shfEcOA8kOEpPDpl3aTbWe27BU=;
        b=ItlyKTIvbsSLXKn7IdbXbcoi4F5x7nN64kxVuIomn/i3pVmzJ+ESxTDWWhfRc+QjOR
         x5tfD3DRnzYBir1FPxTE4vW2ybBU0JQpVoIKyPYt++I7IF0XCQuHiGGYj3kZBjCp5ow9
         RIpFHvS0FW7ETVNWjm4oD1cS1gVa0yz5/fK7/tNf1VtEj5HkdFH4I/UFVYXYOSRGd/cW
         b08x0c937TpiAoPHNISe5U4SlcfbevDKBb+lAT0OPJXP2yL1anFTP/6jvrOychT27sZR
         cQeNbxpHv+9YcGAvAEsCIvkJuKWlGWaFeJgXs121UGR2YwQP6/rRiaiak35o3xrXPsz/
         zuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659093; x=1778263893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1vpqXUUQ6QQX+eD5shfEcOA8kOEpPDpl3aTbWe27BU=;
        b=qmlYCt2Peh2Rt1Xp+N2S0pPOnXJ0bVitwVbkmv5N3emw/xAH9A/tSqXo8UZunkb2e7
         A4rYL9BqnpEBZOovFxTHdcnuVpqOFRjBDR5UnsBys4RlCGhwO5eD7k+oeyUcgFzfilP4
         vbb9t0qaCSSFRnIgYFO30bGkKgxfesuqqYYE7CDSUAovEauNDjhY0YbzXw+V/qv3XNNu
         tkIJUgrp6A98dyGA6zNZrygEv4zEeQeRiKoih6+GqhVl8o/6n5czItOqZSA/ys4dBPsg
         8IW8jZYdvjmvyrXEh3lYy+QOPoPHrD1gQUBLAawAydH8jFSEkKtQd0ZsmDaCHoEUPpzX
         6Zuw==
X-Forwarded-Encrypted: i=1; AFNElJ+gGQ51h+8TYkwAOpPY/0IjVbRTCc9ObXXxus/mr+A+rjsgM4OI+tjsYgFHnxFELVsyKE8evco+AuSsv4uMFCYY@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBv+GaRQ5ZbAAnxpgqVo95cCcPnzmmejOzMlG83gzmvyxNMF6
	0hpdYCT0cbGlmRkaFgouA2tMxPU31KtxONKnc97P2jcoK4FwsiqIK3t/M9AZb6AqVxpR1FqXb9Q
	DY3i98g==
X-Received: from dlai16.prod.google.com ([2002:a05:701b:2710:b0:128:d185:c6ff])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f013:b0:12d:de3e:86ad
 with SMTP id a92af1059eb24-12dfd87fb75mr123370c88.43.1777659092706; Fri, 01
 May 2026 11:11:32 -0700 (PDT)
Date: Fri,  1 May 2026 11:11:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501181129.938256-1-ctshao@google.com>
Subject: [PATCH] perf stat: Check aliases in should_skip_zero_counter
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Aggregation IDs (e.g. sockets, caches) with event zero counts are hidden
in aggregated modes (like `--per-socket`) because alias merging
aggregates counts but not CPU maps. This causes display logic to skip
aggregation IDs not present in the leader's map.

Instead of mutating CPU maps in `evsel__merge_aggr_counters` (which
could have side effects on shared CPU maps), check aliases in
`should_skip_zero_counter` to ensure all applicable aggregation IDs are
displayed.

Before the fix:
  $ perf stat -e amd_umc/config=0xff/ --per-socket -a -- sleep 1

   Performance counter stats for 'system wide':

  S0       12                  0      amd_umc/config=0xff/

         1.000721604 seconds time elapsed

After the fix:
  $ perf stat -e amd_umc/config=0xff/ --per-socket -a -- sleep 1

   Performance counter stats for 'system wide':

  S0       12                  0      amd_umc/config=0xff/
  S1       12                  0      amd_umc/config=0xff/

         1.000879376 seconds time elapsed

`perf test` looks good too.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/stat-display.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 993f4c4b8f44..c12a3405118a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -945,6 +945,27 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 		if (aggr_cpu_id__equal(id, &own_id))
 			return false;
 	}
+
+	/*
+	 * If the counter is a leader in alias merging, check if the aggr id
+	 * matches any of its aliases.
+	 */
+	if (config->aggr_mode != AGGR_NONE && counter->first_wildcard_match == NULL) {
+		struct evsel *alias;
+
+		evlist__for_each_entry(counter->evlist, alias) {
+			if (alias->first_wildcard_match == counter) {
+				perf_cpu_map__for_each_cpu(cpu, idx, alias->core.cpus) {
+					struct aggr_cpu_id own_id =
+						config->aggr_get_id(config, cpu);
+
+					if (aggr_cpu_id__equal(id, &own_id))
+						return false;
+				}
+			}
+		}
+	}
+
 	return true;
 }
 
-- 
2.54.0.545.g6539524ca2-goog

