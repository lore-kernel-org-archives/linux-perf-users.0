Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736393D386
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MB6fSisQ"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9611C1995
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9b9f56489fso5888905276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186275; x=1698791075; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fymRqgLhl5n1SIBrPc0QfOKYmvDTL24JHKj2ULWmDh8=;
        b=MB6fSisQ9Mzg+nwYpdT9l1RYvP7E37uzK/PFXvFTgNtN/Aem2ahuiBBObur4VXkFVo
         p9RcgL9HdBEekHsLtX/Yf2xzTLGU4StIUU5bA6UiUaSVq4z06w4TAYEKckw6gx03sW1N
         EQGwHUpZ32bLHGA1AxHd5PLMVS0yges3zPcF2Pl3yhdlKnbLUUE55ALZ6L6oMScLVG/z
         Y+MLkEs/Ydz7hqs+oHCYKfIkuM+6NoNAOdhu3XBtPNyseQZZFzFCNwrHZXxCsNqPdEiE
         0KdcYH/RQ5aum9KaqMn4egqsERjkcdTCmCdrqGHXFeLB29FgCwasQmxV+aiPfUFU4VRm
         wCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186275; x=1698791075;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fymRqgLhl5n1SIBrPc0QfOKYmvDTL24JHKj2ULWmDh8=;
        b=aMeBpGERbabdHFhvfhgonmDWerLn8QHFSQWhgLB4mT0XW0tLA62KJPkytj6N/KQ9y0
         gbu1n3cv+4T/rDrGFh//TK96EPdgklvY5l8k2n7tEGbkxeLWH63do7DXGst1EOY5kD+2
         trvaXrsAvnv4SuL0NAesVVucy4m69oRvlHCHXqWjEA+u9knjs6TSXS8eYgCzjDfBt8+M
         3ofS7QDBl28Lb/gGYL6StP2whMk4EufUch29DbFyNea5KQHa9LtrjFjoGFa06UbGjdMw
         81SDAbublApYDsZslMWDuwNKg4ZX7RGlH/zqaIBSCKp3HA7qySIOcaF5OYucvydW0flY
         PWDA==
X-Gm-Message-State: AOJu0YwanvcTpB0ylRyl3JA4yAivf8vPagZP119z150U9fV8ZOvDWv/l
	AlapD8wAnRnf9To7Bd7N9whvyBpZPDa5
X-Google-Smtp-Source: AGHT+IGhdi7O5ZhqnheMGqrQAIY05WVYo0pYxR8iw8GFpg46xp5pMtJOmYNKZ4MINF4sURPfdlTdvJxWf7b7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:76cc:0:b0:d9a:68de:16a1 with SMTP id
 r195-20020a2576cc000000b00d9a68de16a1mr273675ybc.0.1698186275302; Tue, 24 Oct
 2023 15:24:35 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:13 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 10/50] perf callchain: Minor layout changes to callchain_list
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

Avoid 6 byte hole for padding. Place more frequently used fields
first in an attempt to use just 1 cacheline in the common case.

Before:
```
struct callchain_list {
        u64                        ip;                   /*     0     8 */
        struct map_symbol          ms;                   /*     8    24 */
        struct {
                _Bool              unfolded;             /*    32     1 */
                _Bool              has_children;         /*    33     1 */
        };                                               /*    32     2 */

        /* XXX 6 bytes hole, try to pack */

        u64                        branch_count;         /*    40     8 */
        u64                        from_count;           /*    48     8 */
        u64                        predicted_count;      /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        abort_count;          /*    64     8 */
        u64                        cycles_count;         /*    72     8 */
        u64                        iter_count;           /*    80     8 */
        u64                        iter_cycles;          /*    88     8 */
        struct branch_type_stat *  brtype_stat;          /*    96     8 */
        const char  *              srcline;              /*   104     8 */
        struct list_head           list;                 /*   112    16 */

        /* size: 128, cachelines: 2, members: 13 */
        /* sum members: 122, holes: 1, sum holes: 6 */
};
```

After:
```
struct callchain_list {
        struct list_head           list;                 /*     0    16 */
        u64                        ip;                   /*    16     8 */
        struct map_symbol          ms;                   /*    24    24 */
        const char  *              srcline;              /*    48     8 */
        u64                        branch_count;         /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        u64                        from_count;           /*    64     8 */
        u64                        cycles_count;         /*    72     8 */
        u64                        iter_count;           /*    80     8 */
        u64                        iter_cycles;          /*    88     8 */
        struct branch_type_stat *  brtype_stat;          /*    96     8 */
        u64                        predicted_count;      /*   104     8 */
        u64                        abort_count;          /*   112     8 */
        struct {
                _Bool              unfolded;             /*   120     1 */
                _Bool              has_children;         /*   121     1 */
        };                                               /*   120     2 */

        /* size: 128, cachelines: 2, members: 13 */
        /* padding: 6 */
};
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/callchain.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 86e8a9e81456..d5c66345ae31 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -116,22 +116,22 @@ extern struct callchain_param callchain_param;
 extern struct callchain_param callchain_param_default;
 
 struct callchain_list {
+	struct list_head	list;
 	u64			ip;
 	struct map_symbol	ms;
-	struct /* for TUI */ {
-		bool		unfolded;
-		bool		has_children;
-	};
+	const char		*srcline;
 	u64			branch_count;
 	u64			from_count;
-	u64			predicted_count;
-	u64			abort_count;
 	u64			cycles_count;
 	u64			iter_count;
 	u64			iter_cycles;
 	struct branch_type_stat *brtype_stat;
-	const char		*srcline;
-	struct list_head	list;
+	u64			predicted_count;
+	u64			abort_count;
+	struct /* for TUI */ {
+		bool		unfolded;
+		bool		has_children;
+	};
 };
 
 /*
-- 
2.42.0.758.gaed0368e0e-goog

