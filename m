Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174331DED40;
	Thu,  4 Jun 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590524; cv=none; b=LOUbj41W6SiAGvJshxm91Ko/2yKw3oS4lc4Ie3thCpocaMBRwzP646IOXAu3HuSEQSg6RzJ7jFPh1tCe1ob88pZ9nAUfLhyX8OeV+XpMfrY1pV5oqlHphxNZoaJgqEmchhlK4Stce5Hy0dxdoGSpHqQrNfIAvWwE9ri6xIpZFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590524; c=relaxed/simple;
	bh=d/dW5bFroevR3NQlg/pDTo6ijALhF89Ow3tfTre6xhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmPEvGASN0jcz/zEdXzqZQoIxVQtVT1KwM2P7MfcpNe+iNEk1LhQ2i7jPHoKujTGYUIeBnECTan2sg79+8cJMNYa2Z18F/mlIckWTLB9iEQfHS82mg3cyUUEUxhibQL2b6Hjg9DMbi4TPp5k9RdmKmuohmjHSXl1dgaqPAlVQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSyO36Ip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSyO36Ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8731F00893;
	Thu,  4 Jun 2026 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780590522;
	bh=fTNZNvKWhMbhcFR7CMZxImUiFaW3AgxPZO3W9TmZgAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VSyO36IpaxXA4UFVeBv0tbYwMmKGHII5odxjFfMtAwe8Wsx1l+lkWQJJk3aFqUwZd
	 +/URCCbu6m54pz2JmFSQgBvmkSRQATDsN29LlwJm5P/MZIa2BCuWOxVJhAK52jrZHw
	 tSrQB30Dzr+ymNEWy63iZP7Nceh1Dn+4SWb0MH6lzdrGsH5lOIuQ7ocg9d92x583dn
	 BgtQeRVmiUMsKjrJPksvQf9IJ62AEuE4nnhEpaVznVTKUhJHU/LvQdOBKcL0+wtvtS
	 KbGU08/qwHqYVZl1KYwn1DUS4hXDBTEOlIppwD5kYt5bQaQxnDKcIMN0hdrSR8qVyq
	 XO8wR4SWFIlsA==
Date: Thu, 4 Jun 2026 09:28:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: Re: [PATCH v2] perf lock contention: Allow 'mmap_lock' in
 -L/--lock-filter
Message-ID: <aiGnt_xUewsAYP2y@google.com>
References: <20260505231136.691907-1-namhyung@kernel.org>
 <aiGGmN0jIsTHgUJH@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiGGmN0jIsTHgUJH@x1>

On Thu, Jun 04, 2026 at 11:07:20AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, May 05, 2026 at 04:11:35PM -0700, Namhyung Kim wrote:
> > The -L/--lock-filter option is to specify target locks by name or
> > address.  It's basically for global locks where name or address is known
> > and fixed.  But 'mmap_lock' is a per-process lock so it cannot be used
> > for the -L option.
> > 
> >   $ sudo perf lock con -ab -L mmap_lock
> >   ignore unknown symbol: mmap_lock
> >   libbpf: map 'addr_filter': failed to create: -EINVAL
> >   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -EINVAL
> >   Failed to load lock-contention BPF skeleton
> >   lock contention BPF setup failed
> 
> Hi,
> 
> 	Did this fell thru the cracks? :-)
 
Will check and send v3 soon.

Thanks,
Namhyung

