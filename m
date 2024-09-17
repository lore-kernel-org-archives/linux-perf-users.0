Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A8193079;
	Tue, 17 Sep 2024 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612111; cv=none; b=hyy8lT+IQRAYBoWPq4bV2uRej1r/02ZXATjfT0KI2j+9JBeRtqwK+3VLnUPnMV1okhITv1ej/DgEpXzQc3YuDaCuYym2af6wTaNAEVKjU4iR48B32jU5/bMbYEXuLaSV7KhdN76zjxBGgvWKKYWKTnZVzhtQ7hNSCZo1JoNTh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612111; c=relaxed/simple;
	bh=nRaCSyRVb+6blaQn01AbFqvMY9x1Rpzwg5L3eXpi3O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDOo1dlgaP/amDjQp/Tx0CCByhaEXHzyu0nuw5oW7tQTb/D3mabccUCOuM+wDVQEtpffa+HgXoflLQfN57cZzt+giRPmObhf8wtBFH7leXtf0eGOnNL12GIgg9xjC0s2hjvfpV4H20ys9bAlycbJM10en9sqvqUHgleERTc0bMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC4kqkQ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC4kqkQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09184C4CEC5;
	Tue, 17 Sep 2024 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612110;
	bh=nRaCSyRVb+6blaQn01AbFqvMY9x1Rpzwg5L3eXpi3O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tC4kqkQ2gSy22Ql+NqPlcxMx+VX1Cj4rX1qSAvBivGiaW3d2ldI46mIe09QeRKmp3
	 tBs2P3JfkLl4O7g2BwJ33fD/Pd2cOhst8qzuP6CPFSMGz1XBa8Q0A+68J4GRLN50J7
	 HvB/97ivAogsOIrOJJzYCnmT5aj6jz0WkaIH/IFqkeDzki4WTXWo24qRCho6Eh97Eo
	 WABPzTcHoinyCGC31nSsnc4evEVNf7SmM/FN/FaYBOeJDYzofsRabNIlWm3M4kb0J5
	 8sscos2tb2Fp+JjDC3U9jTUryVU22kUr3ahBZLWAzQerkKsghLVX1giqc+kYNHHYHV
	 ZTa3eh8m3iUhg==
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 1/5] perf tools: Sync UAPI perf_event.h header
Date: Tue, 17 Sep 2024 15:28:16 -0700
Message-ID: <20240917222820.197594-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240917222820.197594-1-namhyung@kernel.org>
References: <20240917222820.197594-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To import defer_callchain changes.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4842c36fdf801996..a7f875eb29dd049a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -460,7 +460,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* generate PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1217,6 +1218,23 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * TODO: do PERF_SAMPLE_{REGS,STACK}_USER also need deferral?
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
@@ -1247,6 +1265,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV			= (__u64)-32,
 	PERF_CONTEXT_KERNEL		= (__u64)-128,
 	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED	= (__u64)-640,
 
 	PERF_CONTEXT_GUEST		= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
-- 
2.46.0.792.g87dc391469-goog

