Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E871F9428;
	Wed, 22 Jan 2025 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513147; cv=none; b=HXRTA15rQSK7g4j4OALytWXU+mTd2Q5ub2XRLUIk9MylJ3yO2lZfr6Dua9CCjkxtd+vpCTlKdVbi1lau+Brh2KEuiNF2B0iKpFaS9aT7fxvFkLHDSXNzoe3DadY6s4yqFzqptJN3Z60dRzC0VAQkaeIN+okzrPPUW9yEJqbl5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513147; c=relaxed/simple;
	bh=ofsDiLXX3EH+qN+Y5WqqTscSbexhgOnm4ZEbWMlJa4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2KW7w1EVT8jyMU1nZ8JusFPFyOQUC9j43utNPkpwRFl9o0Mi2OghOdkFNkcP/xFnk7FewxX+ZLynb9qpHfLzAnmrsXvaRyimQVVjzN6ZjA8tSeDULb0Y8dYSr/20+8qZNxasb4bbHsP24bmxjggoBek23NiLVXwjKoBWT7sNwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRANL4zK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRANL4zK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846CFC4CEDF;
	Wed, 22 Jan 2025 02:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513147;
	bh=ofsDiLXX3EH+qN+Y5WqqTscSbexhgOnm4ZEbWMlJa4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRANL4zKLW7VuPjnLJ1ogZT2uIgpyFZfW0Nx1FXUkuNU0thERSmvguSoKw/sdjOyn
	 u1Ux2ezjLAODbyqCwfAWiaYfApkJhsdWMSEjiQlu2fLF46eVy2pQKCE3k69WcfUhjC
	 /eqYKFWJAli8QMEz+uVHK4TmGKjEEOBxi8wY+W5bjeZ9YQi928wvwnK6dmBmIzVhge
	 b5VovCWrLEw/XuacKV74OXzJE3W1tfxwyFBVcq5IBgxUzognTNyaa4dpsOaPMFULoG
	 9zGDF3B6m4mygTnFW9NLCbYTC0FRkq0ipzEDyh9OV2bj1PnRC7XBiXgWv/RKHqXxxC
	 flOy18Envivcw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 34/39] perf: Skip user unwind if !current->mm
Date: Tue, 21 Jan 2025 18:31:26 -0800
Message-ID: <24cde1381495cd637f0d5663ab7629572bc0eca6.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the task doesn't have any memory, there's no stack to unwind.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 99f0f28feeb5..a886bb83f4d0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7792,7 +7792,7 @@ struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
-	bool user   = !event->attr.exclude_callchain_user;
+	bool user   = !event->attr.exclude_callchain_user && current->mm;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
 
-- 
2.48.1

