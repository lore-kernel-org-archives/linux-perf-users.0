Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D458108
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y94UqoRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49119C433C8;
	Tue, 21 Nov 2023 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700586269;
	bh=o2lje6MLDqWiG8m5cmgUnmkPV9kdCM+y2t1aBGDhWPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y94UqoRHkQKyT5snXO0zL0cPLp27Whhzi57swkI35O5TtB6q4bKXBNqhbs5SvmZJB
	 by9FFd97dtah0xc3DfQ0ViQCQYpI9c5xwEjNE4yhdG7071a3XmTSknkdfiYfHgtZyM
	 BdV/Rmo/4vYAbqWfKjOw5BWYc5JRahNpq+FaoiK8gcIm3ff5VgpxQoSVcJ6bHDsRP7
	 uiXgqvpW4VAoqVZXXdVBXxiFz9WRh9apr1KMfD54qNy5y+BKu3Wfcz6SouVYGg2x4f
	 6OfQevim5IEEFt/1Nnus3bCgBsDSpXoGVA9PeGIlCuvMjKXPOZlvr40+DLwBWHxoBU
	 3MuftqI16U5mw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id D280640094; Tue, 21 Nov 2023 14:04:26 -0300 (-03)
Date: Tue, 21 Nov 2023 14:04:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Nick Forrington <nick.forrington@arm.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
Message-ID: <ZVzjGqKv9GxYATli@kernel.org>
References: <20231102162225.50028-1-nick.forrington@arm.com>
 <9e3355e0-f0d6-5f82-d2f6-b7e84bda996c@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3355e0-f0d6-5f82-d2f6-b7e84bda996c@arm.com>
X-Url: http://acmel.wordpress.com

Em Fri, Nov 03, 2023 at 09:14:45AM +0000, James Clark escreveu:
> On 02/11/2023 16:22, Nick Forrington wrote:
> > The current use of atomics can lead to test failures, as tests (such as
> > tests/shell/record.sh) search for samples with "test_loop" as the
> > top-most stack frame, but find frames related to the atomic operation
> > (e.g. __aarch64_ldadd4_relax).

> > This change simply removes the "count" variable, as it is not necessary.

> > Fixes: 1962ab6f6e0b ("perf test workload thloop: Make count increments atomic")
> > Signed-off-by: Nick Forrington <nick.forrington@arm.com>

> > +++ b/tools/perf/tests/workloads/thloop.c
> > @@ -7,7 +7,6 @@
> >   #include "../tests.h"
> >   static volatile sig_atomic_t done;
> > -static volatile unsigned count;
> >   /* We want to check this symbol in perf report */
> >   noinline void test_loop(void);
> > @@ -19,8 +18,7 @@ static void sighandler(int sig __maybe_unused)
> >   noinline void test_loop(void)
> >   {
> > -	while (!done)
> > -		__atomic_fetch_add(&count, 1, __ATOMIC_RELAXED);
> > +	while (!done);
> >   }
> >   static void *thfunc(void *arg)
 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied to perf-tools-next.

- Arnaldo

