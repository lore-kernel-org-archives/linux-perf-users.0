Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1993E6390;
	Wed,  1 Apr 2026 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775085800; cv=none; b=NMKz4TywEuVvMTAWaLr+pSN+hTGuryPwDzKxL/c+SLufUE0pDD0joRXDd1aP7ZUf6zDbG+Rg1x8YBDrJOubOCqvwnd+5FV3tEq169HfQonSxlLUK0xIHd68T/Un/MbiyxwCOow/9kQgPzkIZymRKSsVSduupo108VfILpgdTvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775085800; c=relaxed/simple;
	bh=ThVFOSlEP8/malbX/IUftwbeQM6dHj10uNLFrmNF8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxwVkUjeo4f1vmbAho3I5Znl+a0wivDG4n8G2kCbgxFujq55eAs8llGeynBG/mccK8oGni41Da5+l7MHQEH1G4PtvdpdUfQAVkdH1uiAPc8UJLT+II6vcYBkqwKMJQUuRfyIxz5pO4A8JV9AWleDasXoAr+NzFGruJw8A2jA/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUzb5JB1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUzb5JB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53D3C2BCAF;
	Wed,  1 Apr 2026 23:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775085800;
	bh=ThVFOSlEP8/malbX/IUftwbeQM6dHj10uNLFrmNF8BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUzb5JB1S3/jY/xzEeZ2Dp5HhEynzgy3CLE9yvR4mBbblj2eftB2PNKoeYcT8zmk0
	 JFXeuopoc4yLyJL4FM94TbCjdZOPt+iQ/Z6CsjAHgKfpyvMTXdEJthnWPLDY8ft4rg
	 rSZY8j+hT1u8js04YN2O20tRlZj/CsqowbJo4G1ZYWbkJoj8ANnnnjVTtcB51s9JW6
	 wDeiOR19UWBI0yAR824+JwRzOG0Mgi8cbdgJcGjS/FAcnvI4isgR3sCT/4MzpmkzKq
	 NxPaIk8XHELS20oueRMcmrxKeOdJzXORcpGjRxnvU5hlqmxJ5VI4NGpIAn2OWzBbME
	 BB75S9yO5aqxg==
Date: Wed, 1 Apr 2026 16:23:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Improve C++ support in arguments
Message-ID: <ac2o5h9MBxpKr6ST@google.com>
References: <20251205123608.3125691-1-sesse@google.com>
 <CAP-5=fW7y93ZfSF0Mrt3nB1Jqu4HaKypEUhH88CTyy9-v4JPdA@mail.gmail.com>
 <ac2J9BRFsmzdJo2J@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac2J9BRFsmzdJo2J@x1>

On Wed, Apr 01, 2026 at 06:11:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 01, 2026 at 02:03:42PM -0700, Ian Rogers wrote:
> > On Fri, Dec 5, 2025 at 4:36 AM Steinar H. Gunderson <sesse@google.com> wrote:
> > >
> > > For purposes of specifying arguments in tracepoints, C++ classes
> > > work exactly like structs, and C++ references work almost exactly
> > > like pointers (they are dereferenced with . instead of ->).
> > > However, they use different tags in DWARF, which means you cannot
> > > use them in arguments.
> > >
> > > Implement support for both, based on the existing struct and pointer
> > > support. This allows us to to something like this in Chromium:
> > >
> > >   perf probe --exec content_shell --add 'PerformanceMark=\
> > > _ZN5blink15PerformanceMark6CreateEPNS_11ScriptStateERKNS_12\
> > > AtomicStringEPNS_22PerformanceMarkOptionsERNS_14ExceptionStateE \
> > > mark_name.string_.impl_.ptr_'
> > >
> > > even though mark_name is an class AtomicString&.
> > >
> > > We don't support advanced C++ features, such as operator overloading.
> > > Unfortunately, we also don't support C++-style strings where there
> > > is a separate length field instead of null-termination. We also cannot
> > > go past ptr_ in the example above (e.g. add ->length_), due to
> > > unrelated DWARF issues.
> > >
> > > Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > 
> > This change makes sense to me, Namhyung?
> 
> Agreed, and there are some other C++ specific (Go as well), like
> DW_TAG_rvalue_reference_type, that we may want to support, also it would
> be great to have some extra workload in 'perf test -w' to have a shell
> testing this feature, no?

Yep, that would be great.  I'm ok with the change but it needs to be
updated.  Also I think we need a helper to check the compound types.

Thanks,
Namhyung

