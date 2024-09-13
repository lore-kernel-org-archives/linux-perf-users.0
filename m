Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C78194ACA;
	Fri, 13 Sep 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268608; cv=none; b=U6RiC34MPwm1qyVuuHAlz2cFlZCzPHmXBElt/OIZnqi62hkESzCxZzOGKcLNOlOO953poa8YAamcGgwsWGXC88ixvl0XTi8AKPpGCRXQkf+vEYJ1EZ8k6n8CgHoFQPMwoUN9KtfuLoX/HWolPocgymr92lgqOMKxkBRyV6YwE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268608; c=relaxed/simple;
	bh=0WuovsNM7TaO1oYzqlLrboI468hoPkzVYKsi9xko4u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgaTnPCxcUBDFeNwJFlSs2UnMR9873SQisBF/pIMRp+4WTmQdaZcyYFAuIFi7mzGsiq7R6PNWeH4ewZ1WrC+jhxHUmY2fUUB2e0ni+6QcTn2Zkadt+ClxMthscul1p0X85lar4b0Qrc4zISzIHjeBAFcxZzKuiOWtURNE4d+Nw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJJGuHnZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJJGuHnZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F356C4CEC5;
	Fri, 13 Sep 2024 23:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268608;
	bh=0WuovsNM7TaO1oYzqlLrboI468hoPkzVYKsi9xko4u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJJGuHnZDZGHlcrc0068NiNy4moT5d2cYpiizv067ynrq+IRchaaSh3SPSr0V8nTe
	 Dzyxlb23a6MSocyIQkxvC+uUGrnqt2yV/LUK9hdYII1OIbtXz5EYtatAPjlxlDtS1B
	 E0f1slcet58/b0XcmA5QtATfSHWalSCpiaudm6ZrSaNLEBH3SYBSwAJEAzv9RON7PS
	 xNHzTFnX3groYtbQhBe7+tT+fOdGeLlYimIB1kDt5jAqpl3A+OWL6LcjZ2FZLQS62U
	 YyMdL+BoyJbz1eCbruQ0dQXLf/lmHb0BsTWDDHrW6sD1+m0wv7ybrbKsECcIboVJyw
	 FeO7PwuKZxwqg==
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
	Sam James <sam@gentoo.org>
Subject: [PATCH v2 08/11] perf: Simplify get_perf_callchain() user logic
Date: Sat, 14 Sep 2024 01:02:10 +0200
Message-ID: <d3453cfd4b6bcc0283865cf2dd2b03caaba8001a.1726268190.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
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
2.46.0

