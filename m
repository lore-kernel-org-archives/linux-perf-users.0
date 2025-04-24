Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80A215F46;
	Thu, 24 Apr 2025 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525788; cv=none; b=SC86R6Y1yxbuVbI5ZM9zTFaIgdiIuCcapyAo0q9w2VCawC3x/tZF0F6AuOvwz1+KRAYxkghP/MwszS7iur0Fy18nR/0keAgrGWeSJOb4mpsxh37k6cVD0CvliG58SnBM+g9QjoFCDj8VrBBm7+dvyvheLZpShtdpg4sx22cSETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525788; c=relaxed/simple;
	bh=/xd+kpuXL7S4aWgKajgEhSPjj7aSdLReSdmHB3WG7V8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YDrfU707hgBv+LLZYF0j63RGzQsfiDggvedpdpKMV+sM793OXuQmN+3UAqndrEzcTwd2p30CsaqI3OfUP2ywkTyQjIMs1Z9fXldrTNKQwQJFdgQJOeoyym+MnDsVXBahNidPm99/X85EVyQlu/t4yCyS3GGFb6uMoQ06VpMxc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D447C4AF17;
	Thu, 24 Apr 2025 20:16:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u831c-0000000H3vh-3JMm;
	Thu, 24 Apr 2025 16:18:24 -0400
Message-ID: <20250424201824.638379190@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 16:15:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
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
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v5 07/12] unwind_user/sframe: Wire up unwind_user to sframe
References: <20250424201511.921245242@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Now that the sframe infrastructure is fully in place, make it work by
hooking it up to the unwind_user interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/Kconfig                      |  1 +
 include/linux/unwind_user_types.h |  1 +
 kernel/unwind/user.c              | 22 +++++++++++++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5d7946e9a900..9ba467006774 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -448,6 +448,7 @@ config HAVE_UNWIND_USER_COMPAT_FP
 
 config HAVE_UNWIND_USER_SFRAME
 	bool
+	select UNWIND_USER
 
 config HAVE_PERF_CALLCHAIN_DEFERRED
 	bool
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
2.47.2


