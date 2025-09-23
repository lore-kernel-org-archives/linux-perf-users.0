Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B92820A3
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601148; cv=none; b=qUj9N2tZ4IMD7/WROZKu8GbAVgif4MhoVJFypeceHbrYxf5Yon850fzMSuDfHOU5Pk1aVuxThkj3xCHUeboiofSfyFeF2YgAATBGCqKYmEgAKhPih8OiMFWaltKPQPZfwEBVXkthWAJXEnhJTvScvguQiblKVFTQbquiojNyS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601148; c=relaxed/simple;
	bh=A7ME6lBRxNDqwUqz8g1s1XDCmohN7azXW8DlDooqfI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YukJr2zOHqKnwEkiS9GRbPUPvJZEt4LOBm0nVGXcN7pZqIT9Ys5RE9LWJWoSAyraChRpWSFT7bWq748JkzDFCA+Qy/fS5BoqLs/+w0kyeQEl37otkmqFgt+47u+h9AhI6u4BoPrZYQ3710nPGg7LyiUOkDe76jbCkU/dGjHH7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JF14p8xy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JF14p8xy"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso4355737a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 21:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601146; x=1759205946; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmM+YDTHkakrcbqR3dL1OE9HXiYEwJsKu0xmPObyyj0=;
        b=JF14p8xyheuRbFWQ4/8pHNNYGwepOIx3zAtZ2KQ8uos8JUGrgoCcBsKNUxQDhnYwct
         h9Wsce+VNjqxxmtBusgv4YxIH3oTmgXmC6yJGXeGkcatXqy0Pfr5baXTmMEbRSy/qFxc
         N+joTeJeZcOjKkkYbLRiTszxrZPwTAPpcY4fnNKzgxgrWF7rvl3mibpcqpp0osQi0gXp
         qk+WFuVqHJusLSdL0IMVPlKBOJ3EorEWew2nmQpMc2/fSs5OD+BC8FYiLZn71QnbDmpX
         vi1ZhDi/omoksDZ7T/jjyztch5qz1rv17fQC8TJzgmi95a9PjL6H9o1s/wdlEFaXvYpG
         ErGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601146; x=1759205946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmM+YDTHkakrcbqR3dL1OE9HXiYEwJsKu0xmPObyyj0=;
        b=qwRXAgQ3JLcL/c2wFSRQw7q5qkIkq7lA7ndv1h4UmmyMJ+KS2+NQ2rerwMyyLdmrrP
         pgBk5DF73Blchc75q/UmZf9mQMl3OVm7FDZBqEXk7iRc/GRQgHYzrmXoCs4BD60Ivseb
         KJC+sM2cB6n/rZv2FQvdQPfwhJ4739tHx3T+0LpIKbcjkcUmF6rIIMgH1Npm9HajhOvU
         cf+QrYRkT4taZFq4gC2oYz7cIJcAPvwcQl3kfXfyiW9HC1luPwnq88CYNLFylKRcRoIp
         K+rmWQ3oQ3N1LKSudgKjIojsBQwIlpDNTAMv689Gx11WnMadtH1AtWS6IH9kQm8szXpb
         7/AA==
X-Forwarded-Encrypted: i=1; AJvYcCVMfAiFkCmSyhaBjyc5NtAMViqq38Jb2LezkpZHgCfVMdhJEAtXOwKSQcyXDrOxZZHwy7g9aT8xrar0noVrZ/na@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68RI+dtK/IUZ2FVv/INQqxVzc6YAfEyVm7Cz+81Xsv9u9LqdT
	BXY9lzfW3csn/lkuyXKmihwgWHxdfKTnLhbILktCv1o6o+JGjt0mAod189lYO2PDObpfDw9n+XS
	k4QQ2Ts0Pyw==
X-Google-Smtp-Source: AGHT+IFbh1jkZfZ2v/I9g7Flj1gfah00Au8YTQI4DY9zWwtoBXbQPLmiSsrhR7z1uJsUQorfbOMfPRzfa5SM
X-Received: from plmd22.prod.google.com ([2002:a17:903:ed6:b0:268:cfa:6a80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea05:b0:245:f7f3:6760
 with SMTP id d9443c01a7336-27cc9d715c8mr14002435ad.55.1758601145907; Mon, 22
 Sep 2025 21:19:05 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:27 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-9-irogers@google.com>
Subject: [PATCH v5 08/25] perf pmu: Use fd rather than FILE from new_alias
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

The FILE argument was necessary for the scanner but now that
functionality is not being used we can switch to just using
io__getline which should cut down on stdio buffer usage.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b44dfe4c73fc..818be59db2c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -563,7 +563,7 @@ static int update_alias(const struct pmu_event *pe,
 }
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
-				const char *desc, const char *val, FILE *val_fd,
+				const char *desc, const char *val, int val_fd,
 			        const struct pmu_event *pe, enum event_source src)
 {
 	struct perf_pmu_alias *alias, *old_alias;
@@ -614,12 +614,15 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 	if (ret)
 		return ret;
 
-	if (!val_fd) {
+	if (val_fd < 0) {
 		alias->terms = strdup(val);
 	} else {
+		char buf[256];
+		struct io io;
 		size_t line_len;
 
-		ret = getline(&alias->terms, &line_len, val_fd) < 0 ? -errno : 0;
+		io__init(&io, val_fd, buf, sizeof(buf));
+		ret = io__getline(&io, &alias->terms, &line_len) < 0 ? -errno : 0;
 		if (ret) {
 			pr_err("Failed to read alias %s\n", name);
 			return ret;
@@ -698,7 +701,6 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 	while ((evt_ent = io_dir__readdir(&event_dir))) {
 		char *name = evt_ent->d_name;
 		int fd;
-		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
@@ -714,17 +716,12 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 			pr_debug("Cannot open %s\n", name);
 			continue;
 		}
-		file = fdopen(fd, "r");
-		if (!file) {
-			close(fd);
-			continue;
-		}
 
 		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
-					/*val=*/ NULL, file, /*pe=*/ NULL,
+					/*val=*/ NULL, fd, /*pe=*/ NULL,
 					EVENT_SRC_SYSFS) < 0)
 			pr_debug("Cannot set up %s\n", name);
-		fclose(file);
+		close(fd);
 	}
 
 	pmu->sysfs_aliases_loaded = true;
@@ -1041,7 +1038,7 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 {
 	struct perf_pmu *pmu = vdata;
 
-	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
+	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ -1,
 			    pe, EVENT_SRC_CPU_JSON);
 	return 0;
 }
@@ -1090,7 +1087,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 				pe->name,
 				pe->desc,
 				pe->event,
-				/*val_fd=*/ NULL,
+				/*val_fd=*/ -1,
 				pe,
 				EVENT_SRC_SYS_JSON);
 	}
-- 
2.51.0.534.gc79095c0ca-goog

