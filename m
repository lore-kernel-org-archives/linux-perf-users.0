Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634626;
	b=QBK6xrmMtq02+DjPlOp9IB7NyouGwaxISU85tb/H6Z+aDKAqKhy+FaH0soaG5mpKdguP
	 J5NRSLsGXHZkHx+gnPSBvE00syBCNk0ZqQQz4Lom1CfYINvEVd0p3sdgxVjod540Fr9Au
	 fc5y4a97ESK+DtiOLsjOdO6/mY//hLrlbbT89flrp50ckD9DLDr7R3m9qXC+2mFnm3CBZ
	 xCMTn4b6CsBirycxCVwARKMAsRI5J0PYTAJ+kJKYHbTT/cxUp/sqgLgCCZ3jdEHCj1LJp
	 MHmf/TJH3t8MgKJcihf/bHfr0VNbs5BUIUlZ8rZLsjKYnDN/rr9iiBquXwOQulRZlvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634626;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sEtj+eS2/dUQTYhD2EVQry2utSvTjCQEZTPYKN95msI=;
	b=cuDc0KzeuB+aL10tNXSH2kV2PuFLUJ5gVSOe9WN5diP6EhQw2yASF1Apn9Pm4h+Z7ZiU
	 9OoziVjGCSu9HTmXW6YkzqkK8r/eYlQxWoimUmNblRL0mwxut3MfnWyshUG64xEa22uUk
	 +mqB63gp32/FsiS8QLhsAW3ajKg14dlH9/jSYHcMaHnGJImq0HIYRbj8UivAUmWGv3zkM
	 mWU/VenUGGN4MKeBqwcU63AeJnmD29IpWmL/qtx3GjGacfA+nOF2GSBQ6vCaOmuSAaJ9+
	 LRkcaXNdtFud8ZLSPrOPRvLi5nteqHMbWjZovAMgtgFK39bZeSGufEcHrqrTsa6CqDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aM+IK10N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64632606A32A;
	Wed, 25 Nov 2026 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aM+IK10N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4351F000E0;
	Wed, 25 Nov 2026 19:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634626;
	bh=sEtj+eS2/dUQTYhD2EVQry2utSvTjCQEZTPYKN95msI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aM+IK10N8nWbIisPPLsZI/fIhSwmNJGRQq4uZTSWRKfq4rBeIldG4krMhZly5iSHR
	 VCBo7/N3LCvPaE6904G0rRL+RTr8n5CClnoFPhMAV4fIvFHvLAa3UNiJPqkQi92RcV
	 ESYEBo+27uj2Nma2Arw5OuuvWAnfoGVZG1nPKfa6/u0v628e6gP1Z31zBDvjH07WAq
	 xLydK3s14PRkVa7+gsQyz0hBqu9k5TupQ3Ump2q+XsHsrQmdsyzICRnJc4yZZu1X9e
	 pRe5hD2UTpumKU/9IMwrCTYDBjtjivxs2TzQINaXksTYZhkWzfYQPB8DBGmrSXK89B
	 iWgrcfQ1W3ryQ==
Date: Wed, 25 Nov 2026 11:23:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Replace the deprecated FileType with a helper
Message-ID: <awc1wOQYO14k1R6j@google.com>
References: <20261125173315.2359128-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125173315.2359128-1-takano32@gmail.com>


On Wed, Nov 25, 2026 at 05:33:15PM +0000, TAKANO Mitsuhiro wrote:
> pylint-tests and pylint-pmu-events hang off `all`, so with a pylint that
> reports W4904 the build fails on a tree nobody has changed.  Measured on
> 7.4-rc4 with Python 3.14.9 and pylint 4.0.5, both targets exit 2 and
> pylint reports:
> 
>   - W4904 deprecated-class, argparse.FileType: pmu-events/jevents.py:1494
>     and :1496, tests/shell/lib/perf_json_output_lint.py:23
> 
> FileType is deprecated in the class's own terms - the docstring in 3.14
> reads "Deprecated factory for creating file object types" - so the two
> jevents call sites and the one in the JSON output linter are replaced by
> a helper that opens the file, or hands back stdout or stdin for '-',
> which is what FileType did.  The reader names its encoding, as the rest
> of the Python in perf does.
> 
> Verification: pylint-tests and pylint-pmu-events exit 2 and 2 before this
> change and 0 and 0 after it.  The generated pmu-events tables are byte
> identical either side of the change, checked by running jevents.py for
> arm64 and x86 over the same input tree and comparing pmu-events.c and
> pmu-events-string.c.
> 
> Written with Hermes Agent, an LLM assistant; the author reviewed it and
> ran the build and the generator as described.
> 

I think we have a pending patch already.

https://lore.kernel.org/r/20261115003507.1872482-1-lalitmaganti@gmail.com

Thanks,
Namhyung

