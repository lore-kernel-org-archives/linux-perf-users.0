Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE4155726;
	Fri, 24 Jan 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749360; cv=none; b=ZMxTdqA9sAbDyP/35kqxp0eNPEWoKfHkdrPQ6Ci9TSKu7D5j0Yl+gbJGFMSnZEvmFky1klxZv8+IijN1NSkCMUXu8IlJBfnkbUxptAhYQXRlBclfKYYzdrtr4OswxrE48JHsh5lFVLSWhvupWiF2oYw6Y4bskZs7RbM+GHfjCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749360; c=relaxed/simple;
	bh=lat2C5RO+BocrWy6YZ8LYv2rEShhQ7AWBZEFKmTNtoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn1UZjW/zfbIqO/enClVJjAZ0SsOyXTOehm6T2RqM1pThn5iiO7PjguRR8BMlIAaKaaLUrM/PcMSU2jA3yDz4wFdgEZiDCsGRmuWoFWt5aiCv3XytAxgTTeIElielCVplx48+2ofLyEauxXbdNyYd1APWZ0T8MOgl38RLPoqpFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64015C4CED2;
	Fri, 24 Jan 2025 20:09:17 +0000 (UTC)
Date: Fri, 24 Jan 2025 15:09:27 -0500
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
Subject: Re: [PATCH v4 14/39] perf/x86: Rename get_segment_base() and make
 it global
Message-ID: <20250124150927.1f957483@gandalf.local.home>
In-Reply-To: <e54e48ab228aa386fb4c5f64ee02ef5291f2d3da.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
	<e54e48ab228aa386fb4c5f64ee02ef5291f2d3da.1737511963.git.jpoimboe@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 18:31:06 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index c75c482d4c52..23ac6343cf86 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2790,7 +2790,7 @@ valid_user_frame(const void __user *fp, unsigned long size)
>  	return __access_ok(fp, size);
>  }
>  
> -static unsigned long get_segment_base(unsigned int segment)
> +unsigned long segment_base_address(unsigned int segment)
>  {
>  	struct desc_struct *desc;
>  	unsigned int idx = segment >> 3;

As this requires interrupts disabled, and if you do move this out of this
file, you probably should add:

	lockdep_assert_irqs_disabled();

-- Steve
