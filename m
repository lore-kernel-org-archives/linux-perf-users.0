Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5E1D681
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Nov 2023 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OVulI0Vi"
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71B8D4E;
	Mon, 13 Nov 2023 09:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8jJK9PrJUKxGla24Q09ubDd9TDihHkBWmBbnKEzC+YE=; b=OVulI0ViT98C1MR/xDPKT00oT/
	j/SI0kbTtaEB4yK/aKoQU3KrjTgyVbM+FHh54OP6JBQxCPaZg8LPne0GPagTty2YFyzxiuJ6EXcAK
	8+mPirJr9QCoMjEayGJckrofwzN128ApZIJkaxsDAwU4L0MinT5pHhSmbYrBsm+gS8lkS140ri5rs
	S0VlhGXteLVbuu2Kg24gyZ/mhBOixPAoSsPYeiGJhSUZUO9K64lCea8OqkDWR5bMaQC+zITX2tNit
	0agBTvRY3OWOn/D37M1gmkzt52+UiLhAjSkfdoQNhuSIO3O/qfVlMqQ/2f9N2tXopOmPgnZHKIPXt
	bAYB6VaA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r2acV-001gie-0R;
	Mon, 13 Nov 2023 17:21:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C3AE9300427; Mon, 13 Nov 2023 18:21:06 +0100 (CET)
Date: Mon, 13 Nov 2023 18:21:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Message-ID: <20231113172106.GA12501@noisy.programming.kicks-ass.net>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
 <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>

On Mon, Nov 13, 2023 at 08:56:39AM -0800, Namhyung Kim wrote:

> Ok, then BPF gets no user call stacks even with sframes.

Well, you could obviously run another BPF program at return to user and
stitch there.

> Ok, but ...

> If the task is preempted, the call stack would be from another
> task (if it also has the pending call stacks) and we need to
> check which user call stack matches which kernel call stack.
> So there's no guarantee we can just use adjacent samples.

So upon requesting a user backtrace for the task it could request a
token (from eg a global atomic u64 in the most crude case) and place
this in the task_struct. The backtrace will emit this as forward
reference for the user trace.

Once the task_work generates the user stacktrace, it will again dump
this token along with the user unwind, after which it will reset the
token for this this task (to 0).

