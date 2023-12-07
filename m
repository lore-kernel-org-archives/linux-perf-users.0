Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRUXJ7b1"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E901C10E2
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 17:17:54 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d8da78a5fbso1678857b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 17:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701911873; x=1702516673; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2/fI4UKQGbXPKpixoT4A6YY7YN3DKvkLzQPho85kC4=;
        b=fRUXJ7b1rScZjQawpLsDkXqYkoCesK1ay2Cb3Uuqx7sFh3E8GqaDMQOg4m8AxChBKA
         fDVnwgz5MFsMpXSVuAhHi7FdKUr8N2BfHtzAtjhDM8vsgEQOhhdzGfqF8mJElcWzoPv5
         m45f2MNX7sVdYlm1HLl2DMVm9t36d59ntu09vM6AO/nlPOu9Edy4/emzPURDDPrFnXoe
         t+CB0yaYnEFG96jGHAxj7AyuPdh57gZMdnwtxyTQHn24OURM0AEyaw8hxtwEJ9lNZ5Ly
         fIFvZ15JOaS7Tnt3BJ+UpidFkM6uKNY0VvRIsBN+fgAFxaTh5p+5EeF4ByedjTEPZLV0
         irdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701911873; x=1702516673;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2/fI4UKQGbXPKpixoT4A6YY7YN3DKvkLzQPho85kC4=;
        b=cTA2sS9FH0u+NRdyI3DVfKDwDxcXtVQ+cx/cUS+bpjFOovL1fkRiDrhY8mTWVxb5VG
         zLQTyIOye4KnTgt0BSLlxTzqUZqjQvnlySBKLqnK8F26sMcM+1njovLTq7GfvxKUDqkC
         FZKTeaB6z0MWEj0rOFq+cpIsKdeDIh7eGEuNr8elu3xMV1Ox1eiXjMM+wjb20S9Z0aCk
         LP9sIwxyM7RB3VUEpBONN4521Q+/UR09eaQ/BAK5bacravG4aIWoKL04ruVzRHjdBQg6
         ixnLE1xzqXPLEaKRVYIsKbc1cSshVv6D9TLCrZa4DPrlqBcDz4qi1hBxqGI0e7CaMKDu
         Zqng==
X-Gm-Message-State: AOJu0YwRGUTyWSIYWjJb+80AGhOZa2Ad5SZNQdzupmT0Q7ZLh93G3NWz
	cDqbNo5zjaF9AoZPTYP07OYPW5pvPS0m
X-Google-Smtp-Source: AGHT+IG3crwuUKA1k1nPZvH9yQllxEOrTpihvd5crtorXk3VOdB7gfg55UWxCR08/ajjSZBH4vJiir/HQEG2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:35bf:293e:7696:34e9])
 (user=irogers job=sendgmr) by 2002:a81:b70b:0:b0:5d3:bf64:5e20 with SMTP id
 v11-20020a81b70b000000b005d3bf645e20mr25066ywh.9.1701911873370; Wed, 06 Dec
 2023 17:17:53 -0800 (PST)
Date: Wed,  6 Dec 2023 17:16:45 -0800
In-Reply-To: <20231207011722.1220634-1-irogers@google.com>
Message-Id: <20231207011722.1220634-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v6 11/47] perf unwind: Use function to add missing maps lock
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

Switch read_unwind_spec_eh_frame from loop macro maps__for_each_entry
to maps__for_each_map function that takes a callback. The function
holds the maps lock, which should be held during iteration.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/unwind-libunwind-local.c | 34 +++++++++++++++++-------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index c0641882fd2f..228f1565bd0b 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -302,12 +302,31 @@ static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
 	return 0;
 }
 
+struct read_unwind_spec_eh_frame_maps_cb_args {
+	struct dso *dso;
+	u64 base_addr;
+};
+
+static int read_unwind_spec_eh_frame_maps_cb(struct map *map, void *data)
+{
+
+	struct read_unwind_spec_eh_frame_maps_cb_args *args = data;
+
+	if (map__dso(map) == args->dso && map__start(map) < args->base_addr)
+		args->base_addr = map__start(map);
+
+	return 0;
+}
+
+
 static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 				     u64 *table_data, u64 *segbase,
 				     u64 *fde_count)
 {
-	struct map_rb_node *map_node;
-	u64 base_addr = UINT64_MAX;
+	struct read_unwind_spec_eh_frame_maps_cb_args args = {
+		.dso = dso,
+		.base_addr = UINT64_MAX,
+	};
 	int ret, fd;
 
 	if (dso->data.eh_frame_hdr_offset == 0) {
@@ -325,16 +344,11 @@ static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
 			return -EINVAL;
 	}
 
-	maps__for_each_entry(thread__maps(ui->thread), map_node) {
-		struct map *map = map_node->map;
-		u64 start = map__start(map);
+	maps__for_each_map(thread__maps(ui->thread), read_unwind_spec_eh_frame_maps_cb, &args);
 
-		if (map__dso(map) == dso && start < base_addr)
-			base_addr = start;
-	}
-	base_addr -= dso->data.elf_base_addr;
+	args.base_addr -= dso->data.elf_base_addr;
 	/* Address of .eh_frame_hdr */
-	*segbase = base_addr + dso->data.eh_frame_hdr_addr;
+	*segbase = args.base_addr + dso->data.eh_frame_hdr_addr;
 	ret = unwind_spec_ehframe(dso, ui->machine, dso->data.eh_frame_hdr_offset,
 				   table_data, fde_count);
 	if (ret)
-- 
2.43.0.rc2.451.g8631bc7472-goog

