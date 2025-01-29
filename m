Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31720185924;
	Wed, 29 Jan 2025 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738116283; cv=none; b=tCKjRXfKzct3oPnKT5ACJ2+S2eiggsLPRaiss7hVkACKjQ1y0GPl0GWQuJV6VD9usjXZ081Pf9Uc/e2RfCFxPkXS1APDZZtINyXhOrptU6QXjZSLGWeyk1z+fYgyNSPuaJjo7/R6oVFmwQDIYan4oppwtA4wD3AyDKiG4MVwBXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738116283; c=relaxed/simple;
	bh=CbBx4p0bhKHdP4ouAFmGp2+kvH+5Mrt4Ut8ib1YQRY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOJRbTrRjDKhOOMiqb3KygOBtHW0xi36hv/kDSo+Nax6/JALU3b8x7lqKR1IB9H6OYVFwWMam/pOjg3KXiDKKGE5OIY0LcqWi9tr25WW9KRDUZM4cYZc9SExoUuPZX+OzYCoV6ZgQv9FzHYaslY5lliQA7TNfuCWq6rCkMfFXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLQ7QYMz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLQ7QYMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B4C4CED3;
	Wed, 29 Jan 2025 02:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738116282;
	bh=CbBx4p0bhKHdP4ouAFmGp2+kvH+5Mrt4Ut8ib1YQRY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLQ7QYMzSWHkQbVPvfBUTPGqqK5d1I1+ZTQ3mIsMMmcNZZ5FKmoKVvqJ48sUMHw1I
	 y3VUpEJb3UpwRwU5gRNeZX3zhv1TzQzN7JUKZf9G7KtRFCubnzXuYaOcLYfPYHyDI8
	 F1k3Ork+6ejk9iBEMVW+4JZg9hbXkmwKEa7SNiiO+FWrhaIgMIPU7DFAjBvH12Yy46
	 h9oRH71qyb5IQ52yhGhLRtsNqsqJcGCsiLAXnaBBcEd1zjaidUlxJLvcSBcIimPQzY
	 Q3CC+HobH4mzTGahOYMYXC1TrECgWFg3a9vHalaloUgA8K8taQDwe9nWME3vWl+Xkb
	 bbxkqkDf42WIg==
Date: Tue, 28 Jan 2025 18:04:39 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
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
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>, heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v4 19/39] unwind_user/sframe: Add support for reading
 .sframe contents
Message-ID: <20250129020439.rv4e25ppqoeo5y5u@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <77c0d1ec143bf2a53d66c4ecb190e7e0a576fbfd.1737511963.git.jpoimboe@kernel.org>
 <CAEf4Bzb=YFhsLFuK2Zowb1dsXnQPA1uyQUuQ0yXXQbEpeeyDaw@mail.gmail.com>
 <20250124214107.ycccp4gapbdudzux@jpoimboe>
 <CAEf4BzYqDk5pGbmCz3XX1a-RXRKSLw9QwD+wUEABinVG+HZ1qQ@mail.gmail.com>
 <672a4d84-219c-4d45-b3a7-8d9d96e90e01@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <672a4d84-219c-4d45-b3a7-8d9d96e90e01@linux.ibm.com>

On Tue, Jan 28, 2025 at 11:50:25AM +0100, Jens Remus wrote:
> On 28.01.2025 01:39, Andrii Nakryiko wrote:
> > On Fri, Jan 24, 2025 at 1:41 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > On Fri, Jan 24, 2025 at 10:02:46AM -0800, Andrii Nakryiko wrote:
> > > > On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > > > > +       UNSAFE_GET_USER_INC(info, cur, 1, Efault);
> > > > > +       offset_count = SFRAME_FRE_OFFSET_COUNT(info);
> > > > > +       offset_size  = offset_size_enum_to_size(SFRAME_FRE_OFFSET_SIZE(info));
> > > > > +       if (!offset_count || !offset_size)
> > > > > +               return -EFAULT;
> > > > > +
> > > > > +       if (cur + (offset_count * offset_size) > sec->fres_end)
> > > > 
> > > > offset_count * offset_size done in u8 can overflow, no? maybe upcast
> > > > to unsigned long or use check_add_overflow?
> 
> The maximum offset_count * offset_size is 15 * 4 = 60 if I am not wrong:
> 
> > > offset_size is <= 2 as returned by offset_size_enum_to_size().
> 
> SFrame V2 FRE offset sizes are either 1, 2, or 4 bytes.  This is also
> reflected in offset_size_enum_to_size().
> 
> > > offset_count is expected to be <= 3, enforced by the !offset_count check
> > > at the bottom.
> 
> SFrame V2 FRE offset count is 4 bits unsigned, so 0 <= offset_count <= 15.
> > > An overflow here would be harmless as it would be caught by the
> > > !offset_count anyway.  Though I also notice offset_count isn't big
> > > enough to hold the 2-byte SFRAME_FRE_OFFSET_COUNT() value.  Which is
> > > harmless for the same reason, but yeah I'll make offset_count an
> > > unsigned int.
> 
> As mentioned above the FRE offset count is 4 bits, not 2 bytes.  This is
> also reflected in SFRAME_FRE_OFFSET_COUNT().

You are right on both counts, not sure what I was smoking that day.

-- 
Josh
