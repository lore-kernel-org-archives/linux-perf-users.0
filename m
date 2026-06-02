Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC483A7587
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381527; cv=none; b=Rl6bQQU1f7zPwEeftUGuB1JDPjme5zGZPZwYHeZtOnnyEvg4xKtHrlLOb+oM2JUPobv7eRBMZt8r7wIGrHjw6nIcMUMy3MjXuYEylQtgCFd4hs1M6J9AokouWhDuAgJ/4jcHAxCXixpAYQhg5UeXj9lsYXxVb/qruJu1E40TEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381527; c=relaxed/simple;
	bh=0E8FGILepgrTA6ONyBxd8a3wp5kiZDScmQzg7pssilk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dFaHwfTEI8qbmrb7MKlS84qoHRpcEP9kap/vA1JLdHZqBhyiY/+yXMhY17rWqQZm6GWKB04Ljm+tyqzzaEVXvsrgE1S24dC5A6oArejqnGWIxbXNyeFwayW7TikJS7WINmpgQB7ZZgi2u/GDxKJ/on+yYs9/Kc2ptEclct8haX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Encjqj4Z; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Encjqj4Z"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137276019cfso9267398c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Jun 2026 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381523; x=1780986323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/QgB1qOgUmUCrnPstfXNyo3WG7TO2qaKYGbmxO6cXBE=;
        b=Encjqj4ZAKg5mJcwc0bmvhvOrfLyVrxuKf2Xju5npBEMJy0MI5eRcxTuwipSyGSMGO
         C/HCY61XfUrCCgDD9K+uznAQF0rjmNF6/E2P2bIwnXcyydS2pB269Il9ZygBGuyLkYC+
         I7d6shqncCWjIERig/2KjGW37ayNZACCVbRLl5PT54T6qynfR+Ss6v0U0MdaQ0VlQ1ig
         /3CkNwfFsFqBjLEjJYolxtRvQfr+HVz0kUqbt8gDvEgGwuck5IjMWUbUbyMPztPLUKhR
         CDv5m5LIiY7NV5UHn9ACgpLGS1OpSLtr4nOXlDuaBTi5XVeoJixwWcE3GRBaSBa0x1Yg
         JOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381523; x=1780986323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/QgB1qOgUmUCrnPstfXNyo3WG7TO2qaKYGbmxO6cXBE=;
        b=aaDYJFotZvpVbvK0fnRiTQTweBQ7oB4Elg0IBgab6foYO5FuZtbQqv53cN3ri7j45L
         iKPOWyl7z0qYX1V8nKn4LMY+A81w9/PQF8k8BpYUbGXh79hHUd5AGvSSP3+SyEZsfwEO
         sFoXDL9XPTKxtlq3BbrZmwD3scpQCw3+oyfVzZQIDk45HSxEU4SpD2mcD6sXmmPkfYgh
         UkmVHShcnCxVqwqJcfx82JiNnQodNZIqfLVzcB4MPmnbGpOO2D46MhL6+TZmz+/E5Eft
         Nhtf+6bolREMivSV379dcpb6ZnLFa5UemjN+nnAo8RKWQzeY1MlTuNA6L46geaVYe6Oe
         KKHg==
X-Forwarded-Encrypted: i=1; AFNElJ9PZClqNTNo1qHZjk5R6laNkv3zt5PbPAEXmwIOxndVn2MQwm4L2GdteUTNDUQCJ0fXakbhEZDMUG3+VQMLvKLy@vger.kernel.org
X-Gm-Message-State: AOJu0YzUI+9uQEA7gVn7rjkvWv9Au+tq0S/UHE09/cBR7/SZ8c+itZLG
	d/cQrvHeZdxmdAWuKvuA/hqbbbBhOltLcXLgK9JtoSeDHwrwp7sfACwYWIrcYnA8PE1bwOH2l9V
	9TjY4gP8Jzg==
X-Received: from dled10-n2.prod.google.com ([2002:a05:701b:42ca:20b0:135:30b6:b9dc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2211:b0:137:ea00:3f3a
 with SMTP id a92af1059eb24-137ea0042e4mr1120906c88.9.1780381523005; Mon, 01
 Jun 2026 23:25:23 -0700 (PDT)
Date: Mon,  1 Jun 2026 23:24:38 -0700
In-Reply-To: <20260602062452.2583619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601065407.1597927-1-irogers@google.com> <20260602062452.2583619-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602062452.2583619-7-irogers@google.com>
Subject: [PATCH v11 06/19] perf symbol: Avoid use of machine__is
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch to using the ELF machine from the dso or running machine rather
than the machine perf_env arch that may fall back on EM_HOST. This
also avoids potentially imprecise string comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 714b6e6048fa..2ce512f08a1d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -851,6 +851,23 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	return count;
 }
 
+static uint16_t machine_or_dso_e_machine(struct machine *machine, struct dso *dso)
+{
+	uint16_t e_machine = EM_NONE;
+	/* DSO should be most accurate */
+	if (dso)
+		e_machine = dso__e_machine(dso, machine, /*e_flags=*/NULL);
+
+	if (e_machine != EM_NONE)
+		return e_machine;
+
+	/* Check the global environment next. */
+	if (machine && machine->env && machine->env->e_machine != EM_NONE)
+		return machine->env->e_machine;
+
+	return perf_env__e_machine(machine ? machine->env : NULL, /*e_flags=*/NULL);
+}
+
 /*
  * Split the symbols into maps, making sure there are no overlaps, i.e. the
  * kernel range is broken in several maps, named [kernel].N, as we don't have
@@ -866,14 +883,13 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
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
@@ -925,7 +941,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			 */
 			pos->start = map__map_ip(curr_map, pos->start);
 			pos->end   = map__map_ip(curr_map, pos->end);
-		} else if (x86_64 && is_entry_trampoline(pos->name)) {
+		} else if (e_machine == EM_X86_64 && is_entry_trampoline(pos->name)) {
 			/*
 			 * These symbols are not needed anymore since the
 			 * trampoline maps refer to the text section and it's
@@ -1428,7 +1444,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		free(new_node);
 	}
 
-	if (machine__is(machine, "x86_64")) {
+	if (machine_or_dso_e_machine(machine, dso) == EM_X86_64) {
 		u64 addr;
 
 		/*
@@ -1716,7 +1732,7 @@ int dso__load(struct dso *dso, struct map *map)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
 		machine = maps__machine(map__kmaps(map));
-		if (machine__is(machine, "x86_64"))
+		if (machine && machine_or_dso_e_machine(machine, dso) == EM_X86_64)
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
 	}
-- 
2.54.0.929.g9b7fa37559-goog

