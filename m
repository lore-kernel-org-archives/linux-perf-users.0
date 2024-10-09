Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C915FD01;
	Wed,  9 Oct 2024 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452330; cv=none; b=JpizkYvrV/3oSXwQksQ6tYCEy9o/F8KMqo7cvvlQPTYBMpVe5a2YpNr0wGvI8I2Vm+lejvovv0LYeo1Xc67/2xRVurFHXW5Q385Rj9G3/ZgAlo5hYz0PDdaKCXmp8yvuD05xeC0fEdap3i0OMZ+1zlSM97DmckGlyhBoJIPNbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452330; c=relaxed/simple;
	bh=AodUmJbjAEyzv85xinf1CRD33stakirAqexHC332BW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqwnNpbspBZa3XG+Cgyfx/sqb/j/pKz3NlfkYygDcKrENsMaBKLulkvj/045VWCr55cIQ+xhrx2cT1FiufKpoqtSMAH//8DuS/UoCDXFomWNlOQmjtgYx+eGYId5oJ287D4Rjo7PAT3kOI3r8nyW9sJzEvN84NXNY4AAyaLb+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuJAVyMh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuJAVyMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A11CC4CEC5;
	Wed,  9 Oct 2024 05:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728452329;
	bh=AodUmJbjAEyzv85xinf1CRD33stakirAqexHC332BW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZuJAVyMhLKziVFJZ07qBbe/keCjj6eJkozA2uJHINXQlGIVCVuYUsBtbJoQI9p30y
	 xrB93ocsRQ0y561Q7KqPWb0XN6hIJHvC2jPrPpBTdzEx1BCmdeUc9usKllVY9BbM/I
	 Tu3Kn/qJeTJiT7X5O1dpql+0NtZatCr0LumrXllt8xXavwestlhpIO1ONw82hK7Mb7
	 LoubJ7qD9mzcOChIwqg1as4MnG6AUr484+a5vBpEKPi3TbRwGpsrZntpExh+Hhe8tM
	 foUNGAfnNge/cXGmra4b003q/5MEQKBIuU6xBgb5JjOuDGSc/49MTklTSaYZxPQcG9
	 pWqsxCRF/eMzw==
Date: Tue, 8 Oct 2024 22:38:47 -0700
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
Message-ID: <ZwYW54gKOfnUboeZ@google.com>
References: <20241001171950.233723-1-irogers@google.com>
 <CAP-5=fWExR7ae=dgiAG8BCtDN0XDwnzy9=SBbE0cy5S1Luw-4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWExR7ae=dgiAG8BCtDN0XDwnzy9=SBbE0cy5S1Luw-4A@mail.gmail.com>

On Tue, Oct 08, 2024 at 11:55:29AM -0700, Ian Rogers wrote:
> On Tue, Oct 1, 2024 at 10:19 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The path detection for "Setup struct perf_event_attr" test is brittle
> > and leads to the test frequently not running. Running shell tests is
> > reasonably robust, so make the test a shell test. Move the test files
> > to reflect this.
> 
> Ping.
> 
> I think this is worthwhile cleanup for the attributes test. It should
> avoid problems like:
> https://lore.kernel.org/lkml/ZroNTkdA8XDFaDks@x1/

Sorry, it's not clear to me what was the problem.  Can you please say it
again briefly?

Thanks,
Namhyung

