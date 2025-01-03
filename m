Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10701C1AB6
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899909; cv=none; b=bkCTgaTPTdtBbUHaabyV/p1wyTyWT0lk8O/ebihvNGv9M6pSUFZ6eIAHf4DJnrEhPnEq//7HCfiWJlOp/DHB8sAZ+hUr6t2fL/rCQUJXdk5mybP78V3S5z6rvaidiLm7OjMzm/b2OLq6UIDYTmRKargGUfDabc2WVxwwnEtWFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899909; c=relaxed/simple;
	bh=XeJPvhW61Fyjs9S2CZBdHXU08fOcsBnzPAKGfb3kawo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=IX3AIhNxnqQhFi8pG4b++3HC5iwzJ/lr9RjALOtA5MYSqXwGnZKmre+IJry8s0W+eGSgx2EeeMr5I27oSAgzbDRvUgZmGxmKxzIqBur/aAGoOko1taxQmUrz+VSW4k5L+eaDSdY4fIQpdfkpvsisJoGZvR1Opz1myuwl/J669Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Kr2jCsAJ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Kr2jCsAJ"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250103102503epoutp0183d388a51d82f4f5ab2b0727306e2250~XJ8PlT-FR0928409284epoutp01Y
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 10:25:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250103102503epoutp0183d388a51d82f4f5ab2b0727306e2250~XJ8PlT-FR0928409284epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1735899903;
	bh=KZQy+3V3dh3yK4CRz79UT9QyYcTXaE5N37wgEcE59oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kr2jCsAJw+3usSYOvaNNUooEQcZ9Ux96DqVIree/Ie1VoMPLSFhs+IUTruqeq6v8W
	 4i+lMiKAM0H+WioI/LGaO+/olhndqtpodpKa4ug0dc4tkrYHtfGO0fFpUbR+E00pvd
	 f8qXuOTCXDrqSPs0bl/k5AcbqUEVzT1iODo4TLEY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250103102502epcas5p225baf33f9f8774c3cdf2a6dee9339906~XJ8OqG2hT0290502905epcas5p2G;
	Fri,  3 Jan 2025 10:25:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YPfpQ4hTDz4x9Py; Fri,  3 Jan
	2025 10:25:02 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250103053521epcas5p30cd4abba59d695664335b03ba806c56d~XF-TTa7Eo3154031540epcas5p3w;
	Fri,  3 Jan 2025 05:35:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250103053521epsmtrp1dbdf5b12a6eaaa01eef937b7f7640f63~XF-TSFjGv1479714797epsmtrp1R;
	Fri,  3 Jan 2025 05:35:21 +0000 (GMT)
X-AuditID: b6c32a29-61df570000004929-c9-677777194342
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4F.D5.18729.91777776; Fri,  3 Jan 2025 14:35:21 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250103053517epsmtip13909dae4635630f8587def191f2bdeb1~XF-PpvaX01591015910epsmtip1Y;
	Fri,  3 Jan 2025 05:35:17 +0000 (GMT)
Date: Fri, 3 Jan 2025 10:57:22 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, tongtiangen@huawei.com, Yicong Yang
	<yangyicong@huawei.com>, Niyas Sait <niyas.sait@huawei.com>,
	ajayjoshi@micron.com, Vandana Salve <vsalve@micron.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Gregory Price <gourry@gourry.net>,
	Huang Ying <ying.huang@intel.com>, Vishak G <vishak.g@samsung.com>, Krishna
	Kanth Reddy <krish.reddy@samsung.com>, Alok Rathore
	<alok.rathore@samsung.com>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 0/4] CXL Hotness Monitoring Unit perf driver
