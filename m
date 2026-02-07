Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C730AD10
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Feb 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770452689; cv=none; b=JYxjaLEf9NvxmdPt0JQJmz921bVAT/OrvnXUpX//IlBsiUz0jLAfryOC3kHmBH5A3v54o4QcxGjiKhvV9u2EG069SjLTEIgFzDoE1lsI1nyxVjl2xNdaRL5w5Mcvu0+aAmLND7oUWAlcvdWChrtZBGuL3LY65w+9whn99vPP9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770452689; c=relaxed/simple;
	bh=jBXkwhJU0ZdvAAHhKdLYOjGv4tsONXYvOgs5iMwxwUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a/qA8zIRobTBcNOd/lMkGEHBLG3dKXXXELvK5kJvwzW+Kcqq2UQHEQYfjscjKfgjgEDg2yS4Z5sMaaxsewOxTZKjvJI+Pg3Fqu+G0GAWDunSuX/gpNoF7bqaaIBqIde0tF+t95W+4z6PFv2wX3hDtbmfjbAk0PGknvZ3JH5s6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNOeoAea; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNOeoAea"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270be4d176so8202980c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 00:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770452689; x=1771057489; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDQ88E5cIiIk78l45X12qXAsWQanRerQ44tUWmnKJpE=;
        b=HNOeoAearbLNSXid/WoKzxHviv39RiEOLebfYfUbmdDgtmTWBx40mCNlIQG73ErvKz
         EUayuq5madJl4ZYtPWr16jLYofKnVj4hDYNdPHiaVCWmVnhdjdFh3pKxYiOjAx5jNALX
         SishHQx0ctf4oqKXLTFBxQS9kH66Q6uYh2I/5Ymt4Ss1Wp8Ypkhxw7dYmhBpPdix5/UE
         nkoNAjeDtrt7hvLHrrgaGvfVURo0JWwAI8j3BgFbbF17gf4o01KhG/nU+PMsQTaTJS75
         g9C91xCppqbE72BOlReUMAXnDumSzzZyFZoyUFJTA2asVn1onGrVYNx4zvD6UKIagg6j
         XOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770452689; x=1771057489;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDQ88E5cIiIk78l45X12qXAsWQanRerQ44tUWmnKJpE=;
        b=LDGaBsUJWGJgnFXB38IyOsnWLXhBmMyFBwk2yNN/GAFPZ8T5mdtcs9RTiId+opIfBK
         6IRgPR4EnFo4iioh2nd1St2RpEXm77Z22YCBCOE75XOJYYV9VqCYofFwSxukPEOm3a9e
         4xF4umjWGebYgJJ4Rl2wXElXie34eyKpMuk92Fkwzhn5PCMgcDm7nyqjMXQPfzLhCcKt
         GR7Rs3Hejn1oGSo6WajwWlJryt06thjubZRKfBIZ8K3KefMhtme+I3PQHMPu39+nu6Ap
         XpZRGMNTd0MStXqAGTAz86NNMTHQYX8QBAo+kW3MIz1uemQFZQX/ezRYFmm6jHe0GJjW
         jBVA==
X-Forwarded-Encrypted: i=1; AJvYcCXnU9BCRQiYiohPWX7IdHENXuxeiCzXWQD0p4yNDdVDDV+L5jc8B6tgY1K3UujKUERpEG/9hwkA+oFSO9xAhb5a@vger.kernel.org
X-Gm-Message-State: AOJu0YwincNRt38PEChRX/3hNjuklfR586rtCCM/tO153Ax6zGTgeqIt
	oMcH5t92yVz0/P4tU/TYdFhr7I5ZqHqu9KDQZML7hkN1MeHcWiWNhDvMBjjw2AFWMDn5tejx+Ul
	x6f6aCi6obg==
X-Received: from dybpt13.prod.google.com ([2002:a05:7301:408d:b0:2ab:9468:d9cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:caca:b0:2a4:3594:d54e
 with SMTP id 5a478bee46e88-2b8568339e2mr2911177eec.27.1770452688575; Sat, 07
 Feb 2026 00:24:48 -0800 (PST)
Date: Sat,  7 Feb 2026 00:24:25 -0800
In-Reply-To: <20260207082428.1742209-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207082428.1742209-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260207082428.1742209-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf dump-insn: Remove dump-insn.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Eric Biggers <ebiggers@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dump_insn and arch_is_uncond_branch are declared in
intel-pt-insn-decoder.c which is unconditionally part of all perf
builds. Don't declare weak versions of these symbols that will be unused.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build       |  1 -
 tools/perf/util/dump-insn.c | 23 -----------------------
 2 files changed, 24 deletions(-)
 delete mode 100644 tools/perf/util/dump-insn.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index bcccad7487a9..89de23dec401 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -149,7 +149,6 @@ endif
 perf-util-y += cs-etm-base.o
 
 perf-util-y += parse-branch-options.o
-perf-util-y += dump-insn.o
 perf-util-y += parse-regs-options.o
 perf-util-y += parse-sublevel-options.o
 perf-util-y += term.o
diff --git a/tools/perf/util/dump-insn.c b/tools/perf/util/dump-insn.c
deleted file mode 100644
index c1cc0ade48d0..000000000000
--- a/tools/perf/util/dump-insn.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/compiler.h>
-#include "dump-insn.h"
-
-/* Fallback code */
-
-__weak
-const char *dump_insn(struct perf_insn *x __maybe_unused,
-		      u64 ip __maybe_unused, u8 *inbuf __maybe_unused,
-		      int inlen __maybe_unused, int *lenp)
-{
-	if (lenp)
-		*lenp = 0;
-	return "?";
-}
-
-__weak
-int arch_is_uncond_branch(const unsigned char *buf __maybe_unused,
-		   size_t len __maybe_unused,
-		   int x86_64 __maybe_unused)
-{
-	return 0;
-}
-- 
2.53.0.239.g8d8fc8a987-goog

