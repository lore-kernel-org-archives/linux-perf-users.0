Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C037082F
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460821; cv=none; b=HQM2frRenTrt1hVjeuaEv0rmdCcUjSOZQYRBuXFOzI2qI90jTc17j5tVxKe/SUhWilphPlAB8yLtMrhC8Tu/tB/sGpPGKmtpjGuAl8K5/Qh7cKiCpx7DeYQRyu8f0wExt+VYjurYOC61/y3uD1OBM/gBQwLQTvL6SIKgCNP8z2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460821; c=relaxed/simple;
	bh=n9w2lHyBaHMh90Mv5ft01rkntIchm6aO8DYYWUImzSI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=EThRsTzSQ8mXdAgzzHOf8S8xaB8+kijiLTw6Y/HKeYhl8XlM0x4dkZAn1ySnyVf5qiMAgwj8LMLnTAEggUg+SaYpgA4uAR9D02Oj6Fxtz/c5n/RUEdLyegf767VtfvPxUI21U69VrH8BYy+iBiZVAkwfR2rAMra5Rrmr1c5TOyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+1JpJnM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+1JpJnM"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e6101877abso117380047b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 17:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731460819; x=1732065619; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Judfv2fPoYyzswryZaW1u3soz+KrsbfIeWzwfN5wCQA=;
        b=Y+1JpJnM7LWLHRmncI0oGYpKUFCTKuRJqevWHmTCMjMZYOAej4mb/PX1rO0REClD7C
         ApHK+njwQ01Y+NLyijPDdnndWqx2g40Qx5Zq2Mh7y1nMNRPdrbE/UUPwaYFQXR0W3ySc
         6YRqCsjJ1qPlcedYmdzwYxpdwWe47OPSnaUe+i2h/S4K/+rG9JktMQPVJlYM41qLa1O4
         aeGWnMRCjWqB/eP4XZ8lbIlaxt3a7N3C8WkfGYFFA4NOugpiE/QxSR3Em/k4wDIKGUwD
         YhnfX06QKhBxHls5R+XZJtrXfoaVi5f4BDugBYorO0h1NHh5IxwuwoHCbMPhkDNuJeRp
         Vdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731460819; x=1732065619;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Judfv2fPoYyzswryZaW1u3soz+KrsbfIeWzwfN5wCQA=;
        b=kE42hzf7rWxYuAZndq3MbrvAQDibhti8uCs6eEI54JT8G+sj5O453XSSg1HLaE3pT0
         Xdr75G6Jqc/zIpbEFElgYC90IaoeKoecD47QGiuLw7RjUughuX25lrQMbE4Jg5fCJ0j8
         kqMFA5pAiHx3uG45JjMdkN/HTmZJv/b5y/GPBaoxCU6pYLl1fGIWCxJkNFQ62PBWLtbg
         eKpUWZuPvq5rmbjU/tc7NXfdMn8IoB8oLwEvuhS+uB8pAlbeXwutFWlt5JQlwOV9bu7e
         Iyjq+s7bFCtrmI/qlLCP00iIPSknW7hFNFDSsjYaT2AiRZrJ2AL1MW2VP2LTN1HvuvYQ
         mYgA==
X-Forwarded-Encrypted: i=1; AJvYcCVskr4hY9Bwv5dLkNH1IMvBD/t53AVRGmf9tRoc4sULMYjLgCcDK4vQQ5q946F34nefeD1TsY2qvemDwzEOB8VP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iw1b49jBBo+814jwzMrTL37W9IN5zyEg11C0RxLo6Rt9t0fx
	EDsIdmq3RhKhILghjX20Zpv8a05ck8PXXE0c9eiVcCF9l6cebAnFczI2uu3IJcQ9dRQG+pesJQ6
	+YdFqGQ==
X-Google-Smtp-Source: AGHT+IEO2RQDDpW51F8uI7K8/e4j2gKuwfS1YS/fc40tqkrxefg7iH8J1s9ZNxLH1sj7Gl29QxIvEd5IpugF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ba3:1d9a:12e0:c4af])
 (user=irogers job=sendgmr) by 2002:a05:690c:4043:b0:6db:c34f:9e4f with SMTP
 id 00721157ae682-6eaddff063dmr1343747b3.8.1731460817690; Tue, 12 Nov 2024
 17:20:17 -0800 (PST)
