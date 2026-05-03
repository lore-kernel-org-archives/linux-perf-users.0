Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E41A8F97
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767785; cv=none; b=Tg6eMlqTIh+T2v6F9T6nh5aKj2K5JWQ7OZtzNoP1Ei4p+MIaDRCkBH2WUzCd8w8O6jeKFlhJbd5b4dhfFdeHcEyTvdd+t707aMZXdqI1seNX8+B2auktW2gCTgVc1xx/aGlyb7tChpDQJqnYkFvVoSD1yMKlZ3l2MtYNQaRJk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767785; c=relaxed/simple;
	bh=9QpqEPy+XyRDsxWYvbQ4axWxs+A3ZbBA767almG0lQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UrQHbiD9Fu/PVi6Rzm7j87+BWGtVwFaujijEZt6/cK9mi3kroxB4IYMHAuOkODSGD23sCSk16Qz88A6X6DZ36NbJZgb0+5YLSo+wERfq278MuLlcLEYQ9T+Yd39IfUG8RbgAjf6UL9zu0uu3mggK8UUjLj/1zHt5GZ2fVRBE2do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGxvUwA8; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGxvUwA8"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dbf4f678eso16486147c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767783; x=1778372583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeQPgFPRPmQNsYTAg5Wkl/fjmvLR66LnLvQXotERGZQ=;
        b=qGxvUwA8Eg3nnr5TR71ZdWacGRIXpgNCRK8oYfpUbxtR2roOi1SeCcltRflUD0yOV7
         wKeM1QmgZDiP4OvsfXGpA6ASZzC3z+USfCE/KIs+d0Kbe6yvpF/esmNj4VWfXsYLDPt3
         8cuE9y0SyzW9UkaEgoKmFcn+qbMJaJxiSoKw02FkC2aw/nQEVdLIrKXrckqO2wvV8BNY
         gQnXAdNAhGL4+b3QILsMVfA8QBT+GhaJFPc31g8TQGsub9Xq9IgoR/ydGeby4fkOxEla
         uBaJbwJ6QIL9fcLUn1hoiIyu4jw96RKcSmzZrjD1utXcTKbTxJBQV00q0mHMyb/3vqxr
         Sa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767783; x=1778372583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeQPgFPRPmQNsYTAg5Wkl/fjmvLR66LnLvQXotERGZQ=;
        b=BE6rXpFIOhV04vMQ0ivsMJ8/rO7JZuNSJoTfaZ0XIeYHLi2zDsCLqoF099qL228H+k
         5/Fsgw123anBHKkAum1GN1GWP64sQvZdTGvSLMDk2pD7HyMA3eDKleT/DVEcVQUkFjtp
         VdELX1qX69ldQ+FbTI3ekDSdQXthTdQRr6HtDCJfer2Pt/gfVougN8EArOpEcPqwMnEa
         1bTmrtG/Gnn55VX44PuFa/ZMkUZSzitW662FoI/99PIAYRhYiWs3iprs9946+OG47F5p
         xAuvhQ6NqwjwzdgUbkKeL73jLW+M1XgzjHcKje+qubhYPHH4amiIaal8oZ0aqNMAdZVx
         dwvg==
X-Forwarded-Encrypted: i=1; AFNElJ+ovqkVSFnGbJHGGNGKMjxd56ssa39iYaUCwd0ifrg7JOwWONiHjP+cph3rP5Qgnc3b8nMpwRWvXa/z6fkbPEXF@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUNi68JPvTqljTBgeX8ww1BUyM/x6ed3izVWqvw4EGE4IKrZV
	h4M78ZOJYSaB4RkQZLJiuOSSGTuyN5dbuWTW8PSf04Ut/Qt40xLfurIkFmMljW600gKM+LqP9I9
	yujcfbnHImQ==
X-Received: from dlbcf14.prod.google.com ([2002:a05:7022:458e:b0:12d:ba61:2512])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a:b0:128:d2b3:5df
 with SMTP id a92af1059eb24-12dfd81a65emr2186874c88.23.1777767782878; Sat, 02
 May 2026 17:23:02 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:35 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-6-irogers@google.com>
Subject: [PATCH v9 05/18] perf print_insn: Use e_machine for fallback IP
 length check
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Avoid string comparisons with perf_env arch, switch to using the more
precise ELF machine.

Sort header files and fix missing definitions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print_insn.c | 23 ++++++++++++++---------
 tools/perf/util/print_insn.h |  3 +++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/print_insn.c b/tools/perf/util/print_insn.c
index 02e6fbb8ca04..4068436f26ea 100644
--- a/tools/perf/util/print_insn.c
+++ b/tools/perf/util/print_insn.c
@@ -4,19 +4,24 @@
  *
  * Author(s): Changbin Du <changbin.du@huawei.com>
  */
+#include "print_insn.h"
+
 #include <inttypes.h>
-#include <string.h>
 #include <stdbool.h>
+#include <string.h>
+
+#include <dwarf-regs.h>
+
 #include "capstone.h"
 #include "debug.h"
+#include "dso.h"
+#include "dump-insn.h"
+#include "env.h"
+#include "machine.h"
+#include "map.h"
 #include "sample.h"
 #include "symbol.h"
-#include "machine.h"
 #include "thread.h"
-#include "print_insn.h"
-#include "dump-insn.h"
-#include "map.h"
-#include "dso.h"
 
 size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 {
@@ -33,13 +38,13 @@ size_t sample__fprintf_insn_raw(struct perf_sample *sample, FILE *fp)
 static bool is64bitip(struct machine *machine, struct addr_location *al)
 {
 	const struct dso *dso = al->map ? map__dso(al->map) : NULL;
+	uint16_t e_machine;
 
 	if (dso)
 		return dso__is_64_bit(dso);
 
-	return machine__is(machine, "x86_64") ||
-		machine__normalized_is(machine, "arm64") ||
-		machine__normalized_is(machine, "s390");
+	e_machine = perf_env__e_machine(machine->env, /*e_flags=*/NULL);
+	return e_machine == EM_X86_64 || e_machine == EM_AARCH64 || e_machine == EM_S390;
 }
 
 ssize_t fprintf_insn_asm(struct machine *machine, struct thread *thread, u8 cpumode,
diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
index 07d11af3fc1c..1f2c2f25f973 100644
--- a/tools/perf/util/print_insn.h
+++ b/tools/perf/util/print_insn.h
@@ -5,6 +5,9 @@
 #include <stddef.h>
 #include <stdio.h>
 
+#include <linux/types.h>
+
+struct addr_location;
 struct perf_sample;
 struct thread;
 struct machine;
-- 
2.54.0.545.g6539524ca2-goog

