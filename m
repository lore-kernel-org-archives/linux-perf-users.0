Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E391B4236;
	Wed, 22 Jan 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737548916; cv=none; b=nMJrjyMuqLpjDKfGgCRfy5kUTRZp2iUAqjGUvAaK8lou3+nk5662C+pBassmi0RkDpQEOEwczZsY/vTymlZbnqQk9i+2U3vrWtO1EKFHOpuSn/43pS1jQIvTWrPF0njv4/rS0LvAI7VHKn/WlExsy4vmnn68ePb9K5/JhDvkLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737548916; c=relaxed/simple;
	bh=ZEIuYuFzpVNpnsaS1IElgVqUFXAjuJxM/2XVfTsuvIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuTx2kN+RXl/dE26Gvx13i/ITvLa/UiMnxrSRh7Hmmrb0HL2phhn0huoP9ZqaEZG11PjZvd3n2uNKS3AWl0sbFBvPPNsBRp1BsINBE9OkAiNpibcjonwG5AOWxrto8usa2CZOzx9EbqvtR/9Chu9wlfk241kfO44mh1nVSCcO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dSqXYNcg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dSqXYNcg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mm5ArHntQGgCQyeZEglTwhSTgAAN5NBYsIo5LY4N9qU=; b=dSqXYNcgxWQZB5Dw3/WmTmp89F
	XpxW7Tk4KP2ZaAxR6FPc+5uK6QzzXae5rPqA1UM7MOnX9TJrlT3xDGAeoZ3y/bIKZnqLzhiCBnvWe
	F/nxVx8M97zyaznlN03p257T7PRoTA8m5F9TjzV79GKY/hHDLc4s9/kyrElLI+OmHRalNOgGHzvNG
	7WPAP//61pm4OOSTDU8wf/DksyGLTYhzDEpYVFXiYRc/rMeqSbr2/iVtfe3bz0Q8Gce8ZIwzzAdOk
	cBACy3T69NYVEG0duA60LHQfYv+/3Efw+kNVFRSB7eAoRF6v0gpX4VMT/qTG5Q+mzYbRMFKB2697m
	k2DyDcww==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1taZqI-00000001AdU-21FZ;
	Wed, 22 Jan 2025 12:28:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 14641300599; Wed, 22 Jan 2025 13:28:22 +0100 (CET)
Date: Wed, 22 Jan 2025 13:28:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 01/39] task_work: Fix TWA_NMI_CURRENT error handling
Message-ID: <20250122122821.GN7145@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <b46cca62b5ebd131d0a744572e57f5ebc53d5ef4.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b46cca62b5ebd131d0a744572e57f5ebc53d5ef4.1737511963.git.jpoimboe@kernel.org>

On Tue, Jan 21, 2025 at 06:30:53PM -0800, Josh Poimboeuf wrote:
> It's possible for irq_work_queue() to fail if the work has already been
> claimed.  That can happen if a TWA_NMI_CURRENT task work is requested
> before a previous TWA_NMI_CURRENT IRQ work on the same CPU has gotten a
> chance to run.

I'm confused, if it fails then it's already pending, and we'll get the
notification already. You can still add the work.

> The error has to be checked before the write to task->task_works.  Also
> the try_cmpxchg() loop isn't needed in NMI context.  The TWA_NMI_CURRENT
> case really is special, keep things simple by keeping its code all
> together in one place.

NMIs can nest, consider #DB (which is NMI like) doing task_work_add()
and getting interrupted with NMI doing the same.


Might all this be fallout from trying to fix that schedule() bug from
the next patch, because as is, I don't see it.
