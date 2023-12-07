Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKrqV2LL"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F5A1BFF
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:18:12 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca2e530041so1850797b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911891; x=1702516691; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhWv5XH2QIvBBYa/R05A/SafwPCuOWvAm4FZ/Ek/rFM=;
        b=aKrqV2LLaveEeNRG0k5c6Fa2OyEtZKKkinL9NWdjtQ7YQLJxH9WnGGvfKZkZR1nKbV
         AXU6HylhZeuOeDI6fTq5bNOSs4XQRk84D8coYKv5jbRo3shOuq8VUvTLW16YP9RKvDft
         OHApy0W9NqJjcthFbVLptVN7dMeRW7sl6vvJ5FYRiMxTb1gIfKYi9nyjWn9sW3eHVBuQ
         8mtZjMM081V9zYHnYbsvKNc6mRoENbV2EB4sxsFEQ9USJrGqW9+tSmaG2v9AOXao1m19
         IJraUtqlPvbJwmIpP7R4yTUvngdG3eN+LdNKqjANPh0akZklpUFxc1L8kjUGd8lR9IOy
         ptfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911891; x=1702516691;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhWv5XH2QIvBBYa/R05A/SafwPCuOWvAm4FZ/Ek/rFM=;
        b=hgAVh4MXKmY6ph5itg7W8EZfJYsUtovw+eRuh9KIFgtaJb4wmpB/648BNP5FAjBYfW
         lbNb5T7Xed8UcqFmr9RB5Q0+h+TNvla/9GDWPVHCu6+X7AAawvhKYQV7D1t9GoDkhZMt
         0Bk0cxCyMfg8sKMgcq8sScIH9bA9/ulH3+eyhVH1KLuDggut5QLcX5DK5Sq8J7+m6+bD
         kNwioFZOEPCm7PDqm8Dv6/tScGe9MQRCHNQ1L1Lqn9WSpgMeDMWeziIPvGkLEvkEQFkk
         Muo+iCsFEiMmHP5+0bsuUzdSbZS2ZFg5Anaj4N8zS2AOk28U5hz3+3aWxJkJ3PAGp7gM
         uDSg==
X-Gm-Message-State: AOJu0Yzk4JYoTb9iEVYJsXv9xCUMLEUcTCnyip+9IbgG1layXQfRwQFu
	raERNo6Lh1ACK/CWwyRuAWF6dMN1aDk1
X-Google-Smtp-Source: AGHT+IEWcnmiKEOyMIE+2aNgl2GxOpZtGE8TuU2QEQKPQlYZwpHrrMBjKS7T0LXoVJ/omdKDaVXSGMunSkJj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:be14:0:b0:5d1:7706:b886 with SMTP id
 i20-20020a81be14000000b005d17706b886mr31238ywn.0.1701911891461; Wed, 06 Dec
 2023 17:18:11 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:53 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 19/47] perf maps: Add maps__load_first
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
index f1716c089c99..31ff19afc20c 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -318,7 +318,7 @@ int lock_contention_read(struct lock_contention *con)
 	}
 
 	/* make sure it loads the kernel map */
-	map__load(maps__first(machine->kmaps)->map);
+	maps__load_first(machine->kmaps);
 
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 986daa1b0497..024a6c9f72c4 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -793,3 +793,16 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
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
2.43.0.rc2.451.g8631bc7472-goog

