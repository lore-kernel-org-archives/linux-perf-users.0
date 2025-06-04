Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2724B26;
	Wed,  4 Jun 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047093; cv=none; b=SZ4SwDTup2+SxRZJAiWs16G0mZGk928JZVY/Zev7oQYJtjc+6Vc3XbGeej/X7HUg7LFyysCA4WVvcad6TdJDDvaPLVKxRXM8X7MR1MAuoVgst5+Vj5zNDxo82/PnZf3PlLMuZQUx0oT3sLx+Utf2ABUFLGKfdP0PZlOw86/DAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047093; c=relaxed/simple;
	bh=aBj67WqnNRdJAwIA2FVK7ZrPey12dn3fCDbsu6xdMlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOXhfh5G73dnzK6hTy0VkwZmiODNrN2MwphDTQJcZm0qcJ12VqoEWFw40/O4xfLNvgK0K1TtfiJUGwokX+xYyfhaAI1Q8gmU2GZYoaLNZ08LQqo3j1o27NcSWGaNxAqKrNj+XFiIYhJxEqWlV02yiL98FSQfzmrtwZ+K1qugX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SATPIaNP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SATPIaNP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7p5VmWb2SIAcmGijn39glw69okIY8rokGtORJAyMkNA=; b=SATPIaNPngxKZMjgYZLRyy6+zp
	jynnjRFkJtsaLQlCmttogi7m8o9WhTL+bk8Qj2Zi4oMewjUf6xLuF78m/lPNvMfBRQcIE5pXi7dyo
	mg8bHpIGkBEcAjRcHDZAv++lIUeW9dWs7C6F5q0zUdE1TitXmXguxbAxGttvdntpwXSGS6eRYG2Rl
	SOeowo/kx0Q/1FoAYXe8x4vjDm4GNhgCaZl81lloPwJSttyUhLY1fNzqiI5x4Sq/nsS36iMCl2MmR
	98IRMJM/E6Qs1z21+K7XpJ3fBeihXr7HYX5uJtp+fxgAo3lq6pPIcTwGmgOc4BRl88oUC9wjr79Aa
	/2W2bMQQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMp2k-00000000uJJ-2Kam;
	Wed, 04 Jun 2025 14:24:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E2EE7300787; Wed,  4 Jun 2025 16:24:37 +0200 (CEST)
Date: Wed, 4 Jun 2025 16:24:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Baisheng Gao <baisheng.gao@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"reviewer:PERFORMANCE EVENTS SUBSYSTEM" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	cixi.geng@linux.dev, hao_hao.wang@unisoc.com
Subject: Re: [PATCH] perf/core: Handling the race between exit_mmap and perf
 sample
Message-ID: <20250604142437.GM38114@noisy.programming.kicks-ass.net>
References: <20250424025429.10942-1-baisheng.gao@unisoc.com>
 <aEBSt2LN7YhxYX7N@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEBSt2LN7YhxYX7N@J2N7QTR9R3>

On Wed, Jun 04, 2025 at 03:05:43PM +0100, Mark Rutland wrote:

> Loooking at 5.15.149 and current HEAD (5abc7438f1e9), do_exit() calls
> exit_mm() before perf_event_exit_task(), so it looks
> like perf could sample from another task's mm.
> 
> Yuck.
> 
> Peter, does the above sound plausible to you?

Yuck indeed. And yeah, we should probably re-arrange things there.

Something like so?

---
diff --git a/kernel/exit.c b/kernel/exit.c
index 38645039dd8f..3407c16fc5a3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -944,6 +944,15 @@ void __noreturn do_exit(long code)
 	taskstats_exit(tsk, group_dead);
 	trace_sched_process_exit(tsk, group_dead);
 
+	/*
+	 * Since samping can touch ->mm, make sure to stop everything before we
+	 * tear it down.
+	 *
+	 * Also flushes inherited counters to the parent - before the parent
+	 * gets woken up by child-exit notifications.
+	 */
+	perf_event_exit_task(tsk);
+
 	exit_mm();
 
 	if (group_dead)
@@ -959,14 +968,6 @@ void __noreturn do_exit(long code)
 	exit_task_work(tsk);
 	exit_thread(tsk);
 
-	/*
-	 * Flush inherited counters to the parent - before the parent
-	 * gets woken up by child-exit notifications.
-	 *
-	 * because of cgroup mode, must be called before cgroup_exit()
-	 */
-	perf_event_exit_task(tsk);
-
 	sched_autogroup_exit_task(tsk);
 	cgroup_exit(tsk);
 
