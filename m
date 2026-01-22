Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D68C481ABA
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067114; cv=none; b=WP2L4gJVcZCrm1ycl2d7Qd0AjgNh1noMNFXRJiG8spsBv4O2KYQ4mvRoovWMa9PkJllLf6dYB0n0DzApyWCZKYOrlfDXV+ZzkvqgJpoRS+oPcCS5kZ07iCSe/arThkXohE9n9GoZQaJnaiF4eEls5mQWEjeKE9kEhMbzm5N2nRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067114; c=relaxed/simple;
	bh=p/53skaYkxw3FbY6a+zG/VnxhoQiWrk9vg0CARtxbUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PGNn9HKl352ok2tWL/fZu09aBQ8+0e6gOjTiyl4/6sCm4YSzq800Sol24X6wQVwB8+w5wz7j8dTVH3r9amYMaUtTxPR9YHzEFtE+shsMl1PQiIgFFmsyJ+hA7y1H0WUXDiAYpdHnlrnD09id0tGAJswkCQczKMGzHkHTt36zV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwAVxdMy; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwAVxdMy"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-121b1cb8377so1458307c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769067105; x=1769671905; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RuAcUlfLOH+Nmb5IOvdzZq6066CfyPFp8FPVv/E64Q8=;
        b=SwAVxdMyCSAc9RqvV05wFwSmWg0RGGbatx8oKkUF9aq0s2kDjuqTupnCriZf+oBMA9
         sfjeuDYPoZmRUKNfINrs9uLOfLL2EYqXb45EuWQgzVUnFRebln8PO8bsre4SKFTYMQ0a
         /DekiWPmQv/TvsyLEkvLErZF86Uj4fUjqnYxDUXaffcg48zELxlnrUXqZxQvba/O/4x7
         lTO9PS92hUeXrjXlvBpoq/3fLsoz03oyr95iTALhvbCYFS6EL2wdYsPbCgdgJndW/lJw
         S2I3khfXdWw4HOpF1XT1BSIOlFEl38jk0hGkot/kUb0RGhdlqakqwSXDvkyt0MMwqT87
         wDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067105; x=1769671905;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuAcUlfLOH+Nmb5IOvdzZq6066CfyPFp8FPVv/E64Q8=;
        b=AxeHOpul3cJ4ALzIUIIRUHB1WKHirLB32gyZ5Gq9dGxRg0iL8xBDfQDBBacYOokYXx
         SvQ1ZdWNgolhinHc8gnr6ksu9aFcaNMDwxP3DGUlrMLc8djaUDOa8cy/IEPKYaxBl90O
         y7jhJsi2geqMzCJ8GIOcPi1Yx9X3UTsNHgYA2svlgHZuUZotLEGT++B2ieEnVez/mjS4
         jIEfwTkWMgoQkWbCha+s/FwyCFTZtS7+txReUxY0km2oreE+a8RP764tf2YnoBNmII55
         S+cce9DUzw9Fq8bq/7eEJ5zXMts2U2kWOgL1fpqn8WwtzIoM1ZBgp0z4t9VWfyQK8YAx
         Po5A==
X-Forwarded-Encrypted: i=1; AJvYcCUjmuNNXV0PXSkOQIYzpLZxhyoR4e2pjoizOnE6J5yTKQd9UXuiDR5LMv/8vYeKQ6jPKHD4Mz0IxjRqnB0q6nqQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ab51rnbrmDehoIaZD/OSZZ60VxZH5fh9Za4cA7CZ9UL7pTCJ
	nq6+kxUyV6jFTgfyL2MG/V0ar0zObuuVejg7MI6RvwUG8X+POS4sPuL5RUBBtXAPdX44awzIGA/
	2Ymbnf9UT1g==
