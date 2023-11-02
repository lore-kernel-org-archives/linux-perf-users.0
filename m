Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991820B39
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uy1/4wIQ"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD0D5E
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b59662ff67so2718557b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947933; x=1699552733; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZFU+q33RyXycgTF/0yPGI/OvtojYXelKAaBBZD0UYI=;
        b=Uy1/4wIQ2Zpn6AINY6D37TWT4iyK51U8RCrIyNyk+eDSE2fznI4saKcPwhGBGBd+rR
         RMpyo85gqRSGz92uC7BmW6B0qNP9w47stKPPTiSmElYmYYeHsRyM8HpH6AAqa4WGHo4E
         WTYmo6gCfI/Zmy/v3Y3W6EVWttLFAZ3jvuz3acfIAFHUTHe7bqUPf+kcX9+vV6MNPaWL
         WL+OUBuS1UBoW2Q4oL4gUAX5AM5m3Rk4oZ/Mn7OodAMpkTFxgxcjHzicjXGYNflrKpGG
         4DDGROgxArxknCBBSKbToWWhSotYoQROym4Tf6RfnlHTjFIwRq488mU3iZe8qkH3leeA
         EF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947933; x=1699552733;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZFU+q33RyXycgTF/0yPGI/OvtojYXelKAaBBZD0UYI=;
        b=QlwduzV8siZWuzHDKRC/B3N+hw+mvdND1LZt6b+etGsTGYyDLcshqac5VvoNJ63k+K
         uDTQAB4qj+Z2bFt7+saH3R5atNBTVGNSotr+uoAatJ/jG0IaI+x9rqQ9T6ZaH67Cn4qw
         k9Kt69HP/AzuS0ZtENYEuFJUQWbgBucw/o6pow9tbQi4bRoyJRbHUtbfM+DxOhOGZXaK
         3hkWTTaTlh92Uj5rn4aUJx/6RQBFUfkIpCqSn19z+LlqEBpYM6xwurcxXqyVIiRlsY8C
         Zg3Pdx/iirZcKGnn+k0M47LvHRz9Pzg+s2YF6dxQTxcJOexu7bfS+739wr6wOk5knVM3
         ghUw==
X-Gm-Message-State: AOJu0Yx73t70ZwurYpVCMOFUmuaTWOTp45SIeubxMWw4w8Cnkpb6XPda
	qiTyt+xThbR+2CbNejCfMBFmL0pWF7m2
X-Google-Smtp-Source: AGHT+IFojZEQyiPESx+Htv6w7qmFpVGOAnAIUHpw6/EgMIBjXibv5GV1qqwpAFH93KweAwmEsXUuUhE0afYO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:690c:3690:b0:5ae:75db:92c5 with SMTP
 id fu16-20020a05690c369000b005ae75db92c5mr5517ywb.2.1698947933554; Thu, 02
 Nov 2023 10:58:53 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:57:07 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 25/53] perf maps: Add find next entry to give entry after
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.42.0.869.gea05f2083d-goog

