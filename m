Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F6354AF5;
	Sun, 19 Oct 2025 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760842201; cv=none; b=q7ETQLE/3rf5mFeTiKD6G46qptxlIhO8Qgs4N20QxWfCHWS0JFhcuvTEhoLY9c+WGgMy+Od2nKjRv2kKPwJ2PaZSkGYzdN3HJg2DuE2i+vMR+Fwf3CXMTylprCFdp2FaHc/sFCFTYgQ3UFRBEFFtXf2sb/l+ua73iDj8UOcQolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760842201; c=relaxed/simple;
	bh=j+jxkbQzSxWIMmjxVYciZ1m6Fj9nJ3b1MJ51VoCVWFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKq8ufaEmg6gIE5eqx+jFqvpJVx/mtDvnYu7YKehSE5Kt6L+wD3kA8Hssz8hTXYkiChOFKFeQZkMvfc04VQQueg7P3xBvMUNu1HycMiYgPouhk9WaZWZIBhcQcB4R/5hW8DHYg5OVINyUkUTTGHTLG0/Eog1oR8VLngowqMhV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXpyuNGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXpyuNGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B514C4CEF8;
	Sun, 19 Oct 2025 02:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760842201;
	bh=j+jxkbQzSxWIMmjxVYciZ1m6Fj9nJ3b1MJ51VoCVWFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXpyuNGRJh/aNj4zXwtdtZb4RTqK9YcNBEJa63+BqYIXRLmzuk5WVpPCmZymZyFPV
	 ipkfOo8DBfIlPi+XXg55LqZFAtwnKk2NjLDDEkjUkcg/UxxkccZPl4B2JKf+49iYvk
	 43S4FojYB34EiICP7wG7SJnwviWVf8ObX8tSxLx14c40sOHAizU3h5BlTwIgJ3YStS
	 1XgmhPi0uKhPCJP2/RBVyd8OjLkf74QDQRg/1W+1XucP/hq5wBjhzRDrCNRDmxb092
	 h1HukhjsdQdksSlCi9aeng/mvoEc8D55g4QlYI7/5rB0HS6o3FQF25/hRqbWR62su8
	 vdxwb2UQLSI/w==
Date: Sun, 19 Oct 2025 11:49:56 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: Add Debian/Ubuntu python-is-python3
Message-ID: <aPRR1APPW8vro4HB@google.com>
References: <cover.1760617634.git.geert+renesas@glider.be>
 <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>
 <20251017122904.GC281971@e132581.arm.com>
 <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>

Hello,

On Fri, Oct 17, 2025 at 06:39:04PM +0200, Geert Uytterhoeven wrote:
> Hi Leo,
> 
> On Fri, 17 Oct 2025 at 14:29, Leo Yan <leo.yan@arm.com> wrote:
> > On Thu, Oct 16, 2025 at 02:44:12PM +0200, Geert Uytterhoeven wrote:
> > > The build looks for "python" and "python-config", while modern
> > > distributions provide only "python3" and "python3-config" by default.
> > > Suggest installing "python-is-python3" and "python-dev-is-python3", as
> > > available on Debian 11 (bullseye) and Ubuntu 20.04 LTS (focal) and
> > > later.
> >
> > Seems to me, this change is not necessary. The Makefile [1] searches
> > python[2|3]/python[2|3]-cofig if un-versioned executables are not found.
> >
> > I confirmed that I can build successfully without installation
> > python-dev-is-python3 package.
> 
>     $ sudo apt remove python-dev-is-python3 python-is-python3
>     $ make tools/perf
> 
> Indeed, it still works. I am quite sure I had to install both, and
> even verified that uninstalling them again broke the build again before
> creating my patch.
> 
> /me dives deeper.
> 
> Aha, I found it.  After uninstalling python3-dev, I got into the same
> state as yesterday:
> 
>     $ make tools/perf
>     [...]
>     Makefile.config:875: No python interpreter was found: disables
> Python support - please install python-devel/python-dev
>     Makefile.config:918: *** ERROR: No python interpreter needed for
> jevents generation. Install python or build with NO_JEVENTS=1..  Stop.
> 
> So these error messages sound like python is missing. And "python"
> is indeed missing, but "python3" is available.
> Hence I installed python-is-python3, but that turned out not to be
> sufficient.
> Hence I also installed python-dev-is-python3, and that fixed the issue,
> as python-dev-is-python3 depends on python3-dev, so the latter was
> installed, too.
> 
> After removing python-is-python3 and python-dev-is-python3, everything
> keeps on working.  But if you never installed python3-dev manually,
> and run "sudo apt autoremove", python3-dev is uninstalled, reintroducing
> the issue.
> 
> So just recomming to install python-dev-is-python3 in the error
> message should be sufficient?
> 
> What do you think?
> Thanks!

Thanks for looking at the issue.

I think the code was to deal with either python2 or python3 in the past
and we removed python2 support recently.  I don't know if any distro
made 'python' to refer python3 and removed 'python3' otherwise we can
just check python3.

Thanks,
Namhyung

