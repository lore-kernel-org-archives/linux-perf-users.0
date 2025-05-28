Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD128E585;
	Wed, 28 May 2025 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456665; cv=none; b=pJ7pdaY1m37unCd/RgQn4ZZ7nb2sevJV3Y0Q2KmhcZlkYGjcW2F/7LLIDsoQxsdm5JPlfEZTmFGrBdj9vgNPwVWyXxdYq/X0bMrWA5x3H2w3Y+D+xblUMj9CB1YScnetkLPKPxJIOQjlBL5DDZ7YjxiA/TKrjkhVPMG+7ieFwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456665; c=relaxed/simple;
	bh=VdtY8LqEyBJypLL5p9nIDE+rbyWPhX/d8Y9T4l0C3Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNPYiHS8pDsjGE/t2iv+PBOiRKdAIgsoojaBcD8I2ly825ZSM4iwtbw+a8xAboFOjasC1TYpqbHjVF07IIMRmijRSmYVJPT4Ff/xrGdd90yJidN5RH4VXMV/pOi42Itb/1ZypFrnV2902OwoLg5DcoU9fCCEEKFareJlJelnD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPhtmiXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPhtmiXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B35BC4CEED;
	Wed, 28 May 2025 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748456664;
	bh=VdtY8LqEyBJypLL5p9nIDE+rbyWPhX/d8Y9T4l0C3Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPhtmiXcJ/CDPHmkzH6ZeAnm3VOouWW2jo1NU2cVzU3XJE407CBJfkWNI5VyQsf2L
	 i9yC07kM3ppoQQupL20LMvolMMAyM4SnACNStq/4aszjmi0q6rR8i9Dg0zc6RkDdr1
	 aacxX5by0RYlMcjexBLDZBZQCmp4JAakfLjPv6B6CXGyEGT5TvscgWxw9IGjUAsyej
	 xedLpE+tVuEGln0jEe1qTHubC1DAxouNvZggEUXnISkxTEueiGlVaJlQDQzmQlB6Dr
	 Gt7ih24VuOPw5/c8OXBdnZAuJKRH7vpFso4l2lvkIi8R80nsaTMbVPxC4t5ASbKzOK
	 LmV5pOSONMBcw==
Date: Wed, 28 May 2025 11:24:22 -0700
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
Message-ID: <aDdU1npHL2Vczhsa@google.com>
References: <20250410202647.1899125-1-irogers@google.com>
 <Z_mK9BVv16MT7shL@z2>
 <CAP-5=fWykL-01S=35zz-6JASbM_cQkx6PHdKS7pJAX0=JBTuNQ@mail.gmail.com>
 <CAP-5=fWFYS7-FcbyJ5Z5U2rqA7eYwwJ4dMf90TUzwJ0Shh2yxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWFYS7-FcbyJ5Z5U2rqA7eYwwJ4dMf90TUzwJ0Shh2yxA@mail.gmail.com>

On Tue, May 27, 2025 at 01:53:37PM -0700, Ian Rogers wrote:
> On Fri, Apr 11, 2025 at 3:14 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, Apr 11, 2025 at 2:34 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Thu, Apr 10, 2025 at 01:26:47PM -0700, Ian Rogers wrote:
> > > > Clang's unreachable code warning is able to catch bugs like the famous
> > > > "goto fail" which gcc's unreachable code warning fails to warn about
> > > > (it will complain about misleading indent). The changes here are
> > > > sufficient to get perf building with clang with -Wunreachable code,
> > > > but they don't really fix any bugs. Posting as an RFC to see if anyone
> > > > things this is worth pursuing.
> > >
> > > I'm not sure if it's useful and don't see what kind of bugs it can
> > > address.  The proposed changes don't look like an improvement.
> >
> > The goto fail case was in OpenSSL the code from a bad merge:
> > ```
> > if (...)
> >   goto fail;
> >   goto fail;
> > ```
> > Meaning the fail path was always taken and checking on the non-fail
> > code never executed. Newer GCCs will warn of this because of the
> > "misleading indent" but  clang won't. It is easy to imagine similar
> > mistakes creeping in, so using compiler warnings to avoid the bug
> > could be useful.

It doesn't look very convincing to me but it might be valuable in some
rare cases.  But the proposed changes - basically replace exit() to
__builtin_unreachable() - seem weird.  Why is calling it a problem?  I
guess it already has some kind of annotation like "noreturn"?

Thanks,
Namhyung

