Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C09219E7F8;
	Thu,  3 Apr 2025 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658935; cv=none; b=J3hhTzQgXGt4/RPXBG7WIQ4VUMi9UYfTjIHaLoTNDDyQ8i06qyTGV8PCKAzZDCo1CyxmljbIw3dZoNkKs81dCQ2WiIzbM8RfTdn4s3JNGn5ENdBoB+BcQcBL2hrCplle8x/fF/mo5x+9DjS1wHc0sUrVhtPTjvelPseCIc1B9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658935; c=relaxed/simple;
	bh=whEiy9LvmTmm95w1GUUaZlibxVNaG8bjSkBkZzKoR+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZamCe2i4q7hu5r2W9w08nolgZ/1oP8lV4d0ulbg0cT7FVdFuJzVBUgRh/oo+/0tqv5fVul3MZNXXPXal/u+qrIr/YhTzXyeO5HtNbU8cJVGp1RNEFLjhqquOHru00c61X4bTzjiEHLU+/JmNC4B2nT05p/yl8gMZ3FmRVR2xws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIRGu4Hf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIRGu4Hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59985C4CEE3;
	Thu,  3 Apr 2025 05:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743658934;
	bh=whEiy9LvmTmm95w1GUUaZlibxVNaG8bjSkBkZzKoR+4=;
	h=From:To:Cc:Subject:Date:From;
	b=lIRGu4HfNySe5Wnf33+wTxgC8ryIynBlOPNFoEiSw/5Yl75AXy9PtJawdLhkq8UN4
	 Hr15NrAoz/UJqYoBHBwQiEyx+3DKUGc2m5vGOzCyQ0yDazNTbauBOxdMyZ0ypMJQno
	 bJvrB4snR2XHmuufg3Iv8m/IxN+oGond05hlV7+Y3Uxb1aiEj/vWS951Ot6tSaOr9z
	 UuQgw2N5ae4mopBEzmzAxw51dBVSzxO4JJA5nexV//Hee4dulIhGaKC3P+QcKJhEXs
	 SLv4OqAnRDw6NhaDgz3IJJWqKMU7g+08xATHVBz86tNYycN5HpYH+VJneA7LEJ50A+
	 nmfmeRBpM+Igw==
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
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2] perf trace: Fix some leaks of struct thread
Date: Wed,  2 Apr 2025 22:42:13 -0700
Message-ID: <20250403054213.7021-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've found some leaks from 'perf trace -a'.  It seems there are more
leaks but this is what I can find for now.

Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2)
 * add one more thread__put() for parent  (Howard)

 tools/perf/builtin-trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3d0c0076884d34cb..48a0c55c6bcb5840 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2835,7 +2835,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	e_machine = thread__e_machine(thread, trace->host);
 	sc = trace__syscall_info(trace, evsel, e_machine, id);
 	if (sc == NULL)
-		return -1;
+		goto out_put;
 	ttrace = thread__trace(thread, trace);
 	/*
 	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
@@ -4121,10 +4121,13 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 		if (!strcmp(thread__comm_str(parent), "sshd") ||
 		    strstarts(thread__comm_str(parent), "gnome-terminal")) {
 			pids[nr++] = thread__tid(parent);
+			thread__put(parent);
 			break;
 		}
+		thread__put(thread);
 		thread = parent;
 	}
+	thread__put(thread);
 
 	err = evlist__append_tp_filter_pids(trace->evlist, nr, pids);
 	if (!err && trace->filter_pids.map)
-- 
2.49.0.472.ge94155a9ec-goog

