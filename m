Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D27082D;
	Thu, 16 Jul 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225163; cv=none; b=gV5WLDlz3a9PzYjIQVtRd6MUTJIl7HsUs0KZ9x4H5f2oIKwUCRYHfnpFjhmM70KIUPSd6+9sBg6250UdQ0tbJ7b5/erF6MMgpASrluYVVtqk6xE3YZGewFfZP7uxlJPMcwpHmMWt9CTkIkWfj7yG90Pmti6qWGIW3F/04URJ9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225163; c=relaxed/simple;
	bh=0pjRRP4C/ojlNIexBSr0VFlH3669Sl50LdXBO+/RkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpKysGDU5RbFG0XT8Qz3BoNAuaf8/nGG9lG3QItzt0+sYAZCgP/bczm0NJb7QWySfFCZKIJf/kCj6Aplmj5V4Kx9MSUUzn+fGGuFQAkyLvT6JMVaCb6r6i5WsgN94cEp7VhL0I3NEULUuR4ZO7P+75msv3GpvL3/vUeXSpDWPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9cL9jtC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9cL9jtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2D61F000E9;
	Thu, 16 Jul 2026 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784225162;
	bh=JZEa5MRVEPs2NwI4zDomWcp4kCn2jn6jXK9LPrP9oNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a9cL9jtCWLKdDYjqvzchh6Iw1B7lE/6AHPlwpb7MU8CJMINjZg5JL963YnX2t5/ZS
	 39kOw2haBpj2tPqOWyrGW1h9luiC/0YojJaK6SnaXtjEnvqeuPNsQt97YuwSypP54s
	 tI+3DHog0WrKJw3RXPZZB51QyrCSqkV6FbaBvFB1VMEPtaP8wwNuWvJCgxRRAh+9fr
	 Khp7FB7miSEIam2scCrXBPk6c943840uHjHSgncJY69TnyViazei6NHKh58XTlibNE
	 4F2cRxMewQhNXyW+s8brbHrxx/Rl9Y9GTP3QdUHt5AyWx9od78WO43pnfBeT8l2UQZ
	 0XIxAJZzipFGA==
Date: Thu, 16 Jul 2026 11:06:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix a compiler error in util/libbfd.c
Message-ID: <alkdiIHB8yiSf8e5@google.com>
References: <20260716004336.2731086-1-namhyung@kernel.org>
 <CAP-5=fU00=N5h5h-SJVhbK6858agvO=Yf_6GgAd99FZTKOtOmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU00=N5h5h-SJVhbK6858agvO=Yf_6GgAd99FZTKOtOmg@mail.gmail.com>

Hi Ian,

On Wed, Jul 15, 2026 at 07:44:53PM -0700, Ian Rogers wrote:
> On Wed, Jul 15, 2026 at 5:43 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The bfd_boolean type was gone and converted to the standard bool type
> > but we have some old code that uses the type.  It caused a failure in
> > the build test.
> >
> >   util/libbfd.c: In function 'slurp_symtab':
> >   util/libbfd.c:94:9: error: unknown type name 'bfd_boolean'
> >      94 |         bfd_boolean dynamic = FALSE;
> >         |         ^~~~~~~~~~~
> >   util/libbfd.c:94:31: error: 'FALSE' undeclared (first use in this function)
> >      94 |         bfd_boolean dynamic = FALSE;
> >         |                               ^~~~~
> >   util/libbfd.c:94:31: note: each undeclared identifier is reported only once for each function it appears in
> >   util/libbfd.c:102:27: error: 'TRUE' undeclared (first use in this function)
> >     102 |                 dynamic = TRUE;
> >         |                           ^~~~
> >
> > Fix it with standard bool type and constants.
> >
> > Link: https://sourceware.org/pipermail/binutils-cvs/2021-March/056231.html
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Should we add a fixes tag for backports? It's not clear we can provide
> a sensible SHA.

Thanks for your review.  Yep, the file was moved and it had the bug
before.  I was thinking about adding SHA of the move but not sure if
it's really worth it.

Thanks,
Namhyung

