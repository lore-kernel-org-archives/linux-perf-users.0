Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0D2206BF;
	Wed, 28 May 2025 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748462196; cv=none; b=pHlNoitthsssrlWasyp2AXtKQDLvtowiXBiWgN0IDspPMF1h1hZa83x82JpJtLTIr5h3db5MFZeMOFR6OdMsMOGgM+Ib9BVGjcBkEeATzwGMhJicQuH6LScZUqrJMTv7U93gzYPn4CXg6V4Nqk+fARKknf59xSvvTRX+J5sDqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748462196; c=relaxed/simple;
	bh=pnfecmKSpQYkvxOkvpTwWbsi+mXim4QALt0Lzr4hQOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpjAPKSQ3iTyPi4+k6HliPzPUKW5Lsp21HgofVlBkRpvbEYB3va2UWpwL7vbcyDfPar6Alw0fya1cBJyWHEPu/f9QEy3rDPtNSxLipFXSmy7Yrp0b/RpTbfGGe9SCAqXqKgS1ijBfkX8EuSBDpEVKvDReqo9sjy049/MoE2kjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq7WOE57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq7WOE57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C08AC4CEE3;
	Wed, 28 May 2025 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748462195;
	bh=pnfecmKSpQYkvxOkvpTwWbsi+mXim4QALt0Lzr4hQOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bq7WOE57EBGZ7ojGxYtDeoRGXQOvOAzkr0vDVuW5dz+pNOk+MY8RxNLpMdMcJ//T3
	 28oBNmdhcZWJMktvsSY9a/z8XCaWiOW3m/TRpylW1qLphUXMS1RE/AuCrwC0+b12jC
	 gUBrziJ7VWcpsvGZJfP/xY09H2Dww9tDDoxM8T/JKR7npqUrslsg5rrBfxM7UEFSgO
	 PlljObfXP0oRWfnp5OpUvkjN5dkN7HFk9R5TlEkQ2kxhuDqKnNngmi3gcHMPUANvLV
	 BSRFC6dYpFV8y1KdoKXN0R2C1jjS+9Znert72fLGlZHNZigk86iRRA1n1XLnvJxWai
	 0vofM2t+KXmbg==
Date: Wed, 28 May 2025 12:56:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1] perf build: Fix build for clang's
 -Wunreachable-code
Message-ID: <aDdqcfuAuk78eKXD@google.com>
References: <20250410202647.1899125-1-irogers@google.com>
 <Z_mK9BVv16MT7shL@z2>
 <CAP-5=fWykL-01S=35zz-6JASbM_cQkx6PHdKS7pJAX0=JBTuNQ@mail.gmail.com>
 <CAP-5=fWFYS7-FcbyJ5Z5U2rqA7eYwwJ4dMf90TUzwJ0Shh2yxA@mail.gmail.com>
 <aDdU1npHL2Vczhsa@google.com>
 <CAP-5=fUycjUUWW=hoSSvxfUVPXcqAk5KHnknFuUDOr7+Zf=M2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUycjUUWW=hoSSvxfUVPXcqAk5KHnknFuUDOr7+Zf=M2A@mail.gmail.com>

On Wed, May 28, 2025 at 11:35:00AM -0700, Ian Rogers wrote:
> On Wed, May 28, 2025 at 11:24 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, May 27, 2025 at 01:53:37PM -0700, Ian Rogers wrote:
> > > On Fri, Apr 11, 2025 at 3:14 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Fri, Apr 11, 2025 at 2:34 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > On Thu, Apr 10, 2025 at 01:26:47PM -0700, Ian Rogers wrote:
> > > > > > Clang's unreachable code warning is able to catch bugs like the famous
> > > > > > "goto fail" which gcc's unreachable code warning fails to warn about
> > > > > > (it will complain about misleading indent). The changes here are
> > > > > > sufficient to get perf building with clang with -Wunreachable code,
> > > > > > but they don't really fix any bugs. Posting as an RFC to see if anyone
> > > > > > things this is worth pursuing.
> > > > >
> > > > > I'm not sure if it's useful and don't see what kind of bugs it can
> > > > > address.  The proposed changes don't look like an improvement.
> > > >
> > > > The goto fail case was in OpenSSL the code from a bad merge:
> > > > ```
> > > > if (...)
> > > >   goto fail;
> > > >   goto fail;
> > > > ```
> > > > Meaning the fail path was always taken and checking on the non-fail
> > > > code never executed. Newer GCCs will warn of this because of the
> > > > "misleading indent" but  clang won't. It is easy to imagine similar
> > > > mistakes creeping in, so using compiler warnings to avoid the bug
> > > > could be useful.
> >
> > It doesn't look very convincing to me but it might be valuable in some
> > rare cases.  But the proposed changes - basically replace exit() to
> > __builtin_unreachable() - seem weird.  Why is calling it a problem?  I
> > guess it already has some kind of annotation like "noreturn"?
> 
> Yep. The exit is incorrect (depending on your notion of correct, I'd
> go with clang's notion as they've had to consider this for a while) as
> it can never be executed. I've added the __builtin_unreachable() to
> document that you can never get to that statement, as otherwise it can
> make the code readability harder with the code looking like it will
> fall through after calling something like usage_with_options (which is
> noreturn). In unoptimized builds __builtin_unreachable() will fail if
> executed, so it is a bit more active than just a comment.

Oh I see, usage_with_options() calls exit() inside so any code after
that won't be executed.  Hmm.. isn't it better to remove those codes
then?

Thanks,
Namhyung

