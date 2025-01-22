Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F38F7D;
	Wed, 22 Jan 2025 21:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581892; cv=none; b=RQ4HwW01vX/YRzhaLj4SwKM35QrBeG1nR7ykPxUsyX6XGj9PY8cdgzf6/tvLSTclHSwY2fiwRswBmosIZftLJZcfprVruJk3TYPz0whKwmFsz7cgbDSmzb3oonpTMok2TqA7OR9Pc/pWp+tKmrX8o7dMnpA31dH3Zie6qccTMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581892; c=relaxed/simple;
	bh=nsa82N+UqX5eUkDvsBsM38qybveCYzz7Y/ICGZXEC8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1e9kLHOdfQqMwYRQYgVCMvKGkNxhxIAw8HqpuB4ipEa6ZvapSonsS0BnclPmYWltLmVLUJZRB7twSiiS+tbb5NHfGdbidpMuXe1K3ORD7RAqP9FJ5oM3DPl2Jsz36JATrmMqyEPAdcG6B7DLhufphtrgvbxM8j6Fg2tXVKgZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI91gAQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI91gAQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A02C4CED2;
	Wed, 22 Jan 2025 21:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737581892;
	bh=nsa82N+UqX5eUkDvsBsM38qybveCYzz7Y/ICGZXEC8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JI91gAQ3Mikl+ahGA4pYV+Iy9w+Xys7F1IwWQc+cpixaXLs9nAXUJIoyAnQgXszjF
	 h97W5G0piJR5rDmfJYf/O53bVuaowS5LD2H1LslhpZocMiEJ5UuCpaWjWKmu0EGDs7
	 63t9+J+K6DUY8HIFyngRu+IYUXvns4FCrtvkmgfrpWEDhSb4xZ1TYd1ocBB4P7ORAv
	 s8tFe1vMYjsp4QwaIGyH2dTkbmd11c7QpjKi3hdBhy53/LCzE4Ns39/fbLkmSG7zQx
	 9IYFfafSnrdgfa1Q+aeDAoY/qmWYvX+GUFQyDrQO6MzeCM1Nqm5scQJbci1A6Keajl
	 COG0Gn+JHYf0g==
Date: Wed, 22 Jan 2025 13:38:09 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250122213809.wcpmpvexg3gmzsoq@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <20250122133730.GQ7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122133730.GQ7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 02:37:30PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 06:31:20PM -0800, Josh Poimboeuf wrote:
> > +/*
> > + * The context cookie is a unique identifier which allows post-processing to
> > + * correlate kernel trace(s) with user unwinds.  The high 12 bits are the CPU
> 
> s/12/16/ ?

Oops.  Code is right, comment is wrong.

> 
> > + * id; the lower 48 bits are a per-CPU entry counter.
> > + */
> > +static u64 ctx_to_cookie(u64 cpu, u64 ctx)
> > +{
> > +	BUILD_BUG_ON(NR_CPUS > 65535);
> > +	return (ctx & ((1UL << 48) - 1)) | (cpu << 48);
> > +}

-- 
Josh
