Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBBF60EE7
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frL0nD/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A474C433C8;
	Wed, 29 Nov 2023 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701289843;
	bh=kDVqqhvS7fMT+IWmCg5HfszY7e3uXpelsi48BU7S+Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frL0nD/GBuZLBlqS9AaNxXlTopyV8umDgZWa4jDEWA46BH7Q++/5ueTIpJzU6XZDV
	 vRMPCFXPA9li0858dY4Bta3UtlgJpANTseqlwjLG52exFFE3KyAk9CUS0I8kq3D7Mo
	 1ixyF+sT+dXVwzCvjABZdcYiwTkrBp4oHnYg+M/EDsEu4XJyWP2uvvwoKBDbVP1Bvv
	 KVu8IQYgBMM0TRh0TdrfFSqLUsftMcNp0Y/UDYAbGOl0YXUo1Mizb3/EMq3eD6zAZ2
	 qH8iX5u/zeDA8YBc8kGAq3Y0PNNgglDNpZfo56hdw2fnM8pGfTELN1UCm4W1utKt3t
	 H/5SWbOEZTV7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 85D8A40094; Wed, 29 Nov 2023 17:30:40 -0300 (-03)
Date: Wed, 29 Nov 2023 17:30:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Add basic list test
Message-ID: <ZWefcAoHBe+GpuiY@kernel.org>
References: <20231129081004.1918096-1-irogers@google.com>
 <20231129081004.1918096-2-irogers@google.com>
 <a54d0a93-aacd-4c69-a34c-8628b0e18ee7@intel.com>
 <03b314c6-ed6d-ae17-5bc5-0170139f7feb@arm.com>
 <CAP-5=fX7UQGCXp3rqk8bKdevPUH6bnP2hxZ_jktj17YDzkuUDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX7UQGCXp3rqk8bKdevPUH6bnP2hxZ_jktj17YDzkuUDA@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 29, 2023 at 09:21:12AM -0800, Ian Rogers escreveu:
> On Wed, Nov 29, 2023 at 1:27 AM James Clark <james.clark@arm.com> wrote:
> >
> >
> >
> > On 29/11/2023 09:00, Adrian Hunter wrote:
> > > On 29/11/23 10:10, Ian Rogers wrote:
> > >> Test that json output produces valid json.
> > >>
> > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > >> ---
> > >>  tools/perf/tests/shell/list.sh | 29 +++++++++++++++++++++++++++++
> > >>  1 file changed, 29 insertions(+)
> > >>  create mode 100755 tools/perf/tests/shell/list.sh
> > >>
> > >> diff --git a/tools/perf/tests/shell/list.sh b/tools/perf/tests/shell/list.sh
> > >> new file mode 100755
> > >> index 000000000000..286879a9837a
> > >> --- /dev/null
> > >> +++ b/tools/perf/tests/shell/list.sh
> > >> @@ -0,0 +1,29 @@
> > >> +#!/bin/sh
> > >> +# perf list tests
> > >> +# SPDX-License-Identifier: GPL-2.0
> > >> +
> > >> +set -e
> > >> +err=0
> > >> +
> > >> +if [ "x$PYTHON" == "x" ]
> > >> +then
> > >> +    if which python3 > /dev/null
> > >
> > > 'which' isn't always present.  Maybe
> > >
> > > python3 --version >/dev/null 2>&1 && PYTHON=python3
> > >
> >
> > Now that we have shellcheck integrated into the build, we could enable
> > the POSIX mode test which would warn against this usage of which and
> > suggest the alternative.
> >
> > At the moment though there are several other usages of which already in
> > the tests. And probably enabling POSIX mode would come with hundreds of
> > other warnings to fix.
> >
> > I'm not saying we shouldn't change this instance though, just adding the
> > info for the discussion.
> 
> Sounds good to me. Fwiw, the instance where I lifted this code was:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat+json_output.sh?h=perf-tools-next#n12
> 
> With this change:
> ```
> diff --git a/tools/perf/tests/Makefile.tests b/tools/perf/tests/Makefile.tests
> index fdaca5f7a946..06de6d3f4842 100644
> --- a/tools/perf/tests/Makefile.tests
> +++ b/tools/perf/tests/Makefile.tests
> @@ -1,7 +1,7 @@
> # SPDX-License-Identifier: GPL-2.0
> # Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 2023
> 
> -PROGS := $(shell find tests/shell -perm -o=x -type f -name '*.sh')
> +PROGS := $(shell find tests/shell -executable -type f -name '*.sh')
> FILE_NAME := $(notdir $(PROGS))
> FILE_NAME := $(FILE_NAME:%=.%)
> LOGS := $(join $(dir $(PROGS)),$(FILE_NAME))
> ```
> 
> shellcheck now runs for me. I'll try adding the posix check into the
> patch series, as well as fixing other instances I can see.

So I'll wait for a v2 for this one, ok?

- Arnaldo
