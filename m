Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3111ABED9;
	Wed,  8 Jan 2025 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367618; cv=none; b=XdueGQMF2uRcKHF6TyOwHBRylBlwMazU3ObUTRy+Yw+1GBxQEc5/ZVftGy9IC5X4ZBlMi80J/LDIQk6ECW6NyGLyGrSxBW2nXVgUnU/58quq7vJ6qBZFzlYWfj9ZzssBWsy0NYylpetUJQz3PMYZDAyFwNKxw+hCnNSz265rCbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367618; c=relaxed/simple;
	bh=d/y3BsjqAtTMNOENP4j5MB3jZmFYIRJMndq13i+at3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQPXH+DYm3dcy8nRafjN2zT+QyjOrZmeFf9fXWvJ4lfholfCF/o87N+vgywVBVmjls2Q/WB22Xhe5QxArQBTL06R3Qbf2bYWPRKfv6GuW8nyyNFseeIuj5UrkhP1gYiEfBUMQTec8WAKtArjOxhsVesE1rzQjWzvmOJPdthTPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRcfzt3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRcfzt3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E6EC4CED3;
	Wed,  8 Jan 2025 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736367617;
	bh=d/y3BsjqAtTMNOENP4j5MB3jZmFYIRJMndq13i+at3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRcfzt3tPjRhwaPOO6QYu/TfV1gjXGHat0i3BJxLStZ5cBAiJ2A2BLOPEXEf/Y8t2
	 7eR0LcSNFrm3PFGFjOyhOF322gb1yHITqm/BaHKy7GKl5R4HkdWSuSUkvK1t0TnfUQ
	 R3NbYVUMe+1Lp7riLavh5/JzOrVfm+i5WtqjbGrB2Em5LOkjzFS+Xo+e82FHM+Z7Xm
	 fA5wS7FUktGWp8jf+r4x3Y7jFeuV3/XiDiC22xkk2+9TMrJqcu+iRh72MoFZ8D5KDA
	 FKN1NY3LkyLVEjD5GaCclPsfQIsgu0q0bgXyAfBQhwdX0RM8m2ty1+7x6fpUHbmG6I
	 8IS6D6m9nnzVQ==
Date: Wed, 8 Jan 2025 17:20:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 perf-tools-next] perf top: Don't complain about lack
 of vmlinux when not resolving some kernel samples
Message-ID: <Z37d_pEDFJzw5u5R@x1>
References: <Z3gUl1guIXi4bU0a@x1>
 <Z3xFbYjkPz_u1UeK@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3xFbYjkPz_u1UeK@google.com>

On Mon, Jan 06, 2025 at 01:04:45PM -0800, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Fri, Jan 03, 2025 at 01:47:19PM -0300, Arnaldo Carvalho de Melo wrote:
> > Recently we got a case where a kernel sample wasn't being resolved due
> > to a bug that was not setting the end address on kernel functions
> > implemented in assembly (see Link: tag), and then those were not being
> > found by machine__resolve() -> map__find_symbol().
> > 
> > So we ended up with:
> > 
> >   # perf top --stdio
> >   PerfTop: 0 irqs/s  kernel: 0%  exact: 0% lost: 0/0 drop: 0/0 [cycles/P]
> >   -----------------------------------------------------------------------
> > 
> >   Warning:
> >   A vmlinux file was not found.
> >   Kernel samples will not be resolved.
> >   ^Z
> >   [1]+  Stopped                 perf top --stdio
> >   #
> > 
> > But then resolving all other kernel symbols.
> > 
> > So just fixup the logic to only print that warning when there are no
> > symbols in the kernel map.
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Link: https://lore.kernel.org/lkml/Z3buKhcCsZi3_aGb@x1
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> 
> Looks like an old bug since d88205db9caa0e9d ("perf dso: Add
> dso__has_symbols() method"). :)

Agreed, logic inversion, I'm adding the Fixes tag, thanks for finding
it!

- Arnaldo
