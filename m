Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24DE1A8F97
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767788; cv=none; b=SL2Z+wEgGe6k8loiLloR6c0GrXoZhBz0KSkwQ7fmxAuYfSwWhS6eZhUwpwaA6Gli47ysw4veL4Uj9XUVsP0EzxhXdelJdhWSQNTehm0QThvHEYtKOC4Pw/PCdjTNx83IuDA4BVCIzTXDFO26V8oD+7FFaj8mU9ux8JdEUWwSWFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767788; c=relaxed/simple;
	bh=AU7EKzo/kXrsAjfgR40n40MqM3yvsMJ1cD4bHl4i3uU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J/6IkQzlURFDYPCdT0BL8+BrjED6Dt2opIQNxuvL5gdSMBDuzjS4VDNhbPnWBkAxCnZuGVYxJpTzqnfP8JYp/jw2EpOSlcy9L84W0PWKluNN4pwqKsLeF5k9c7v9FrqRXJYAa4vp9KLquGb7nC5TpMI8tIg3srJyzagLwowFcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vT6C4J10; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vT6C4J10"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dbf4f678eso16486186c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767785; x=1778372585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mje3fRK1Ca3WEYFTmWriS1ZD47KIvC5apYOlB73RA4c=;
        b=vT6C4J10HPbUjs0bkIL076r272onB7owiR2QoBkiuSqR+dNTQDR+qrFQNbWxXTq79I
         RYJy07r803GihksM6UlqxPRpqOZTjZjnxRY8gdIO4bHSpc3nDAhucfzSnCer1TzNpitu
         Qs+DLPrPiO91LkXMWSQPBTlh2+99nddaorovVe3Mu+vi8RaQ8BbQ26GWzstXsGp2Af2x
         CFOc1m7GbQWnSJ/bSq231hR7lqiBSGzXVFtDUFZyVx29I+NTAscJ+SlCPB5z7juy0AZB
         LqVw1YQR9j4T0rrwe9KloahPdPmkjeDak1IrMftf6LwsWM/3PgnJi4u+2eisQRXjnMNc
         BW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767785; x=1778372585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mje3fRK1Ca3WEYFTmWriS1ZD47KIvC5apYOlB73RA4c=;
        b=ZEmmfLMIv8lDOAIoXabCtAjhndQu4SmEvCn2i8suZsm/sFSsekDljPosJ5TlteTiXv
         dtW6F8TfgYc9SNSB1MSkCEiLtwbAjy41uv85ggMHcOM8m2GniwDxyO3q0GPBcBpsRK34
         e11YIJMGpyUWWZDyl4CWkIVTemr0fTTPOqGB2dsYROSAz8dHpjlVwUl+h4LJIlt8y9or
         aSD/6+yG4mSfnav6nhbNJTiFbyCtwmR9HNDF2i6UTj8/3z/kQpkDBtqaGN63XVdDloFJ
         Wggv8dRZC5qTgG9+rbwJaestNpkwqv0qFGMOTCuy9siSqAcbXQMa8NgUAzlrCYpvL1es
         b0fg==
X-Forwarded-Encrypted: i=1; AFNElJ+83sLJwR0bwATiDbBtq9FgapWefTBMXRZzRMgGju0AWGJGk7m98BqmuZwYGk5T4J4obGXaoZvLXx4s5YxIlrHK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MNS9uIiLg/GTlqopj8XJnOMQD8qn80UL1YDWChV8/iaH+Vbw
	ImwFEx8NBini6Uh1cU7GKqnpRRKNqeeNZjWhay1BOW3HubaPl05w6DZ22bGwmRBmHWJjqz4qS5S
	yhL8XQUwM7g==
X-Received: from dlbsv4.prod.google.com ([2002:a05:7022:3a04:b0:12d:b86f:f7a6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fe05:b0:12d:b28e:75b1
 with SMTP id a92af1059eb24-12dfd81a89fmr1953500c88.22.1777767784628; Sat, 02
 May 2026 17:23:04 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:36 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-7-irogers@google.com>
Subject: [PATCH v9 06/18] perf symbol: Avoid use of machine__is
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
 tools/perf/util/symbol.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fcaeeddbbb6b..a4b1f837a5a5 100644
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
+		if (machine_or_dso_e_machine(machine, dso) == EM_X86_64)
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
 	}
-- 
2.54.0.545.g6539524ca2-goog

