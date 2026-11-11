Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378354;
	b=B66bCWFOvzATsscu1JeG6xLQKfDdwZc1fvOvAAiLUgIaQgyUFJdLABmSjEJrNATjyWnP
	 IuDWxBaHtoy4DPH7jddUOt7qNcq1L/IM6votWujtzOnRUB7QTc1OpZXTfAvk0Dng82vAk
	 PL8wCFIM00YHlyvB5k8L4iSfK30yIsCr0n9UyapGaYQnOevpDM0mn4o/x3fNDYI7QhrNG
	 rftgmWCJV1qVSOyY1n9S95wP7VKcP1ZYvTuO+xeCsBoAVk+4SUylLhGLNFWgBa2JkHGWc
	 mzs801wwGFibqi78QwxY0Ns116M8kCUUaTixl6VgyNQ8RXQ+6+ce2wvgJ1o7bNRPMMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378354;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cZQmf3rKYa62Ru0ytEh6HRhQWVPRFmnqQycLLmAQQW0=;
	b=w+AZLpvQR9lFvv9AqAVGiDXlhFUo07buDhOysoh0ZzDVgFszaAiTRKsBFxOivyiX8N6N
	 txxdXFb+FfAYfJT63zt8bx2u9D8B2tAdssfDGFHl/vZ7Yuce/jO4+SyP1j9g81W50EWqE
	 G//ar89cPr0ke2bCA0zLfhatmVDOWTL5iBl6eFxO6FtDHCnM5UVfkY8SYpk/QUr4wB6eg
	 FBiTefaqVbxv+H0OyRWOFUiSgdv4QEUpb+yDDAmYZMGkezzmmqWH/8TlPTVJv7bmedFFs
	 JfE0UbQJ5ta2rQptt42nEV8dK6RznPmpjAG086IRG58dVO9uH2wCzK908KwseO5Wbxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTSkVDt2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1BC606A31C;
	Wed, 11 Nov 2026 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTSkVDt2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133071F00A05;
	Wed, 11 Nov 2026 06:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794378353;
	bh=cZQmf3rKYa62Ru0ytEh6HRhQWVPRFmnqQycLLmAQQW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dTSkVDt2MZgKxE5gNAHSsZYqTggsReO4ZtPqt4qVNEl62VwzSW9akXRGFYoLBIedn
	 P69/MlL1Muc1EUXsVRho86vy/qTb7WrButfiFzlEvm7LyhT6oeX0Kv9imRHp2qxzhB
	 rx921EHIKeJ1T4TDF88DoOz/UcCEzpstO+NT4wY5Occqm3qm0eomBk/mAjOZay8r6a
	 bqqlXMYwnWpOQOiLzz2KiVvV2RsMpYA4G/oXv3c47kDm7DTDm9C3OFYEvTfNmFsVf9
	 zOWu2U8tOff90jrjNXLx2/kog4PCwurFUOAiHXxddjlQABZa1HaGsi47eI8+4rFbN/
	 +O4uv2B63dg3A==
Date: Tue, 10 Nov 2026 22:25:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Magnus Lindholm <linmag7@gmail.com>, Ian Rogers <irogers@google.com>
Cc: Matt Turner <mattst88@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 0/3] perf alpha: Decode ProfileMe samples
Message-ID: <avQKb-vBxTvMn1yF@z2>
References: <20261104-perf-alpha-profileme-v4-0-1771ea02950e@gmail.com>
 <CA+=Fv5RBKVAdGgq=BGPmLXpczcB3qvQcSw8aat7nB2ePXcG4yg@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+=Fv5RBKVAdGgq=BGPmLXpczcB3qvQcSw8aat7nB2ePXcG4yg@mail.gmail.com>

Hello,

