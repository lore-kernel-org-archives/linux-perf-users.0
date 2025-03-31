Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41720E6;
	Mon, 31 Mar 2025 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743446802; cv=none; b=aRK51x4SKE9Eh6M+rA0m2JBgrUWctc9EJuKNGT0gyTNxW8E6hC9x2gHUDwihBHPwC4j4LDQz3S9yNItrkwTPGVPqp31lyXS2DRsd8rLS56LQxs0lQhKWcDGEs4CDi8BHWKtQd2BW7oM7Om70A0HafphVOBjEF66CgLIMH5IFzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743446802; c=relaxed/simple;
	bh=hYDIEG453/r3w6ClHoDre/nxcohYbZa7qjm98Pz4FiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnjWr9OjYGh7j/iTUOPsPuFPV3ZW1u8tiVrOFSuKFuXJk2mAsUtTMJ5z7QZcyeBD1PfBJqAMukIJv9OAwTVTGpTgXmpNBXnioeUPpYfR3+yPUSmSB8GC5aFj2+AC4bMQy05Kz29qzZcFyX8WdEui2uqdzGE4e9fLRpqI09nQKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9vJlR30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9vJlR30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E479C4CEE3;
	Mon, 31 Mar 2025 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743446799;
	bh=hYDIEG453/r3w6ClHoDre/nxcohYbZa7qjm98Pz4FiI=;
	h=From:To:Cc:Subject:Date:From;
	b=Y9vJlR30oTLQ0YvQJoFNuJ3jQGi3QunQ3wr7hUR9J+oqA9/bQG0R5DTr4AFDPh46X
	 ghjSR67FM4HCn2tlTRlP8qLoMf25ItIR4jBnC6B81cEOU0YO+yHTBczXKJr73MwvY4
	 ltVFpuEi9ZB5WZCE2RWwxMW5+EZhPBHCPAWm4IexAH8vHuw6DGZhKbON6/NWFfWD5b
	 sdRhFIe1/3o0xDm0QVOHouV3WX1y2SfFydTSdl5dayGUURYRoIQIE2WK6CiVvdXJ1x
	 RR8JDNnd/cNmSP7E2+Vq+XMhyvaDZBDbCI06MDWXhV+3w0OcaStQKnM1ST8femLws9
	 UDP6EaGJoz3wQ==
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
Subject: [PATCH] perf trace: Fix some leaks of struct thread
Date: Mon, 31 Mar 2025 11:46:38 -0700
Message-ID: <20250331184638.3856982-1-namhyung@kernel.org>
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
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3d0c0076884d34cb..10cd99888a9a11b5 100644
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
@@ -4123,8 +4123,10 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 			pids[nr++] = thread__tid(parent);
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

