Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A633224
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSTUS5jd"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B51FD4
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cb10a5d44so2893005276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186332; x=1698791132; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiRI18wPFPsoj3esFQh9IhgomcBelp5JaqZwyCYVfWY=;
        b=zSTUS5jdV7rKsOD7wncjVXcyqL1sOPHzXG2/a9kSRAwf3/XvbAHBV5zrQ8WsLWkVCk
         efbjbuAfjgH0FNr5pR251us6BjWcJHX8KZHGzNjnXM9N8F5NSklkreiQEKXnOUyNxP3x
         eq6QeDZ289YikNgPMqhf3xSLXd0fCmYu/+t9g8n1Zat1fJM0f52DAuEHuKdkgNTvtkSS
         n7kaGgZXC+gNxiwEcvEXbEs7GtKxegcL9JXCfVHjB2KInCWV3sqH+s+0qymhutcxAooN
         jVlDCUZXEcHqVf5uA817QVZWRlYKJPmgK1+MwEAUnj8P3EXu8KkLT/5C+lOqK37g/oEm
         6gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186332; x=1698791132;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiRI18wPFPsoj3esFQh9IhgomcBelp5JaqZwyCYVfWY=;
        b=cyx88KgfY+33zNXCPsDSqqSwI0YEehA9ZiBJQpbGjwRqzUR6KU8BUzOI2MKi428xgj
         MnZzBVoBaGN3XahW3f0/V+q4dbm+02RmFT/ctuIlYdIznQD4FgMH4UUxFgZqX+9q+P/S
         uFHzVz/ums/LhIHRZVjf43+ywgOCDOvjM2WJvkhQyjNRtjia2e329+1OzEBOTGmJxQX7
         ETILHNfzFyY/wsAR2eCgvs+Cx6pqPOLL2jykNaAEy5wCaen+8whte/zY8QH9/1cKUp7N
         pzWqjbtuUPkA54BroWq3UPBARHrfYozeFJWXD2I2fYRUDvtrpfNmw7515vvGMDeMubbJ
         +TyA==
X-Gm-Message-State: AOJu0YwvMbLOrBEq82aV2Lw3qGxDWEA0sRaGGa8TDQX+Xhp/Swjzs2AI
	h/4yBdowRaZoncilCGK9oj0cDhFh5CVU
X-Google-Smtp-Source: AGHT+IGXDkdr+GYf3+Uii128YBRB9U48VI5EbuLEHC0IkaHgNqKm9aqVymDt2TgW9D08iv713nCAp1+H/yHP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a05:6902:1743:b0:d9a:50d2:a8be with SMTP
 id bz3-20020a056902174300b00d9a50d2a8bemr262421ybb.1.1698186331901; Tue, 24
 Oct 2023 15:25:31 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:38 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-36-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 35/50] perf maps: Add find next entry to give entry after
 the given map
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use to remove map_rb_node use from machine.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c |  7 +++----
 tools/perf/util/maps.c    | 11 +++++++++++
 tools/perf/util/maps.h    |  2 ++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 191e492539e5..ab345604f274 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1759,12 +1759,11 @@ int machine__create_kernel_maps(struct machine *machine)
 
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
index 9a84d26328a7..38d56709bd5e 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -662,6 +662,17 @@ struct map *maps__find_by_name(struct maps *maps, const char *name)
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
2.42.0.758.gaed0368e0e-goog