X-Received: from dlbep12.prod.google.com ([2002:a05:7022:108c:b0:11e:64d:cd3b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eacf:b0:11a:fec5:d005
 with SMTP id a92af1059eb24-1246a95600emr5252743c88.10.1769067104935; Wed, 21
 Jan 2026 23:31:44 -0800 (PST)
Date: Wed, 21 Jan 2026 23:31:24 -0800
In-Reply-To: <20260122073127.375139-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122073127.375139-9-irogers@google.com>
Subject: [PATCH v1 08/11] perf disasm: Refactor ins__is_call/jump to avoid
 exposing arch ins_ops
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Add booleans indicating whether and ins_ops are call or jump and
return it. This avoids exposing loongarch and s390 ins_ops for the
sake of matching.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate-arch/annotate-loongarch.c | 6 ++++--
 tools/perf/util/annotate-arch/annotate-s390.c      | 3 ++-
 tools/perf/util/disasm.c                           | 6 ++++--
 tools/perf/util/disasm.h                           | 5 ++---
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index 4bd651b63652..b95ae5d6657f 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -55,9 +55,10 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 	return 0;
 }
 
-const struct ins_ops loongarch_call_ops = {
+static const struct ins_ops loongarch_call_ops = {
 	.parse	   = loongarch_call__parse,
 	.scnprintf = call__scnprintf,
+	.is_call   = true,
 };
 
 static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *ops,
@@ -104,9 +105,10 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 	return 0;
 }
 
-const struct ins_ops loongarch_jump_ops = {
+static const struct ins_ops loongarch_jump_ops = {
 	.parse	   = loongarch_jump__parse,
 	.scnprintf = jump__scnprintf,
+	.is_jump   = true,
 };
 
 static
diff --git a/tools/perf/util/annotate-arch/annotate-s390.c b/tools/perf/util/annotate-arch/annotate-s390.c
index c1d06caa5f77..6d1a1da277e2 100644
--- a/tools/perf/util/annotate-arch/annotate-s390.c
+++ b/tools/perf/util/annotate-arch/annotate-s390.c
@@ -54,9 +54,10 @@ static int s390_call__parse(const struct arch *arch, struct ins_operands *ops,
 	return 0;
 }
 
-const struct ins_ops s390_call_ops = {
+static const struct ins_ops s390_call_ops = {
 	.parse	   = s390_call__parse,
 	.scnprintf = call__scnprintf,
+	.is_call   = true,
 };
 
 static int s390_mov__parse(const struct arch *arch __maybe_unused,
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index c732b015f2e8..bc5323ecb5da 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -315,11 +315,12 @@ int call__scnprintf(const struct ins *ins, char *bf, size_t size,
 const struct ins_ops call_ops = {
 	.parse	   = call__parse,
 	.scnprintf = call__scnprintf,
+	.is_call   = true,
 };
 
 bool ins__is_call(const struct ins *ins)
 {
-	return ins->ops == &call_ops || ins->ops == &s390_call_ops || ins->ops == &loongarch_call_ops;
+	return ins->ops && ins->ops->is_call;
 }
 
 /*
@@ -469,11 +470,12 @@ const struct ins_ops jump_ops = {
 	.free	   = jump__delete,
 	.parse	   = jump__parse,
 	.scnprintf = jump__scnprintf,
+	.is_jump   = true,
 };
 
 bool ins__is_jump(const struct ins *ins)
 {
-	return ins->ops == &jump_ops || ins->ops == &loongarch_jump_ops;
+	return ins->ops && ins->ops->is_jump;
 }
 
 static int comment__symbol(char *raw, char *comment, u64 *addrp, char **namep)
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 83503c5075f9..b6a2a30fdf27 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -93,6 +93,8 @@ struct ins_ops {
 			struct disasm_line *dl);
 	int (*scnprintf)(const struct ins *ins, char *bf, size_t size,
 			 struct ins_operands *ops, int max_ins_name);
+	bool is_jump;
+	bool is_call;
 };
 
 struct annotate_args {
@@ -139,9 +141,6 @@ bool ins__is_fused(const struct arch *arch, const char *ins1, const char *ins2);
 bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
 
-extern const struct ins_ops s390_call_ops;
-extern const struct ins_ops loongarch_call_ops;
-extern const struct ins_ops loongarch_jump_ops;
 const struct ins_ops *check_ppc_insn(struct disasm_line *dl);
 
 struct disasm_line *disasm_line__new(struct annotate_args *args);
-- 
2.52.0.457.g6b5491de43-goog

