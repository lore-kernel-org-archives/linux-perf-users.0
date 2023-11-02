Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71C20B0C
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0JC1pR9N"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB7BD7C
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7d261a84bso17649867b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947899; x=1699552699; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5PgdsnPH7oI10azUBd0z2aRarT0oGQNjgB7Dvx0Ne0=;
        b=0JC1pR9NC+wjbC7AoiPY/Rd2b0kYe/RInF1IQEjZSYwlobCeoKmMIriyHU/i3D//Ek
         rIqQOyxjbCzCw7duHKXj9bfmlQAsWfoD3pCEE/MX9M95nIaPydlj5xZYHq4tGK59tLdB
         ZoXcb7Z5damA8LnffX8SLcHMD3YFgHnbihXd6VTXcrZI/Rftu0k0ee4n61/B5VaajnCZ
         oSAx8NafXUvkLfe7CiE+R6XQCsxExi4VsgXL+Qqan+NcVR4YppdKvM/5oZr2tRVQAEAl
         1pKg/qpDKSPkYqYM2GLIRJCCadCTmXy6f+cVmZRHQ/LFKyIkzIt4tMxTHCYoPpQoQAEA
         viCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947899; x=1699552699;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5PgdsnPH7oI10azUBd0z2aRarT0oGQNjgB7Dvx0Ne0=;
        b=ByTw2GQO8tcbV1eySD2aX8uv/0rrEF5uI3ILEh0tlIVS3IFDYT9TbezNxnwQtjU6Ei
         WzRK9HgyySkdAHrFIEoDXZse0Ap4J8mBjNZYH0LuKEHRd4WsmBBvsuArReS6Qh265Szr
         gSJPRqtXI5QKfSKfuzeWk4oH1OOdEZK1XFiWrWwSWKNA51VtbES4ZpkiXYXeXf4tIOof
         20olamQJfWvFe6lk3wmrMKeWfg0wbIxlQR8+KQDK1YCmZ1msp51YpgvKMAovE85fkgRy
         B/WtEeG5/jG1e6HuD+G+BHkmssJuMykRJdZmLRYdbCBEBWegqpZnjS6qmGNSBs9S63j0
         laiQ==
X-Gm-Message-State: AOJu0Yy+gYGwy0RNEE0xRw9evkXgXTcf7YreBvumDPnUAHGCCZ9HDNXb
	75oT/tVQFwPENkqPIrG5rFtGDaNrpyYL
X-Google-Smtp-Source: AGHT+IE/xmbYEWKH6RBOQRI171I9yC8HUIHsRXQIAw0gBljxL458sfjGnRwpi9ubJuKxlU9ZGOtOe9IETfdR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:4ed5:0:b0:59b:c6bb:bab9 with SMTP id
 c204-20020a814ed5000000b0059bc6bbbab9mr8387ywb.3.1698947898905; Thu, 02 Nov
 2023 10:58:18 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:56:52 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 10/53] perf record: Be lazier in allocating lost samples buffer
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Wait until a lost sample occurs to allocate the lost samples buffer,
often the buffer isn't necessary. This saves a 64kb allocation and
5.3kb of peak memory consumption.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9b4f3805ca92..b6c8c1371b39 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct record *rec, struct evsel *evsel,
 static void record__read_lost_samples(struct record *rec)
 {
 	struct perf_session *session = rec->session;
-	struct perf_record_lost_samples *lost;
+	struct perf_record_lost_samples *lost = NULL;
 	struct evsel *evsel;
 
 	/* there was an error during record__open */
 	if (session->evlist == NULL)
 		return;
 
-	lost = zalloc(PERF_SAMPLE_MAX_SIZE);
-	if (lost == NULL) {
-		pr_debug("Memory allocation failed\n");
-		return;
-	}
-
-	lost->header.type = PERF_RECORD_LOST_SAMPLES;
-
 	evlist__for_each_entry(session->evlist, evsel) {
 		struct xyarray *xy = evsel->core.sample_id;
 		u64 lost_count;
@@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct record *rec)
 				}
 
 				if (count.lost) {
+					if (!lost) {
+						lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+						if (!lost) {
+							pr_debug("Memory allocation failed\n");
+							return;
+						}
+						lost->header.type = PERF_RECORD_LOST_SAMPLES;
+					}
 					__record__save_lost_samples(rec, evsel, lost,
 								    x, y, count.lost, 0);
 				}
@@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct record *rec)
 		}
 
 		lost_count = perf_bpf_filter__lost_count(evsel);
-		if (lost_count)
+		if (lost_count) {
+			if (!lost) {
+				lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+				if (!lost) {
+					pr_debug("Memory allocation failed\n");
+					return;
+				}
+				lost->header.type = PERF_RECORD_LOST_SAMPLES;
+			}
 			__record__save_lost_samples(rec, evsel, lost, 0, 0, lost_count,
 						    PERF_RECORD_MISC_LOST_SAMPLES_BPF);
+		}
 	}
 out:
 	free(lost);
-- 
2.42.0.869.gea05f2083d-goog

