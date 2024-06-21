Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB416A95B;
	Fri, 21 Jun 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989531; cv=none; b=FHQbW+bPj/nIVzWksjc9scd+mO0lnlYHVgHayQHxVamEUjUqU2d3LGLBRDOLzAWzxrGyk6vV9JsHmltcuS7mVAM81rFIxoR7OrS6vahQfiK9CXs9vtHLKS6IJz3qyOjECAnrTXIOKUbozaDvnAeoy9/YFq5fNkNRoeQetvm8ius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989531; c=relaxed/simple;
	bh=d2u6CluNqHWjqRE3vn1x6VOO63b45+Y8ceccB7kIFCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVBZbC+RhpjwdvF9AfA+TWatcQpZlRP4iiGZgU03k5fruOAMOv/mdTEVVOWNCFKKqhghWDOP1V4gSdt+Fsv0W8Bh08Mbb6dWg0dqm6VstyRAMglmYEnAdB7l18Ei7mVZYSiFs3ta0vx3vHo0LY3ydZk2lpVIGmvGxd/D8SQ7mOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTkouqiZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTkouqiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD27C4AF0E;
	Fri, 21 Jun 2024 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718989531;
	bh=d2u6CluNqHWjqRE3vn1x6VOO63b45+Y8ceccB7kIFCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTkouqiZnuAGHXwk5EWiMu5ZY91p5sVNhyjOw10zoC4mfXBWcU5BqPao73tVcYBoS
	 52LVfNooO6iQYpaNhf2Bdj4ODjiyhp3ikZWXCJsh7Kqin+RWLlFG026QVWorm5Re7K
	 2LyQU/GUAXnRCHzgqb8IYBVUY/FbUBBZrsQ8Rjo/EJsmXQViTUTm2Yceaabn7IkOaR
	 Cnj+0Oqypi8Xr68rvAuVT1YM0swIG6UNME9ar6NjyItwmJ6LsKo9YIWFVx/fWnncp6
	 U4fUjuqxtbvncio8dfQgAQGfSnn+YtUXlSUD0ir3/UHhguPvXBgrHhfw4IezDzdyGX
	 C5NeZU7GtfSIA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@cern.ch>
Subject: [PATCH 4/4] perf mem: Fix a segfault with NULL event->name
Date: Fri, 21 Jun 2024 10:05:28 -0700
Message-ID: <20240621170528.608772-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621170528.608772-1-namhyung@kernel.org>
References: <20240621170528.608772-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guilherme reported a crash in perf mem record.  It's because the
perf_mem_event->name was NULL on his machine.  It should just return
a NULL string when it has no format string in the name.

But I'm not sure why it returns TRUE if it doesn't have event_name in
perf_pmu__mem_events_supported().

The backtrace at the crash is below:

  Program received signal SIGSEGV, Segmentation fault.
  __strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
  67              vmovdqu (%rdi), %ymm2
  (gdb) bt
  #0  __strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
  #1  0x00007ffff6c982de in __find_specmb (format=0x0) at printf-parse.h:82
  #2  __printf_buffer (buf=buf@entry=0x7fffffffc760, format=format@entry=0x0, ap=ap@entry=0x7fffffffc880,
      mode_flags=mode_flags@entry=0) at vfprintf-internal.c:649
  #3  0x00007ffff6cb7840 in __vsnprintf_internal (string=<optimized out>, maxlen=<optimized out>, format=0x0,
      args=0x7fffffffc880, mode_flags=mode_flags@entry=0) at vsnprintf.c:96
  #4  0x00007ffff6cb787f in ___vsnprintf (string=<optimized out>, maxlen=<optimized out>, format=<optimized out>,
      args=<optimized out>) at vsnprintf.c:103
  #5  0x00005555557b9391 in scnprintf (buf=0x555555fe9320 <mem_loads_name> "", size=100, fmt=0x0)
      at ../lib/vsprintf.c:21
  #6  0x00005555557b74c3 in perf_pmu__mem_events_name (i=0, pmu=0x555556832180) at util/mem-events.c:106
  #7  0x00005555557b7ab9 in perf_mem_events__record_args (rec_argv=0x55555684c000, argv_nr=0x7fffffffca20)
      at util/mem-events.c:252
  #8  0x00005555555e370d in __cmd_record (argc=3, argv=0x7fffffffd760, mem=0x7fffffffcd80) at builtin-mem.c:156
  #9  0x00005555555e49c4 in cmd_mem (argc=4, argv=0x7fffffffd760) at builtin-mem.c:514
  #10 0x000055555569716c in run_builtin (p=0x555555fcde80 <commands+672>, argc=8, argv=0x7fffffffd760) at perf.c:349
  #11 0x0000555555697402 in handle_internal_command (argc=8, argv=0x7fffffffd760) at perf.c:402
  #12 0x0000555555697560 in run_argv (argcp=0x7fffffffd59c, argv=0x7fffffffd590) at perf.c:446
  #13 0x00005555556978a6 in main (argc=8, argv=0x7fffffffd760) at perf.c:562

Reported-by: Guilherme Amadio <amadio@cern.ch>
Closes: https://lore.kernel.org/linux-perf-users/Zlns_o_IE5L28168@cern.ch
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/mem-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 6dda47bb774f..429079329e48 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -86,7 +86,7 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
 		return NULL;
 
 	e = &pmu->mem_events[i];
-	if (!e)
+	if (!e || !e->name)
 		return NULL;
 
 	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE) {
-- 
2.45.2.741.gdbec12cfda-goog