On Tue, Nov 10, 2026 at 08:31:02PM +0100, Magnus Lindholm wrote:
> Hi all,
> 
> On Wed, Nov 4, 2026 at 7:53 PM Matt Turner <mattst88@gmail.com> wrote:
> >
> > The Alpha kernel series "alpha/perf: add ProfileMe sampling" adds
> > ProfileMe sampling to the Alpha cpu PMU. Each ProfileMe sample carries
> > the profiled instruction's PMPC and its I_STAT and PCTR_CTL status as
> > PERF_SAMPLE_RAW data, which says whether the instruction retired,
> > whether it trapped and why, whether it was a mispredicted branch,
> > stalled before map, or was killed on a wrong path, and what PCTR1
> > counted while it was in flight:
> >
> >   https://lore.kernel.org/r/20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com
> >
> > This series is the perf tool side. Patch 1 decodes the raw data in perf
> > report -D and perf script -D, as is done for AMD IBS. It copies the new
> > uapi header from the kernel series into tools/arch, so it should wait
> > until that header is merged. Patch 2 adds a script that sums the status
> > by symbol or by instruction, in the style of DCPI. Patch 3 gives perf
> > mem a ProfileMe event, as the kernel series reports the DTB hits and
> > misses of loads and stores in the data source.
> >
> > To try it, with the kernel series applied:
> >
> >   perf record -R -e cpu/instructions,profileme/ -- ./workload
> >   tools/perf/python/alpha-profileme.py --pc
> >
> > I tested this on an AlphaServer ES47 (EV7). Sampling a loop whose
> > branch tests random data reports that branch mispredicted in 21% of its
> > samples, and 0% with sorted data. As a normal user, perf mem record on
> > a loop that loads one word from each page reports the load's DTB hits
> > and misses.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> > Changes in v4:
> > - Patches 1 and 2: ignore TRP, and MIS and the trap type with it, for
> >   an instruction killed before it was mapped, as the kernel series
> >   does. Thanks to Ian Rogers.
> > - Patch 2: record cpu/instructions,profileme/ in the example, as a
> >   precise event now samples only retired instructions, which leaves
> >   the killed% and invalid% columns at 0. Thanks to Ian Rogers.
> > - New patch 3: add a perf mem event for Alpha, cpu/cycles,profileme/.
> >   Suggested by Ian Rogers.
> > - Link to v3: https://patch.msgid.link/20261102-perf-alpha-profileme-v3-0-4bf6e1dda733@gmail.com
> >
> > Changes in v3:
> > - Patch 1: silence -Wpacked around the uapi header, which breaks the
> >   build where __u64 is 4-byte aligned, such as sh4.
> > - Patch 2: only read raw data from cpu PMU events, as a tracepoint's
> >   payload can pass for ProfileMe status. Thanks to Magnus Lindholm.
> > - Patch 2: print a table for each thing PCTR1 can count, so that mixing
> >   events no longer averages unrelated values. Thanks to Magnus Lindholm.
> > - Link to v2: https://patch.msgid.link/20261030-perf-alpha-profileme-v2-0-9ce2f0b0e622@gmail.com
> >
> > Changes in v2:
> > - Patch 1: copy the raw data out of the sample and convert it from
> >   little endian, so that it decodes on strict-alignment and big-endian
> >   hosts.
> > - Patches 1 and 2: follow the new 28-byte struct alpha_profileme_sample
> >   from kernel v2.
> > - Link to v1: https://patch.msgid.link/20261028-perf-alpha-profileme-v1-0-f46c1938d001@gmail.com
> >
> > ---
> > Matt Turner (3):
> >       perf alpha: Decode ProfileMe raw samples
> >       perf python: Add alpha-profileme.py
> >       perf alpha: Add perf mem support
> >
> >  tools/arch/alpha/include/uapi/asm/perf_event.h |  31 +++++
> >  tools/perf/Documentation/perf-mem.txt          |   3 +
> >  tools/perf/arch/alpha/Build                    |   2 +-
> >  tools/perf/arch/alpha/util/Build               |   2 +
> >  tools/perf/arch/alpha/util/mem-events.c        |  17 +++
> >  tools/perf/arch/alpha/util/mem-events.h        |   7 +
> >  tools/perf/arch/alpha/util/pmu.c               |  11 ++
> >  tools/perf/check-headers.sh                    |   1 +
> >  tools/perf/python/alpha-profileme.py           | 178 +++++++++++++++++++++++++
> >  tools/perf/util/Build                          |   1 +
> >  tools/perf/util/alpha-sample-raw.c             | 156 ++++++++++++++++++++++
> >  tools/perf/util/sample-raw.c                   |   2 +
> >  tools/perf/util/sample-raw.h                   |   2 +
> >  13 files changed, 412 insertions(+), 1 deletion(-)
> > ---
> > base-commit: 4626d370ae89b8af4d46a45372b269f926ec662d
> > change-id: 20261028-perf-alpha-profileme-8010299be323
> >
> > Best regards,
> > --
> > Matt Turner <mattst88@gmail.com>
> >
> 
> My plan is to take this series through the Alpha tree alongside the
> kernel ProfileMe support. Does that work for the perf maintainers?
> An Acked-by would be appreciated.

Should be ok as it hardly touches the common code.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Ian, does it look ok to you?

Thanks,
Namhyung

