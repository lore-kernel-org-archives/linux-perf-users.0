Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/6UkiRk"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E78F7
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 18:16:31 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d10f5bf5d9so1744337b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 18:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701915391; x=1702520191; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NsPj5qKC8yO/4S4uTFAVTwLtanN0zO749Ogx8NLNS9w=;
        b=N/6UkiRk3RlTUolRr2U13HbrMbLP6QBYU30cTKCRXAI4Ocat2gS09LcbqVT6mRgBvB
         6lU9Dkd3QOk7YtPtnX192uxmHeBWNSX2QlrfuM+q5eWrgJJtkfvx1a6OAVI6J+dB/kVE
         Q30a9m5s1cWkhMjQbXyCqv+N+0CDaXB6lGVv65oAKbxZiiPLiT0ELxxTNN7fsSAoA82S
         60W2MauRqHl6K996FZNqvwRgkURx8ZzkZkZXymtby186Gi2sMzZUrG/a5Q6Z3sPdla9S
         IrejgCIeRU4erj7B0z6arqj8BYojnf3h0I/EXaAZRGPQgQoIsPEJT30Qg5Wc8SeTGLt8
         nGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701915391; x=1702520191;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsPj5qKC8yO/4S4uTFAVTwLtanN0zO749Ogx8NLNS9w=;
        b=R02iupkyQRZfkkOrRSOY0gXcV5WzB8sFt2KOpbm3kMseoW+6EZKv7BtBHKpLL+JwP9
         I/C4iIuvwLfnZLl2rgz8QVryCjpiAGE+HBnAcWDn+iCtBHnF1hnjtA+zfj6sMC58+wQX
         2L1jhAJUZz2b4Wk84PlKBMaLwXbONAxUAUIacXAbEpEjntuhbpreLwlebgw1xs6dxXQn
         5i3qQh0xtQT2gmciYP2ngJtjRnhY3a1Ydn+65ml5thvuuISiXLDJGznwIxAXGyZhpkls
         dLG3KfMR/409akaZqeC6KznBEzIhVL8G078GkGldYSAmkjB+8TJXBXSfI7m3EWQJAclh
         PVbA==
X-Gm-Message-State: AOJu0Yx4ZZs9/Gjeuh6ccQJGriww46bj4i2X8OkwP/qatwuV4oZiOaDd
	waMtZqyheOLvTD35BPRygGfskQI+Xkxq
X-Google-Smtp-Source: AGHT+IHKrj0RwlDvYvwye9pD9ZReSUK4nwO3Y2DejPuWpye8TRVrJIGwoeP9TIYKuEtMhjsnlPmt8JxE9oN5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:2893:b0:5d3:b449:e58e with SMTP
 id ee19-20020a05690c289300b005d3b449e58emr26831ywb.6.1701915390873; Wed, 06
 Dec 2023 18:16:30 -0800 (PST)
Date: Wed,  6 Dec 2023 18:16:27 -0800
Message-Id: <20231207021627.1322884-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1] perf record: Reduce memory for recording lost samples event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reduce from PERF_SAMPLE_MAX_SIZE to "sizeof(*lost) +
session->machines.host.id_hdr_size".

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
Suggested in:
https://lore.kernel.org/lkml/CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com/
---
 tools/perf/builtin-record.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index eb5a398ddb1d..206110fc2799 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1954,7 +1954,8 @@ static void record__read_lost_samples(struct record *rec)
 
 				if (count.lost) {
 					if (!lost) {
-						lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+						lost = zalloc(sizeof(*lost) +
+							      session->machines.host.id_hdr_size);
 						if (!lost) {
 							pr_debug("Memory allocation failed\n");
 							return;
@@ -1970,7 +1971,8 @@ static void record__read_lost_samples(struct record *rec)
 		lost_count = perf_bpf_filter__lost_count(evsel);
 		if (lost_count) {
 			if (!lost) {
-				lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+				lost = zalloc(sizeof(*lost) +
+					      session->machines.host.id_hdr_size);
 				if (!lost) {
 					pr_debug("Memory allocation failed\n");
 					return;
-- 
2.43.0.rc2.451.g8631bc7472-goog

