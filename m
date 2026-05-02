Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA632FF170
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705213; cv=none; b=uPGCyn/dGvr6ZjoPDfduZfgC1JLeyICQH1ogDMqtkQd2Lh+GGSKUoPvlG3t6tWrqdcvuolCfwoX59zHKWyyybEa8NiAbmSGtMYIBOP93cI15Z6bGYxA5MH3wc/uM0Pqu7JDNFLEMxL7HhbyJuxy27WHOGv/V/qpj2oKf2gJjJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705213; c=relaxed/simple;
	bh=KuACTPu6OuS48J4FtO0bd/dTI2geNdASrJW/13fBdHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J6pf1nfMRKSKsvzMAsitKREO6qrzuXhORQxlAWiE4Dt2ESn7Ua8CauPFqKGz8ZQkABYtCdMYsWA7XzCptYTHZMO9/+eAvBjC+8sAQodvO7Drn3nP7We4HyQq/duUW8sH0GAbK0XoWi7EUABVbB60eLiuWhnzZrKrlX4xTNALQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRJctNu7; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRJctNu7"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12df9e440d3so2131653c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 00:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705208; x=1778310008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZGT+VJn1AUc670crxwfqYjQB0IuuY3cfwhTbHMCMmg=;
        b=DRJctNu7msNC7Xn+fCJNnWOJBSwf1PAfNeCQrzLehHJhY/4qdAmXJdTFkaBc6uTxlG
         tst1zbOLrO8G/gL23iUOvjspyDqoS1bdmXHw15+cvJXBLpE3DUvM82k5ubYjpuxRisxq
         s9IkAJwDYoHbBWq9T0+0FpWH1yLugpVE1jyjNPGbxTZVhTYpJkZs/aUE6YL48rGd790z
         yIE1Lmz/HAS1yBo+BGauRoc2qjktqCDFhmbzQHwSMnvnQHIy+lukTSZm/fqaxOXPPvi9
         00EhBCDvrKavmM4/vdYmR96T2/2zyzO9azwhsM5oSj5RpMGHZKslFpcw/BcsvZYiasud
         L37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705208; x=1778310008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZGT+VJn1AUc670crxwfqYjQB0IuuY3cfwhTbHMCMmg=;
        b=MCsiz08p+DoFlY5iEOr5IfN1F33Jy27vdRMd+ksa19+BSKLutlDIgr2vdOdW96W6m1
         5Pa1bMTvtz9vGd0MxryrGakbhDx8nyoxbaetGmZAsNKUX5UhdQnF6lwUM1e/AenXFXJ2
         af8W7i7xQz2xwrn93vs+VEcBY6Ct7wlFLpE6+YD1sI2VR95OENljdP3QYyDLbzCHassc
         HtjvdxG4IUZdWv3xi8F5AhlgOrqGMvMLOmAOzR//JxBRysK6lptFmkOEs/A1yJsjvy6x
         3hQlIWXzC3GEh50YTqRpiUjDEuBGzC0Fvs9W9LO23F18HXGk9pjC8zGeCMoQ0qmcARuD
         TXWA==
X-Forwarded-Encrypted: i=1; AFNElJ9App2PRYoq3GOib2pLlmyNMT42rr6s71R/jYNgGz6JuWU9eGbVWeHgmM5MM/NIhZvxp4dKpxCZG28SQLgcJKJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YzmlezdWLCVycTS3IZEfFKU2pbno47zXw2zzD7rxCSDQI8s6WSG
	txXpmPqzcOUAINSQdAW9s8JkJpmy/cNPFYWzB55ESo0UlM8E/W/yZgf+5WNszsO4+i92DPfr265
	HRRIsPWhbmA==
X-Received: from dltt17.prod.google.com ([2002:a05:701a:c971:b0:12a:c5dd:73f9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:23a5:b0:12d:b396:eade
 with SMTP id a92af1059eb24-12dfd7bb139mr1092145c88.3.1777705207872; Sat, 02
 May 2026 00:00:07 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:26 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-9-irogers@google.com>
Subject: [PATCH v8 08/17] perf symbol: Avoid use of machine__is
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch to using the ELF machine from the dso or running machine rather
than the machine perf_env arch that may fall back on EM_HOST. This
also avoids potentially imprecise string comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fcaeeddbbb6b..8aaaab0ad4b7 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -851,6 +851,24 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	return count;
 }
 
+static uint16_t machine_or_dso_e_machine(struct machine *machine, struct dso *dso)
+{
+	uint16_t e_machine = EM_NONE;
+
+	/* Check for a cached value first. */
+	if (machine && machine->env && machine->env->e_machine != EM_NONE)
+		return machine->env->e_machine;
+
+	/* DSO should be most accurate */
+	if (dso)
+		e_machine = dso__e_machine(dso, machine, /*e_flags=*/NULL);
+
+	if (e_machine != EM_NONE)
+		return e_machine;
+
+	return perf_env__e_machine(machine ? machine->env : NULL, /*e_flags=*/NULL);
+}
+
 /*
  * Split the symbols into maps, making sure there are no overlaps, i.e. the
  * kernel range is broken in several maps, named [kernel].N, as we don't have
@@ -866,14 +884,13 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	struct rb_root_cached *root = dso__symbols(dso);
 	struct rb_node *next = rb_first_cached(root);
 	int kernel_range = 0;
-	bool x86_64;
+	uint16_t e_machine = EM_NONE;
 
 	if (!kmaps)
 		return -1;
 
 	machine = maps__machine(kmaps);
-
-	x86_64 = machine__is(machine, "x86_64");
+	e_machine = machine_or_dso_e_machine(machine, dso);
 
 	while (next) {
 		char *module;
@@ -925,7 +942,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			 */
 			pos->start = map__map_ip(curr_map, pos->start);
 			pos->end   = map__map_ip(curr_map, pos->end);
-		} else if (x86_64 && is_entry_trampoline(pos->name)) {
+		} else if (e_machine == EM_X86_64 && is_entry_trampoline(pos->name)) {
 			/*
 			 * These symbols are not needed anymore since the
 			 * trampoline maps refer to the text section and it's
@@ -1428,7 +1445,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		free(new_node);
 	}
 
-	if (machine__is(machine, "x86_64")) {
+	if (machine_or_dso_e_machine(machine, dso) == EM_X86_64) {
 		u64 addr;
 
 		/*
@@ -1716,7 +1733,7 @@ int dso__load(struct dso *dso, struct map *map)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
 		machine = maps__machine(map__kmaps(map));
-		if (machine__is(machine, "x86_64"))
+		if (machine_or_dso_e_machine(machine, dso) == EM_X86_64)
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
 	}
-- 
2.54.0.545.g6539524ca2-goog

