Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7823D386
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZqrKT+U"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046310CF
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5a16fa94so263966276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186264; x=1698791064; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cG5+OY088Om6+iLiqKt06WFCMXUosiNbLSusAjLjbIM=;
        b=ZZqrKT+UjHHvy/H00VQVIZt3PiS/jfnqDnz7ouPps9VLW80Fv2MkQkEZp+0e3wLOvi
         aIC9Le/kVULcDKBJ0GuhTEYHFDpIpHkFYeU2Vivs0+agAus9cmVUypi2M6ZIE5lsnBwd
         F0x4UKY7hlNf8NIh4Hiky32niofP45ujmy8OV6r4DCzjX2xk21gGUPKeve6IZmY/i0/w
         MpxWzRL0gKARR1KGhg9O6ItbnHJWZ/Fd1AVL3ooyhebg2Fnjq1GzBJGN8uO/fVV+FRBT
         ef0MFik8vbgkT404AwvA9/VZ8dcmVWEn/uZN0ECmOGyWEFjzxotYS3SucyA82jueLp4D
         b7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186264; x=1698791064;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cG5+OY088Om6+iLiqKt06WFCMXUosiNbLSusAjLjbIM=;
        b=jWbOB2XoNKEPUW8xaW3ol4m9wnifTFlcFZV19F58Giibxbc0vnyQudKtPLQvp4NwUn
         WpL0gtn3KoS6XM257/QkXc6Zs31hBMtretjFmZUDaCTpArq7F7CVqR5CtnLNF7ZWS4Uw
         kqS1RqsY78YagdqpZUnzxiiqE+4f8gGvRiTo4d06rScVnVpMPOedKfMxf2je8e3dxnqB
         MRLo3bOfu7EBD7FggU+g1bbVRZz20kRtXH/7t/ZutoTr1/wYtA4/yzkT1EyLwn/FlILk
         6YnKz/7/o05B4NXGW0fuTjOqK777mnzzEt+tvp/pMG5WQOTz9C6l6bjIYTMgmz8FDtRR
         J7Fg==
X-Gm-Message-State: AOJu0YzGzCi4Dqn/ab7yY+BxHgILWnowYoESI0OGS93j5bm0FWmIkukt
	1K+y1Vwy6GCLfrLHz1PexbB1WWhyzEQH
X-Google-Smtp-Source: AGHT+IFn//bqSDPEs2RC7FYYE8cGNXvKFT1zQAKQHXM0RMKa99x4nFnwh3d+RZhqnjrY7SobrnskwiRaU1e/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:34d1:0:b0:d9a:6360:485b with SMTP id
 b200-20020a2534d1000000b00d9a6360485bmr385686yba.2.1698186263960; Tue, 24 Oct
 2023 15:24:23 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:08 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 05/50] perf hist: Add missing puts to hist__account_cycles
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

Caught using reference count checking on perf top with
"--call-graph=lbr". After this no memory leaks were detected.

Fixes: 57849998e2cd ("perf report: Add processing for cycle histograms")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index cde0078e6c90..0aa7e231172a 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2676,8 +2676,6 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 
 	/* If we have branch cycles always annotate them. */
 	if (bs && bs->nr && entries[0].flags.cycles) {
-		int i;
-
 		bi = sample__resolve_bstack(sample, al);
 		if (bi) {
 			struct addr_map_symbol *prev = NULL;
@@ -2692,7 +2690,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			 * Note that perf stores branches reversed from
 			 * program order!
 			 */
-			for (i = bs->nr - 1; i >= 0; i--) {
+			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
@@ -2701,6 +2699,12 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 				if (total_cycles)
 					*total_cycles += bi[i].flags.cycles;
 			}
+			for (unsigned int i = 0; i < bs->nr; i++) {
+				map__put(bi[i].to.ms.map);
+				maps__put(bi[i].to.ms.maps);
+				map__put(bi[i].from.ms.map);
+				maps__put(bi[i].from.ms.maps);
+			}
 			free(bi);
 		}
 	}
-- 
2.42.0.758.gaed0368e0e-goog

