Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739E387363
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737453; cv=none; b=pSkHo4NrIWsNe1GSOAg/UB4rFBaYBF2UEu3S+U2qYiwlp8xNNQ9eS47Y4BCqJ8qoZQbS2cBj+j6DrldL9xzN6+K+Ly2fi2c1a2xoaW/WrI7Q1JjVqXf2YsPnnQsJfJddSMvB0PZHLiQHtaqQCc4AylkbwJngIxYeaSa1XULPYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737453; c=relaxed/simple;
	bh=aejM4DU7JRkliTqft/Llsk1zUeLQIbJRjWsEykxh2ys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T1FUwA9onPbQptKPQb7cY9B6zYaagd8jg7xYqjlqp3JekrAhqO9XvLdGW2fmwgdMd9mIKfcFt0QeI9TSMahuPdiL43Vnx/AyMVOb6gdoDWbwbPYnFwl5PLfwdq9v+OCGyRzPocrVqvglMyGZlwOY1rGZTX8QNcvfSkRNIbj3YKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eTLixmli; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTLixmli"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso5114229eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777737452; x=1778342252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQmVm0Mk8S8yIw6NN5Lf29gNVzq8HKFVdhFBj2+c9Uw=;
        b=eTLixmliEyuBkQWOJAZLMP4GBad6asQ75oGhS9/9b0qx4BG/gigdAEiD7B0DDhiXzG
         MVehFt+x643i3Y5YzQOqy4Jw+aJwsfvXu7i3XuUO5YBcsksUM+lnXpks04/jW1r66IUl
         Q8CG0hR0has6SyncZ2hHClo2fWOv1oWYoBWFMA45IrFOT6sn1Rb1Cp/2nnrgwCb6eqfW
         Mt0jbHkWSEG+hzxuDYdMqH4T5qbrkOLXFxu1Q0fJ64FxhHsxdV1oQ3gvmOmTst+3w7Rf
         MTMbZICMhPfndS6cMDMoJbokHtOcvZVv3V3Jlksh7/DaBU1rZpHjdbzJQcAJD+kDpwFd
         PBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777737452; x=1778342252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQmVm0Mk8S8yIw6NN5Lf29gNVzq8HKFVdhFBj2+c9Uw=;
        b=RSoyz8MOaYBo7JkLGv7yl80zoQn0Cq38Dhne6yGKxlVSt8xRiF2/yVbI/2SlULNmny
         rkY3NdpkPtya5EhjzFmXkrhIkV9jj2XVU1w00UedtLGe19mofh0aotbq0Di926eRwfAF
         RuGw1WHAySH8u1ncml+AC1EssLpLnAi5R7Psz+18CEYeUWOPj3mGhmx93ed45578IkGV
         sSKsrnF6sNfUyN+I9i7xurPWkkIZSG0BZRTwEjlfIfwT3gEoGzFAYgRCFVUaBC45sEyE
         jyn/yvuJwnUbCoHQWfzLbhKzle9GMul7q5d1TZktZHPHmae0pdI0PgMx4wukdpDT2bsD
         RuVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UR5AgshEpMEUcwT5lv7dYd0zlZUxOtejH1Sa/X87A9Qw0SyzcYjDhGj4Mt6TobW1E41Y110FARnTWOQA2AkZR@vger.kernel.org
X-Gm-Message-State: AOJu0YziYxb/aaGT4/3zLcZUz9Ohr9XG5IrtxQbndf/gAgZtcB0Vx7dl
	la5pzfFaovLj2+CxZWdPiDBt0we7bCQuVlRbijiQyTPVpO4qvcHV41OvhqrnJYWaJtD23BF89s4
	rbJjxScrULg==
X-Received: from dlad7.prod.google.com ([2002:a05:701b:2207:b0:128:cfd6:a3c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2412:b0:12f:1f67:e744
 with SMTP id a92af1059eb24-12f1f67e7f4mr258370c88.44.1777737451549; Sat, 02
 May 2026 08:57:31 -0700 (PDT)
Date: Sat,  2 May 2026 08:56:56 -0700
In-Reply-To: <20260502155656.478642-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502064839.282422-1-irogers@google.com> <20260502155656.478642-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502155656.478642-7-irogers@google.com>
Subject: [PATCH v2 6/6] perf debuginfo: Fix libdw API contract violations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Check return value of `dwfl_report_end` during offline initialization.
Validate `dwfl_module_relocation_info` result before passing to `strcmp`
to avoid potential segmentation faults.

Fixes: 6f1b6291cf73 ("perf tools: Add util/debuginfo.[ch] files")
Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debuginfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 0e35c13abd04..49cb7f9b715d 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -62,7 +62,8 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
 
 	dwfl_module_build_id(dbg->mod, &dbg->build_id, &dummy);
 
-	dwfl_report_end(dbg->dwfl, NULL, NULL);
+	if (dwfl_report_end(dbg->dwfl, NULL, NULL) != 0)
+		goto error;
 
 	return 0;
 error:
@@ -167,7 +168,7 @@ int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
 	/* Search the relocation related .text section */
 	for (i = 0; i < n; i++) {
 		p = dwfl_module_relocation_info(dbg->mod, i, &shndx);
-		if (strcmp(p, ".text") == 0) {
+		if (p && strcmp(p, ".text") == 0) {
 			/* OK, get the section header */
 			scn = elf_getscn(elf, shndx);
 			if (!scn)
-- 
2.54.0.545.g6539524ca2-goog

