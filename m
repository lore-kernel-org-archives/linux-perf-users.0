Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D1365
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Jun 2024 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718082393; cv=none; b=jsAWwxiWUraF1pcxGFflQhvWebJkYmh9p7T5cDaCGN4DAyWU0FKhcsnu0VKDuKihBo3A4rJkp98ooqEg/03g7tSgYIPc4+vr43dn5ogfu8Q6gxdmabl8r6qbAkQhcwmmxnZn0fQ1imXQj1nu1NVALX21gmRxcZQu1Qeogv6SzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718082393; c=relaxed/simple;
	bh=wfNuKcpCIlJrJwk/H9c5ECx+DB/Jmr1J+PH6oJRL3D8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=rOU/yKzRmXQoR8u96hxZDR52Y3TSqwN9Ag93OmbS80Tqv0bwp+N8RgjGMiB+T3+DDoLWQVkzomKBhF3ymIWKUj6PfK0Ah+dEHmi0yTOY42Y7g1USGSLDB6ZBE/Xc9IjFLU+bGAstSIxq8I8q0is5mH+nC+cS2OKepqMLPjZbbUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2F3NPmW3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2F3NPmW3"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df78fddad5dso1134720276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jun 2024 22:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718082391; x=1718687191; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3a15i1kZLc+SlZ1Pt4nlLZoYgpbJp0ryg7Wc92RcD0=;
        b=2F3NPmW3ZmyZrjm4bHPMHH7mOM8vIHsa82heL4MG6HcQaZ5z+zCZzIvcZxToQdEBFK
         g6QyoDYeSrRoeibiKpcaiDxIJRUUaysI3WT/jH4qF3zRmClp1zSK9j3Jj0/1IBY7qXai
         M+TyBZ7gsqoMLT4D8yWWv3NFgSV+Mp+EsN53bRurvfwtJqM1KUL28rpn7o8dCoslSUni
         2MHEKuyQVz0HBnL5vhCoi7FUcAdJ0insN8NegGUhTlEESyyMVmPQJQoue0xNzxKhl9do
         gRbrMIakieJGiuNA5qjGWKWzjhIApppRo0DVNArLIC6Ejn9qX05b6CwDUa23SJ8z/039
         7pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718082391; x=1718687191;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3a15i1kZLc+SlZ1Pt4nlLZoYgpbJp0ryg7Wc92RcD0=;
        b=Ap/d2uZa0FpFptz0OoLEgEeJwhlIAcVrDlg7Kb9tI/n1qRFTv13dKr7p6k/8529bBu
         ZK1nCxSr7+PS2jx8WMZq3eeWSXW/zxafClsk1Cb9lV2HjQewJjp5gTQc+enO/AhaKh6X
         LyI5tlFVJ4xIWOxrLbZK3XT9nmiAJf+7zV5lZoVn7E8VvGO4/IPDzZFB1UYN1ZVyu5Of
         w5iOTo4eBgpDe8ycyIW1wPiS3ePvY8H9c5hLEc6bXwJH7pqxVJBP5sb3KJeOiQigCB+5
         sQdqh/zRY7V4KftFOUaNfn67PBU07pLncznlMY0BkNWNfFizP24Lcc9R+K+MpE/e7Gal
         UA1A==
X-Forwarded-Encrypted: i=1; AJvYcCXxFuaHL3tkvPm48Gd0+WNc9U6XLAKJGP+zj7dk7ePbmbY9tz7BjX4NV06uS5WrULD+lmtF5CLdeY8nGkC/KWW6G90c4XrpFNZTzLDdu4FeCg==
X-Gm-Message-State: AOJu0YyKxGvVQ4Z75C9X0XV+rDkRBUw69wlab8S3JOE5rZw47rc6taMG
	AiMlqtXqGHzDwRDL5ysFtgQPJOkdGf0kZe4i5YRr0QYKYoFuEXzp3odI/WUcVZVHCUq88dp9iWv
	p1K+ChQ==
