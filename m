Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA8E38DF9;
	Wed, 22 Jan 2025 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737586290; cv=none; b=cC9Uoy4c9rTTsietz22vGPDXfsryFG1Tb+gSeF7K2cV0xskyDPHyVHaVeXc2g9/+5zuASk75Aqihh47feXiHQrR0JKgJO0BUIlK8QkKxeyZW+tMTtgj2Wy87wMjdmmo1HxkaUZBelfcRS4sDRiK1WLk+Xs4ha5Qp3k3tbThhTQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737586290; c=relaxed/simple;
	bh=YWQtUcumTn6FHln6OPiZH3GA/KCi5vn+c6w77T4yNV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MySC0gh7DGVhsBxU3psgmmq/GIUdVqUwVBMPRbNO/5KhquRD+7i2UjSQPAYnPkDUWcc4kT2uQDJDOlQQzgqZAWjzfV/AE4axq65BphesmkU0G7cdZgfSVOGgwMbXc75gi7PJqGfRdLiMsYhA2Jr9ieZKGVLa/y1dI2BDvhYFU94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE7hVB6q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE7hVB6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461A1C4CED2;
	Wed, 22 Jan 2025 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737586290;
	bh=YWQtUcumTn6FHln6OPiZH3GA/KCi5vn+c6w77T4yNV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kE7hVB6qIxmh5xK/N+l5I/TU4XEy8b9gBn3oRMry+qMnY+rl8xvfyt8gUi2AoQsfp
	 xUybRGHeuulunH6xmqnD4SC0e7FAmdhMNn/DEyeptB5xKNaxGhe8b0pD0mkLfKDbzM
	 9r1O+Qg6YS9JuNCYodzETRZz1F3AISBPFRvV5hgp/0zHEWI06lc2gODSlIrnocv0H0
	 fRmCj7i2gQf1U8aZ9KU+YPydgVW0d3SvhRx2sifwTN0vhKckhk6ekiubGVoHKXFWPG
	 DA4xZE+YDh+ij65+EsI0aIj8CQ7HNGjlq4kOC93niJnoC6iIns4nEifFoyDb6VCBgu
	 eBdnhIHKTw8fw==
Date: Wed, 22 Jan 2025 14:51:27 -0800
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
Message-ID: <20250122225127.qhxmqamg7pnugnya@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <20250122133730.GQ7145@noisy.programming.kicks-ass.net>
 <20250122141616.GU7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122141616.GU7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 03:16:16PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 22, 2025 at 02:37:30PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 21, 2025 at 06:31:20PM -0800, Josh Poimboeuf wrote:
> > > +/*
> > > + * The context cookie is a unique identifier which allows post-processing to
> > > + * correlate kernel trace(s) with user unwinds.  The high 12 bits are the CPU
> > 
> > s/12/16/ ?
> > 
> > > + * id; the lower 48 bits are a per-CPU entry counter.
> > > + */
> > > +static u64 ctx_to_cookie(u64 cpu, u64 ctx)
> > > +{
> > > +	BUILD_BUG_ON(NR_CPUS > 65535);
> > > +	return (ctx & ((1UL << 48) - 1)) | (cpu << 48);
> > > +}
> 
> Also, I have to note that 0 is a valid return value here, which will
> give a ton of fun.

The ctx_ctr is always incremented before calling this, so 0 isn't a
valid cookie.

-- 
Josh
