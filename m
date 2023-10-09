Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AB374FF
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YsxlfECd"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420910D4
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 11:40:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9299cac11aso5588483276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 11:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876811; x=1697481611; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfL4FLU++s9CKjil59t6XdpqiER2jatUC+zl7nbhx6Q=;
        b=YsxlfECdt177X4UMflQL0j0/eiiJ163V49F/TKWFkTlFW+aY45ZLUbU8f6NDVQQigD
         BtRPIKXxexi76R+oVTm1GCgmpGzx9NSFdWZVepRouWnYHynBJuF78cTALiIizRVnr+Ug
         7DFkxBdCvyLYUU6dzWqKmIrjj1k+Bj7M8v5yM7GLYQWHwV6LBCjZEKYGsV6hdXaTETYY
         73ANscnYgCjASWj7H2Mpu5TlecYA/5dlHkVSVO57N1VHBI2ObMLd0xYloJy6U6+Dv642
         Dg3ao67NHSRXvIcx6F+FW5mpUs9l6giCn1/D4ppTJh+jBkCv8ZEb5aaEJYWUejPZuVk0
         o5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876811; x=1697481611;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfL4FLU++s9CKjil59t6XdpqiER2jatUC+zl7nbhx6Q=;
        b=vWv+dwwyEm2EG/k3Hmm13iy2JldSyjNSGF+cUaMAbeSCGjGkWx88sa1F80XD0OyBvN
         BwrfYHMHZfc3JNKekCgCmcYpCIBKupjNdYU4rQHFbhdzpHCrereUzKKhoV8fSimRtey7
         J33Oe9sHvpXz31Do8VW6o7KU7toKTgR2cfDNiZgpBBhbj2g5q+dcqAeogXed1JuyM1HN
         DO0z9h+7V/56/jYBxxXLjCMuI7ODXTIUxn7r2tYAVc4VbuGAY7/w/xFh7gCLnG1TVHjQ
         8MvXyKslODt0j/LI0MuzMSgiX2OoqhNWBT/XorlFbHE7LTK6GMIoxdNsbrmh7xkkKE33
         o+tQ==
X-Gm-Message-State: AOJu0YzViT3PDFxhugK3oAoc3yaKRBw7JBoyyOCuU60NE5rhSUS3Xf5D
	kDK/XY9zbl1yQG0JoTwCaQtg/vKGVt3U
X-Google-Smtp-Source: AGHT+IEgB0ixdKNlygdhv4h59H76SFd7CewMHkUz7uO+EUvepYTGPVZ0JlyDFpg5Eeb38pxoje/eR8ZZskOD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:e74f:0:b0:d9a:43eb:4391 with SMTP id
 e76-20020a25e74f000000b00d9a43eb4391mr17704ybh.9.1696876810948; Mon, 09 Oct
 2023 11:40:10 -0700 (PDT)
Date: Mon,  9 Oct 2023 11:39:20 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 18/18] perf bpf_counter: Fix a few memory leaks
From: Ian Rogers <irogers@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Tom Rix <trix@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Ming Wang <wangming01@loongson.cn>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Memory leaks were detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 6732cbbcf9b3..7f9b0e46e008 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -104,7 +104,7 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
 	struct bpf_prog_profiler_bpf *skel;
 	struct bpf_counter *counter;
 	struct bpf_program *prog;
-	char *prog_name;
+	char *prog_name = NULL;
 	int prog_fd;
 	int err;
 
@@ -155,10 +155,12 @@ static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
 	assert(skel != NULL);
 	counter->skel = skel;
 	list_add(&counter->list, &evsel->bpf_counter_list);
+	free(prog_name);
 	close(prog_fd);
 	return 0;
 err_out:
 	bpf_prog_profiler_bpf__destroy(skel);
+	free(prog_name);
 	free(counter);
 	close(prog_fd);
 	return -1;
@@ -180,6 +182,7 @@ static int bpf_program_profiler__load(struct evsel *evsel, struct target *target
 		    (*p != '\0' && *p != ',')) {
 			pr_err("Failed to parse bpf prog ids %s\n",
 			       target->bpf_str);
+			free(bpf_str_);
 			return -1;
 		}
 
-- 
2.42.0.609.gbb76f46606-goog

