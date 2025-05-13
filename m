Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14A1CD0C
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170795; cv=none; b=g7JtYpL2Qbpcuu6PJvaVUNGDRDC7WcEywIHKxipK7BLcKomm6l46VCrPt7b0qOlQAu5vTvT73sFMz+86rdur4oGp49rMz/yPeTRvfL1H7LpZJQ10FBr+yUSTQgb04brui9SDv/7CVaeAqIv7x2tOcZQPqnE6gw9i0hwItpHcf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170795; c=relaxed/simple;
	bh=lSO4G0MjFvkGxsdN+DqSJNonGJ8MvH7A4Iu1Mc6BmP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIaue2ssiffjWuoRqycr0Qov4GR3fjIWzZLHAvJRmW5bk3uImofUN1RR+ut7C1Akz0ocPv9iCVdmJ4SUwo6yqfZfHDrxk9S8+YEWWc1c4QdwUcu4L4FDQ5ZQEYV7ihenOSGlyBDNy03iekH9orDREg4D46x6ZReR+l71acI54vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0A/21tC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0A/21tC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBFEC4CEE4;
	Tue, 13 May 2025 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747170794;
	bh=lSO4G0MjFvkGxsdN+DqSJNonGJ8MvH7A4Iu1Mc6BmP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0A/21tCQi6vmsNbJWgrgIkhRnXXsZZZFp29g0KlyDxWe8VKPnCzSGMky3IYKe0Rl
	 fmYCvX3Xq0jG6/vyPYhEi4ETHBbyTs0ULaTOYOEP/6BnBTkx7TOJMx1GBRdpHfTS/9
	 +tcApLMg1oKpQLNZsNeZUHb+mmj7h1ngiy2vHRuTILBExPY/mxIieRt2x8mNJuSag1
	 CaPF1umLUhOuazh2viAt8m14uuL2wg5BVLV65zOhR/fkrWBZC8wUuNbkIckjjoU1k3
	 fvbpzRexfWzyBgqHdgXAgMJGQQ8DlnIwVCsmdjDY4VpPBRPF8vVEL50anM0rKcFdpn
	 dkCtoehopzuiQ==
Date: Tue, 13 May 2025 18:13:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	Likhitha Korrapati <likhitha@linux.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH] tools/lib/perf: Fix -Werror=alloc-size-larger-than in
 cpumap.c
Message-ID: <aCO156Qh5mbeR4Sk@x1>
References: <20250406163412.897313-1-likhitha@linux.ibm.com>
 <E58C5DCA-5F52-4B61-A816-DE932BA40FDA@linux.ibm.com>
 <baad9d65-07b1-4a19-aea6-5ba5d60da98e@linux.ibm.com>
 <1b1450a8-f091-4091-981d-76b27f61be24@linux.ibm.com>
 <D1C1E5D6-085A-41D1-85AB-52809C956BFB@linux.ibm.com>
 <aAvKg8K2fyrZ6zy4@x1>
 <wqewmdha3bx7pmxqwbna26qnl55fcejqsjs4b2zhuciddpb3b5@7ztolpf6erwo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wqewmdha3bx7pmxqwbna26qnl55fcejqsjs4b2zhuciddpb3b5@7ztolpf6erwo>

On Fri, May 02, 2025 at 01:14:32PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Fri, Apr 25, 2025 at 02:46:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > Maybe that max() call in perf_cpu_map__intersect() somehow makes the
> > compiler happy.

> > And in perf_cpu_map__alloc() all calls seems to validate it.
 
> > Like:

> > +++ b/tools/lib/perf/cpumap.c
> > @@ -411,7 +411,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
> >         }
> >  
> >         tmp_len = __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
> > -       tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> > +       tmp_cpus = calloc(tmp_len, sizeof(struct perf_cpu));
> >         if (!tmp_cpus)
> >                 return -ENOMEM;

> > ⬢ [acme@toolbx perf-tools-next]$

> > And better, do the max size that the compiler is trying to help us
> > catch?

> Isn't it better to use perf_cpu_map__nr. That should fix this problem.

Maybe, have you tried it?
 
> One question I have, in perf_cpu_map__nr, the function is returning
> 1 in case *cpus is NULL. Is it ok to do that? wouldn't it cause problems?

Indeed this better be documented, as by just looking at:

int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
{
        return cpus ? __perf_cpu_map__nr(cpus) : 1;
}

It really doesn't make much sense to say that a NULL map has one entry.

But the next functions are:

bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map)
{
        return map ? __perf_cpu_map__cpu(map, 0).cpu == -1 : true;
}

bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map)
{
        if (!map)
                return true;

        return __perf_cpu_map__nr(map) == 1 && __perf_cpu_map__cpu(map, 0).cpu == -1;
}

bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
{
        return map == NULL;
}

So it seems that a NULL cpu map means "any/all CPU) and a map with just
one entry would have as its content "-1" that would mean "any/all CPU".

Ian did work on trying to simplify/clarify this, so maybe he can chime
in :-)

- Arnaldo
