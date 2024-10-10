Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFF2AD33;
	Thu, 10 Oct 2024 00:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521787; cv=none; b=iLOWrUoYNUGnzhnHyv0CUTr+AqI7T6NaJ8TBvg2iELntlwsUz7sG5kHxwvhe61RzxfY/s2EDsijrq3bPr1DHCBEbLYWm+oQNWcyUtda8uVhXXOEmiOh4lEshHp+0r705/bHp7tnBRaAghHtNutbkXzmLdZSy0EOnoH1JbY7gnog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521787; c=relaxed/simple;
	bh=eIXQdu5G0lTx04A4tDOo6481P4obHE3p359ClK5Pxyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsY0dzy5x0hpjHxRJPTWkcBcAGy4RYgo4a2LzPIErEuQCao0HLv2CmLbIhZV3i4Rg+C73VUVON+gJG1snFZePfF/eXZo9B0pu1/pFdf5eE1ypgDvIyFnV2yM1wyyLDnumIVNJfy4XgZZJN5sa2n0DugneV8b2KRsQSQmPmI0SVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TckMWn+0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TckMWn+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73802C4CEC3;
	Thu, 10 Oct 2024 00:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728521787;
	bh=eIXQdu5G0lTx04A4tDOo6481P4obHE3p359ClK5Pxyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TckMWn+0/MfBHWt+5zIaSgdf52IEhxiCoPl9FYJNxrldZ88LiNQN5rdEEFmDVLdXZ
	 a3JOc9iaVSEDxnuWkTHZUrhz5eA/3ycWo3dVHhF2vSGFcNufbME9KyTSfCAOVpzv7r
	 wSu2e7L4OhKxoA2jHz8f9GwcuYt1sDq/TrFN5vOZrObhpl74uZYmy8dldFa40vyIZ2
	 Rk06k06bANUyer0t8IMVete8iVB99fYb5oXMHg5BM1o9Ap67wFw+nLchVypewlZa3t
	 ZpchJmY9VLAfOgBREL7LnR4VaftCNDIXuGNDNGPR7+TGvJOLiERZnMp7GVLhftSmBe
	 02c6aBsmiuQTw==
Date: Wed, 9 Oct 2024 17:56:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Leo Yan <leo.yan@linux.dev>, Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Make a "Setup struct perf_event_attr" a shell test
Message-ID: <ZwcmOeI2NDQw96mR@google.com>
References: <20241001171950.233723-1-irogers@google.com>
 <CAP-5=fWExR7ae=dgiAG8BCtDN0XDwnzy9=SBbE0cy5S1Luw-4A@mail.gmail.com>
 <ZwYW54gKOfnUboeZ@google.com>
 <CAP-5=fUY8d4DN+ekpj5B58kvoksrPcWpZU=iZhs+=bFfpakK3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUY8d4DN+ekpj5B58kvoksrPcWpZU=iZhs+=bFfpakK3Q@mail.gmail.com>

On Tue, Oct 08, 2024 at 10:59:59PM -0700, Ian Rogers wrote:
> On Tue, Oct 8, 2024 at 10:38 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Oct 08, 2024 at 11:55:29AM -0700, Ian Rogers wrote:
> > > On Tue, Oct 1, 2024 at 10:19 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > The path detection for "Setup struct perf_event_attr" test is brittle
> > > > and leads to the test frequently not running. Running shell tests is
> > > > reasonably robust, so make the test a shell test. Move the test files
> > > > to reflect this.
> > >
> > > Ping.
> > >
> > > I think this is worthwhile cleanup for the attributes test. It should
> > > avoid problems like:
> > > https://lore.kernel.org/lkml/ZroNTkdA8XDFaDks@x1/
> >
> > Sorry, it's not clear to me what was the problem.  Can you please say it
> > again briefly?
> 
> If you build perf like:
> make -C tools/perf O=/tmp/perf
> 
> Then run the built perf test for the "Setup struct perf_event_attr" it
> skips (causing the tests to bitrot and fixes to be sent by Veronika):
> ```
> $ sudo /tmp/perf/perf test -vv perf_event_attr
> capget syscall failed (No such file or directory - 2) fall back on root check
> 17: Setup struct perf_event_attr:
> 17: Setup struct perf_event_attr:
> --- start ---
> test child forked, pid 806601
> Using CPUID GenuineIntel-6-8D-1
> ---- end(-2) ----
> 17: Setup struct perf_event_attr                                    : Skip
> ```
> 
> The issue is around the path set up, the test has a few path
> expectations but they are brittle as shown above. While we could
> endeavour to set up the path in C code, it makes sense to migrate the
> test to a shell test due to the tests smaller size, ease of
> environment variable manipulation, existing perf test support for
> better path setup, etc. Ie let's not reinvent the shell test
> infrastructure that handles python tests for the sake of one C test.
> After this change:
> ```
> $ sudo /tmp/perf/perf test attribute
> 76: Perf attribute expectations test                                : Ok
> ```

Ok, thanks for the explanation!
Namhyung

