Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95D36403D;
	Wed, 16 Sep 2026 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536825; cv=none; b=ayBT9sMN1d6iDvNvLn/84Lmeu8jCQqCzN6Z7DV273R6naLlfY3No2BatqIK6O21wEnKjE6LNHUMW2nUCvaZ0vqLrVHSiUcxDP60R+3/Pi29PfpShnLkXgSmkUDXKt3oQFDcNbCrpRvlEuMdz5S1XtBwc85WGzLH/RYXbcQwfMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536825; c=relaxed/simple;
	bh=2qjND9Nc1bXGSBNchCuG3n3Vxmc5XzAW7RX8d4VmoRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIkFkRW96767xuABXyRh01zI7i1fLcb38sM69pNeyZptMcDZr31kpogKI4KOa2isTK3jgJYV8aYrCRZ+WJbx6lZBYTTlQ8HEW1FSEhE7xaiul/DUqG8YW9m4wzlNEPzVFfUD3gsdbPUuO4l87dHOkAKWSB/xa0MKo+DH2BMlLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0vKQEFa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0vKQEFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55EE1F000FF;
	Wed, 16 Sep 2026 05:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789536824;
	bh=M/tQwlC4QMqO9tKjAZLIq6vIVK/6fmRCOZpbcb8EoUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z0vKQEFajwgqJMdiEAqExq2UW0GIl7YnE8kHUEEMbI9Jih/rNN4To4wGdbaiEu5XC
	 WcHKFdNmYu3xMMuS6+wobo1S022nu9XrCPesoIRbrWNmTKSM6CiKDgqlCuQMzmB/CJ
	 C3H6pKRXWLQPGnMeJs/FCoLvk9nHglINYORfZSaFEplKVVs/MqGpCP3mjVrnUxVK/H
	 acXLl9w4iLVoyVPbs/fQ0CF7j2A3QftTd238TZ6AAC9Y1DxyafAizpBBk05suBRneT
	 hqpf4vBAvxfXpxHwoS2ppvemNGL5oDuU9Vqqn0ujAg7R8jB+tddeQo0g64MrYNhDyg
	 GXDnhUWjcZ5Ew==
Date: Tue, 15 Sep 2026 22:33:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf symbols: Don't apply the symfs layout to
 synthesised paths
Message-ID: <aqoqNqr0DHaO5g-t@google.com>
References: <20260819094621.844115-1-zhanxusheng@xiaomi.com>
 <CAP-5=fVXYFvWOEiH5R+Gc29nfKBGA6y6ULsT68Gudw7ErMVFsg@mail.gmail.com>
 <20260916033648.500387-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916033648.500387-1-zhanxusheng@xiaomi.com>

Hello,

On Wed, Sep 16, 2026 at 11:36:47AM +0800, Zhan Xusheng wrote:
> On Tue, Sep 15, 2026 at 01:31:16PM -0700, Ian Rogers wrote:
> > In those before and after examples, the 'before' case seems to better
> > match what the user is requesting on the command line, so I think I'm
> > misunderstanding something.
> 
> Neither side is the flat layout.  The changelog showed the prefixes and
> not the full paths they end up in, so there was nothing in it to see that
> from.
> 
> For /usr/lib/x86_64-linux-gnu/libc.so.6 the base name is libc.so.6.debug,
> so the flat lookup is /s/libc.so.6.debug.  With --symfs /s,flat, the
> FEDORA_DEBUGINFO path actually tried is
> 
>   before  /s/debug/usr/lib/x86_64-linux-gnu/libc.so.6.debug
>   after   /s//usr/lib/debug/usr/lib/x86_64-linux-gnu/libc.so.6.debug

For the original purpose of the flat symfs, I believe it should be

  /s/libc.so.6.debug

> 
> Both carry /usr/lib/x86_64-linux-gnu/libc.so.6 whole.  perf_basename()
> only ever saw the prefix, because the DSO path arrives after it:
> 
> 	len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
> 	snprintf(filename + len, size - len, "%s.debug", dso__long_name(dso));
> 
> Before is shorter in its first component, which is what makes it read as
> flatter, but the layout that was asked for is on neither side.
> 
> BUILDID_DEBUGINFO is the one I would not try to defend as intended.  Its
> prefix is "/usr/lib/debug/.build-id/", and perf_basename() of a path
> ending in '/' is "", so the prefix does not become shorter, it disappears:
> 
>   before  <symfs>/ab/cdef...ff.debug
>   after   <symfs>//usr/lib/debug/.build-id/ab/cdef...ff.debug

This is somewhat confusing as it uses the first 2 character as a
directory name.  But I believe this should be

  /s/abcdef..ff.debug

> 
> Where the argument is the file being looked for, the option does what it
> says and the patch changes nothing:
> 
> 	__symbol__join_symfs(filename, size, dso__long_name(dso));
> 
> /s/libc.so.6, /s/ld-linux-x86-64.so.2, /s/sleep.

These look fine.

> 
> So the patch is narrow: it keeps a flat request from rewriting perf's own
> fixed prefixes.  It does not make flat find distro debuginfo -- for a user
> whose debug files really are flat under <symfs>, both columns miss.  That
> needs the base name taken from the composed filename instead of the
> prefix, which is a different change and not a Fixes:.  I can write that
> one instead if you would rather have it.
> 
> 8 paths change across those 4 sites and 13 are untouched; hierarchy is
> identical between the two builds at all 21.  The doubled slash comes from
> path__join(), it predates this and shows up in untouched paths too.
> 
> The v2 changelog also said four paths differ while listing four call
> sites; it is eight paths.  That did not help.

Can you please change the symfs join function just to use the basename
so that it can really have the flat directory structure inside symfs?

Thanks,
Namhyung

