Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/phPbzp"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A10213D
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:15 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d10f5bf5d9so10693587b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123015; x=1701727815; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibxQbrmoPrqwkvjL6HzRr4OKzYq/57jpsc4KyLgcIQ8=;
        b=y/phPbzp6l0w8r3SUhuPNmyskKStD+EXNXGRuWsUxJMpIo+yW8HuZgZY9Adu6B5Qnu
         wHLcIoBF6XTRz5wP3kfWBDvJDbGS6mx3fGU5GMVCbcUN/22BzR0PMzFHMleZaXb6PK6F
         ovlgl8GfmdFGPiMwZdKzRCsM0kxgwkL8wWYqGU2Djz48oOJ7T92kMd5gIjqeoEI1O2hv
         a5bith3Gh4lV1boKHpoBvkrh2xVgTZ3nE/lViNx1Gjy/FUvovqkKOxzApwGkWGC/oPxf
         GpWlZQj7sWkIDGw9yRPzAjSJD+/fp3iYmnuIRbJXRnxUqQVOXADvdIW26w5/3JvqVA8P
         Whrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123015; x=1701727815;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibxQbrmoPrqwkvjL6HzRr4OKzYq/57jpsc4KyLgcIQ8=;
        b=JV3U5nmkOo1S6VSu9Q2u/RgUH9LMBpp6FP76K+VvrkyTfogtU+tKJcy9ARIg9TfiTu
         H9D/P/RJbdlyAKU50tXZgWIItMDM7tEpOfu6/FbV616Iugheg5jEyh2Kaetrkz3qjh3B
         mERD83He4//JEe3pebfSY+mLKB9N0CIccUdgme8uXf4JshW2oEcgdSDsfVhZvFSa/htw
         Pu2KLQ5GIq5KovHUJrNGbtB0E/A8qkG+iXRZhkt/hHxNkdXn2d1MqUn4vaBVbsaYZHll
         5pTdRSmxUCIdP7twQUsNBzXxzhdAFPgJ07g0aiz8NIW1vAQvLvctVu8Hwbqs8dUymaAG
         VOnw==
X-Gm-Message-State: AOJu0Yy19JBkODxuxvERr+bJPRZyAcBvJR/1O0AZ9WG+VilNcA2rolaN
	xNzyjN33hbunOnl4sp9Vtg07J3dkTA6a
X-Google-Smtp-Source: AGHT+IFiFRarIwKzVw2I2RiWdhieVGSthk0nHPmIuYC38wDVYVD5eRcsUPGbS9uAUdIseW4UsQTrdpBof0fS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a0d:d40f:0:b0:59b:e684:3c7a with SMTP id
 w15-20020a0dd40f000000b0059be6843c7amr440723ywd.4.1701123014862; Mon, 27 Nov
 2023 14:10:14 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:34 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 22/50] perf maps: Add find next entry to give entry after
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
2.43.0.rc1.413.gea7ed67945-goog