> 
> > >
> > > > Ian Rogers (3):
> > > >   perf test: Add a shell wrapper for "Setup struct perf_event_attr"
> > > >   perf test: Remove C test wrapper for attr.py
> > > >   perf test: Move attr files into shell directory where they are used
> > > >
> > > >  tools/perf/Makefile.perf                      |   5 +-
> > > >  tools/perf/perf.c                             |   2 -
> > > >  tools/perf/tests/Build                        |   1 -
> > > >  tools/perf/tests/attr.c                       | 218 ------------------
> > > >  tools/perf/tests/builtin-test.c               |   1 -
> > > >  tools/perf/tests/shell/attr.sh                |  22 ++
> > > >  tools/perf/tests/{ => shell}/attr/README      |   0
> > > >  tools/perf/tests/{ => shell}/attr/base-record |   0
> > > >  .../tests/{ => shell}/attr/base-record-spe    |   0
> > > >  tools/perf/tests/{ => shell}/attr/base-stat   |   0
> > > >  .../tests/{ => shell}/attr/system-wide-dummy  |   0
> > > >  .../tests/{ => shell}/attr/test-record-C0     |   0
> > > >  .../tests/{ => shell}/attr/test-record-basic  |   0
> > > >  .../{ => shell}/attr/test-record-branch-any   |   0
> > > >  .../attr/test-record-branch-filter-any        |   0
> > > >  .../attr/test-record-branch-filter-any_call   |   0
> > > >  .../attr/test-record-branch-filter-any_ret    |   0
> > > >  .../attr/test-record-branch-filter-hv         |   0
> > > >  .../attr/test-record-branch-filter-ind_call   |   0
> > > >  .../attr/test-record-branch-filter-k          |   0
> > > >  .../attr/test-record-branch-filter-u          |   0
> > > >  .../tests/{ => shell}/attr/test-record-count  |   0
> > > >  .../tests/{ => shell}/attr/test-record-data   |   0
> > > >  .../{ => shell}/attr/test-record-dummy-C0     |   0
> > > >  .../tests/{ => shell}/attr/test-record-freq   |   0
> > > >  .../attr/test-record-graph-default            |   0
> > > >  .../attr/test-record-graph-default-aarch64    |   0
> > > >  .../{ => shell}/attr/test-record-graph-dwarf  |   0
> > > >  .../{ => shell}/attr/test-record-graph-fp     |   0
> > > >  .../attr/test-record-graph-fp-aarch64         |   0
> > > >  .../attr/test-record-group-sampling           |   0
> > > >  .../tests/{ => shell}/attr/test-record-group1 |   0
> > > >  .../tests/{ => shell}/attr/test-record-group2 |   0
> > > >  .../{ => shell}/attr/test-record-no-buffering |   0
> > > >  .../{ => shell}/attr/test-record-no-inherit   |   0
> > > >  .../{ => shell}/attr/test-record-no-samples   |   0
> > > >  .../tests/{ => shell}/attr/test-record-period |   0
> > > >  .../{ => shell}/attr/test-record-pfm-period   |   0
> > > >  .../tests/{ => shell}/attr/test-record-raw    |   0
> > > >  .../{ => shell}/attr/test-record-spe-period   |   0
> > > >  .../attr/test-record-spe-period-term          |   0
> > > >  .../attr/test-record-spe-physical-address     |   0
> > > >  .../attr/test-record-user-regs-no-sve-aarch64 |   0
> > > >  .../test-record-user-regs-old-sve-aarch64     |   0
> > > >  .../attr/test-record-user-regs-sve-aarch64    |   0
> > > >  .../perf/tests/{ => shell}/attr/test-stat-C0  |   0
> > > >  .../tests/{ => shell}/attr/test-stat-basic    |   0
> > > >  .../tests/{ => shell}/attr/test-stat-default  |   0
> > > >  .../{ => shell}/attr/test-stat-detailed-1     |   0
> > > >  .../{ => shell}/attr/test-stat-detailed-2     |   0
> > > >  .../{ => shell}/attr/test-stat-detailed-3     |   0
> > > >  .../tests/{ => shell}/attr/test-stat-group1   |   0
> > > >  .../{ => shell}/attr/test-stat-no-inherit     |   0
> > > >  tools/perf/tests/{ => shell/lib}/attr.py      |   0
> > > >  tools/perf/tests/tests.h                      |   1 -
> > > >  tools/perf/util/evsel.c                       | 122 +++++++++-
> > > >  tools/perf/util/util.h                        |   7 -
> > > >  57 files changed, 142 insertions(+), 237 deletions(-)
> > > >  delete mode 100644 tools/perf/tests/attr.c
> > > >  create mode 100755 tools/perf/tests/shell/attr.sh
> > > >  rename tools/perf/tests/{ => shell}/attr/README (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/base-record (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/base-record-spe (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/base-stat (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/system-wide-dummy (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-C0 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-basic (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-any (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_call (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_ret (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-hv (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-ind_call (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-k (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-u (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-count (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-data (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-dummy-C0 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-freq (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-default (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-default-aarch64 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-dwarf (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp-aarch64 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-group-sampling (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-group1 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-group2 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-no-buffering (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-no-inherit (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-no-samples (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-period (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-pfm-period (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-raw (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-spe-period (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-spe-period-term (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-spe-physical-address (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-no-sve-aarch64 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-old-sve-aarch64 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-sve-aarch64 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-stat-C0 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-stat-basic (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-stat-default (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-1 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-2 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-3 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-stat-group1 (100%)
> > > >  rename tools/perf/tests/{ => shell}/attr/test-stat-no-inherit (100%)
> > > >  rename tools/perf/tests/{ => shell/lib}/attr.py (100%)
> > > >
> > > > --
> > > > 2.46.1.824.gd892dcdcdd-goog
> > > >
