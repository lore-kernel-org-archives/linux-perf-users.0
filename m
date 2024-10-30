Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F4199EAB;
	Wed, 30 Oct 2024 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318300; cv=none; b=r4UdNKL0LRG03AtWDvpoZC3JZ6xXHUR6LCbuBtbcEz1OESeMCTshotG4tnqX1PZquY9hm+iJcFlioz4kf6Z/k8irAXnxFhKaMXWYQKDMsxU7uh7fNB0GJMN5xCfuFCuWeC9NUVIe0ZIVLUGqX3bjTpL1t2e62ISiO+Hsa82o3uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318300; c=relaxed/simple;
	bh=1fWLQgEgTK+V17kPkpcyB3IbVdSjn9Cids4/zFTo7YI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLBBTbXFC1KdRJfsq+SVn5/JYsmYvldsFWE8yY7PUra0sPdoR1WChz6xj30KLMZK1hRs1vqVuPbgNydA16y0qTK9SF3olAg/uLVszMjiCI9AqJr07VvFhrlZR8yQJOQvoBjmfOh2WII5f9BsFGNvK3/YPBoyrLl15RYlg7tMQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ECAC4CECE;
	Wed, 30 Oct 2024 19:58:18 +0000 (UTC)
Date: Wed, 30 Oct 2024 15:58:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
 Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241030155816.094edca5@rorschach.local.home>
In-Reply-To: <20241030140324.GM14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
	<a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
	<20241029135617.GB14555@noisy.programming.kicks-ass.net>
	<20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
	<bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
	<20241029182032.GI14555@noisy.programming.kicks-ass.net>
	<20241030021722.2d1fe6d3@rorschach.local.home>
	<20241030140324.GM14555@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 15:03:24 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> You're designing things inside out again. You should add functionality
> by adding layers.
> 
> Pass a void * into the 'request-unwind' and have the 'do-unwind'
> callback get that same pointer. Then anybody that needs identifiers to
> figure out where things came from can stuff something in there.

What the hell should I do with a void pointer? I want a stack trace, I
ask for one, it gives me an identifier for it, then at the end when it
does my callback it gives me the stack trace I asked for with the
identifier that it belongs to.

The identifier should be part of the unwinder code as it has to do with
the stack trace and has nothing to do with tracing.

-- Steve
