Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948041CCB40;
	Wed, 22 Jan 2025 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513136; cv=none; b=NOBdX1DG0lMJWGoU0RPeg7rThSFemHnzX9SApLqRuujXmRHV717VUlejWUg8p5Wj1jjToSAIQnWbGSciPooHyFO/VJk34A2ybGVurTkPGASdORxXlMc9yF7DZ5S//yyASoqUfyggCRonZBEEJ+N2jrTHsGnE+agbg7BZ+PsclxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513136; c=relaxed/simple;
	bh=3l4otAURi7kB3h4hFwmhDwPOJru/SqxpPAZlyFNo3VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFkdF/enMgPmf5KP3tu2TBvmG+hG4yysZ/gRB2CNu8JVeguWReqTun6vQl+acd8ugnNSY6x/8QwKwhpojRRpxTOZtTG0s/OtWnrpg/q75SiDpc89tKlG9bPccWnS7eKfZK8Hoj0O9FnoqLbxrr3ltow2i+RH3UGoefNnxzz40o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d68pAy6U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d68pAy6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3866BC4CEDF;
	Wed, 22 Jan 2025 02:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513135;
	bh=3l4otAURi7kB3h4hFwmhDwPOJru/SqxpPAZlyFNo3VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d68pAy6UiYIsXp8LITx076zVTZTyrm1OXBRC5OuHcsdfD+Q7V30hrc+0QVV1+7nd5
	 c1S+S6nAjhyDe7YuVxMTNiIcXi0jsQQgPoFSGK1H193Uk+YUYj8EZo5fcqE+P+jEdX
	 No5ap9GE61FQ6YpTt1ytrYTu2nSoEImZrIosqJ4HibfkrWtXbqIFSTlaqDJCBx3N5y
	 DqU2AXa1GHeSPJHNo/foKQ90cJK67s+4lzT5oHUkPOHLg5mmzdkZ5YJ2sSAJMhgtqP
	 p5oYApcj3+fTMRsuyi//ZZ+xmLThJZnzhX0X5dTPxI6cP0Q4iUWpFjiLlcqY9ccxxV
	 u9AWNC5nAMqFA==
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
Subject: [PATCH v4 22/39] unwind_user/sframe: Wire up unwind_user to sframe
Date: Tue, 21 Jan 2025 18:31:14 -0800
Message-ID: <25c75930c310cb4e9d3878276f00fe7e6523f4e1.1737511963.git.jpoimboe@kernel.org>
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

Now that the sframe infrastructure is fully in place, make it work by
hooking it up to the unwind_user interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                      |  1 +
 include/linux/unwind_user_types.h |  1 +
 kernel/unwind/user.c              | 22 +++++++++++++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 23edd0e4e16a..12a3b73cbe66 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -448,6 +448,7 @@ config HAVE_UNWIND_USER_COMPAT_FP
 
 config HAVE_UNWIND_USER_SFRAME
 	bool
+	select UNWIND_USER
 
 config AS_SFRAME
 	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 3ec4a097a3dd..5558558948b7 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -9,6 +9,7 @@ enum unwind_user_type {
 	UNWIND_USER_TYPE_NONE,
 	UNWIND_USER_TYPE_FP,
 	UNWIND_USER_TYPE_COMPAT_FP,
+	UNWIND_USER_TYPE_SFRAME,
 };
 
 struct unwind_stacktrace {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 92963f129c6a..fc0c75da81f6 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/unwind_user.h>
+#include <linux/sframe.h>
 #include <linux/uaccess.h>
 #include <asm/unwind_user.h>
 
@@ -29,6 +30,12 @@ static inline bool compat_state(struct unwind_user_state *state)
 	       state->type == UNWIND_USER_TYPE_COMPAT_FP;
 }
 
+static inline bool sframe_state(struct unwind_user_state *state)
+{
+	return IS_ENABLED(CONFIG_HAVE_UNWIND_USER_SFRAME) &&
+	       state->type == UNWIND_USER_TYPE_SFRAME;
+}
+
 #define UNWIND_GET_USER_LONG(to, from, state)				\
 ({									\
 	int __ret;							\
@@ -48,12 +55,19 @@ int unwind_user_next(struct unwind_user_state *state)
 	if (state->done)
 		return -EINVAL;
 
-	if (compat_state(state))
+	if (compat_state(state)) {
 		frame = &compat_fp_frame;
-	else if (fp_state(state))
+	} else if (sframe_state(state)) {
+		if (sframe_find(state->ip, frame)) {
+			if (!IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
+				goto the_end;
+			frame = &fp_frame;
+		}
+	} else if (fp_state(state)) {
 		frame = &fp_frame;
-	else
+	} else {
 		goto the_end;
+	}
 
 	cfa = (frame->use_fp ? state->fp : state->sp) + frame->cfa_off;
 
@@ -94,6 +108,8 @@ int unwind_user_start(struct unwind_user_state *state)
 
 	if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_COMPAT_FP) && in_compat_mode(regs))
 		state->type = UNWIND_USER_TYPE_COMPAT_FP;
+	else if (current_has_sframe())
+		state->type = UNWIND_USER_TYPE_SFRAME;
 	else if (IS_ENABLED(CONFIG_HAVE_UNWIND_USER_FP))
 		state->type = UNWIND_USER_TYPE_FP;
 	else
-- 
2.48.1

