Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ou5kncoO"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80AF2106
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5ca2a6f07b6so67869807b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123008; x=1701727808; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAs9xJJ0NlEB/osgBnOQ+CItqjWbP34nP1iWUwmaFSk=;
        b=Ou5kncoOrxfYfVuvym4yMip8yo+PgBMeoms+79MdyYq6I6GUngQSVDEBECX97ZHBMQ
         wwRakzunprC5rB914GbqG7eDAK9q4rHR9iWScZEVoOzbI2FoGEA96OuJd3NGb7aIbixI
         lsBoN/H17MSLdJ7SHnivj5uNn8I8r7ecDRslQKoh2P56d1zrCDw3WQ26usbn+ng3P3U8
         hhI3+V/c9hT+a2pTgq+8TGvoN+4lDJQ5bVLTP82Fq+PTLpFPbyV2JDfyjJL/KFpcSXVt
         LwIlOnXP/oKWiZzp2G0Dc3mShtZQiUOoSP4eiAIZiLGYfQ7CoNkcj6kORIws6vy1lZ9R
         qG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123008; x=1701727808;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAs9xJJ0NlEB/osgBnOQ+CItqjWbP34nP1iWUwmaFSk=;
        b=IgHsg2D2xePz4Ta2eIDhPnwWCiVG6m8xhsfftWajRWvpKeoJr5ZoGYdeR+kV32oLGg
         7hZAQ7+BTPsTUYS086BIrf++Z1TTOBoEJGNquBWtNobdKF4bq6D0GrKZgksunHmdLcaS
         zIPOMZ2HDb14cCarSqUp1GgFJHQn1Zr3XXeXCGIN3b3k3r7TC7S08yU0rOUUIni7Xopr
         TMH9xSNmX59zP9uvYKHtg+S5y2z72QLzd78/58OZ0HQx2ukmSZJDcgIm7bUUzw78n3jr
         4JkTjoQar21P0EqaCsgDvDc8vAoqO3EDqXxNbLThVYHRLytQ80iRPUHqEkFQ9y8qVRMK
         xLrg==
X-Gm-Message-State: AOJu0YzksFGeBZcrTXg1G38963FJ+JUrdpiA0rdklwAJCRN2JqG8la3c
	wV0JUctRAukh/PyQAO+LR3qYB9n3KW4i
X-Google-Smtp-Source: AGHT+IGZwOFBSYgDDTtvjfQ20Rcd6wK+D7RNERey9zwI5OgP3A1VgudHB+xv/VeG3IN4hmQ164LHJiqXguWX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:829:6e77:9093:f39b])
 (user=irogers job=sendgmr) by 2002:a05:690c:811:b0:5ca:f8cb:181d with SMTP id
 bx17-20020a05690c081100b005caf8cb181dmr425161ywb.3.1701123007777; Mon, 27 Nov
 2023 14:10:07 -0800 (PST)
Date: Mon, 27 Nov 2023 14:08:31 -0800
In-Reply-To: <20231127220902.1315692-1-irogers@google.com>
Message-Id: <20231127220902.1315692-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v5 19/50] perf maps: Do simple merge if given map doesn't overlap
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
2.43.0.rc1.413.gea7ed67945-goog

