Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9034292A
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IikWft0+"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561DE2D51
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a81a80097fso65159817b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186329; x=1698791129; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/BBcChnvHkmkYd/yKkYLm0W4V4ebv0lxjgGfrAGFAQ=;
        b=IikWft0+Z2JZYapaYzZducsS8U/UZgqXninSEVB+zlH+i8i0EAC/IiJDMsOg/YwMgg
         1vdiLwhQB8Yhct/2Aljp2ItEUU6WxI7oGstRkTzDu0PCYsvzZ/lTNDb6bXKKdoglzboL
         X5+Wwh7+RRHtobAaoZiTBg81555viJ7u6zG8StT0D05c4sO/ON7lvLvRbYQ/k+za7Khu
         dDSITUE9C9XWQy4dc9A/Iso3ALZ+17oHeiZbFLgdLzByROS+AFa4XNvHHzW/ZcNuGiO7
         Of5VeO1ZiCeEo7UN4PM5PnpzWWDDlNUA0QdUtI1e9jovCqgY2Fxh1cn6PQuErjwH7OsW
         e10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186329; x=1698791129;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/BBcChnvHkmkYd/yKkYLm0W4V4ebv0lxjgGfrAGFAQ=;
        b=KTX1hHwDrrrojrdcc/YTfNsdJNKC1mVAPSuPd6E6BfuzOrRjI3z5UKnDAuNglKZMGl
         Ys3itsrwO6Kn4N1FMKEY98zDG4zjqmIaMsplrsmxB4KxiZxwCyL0CDh623Z8krepJu35
         dTr82YRfu1jwVFr8+izznmCFwxIKw1/pENz7Hz4eumHxaee6vG+TUX+r0Bo15yKkKN65
         4XN2Opuf8q5p9ieKlsDwD0BXvuvCh3X6pkfNYHNjd4nr3P7riYnTC4XPngSy19h5RsC0
         AuRpEXyHSyxYnljseL3GfAzlVoqDhBlosGVeq+v1VECsSrrnDyR4PnmUsP6r6F8ijGhp
         O83g==
X-Gm-Message-State: AOJu0Yx78+pXzuye/kurDkS4o7oR0SvAOZwYTFMVnOxZLkN5lt4Bl9Wd
	3Ndsz/yL6UfGR6Ypq73oa76yIe8uoDw1
X-Google-Smtp-Source: AGHT+IG0zOXVoS4I27y9mQ3iP8YCnXrnCRbcVVP+t3TFR8m1DZEM6pyqJUzKpCn9UlcVCa0j9N5exd/Lyl00
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:d954:0:b0:595:5cf0:a9b0 with SMTP id
 b81-20020a0dd954000000b005955cf0a9b0mr293421ywe.9.1698186329522; Tue, 24 Oct
 2023 15:25:29 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:37 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-35-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 34/50] perf maps: Add maps__load_first
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
2.42.0.758.gaed0368e0e-goog

