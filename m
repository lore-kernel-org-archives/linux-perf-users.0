Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB226AC3;
	Wed, 30 Oct 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297023; cv=none; b=OQVGLb7aNbKyCPebIY/pn64k1LG4EUSRgmYdNWCb8ZFwT8ihT+xo6PLfivgtINXyQyscFhb2i8HSV4IpecXY9G3ezu+qAq656PLxo01vh8vMVL5Phfo082sVZUQiXzuVI/fzs5q/eKWny23kYUsn2C4V3uOwguN3pP/BBMVDGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297023; c=relaxed/simple;
	bh=WREgZgwaUpe0QqIqqKHUlleKGHjEWpMfLFBqRJaBucs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDzRhgsbZoKjV3TbEDzHZQbKhSpUTINh1zLEdDaQH/N5iqLHApyyn9lSQOsK+4Y63DrQFa3u4SM/ZXzDw7wehyNiVpZPTx+NvM9TtZfbKkItckTyjk66a1EuiaKnoeQ3IK3/2ySkqfl2bJ8KRigPqif6BBGbgpQuFJYFOvX1Z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fbtewNI3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fbtewNI3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PWbT83tcerTIQi8XzpZf3kWGF9r+M/FnjfrwWbmtpWI=; b=fbtewNI3zJ1+BvW0SBmygie0hA
	vqIruaTV/c4BX7hGkKMJzFb1sGcoumH+AnQQOhg7T5esdpVpQQGd1LRGuoZYRD3bX3lf/cMOH8VdG
	YZ1Fgp9dkEP9imwvRuZrTMzUGulku2gFtjNW7wMPpt3jvxtESu9159M744XJZs8CTeout/PppwOEg
	5bn3FrFOavsDw37VEFfA6CuSQzmWk6Vh6yv4OUY+2wGyWwoD3PJSg46alHErpUOP9/PryT2WrSn1S
	3pFukxoxFad0cu39jjiMtdpydmYGIQElx9irk1hKQ5pYi8xGJD3a3dOjiFZUDZ5VOoVDNWQE35F9+
	imuIsrhw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t69ID-0000000AGaY-2YuW;
	Wed, 30 Oct 2024 14:03:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A06A300ABE; Wed, 30 Oct 2024 15:03:24 +0100 (CET)
Date: Wed, 30 Oct 2024 15:03:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241030140324.GM14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
 <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
 <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
 <20241029182032.GI14555@noisy.programming.kicks-ass.net>
 <20241030021722.2d1fe6d3@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030021722.2d1fe6d3@rorschach.local.home>

On Wed, Oct 30, 2024 at 02:17:22AM -0400, Steven Rostedt wrote:
> On Tue, 29 Oct 2024 19:20:32 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > The 48:16 bit split gives you uniqueness for around 78 hours at 1GHz.
> 
> Are you saying that there will be one system call per nanosecond? This
> number is incremented only when a task enters the kernel from user
> spaces *and* requests a stack trace. If that happens 1000 times a
> second, that would still be around 9000 years.

We used to be able to do well over a million syscalls a second. I'm not
exactly sure where we are now, the whole speculation shit-show hurt
things quite badly.

> > 
> > But seriously, perf doesn't need this. It really only needs a sequence
> > number if you care to stitch over a LOST packet (and I can't say I care
> > about that case much) -- and doing that right doesn't really take much
> > at all.
> 
> Perf may not care because it has a unique descriptor per task, right?
> Where it can already know what events are associated to a task. But
> that's just a unique characteristic of perf. The unwinder should give a
> identifier for every user space stack trace that it will produce and
> pass that back to the tracer when it requests a stack trace but it
> cannot yet be performed. This identifier is what we are calling a
> context cookie. Then when it wants the stack trace, the unwinder will
> give the tracer the stack trace along with the identifier
> (context-cookie) that this stack trace was for in the past.

You're designing things inside out again. You should add functionality
by adding layers.

Pass a void * into the 'request-unwind' and have the 'do-unwind'
callback get that same pointer. Then anybody that needs identifiers to
figure out where things came from can stuff something in there.

