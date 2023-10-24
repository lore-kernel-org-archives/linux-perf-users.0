Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5A4293F
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zBCpTlFl"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BF91BC2
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7fb3f311bso64649177b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186325; x=1698791125; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxgK5fVHKp+mV0fGm6A00soSn6WBUBJ/2ysR29mR0ns=;
        b=zBCpTlFl9akgkYZ47XY/LVVGF6Q8NqFwRlue7vNIvrQ3LKbNv2boVxYD2zUyndF4Gj
         NFrd1QOZwSUDjKu+LDP51pHt4h33mqD06GvKUl6PO77a5PkbFxYtxwuw1dz+LAMWR6E/
         XhDR/cRLWootOK8KkU2yuKl2hor9858+hWjX6eg2dpliu0J1YftRt/YW2JjXqLu6Kdb7
         i7Its/RxFcnh7XWJMxniVMf17Kaf0FxL22fTNvWt9TjRvGs2Ia7aWO8cnn2arX4WDO91
         KnRjsVYKK95MFNbgQa6kicYf9K8wIRi7P989G+R5HurEZ0aAWJNqnJrilU/menxwqNPY
         Snpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186325; x=1698791125;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxgK5fVHKp+mV0fGm6A00soSn6WBUBJ/2ysR29mR0ns=;
        b=Q12NQakGQxm8346o/DxK4fYP8GqlK+W2utKor7RRlNRil+EL3Iv00Bdd5RKZvLCrQC
         ITWyAT7KLsemWf4iviylJ/pJdW2POoTr0LYD1MP4II1z7IU4urbL+NVbTivXTjndMKMQ
         F20omPDsueLTMDT6tw2qaUbm7xiy3TVjIc6QOVo7x8jdJwR8rXoD8vWagdBESPj06r07
         Kdnogyo1k3W8HCNc7RVXIp7PfvDuBk7dojvar9yDUxS6A/CQzfq5JmkuDn3nyipbh6S4
         PAAL7AQUj5QoPwCZqfx5C9LO7Lt3XL97ah4Pnm3ILl4NV4HKC/bNwcGFyj/aUKY3ZQiK
         5JwQ==
X-Gm-Message-State: AOJu0YxWT5MKIHX5y/GQlByLzqzAiFi5ol1c0ufnK0zTTLWCGa9cCm9F
	jHWr6YAwN3Jqv0LjH9xy3NGWnEkEdmmQ
X-Google-Smtp-Source: AGHT+IGPYhopVp4NwknT60DLHn+cg2ZkfPgvlB2ztGqyTTywxRVA0AhNRyMeJWGl0Lazqkj9RV8TWcoRdfRo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:d644:0:b0:5a7:f73d:e69 with SMTP id
 y65-20020a0dd644000000b005a7f73d0e69mr271133ywd.4.1698186325326; Tue, 24 Oct
 2023 15:25:25 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:35 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-33-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 32/50] perf maps: Do simple merge if given map doesn't overlap
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

Simplify merge in for the simple case of a non-overlapping map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 40df08dd9bf3..14e1a169433d 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -696,9 +696,20 @@ void maps__fixup_end(struct maps *maps)
 int maps__merge_in(struct maps *kmaps, struct map *new_map)
 {
 	struct map_rb_node *rb_node;
+	struct rb_node *first;
+	bool overlaps;
 	LIST_HEAD(merged);
 	int err = 0;
 
+	down_read(maps__lock(kmaps));
+	first = first_ending_after(kmaps, new_map);
+	overlaps = first &&
+		map__start(rb_entry(first, struct map_rb_node, rb_node)->map) < map__end(new_map);
+	up_read(maps__lock(kmaps));
+
+	if (!overlaps)
+		return maps__insert(kmaps, new_map);
+
 	maps__for_each_entry(kmaps, rb_node) {
 		struct map *old_map = rb_node->map;
 
-- 
2.42.0.758.gaed0368e0e-goog

