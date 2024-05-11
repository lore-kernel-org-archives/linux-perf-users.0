Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A217F5;
	Sat, 11 May 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715441897; cv=none; b=n05ljSDPKCIm3gCMFVKfnQmM2CUu4AsIU5j83OpUxz2XXi/+GzK/vAqKx+GszKBXsifGgwiRiuQ7TVPbxlk6VcLt8tIHFyaOIL7c42v0BMIZBkePTDE/O2KRfOtpR0TIIRJJrzjaw1jvlkibpWeQl+t1U2FL4fY7b4XvOweQS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715441897; c=relaxed/simple;
	bh=O6CUJ7TOMBM6nLZ7+njB2Nz7V2IHmW5Y3v8WGwbEwHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moPfokdpTecDPIwjVLYDhLGaPAPoy1OEd/cgyoQgMUsWz5KEFYSH7mrVRGH//2EUn19xsPJQMIBeucJdtyBM0iATlTEZhCOnRzh5JKhAWKUHa1cj6eemle0PcNGXq+uS2D1DAt3vP6DF9Wlu+5N5y5HGxNPUIrp76fTfqMYT+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMf6etTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMf6etTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30548C2BBFC;
	Sat, 11 May 2024 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715441896;
	bh=O6CUJ7TOMBM6nLZ7+njB2Nz7V2IHmW5Y3v8WGwbEwHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMf6etTWOYFVHj/iu2S9B9jk1r6hufK4+X4Yan2uD0jc8PAiKhmvxpWQDx/4c7J8X
	 3okgT+AYEdtrZbYNYNS4G1lZtsKaDW+B4JsQ6F0AQA+XrY5DbSCrQVVP+/oMCY5h1D
	 p3QApLz/85FCs+dgkzm4S/0GBaXBMkt99cSaakGiXXhF7EV3nyKzbxB2sDKUoaA0s/
	 gMtdok43NknCwFfArcW0RF61FES/F8enwgw7C4UGGQ+tkj6V/QKRfjqepik/mAKUFH
	 0QS1RMl4634UudGuFhYjyph89WDnUxPvW82hi81DyuL/ttxa/kmtK8LiFNSxyNppE8
	 T4DvQyKblHsLw==
Date: Sat, 11 May 2024 12:38:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Bhaskara Budiredla <bbudiredla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 0/2] perf pmus: Sort/merge/aggregate PMUs like
 mrvl_ddr_pmu
Message-ID: <Zj-Q5W13muoNlqxh@x1>
References: <20240505031624.299361-1-irogers@google.com>
 <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVSAQOXbSfpSLTVkWcZKGx+LqiuC_ZkCxnc0iPtyfrzvQ@mail.gmail.com>

On Fri, May 10, 2024 at 11:13:36AM -0700, Ian Rogers wrote:
> On Sat, May 4, 2024 at 8:16 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The mrvl_ddr_pmu is uncore and has a hexadecimal address
> > suffix. Current PMU sorting/merging code assumes uncore PMU names
> > start with uncore_ and have a decimal suffix. Add support for
> > hexadecimal suffixes and add tests.
> >
> > v3. Rebase and move tests from pmus.c to the existing pmu.c.
> >
> > Ian Rogers (2):
> >   perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
> >   perf tests: Add some pmu core functionality tests
> 
> Hi, these patches have been hanging around since March [1], it would
> be nice to either be landing them or getting feedback on what to fix.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Thanks,
> Ian
> 
> [1] https://lore.kernel.org/lkml/20240329064803.3058900-1-irogers@google.com/
> 
> >  tools/perf/tests/pmu.c | 95 ++++++++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/pmu.c  |  4 +-
> >  tools/perf/util/pmus.c | 53 ++++++++++++-----------
> >  tools/perf/util/pmus.h |  7 +++-
> >  4 files changed, 131 insertions(+), 28 deletions(-)
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
