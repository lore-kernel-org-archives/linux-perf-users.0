Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F811C1AB6
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899913; cv=none; b=rkHnpQH17qW524Mn5KSkqXEv70Z6UwL4YYwziYKNqAdDAQAlsXP1SQzExPREil0tWwkJ9pA2P8SNxAMPIhVKxk+ThjRtCiR+0hAcOHd56FkxmbEA3PyWSItw+Co63p8RU4bTCfLvQKUdYhzW4TqS9RiqZI6dLJnE+/r5jYa+SM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899913; c=relaxed/simple;
	bh=1huyat/rDoE+3jloVqQS4Nw7yB6T7fOrWCFpfsc3Whw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=blY7VzpAhsOu7r+kCx/AckG05/wS0scHSJrlEqrn4cLd8f9rItvGhudybfvt3MDSRO3u4dl7riCeUPneBm54vrT4cTGtsGXc5qhu8Q5QXLtatdUFynwYlhmfmUXp1FrYuIrQ1XLXpQDtXmnTl3H0LXnuYlam2JJdzQ686Gu0O2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lagFeXOW; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lagFeXOW"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250103102503epoutp047650f34004d1bb15b363649a400820dd~XJ8PU_Ldm2459024590epoutp04O
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jan 2025 10:25:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250103102503epoutp047650f34004d1bb15b363649a400820dd~XJ8PU_Ldm2459024590epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1735899903;
	bh=Jl9IBnB0qG+Ux1AJFrxobJ1+wbLR/Bpu/l1Q6vPAscg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lagFeXOW89Ob4gpQIDYHzHG8zm12JwnodcyXfsw871pu4T6Ni5rJdAnCNE13l4ZXg
	 bqn3eqdU9AORwyccWK76pRDWacHyvvlTKGkRln5XKJ+SAxe5Rw46PeEYjolnDC568S
	 6B3+G+Rc+R6IyvnIudmJaOH771mKbJ1YrcWs/Buc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250103102502epcas5p192e3e54d5a54e214197296c166bbf52c~XJ8OcPcL40091800918epcas5p1b;
	Fri,  3 Jan 2025 10:25:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YPfpQ33RBz4x9Px; Fri,  3 Jan
	2025 10:25:02 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250103052702epcas5p3f7eea83ac70ba7147e0de7fb30f90a62~XF4CS4d0O1068110681epcas5p3B;
	Fri,  3 Jan 2025 05:27:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250103052702epsmtrp195ceeea5354adb4809e7486cb92e8ad4~XF4CQlw3l0853008530epsmtrp1F;
	Fri,  3 Jan 2025 05:27:02 +0000 (GMT)
X-AuditID: b6c32a29-e5d8824000004929-41-677775260af1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	87.A4.18729.62577776; Fri,  3 Jan 2025 14:27:02 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250103052658epsmtip12789f94584f95a43bcf74a64472b38ac~XF3_huf8O0883908839epsmtip1Q;
	Fri,  3 Jan 2025 05:26:58 +0000 (GMT)
Date: Fri, 3 Jan 2025 10:49:02 +0530
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
Subject: Re: [RFC PATCH 4/4] hwtrace: Document CXL Hotness Monitoring Unit
 driver
