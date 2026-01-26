Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A53EBF3A;
	Mon, 26 Jan 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447888; cv=none; b=UcUsZvQobO/2SJG8jyeNgGpddFRAOJR4Db1IX7K31Zm0L4Vx2grX/iJ53WOzEczVMgg14+aZZnBgU5j0+d+/w+ZAP0QOaT4kSmERMoVC6WK8zbX6y22vDIH5kD+zgTUfs0RJhPq8H/FszdN5KgRcaKNDoTgKZLbjsBljn0zn2hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447888; c=relaxed/simple;
	bh=QbmFdufQZcCj+javmvRugRR6SShGkPuWYYKf7OSury0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8YgjCZefMhQN+lUVEK5lYxGXh7sNAlMHfbJ+GapAnBoAwHvFdCIj59RhzTrYQ6OWELMTUaTBbY/2S8Sthn71j2UJZQsEK8s3fOn+Rxvfz0ErlFOj5a8bGQgesXjF8g4Bv9Lxg9ljYp9XUKCQQo9tBVTq9TzJEiGiShQ2AWMP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id AE830160832;
	Mon, 26 Jan 2026 17:18:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 468DE2000D;
	Mon, 26 Jan 2026 17:18:01 +0000 (UTC)
Date: Mon, 26 Jan 2026 12:18:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND][PATCH 3/5] perf: Use current->flags &
 PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
Message-ID: <20260126121803.4a90c959@gandalf.local.home>
In-Reply-To: <20260126120553.2fa79048@gandalf.local.home>
References: <20250820180338.701352023@kernel.org>
	<20250820180428.592367294@kernel.org>
	<0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
	<20260126120553.2fa79048@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ms736ekqxs95t5cucfsx7u8qhe15snef
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 468DE2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19T1g40h6o0z0ybLMs0NNqz8UMt/Ofgtd0=
X-HE-Tag: 1769447881-941100
X-HE-Meta: U2FsdGVkX19Sv8HKgGwUUAFhav8iVZYQz1b5ZTWmNMNvVMWC6UCISW6dBHrYgbM/zOX1XuI3y719D4+mBy5xb9H1AH76CrNrZaWMnhadUazDgFB40kWqbVQLPrzgIxcgd7Lcs/2txdMS7Zf8fXMuyiuLwWFpBqoybtK8P1dCqtUmA7zOprkh7Eis2OhCMNeIOErjwxVtnMM4gfz1ihPy6lqhhLUvuOZxMTgoSFqSQcp45rRk1a7jEAOZ7nRsgAkyIMSCuAh4qB4wLqMKtPbIJsrCMKUGuRpaZkMcHHxA32V289wj5JVaqb+JD0tRpXNNGP8a2NWJESyLeHCG93fii4K6NhU+Kg9z

On Mon, 26 Jan 2026 12:05:53 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> I guess we need to also test for !current->mm because the flags set for an
> exiting task is done when we can still do callchains. Thus, the only way to
> know if it is safe to do a callchain when a task is exiting is via task->mm
> and not task->flags :-/

Can you test this patch?

-- Steve

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1f6589578703..c82d61d73bd8 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,7 +246,14 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
+			/*
+			 * Testing current->mm is not enough as some kernel threads
+			 * may have one set. But testing the flags is not enough
+			 * either as this can be called after a user task
+			 * frees its mm just before it exits.
+			 */
+			if (!current->mm ||
+			    (current->flags & (PF_KTHREAD | PF_USER_WORKER)))
 				goto exit_put;
 			regs = task_pt_regs(current);
 		}
