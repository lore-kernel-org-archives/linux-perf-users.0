Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B29215040;
	Wed, 22 Jan 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562400; cv=none; b=QhXuFHN/uPB8jPiB45qMj9bwWTAxu44ByiDJ1Y2c1EinZh3vutRND+w1V25lQ/MHhkUgO6DgPEp6lNY9oK6cF6RoImg2tqFplXBORVE3RNomMz2R3mgFXGuGGilic0b1uoNJvvN3sjrNgnLp/bBxITbsxKPRm1SwAy+Or3WCh/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562400; c=relaxed/simple;
	bh=Slex//leJAGiw44PzLE42ElZXiAuzCfmGlaUCogurIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqLNlk8Cke3p5vZnaNbjPe+rW9+u6RmiRRVZxpwExHRlPL6NzWnYw1ZrCwhiEMU0V04H5hNGPJtoDtVuHT8aR7coAo9ebLg1hMa+OY4d7PqnptjuH99Y0BKsJ7NBzYjkRrjqsNJTpQJQx9K1qL2eMuHCBmVUlpeDLjXosBmUR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC058C4CED2;
	Wed, 22 Jan 2025 16:13:17 +0000 (UTC)
Date: Wed, 22 Jan 2025 11:13:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 linux-trace-kernel@vger.kernel.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Florian Weimer
 <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 00/39] unwind, perf: sframe user space unwinding
Message-ID: <20250122111322.26eb3540@gandalf.local.home>
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 18:30:52 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> The interface is similar to {task,irq}_work.  The caller owns an
> unwind_work struct:
> 
>   struct unwind_work {
> 	struct callback_head		work;
> 	unwind_callback_t		func;
> 	int				pending;
>   };
> 
> For perf, struct unwind_work is embedded in struct perf_event.  For
> ftrace maybe it would live in task_struct?

Hmm, this is going to be difficult, as I don't want to add more to a task
struct as it's already too bloated as is. I'll have to think about this a bit.

-- Steve
