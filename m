Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB42E822;
	Fri,  7 Mar 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361704; cv=none; b=aXlpLNkESDDo9CKgd6jcc+rYOrqbqlZ35H7UPKR2w2xBXrxjlWcZgmiS45ukK4qxGGhHkRAmn00847LYH/AF9RDpTdxSrLM1GHnDJ5u18Ku7TAfotyOG8xKgetynWOsErcQ9v04CnEpgH2zX/5zS6ba4NqWdPA1SCun9gi6r2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361704; c=relaxed/simple;
	bh=Yy8lewVJwdLyTidZznICK53OeIQJkdUqGtk8gBdoVns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=puXWthsZ7nBCt0vNTABXzGoVBrTbQlIaoj/MReBSPqNbvz03vKowOaZC78MMYbOHQg6CJSQcD+y0MwI9+OtExcAmuzwwNoc5RKo0PYT3yvvsumUPPf47xPjopzKjSUvsYtYPjQ/jqCsbJgniWYUyvk0ZGuBlJo3AVuXJhDWBPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XppAGao6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XppAGao6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE02C4CED1;
	Fri,  7 Mar 2025 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741361703;
	bh=Yy8lewVJwdLyTidZznICK53OeIQJkdUqGtk8gBdoVns=;
	h=From:To:Cc:Subject:Date:From;
	b=XppAGao6CvdwA1HttSn95LUSxPj9MadeAM0KoLcpm9PCQl32MJQEYB6yIVFWJLjkW
	 zb+5DYuv9VduXbP9ob7u2GOWZalo4hLR/m7aQJGlr13ZVQE0WIPXs906vz2EtxFnTH
	 F+iuayLBSsgB05LdpwU5JS8VXZLoyystD+ncHM8h1FOfCaukGVEb2jAawM54cVerfG
	 s8nEQrnjh8SNKObc6JcRnf/+btl9/uuQi7OiQeN5mp1pWIcTNEPhF3BV2lZDmJyHiG
	 x0TY3Tp8r7rxpDihA1gHI2sJOf4ksOP44MR8pLQ+YZEW3AiHhm6fq7DhwWJuLCUAdf
	 DEBZLv4o1Xx8A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Leo Yan <leo.yan@linux.dev>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tavian Barnes <tavianator@tavianator.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1 next] perf libunwind: Fixup conversion perf_sample->user_regs to a pointer
Date: Fri,  7 Mar 2025 12:34:48 -0300
Message-ID: <20250307153448.250871-1-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optional") misses
the changes to a file, resulting in this problem:

  $ make LIBUNWIND=1 -C tools/perf O=/tmp/build/perf-tools-next install-bin
  <SNIP>
    CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
    CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
  <SNIP>
  util/unwind-libunwind-local.c: In function ‘access_mem’:
  util/unwind-libunwind-local.c:582:56: error: ‘ui->sample->user_regs’ is a pointer; did you mean to use ‘->’?
    582 |         if (__write || !stack || !ui->sample->user_regs.regs) {
        |                                                        ^
        |                                                        ->
  util/unwind-libunwind-local.c:587:38: error: passing argument 2 of ‘perf_reg_value’ from incompatible pointer type [-Wincompatible-pointer-types]
    587 |         ret = perf_reg_value(&start, &ui->sample->user_regs,
        |                                      ^~~~~~~~~~~~~~~~~~~~~~
        |                                      |
        |                                      struct regs_dump **
<SNIP>
  ⬢ [acme@toolbox perf-tools-next]$ git bisect bad
  dc6d2bc2d893a878e7b58578ff01b4738708deb4 is the first bad commit
  commit dc6d2bc2d893a878e7b58578ff01b4738708deb4 (HEAD)
  Author: Ian Rogers <irogers@google.com>
  Date:   Mon Jan 13 11:43:45 2025 -0800

      perf sample: Make user_regs and intr_regs optional

Detected using:

  make -C tools/perf build-test

Fixes: dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optional")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tavian Barnes <tavianator@tavianator.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/unwind-libunwind-local.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 16c2b03831f39afc..cc0e41f2c2f2ef10 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -579,12 +579,12 @@ static int access_mem(unw_addr_space_t __maybe_unused as,
 	int ret;
 
 	/* Don't support write, probably not needed. */
-	if (__write || !stack || !ui->sample->user_regs.regs) {
+	if (__write || !stack || !ui->sample->user_regs->regs) {
 		*valp = 0;
 		return 0;
 	}
 
-	ret = perf_reg_value(&start, &ui->sample->user_regs,
+	ret = perf_reg_value(&start, perf_sample__user_regs(ui->sample),
 			     perf_arch_reg_sp(arch));
 	if (ret)
 		return ret;
@@ -628,7 +628,7 @@ static int access_reg(unw_addr_space_t __maybe_unused as,
 		return 0;
 	}
 
-	if (!ui->sample->user_regs.regs) {
+	if (!ui->sample->user_regs->regs) {
 		*valp = 0;
 		return 0;
 	}
@@ -637,7 +637,7 @@ static int access_reg(unw_addr_space_t __maybe_unused as,
 	if (id < 0)
 		return -EINVAL;
 
-	ret = perf_reg_value(&val, &ui->sample->user_regs, id);
+	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample), id);
 	if (ret) {
 		if (!ui->best_effort)
 			pr_err("unwind: can't read reg %d\n", regnum);
@@ -741,7 +741,7 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	unw_cursor_t c;
 	int ret, i = 0;
 
-	ret = perf_reg_value(&val, &ui->sample->user_regs,
+	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample),
 			     perf_arch_reg_ip(arch));
 	if (ret)
 		return ret;
@@ -808,7 +808,7 @@ static int _unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 		.best_effort  = best_effort
 	};
 
-	if (!data->user_regs.regs)
+	if (!data->user_regs->regs)
 		return -EINVAL;
 
 	if (max_stack <= 0)
-- 
2.47.0