> 
> > Ian Rogers (3):
> >   perf test: Add a shell wrapper for "Setup struct perf_event_attr"
> >   perf test: Remove C test wrapper for attr.py
> >   perf test: Move attr files into shell directory where they are used
> >
> >  tools/perf/Makefile.perf                      |   5 +-
> >  tools/perf/perf.c                             |   2 -
> >  tools/perf/tests/Build                        |   1 -
> >  tools/perf/tests/attr.c                       | 218 ------------------
> >  tools/perf/tests/builtin-test.c               |   1 -
> >  tools/perf/tests/shell/attr.sh                |  22 ++
> >  tools/perf/tests/{ => shell}/attr/README      |   0
> >  tools/perf/tests/{ => shell}/attr/base-record |   0
> >  .../tests/{ => shell}/attr/base-record-spe    |   0
> >  tools/perf/tests/{ => shell}/attr/base-stat   |   0
> >  .../tests/{ => shell}/attr/system-wide-dummy  |   0
> >  .../tests/{ => shell}/attr/test-record-C0     |   0
> >  .../tests/{ => shell}/attr/test-record-basic  |   0
> >  .../{ => shell}/attr/test-record-branch-any   |   0
> >  .../attr/test-record-branch-filter-any        |   0
> >  .../attr/test-record-branch-filter-any_call   |   0
> >  .../attr/test-record-branch-filter-any_ret    |   0
> >  .../attr/test-record-branch-filter-hv         |   0
> >  .../attr/test-record-branch-filter-ind_call   |   0
> >  .../attr/test-record-branch-filter-k          |   0
> >  .../attr/test-record-branch-filter-u          |   0
> >  .../tests/{ => shell}/attr/test-record-count  |   0
> >  .../tests/{ => shell}/attr/test-record-data   |   0
> >  .../{ => shell}/attr/test-record-dummy-C0     |   0
> >  .../tests/{ => shell}/attr/test-record-freq   |   0
> >  .../attr/test-record-graph-default            |   0
> >  .../attr/test-record-graph-default-aarch64    |   0
> >  .../{ => shell}/attr/test-record-graph-dwarf  |   0
> >  .../{ => shell}/attr/test-record-graph-fp     |   0
> >  .../attr/test-record-graph-fp-aarch64         |   0
> >  .../attr/test-record-group-sampling           |   0
> >  .../tests/{ => shell}/attr/test-record-group1 |   0
> >  .../tests/{ => shell}/attr/test-record-group2 |   0
> >  .../{ => shell}/attr/test-record-no-buffering |   0
> >  .../{ => shell}/attr/test-record-no-inherit   |   0
> >  .../{ => shell}/attr/test-record-no-samples   |   0
> >  .../tests/{ => shell}/attr/test-record-period |   0
> >  .../{ => shell}/attr/test-record-pfm-period   |   0
> >  .../tests/{ => shell}/attr/test-record-raw    |   0
> >  .../{ => shell}/attr/test-record-spe-period   |   0
> >  .../attr/test-record-spe-period-term          |   0
> >  .../attr/test-record-spe-physical-address     |   0
> >  .../attr/test-record-user-regs-no-sve-aarch64 |   0
> >  .../test-record-user-regs-old-sve-aarch64     |   0
> >  .../attr/test-record-user-regs-sve-aarch64    |   0
> >  .../perf/tests/{ => shell}/attr/test-stat-C0  |   0
> >  .../tests/{ => shell}/attr/test-stat-basic    |   0
> >  .../tests/{ => shell}/attr/test-stat-default  |   0
> >  .../{ => shell}/attr/test-stat-detailed-1     |   0
> >  .../{ => shell}/attr/test-stat-detailed-2     |   0
> >  .../{ => shell}/attr/test-stat-detailed-3     |   0
> >  .../tests/{ => shell}/attr/test-stat-group1   |   0
> >  .../{ => shell}/attr/test-stat-no-inherit     |   0
> >  tools/perf/tests/{ => shell/lib}/attr.py      |   0
> >  tools/perf/tests/tests.h                      |   1 -
> >  tools/perf/util/evsel.c                       | 122 +++++++++-
> >  tools/perf/util/util.h                        |   7 -
> >  57 files changed, 142 insertions(+), 237 deletions(-)
> >  delete mode 100644 tools/perf/tests/attr.c
> >  create mode 100755 tools/perf/tests/shell/attr.sh
> >  rename tools/perf/tests/{ => shell}/attr/README (100%)
> >  rename tools/perf/tests/{ => shell}/attr/base-record (100%)
> >  rename tools/perf/tests/{ => shell}/attr/base-record-spe (100%)
> >  rename tools/perf/tests/{ => shell}/attr/base-stat (100%)
> >  rename tools/perf/tests/{ => shell}/attr/system-wide-dummy (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-C0 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-basic (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-any (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_call (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_ret (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-hv (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-ind_call (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-k (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-u (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-count (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-data (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-dummy-C0 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-freq (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-default (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-default-aarch64 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-dwarf (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp-aarch64 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-group-sampling (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-group1 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-group2 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-no-buffering (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-no-inherit (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-no-samples (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-period (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-pfm-period (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-raw (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-spe-period (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-spe-period-term (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-spe-physical-address (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-no-sve-aarch64 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-old-sve-aarch64 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-sve-aarch64 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-stat-C0 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-stat-basic (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-stat-default (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-1 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-2 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-3 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-stat-group1 (100%)
> >  rename tools/perf/tests/{ => shell}/attr/test-stat-no-inherit (100%)
> >  rename tools/perf/tests/{ => shell/lib}/attr.py (100%)
> >
> > --
> > 2.46.1.824.gd892dcdcdd-goog
> >
