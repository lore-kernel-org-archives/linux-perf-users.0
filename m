Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42023B0;
	Fri, 24 Jan 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738564; cv=none; b=Rh7wTpBX3tttDOGKvFf40n4ZcFfKDBLThYIkb1MX8h4TCGUfcF/yVXrzv5Xu/6YGEoTB4eDx2z7qiCjtmACrvT81k6Vad4stuVrUHJhu2tYORVeVfl19D8SaZL0yLZZPfXVqwXdh+RPwcVFlRWcGwdbzGENF1JpQpEMBGWSutD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738564; c=relaxed/simple;
	bh=iNmuXDwZuK0qZxAFbFwroLVFsePi12ssQU51ekJzrAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHqiktcr7EwbpY+a3e/iIzVjczO5jt7JaRhfk2X8zj34VqK/Mg7uzs04yyNSCQuY6C14L2ajhthumRk15jBEwF3C+Dtd/dny1AUDUX+9MbLjhPjuWb/4uL/8FWg8Ib32EJPJvPrP4FFmNWwp1aSI7Yye/zttQv8DznuVISYEfWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieZqMWOi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieZqMWOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B889AC4CED2;
	Fri, 24 Jan 2025 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737738563;
	bh=iNmuXDwZuK0qZxAFbFwroLVFsePi12ssQU51ekJzrAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ieZqMWOik2QkTKqrv1o7nfD+wo7NGHLoI3b0VQAW+vvtcyVC06eCIz8slOdgZonem
	 dck36YfNx3GJKfpBhfdPpC0CPjzGKJl3Ij5kiRZvyORM4fmgWRJGjqB2+zd9dmnRZ3
	 qwzRJL+km6U80fulA27dopXG4K6xLq55C360hYOQk6rw4INZT4/cHLoxKhyuKZod3I
	 boxSS74tPsbxyh6lhuR6jRBpV+qj7cdtASwVMDGkIUU3DhGVduSwoYDpcNMmgT0EVa
	 X7DcyyNXFWy+RHf/Cn8eTe7g0bVM2D70+yqw+pqnY0mdgxOBdNw2mLdwzq3x1YHwEx
	 QWiXlUNc0YiHg==
Date: Fri, 24 Jan 2025 09:09:21 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 11/39] unwind_user: Add user space unwinding API
Message-ID: <20250124170921.oa5etcxie3axy6jk@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <cd54347d26967427bc831f473d76e424ba3eba95.1737511963.git.jpoimboe@kernel.org>
 <a02d7751-2e55-47fa-8e97-c9fd803640a1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a02d7751-2e55-47fa-8e97-c9fd803640a1@linux.ibm.com>

On Fri, Jan 24, 2025 at 05:41:29PM +0100, Jens Remus wrote:
> On 22.01.2025 03:31, Josh Poimboeuf wrote:
> > +int unwind_user_next(struct unwind_user_state *state)
> > +{
> > +	struct unwind_user_frame _frame;
> > +	struct unwind_user_frame *frame = &_frame;
> > +	unsigned long cfa = 0, fp, ra = 0;
> 
> Why are cfa and ra initialized to zero? Where is that important in
> subsequent patches?
> 
> "[PATCH v4 12/39] unwind_user: Add frame pointer support" does either
> unconditionally set both cfa and ra or bail out.

Right, probably leftovers from some previous iteration.  I drop those.

-- 
Josh
