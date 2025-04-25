Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C425B683;
	Fri, 25 Apr 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592975; cv=none; b=mSEE3DyfPhCHbH01amx0329wSdSugyerhlsDhVOt/Cr85Zjsj5TNqSS9j4bRgH+ZqPIwEiiF4/tl2JbTSaxbVrJUv37I02FofMeZvlCPLyg9e+D1a7FmNLJOQBlGjmWwo+I5L1r6TxvsBnu+ObcbeHHUanGVGAoKa0oDq1LuvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592975; c=relaxed/simple;
	bh=UruFrykajNjxMX/0A6fTNZ1MktM/smIbdfB+M9Tloe0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eAYRVtoVUnWdG759xXYYTXiKUJoS/DCkMfHTk75J0l5szUJW0dBe4y+eIVw9+dt1SmqkX+ToZ8lhMmw6OX1E3ksrtW/imeAFy/fqea76KxxeelAryt38w98qfcrjCwQkVnbLUO5PP2k5rrW8dM/2s6BafYJB/StwnT5wCwKJOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C40C4CEF3;
	Fri, 25 Apr 2025 14:56:15 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u8KVJ-0000000HSlO-2neE;
	Fri, 25 Apr 2025 10:58:13 -0400
Message-ID: <20250425145813.518795213@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Apr 2025 10:54:33 -0400
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
Subject: [PATCH v6 11/18] perf: Use current->flags & PF_KTHREAD instead of current->mm == NULL
References: <20250425145422.132820147@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

To determine if a task is a kernel thread or not, it is more reliable to
use (current->flags & PF_KTHREAD) than to rely on current->mm being NULL.
That is because some kernel tasks (io_uring helpers) may have a mm field.

Link: https://lore.kernel.org/linux-trace-kernel/20250424163607.GE18306@noisy.programming.kicks-ass.net/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/events/callchain.c | 6 +++---
 kernel/events/core.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index abf258913ab6..cda145dc11bd 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,10 +246,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs = task_pt_regs(current);
-			else
+			if (current->flags & PF_KTHREAD)
 				regs = NULL;
+			else
+				regs = task_pt_regs(current);
 		}
 
 		if (regs) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67581babe9ba..430dd158b1ee 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7989,7 +7989,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (current->mm != NULL) {
+		if (!(current->flags & PF_KTHREAD)) {
 			struct page *p;
 
 			pagefault_disable();
-- 
2.47.2


