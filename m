Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109411F9AB1;
	Wed, 27 Nov 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725301; cv=none; b=uQYYr+Wr9BD2ALOs7y7T1zUwzATgJC2++8l87c6h0twQKbwBt3RADCv2kGy+tsYUZ9VgAOyOTzSZYyFnuyf4W6b3MluphjyH6nd6lo8qihfztGI1xpuogJR0ABs7aVVdggltcxYXL2+v5fzY8potoVYx3DvnAQKRuEOGSERgSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725301; c=relaxed/simple;
	bh=hz772gxy7L0ksRCjSvbYXOfm/jK6yfavLZkXUFN0xjA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXpPtFm7/lUOr+XL403RVobhd/jrCFeGQsaf+p8UzNzFWh+8Bk6VM69935pA1ii8SeCPqn847WcWBOtqPbWLQA7OJEWmjshzGEOaM68dY6O3cA/YxgW7gM534tO9yFmx09AILoTFhZLiMLobqurA/O66Fz4PktKyx/HKNHDLM5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xz4j723Dwz6D8gt;
	Thu, 28 Nov 2024 00:32:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F6851400D8;
	Thu, 28 Nov 2024 00:34:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 27 Nov
 2024 17:34:47 +0100
Date: Wed, 27 Nov 2024 16:34:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>
CC: <tongtiangen@huawei.com>, Yicong Yang <yangyicong@huawei.com>, "Niyas
 Sait" <niyas.sait@huawei.com>, <ajayjoshi@micron.com>, Vandana Salve
	<vsalve@micron.com>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Gregory Price
	<gourry@gourry.net>, Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC PATCH 0/4] CXL Hotness Monitoring Unit perf driver
Message-ID: <20241127163426.00004a65@huawei.com>
In-Reply-To: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 21 Nov 2024 10:18:41 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> The CXL specification release 3.2 is now available under a click through at
> https://computeexpresslink.org/cxl-specification/ and it brings new
> shiny toys.

If anyone wants to play, basic emulation on my CXL QEMU staging tree
https://gitlab.com/jic23/qemu/-/commit/e89b35d264c1bcc04807e7afab1254f35ffc8cb9

Branch with a few other things on top is:
https://gitlab.com/jic23/qemu/-/commits/cxl-2024-11-27

Note that this currently doesn't produce real data.  I have a plan
/ initial PoC / hack to hook that up via an addition to the QEMU cache
plugin and an external tool to emulate the hotness tracker counting
hardware. Will be a little while before I get that finished, so in
a meantime the above exercises the driver.

Jonathan
 
