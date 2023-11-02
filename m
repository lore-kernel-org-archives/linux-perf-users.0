Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08920B35
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ER89x3QB"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED819A3
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afe220cadeso16878657b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947931; x=1699552731; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjGLpULVRUxYABNs8KK8hib6JmANLHcuQm1tIO1QTLc=;
        b=ER89x3QBSjW75W4RiQdRTVKtAxJHVgvda9Wayj8xyj7MRXcx4tLWCOeoLY4QQ/S6oH
         F/+U79jPBKgdjYjmmTi4JZMnc04mDRMvXrIWEo7LW/pfBNqdetmIfEK0zhHEWI8drs9D
         RHi6LGkMDc6JqV0h1MAgeAfscLsnwmQaQ+fEj+/6dIDa2MQEDrIQ//6/mFNQ8Y8jxdoV
         wzVde1G5nZ8o32XkKO41x6CZe/CDlVukhGIsY5m3fSctSrh1xEsSR9YO2l0smLMPNimI
         ZqlHuLtC37bxumhr2GPvKs9YogLsOTGYArBXhmBEkc6500EJSLVv/BGIq3qFFiHwnNCE
         /3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947931; x=1699552731;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjGLpULVRUxYABNs8KK8hib6JmANLHcuQm1tIO1QTLc=;
        b=COkkQ+n4Z1Gjiko44NiXgoorB1AWuczztlBf+9dGE0u7Twkg2Z8OQHYrrQPVfGTSjm
         my90nobJsZ0LoRwfubdXkXSaKvF/fkejt2y+U13wDB3hTj2XfcNvXMhQXwH25biymDjA
         jhryOt50N6w1Ki/x1i26RUuuCXRYWPziMWTWFwAfIt6veDngslSeZsG95WQO4UKST28J
         Y+mao1fO3hbYbjq0kTTVgA+1UI9xn/Ft9wOT/efSI4btoHDS5j7fzJWxotv6zD1LEyy5
         WQPowPc8EJcTRInTr9/5hEGkd4pnB8h+EFdqg4BQTmwMtnwF3NnNfcZ+GJY39nKLEnaP
         zxCQ==
X-Gm-Message-State: AOJu0YyHocw4Ck33uzB6wupD2qwEuZEgv4T90vn+J+nbXnxQXGfLZc93
	+ssdZ57UnlqYp4zHUXbRW6Kgt9bbqXl+
X-Google-Smtp-Source: AGHT+IEaqoxnS8RYuF+B0Tq+gELTQ54gaKcVVdKaiSS1qLvvW9EX9LtcaPvY9lTdk6v6MN54IVKOKzEE90HZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a81:5249:0:b0:5a1:d329:829c with SMTP id
 g70-20020a815249000000b005a1d329829cmr9123ywb.0.1698947931428; Thu, 02 Nov
 2023 10:58:51 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:06 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 24/53] perf maps: Add maps__load_first
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
2.42.0.869.gea05f2083d-goog

