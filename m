Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKhP33GG"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4DE211C
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:13 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cc7d051e38so63963007b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123012; x=1701727812; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjlQMs1hNHRgSuoywd2CjIiILfAJuheeO1q52M2CHpo=;
        b=PKhP33GGrallGD2URPK+wiamwQuNjJR/ojvWyWq03PWiYMXXdzxtU03jWHCfLGoaxF
         ggq9YKQ8fVu0JSski08WTZyh4b5qemd5P+aA9Awq3s3GodbPCYqly6un6LKB+cwelIpg
         9JLMbsmyzMZYPYDxouu6/vP75x71x0fuGYtuqjwsG3NHRmNns30C9Gaefk3HyG+NHoaV
         lh3zkq7aDTsBK/PhpLl6AzEInp4ViyrvsqJtyYdUEF4x+KV20CFA3ZLerCyR5Bn0NBOk
         x/pVPBchPa8l2C5w4lJAiA02kTP7oTfU1VdZUl/FTJS8Fh9K6ZyOwuzgaZnxB0nQbF6b
         VxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123012; x=1701727812;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cjlQMs1hNHRgSuoywd2CjIiILfAJuheeO1q52M2CHpo=;
        b=oHioCvlfwAmKxsJ+2JeltJoYm2Sj4ce4UqbA3GxE4cugZu6zcbxovKbAKEKMEG9cpj
         5i+bCduMrd0IfHHtokfUnGnVBC3uLwQEt4N+oKvx0k/N26pgSHXF0grtBkVFAludjCXp
         XZQj30kzuSG1HzZBRdClUiKtziLbBxVt1wM5zKKVFUtAhRQq5UV6cpUNa7B5xuOhsnun
         ZHnvKYm8jD+FOYrwcRBVsp97yhd/xoz52zRwWcV3nLMrc3ZjSl6lxFd17W7vFaRCldnD
         JqiGCazi9AB/4M4HBbkWJPTdUrUNENvZ6kaWoaY8sNPd4olNfnk+M4j9yoyIxIvzq8mH
         y5Pw==
X-Gm-Message-State: AOJu0Yw2iKO5VHMhJ/xItSyPd7uqludZjokRq24wt+J4ip3jomjPC0vk
	3YTd7Pd1TMyjDVcxIL9WFk7nlV3eOCc/
X-Google-Smtp-Source: AGHT+IGsvdeQNa7n/pjPYJ60HKKWhbdNVn1oCLGQk/0oHT4BwaHg2UpfkIzI0kS+r0RxgAmkyDcSFNXaGe8L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a25:fb07:0:b0:db4:5d35:c5a3 with SMTP id
 j7-20020a25fb07000000b00db45d35c5a3mr432690ybe.0.1701123012376; Mon, 27 Nov
 2023 14:10:12 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:33 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 21/50] perf maps: Add maps__load_first
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

Avoid bpf_lock_contention_touching the internal maps data structure by
adding a helper function. As access is done directly on the map in
maps, hold the read lock to stop it being removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_lock_contention.c |  2 +-
 tools/perf/util/maps.c                | 13 +++++++++++++
 tools/perf/util/maps.h                |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index e105245eb905..d9720a910330 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -317,7 +317,7 @@ int lock_contention_read(struct lock_contention *con)
 	}
 
 	/* make sure it loads the kernel map */
-	map__load(maps__first(machine->kmaps)->map);
+	maps__load_first(machine->kmaps);
 
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 85bea2a6dca9..9a84d26328a7 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -792,3 +792,16 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	}
 	return err;
 }
+
+void maps__load_first(struct maps *maps)
+{
+	struct map_rb_node *first;
+
+	down_read(maps__lock(maps));
+
+	first = maps__first(maps);
+	if (first)
+		map__load(first->map);
+
+	up_read(maps__lock(maps));
+}
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index e4a49d6ff5cf..b7ab3ec61b7c 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -142,4 +142,6 @@ void __maps__sort_by_name(struct maps *maps);
 
 void maps__fixup_end(struct maps *maps);
 
+void maps__load_first(struct maps *maps);
+
 #endif // __PERF_MAPS_H
-- 
2.43.0.rc1.413.gea7ed67945-goog

