Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995A197A99;
	Wed, 30 Oct 2024 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269050; cv=none; b=NpVyOce2xbpW70bB8BKMp/SsAYdm6F9B0xgDNVV4fYGDmOHQ1XY2igfyOc6PvFvzjelNpkZ+nWQt+lF+57CL/jcsm+vupMasxkRmNi54rKivV/oH15zopMqRJz8jADJbjnxIl0Q/Jhg/TH134QM2BCLemliez5PjRrciLgleQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269050; c=relaxed/simple;
	bh=KjFF9nrrYbN8/+R2wcRFgj/seeT8/hxPycZd47+TIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2x3hCbZjlVpsOMOIa4NxTRhSBnvHCR9cvMSga99wEsufjXRo3UDVpM/SW//rIc5XVqma5s6VDNRahHmTey41VUPWzC6cTveAkTFH6irF9dBa/nVwVdFA1V5y9tHmezMRQE6DIPNkIJkJtdQe+DkSU4DglttzvdS7pdd3T5wcDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4298FC4CEE4;
	Wed, 30 Oct 2024 06:17:26 +0000 (UTC)
Date: Wed, 30 Oct 2024 02:17:22 -0400
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
Message-ID: <20241030021722.2d1fe6d3@rorschach.local.home>
In-Reply-To: <20241029182032.GI14555@noisy.programming.kicks-ass.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
	<a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
	<20241029135617.GB14555@noisy.programming.kicks-ass.net>
	<20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
	<bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
	<20241029182032.GI14555@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 19:20:32 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> The 48:16 bit split gives you uniqueness for around 78 hours at 1GHz.

Are you saying that there will be one system call per nanosecond? This
number is incremented only when a task enters the kernel from user
spaces *and* requests a stack trace. If that happens 1000 times a
second, that would still be around 9000 years.

> 
> But seriously, perf doesn't need this. It really only needs a sequence
> number if you care to stitch over a LOST packet (and I can't say I care
> about that case much) -- and doing that right doesn't really take much
> at all.

Perf may not care because it has a unique descriptor per task, right?
Where it can already know what events are associated to a task. But
that's just a unique characteristic of perf. The unwinder should give a
identifier for every user space stack trace that it will produce and
pass that back to the tracer when it requests a stack trace but it
cannot yet be performed. This identifier is what we are calling a
context cookie. Then when it wants the stack trace, the unwinder will
give the tracer the stack trace along with the identifier
(context-cookie) that this stack trace was for in the past.

It definitely belongs with the undwinder logic.

-- Steve
