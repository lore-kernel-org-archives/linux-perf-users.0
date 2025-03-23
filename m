Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502420EB;
	Sun, 23 Mar 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742740643; cv=none; b=eueHXiK3oirVDOctjRBnuqYrSMgxLuJ33MCVHFSSUaPXTPy9x6qhpMy07HhiVTftFOryx3aKfbU6szwd2PKxUcdsaZHVkbtOYH6lD4euCChnPnbiXIGlqvCiFwpAGSTodzwGyAKCCpY6Q3Z6W8vo12njwS4b1phl5a9CAhiVMG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742740643; c=relaxed/simple;
	bh=Z9/22kWKr/x8jhk4QnOrrqdwh6LlTgkSojjkYGWCPf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCyk9J/nzDUb50PJBwR2szcBFECGZBIE77BtRkQO0e4+V0sI6qvFiPG+fnmwZ+YyU7Gyn3YXKnefQietiqWRkAG/E0MLyVM4iS1vctX7oX8pVDq5PHManILLPrRf+NXA0kbWEwYPaUCEw6J476ycVZ/O5YWJ7m/HDE48GQjs/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=nUJmMEYB; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="nUJmMEYB"
Received: from localhost (ip-109-42-179-92.web.vodafone.de [109.42.179.92])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 52NE6q3I008644
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 23 Mar 2025 15:06:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1742738814; bh=Z9/22kWKr/x8jhk4QnOrrqdwh6LlTgkSojjkYGWCPf0=;
	h=From:To:Cc:Subject:Date;
	b=nUJmMEYBNQzqLZahTSvFo3VAaYQZfvTs4mrdzLrst/+F1AkvACJ8N/NuHWI3726B+
	 SgoHVQGBCsc3x+FF0A6ektZvPbCcp+sQne2hSEFCxXk6pJa5Qz3VXwA019oqVUlfkl
	 EQRFHz4UhK5GQ0WlMDBeBtD1cQpkrb24gmtQkQ3A=
From: Dirk Gouders <dirk@gouders.net>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Dirk Gouders <dirk@gouders.net>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf bench sched pipe: fix enforced blocking reads in worker_thread
Date: Sun, 23 Mar 2025 15:01:01 +0100
Message-ID: <20250323140316.19027-2-dirk@gouders.net>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function worker_thread() is programmed in a way that roughly
doubles the number of expectable context switches, because it enforces
blocking reads:

 Performance counter stats for 'perf bench sched pipe':

         2,000,004      context-switches

      11.859548321 seconds time elapsed

       0.674871000 seconds user
       8.076890000 seconds sys

The result of this behavior is that the blocking reads by far dominate
the performance analysis of 'perf bench sched pipe':

Samples: 78K of event 'cycles:P', Event count (approx.): 27964965844
Overhead  Command     Shared Object         Symbol
  25.28%  sched-pipe  [kernel.kallsyms]     [k] read_hpet
   8.11%  sched-pipe  [kernel.kallsyms]     [k] retbleed_untrain_ret
   2.82%  sched-pipe  [kernel.kallsyms]     [k] pipe_write

From the code, it is unclear if that behavior is wanted but the log
says that at least Ingo Molnar aims to mimic lmbench's lat_ctx, that
doesn't handle the pipe ends that way
(https://sourceforge.net/p/lmbench/code/HEAD/tree/trunk/lmbench2/src/lat_ctx.c)

Fix worker_thread() by always first feeding the write ends of the pipes
and then trying to read.

This roughly halves the context switches and runtime of pure
'perf bench sched pipe':

 Performance counter stats for 'perf bench sched pipe':

         1,005,770      context-switches

       6.033448041 seconds time elapsed

       0.423142000 seconds user
       4.519829000 seconds sys

And the blocking reads do no longer dominate the analysis at the above
extreme:

Samples: 40K of event 'cycles:P', Event count (approx.): 14309364879
Overhead  Command     Shared Object         Symbol
  12.20%  sched-pipe  [kernel.kallsyms]     [k] read_hpet
   9.23%  sched-pipe  [kernel.kallsyms]     [k] retbleed_untrain_ret
   3.68%  sched-pipe  [kernel.kallsyms]     [k] pipe_write

Signed-off-by: Dirk Gouders <dirk@gouders.net>
---
 tools/perf/bench/sched-pipe.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index e2562677df96..70139036d68f 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -204,17 +204,10 @@ static void *worker_thread(void *__tdata)
 	}
 
 	for (i = 0; i < loops; i++) {
-		if (!td->nr) {
-			ret = read_pipe(td);
-			BUG_ON(ret != sizeof(int));
-			ret = write(td->pipe_write, &m, sizeof(int));
-			BUG_ON(ret != sizeof(int));
-		} else {
-			ret = write(td->pipe_write, &m, sizeof(int));
-			BUG_ON(ret != sizeof(int));
-			ret = read_pipe(td);
-			BUG_ON(ret != sizeof(int));
-		}
+		ret = write(td->pipe_write, &m, sizeof(int));
+		BUG_ON(ret != sizeof(int));
+		ret = read_pipe(td);
+		BUG_ON(ret != sizeof(int));
 	}
 
 	return NULL;
-- 
2.45.3

