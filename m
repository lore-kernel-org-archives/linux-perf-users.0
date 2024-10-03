Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFC197A65;
	Thu,  3 Oct 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967323; cv=none; b=BHHFHLxv2coJqatCOJheIsOAEVHiV+NSuf9hsajsHVM4IFKRJPxb5ueN4dd+5SZBHxkMEPpfNU0+0fBPTz4SITu7ZeqOKej5rw2PlE3yucJ8oDek5qDaI8HytdycO3fw7R087AcBCyOPQCXws4MAZSZeXIwe+lhIkXiFdm9RAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967323; c=relaxed/simple;
	bh=/JDDZfDHQofBOOkYa8KN/nn1lXdqbueoXdqG1881SU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NN49/eanlodMNvf4RNRsax/fuTdTcFu/KS9vscz4tN00byFZuQ7PtgpuCvmJXyApRmANTSYTEJ394Uv56JOrT9+gI2MGzntM5T91AY4mJmW06XgVeae2+wXdbO7V2IKRupPFqOMn/fUL7WZ7y+KInhDnEo+k4WD7XpfzLW0c+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C228C4CEC7;
	Thu,  3 Oct 2024 14:55:20 +0000 (UTC)
Date: Thu, 3 Oct 2024 10:56:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20241003105614.7d1aeed3@gandalf.local.home>
In-Reply-To: <20241003023702.4bam6cj5opcz24em@treble>
References: <cover.1726268190.git.jpoimboe@kernel.org>
	<20240914081246.1e07090c@rorschach.local.home>
	<20240915111111.taq3sb5xzqamhb7f@treble>
	<20240916140856.GB4723@noisy.programming.kicks-ass.net>
	<20240916153953.7fq5fmch5uqg7tjj@treble>
	<20241002223125.2d610510@gandalf.local.home>
	<20241003023702.4bam6cj5opcz24em@treble>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 19:37:02 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > That was just one issue. Things are still not working but I'll debug the
> > rest later.  
> 
> If you don't want to run on the bleeding edge, I'll be testing it soon
> myself once I get the coding done for my v3.

Yeah, I'll wait for that. I have some code working for ftrace on top of
this, but I also promised Mathieu I would start looking at his faultable
trace points, so I should do that before working more on sframe.

-- Steve
