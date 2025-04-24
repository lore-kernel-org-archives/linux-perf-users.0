Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80F27FD72;
	Thu, 24 Apr 2025 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516735; cv=none; b=nUmJSGlSzfzlUHRzWG50l3qjNocafiDDp+3yw2UVJd0YqYMVdNFE+ngEyvPbTmfEshBkeQHUIyc1fWZOSa7YutuASD30A6kKzuKENo2JOm6iYm0SeNXaiJUR8OYkfCLb8gPEqEgUQa0w8OEWd8YCUenWEeoLwg68gxkmWx+Fm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516735; c=relaxed/simple;
	bh=OjvIsPkYeiGOVCMaQkPn+Dv3j9wFmvWUJG1fV1TTiqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4p/rYulW1/X1YVZmEFTKOADm7Bp8lTWf3/PzUDQp0Rqd0OqWArUnYcjVcd7ALmJA6YImq3cc+cVjPWufNeQb72F5DzYNqNUWfVzT6KsdJvHFnf0xOH/CJlTG22qEQymMwpz5FF1qPKrxVMVj7soxJTIht3nOyns3zV94hux0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B3BC4CEE3;
	Thu, 24 Apr 2025 17:45:31 +0000 (UTC)
Date: Thu, 24 Apr 2025 13:47:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Weinan Liu
 <wnliu@google.com>, Blake Jones <blakejones@google.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 11/17] perf: Simplify get_perf_callchain() user logic
Message-ID: <20250424134727.0e8fd0ce@gandalf.local.home>
In-Reply-To: <2fe98d8a-1165-45ac-b539-d597dd1bbcaa@efficios.com>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.048002581@goodmis.org>
	<20250424163607.GE18306@noisy.programming.kicks-ass.net>
	<20250424132800.49160c2e@gandalf.local.home>
	<2fe98d8a-1165-45ac-b539-d597dd1bbcaa@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 13:42:16 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> The case I'd be careful about is if the code can nest over exit_mm()
> (e.g. interrupt) after it sets current->mm = NULL.

Then probably we should always check if current->mm is non-NULL before
using it then, and not rely on just task->flags.

-- Steve