Message-ID: <1983025922.01735899902414.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241121101845.1815660-5-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCSnK5aaXm6wa2rfBZd93awWazY28pu
	0bFpJqvF3ccX2Cy+nN7DZvHykKbF9KkXGC1O3Gxks1h9cw2jxc0DO5ksft49zm6x/+lzFotV
	C6+xWSzcuIzJ4vysUywWl3fNYbO4t+Y/q8WVretYLA5vPMNksfT6RSaLSwcWMFm0Tj/HaHG8
	9wCTxf79p0E65rBb7Nu2hdlizfKbTBYnZ01mcZDxWDNvDaNHd9tldo+WI29ZPTav0PJYvOcl
	k8emVZ1sHps+TWL3mHcy0OP7+g42j/f7rrJ59G1ZxegxdXa9x+dNcgG8UVw2Kak5mWWpRfp2
	CVwZWyYbFrxyrdi3uIu1gXGRZRcjJ4eEgInEs+fPGbsYuTiEBHYzSkxY1s4IkZCQ+PnnC5Qt
	LLHy33N2iKInjBLNt46BJVgEVCTWfXvIDmKzCWhKXL/YwgpiiwgYSby7MQlsKrPAWnaJ9582
	MIEkhAWCJd5euwmU4ODgFTCTOLRDGiQsJFAtcfPVUbBeXgFBiZMzn7CA2MxAJfM2P2QGKWcW
	kJZY/o8DJMwp4Cyx9PFfZhBbVEBGYsbSr8wTGAVnIemehaR7FkL3AkbmVYySqQXFuem5xYYF
	hnmp5XrFibnFpXnpesn5uZsYwalBS3MH4/ZVH/QOMTJxMB5ilOBgVhLhjQgvSRfiTUmsrEot
	yo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgmy8TBKdXAlD0vc+Kz/UVntdzy2/8s
	Wn3im71/l/KDROeT+ybFPtjduX7Ty5TPjOuD//Q+XX47/vxvAT+V5Rcbb320M5F4IR+ZfmGJ
	g1Ea09Hs4mPbasqmSij3OrIoB1/fJHHXjWMDw90XMob3uqbrBKaocD5kv70pvcJiOe+mBSGX
	qib89D/nWNlgkKB6bWXpFIXb087uuZH4LnVz/kS/luaHEVaVdYH33f/83N3ffnlaWFK6wMVr
	jz1nzvgV8ZOva6XuPy5ZASmGReu49VNt+PcqlOdcupnw2Nup48tlgSM5a3543q959qxwb3g9
	x4n9/deMujedDHWY5Kflsq6751/4Lab9p/Ztddq3dpfO/7AVax9emKrEUpyRaKjFXFScCADd
	LLxOfAMAAA==
X-CMS-MailID: 20250103052702epcas5p3f7eea83ac70ba7147e0de7fb30f90a62
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----lzW.cJR_-6sCvQYD.lREqa.H-32Z9TKwpDxBjmCjs3VZTSBT=_d4dc1_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250103052702epcas5p3f7eea83ac70ba7147e0de7fb30f90a62
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
	<20241121101845.1815660-5-Jonathan.Cameron@huawei.com>
	<CGME20250103052702epcas5p3f7eea83ac70ba7147e0de7fb30f90a62@epcas5p3.samsung.com>

