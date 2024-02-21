Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4643A1D1
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497937; cv=none; b=KDZTVMVNgARx6FDs+qrmVzjD9FV3v3BDWEw7NyDfMT6o7wwu6xe4Lb5Jp86wLTfhqTdS0KsII89Nv9tmjwO4oI/eqC2hLKKaBUeJJzQsRevg9EHwx0pD0vrKp2ESlMjKmoYddOgtGuDj3QMlDaJdIx25UHPrvWth2VlSYu/AV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497937; c=relaxed/simple;
	bh=/6zujSE566bACQeKSvHvMpYeeTA8PlC2Y0AN3XU66zc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=FreJb8J9H8sPWU+HxOiJQI6TAQoTc+J+7FH/dJd7wQt+7dwDN6W2p3qaRP0hNTFWgxFL0PkEslyjmQo4N1G4ZVvJ2kUnsaEHDrk4M7GULFhRwYuH6q11RL+IQf6sYzBKD0FXHvc1ED7Vc+a2yKtfSWoKvFXKT60LKNGYX34fm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fp/fwxhE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fp/fwxhE"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so12781538276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 22:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708497935; x=1709102735; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/pI7AtchfWx5feeWTlX63xH7EqjzW5vpXnx4QlPqwg=;
        b=fp/fwxhEI01Fqx/jks8ALYZtPem7JIH9Lv2V8MUXGgo2PRCpRHXkjL7oo2/ddP2607
         5rSY3Tzh7RQBJoMduCexR5JFm3/nRVTnSOTVGZQnGsX+qKQ0NXy4hE8rDd5Pm6+oSVko
         Hd6mEHrewL9X8vOdVeMoTw+BBqojr9t5OhByVJNCcE3Epwbbm7yYhPYt50fFbsZyMgu3
         BZo3JZh5cYk3DwEyxhx62c7pbIhyy1HeaYviwkgbqPp1C0qVOvJNOLuPHlm6wiSBHTRl
         b/89ulYshwOkdgqQEG6YYxjucxivheF0wmbf0r7UrZS1DocBGB2TJMz/cHdwf3HXHqWH
         uGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708497935; x=1709102735;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/pI7AtchfWx5feeWTlX63xH7EqjzW5vpXnx4QlPqwg=;
        b=pHajJ7TRd7WJtPwM9f2afvS2btW+U+qUFGl+9Wjeivz792jBhN+Z1YUjxdjRRH3n3J
         jb9+1IoawFhoFIQ+7kSa7sp05tEQd8zkhJAbQ1eimQZdD1NXm9bjDDB83BSP9gFROpay
         +yq5pmgBFi0HIzYaOzBS4EAjvVkQ3nO3iptEhcxDNO2yuFoXLPDQsVqHtQKtlBL/L+Uu
         BzAwGFX0/C8xwXQV/2bRGbcEQ9CZarNXP/1o1vM72R1cDD5O84ITi/OkDFTuLW5hziXV
         0cX5rvExOblWPWLEw0DPuJ2JXYk0rOtsT9Zi7UP3Po7gcfcwFBEc7j2O3pdTrJU0ku6g
         blXw==
X-Forwarded-Encrypted: i=1; AJvYcCV4JyMUBus90ZtUCLXRCGPBliGVPr0I8SIUrTZPkzIp8nIKJLEAypcX/KJTS9x+M3OkjcvvEuPlJsdSgU85HLDSJYT1b5k47IXjg+1D3swLfg==
X-Gm-Message-State: AOJu0YxCNdltRbb1+ni4Dz06tRymxR6m2wGGz22rxk/mS56sxoz8Sfux
	J027AniflLmg2ZhhsXWcq8LtS6eChQls7H/7TsBfGYY23jA/PpCdVyFDyzNptDPrID+AXlLRXIb
	eGP2nMw==
X-Google-Smtp-Source: AGHT+IEwYgbJA0O1mFJMicyN/Dg0T7MX19vCpK193t3RzYHu3hebTrqejNfBSKs8JWdQ4ffOe+kV7ZVsQhYl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:1104:b0:dbd:b4e8:1565 with SMTP
 id o4-20020a056902110400b00dbdb4e81565mr5476893ybu.4.1708497935001; Tue, 20
 Feb 2024 22:45:35 -0800 (PST)
Date: Tue, 20 Feb 2024 22:45:26 -0800
In-Reply-To: <20240221064527.4157979-1-irogers@google.com>
Message-Id: <20240221064527.4157979-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221064527.4157979-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v3 3/3] perf stat: Fix metric-only aggregation index 1;115;0c
 Aggregation index was being computed using the evsel's cpumap which may have
 a different (typically the same or fewer) entries.
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Before:
```
$ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

       MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total
CPU0                            12.8                           0.0                          12.9                          12.7                           0.0                          12.6
CPU1

       1.007806367 seconds time elapsed
```

After:
```
$ perf stat --metric-only -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

       MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total MB/s  memory_bandwidth_total
CPU0                            15.4                           0.0                          15.3                          15.0                           0.0                          14.9
CPU18                            0.0                           0.0                          13.5                           5.2                           0.0                          11.9

       1.007858736 seconds time elapsed
```

Signed-off-by: Ian Rogers <irogers@google.com>                                  |
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ae37395f90c0..bfc1d705f437 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1137,11 +1137,16 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			u64 ena, run, val;
 			double uval;
 			struct perf_stat_evsel *ps = counter->stats;
-			int aggr_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
+			int aggr_idx = 0;
 
-			if (aggr_idx < 0)
+			if (!perf_cpu_map__has(evsel__cpus(counter), cpu))
 				continue;
 
+			cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+				if (config->aggr_map->map[aggr_idx].cpu.cpu == cpu.cpu)
+					break;
+			}
+
 			os->evsel = counter;
 			os->id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
-- 
2.44.0.rc1.240.g4c46232300-goog

