Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB16271A7B;
	Thu, 13 Nov 2025 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065914; cv=none; b=rAptQCXMUfV6qnJF6/V6Iv7M5v12a8fUA1jwJEmuEpQuqDYLPwptWj0b8J/Z2ocJAdG4SCGZlG2o3sGhCutc/0SjbOQEscRY2wOQJLdE4Q1HV/EvjoGj3n3Xdtz00t3DdLhX2gWVWh99bmhnbHFL/X7Q4+vMCqMY4bDdgwkEwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065914; c=relaxed/simple;
	bh=/hb/QO5JgVeDKU8Av/pRPT5YLrlhc9DOzlp9kadV85g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMiG+I0AccxP5+rvIGHC9t+obSmEImUxNTtBjl2LSRUZYcYEVVkxrV8ewtDyOSnE6Y2oV2qXljOzqllRYtiXr8I0DK3s3JXBXUjSbOD9W9NrJflrfn4jtzRQ0Ro1vZfliqVL4V2TlTPM8Eh3nSC0MVs4nsjPIBpHr4+kaGh09hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNvzbuwW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNvzbuwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826CBC4CEF5;
	Thu, 13 Nov 2025 20:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763065914;
	bh=/hb/QO5JgVeDKU8Av/pRPT5YLrlhc9DOzlp9kadV85g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNvzbuwWVvREgk8FJvGh9z0CNZHU8e0qyOchBcxto/8lfDXAL5DbBus+f94wn4kkY
	 fBIjlhnpfAD0pYQ/8UJeq2faz4LTXjGjWVDHmZ76jowLeEk8mbwPC+54vN3/QbLCjq
	 ZN6VIV41PInk+zo841r4BTuC7KPKgEBL6Pr+PrsSXcHH0fhIN+ugGuk/XIrSyEo50g
	 RwlpVnAqXA5TmDL2MO54opTXzssBPEY/jxE4SByLVybo3PUiPehyDCun6+sQsJMZRz
	 en99bsjL17Xmtg8bXAMg+LvMOXqejWKibAVYSKRrrtbYNgjXYDWtXTeqho8ZCc8vsx
	 mLCPtVVYdAZqw==
Date: Thu, 13 Nov 2025 17:31:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Guilherme Amadio <amadio@gentoo.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf libbfd: Ensure libbfd is initialized prior to use
Message-ID: <aRZANk3yLBSb8rq2@x1>
References: <20251112074311.1440101-1-irogers@google.com>
 <CAP-5=fU6xad0EGzQ=gJy6eUJtYrgV2FKSu=JcndeWVTKZE_RrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU6xad0EGzQ=gJy6eUJtYrgV2FKSu=JcndeWVTKZE_RrA@mail.gmail.com>

On Thu, Nov 13, 2025 at 09:03:42AM -0800, Ian Rogers wrote:
> On Tue, Nov 11, 2025 at 11:43 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Multiple threads may be creating and destroying BFD objects in
> > situations like `perf top`. Without appropriate initialization crashes
> > may occur during libbfd's cache management. BFD's locks require
> > recursive mutexes, add support for these.
> >
> > Reported-by: Guilherme Amadio <amadio@gentoo.org>
> > Closes: https://lore.kernel.org/lkml/aQt66zhfxSA80xwt@gentoo.org/
> > Fixes: 95931d9a594d ("perf libbfd: Move libbfd functionality to its own file")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> I'm hoping adding the missing initialization is just obviously
> correct, Guilherme if you could provide a Tested-by it would be great.

Indeed, Guilherme?

I'm now trying to reproduce the problem to then try with the patch,

- Arnaldo
