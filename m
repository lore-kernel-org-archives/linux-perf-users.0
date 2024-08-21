Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0E18475C;
	Wed, 21 Aug 2024 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223250; cv=none; b=U7BKZlE7TIMiOAzG6Dcka0OJkCLnutBZnV75Qc7hveGaN3msZO5GSr7hZfpoSIgMQQLBNhtI45obLGJhrc1zSJdBWqMFmzDQ09kimfWzwjrr4aEE8RwhQ/Ns1q/u5gQnkVnvqyRQgwF9mzr7JLkMBcJcDUvUfmZEFe9L/EiVyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223250; c=relaxed/simple;
	bh=lBjQlKE3w5epF0YAuSwIcDk2n3dg7KcCujTXXA3loxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krrYyQPJuyi2lhGB6DJjCgGvtBNiuTgOI37/vtLlDCpXlW5OHomvH5oCLUqA1uIV+BODed834NTPYrGMNJ3xEvX+udjE0FrlGDw2PmtI5+2/JoBwWKhx3++quWxT8apwI3in9Gd3lt3fgtEZeIJMhSLerpN2XoQQwE165P/zTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBiQ6KFY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBiQ6KFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3B6C32782;
	Wed, 21 Aug 2024 06:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724223249;
	bh=lBjQlKE3w5epF0YAuSwIcDk2n3dg7KcCujTXXA3loxw=;
	h=From:To:Cc:Subject:Date:From;
	b=VBiQ6KFYp48nsvScqEj8ngZtYr1GnlPsQX/2uoGLXpA5LP0veZ0kxxL5M9CjDf14A
	 LunL2JPO/mFJTJZX+yAf+B+B5LVBLLCH0nfwht4XgPS7ex/nfMpivxhWvozgKr1kVi
	 tLBNNVCrIu7yff1DZ21PS0IjWZOF7TwXxLi32ESvAfI7Nimz9I6ZiuFdnbTF4JLmRc
	 AbgukeBPXeeF0QY3XajlhzOlbJLBBGuOi3DqjRniLwasshn5l1oAPMHFcsWHoFGxeg
	 62fQDWbRfrDG7XBVBSgldUjzHLUNMCAS0SWrrFz92w/ebnyWIavQIWPsb2YEIkxOna
	 NTk8LrysbZLvw==
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
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 1/3] perf annotate-data: Fix missing constant copy
Date: Tue, 20 Aug 2024 23:54:06 -0700
Message-ID: <20240821065408.285548-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found it missed to copy the immediate constant when it moves the
register value.  This could result in a wrong type inference since the
address for the per-cpu variable would be 0 always.

Fixes: eb9190afaed6 ("perf annotate-data: Handle ADD instructions")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/annotate/instructions.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 7b7d462c6c6b..88b5bcf2116f 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -382,6 +382,7 @@ static void update_insn_state_x86(struct type_state *state,
 
 		tsr->type = state->regs[src->reg1].type;
 		tsr->kind = state->regs[src->reg1].kind;
+		tsr->imm_value = state->regs[src->reg1].imm_value;
 		tsr->ok = true;
 
 		pr_debug_dtp("mov [%x] reg%d -> reg%d",
-- 
2.46.0.184.g6999bdac58-goog