Message-ID: <1296674576.21735899902648.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241127163426.00004a65@huawei.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CLYQDHPe/77t3bmHsV9kR+3OjcophL9/gVl/54z13IOZzrLlPvTbTJ
	Fs2vU7uiFY66rryRXxfbzI8tJb8qG9L8SG3MctWlqBEx4iLSwvHf577f7+d5nj8eCvd/Q4yj
	kpSprEopSxaTAqLCJp4YGpiWJp9lc0xGOS2VJNLfyuKjbMtRHmpuf0Kizw9ukshjlaDCgicA
	3XdnkOi82wSQu+Yahvqaa/mo+lUngYynnpHolPkshuo5O4Ec14+RqMU0wEPO8osEspkfYqjU
	1YChxpqTGMoqfAxQ7cEaDFVXP/AZx/ioquIKjkzn3Biq4/KJxUGMqcQEmNx9Dj6TeecdjynT
	hzBnbnowxmLUkYzFm8dnSupima+Xskmmp+opyRy6YgRMQfFe5pNl4grhOsGCRDY5aTurmhm5
	XrDxdIEepOhXaTp+HOalgxPROcCPgnQ4bMz9hPvYn74B4OVO0e8cwr7+z+A3B0DDz05+DhAM
	bjoArPB+IX0FQU+F+d1Ono9JWgJdDZlDPJqeDd8/zwM+Aacv8GGP9zLmKwLoaFjraB86VUhH
	wPSMt39uToL3zPv+5KNg3dEOwsf44KakrG1wQw3yeHjuJ+WL/WgpzLA6ht4whg6CRaW9+GEw
	ivvP5v6zuX/2SYAbQSCbolbIFWppilTJpoWpZQr1NqU8LGGLwgKGvkOIpBJcNX4IswKMAlYA
	KVw8Wrh2TarcX5go27GTVW2JV21LZtVWMJ4ixCKhqOtgoj8tl6Wym1k2hVX9bTHKb1w6FnWb
	TTifWO6sV80q98REDR/b8HFEwt360NCYnqcd1DfdyOeiqc4Nja6BPq/2e26cu9DZgO7QEDsO
	gqXRnM2+P142nW0JmOeelAl14Sc26YpcRsNy0aPWl/a2eUbNonjUyk27z9vvCf4erBn4kqR5
	rHy58IghbtcC/dVlTc1hxW8iudYpGXkP80s9Bp3Z411dPGHTsAP9F2Jv7+lqurFybWUuXLq7
	u02zrk4i04bYX8wZ2Q2tU7J02TslbbMF4RGpthFxi51VvaLYKH1UTH+ZtPdRZBM2N2Kri1OY
	7N0zquKY+RdXLNmjndAzsKv2NXLLhdVd7SuDArXahdfNBjGh3iiThuAqtewXiHDMWn0DAAA=
X-CMS-MailID: 20250103053521epcas5p30cd4abba59d695664335b03ba806c56d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_d5212_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250103053521epcas5p30cd4abba59d695664335b03ba806c56d
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
	<20241127163426.00004a65@huawei.com>
	<CGME20250103053521epcas5p30cd4abba59d695664335b03ba806c56d@epcas5p3.samsung.com>

------syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_d5212_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 27/11/24 04:34PM, Jonathan Cameron wrote:
>On Thu, 21 Nov 2024 10:18:41 +0000
>Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>
>> The CXL specification release 3.2 is now available under a click through at
>> https://computeexpresslink.org/cxl-specification/ and it brings new
>> shiny toys.
>
>If anyone wants to play, basic emulation on my CXL QEMU staging tree
>https://gitlab.com/jic23/qemu/-/commit/e89b35d264c1bcc04807e7afab1254f35ffc8cb9
>
>Branch with a few other things on top is:
>https://gitlab.com/jic23/qemu/-/commits/cxl-2024-11-27
>
>Note that this currently doesn't produce real data.  I have a plan
>/ initial PoC / hack to hook that up via an addition to the QEMU cache
>plugin and an external tool to emulate the hotness tracker counting
>hardware. Will be a little while before I get that finished, so in
>a meantime the above exercises the driver.
>
>Jonathan
>
>>
>> RFC reason
>> - Whilst trace capture with a particular configuration is potentially useful
>>   the intent is that CXL HMU units will be used to drive various forms of
>>   hotpage migration for memory tiering setups. This driver doesn't do this
>>   (yet), but rather provides data capture etc for experimentation and
>>   for working out how to mostly put the allocations in the right place to
>>   start with by tuning applications.
>>
>> CXL r3.2 introduces a CXL Hotness Monitoring Unit definition. The intent
>> of this is to provide a way to establish which units of memory (typically
>> pages or larger) in CXL attached memory are hot. The implementation details
>> and algorithm are all implementation defined. The specification simply
>> describes the 'interface' which takes the form of ring buffer of hotness
>> records in a PCI BAR and defined capability, configuration and status
>> registers.
>>
>> The hardware may have constraints on what it can track, granularity etc
>> and on how accurately it tracks (e.g. counter exhaustion, inaccurate
>> trackers). Some of these constraints are discoverable from the hardware
>> registers, others such as loss of accuracy have no universally accepted
>> measures as they are typically access pattern dependent. Sadly it is
>> very unlikely any hardware will implement a truly precise tracker given
>> the large resource requirements for tracking at a useful granularity.
>>
>> There are two fundamental operation modes:
>>
>> * Epoch based. Counters are checked after a period of time (Epoch) and
>>   if over a threshold added to the hotlist.
>> * Always on. Counters run until a threshold is reached, after that the
>>   hot unit is added to the hotlist and the counter released.
>>
>> Counting can be filtered on:
>>
>> * Region of CXL DPA space (256MiB per bit in a bitmap).
>> * Type of access - Trusted and non trusted or non trusted only, R/W/RW
>>
>> Sampling can be modified by:
>>
>> * Downsampling including potentially randomized downsampling.
>>
>> The driver presented here is intended to be useful in its own right but
>> also to act as the first step of a possible path towards hotness monitoring
>> based hot page migration. Those steps might look like.
>>
>> 1. Gather data - drivers provide telemetry like solutions to get that
>>    data. May be enhanced, for example in this driver by providing the
>>    HPA address rather than DPA Unit Address. Userspace can access enough
>>    information to do this so maybe not.
>> 2. Userspace algorithm development, possibly combined with userspace
>>    triggered migration by PA. Working out how to use different levels
>>    of constrained hardware resources will be challenging.
>> 3. Move those algorithms in kernel. Will require generalization across
>>    different hotpage trackers etc.
>>
>> So far this driver just gives access to the raw data. I will probably kick
>> of a longer discussion on how to do adaptive sampling needed to actually
>> use these units for tiering etc, sometime soon (if no one one else beats
>> me too it).  There is a follow up topic of how to virtualize this stuff
>> for memory stranding cases (VM gets a fixed mixture of fast and slow
>> memory and should do it's own tiering).
>>
>> More details in the Documentation patch but typical commands are:
>>
>> $perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,\
>>  hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,\
>>  range_size=1024,randomized_downsampling=0,downsampling_factor=32,\
>>  hotness_granual=12

Facing issue while executing perf record on x86 emulation environment using following steps

1. Tried applying CHMU Patch on branch cxl-for-6.13 using b4 utility. As
base commit is not specified, with minor change able to apply patch.
Compiled kernel with CONFIG_CXL_HMU

2. Compiled jic23/cxl-2024-11-27 for x86_64-softmmu

3. Launched Qemu with following CXL topology along with compiled kernel
VM="-object memory-backend-ram,id=vmem1,share=on,size=512M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
     -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
     -device cxl-type3,bus=root_port13,volatile-memdev=vmem1,id=cxl-vmem1 \
     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k"

4. Created region and onlined this memory. Also run top utility on the newly created 
numa node using numactl -m<node> top

5. Compiled and installed perf utility in qemu environment, and able to
see cxl_hmu_mem* entries in perf list

root@QEMUCXL2030mm:~# perf list
<snip>
  cxl_hmu_mem0.0.0/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
  cxl_hmu_mem0.0.1/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
  cxl_hmu_mem0.0.2/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
  cxl_hmu_mem1.0.0/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
  cxl_hmu_mem1.0.1/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
  cxl_hmu_mem1.0.2/hotness_granual=0..0xffffffff,hotness_threshold=0..0xffffffff,downsampling_factor=0..255,.../modifier[Raw ev>
  cxl_pmu_mem0.0/vid=0..0xffff,edge,mask=0..0xffffffff,.../modifier[Raw event descriptor]
  cxl_pmu_mem0.1/vid=0..0xffff,edge,mask=0..0xffffffff,.../modifier[Raw event descriptor]
  cxl_pmu_mem1.0/vid=0..0xffff,edge,mask=0..0xffffffff,.../modifier[Raw event descriptor]
  cxl_pmu_mem1.1/vid=0..0xffff,edge,mask=0..0xffffffff,.../modifier[Raw event descriptor]
<snip>

6. Tried running perf command mentioned in Documentation/trace/cxl-hmu.rst

root@QEMUCXL2030mm:/home/cxl/cxl-linux-mainline/tools/perf# perf -v
perf version 6.12.rc5.gc198a4f4a356
root@QEMUCXL2030mm:/home/cxl/cxl-linux-mainline/tools/perf# perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,range_size=1024,randomized_downsampling=0,downsampling_factor=32,hotness_granual=12
event syntax error: '..ess_granual=12'
                                  \___ Unrecognized input



Are there any steps i am missing?

Regards,
Neeraj	 

>>
>> $perf report --dump-raw-traces
>>
>> Example output.  With a counter_width of 16 (0x10) the least significant
>> 4 bytes are the counter value and the unit index is bits 16-63.
>> Here all units are over the threshold and the indexes are 0,1,2 etc.
>>
>> . ... CXL_HMU data: size 33512 bytes
>> Header 0: units: 29c counter_width 10
>> Header 1 : deadbeef
>> 0000000000000283
>> 0000000000010364
>> 0000000000020366
>> 000000000003033c
>> 0000000000040343
>> 00000000000502ff
>> 000000000006030d
>> 000000000007031a
>>
>> Which will produce a list of hotness entries.
>> Bits[N-1:0] counter value
>> Bits[63:N] Unit ID (combine with unit size and DPA base + HDM decoder
>>   config to get to a Host Physical Address)
>>
>> Specific RFC questions.
>> - What should be in the header added to the aux buffer.
>>   Currently just the minimum is provided. Number of records
>>   and the counter width needed to decode them.
>> - Should we reset the counters when doing sampling "-F X"
>>   If the frequency is higher than the epoch we never see any hot units.
>>   If so, when should we reset them?
>>
>> Note testing has been light and on emulation only + as perf tool is
>> a pain to build on a striped back VM,  build testing has all be on
>> arm64 so far.  The driver loads though on both arm64 and x86 so
>> any problems are likely in the perf tool arch specific code
>> which is build tested (on wrong machine)
>>
>> The QEMU emulation needs some cleanup, but I should be able to post
>> that shortly to let people actually play with this.  There are lots
>> of open questions there on how 'right' we want the emulation to be
>> and what counting uarch to emulate.
>>
>> Jonathan Cameron (4):
>>   cxl: Register devices for CXL Hotness Monitoring Units (CHMU)
>>   cxl: Hotness Monitoring Unit via a Perf AUX Buffer.
>>   perf: Add support for CXL Hotness Monitoring Units (CHMU)
>>   hwtrace: Document CXL Hotness Monitoring Unit driver
>>
>>  Documentation/trace/cxl-hmu.rst     | 197 +++++++
>>  Documentation/trace/index.rst       |   1 +
>>  drivers/cxl/Kconfig                 |   6 +
>>  drivers/cxl/Makefile                |   3 +
>>  drivers/cxl/core/Makefile           |   1 +
>>  drivers/cxl/core/core.h             |   1 +
>>  drivers/cxl/core/hmu.c              |  64 ++
>>  drivers/cxl/core/port.c             |   2 +
>>  drivers/cxl/core/regs.c             |  14 +
>>  drivers/cxl/cxl.h                   |   5 +
>>  drivers/cxl/cxlpci.h                |   1 +
>>  drivers/cxl/hmu.c                   | 880 ++++++++++++++++++++++++++++
>>  drivers/cxl/hmu.h                   |  23 +
>>  drivers/cxl/pci.c                   |  26 +-
>>  tools/perf/arch/arm/util/auxtrace.c |  58 ++
>>  tools/perf/arch/x86/util/auxtrace.c |  76 +++
>>  tools/perf/util/Build               |   1 +
>>  tools/perf/util/auxtrace.c          |   4 +
>>  tools/perf/util/auxtrace.h          |   1 +
>>  tools/perf/util/cxl-hmu.c           | 367 ++++++++++++
>>  tools/perf/util/cxl-hmu.h           |  18 +
>>  21 files changed, 1748 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/trace/cxl-hmu.rst
>>  create mode 100644 drivers/cxl/core/hmu.c
>>  create mode 100644 drivers/cxl/hmu.c
>>  create mode 100644 drivers/cxl/hmu.h
>>  create mode 100644 tools/perf/util/cxl-hmu.c
>>  create mode 100644 tools/perf/util/cxl-hmu.h
>>
>

------syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_d5212_
Content-Type: text/plain; charset="utf-8"


------syFHuyivwrsgIW8y2bU-AmBmzS5V9dEENjkeRCLm2dEK6Ofb=_d5212_--

