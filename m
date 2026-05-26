Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924858F7D;
	Tue, 26 May 2026 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755885; cv=none; b=aOT5sz8oYY1Xal06Tpgw4ezNIq4BjdKOzmnFRtfwzDgXTkVMBhUS5pugvvyhDBt15oI1xVbbqWn9mZoECSLQWCaKoFUmvqz3RC8sZNwfpS53dGdGQ8IPGNs56KMHlai47avlDmJHMTX/7w90ClcDRN+bm652WgaZ9FZEHBwcmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755885; c=relaxed/simple;
	bh=7b9WUA6Oon073MXqg3OXf9hN5UxNB0RyTY4LvxBeBzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REjHaU3en6w7asaEQOy2+ua1EgofGW18lGYbpIPiSDum/HmGbA0of4lCaJsC32VbhrvKmmxZyHRujKycwBHr1VEHd28/CyPe+clKzBPmMF4YfxMW1q1vZnVgZhQTpRukBruI3bso09+6lNk1tDbMW8huYXmNkHmvHol8l3WrfG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfyACkcb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfyACkcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEEF1F000E9;
	Tue, 26 May 2026 00:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779755884;
	bh=J+l//ukBHDQhg9StbUnckzWIkb3cLxIvbJtICtk6JWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WfyACkcbDyzemRP2TKut34NN6NcERlFmal2l2A+zYUrWnqHo5kQm8s3ZT4BWavcVA
	 YV5vJ4srj8SwoTgcsLJanP2JjNotU5WwHpTJGY7QPhqMDhfyczGdERTaIwO/xMEraC
	 LRPJNpvM85aKv7/BIMweGS1lc6t9vE3ECYBtE5QCSSXqGjkEHHfpTjtxHVtA3IAOnx
	 ocbIQ4BH+u534lmP3Js9hdbdkjztrx/khsnmCNm3t4psqKYkWAgUz/hDHXZsC2Xi0u
	 koQgkrv534gQ6kLz9qDoPVuo5cdaA4S//OsePM74cPQj0amdE90+jpmgAEa3mx+oqC
	 M/gcyKSzg/sCQ==
Date: Mon, 25 May 2026 19:38:01 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 06/23] perf python: Add missed explicit dependencies
Message-ID: <ahTraRGMGowOJ4II@google.com>
References: <20260522220435.2378363-7-irogers@google.com>
 <20260522221338.039751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522221338.039751F000E9@smtp.kernel.org>

On Fri, May 22, 2026 at 10:13:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Including `<Python.h>` after standard system headers violates the Python C-API contract and can lead to macro redefinition warnings, build failures, or ABI mismatches.
> --
> 
> commit 37ded89f453597ef269f0bcb73c5907738b8e5d9
> Author: Ian Rogers <irogers@google.com>
> 
> perf python: Add missed explicit dependencies
> 
> This commit fixes a missing include of pmus.h that was discovered
> while cleaning up the evsel and evlist header files. It also sorts
> the include directives alphabetically.
> 
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index cc1019d29a5d0..dd937d714e991 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1,30 +1,35 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include <Python.h>
> > -#include <structmember.h>
> >  #include <inttypes.h>
> > -#include <poll.h>
> > +
> >  #include <linux/err.h>
> > +#include <poll.h>
> > +
> > +#include <Python.h>
> 
> [Severity: Medium]
> Could moving Python.h here cause build warnings or ABI mismatches?
> 
> The Python C API requires that Python.h must be included before any
> standard system headers. Python.h defines preprocessor macros that
> alter the behavior of standard headers. Because this alphabetizes the
> list, standard headers like inttypes.h and poll.h are now included
> before Python.h.

I think it's worth following the suggestion.  I'm not sure if it's
possible to add an exception for the python headers to clang format.

Thanks,
Namhyung

