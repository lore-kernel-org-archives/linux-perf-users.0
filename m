Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2920B24
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zxmkJ4j"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CB81985
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5a16fa94so1079216276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947926; x=1699552726; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/N4ckVg6cjKSIfadSgQO70fx2qt1gK+WL2vtB+jVqs=;
        b=2zxmkJ4jWXDGt9kklD3qp4T+SUeQYNWxrQTUc6IrAfmTuK1p97pdhKXlOBQRXHvLLZ
         S9KsnhwyfxyOznTCcMHEnL9BRUoqqPK6UlyxU1/EBhf3dIqIrD68C25WS1V286+DvYCH
         3yBzVy+jEm22RkrJW4xhi9h4MuNQkAdn/5K4N76H7Sxl1t4hRLOEFsc5Bhg7U7aRxTqK
         qLQW/GNIdGG1ViEPwtgWPOd3s76QSoc+jPJUYDUt8lgkw/9FIh1RYUMHlNZvMxXZu5LX
         pAnHiFF85jiRpf+D1KZLjccaDSTSRbTJNeEw4wwmEEqQbNjO/PiAyz5Yjl3NuXfpKTNx
         1H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947926; x=1699552726;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/N4ckVg6cjKSIfadSgQO70fx2qt1gK+WL2vtB+jVqs=;
        b=Hg6+Aye8ybZ2gKWuMvbfBuqIMxic9AX8Ek6dVKGxWIIcm6TXkTKX4DwLT/eKLiKKbb
         jj0woDMujlySo6maNGDvOXfrPyx7xbvIqC4iyc5a/VtqfZftllOUt80c6MtJx42wv7v7
         v2vrMcucmM676AP8mwVhKuz4X+SrBWEtQvEr8b5C0wLm9nZw92R9QlhtDpvGTObiRrp2
         mNH2pIYdLsjYnSIyeIHarNIg5qERuq+9yjCG4+N/gErqvKkQ3jrSPUFLJmSzdk1Jh1wt
         HQvf89jFb/aqmN/3PIoJvbYk3zPTK2pNrXl7UBJ46ManhGwjfXJReUOQhy+od97iwnF2
         RV1Q==
X-Gm-Message-State: AOJu0Yxd07rIMe+0i4dzj86q2Id07o+HnvHGMwsp+8IBLSzqg4Raosoq
	Ag+iEIvV5IdZUEW0X9C7Vu0LPPmLx6R+
X-Google-Smtp-Source: AGHT+IELmnUlik1Iorlfj1hreAP7SM2tVfd1zV588w7U8EnJ1Yl5h37ZV5f34FREAL85Q0y54IkJ7ONHkjDS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:45:b0:d9b:59c3:6eef with SMTP id
 m5-20020a056902004500b00d9b59c36eefmr5140ybh.0.1698947926695; Thu, 02 Nov
 2023 10:58:46 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:04 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 22/53] perf maps: Do simple merge if given map doesn't overlap
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
2.42.0.869.gea05f2083d-goog