------lzW.cJR_-6sCvQYD.lREqa.H-32Z9TKwpDxBjmCjs3VZTSBT=_d4dc1_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 21/11/24 10:18AM, Jonathan Cameron wrote:
>Add basic documentation to describe the CXL HMU and the
>perf AUX buffer based interfaces.
>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>---
> Documentation/trace/cxl-hmu.rst | 197 ++++++++++++++++++++++++++++++++
> Documentation/trace/index.rst   |   1 +
> 2 files changed, 198 insertions(+)
>
>diff --git a/Documentation/trace/cxl-hmu.rst b/Documentation/trace/cxl-hmu.rst
>new file mode 100644
>index 000000000000..f07a50ba608c
>--- /dev/null
>+++ b/Documentation/trace/cxl-hmu.rst
>@@ -0,0 +1,197 @@
>+.. SPDX-License-Identifier: GPL-2.0
>+
>+==================================
>+CXL Hotness Monitoring Unit Driver
>+==================================
>+
>+CXL r3.2 introduced the CXL Hotness Monitoring Unit (CHMU). A CHMU allows
>+software running on a CXL Host to identify hot memory ranges, that is those with
>+higher access frequency relative to other memory ranges.
>+
>+A given Logical Device (presentation of a CXL memory device seen by a particular
>+host) can provide 1 or more CHMU each of which supports 1 or more separately
>+programmable CHMU Instances (CHMUI). These CHMUI are mostly independent with
>+the exception that there can be restrictions on them tracking the same memory
>+regions. The CHMUs are always completely independent.
>+The naming of the units is cxl_hmu_memX.Y.Z where memX matches the naming
>+of the memory device in /sys/bus/cxl/devices/, Y is the CHMU index and
>+Z is the CHMUI index with the CHMU.
>+
>+Each CHMUI provides a ring buffer structure known as the Hot List from which the
>+host an read back entries that describe the hotness of particular region of
>+memory (Hot List Units). The Hot List Unit combines a Unit Address and an access
>+count for the particular address. Unit address to DPA requires multiplication
>+by the unit size. Thus, for large unit sizes the device may support higher
>+counts. It is these Hot List Units that the driver provides via a perf AUX
>+buffer by copying them from PCI BAR space.
>+
>+The unit size at which hotness is measured is configurable for each CHMUI and
>+all measurement is done in Device Physical Address space. To relate this to
>+Host Physical Address space the HDM (Host-Managed Device Memory) decoder
>+configuration must be taken into account to reflect the placement in a
>+CXL Fixed Memory Window and any interleaving.
>+
>+The CHMUI can support interrupts on fills above a watermark, or on overflow
>+of the hotlist.
>+
>+A CHMUI can support two different basic modes of operation. Epoch and
>+Always On. These affect what is placed on the hotlist. Note that the actual
>+implementation of tracking is implementation defined and likely to be
>+inherently imprecise in that the hottest pages may not be discovered due to
>+resource exhaustion and the hotness counts may not represent accurately how
>+hot they are. The specification allows for a very high degree of flexibility
>+in implementation, important as it is likely that a number of different
>+hardware implementations will be chosen to suit particular silicon and accuracy
>+budgets.
>+
>+Operation and configuration
>+===========================
>+
>+An example command line is::
>+
>+  $perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,\
>+  hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,\
>+  range_size=1024,randomized_downsampling=0,downsampling_factor=32,\
>+  hotness_granual=12
>+
>+  $perf report --dump-raw-traces

Typo: --dump-raw-trace

