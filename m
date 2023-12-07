Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0LC3uUW"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CA0D7F
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:17:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d988d69812so2000537b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911856; x=1702516656; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SY+VZ2g7Sz9SUrig6hGASQIeGQdVI2UxDJkUdRi/lk4=;
        b=f0LC3uUW/cEQraZC/IobZ9ZkfT2/zJsoAuA/0MNe2oMW01UFK78qQwd4PSU7p0eJRo
         DLx3AAIgMYFN4Yne9xVwhS32HXCV7TedGCVR7O2/2n3XafEL7A6Te0r8Dpct63E5pS3o
         4TWlSzI64OP+0iCt3zQjDrqDVLcCGXtYRztkxKEU6BNtUEa1FyVhmt+95/Tr9A28qIvi
         wTWhQlEd/x+i4Q4znhc4uPbkhBt70B5sgfObCTFoWUID36Ygrd4EbCsIvVdwl6zB6muu
         iKcqm5smsc1UmCVMZA1SyznCIc3UWpoCpl/OWj9HX1LlDuKU5yyhy3vI4Zrc8LWymoqe
         JXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911856; x=1702516656;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SY+VZ2g7Sz9SUrig6hGASQIeGQdVI2UxDJkUdRi/lk4=;
        b=GzdRYqzog4YczDqxpLoFEAxXKL1iLcgEPEnTtm63xOORG4vTPGwX4NcchJc5REqfsp
         4Y7f6pJrvPsmrTrduUOUABC6gusG48SUESGofc6anbdysby1GnyKdLzftkSsnNV4/HGT
         n6K+rG9Afr4mG2RXOMOBj/RNWGKfMRPa2oyfAbJ7wjRWs9+bVthXTcaYCbCGMZHl1jn7
         IdnsOb9fzGPZq6J5id/hg3dnSSaUZ1JXUSchXIDSs44+lBcJG0Qbx2YadHZc1LKX2ATa
         DxVf55UUnsDrxWTywCKBarO/LNFZt8G+gfwkvx5wTlAeVD0gASgmFyRX1kjYZnFUjjBo
         22Sg==
X-Gm-Message-State: AOJu0YxuxjDZrl5v0E7pg1wwtknq2uI7zNzN0m5HauZX1tl0llJ8L5kA
	btlHBWCR1+2zAkOi3WOm32MSgdRjiOlj
X-Google-Smtp-Source: AGHT+IGVWPHm9Dm5cf3RddNOyUG7uObFhuAf0TozauBkiT/nzt0KQG+s2iZOiUNbOR/dOOKeFIx+Rr1RWgkd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:2847:b0:5d9:4242:8d21 with SMTP
 id ed7-20020a05690c284700b005d942428d21mr23555ywb.9.1701911856720; Wed, 06
 Dec 2023 17:17:36 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:38 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 04/47] perf report: Use function to add missing maps lock
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Switch maps__fprintf_task from loop macro maps__for_each_entry to
maps__for_each_map function that takes a callback. The function holds
the maps lock, which should be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 54 +++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 121a2781323c..a5d7bc5b843f 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -859,27 +859,47 @@ static struct task *tasks_list(struct task *task, struct machine *machine)
 	return tasks_list(parent_task, machine);
 }
 
-static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
+struct maps__fprintf_task_args {
+	int indent;
+	FILE *fp;
+	size_t printed;
+};
+
+static int maps__fprintf_task_cb(struct map *map, void *data)
 {
-	size_t printed = 0;
-	struct map_rb_node *rb_node;
+	struct maps__fprintf_task_args *args = data;
+	const struct dso *dso = map__dso(map);
+	u32 prot = map__prot(map);
+	int ret;
 
-	maps__for_each_entry(maps, rb_node) {
-		struct map *map = rb_node->map;
-		const struct dso *dso = map__dso(map);
-		u32 prot = map__prot(map);
+	ret = fprintf(args->fp,
+		"%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
+		args->indent, "", map__start(map), map__end(map),
+		prot & PROT_READ ? 'r' : '-',
+		prot & PROT_WRITE ? 'w' : '-',
+		prot & PROT_EXEC ? 'x' : '-',
+		map__flags(map) ? 's' : 'p',
+		map__pgoff(map),
+		dso->id.ino, dso->name);
 
-		printed += fprintf(fp, "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" PRIu64 " %s\n",
-				   indent, "", map__start(map), map__end(map),
-				   prot & PROT_READ ? 'r' : '-',
-				   prot & PROT_WRITE ? 'w' : '-',
-				   prot & PROT_EXEC ? 'x' : '-',
-				   map__flags(map) ? 's' : 'p',
-				   map__pgoff(map),
-				   dso->id.ino, dso->name);
-	}
+	if (ret < 0)
+		return ret;
+
+	args->printed += ret;
+	return 0;
+}
+
+static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
+{
+	struct maps__fprintf_task_args args = {
+		.indent = indent,
+		.fp = fp,
+		.printed = 0,
+	};
+
+	maps__for_each_map(maps, maps__fprintf_task_cb, &args);
 
-	return printed;
+	return args.printed;
 }
 
 static void task__print_level(struct task *task, FILE *fp, int level)
-- 
2.43.0.rc2.451.g8631bc7472-goog

