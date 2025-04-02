Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464501F3B82
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743634064; cv=none; b=JgsBOGuBpdhhfL7z3vWydy5UjQqFUf5+C9/uATg8uyB38ARatCYnoiCCTirsgS8tr1fhy7fz48aodJYGVK4PyyXAR8HPQNuoBWjXoA1kORQOXqdKgfhi/ZrtltOh+JGqZdXg5IfrKPZcSUa2Ibf1AKKRiW+WZfZGNF4gHryzBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743634064; c=relaxed/simple;
	bh=iPx8nikC+FuJSk+ldq09sm3wLWoporp6/awl0PQSuhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YXLGS8q/N66JJQ0fobd2JXluq0nYP3RMjj6ZnLW0FmkL0BwbbW67t3An4bxeGH047zQaaI3x2Kmk9Xp4bfpZdRYlX0cFCFZfC1wof7Yyjma/GGkvLvWlsJIDHTG2kx9yhWNPYanuxAWKoOLvqb/AIQ+dKbklFZYToqaKPlvQxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEJ5Qt7X; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEJ5Qt7X"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c28e1b1cefso70662fac.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743634061; x=1744238861; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68/tmXqoVz/h69wPliFMFDaCp2yoUaIFTM/ZDFqAtoE=;
        b=OEJ5Qt7Xzjkhunr49BGIkvdmbnpSZqAus1+Yi4ul5Zk+cNlsHC5J2TsVys4F0skXZO
         /Ui1CMe2RWF2Ci/5KIG7J6A3jGZJOmzw8FnlNaB+TuQg0MEbMD5IpB6F/r8c/JLqccK2
         zNIo6KCbny3i+BhDmZJ6A36zOS3iipZKa3Z6A11Iqj/VqGOzLkJoxkiJsQRszDJgExDn
         d7epXoSdc7I5rQjBj9nXCtRXgvsowrKJNSLDqD/u4qHvc30QK+79vJhrIzHXRsgTg9th
         5Xp9npKEOhLp+NXoy4ty3E/QwJy5yLoVRVHYUrb2u1ElSrIqtEcb/C2IADrjOAZhO0Fy
         MsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743634061; x=1744238861;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68/tmXqoVz/h69wPliFMFDaCp2yoUaIFTM/ZDFqAtoE=;
        b=T2ae7epiNr9+P0fkd3WResBJoGDBygWsjhVUQfp4mYMJQGMmlDndXSsQh1tRtE1PCS
         HSFxP8IEKK41DUA/2//+VbUgzOGXVg70UQZgHDekfro7zbHDT3Hqqx/XsEUj3yVwl3Ug
         PEN9qAENN9Iqe2nxiYVDWnUJ7+VSy60Tn/50VGNnZD4TlamsHnF23w9mTLqMEhoieqH0
         XbbPfZF0/Sn34aSZvJqM7Rha8gcREo1jc6idPMIVRwifzcUqEt4EKnC0IVCijoXLAam0
         ZvK9ZZTzHDGXYk9qksWObF+Kaln54p92AOe47zJAx5L+a81HIr58DG8wCY9i+mopFYdw
         2EuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXirQn7rf1c1T5Kd4thNcYSKx9ROzPyJ2NeqzPW5ZZcV8zwpd3jGrnUPmcDXJHSN8MYJ4dClkk+qFzFJqFBc65a@vger.kernel.org
X-Gm-Message-State: AOJu0YwsnAgBq9y8qr08P2fKV98P821YZJpTXgkXxMyrxicNT/QGuRtH
	sFgDB8EOaXi05P0EvU6WuPwX5dgNoIF49H9rgqi1RsU5i/3VbCeIm/rkhoKBUClWAz+NPByEUwE
	/1uUR7g==
X-Google-Smtp-Source: AGHT+IGA0Ci0HBl+mfOaNd2vBxQdSnwZe4pR80XRoe96Pa3B/vXeQYX4GJOxK+O8NWh4Y6U0EUfY6HM9sqwT
X-Received: from oabvs20.prod.google.com ([2002:a05:6871:a114:b0:2c1:5dcb:42ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:a106:b0:29e:5e83:150e
 with SMTP id 586e51a60fabf-2cc60d4f0f7mr2390203fac.27.1743634061447; Wed, 02
 Apr 2025 15:47:41 -0700 (PDT)
Date: Wed,  2 Apr 2025 15:47:21 -0700
In-Reply-To: <20250402224722.88740-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402224722.88740-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402224722.88740-2-irogers@google.com>
Subject: [PATCH v7 1/2] perf record: Skip don't fail for events that don't open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>
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

If all events fail to open then the perf record will fail:
```
$ perf record -e LLC-prefetch-read true
Error:
Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
The LLC-prefetch-read event is not supported.
Error:
Failure to open any events for recording
```

As an evlist may have dummy events that open when all command line
events fail we ignore dummy events when detecting if at least some
events open. This still permits the dummy event on its own to be used
as a permission check:
```
$ perf record -e dummy true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.046 MB perf.data ]
```
but allows failure when a dummy event is implicilty inserted or when
there are insufficient permissions to open it:
```
$ perf record -e LLC-prefetch-read -a true
Error:
Failure to open event 'LLC-prefetch-read' on PMU 'cpu' which will be removed.
The LLC-prefetch-read event is not supported.
Error:
Failure to open any events for recording
```

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
 tools/perf/builtin-record.c | 47 ++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d..00f6a1c23254 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -962,7 +962,6 @@ static int record__config_tracking_events(struct record *rec)
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
 	    perf_pmus__num_core_pmus() > 1) {
-
 		/*
 		 * User space tasks can migrate between CPUs, so when tracing
 		 * selected CPUs, sideband for all CPUs is still needed.
@@ -1367,6 +1366,7 @@ static int record__open(struct record *rec)
 	struct perf_session *session = rec->session;
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
+	bool skipped = false;
 
 	evlist__for_each_entry(evlist, pos) {
 try_again:
@@ -1382,15 +1382,50 @@ static int record__open(struct record *rec)
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
+		bool evlist_empty = true;
+
+		/* Remove evsels that failed to open and update indices. */
+		evlist__for_each_entry_safe(evlist, tmp, pos) {
+			if (pos->skippable) {
+				evlist__remove(evlist, pos);
+				continue;
+			}
+
+			/*
+			 * Note, dummy events may be command line parsed or
+			 * added by the tool. We care about supporting `perf
+			 * record -e dummy` which may be used as a permission
+			 * check. Dummy events that are added to the command
+			 * line and opened along with other events that fail,
+			 * will still fail as if the dummy events were tool
+			 * added events for the sake of code simplicity.
+			 */
+			if (!evsel__is_dummy_event(pos))
+				evlist_empty = false;
+		}
+		evlist__for_each_entry(evlist, pos) {
+			pos->core.idx = idx++;
+		}
+		/* If list is empty then fail. */
+		if (evlist_empty) {
+			ui__error("Failure to open any events for recording.\n");
+			rc = -1;
+			goto out;
+		}
+	}
 	if (symbol_conf.kptr_restrict && !evlist__exclude_kernel(evlist)) {
 		pr_warning(
 "WARNING: Kernel address maps (/proc/{kallsyms,modules}) are restricted,\n"
-- 
2.49.0.504.g3bcea36a83-goog

