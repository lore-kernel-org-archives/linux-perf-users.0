Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DEF2022C9;
	Mon, 28 Oct 2024 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152104; cv=none; b=tyuzBdpTHfkDcSWzfvAM5sck+s0nmY2VOXVKZKly3oD1DoYJ/ojHU/EWz7oNQ6dDKQW/hcO6Jw1ovcCcwGvdC9jADUGReD0MwWHKvxML+LfVotf15DyJCSeiBJeaOyj4DzkWRJZZISi38lkE8W1fEnvQ7eElNHMthJWL4FOYRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152104; c=relaxed/simple;
	bh=FAGQnaAp9X/oqvdaCFG+QdxKrKoTF5tQk3+U3LCGtAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndJGVdy+mDLFHXW/nfjBfmtNEPu1Wzx+7Ok8wufsGxXuUlHw5nxeA3/zcwKCGesSSnnSU158z10mwhGFifRdRBgk4madjg4nRAZWYujnDWT6P1yUigAQMv4GPGJz8U7R/KU3EYl4BhezhbufI/xz9SjXiuRZMDnt4mwgD9aN6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8YgP67n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8YgP67n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21068C4CEE8;
	Mon, 28 Oct 2024 21:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152104;
	bh=FAGQnaAp9X/oqvdaCFG+QdxKrKoTF5tQk3+U3LCGtAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8YgP67nbXTS84HJnqRj829E6UCIhjtMS5zu6d2iX9eVIT9kV11oDxbme9g7htqTm
	 jYeSNt/PQ3RMRolswXPWsbk9uSnaUkgt9KIATrlcV7/Vak/S79UlGJJFYUrIA/EvAt
	 Dpdw8z9cgwYppw+R2LXKXFTT6u9WzeUZLMpfW+Usgt3MVe0RxUiqgmRTYulzyxoKF5
	 +b0zqkspVtQ2ln1iFNnnZJObOgEnCX03AK+8knJmaCPHXQPyMp5D46N5nwkcfwnxzY
	 ps72KpLVHYFKYvStyZfzfJCJi7tV4XGhe/4PC2V0+bsOcKt8h54clhZkTQx6UCEBGk
	 kNTL+Ohh8GNJw==
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
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 14/19] perf: Simplify get_perf_callchain() user logic
Date: Mon, 28 Oct 2024 14:47:41 -0700
Message-ID: <4d141847262054cc73551fa33609bc3099f0d2f9.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
should never be NULL.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/events/callchain.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 655fb25a725b..2278402b7ac9 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -241,22 +241,20 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs = task_pt_regs(current);
-			else
-				regs = NULL;
+			if (!current->mm)
+				goto exit_put;
+			regs = task_pt_regs(current);
 		}
 
-		if (regs) {
-			if (add_mark)
-				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+		if (add_mark)
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
-			start_entry_idx = entry->nr;
-			perf_callchain_user(&ctx, regs);
-			fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
-		}
+		start_entry_idx = entry->nr;
+		perf_callchain_user(&ctx, regs);
+		fixup_uretprobe_trampoline_entries(entry, start_entry_idx);
 	}
 
+exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.47.0