>+
>+which will produce a list of hotlist entries, one per line with a short header
>+to provide sufficient information to interpret the entries::
>+
>+  . ... CXL_HMU data: size 33512 bytes
>+  Header 0: units: 29c counter_width 10
>+  Header 1 : deadbeef
>+  0000000000000283
>+  0000000000010364
>+  0000000000020366
>+  000000000003033c
>+  0000000000040343
>+  00000000000502ff
>+  000000000006030d
>+  000000000007031a
>+  ...
>+
>+The least significant counter_width bits (here 16, hex 10) are the counter
>+value, all higher bits are the unit index.  Multiply by the unit size
>+to get a Device Physical Address.
>+
>+The parameters are as follows:
>+
>+epoch_type
>+----------
>+
>+Two values may be supported::
>+
>+  0 - Epoch based operation
>+  1 - Always on operation
>+
>+
>+0. Epoch Based Operation
>+~~~~~~~~~~~~~~~~~~~~~~~~
>+
>+An Epoch is a period of time after which a counter is assessed for hotness.
>+
>+The device may have a global sense of an Epoch but it may also operate them on
>+a per counter, or per region of device basis. This is a function of the
>+implementation and is not controllable, but is discoverable. In a global Epoch
>+scheme at start of each Epoch all counters are zeroed / deallocated. Counters
>+are then allocated in a hardware specific manner and accesses counted. At the
>+completion of the Epoch the counters are compared with a threshold and entries
>+with a count above a configurable threshold are added to the hotlist. A new
>+Epoch is then begun with all counters cleared.
>+
>+In non-global Epoch scheme, when the Epoch of a given counter begins is not
>+specified. An example might be an Epoch for counter only starting on first
>+touch to the relevant memory region.  When a local Epoch ends the counter is
>+compared to the threshold and if appropriate added to the hotlist.
>+
>+Note, in Epoch Based Operation, the counter in the hotlist entry provides
>+information on how hot the memory is as the counter for the full Epoch is
>+provided.
>+
>+1. Always on Operation
>+~~~~~~~~~~~~~~~~~~~~~~
>+
>+In this mode, counters may all be reset before enabling the CHMUI. Then
>+counters are allocated to particular memory units via an hardware specific
>+method, perhaps on first touch.  When a counter passes the configurable
>+hotness threshold an entry is added to the hotlist and that counter is freed
>+for reuse.
>+
>+In this scheme the count provided in the hotlist entry is not useful as it will
>+depend only on the configured threshold.
>+
>+access_type
>+-----------
>+
>+The parameter controls which access are counted::
>+
>+  1 - Non-TEE read only
>+  2 - Non-TEE write only
>+  3 - Non-TEE read and write
>+  4 - TEE and Non-TEE read only
>+  5 - TEE and Non-TEE write only
>+  6 - TEE and Non-tee read and write
>+
>+
>+TEE here refers to a trusted execution environment, specifically one that
>+results in the T bit being set in the CXL transactions.
>+
>+
>+hotness_granual
>+---------------
>+
>+Unit size at which tracking is performed.  Must be at least 256 bytes but
>+hardware may only support some sizes. Expressed as a power of 2. e.g. 12 = 4kiB.
>+
>+hotness_threshold
>+-----------------
>+
>+This is the minimum counter value that must be reached for the unit to count as
>+hot and be added to the hotlist.
>+
>+The possible range may be dependent on the unit size as a larger unit size
>+requires more bits on the hotlist entry leaving fewer available for the hotness
>+counter.
>+
>+epoch_multiplier and epoch_scale
>+--------------------------------
>+
>+The length of an epoch (in epoch mode) is controlled by these two parameters
>+with the decoded epoch_scale multiplied by the epoch_multiplier to give the
>+overall epoch length.
>+
>+epoch_scale::
>+
>+  1 - 100 usecs
>+  2 - 1 msec
>+  3 - 10 msecs
>+  4 - 100 msecs
>+  5 - 1 second
>+
>+range_base and range_scale
>+--------------------------
>+
>+Expressed in terms of the unit size set via hotness_granual. Each CHMUI has a
>+bitmap that controls what Device Physical Address spaces is tracked. Each bit
>+represents 256MiB of DPA space.
>+
>+This interface provides a simple base and size in units of 256MiB to configure
>+this bitmap. All bits in the specified range will be set.
>+
>+downsampling_factor
>+-------------------
>+
>+Hardware may be incapable of counting accesses at full speed or it may be
>+desirable to count over a longer period during which the counters would
>+overflow.  This control allows selection of a down sampling factor expressed
>+as a power of 2 between 1 and 32768.  Default is minimum supported downsampling
>+factor.
>+
>+randomized_downsampling
>+-----------------------
>+
>+To avoid problems with downsampling when accesses are periodic this option
>+allows for an implementation defined randomization of the sampling interval,
>+whilst remaining close to the specified downsampling_factor.
>diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
>index 0b300901fd75..b35ed8e9dfa9 100644
>--- a/Documentation/trace/index.rst
>+++ b/Documentation/trace/index.rst
>@@ -36,3 +36,4 @@ Linux Tracing Technologies
>    user_events
>    rv/index
>    hisi-ptt
>+   cxl-hmu
>-- 
>2.43.0
>

------lzW.cJR_-6sCvQYD.lREqa.H-32Z9TKwpDxBjmCjs3VZTSBT=_d4dc1_
Content-Type: text/plain; charset="utf-8"


------lzW.cJR_-6sCvQYD.lREqa.H-32Z9TKwpDxBjmCjs3VZTSBT=_d4dc1_--

