Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0821BF3A;
	Thu, 22 Aug 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358405; cv=none; b=bDPuZuRoDMj3Swl7j1Sqg6pg3G+Ti0t6aS0bw/3Uz6bTr9Qmkufoa9zf0D1zqmc7u4CaLFWPLsHI1SKL5lgQeKLG5AOiAYalBw8ZenB4drH96YWjPrWcrUHrJ5n+3Y5xAwC78fKukkCVTTUKGJUwCqMrCATZj6toHCatcUXNobE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358405; c=relaxed/simple;
	bh=frxqg9aAef2OsOIlFRw2Ax328+Ft+xt9ccrgfJQaQBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MizN/7cTRtAfIR0neWEaKLoo2HUtMFKx2UD0UZTKULxAPx+I42yS6l3dyK5SohDqSFchXRB23axwLA8tlIBVhEeMxnE/yVO8PrrGWNIGlFKVvOu0VT02xDT8Ng8a8wM05xTSeab2KCE0+hM0wKXjJQVkSshycjXLZ3tFfbtuRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjNgswlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjNgswlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAF4C32782;
	Thu, 22 Aug 2024 20:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724358405;
	bh=frxqg9aAef2OsOIlFRw2Ax328+Ft+xt9ccrgfJQaQBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjNgswlBToBNQhdLWltsZAU11zgVBaqbVi+tiqPz7UBZwxIvaf9+7vVWnWxrmI2gy
	 b0KB0y16wbXTYs2g6g8exjr0h1rDAGpCZ/M94U/1NiC6HPG+kROfktgrOeI6+TjUgM
	 xmCGyGucFbX1CZ1ycjcUPctUjepD1nqqraWCz4LMr/i+YT0s8jXgL30d8IYDfo0vSZ
	 BvA0CmAIQAC3BF+21EnEArkGFGt24hVKJ3u/GPx9Ylqzce+HnRzRu3q3f4zBx6WSnX
	 cmyFxS4g2ouX0gbWuyo2Il04KGht9zQsDWiBDWIOX3rUNNz/Rk10m1hJ8XfHRD0vlQ
	 BmFPqvpHcLWdw==
Date: Thu, 22 Aug 2024 17:26:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sedat.dilek@gmail.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
Message-ID: <ZsefAWKrE7jdlxhl@x1>
References: <ZsdUxxBrpbuYxtXN@x1>
 <CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com>
 <ZsdxinrZP1kHINWT@x1>
 <ZsdzLmIFWRqsXeXD@x1>
 <CA+icZUURwYd8nJSdMU7KW6nFjubi-VD2f-a5+zQNQGUxK7+2aw@mail.gmail.com>
 <Zsd39zG9BuGpZ8aA@x1>
 <CA+icZUXGV9dMGcRwJiP7WLcYUaY5CRCcDw1HLFr+9Sn7CrRGDw@mail.gmail.com>
 <CAM9d7cgSR4OroaX0FuBvC_bPPMeEr7ThXJwqgMfAnj-Lfk8wNw@mail.gmail.com>
 <ZseBZ1DIi4Y5zC2W@x1>
 <CAM9d7cib0JFJPM4KdFDPkw_2K0Nu79QGHBsVZ7XyR-Yz1ZBHdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cib0JFJPM4KdFDPkw_2K0Nu79QGHBsVZ7XyR-Yz1ZBHdg@mail.gmail.com>

On Thu, Aug 22, 2024 at 01:11:22PM -0700, Namhyung Kim wrote:
> On Thu, Aug 22, 2024 at 11:20 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Aug 22, 2024 at 11:17:21AM -0700, Namhyung Kim wrote:
> > > > On Thu, Aug 22, 2024 at 7:40 PM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > > From 155212c965b5b23a90b8558449dbfd1c60dad934 Mon Sep 17 00:00:00 2001
> > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date: Thu, 22 Aug 2024 14:13:49 -0300
> > > > > Subject: [PATCH 1/1] perf python: Disable -Wno-cast-function-type-mismatch if
> > > > >  present on clang
> > > > >
> > > > > The -Wcast-function-type-mismatch option was introduced in clang 19 and
> > > > > its enabled by default, since we use -Werror, and python bindings do
> > > > > casts that are valid but trips this warning, disable it if present.
> > > > >
> > > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > Cc: Ian Rogers <irogers@google.com>
> > > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
> > > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > Can we also add 'Fixes' tag to make this picked by stable kernels?
> >
> > Fixes what? This isn't a regression, clang 19 isn't available for Fedora
> > 40, the most recent.
> 
> No, I'm not saying it's a bug.  But we may want to build the old
> source code using new clang.

Sure, and with the tags we have now, we can signal it by using Closes:
and Cc: stable@kernel.org, without a version, I added those, the tags
section then is this:

    Closes: https://lore.kernel.org/all/CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com
    Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
    Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Nathan Chancellor <nathan@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: stable@vger.kernel.org # To allow building with the upcoming clang 19
    Link: https://lore.kernel.org/lkml/CA+icZUVtHn8X1Tb_Y__c-WswsO0K8U9uy3r2MzKXwTA5THtL7w@mail.gmail.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Ok?

- Arnaldo
