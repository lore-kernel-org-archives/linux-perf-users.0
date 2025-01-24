Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934019005D;
	Fri, 24 Jan 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737742574; cv=none; b=e+xEd9nhajd60TmPTsFhgJVmV8guZbrKzxaqbpHRxzkB0AFGfr4CN+MLjMoAzecJYJkAgy7L8yLGcBH1udZSvSlC9uxBK2106xeo93fel/fsy4amdqLaLOoOrohFS/DM3qhZGt3HC2+rRjAihI3jz5529GAurEbVLcMOrrRj6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737742574; c=relaxed/simple;
	bh=gUlg07cfYCtqAvUtQVWAhJdnZvO70RjctPhFxBYOdns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHO5JScxNdT9gIw4mBV2w3vz9ZtWrNEHjc85uPU1dCQ6iVHXhcsO1vt3n4Nqtn6fygyV8y8TkoLvElX9X8mICOoHW8tXn1XWTphHFRZBFlVfsqOowKhcslvj3Q5NiZ+mdQESust1P3I0tQ1b9ZZhaIU9cbma69EmaVPwf7c0biw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvdIM/nc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvdIM/nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388BEC4CED2;
	Fri, 24 Jan 2025 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737742573;
	bh=gUlg07cfYCtqAvUtQVWAhJdnZvO70RjctPhFxBYOdns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvdIM/nc1hrTBWvbjO2dTLJgUJ5TAOymVTNvpqneqpQ3Ed3G3+C1re/UJK8kK8WgC
	 /8P0mD3Zg0IsGkwyFxbsnb+wSjnM8h0SnFF1NVQghINPru+w/l/dodFaQl9HzQ8uEt
	 P9vcUNAxMW+nbakNOpRocOabnZ/G6Rh7zBgOaucbfbur4lIabXTeSumkcvW3188uJc
	 aFDklrUCcykqUjpJpCx8SlQZEQs0DZfJskZ39BN7eypctDgEviFUlexv0stCRCTDJq
	 nXmf+SL7J+V0JvozsDxc2ZDLWMBscpjW37aIct3e4Ig714jbf/dmJYsCuzG+Mv5dOO
	 7KtV10w9mN7/w==
Date: Fri, 24 Jan 2025 10:16:10 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 12/39] unwind_user: Add frame pointer support
Message-ID: <20250124181610.zdqvdaeqrp7kyzis@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <10b92f2fd065b67e6e3fd473ca145c34ea74b73a.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzaQr1ruCh1beyhJ_i+aGuw4rGSftF_Zr5ZB=8Jim1jyyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaQr1ruCh1beyhJ_i+aGuw4rGSftF_Zr5ZB=8Jim1jyyQ@mail.gmail.com>

On Fri, Jan 24, 2025 at 09:59:37AM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 21, 2025 at 6:32 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > Add optional support for user space frame pointer unwinding.  If
> > supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_FP and
> > define ARCH_INIT_USER_FP_FRAME.
> >
> > By encoding the frame offsets in struct unwind_user_frame, much of this
> > code can also be reused for future unwinder implementations like sframe.
> >
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> >  arch/Kconfig                      |  4 +++
> >  include/asm-generic/unwind_user.h |  9 ++++++
> >  include/linux/unwind_user_types.h |  1 +
> >  kernel/unwind/user.c              | 49 +++++++++++++++++++++++++++++--
> >  4 files changed, 60 insertions(+), 3 deletions(-)
> >  create mode 100644 include/asm-generic/unwind_user.h
> >
> 
> Do you plan to reuse this logic for stack unwinding done by perf
> subsystem in perf_callchain_user()? See is_uprobe_at_func_entry()
> parts and also fixup_uretprobe_trampoline_entries() for some of the
> quirks that have to be taken into account when doing frame
> pointer-based unwinding. It would be great not to lose those in this
> new reimplementation.
> 
> Not sure what's the best way to avoid duplicating the logic, but I
> thought I'd bring that up.

Indeed!  That was on the todo list and somehow evaporated.

-- 
Josh
