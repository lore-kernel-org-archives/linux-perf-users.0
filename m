Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537D1D63F8
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Oct 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945096; cv=none; b=tMgpblwWz1ZwnPt7RVVLnkTsm3HR0yY7HJJExtv1qq+5PzWQcDkLii19Ui0QVEc/CB6hlqPYZAX26zxcg2HQw4SYroc1s8XS8cLQD0UCxa4US1unkwmh1jAMvJtOL3n/RaU6qXK7406ZnVdNlC6zXDVT9TKUksHH3DmKonQwgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945096; c=relaxed/simple;
	bh=XP9mEzAtZ8d2CSIQWX5Go/SHsDroib7XQqauoGKr8OU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hg2IQil0zlBr1S1+TpBS/N4TZITeM6PmlGJn2+2ZK96QBJzy6+2JQD6I3Ost24QUc6s1cOJX0UIUu8QsM6IoakjTyXHpdERkrT5RKxCnur7tGrpz9+KxEQeIJqsb54e6Ld1l9z9x35mF8IfsuMXmFshqEsHmecP0UjEkescKqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UN1zBTtx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UN1zBTtx"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7e0093018so50479167b3.3
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Oct 2024 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729945092; x=1730549892; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2vjrGB7qYjjtCMVzRupcGHYUQ0/euLShZj24B3CAVY=;
        b=UN1zBTtxMuAndSSYb5pZ0L+X0/BdR7yfFw9VE4fyFJPzOfPyWMu9zmmfYMyMR3vzb+
         +j6vQXOtPncWcDByB2OklC+ncpYF+oY8EfJXfKw+v5Vv9nZtRU6RgNz0zdWdvyA3lPKB
         idLdUBAo/2IgpWi0bILMnf5uAT400+sBnHnwsD2GwAbDACVLPX+xQYOlO0qkULgv2rGU
         n1qkKVx1gzDanLBLGlh7b8rLzcda4zSd6JVASNKQhF+o171cV9Z7iT3OxkrdVsbveGtf
         JaM5PxigiJQNba6smDUSFyAde5bPIPJh7rQTEi1WUSDCEIL25hf5Cjm34zNsk9kD6XqS
         JvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729945092; x=1730549892;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2vjrGB7qYjjtCMVzRupcGHYUQ0/euLShZj24B3CAVY=;
        b=BurGmWm8pxtZibQOS57rlh3Pa631xbwTa9qimPoxEVVxa12gLlzeHYRKq5BwSJbJLQ
         u40vPTHDAFOOzynuHmQau+FEwIBnXpyMSWJ3giTfo16GU1H7LXB5eNj+IdZBY636838i
         5iykjvDuF/q16ZsyEenJexYVqzWvYWX3pdqJCi2R305HJ4nCzgH10Sosl+WHg8ezShqE
         E60M1oJJ+czgCg86Gco+R3iGYlXLPKkULHlCZH9eshESoo6JVRukVLHZXmZTQN0ATUAn
         ghkQyDx2loijd+iW3c4nXsxmwmyQrjF3P7isEzF3zptBOiR8oprYhBTdgeYNd1WR1QqC
         LbfA==
X-Forwarded-Encrypted: i=1; AJvYcCVl8wuLwYOFtuHSfhKR4idfQ82utWAwBoAppWRNYmmwNciUs7c/V6lP2Opw83YLgzk6sXuh3ixoocCbEY5PaHkt@vger.kernel.org
X-Gm-Message-State: AOJu0YxdxqyBlbyEXx0I4PD0BU9nQLjbgz5z8XFg4m1sJr8EP2IqWnaT
	qdy5XEoLuaVGzdZp7amrB9GKeOKFtYZJSS3JCiXbtqR/5tyizkgGEpBvtf/lt1EIgp1EGYmiuZI
	dezHkKA==
X-Google-Smtp-Source: AGHT+IEsM/AxBcDGQflFJCepomQhbOJ8k6jWS/Dg9HzPpOvx9YedrkWoKAs2MTNM86jX3dIc4CLHW5uZhQ5E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:4bc4:f7cc:83b4:dece])
 (user=irogers job=sendgmr) by 2002:a25:aa04:0:b0:e28:8f62:e735 with SMTP id
 3f1490d57ef6-e3087854604mr1606276.1.1729945091637; Sat, 26 Oct 2024 05:18:11
 -0700 (PDT)
Date: Sat, 26 Oct 2024 05:17:57 -0700
In-Reply-To: <20241026121758.143259-1-irogers@google.com>
Message-Id: <20241026121758.143259-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 3/4] perf record: Skip don't fail for events that don't open
From: Ian Rogers <irogers@google.com>
To: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
2.47.0.163.g1226f6d8fa-goog