Date: Tue, 12 Nov 2024 17:19:55 -0800
In-Reply-To: <20241113011956.402096-1-irogers@google.com>
Message-Id: <20241113011956.402096-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241113011956.402096-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v2 3/4] perf record: Skip don't fail for events that don't open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Whilst for many tools it is an expected behavior that failure to open
a perf event is a failure, ARM decided to name PMU events the same as
legacy events and then failed to rename such events on a server uncore
SLC PMU. As perf's default behavior when no PMU is specified is to
open the event on all PMUs that advertise/"have" the event, this
yielded failures when trying to make the priority of legacy and
sysfs/json events uniform - something requested by RISC-V and ARM. A
legacy event user on ARM hardware may find their event opened on an
uncore PMU which for perf record will fail. Arnaldo suggested skipping
such events which this patch implements. Rather than have the skipping
conditional on running on ARM, the skipping is done on all
architectures as such a fundamental behavioral difference could lead
to problems with tools built/depending on perf.

An example of perf record failing to open events on x86 is:
```
$ perf record -e data_read,cycles,LLC-prefetch-read -a sleep 0.1
Error:
Failure to open event 'data_read' on PMU 'uncore_imc_free_running_0' which will be removed.
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
"dmesg | grep -i perf" may provide additional information.

Error:
Failure to open event 'data_read' on PMU 'uncore_imc_free_running_1' which will be removed.
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (data_read).
"dmesg | grep -i perf" may provide additional information.

Error:
Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
The LLC-prefetch-read event is not supported.
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.188 MB perf.data (87 samples) ]

$ perf report --stats
Aggregated stats:
               TOTAL events:      17255
                MMAP events:        284  ( 1.6%)
                COMM events:       1961  (11.4%)
                EXIT events:          1  ( 0.0%)
                FORK events:       1960  (11.4%)
              SAMPLE events:         87  ( 0.5%)
               MMAP2 events:      12836  (74.4%)
             KSYMBOL events:         83  ( 0.5%)
           BPF_EVENT events:         36  ( 0.2%)
      FINISHED_ROUND events:          2  ( 0.0%)
            ID_INDEX events:          1  ( 0.0%)
          THREAD_MAP events:          1  ( 0.0%)
             CPU_MAP events:          1  ( 0.0%)
           TIME_CONV events:          1  ( 0.0%)
       FINISHED_INIT events:          1  ( 0.0%)
cycles stats:
              SAMPLE events:         87
```

Note, if all events fail to open then the data file will contain no
samples. This is deliberate as at the point the events are opened
there are other events, such as the dummy event for sideband data, and
these events will succeed in opening even if the user specified ones
don't. Having a mix of open and broken events leads to a problem of
identifying different sources of events.

The issue with legacy events is that on RISC-V they want the driver to
not have mappings from legacy to non-legacy config encodings for each
vendor/model due to size, complexity and difficulty to update. It was
reported that on ARM Apple-M? CPUs the legacy mapping in the driver
was broken and the sysfs/json events should always take precedent,
however, it isn't clear this is still the case. It is the case that
without working around this issue a legacy event like cycles without a
PMU can encode differently than when specified with a PMU - the
non-PMU version favoring legacy encodings, the PMU one avoiding legacy
encodings.

The patch removes events and then adjusts the idx value for each
evsel. This is done so that the dense xyarrays used for file
descriptors, etc. don't contain broken entries. As event opening
happens relatively late in the record process, use of the idx value
before the open will have become corrupted, so it is expected there
are latent bugs hidden behind this change - the change is best
effort. As the only vendor that has broken event names is ARM, this
will principally effect ARM users. They will also experience warning
messages like those above because of the uncore PMU advertising legacy
event names.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: James Clark <james.clark@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/builtin-record.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f83252472921..7e99743f7e42 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1364,6 +1364,7 @@ static int record__open(struct record *rec)
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
+	bool skipped = false;
 
 	evlist__for_each_entry(evlist, pos) {
 try_again:
@@ -1379,15 +1380,26 @@ static int record__open(struct record *rec)
 			        pos = evlist__reset_weak_group(evlist, pos, true);
 				goto try_again;
 			}
-			rc = -errno;
 			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
-			ui__error("%s\n", msg);
-			goto out;
+			ui__error("Failure to open event '%s' on PMU '%s' which will be removed.\n%s\n",
+				  evsel__name(pos), evsel__pmu_name(pos), msg);
+			pos->skippable = true;
+			skipped = true;
+		} else {
+			pos->supported = true;
 		}
-
-		pos->supported = true;
 	}
 
+	if (skipped) {
+		struct evsel *tmp;
+		int idx = 0;
+
+		evlist__for_each_entry_safe(evlist, tmp, pos) {
+			if (pos->skippable)
+				evlist__remove(evlist, pos);
+			pos->core.idx = idx++;
+		}
+	}
 	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-- 
2.47.0.277.g8800431eea-goog