> 
> RFC reason
> - Whilst trace capture with a particular configuration is potentially useful
>   the intent is that CXL HMU units will be used to drive various forms of
>   hotpage migration for memory tiering setups. This driver doesn't do this
>   (yet), but rather provides data capture etc for experimentation and
>   for working out how to mostly put the allocations in the right place to
>   start with by tuning applications.
> 
> CXL r3.2 introduces a CXL Hotness Monitoring Unit definition. The intent
> of this is to provide a way to establish which units of memory (typically
> pages or larger) in CXL attached memory are hot. The implementation details
> and algorithm are all implementation defined. The specification simply
> describes the 'interface' which takes the form of ring buffer of hotness
> records in a PCI BAR and defined capability, configuration and status
> registers.
> 
> The hardware may have constraints on what it can track, granularity etc
> and on how accurately it tracks (e.g. counter exhaustion, inaccurate
> trackers). Some of these constraints are discoverable from the hardware
> registers, others such as loss of accuracy have no universally accepted
> measures as they are typically access pattern dependent. Sadly it is
> very unlikely any hardware will implement a truly precise tracker given
> the large resource requirements for tracking at a useful granularity.
> 
> There are two fundamental operation modes:
> 
> * Epoch based. Counters are checked after a period of time (Epoch) and
>   if over a threshold added to the hotlist.
> * Always on. Counters run until a threshold is reached, after that the
>   hot unit is added to the hotlist and the counter released.
> 
> Counting can be filtered on:
> 
> * Region of CXL DPA space (256MiB per bit in a bitmap).
> * Type of access - Trusted and non trusted or non trusted only, R/W/RW
> 
> Sampling can be modified by:
> 
> * Downsampling including potentially randomized downsampling.
> 
> The driver presented here is intended to be useful in its own right but
> also to act as the first step of a possible path towards hotness monitoring
> based hot page migration. Those steps might look like.
> 
> 1. Gather data - drivers provide telemetry like solutions to get that
>    data. May be enhanced, for example in this driver by providing the
>    HPA address rather than DPA Unit Address. Userspace can access enough
>    information to do this so maybe not.
> 2. Userspace algorithm development, possibly combined with userspace
>    triggered migration by PA. Working out how to use different levels
>    of constrained hardware resources will be challenging.
> 3. Move those algorithms in kernel. Will require generalization across
>    different hotpage trackers etc.
> 
> So far this driver just gives access to the raw data. I will probably kick
> of a longer discussion on how to do adaptive sampling needed to actually
> use these units for tiering etc, sometime soon (if no one one else beats
> me too it).  There is a follow up topic of how to virtualize this stuff
> for memory stranding cases (VM gets a fixed mixture of fast and slow
> memory and should do it's own tiering).
> 
> More details in the Documentation patch but typical commands are:
> 
> $perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,\
>  hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,\
>  range_size=1024,randomized_downsampling=0,downsampling_factor=32,\
>  hotness_granual=12
> 
> $perf report --dump-raw-traces
> 
> Example output.  With a counter_width of 16 (0x10) the least significant
> 4 bytes are the counter value and the unit index is bits 16-63.
> Here all units are over the threshold and the indexes are 0,1,2 etc.
> 
> . ... CXL_HMU data: size 33512 bytes
> Header 0: units: 29c counter_width 10
> Header 1 : deadbeef
> 0000000000000283
> 0000000000010364
> 0000000000020366
> 000000000003033c
> 0000000000040343
> 00000000000502ff
> 000000000006030d
> 000000000007031a
> 
> Which will produce a list of hotness entries.
> Bits[N-1:0] counter value
> Bits[63:N] Unit ID (combine with unit size and DPA base + HDM decoder
>   config to get to a Host Physical Address)
> 
> Specific RFC questions.
> - What should be in the header added to the aux buffer.
>   Currently just the minimum is provided. Number of records
>   and the counter width needed to decode them.
> - Should we reset the counters when doing sampling "-F X"
>   If the frequency is higher than the epoch we never see any hot units.
>   If so, when should we reset them?
> 
> Note testing has been light and on emulation only + as perf tool is
> a pain to build on a striped back VM,  build testing has all be on
> arm64 so far.  The driver loads though on both arm64 and x86 so
> any problems are likely in the perf tool arch specific code
> which is build tested (on wrong machine)
> 
> The QEMU emulation needs some cleanup, but I should be able to post
> that shortly to let people actually play with this.  There are lots
> of open questions there on how 'right' we want the emulation to be
> and what counting uarch to emulate.
> 
> Jonathan Cameron (4):
>   cxl: Register devices for CXL Hotness Monitoring Units (CHMU)
>   cxl: Hotness Monitoring Unit via a Perf AUX Buffer.
>   perf: Add support for CXL Hotness Monitoring Units (CHMU)
>   hwtrace: Document CXL Hotness Monitoring Unit driver
> 
>  Documentation/trace/cxl-hmu.rst     | 197 +++++++
>  Documentation/trace/index.rst       |   1 +
>  drivers/cxl/Kconfig                 |   6 +
>  drivers/cxl/Makefile                |   3 +
>  drivers/cxl/core/Makefile           |   1 +
>  drivers/cxl/core/core.h             |   1 +
>  drivers/cxl/core/hmu.c              |  64 ++
>  drivers/cxl/core/port.c             |   2 +
>  drivers/cxl/core/regs.c             |  14 +
>  drivers/cxl/cxl.h                   |   5 +
>  drivers/cxl/cxlpci.h                |   1 +
>  drivers/cxl/hmu.c                   | 880 ++++++++++++++++++++++++++++
>  drivers/cxl/hmu.h                   |  23 +
>  drivers/cxl/pci.c                   |  26 +-
>  tools/perf/arch/arm/util/auxtrace.c |  58 ++
>  tools/perf/arch/x86/util/auxtrace.c |  76 +++
>  tools/perf/util/Build               |   1 +
>  tools/perf/util/auxtrace.c          |   4 +
>  tools/perf/util/auxtrace.h          |   1 +
>  tools/perf/util/cxl-hmu.c           | 367 ++++++++++++
>  tools/perf/util/cxl-hmu.h           |  18 +
>  21 files changed, 1748 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/trace/cxl-hmu.rst
>  create mode 100644 drivers/cxl/core/hmu.c
>  create mode 100644 drivers/cxl/hmu.c
>  create mode 100644 drivers/cxl/hmu.h
>  create mode 100644 tools/perf/util/cxl-hmu.c
>  create mode 100644 tools/perf/util/cxl-hmu.h
> 