X-Google-Smtp-Source: AGHT+IGXg6MLzJVlTMjDjK4qpsPZQJg7FjWAtts19sPLfAtFffF1hcAi5jMMDMTnaeXo/9ICiKULSK9UZPeY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b1e:6a57:2401:1e9b])
 (user=irogers job=sendgmr) by 2002:a05:6902:20c5:b0:df7:9ac4:f1b2 with SMTP
 id 3f1490d57ef6-dfaf64ec25cmr3405059276.5.1718082391082; Mon, 10 Jun 2024
 22:06:31 -0700 (PDT)
Date: Mon, 10 Jun 2024 22:06:26 -0700
Message-Id: <20240611050626.1223155-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v2] perf record: Ensure space for lost samples
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Milian Wolff <milian.wolff@kdab.com>
Content-Type: text/plain; charset="UTF-8"

Previous allocation didn't account for sample ID written after the
lost samples event. Switch from malloc/free to a stack allocation.

Reported-by: Milian Wolff <milian.wolff@kdab.com>
Closes: https://lore.kernel.org/linux-perf-users/23879991.0LEYPuXRzz@milian-workstation/
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2. Switch from union to struct and place struct in header to clearly
    tie it to the MAX_ID_HDR_ENTRIES.
---
 tools/lib/perf/include/perf/event.h |  6 +++++
 tools/perf/builtin-record.c         | 34 ++++++++---------------------
 2 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ae64090184d3..37bb7771d914 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -77,6 +77,12 @@ struct perf_record_lost_samples {
 	__u64			 lost;
 };
 
+#define MAX_ID_HDR_ENTRIES  6
+struct perf_record_lost_samples_and_ids {
+	struct perf_record_lost_samples lost;
+	__u64 sample_ids[MAX_ID_HDR_ENTRIES];
+};
+
 /*
  * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID | PERF_FORMAT_LOST
  */
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac661..019305b94e5f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1926,7 +1926,7 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
 static void record__read_lost_samples(struct record *rec)
 {
 	struct perf_session *session = rec->session;
-	struct perf_record_lost_samples *lost = NULL;
+	struct perf_record_lost_samples_and_ids lost;
 	struct evsel *evsel;
 
 	/* there was an error during record__open */
@@ -1951,20 +1951,13 @@ static void record__read_lost_samples(struct record *rec)
 
 				if (perf_evsel__read(&evsel->core, x, y, &count) < 0) {
 					pr_debug("read LOST count failed\n");
-					goto out;
+					return;
 				}
 
 				if (count.lost) {
-					if (!lost) {
-						lost = zalloc(sizeof(*lost) +
-							      session->machines.host.id_hdr_size);
-						if (!lost) {
-							pr_debug("Memory allocation failed\n");
-							return;
-						}
-						lost->header.type = PERF_RECORD_LOST_SAMPLES;
-					}
-					__record__save_lost_samples(rec, evsel, lost,
+					memset(&lost.lost, 0, sizeof(lost));
+					lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
+					__record__save_lost_samples(rec, evsel, &lost.lost,
 								    x, y, count.lost, 0);
 				}
 			}
@@ -1972,21 +1965,12 @@ static void record__read_lost_samples(struct record *rec)
 
 		lost_count = perf_bpf_filter__lost_count(evsel);
 		if (lost_count) {
-			if (!lost) {
-				lost = zalloc(sizeof(*lost) +
-					      session->machines.host.id_hdr_size);
-				if (!lost) {
-					pr_debug("Memory allocation failed\n");
-					return;
-				}
-				lost->header.type = PERF_RECORD_LOST_SAMPLES;
-			}
-			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
+			memset(&lost.lost, 0, sizeof(lost));
+			lost.lost.header.type = PERF_RECORD_LOST_SAMPLES;
+			__record__save_lost_samples(rec, evsel, &lost.lost, 0, 0, lost_count,
 						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
 		}
 	}
-out:
-	free(lost);
 }
 
 static volatile sig_atomic_t workload_exec_errno;
@@ -3198,7 +3182,7 @@ static int switch_output_setup(struct record *rec)
 	unsigned long val;
 
 	/*
-	 * If we're using --switch-output-events, then we imply its 
+	 * If we're using --switch-output-events, then we imply its
 	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
 	 *  thread to its parent.
 	 */
-- 
2.45.2.505.gda0bf45e8d-goog

