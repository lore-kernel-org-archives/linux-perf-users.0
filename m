Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4638285050;
	Tue, 27 Jan 2026 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549771; cv=none; b=RSrhICMTlhqVpT/yIJ6PPZV0XyuULgS5VPafBFErrqGJ2g0LVNz2X0Izh8dIloivD+4Qg+iQymYrVYLC87AW0zQmtE+zWnRwSlOkRkQjvcaaj7Q/tNUIWR21IIykvDjkW6ckkX91Uz9iryzjtvhP4XRXQydsXadl5x9Kga3Pfxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549771; c=relaxed/simple;
	bh=5O0M++sW4SkonE9ECHt/AiAabXTf/Ayouma2reJmXls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiQ4w+gi9Uj6fOmHbthzrw9tv8UEpQfDFUgv3WAplH6lmv+IqdATEnAMejLLWfdlC/q+CfzK2DX2fjPUo4vwTNDgHqypEnbCemr1AqU38ZFcXXsQX5z/6pGXOw1VayE/o7pYWG63y2lwyzSUNk5K6PGbaPzncW4W+edxI93RKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 08E881A0364;
	Tue, 27 Jan 2026 21:36:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 90BBD2002A;
	Tue, 27 Jan 2026 21:36:03 +0000 (UTC)
Date: Tue, 27 Jan 2026 16:36:09 -0500
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
Message-ID: <20260127163609.4d1f1647@gandalf.local.home>
In-Reply-To: <402e0322-bc2d-441f-8969-fc643dfaff06@roeck-us.net>
References: <20250820180338.701352023@kernel.org>
	<20250820180428.592367294@kernel.org>
	<0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
	<20260126120553.2fa79048@gandalf.local.home>
	<20260126121803.4a90c959@gandalf.local.home>
	<27f9a957-67c7-4c88-b320-0f8725e9b03d@roeck-us.net>
	<20260127102234.755d8c4e@gandalf.local.home>
	<402e0322-bc2d-441f-8969-fc643dfaff06@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 90BBD2002A
X-Stat-Signature: c3zsuk385ynpw37fz9s8fpndywntmdyf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++i7APigOEPttZ+8NFwu/hg+iqijZKBa4=
X-HE-Tag: 1769549763-311923
X-HE-Meta: U2FsdGVkX1+O96WQ7kQLHMDfnSCKW0/pBoX7nDhmFFpkTrQeEavoJ2QTSeJbBiiATa6/zV/ypYhYJLZ4iiIoDpf/Bhoy8Hrk+Iz+KnF8ywbPEQcUb9u5UXEy2iFMCj6084poDLFIhyGuIwMtkXUQNuOTk2gNd+SrudUaWppZTU554f5Y2kpYA3CI9DMTqGEnBuMMoos5iutwz4RnBm973BYB79F5UrBMutWeaoeaDxYiXvuvQQhbNd2VoKbRYah4r95uY677+8Phlao45cwsZ91zIJUHHEfPjGIsYvwMZmCSCwHGhsVJxKsoiHfQVN750tiOYV9fIoGpOuO/SieeXOpv3Zpk9N922AQEwnyhhNo96vxgXzryabz0qXBSIVe7

On Tue, 27 Jan 2026 11:07:05 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Trying. So far I can no longer reproduce the problem with the patch below applied.
> Obviously that doesn't mean that the problem is fixed, only that I can no longer
> reproduce it. I'll keep trying with different platforms.

Well, the revert of the patch just replaces the flags test with a test for
current->mm being NULL. This patch simply makes all those locations test
both the flags and for current->mm being NULL.

I can't see how it doesn't fix it.

Anyway, I'll start making this into a legitimate patch.

Thanks,

-- Steve
