Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5AE1946DF;
	Thu, 29 Aug 2024 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943284; cv=none; b=U8E2KNA4l/6mzrCll6gg/HkZatppcqrUdcjsq1jlzJWJIKy14BABglbdIoC26d3IPU3G5RWd4D3pP+iUstIk9CepHKKgF5OZfTXUHDmbJ4YRGnQUQ6BrKyNclgwkvMIYhDq6bEqr2aZ6jOUBGPbleZ0pMXYFX/DcTc3YjYVBg6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943284; c=relaxed/simple;
	bh=+sNg+YIf6L4RPCJMyrcdmq8e0Kse/YJQU+JIPqKDrvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+CygdIWKLRxsKYAflA8eL016dZ5y17IDlGfDz7f7jYl5giibi+2ntW4pWrdXuPV6SwcNikjFHN08GGRtC7xKAShLDVOXRPmL/uyc3fNQR4aJ6EFx2J0t2loA+pKh49XZ40jWOTOT84u4xq+gSsEJIMhjOCxIgNXRuxAdbMccHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8xU/3LE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8xU/3LE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6786C4CEC1;
	Thu, 29 Aug 2024 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724943283;
	bh=+sNg+YIf6L4RPCJMyrcdmq8e0Kse/YJQU+JIPqKDrvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8xU/3LED0Aj2cHDv6bMWaHr8zJ6N76RkR0/X0l2hg07zlLNSXw1j0YyMMg7uPLQG
	 MDmppvy0sTpegp9RCsHmSIBTmDJZp0PJm8D8F376hV2MC3764Zu8CqdVTRxT2dWOx0
	 wCHFjn+sXMOLO2ycATpovWsudPXu9TT8ono1A5GAhANLffdao4aCYPO51BiZqdZypJ
	 TW+dh2iMXqqTPTT1sbY/3fCDZ70Ot5MGstMqRWRugofNiQbGHY8XN9YtyLQs2RpFyJ
	 sKzG0SKpcxJRj1EZzl/1U4YGIR6CyyDMQqPKoFieA4R1wxGZFmkgygYB2iaiSKncRx
	 Uh3EoBRyK6giw==
Date: Thu, 29 Aug 2024 11:54:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Remove leftover libcap tests that
 prevents fast path feature detection from working
Message-ID: <ZtCLrySDaZNJAEQB@x1>
References: <Zs-gjOGFWtAvIZit@x1>
 <CAP-5=fX-Viz40=J+WQTT8PUDQ+Wtsj1sjA5ZPTxXY4eZo2eXUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX-Viz40=J+WQTT8PUDQ+Wtsj1sjA5ZPTxXY4eZo2eXUA@mail.gmail.com>

On Wed, Aug 28, 2024 at 11:32:06PM -0700, Ian Rogers wrote:
> On Wed, Aug 28, 2024 at 3:11 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > I noticed that the fast path feature detection was failing:

> >   $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
> >   /usr/bin/ld: cannot find -lcap: No such file or directory
> >   collect2: error: ld returned 1 exit status
> >   $

> > The patch removing the dependency (Fixes tag below) didn't remove the
> > detection of libcap, and as the fast path feature detection (test-all.c)
> > had -lcap in its Makefile link list of libraries to link, it was failing
> > when libcap-devel is not available, fix it by removing those leftover
> > files.

> Isn't the feature test still in use by bpftool:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/bpf/bpftool/Makefile?h=perf-tools-next#n103
> I'd deliberately not followed up in removing it because of this.

Right, I just reverted that patch, documenting in the revert text that
bpftool uses it, etc.

Thanks a lot!

- Arnaldo
