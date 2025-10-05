Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049F175D53
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688068; cv=none; b=Yk6CleoUMvBFZzZtaHK56SRiANdJrepJ36a8SquHeFMq7XQsiNEm/alrrqnL/x7KXf3PXRXsbRLEqEEdmLtNHEfyLPF3g9iMCO5vYcztKiTB6eBp2tQGg/4hUu90C+BI+iD3eQGETgdHNHlOX8Th5NcI4/qcWg7hXvsxjY1Q3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688068; c=relaxed/simple;
	bh=jKJufSzsIoGcPnz19tjXEcjablrQpmKm53WL7N/ygy8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=eFOhGqiOKEGM7jRmzumutG39BJ048UlIePuhqUyBnJRTAAILozxceqJQpQSuX5hsc3Wd+uz7NArapgw1+AadEP5kqz5VtQeMbpDNHRNHZfh6Zi0qbgeEon9XIWiNAxRa8ptpfnrsHbs4vdwfXnIw1bSJSR8kcAS52v4v+wseVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCYtvh5/; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCYtvh5/"
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-63ba1a12aebso2835225d50.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688065; x=1760292865; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sOkNJ+T+Tdfr45vmGmFX0Mkoori48Hk8UPWsdnH0IUA=;
        b=RCYtvh5/HruTnbS46wxZ/lN0mkE1dKZ2UZaF+17/kkuHmmkDchBMyvUT4ADzsENtfB
         7HCbTtTu4pIB+/YDoFvlBIQMBWSdxE/hPiduAK3WQ338H2xUHvd5++om2HNAKWS2Use+
         1XLTxh1sysZCiXwzSggNDzPkgZuHOjdD+Kif9GjFbBXOGjsaXsSHPlL4ojnmYl+Hfv3P
         x40e8NgeJnp7BdaFlYMhlS1N3KEj6rIWh6I0JVgUJ8+ietw6sSrmPf+2nc6TRpi65ml3
         /W25E9molfTyik+rd9xWGrLbSLVVPSO9czRE7EzPcQj9rZMxA8aFMYrzLVXZ7pT15Wr8
         RLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688065; x=1760292865;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOkNJ+T+Tdfr45vmGmFX0Mkoori48Hk8UPWsdnH0IUA=;
        b=GTIcs+c74p/NvrNf6gv1FkER0L15Gtkaz8o1op3z8kCy/05SJZ9/17VQv1XicovT/a
         IRhH1wHkAPnUrEgpx8LafX0+gsmNJThAFx7nQ9v9hACk740BQ+EaWfyxkpzXB4FS/5+Z
         a0wb4AYBMuV4sayYaLoBQ+aGJbq3vlvjsuBHnZsL4UegqvJNfdP/fVTrkdWMb2KSeuVM
         Sj0tSOCEAMQLUT8i4kG2BGXO/juQlF0pa3PjvhHEUPHwKm3SiYcPN9CEsE/IdIXocu8Y
         Hgc81w7r/+QyYgtUZBkLJm4c2nN2Vyy5NFBQ/bALxT4+NGmvr5IEoek3/Nu4I8N/kcxJ
         Lz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnRK7QXHaviP1Xia5nIlnms21mvB+TztIjMQsJcEwu+AgqoMS6c9CwCkbTpS8zs8az7Rp/03zxiL5Hc1Fw7Tc4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+ThFQUcqjhAmVOUQfdudHCzPAq+ilHp7x2+X5EKB5+TzmCiW
	w7scbCzbGFpBWIaxPKH8vTkqtGfrI5ATpFZP5nBKE28BvMvnbCU4BSpuwaGL9aAhgm5BZ0CdBt0
	PgE/ZWWCTUQ==
X-Google-Smtp-Source: AGHT+IExPa7jt6IjPv1ZghhlDGVqvEx9LAVQg1UNjFhdGHMbp3SUqMPu4Z3IxXaPOIqxEklUHvGMN8/FJJ93
X-Received: from ywbfl2.prod.google.com ([2002:a05:690c:3382:b0:77f:7918:3482])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:691:b0:77f:937f:32be
 with SMTP id 00721157ae682-77f94705f60mr202405377b3.41.1759688065332; Sun, 05
 Oct 2025 11:14:25 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:14:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005181421.2787960-1-irogers@google.com>
Subject: [PATCH v1] perf stat: Additional verbose details for <not supported> events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If an event shows as "<not supported>" in perf stat output, in verbose
mode add the strerror output to help diagnose the issue.

Consider:
```
$ perf stat -e cycles,data_read,instructions true

 Performance counter stats for 'true':

           357,457      cycles:u
   <not supported> MiB  data_read:u
           156,182      instructions:u                   #    0.44  insn per cycle

       0.001250315 seconds time elapsed

       0.001283000 seconds user
       0.000000000 seconds sys
```

To understand why the data_read uncore event failed, with this change:
```
$ perf stat -v -e cycles,data_read,instructions true
Using CPUID GenuineIntel-6-8D-1
cycles -> cpu/cycles/
data_read -> uncore_imc_free_running_0/data_read/
data_read -> uncore_imc_free_running_1/data_read/
instructions -> cpu/instructions/
Control descriptor is not initialized
Warning:
kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
Warning:
kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
Warning:
kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
Warning:
data_read:u event is not supported by the kernel.
Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
Warning:
kernel.perf_event_paranoid=2, trying to fall back to excluding kernel and hypervisor  samples
Warning:
data_read:u event is not supported by the kernel.
Invalid event (data_read:u) in per-thread mode, enable system wide with '-a'.
cycles:u: 351621 362833 362833
failed to read counter data_read:u
failed to read counter data_read:u
instructions:u: 156184 362833 362833

 Performance counter stats for 'true':

           351,621      cycles:u
   <not supported> MiB  data_read:u
           156,184      instructions:u                   #    0.44  insn per cycle

       0.001584472 seconds time elapsed

       0.001811000 seconds user
       0.000000000 seconds sys
```
where without this change only "data_read:u event is not supported by
the kernel." is shown.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7006f848f87a..84e06ec09cc2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -624,8 +624,9 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 	 */
 	if (err == EINVAL || err == ENOSYS || err == ENOENT || err == ENXIO) {
 		if (verbose > 0) {
-			ui__warning("%s event is not supported by the kernel.\n",
-				    evsel__name(counter));
+			evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
+			ui__warning("%s event is not supported by the kernel.\n%s\n",
+				    evsel__name(counter), msg);
 		}
 		return COUNTER_SKIP;
 	}
@@ -649,10 +650,11 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
 		}
 	}
 	if (verbose > 0) {
+		evsel__open_strerror(counter, &target, err, msg, sizeof(msg));
 		ui__warning(err == EOPNOTSUPP
-			? "%s event is not supported by the kernel.\n"
-			: "skipping event %s that kernel failed to open.\n",
-			evsel__name(counter));
+			? "%s event is not supported by the kernel.\n%s\n"
+			: "skipping event %s that kernel failed to open.\n%s\n",
+			evsel__name(counter), msg);
 	}
 	return COUNTER_SKIP;
 }
-- 
2.51.0.618.g983fd99d29-goog

