Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUYPU1ne"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960A1FD7
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:18:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d67fc68a82so1631487b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911894; x=1702516694; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJG3uwAA/nSL7IkSfLWDFQ2uIzS+c6TzT8pbE94oS2I=;
        b=QUYPU1nepX6XgvTp3WSz/qAjTWrBjE+forNlVwRJe6yf5bdp4bpOpWjl3KjH4L6geD
         sRE9u/F7kMxf66tIIErTZU/PEwXki2BpAzzJQRohbqj82BMETZkHFn4jZ7hp9pFNMrHX
         fqSNiv77QyXMmfOBz1AQKP/tc1q2L2eSjjjJD9L9PRlEcD2XXFaamNGHScFhghvPeA/e
         PqiFJkvZF1zEpjAtP9V5LsQpEHz8JwJ3VmLcJZMQCQjpuWJDf4rCdt5lDwApwtjWz3VJ
         jvdFMSw5z190boZWCO5O8hCBYqLE60DWvNcPKvVM7SNsJtwC4f0nt7d1zG1sUfHjF+qr
         UenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911894; x=1702516694;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJG3uwAA/nSL7IkSfLWDFQ2uIzS+c6TzT8pbE94oS2I=;
        b=WGTKq+uGCOjRI6aAaQ9b0S8IZYrp7D1/be3Ra0I3hJxFed5dftNoyLSnYV35zBAaii
         HYvAyhaJ+BB47OTskT0QXecuh//ui7P07bsreXuFEcEIQO52g7bPv1U+JQdZSb2qwvHY
         mHFYWxQeDZEz4+Y9VfqRriLjFqXGBg/rWZl7zw+v+HoofOhZ2wTJh7EE4PjI70VxG2Uo
         yVy5TBZflhsKy6N+myi08tvm061bUK/SGFCM9ExWKc7w6oWYunZZ4aEnI+LwJD1ihkYT
         dd5o27HobaJuMAKRvKqa4BoexnJjKI7VM8USWYrNLLhCy3JBhq3KvVhkKqrdZlYsu7xJ
         kysw==
X-Gm-Message-State: AOJu0YxZ1IubgFm6Ueza2ch82KxjgdEovfVczhze6i+l9dY7lLWWjrgD
	XbXiFa96+mP/hBYoYYk48YkZm8nDueUP
X-Google-Smtp-Source: AGHT+IF0a7ketmt5BUFG2QBffvucaW4XUe/DUnqODHbALoqI9bNPUz4fkpLpUoajFV79lavu5D/8zgA8ff51
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a05:690c:3244:b0:5ca:5fcd:7063 with SMTP
 id fg4-20020a05690c324400b005ca5fcd7063mr32175ywb.3.1701911893941; Wed, 06
 Dec 2023 17:18:13 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:54 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 20/47] perf maps: Add find next entry to give entry after
 the given map
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

Use to remove map_rb_node use from machine.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c |  7 +++----
 tools/perf/util/maps.c    | 11 +++++++++++
 tools/perf/util/maps.h    |  2 ++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 38bf7108821d..b397a769006f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1762,12 +1762,11 @@ int machine__create_kernel_maps(struct machine *machine)
 
 	if (end == ~0ULL) {
 		/* update end address of the kernel map using adjacent module address */
-		struct map_rb_node *rb_node = maps__find_node(machine__kernel_maps(machine),
-							machine__kernel_map(machine));
-		struct map_rb_node *next = map_rb_node__next(rb_node);
+		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
+							 machine__kernel_map(machine));
 
 		if (next)
-			machine__set_kernel_mmap(machine, start, map__start(next->map));
+			machine__set_kernel_mmap(machine, start, map__start(next));
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 024a6c9f72c4..5b898a0e97b2 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -663,6 +663,17 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
 	return map;
 }
 
+struct map *maps__find_next_entry(struct maps *maps, struct map *map)
+{
+	struct map_rb_node *rb_node = maps__find_node(maps, map);
+	struct map_rb_node *next = map_rb_node__next(rb_node);
+
+	if (next)
+		return next->map;
+
+	return NULL;
+}
+
 void maps__fixup_end(struct maps *maps)
 {
 	struct map_rb_node *prev = NULL, *curr;
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index b7ab3ec61b7c..84b42c8456e8 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -136,6 +136,8 @@ int maps__fixup_overlap_and_insert(struct maps *maps, struct map *new);
 
 struct map *maps__find_by_name(struct maps *maps, const char *name);
 
+struct map *maps__find_next_entry(struct maps *maps, struct map *map);
+
 int maps__merge_in(struct maps *kmaps, struct map *new_map);
 
 void __maps__sort_by_name(struct maps *maps);
-- 
2.43.0.rc2.451.g8631bc7472-goog

