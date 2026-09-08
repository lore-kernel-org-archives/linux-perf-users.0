Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A899377ECA;
	Tue,  8 Sep 2026 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898600; cv=none; b=Rsa6CFPdrS6rFcVGsn/sC9pzTXUDLRg1ahOH1yJWDBARNvV78ZhjU5rGKL34lgRjMON6AOlvy2eO24EAXgTS/I9pexJwrk+dTQSnEpk+i73czke1LtAO/liL2qRDrpsbZ/nO/HnYxLmZtQohzZIpD4jF4Qk4+NQziZumicVEcmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898600; c=relaxed/simple;
	bh=9vlE6KlpC3Z0SQFdIk6Id3tofnUcj0iZLIsEN2WUprw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaKCXXMeJ+kwLSHkT2VDDvy4TQ6KL/QIl92Fu4EbKl/KHpC1ofMoktu/dEQqln6Cfd8pPNtYfbD+7FGUeWyjT0tHo3SMFIO7kKQuTJdLfJeJyv5XHCX7P+9vY3fSJk5xJlPNg7mYgstr8tGkM5IoEKsp1fq6SwTH67to5vWWQow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGidzXyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGidzXyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3018A1F00A3A;
	Tue,  8 Sep 2026 20:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788898598;
	bh=sIXU4mbZccn8xifzUlrPYOIRAZscFD5wQKcQwFU/nc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LGidzXykCQDoaV0Kgsn5eIAfRB3m8xdCO5NUqYIgxes0+v9mIugQ2DgBoaqSHB9tq
	 +GBPKkGfmXMKgizFCQNRpu+epBuSp6Cvn7IqHCiORy3k2nJjj5pxS+IMvVGDkMVRao
	 MVkMYCg1CTvz5OYczq9TWTLAky/iwDU/Ws/w34R4yxQ0ZK/t1dgkaXubBIVXLjIxXd
	 Tk0ysRL8d/Xpnn5ZGJ8n2SmBF7W2ktHBnF9qY+4cl7hQRo6tx7P8KgNN+i5DotM0hc
	 +yFTrGi06tW4+PnysltjPpoOUcTjVTIWzFg2tnxdZ5uMkdF2EmAXrvLidsc5c9jcdp
	 PbK3BwNgVAmRw==
Date: Tue, 8 Sep 2026 17:16:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Tianyou Li <tianyou.li@intel.com>,
	Jiebin Sun <jiebin.sun@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/6] perf tool: Build dependency tidy up
Message-ID: <aqBtI0Asky_eJSD2@x2>
References: <20260902154858.2078885-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902154858.2078885-1-irogers@google.com>

On Wed, Sep 02, 2026 at 08:48:52AM -0700, Ian Rogers wrote:
> In doing some work on bazel building of perf (bazel being stricter on
> how header files are used), rather than just making the bazel BUILD
> files more generous in how they accept header file issues like
> transitive dependencies it felt cleaner to address them. These patches
> tackle the most severe issues such as cache.h pulling in UI code,
> hist.h bringing in UI code, unused header files, transitive
> dependencies, etc.
> 
> While cleaning up the dependencies in perf.c, change how missing
> commands are handled to give a more meaningful error message at run
> time about missing build time dependencies.
> 
> v1 and v2 were previously sent just addressing the cache.h issue:
> https://lore.kernel.org/linux-perf-users/20260828222045.1314766-1-irogers@google.com/

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
