Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FAD31AAAA;
	Wed, 27 May 2026 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916637; cv=none; b=ji3BzcvCYa015HqD2G7tcH1EsWXI8eZ1oFuaZqtwW+2WB53/OvNjAww3MGzy/oa2p6QtqACOrvTq8aeDAPzEwetC8hZPgmBsgcEYIFeqndr5ov68uUym56tWx11wd/HadDMfOTPqG1xi8oHS7j0ui9i2mpfDiV+xP3zkAgkQ+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916637; c=relaxed/simple;
	bh=YtMVtpQ0gkIxEAKoZwZw9MFPu0VHMtkmMgOpHvRAl+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN2rhyANA3NHkwUYHxCwqqwcRk78LacYwuS6fvahJ9b4VSdYDwTezBGFArD06nf4MHznmBYorC9fYjl+d9KhJx4jXEPjh9T4y7s+1ufHWI8Y583QkLC88d2x6oag//4NXf55eANgX/8m5k5pn4cj5JXNT8DT2DTTftcftt2YlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBeoaAw0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBeoaAw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E289A1F000E9;
	Wed, 27 May 2026 21:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779916636;
	bh=Kr7F2nWm8acDlq6jnSXZWOVTekSqLdzQeWD6dWuNykc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bBeoaAw0PC/mEGn+kHzrzyh/FhC48f9xx2eIh0ajK2SE4gd8twPl2/LxMmA5qhbA7
	 RhzEcBGbmYbq6f+v3Y17S59Ywo3CYx2c9dclLSwSMi3sFpD7Tc2b73DsK/NzH4+xe4
	 Kpy1rCK4NIIft/1xtqMd8xf1E46mFpkK80llODmZlFfj0VYjx2bmMoEDx2K/AMk8xo
	 tXctj9zVkUMgZCgvJ5jL3Unjxmg6Jl3nYsyA8Wl89qIICYxXmgIREGcJGjIJ+1lQNm
	 sPqATuMg/8rwt0gdtK3mjDQNpD2mSfal4yOc3chpFUStxjwlCS0pjPRZMi3U4nvUR6
	 tAgGYZgV0278A==
Date: Wed, 27 May 2026 14:17:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 06/23] perf python: Add missed explicit dependencies
Message-ID: <ahdfWRS_Y_3FrNJg@google.com>
References: <20260522220435.2378363-7-irogers@google.com>
 <20260522221338.039751F000E9@smtp.kernel.org>
 <ahTraRGMGowOJ4II@google.com>
 <CAP-5=fUFKEdLQEjfW7aiwpO0fEeumcJ-djDuibsd4sr5NLW9Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUFKEdLQEjfW7aiwpO0fEeumcJ-djDuibsd4sr5NLW9Ug@mail.gmail.com>

On Mon, May 25, 2026 at 08:28:16PM -0700, Ian Rogers wrote:
> On Mon, May 25, 2026 at 5:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, May 22, 2026 at 10:13:37PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Medium] Including `<Python.h>` after standard system headers violates the Python C-API contract and can lead to macro redefinition warnings, build failures, or ABI mismatches.
> > > --
> > >
> > > commit 37ded89f453597ef269f0bcb73c5907738b8e5d9
> > > Author: Ian Rogers <irogers@google.com>
> > >
> > > perf python: Add missed explicit dependencies
> > >
> > > This commit fixes a missing include of pmus.h that was discovered
> > > while cleaning up the evsel and evlist header files. It also sorts
> > > the include directives alphabetically.
> > >
> > > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > > index cc1019d29a5d0..dd937d714e991 100644
> > > > --- a/tools/perf/util/python.c
> > > > +++ b/tools/perf/util/python.c
> > > > @@ -1,30 +1,35 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > > -#include <Python.h>
> > > > -#include <structmember.h>
> > > >  #include <inttypes.h>
> > > > -#include <poll.h>
> > > > +
> > > >  #include <linux/err.h>
> > > > +#include <poll.h>
> > > > +
> > > > +#include <Python.h>
> > >
> > > [Severity: Medium]
> > > Could moving Python.h here cause build warnings or ABI mismatches?
> > >
> > > The Python C API requires that Python.h must be included before any
> > > standard system headers. Python.h defines preprocessor macros that
> > > alter the behavior of standard headers. Because this alphabetizes the
> > > list, standard headers like inttypes.h and poll.h are now included
> > > before Python.h.
> >
> > I think it's worth following the suggestion.  I'm not sure if it's
> > possible to add an exception for the python headers to clang format.
> 
> I believe we can set Python.h as having the highest priority and
> always including it first. I want to make sure the Sashiko is advice
> is accurate first :-)

Yep, looks like so.  The first note section in the "Include Files"
explains that.  Probably we should define PY_SSIZE_T_CLEAN as well.

https://docs.python.org/3/c-api/intro.html

Thanks,
Namhyung

