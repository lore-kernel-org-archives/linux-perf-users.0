Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937C262FEB;
	Fri,  8 Aug 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.97.181.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641843; cv=fail; b=K9Z3Xuc6ccSVlzfVk0Z0//DXRV9eT1VVTu/Bvj7Ssu8zVakldn7vEt1xmtyCXPhm+YAzG/GCDzcOHsnvAyr5A4yKBTc7rWhcoHdhSyim9IJIYmr1Me2PQN1Wj4WrEfv6rR7hEsZpKO1RSYHY8VHf4ZfajMlJtcgir2/+gtKq4bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641843; c=relaxed/simple;
	bh=S9gFz4Ybkvu9LfjiFi6+/BcQ592ZqiPeY+R4I9Saq7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version:MIME-Version; b=iU/11KF9Mk3+VkaewcbUtVhJZjU3vQYquwPTVqeziqM1RIFfyBBpffvnOIoRvLCSmnbWTuSvLEE5XhGWr0InEetTOohN/ypLXpjCL8MUcl62eO9o6B5vvf9Kz8KNOecLcIkT/yXGC1noI32pPcZofJLQyyojeu1d9nl9J7wn9W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=fail smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBnaUGntZVo_fqSBQ--.4S2;
	Fri, 08 Aug 2025 16:30:31 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwBH0gmNtZVoag0NAA--.18908S10;
	Fri, 08 Aug 2025 16:30:25 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: tangtao1634@phytium.com.cn,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linuxarm@huawei.com,
	tongtiangen@huawei.com,
	Yicong Yang <yangyicong@huawei.com>,
	Niyas Sait <niyas.sait@huawei.com>,
	ajayjoshi@micron.com,
	Vandana Salve <vsalve@micron.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gregory Price <gourry@gourry.net>,
	Huang Ying <ying.huang@intel.com>
Subject: [RFC PATCH 4/4] hwtrace: Document CXL Hotness Monitoring Unit driver
Date: Fri,  8 Aug 2025 16:29:56 +0800
Message-ID: <20241121101845.1815660-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Submitter: Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Patchwork-Id: 13881832
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56]) (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits)) (No client certificate requested) by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C51D5ADC; Thu, 21 Nov 2024 10:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116; t=1732184459; cv=none; b=JSR4Jjxrh2tJ+qtIkpZzBVZWvo4PhSyrou7dgxzL9bWXnR380MPAt0yoHNj/OX3KcLwmbkOU8+6zhYWqwN0N77Gd7nf39jfxmxg5WymG/CmfrsyzwOC48tdgJF8nrlgA7km4Exb4eOnpUI7DxPXH78vvY6rteUlWQHYDrDSCdt4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116; t=1732184459; c=relaxed/simple; bh=CV6JU7sYOsHz2ueDAt/Yb9FWbTFxVhrMXlaTilLqVGk=; h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References: MIME-Version:Content-Type; b=aYV7eEPwDUKJA3hKwCe7F50gx2wO3pgp91KoFtqLDyIJPnNdgWgXVPa7Vh4TgqVbXw5hLUD854jhW3PNo3qMAXA6ELV5ab4Aym7f1nh91IV6WR8k1XPba52PPG0fBjA1w8F6hDA6kc5k2DHwlwgcJ/XJrn4M1vSvTKzdrmkSyVE=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Received: from mail.maildlp.com (unknown [172.18.186.216]) by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvDgN6ZNCz6K6yP; Thu, 21 Nov 2024 18:17:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71]) by mail.maildlp.com (Postfix) with ESMTPS id 1EEAF140DD4; Thu, 21 Nov 2024 18:20:55 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov 2024 11:20:52 +0100
X-Mailer: git-send-email 2.43.0
Precedence: bulk
MIME-Version: 1.0
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To frapeml500008.china.huawei.com (7.182.85.71)
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBH0gmNtZVoag0NAA--.18908S10
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWiU-30C6wADsE
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Gw48AF47tFW5Xr4rGFyUKFg_yoWfJw1fpF
	Zagr93KFWkJryfGw1xJw47WFy5Ars5Aa15C3Z5KryFyrn8AryYqF1xtr1rXFyDGrWIyay0
	qFn09ryjk3Z8AaDanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU
Message-ID: <20250808082956.mtkFUw_QRNVCI6I8a-yOoZcEqeylOg0ivVYQaNkqUEk@z>

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add basic documentation to describe the CXL HMU and the
perf AUX buffer based interfaces.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/trace/cxl-hmu.rst | 197 ++++++++++++++++++++++++++++++++
 Documentation/trace/index.rst   |   1 +
 2 files changed, 198 insertions(+)

diff --git a/Documentation/trace/cxl-hmu.rst b/Documentation/trace/cxl-hmu.rst
new file mode 100644
index 000000000000..f07a50ba608c
--- /dev/null
+++ b/Documentation/trace/cxl-hmu.rst
@@ -0,0 +1,197 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+CXL Hotness Monitoring Unit Driver
+==================================
+
+CXL r3.2 introduced the CXL Hotness Monitoring Unit (CHMU). A CHMU allows
+software running on a CXL Host to identify hot memory ranges, that is those with
+higher access frequency relative to other memory ranges.
+
+A given Logical Device (presentation of a CXL memory device seen by a particular
+host) can provide 1 or more CHMU each of which supports 1 or more separately
+programmable CHMU Instances (CHMUI). These CHMUI are mostly independent with
+the exception that there can be restrictions on them tracking the same memory
+regions. The CHMUs are always completely independent.
+The naming of the units is cxl_hmu_memX.Y.Z where memX matches the naming
+of the memory device in /sys/bus/cxl/devices/, Y is the CHMU index and
+Z is the CHMUI index with the CHMU.
+
+Each CHMUI provides a ring buffer structure known as the Hot List from which the
+host an read back entries that describe the hotness of particular region of
+memory (Hot List Units). The Hot List Unit combines a Unit Address and an access
+count for the particular address. Unit address to DPA requires multiplication
+by the unit size. Thus, for large unit sizes the device may support higher
+counts. It is these Hot List Units that the driver provides via a perf AUX
+buffer by copying them from PCI BAR space.
+
+The unit size at which hotness is measured is configurable for each CHMUI and
+all measurement is done in Device Physical Address space. To relate this to
+Host Physical Address space the HDM (Host-Managed Device Memory) decoder
+configuration must be taken into account to reflect the placement in a
+CXL Fixed Memory Window and any interleaving.
+
+The CHMUI can support interrupts on fills above a watermark, or on overflow
+of the hotlist.
+
+A CHMUI can support two different basic modes of operation. Epoch and
+Always On. These affect what is placed on the hotlist. Note that the actual
+implementation of tracking is implementation defined and likely to be
+inherently imprecise in that the hottest pages may not be discovered due to
+resource exhaustion and the hotness counts may not represent accurately how
+hot they are. The specification allows for a very high degree of flexibility
+in implementation, important as it is likely that a number of different
+hardware implementations will be chosen to suit particular silicon and accuracy
+budgets.
+
+Operation and configuration
+===========================
+
+An example command line is::
+
+  $perf record -a  -e cxl_hmu_mem0.0.0/epoch_type=0,access_type=6,\
+  hotness_threshold=1024,epoch_multiplier=4,epoch_scale=4,range_base=0,\
+  range_size=1024,randomized_downsampling=0,downsampling_factor=32,\
+  hotness_granual=12
+
+  $perf report --dump-raw-traces
+
+which will produce a list of hotlist entries, one per line with a short header
+to provide sufficient information to interpret the entries::
+
+  . ... CXL_HMU data: size 33512 bytes
+  Header 0: units: 29c counter_width 10
+  Header 1 : deadbeef
+  0000000000000283
+  0000000000010364
+  0000000000020366
+  000000000003033c
+  0000000000040343
+  00000000000502ff
+  000000000006030d
+  000000000007031a
+  ...
+
+The least significant counter_width bits (here 16, hex 10) are the counter
+value, all higher bits are the unit index.  Multiply by the unit size
+to get a Device Physical Address.
+
+The parameters are as follows:
+
+epoch_type
+----------
+
+Two values may be supported::
+
+  0 - Epoch based operation
+  1 - Always on operation
+
+
+0. Epoch Based Operation
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+An Epoch is a period of time after which a counter is assessed for hotness.
+
+The device may have a global sense of an Epoch but it may also operate them on
+a per counter, or per region of device basis. This is a function of the
+implementation and is not controllable, but is discoverable. In a global Epoch
+scheme at start of each Epoch all counters are zeroed / deallocated. Counters
+are then allocated in a hardware specific manner and accesses counted. At the
+completion of the Epoch the counters are compared with a threshold and entries
+with a count above a configurable threshold are added to the hotlist. A new
+Epoch is then begun with all counters cleared.
+
+In non-global Epoch scheme, when the Epoch of a given counter begins is not
+specified. An example might be an Epoch for counter only starting on first
+touch to the relevant memory region.  When a local Epoch ends the counter is
+compared to the threshold and if appropriate added to the hotlist.
+
+Note, in Epoch Based Operation, the counter in the hotlist entry provides
+information on how hot the memory is as the counter for the full Epoch is
+provided.
+
+1. Always on Operation
+~~~~~~~~~~~~~~~~~~~~~~
+
+In this mode, counters may all be reset before enabling the CHMUI. Then
+counters are allocated to particular memory units via an hardware specific
+method, perhaps on first touch.  When a counter passes the configurable
+hotness threshold an entry is added to the hotlist and that counter is freed
+for reuse.
+
+In this scheme the count provided in the hotlist entry is not useful as it will
+depend only on the configured threshold.
+
+access_type
+-----------
+
+The parameter controls which access are counted::
+
+  1 - Non-TEE read only
+  2 - Non-TEE write only
+  3 - Non-TEE read and write
+  4 - TEE and Non-TEE read only
+  5 - TEE and Non-TEE write only
+  6 - TEE and Non-tee read and write
+
+
+TEE here refers to a trusted execution environment, specifically one that
+results in the T bit being set in the CXL transactions.
+
+
+hotness_granual
+---------------
+
+Unit size at which tracking is performed.  Must be at least 256 bytes but
+hardware may only support some sizes. Expressed as a power of 2. e.g. 12 = 4kiB.
+
+hotness_threshold
+-----------------
+
+This is the minimum counter value that must be reached for the unit to count as
+hot and be added to the hotlist.
+
+The possible range may be dependent on the unit size as a larger unit size
+requires more bits on the hotlist entry leaving fewer available for the hotness
+counter.
+
+epoch_multiplier and epoch_scale
+--------------------------------
+
+The length of an epoch (in epoch mode) is controlled by these two parameters
+with the decoded epoch_scale multiplied by the epoch_multiplier to give the
+overall epoch length.
+
+epoch_scale::
+
+  1 - 100 usecs
+  2 - 1 msec
+  3 - 10 msecs
+  4 - 100 msecs
+  5 - 1 second
+
+range_base and range_scale
+--------------------------
+
+Expressed in terms of the unit size set via hotness_granual. Each CHMUI has a
+bitmap that controls what Device Physical Address spaces is tracked. Each bit
+represents 256MiB of DPA space.
+
+This interface provides a simple base and size in units of 256MiB to configure
+this bitmap. All bits in the specified range will be set.
+
+downsampling_factor
+-------------------
+
+Hardware may be incapable of counting accesses at full speed or it may be
+desirable to count over a longer period during which the counters would
+overflow.  This control allows selection of a down sampling factor expressed
+as a power of 2 between 1 and 32768.  Default is minimum supported downsampling
+factor.
+
+randomized_downsampling
+-----------------------
+
+To avoid problems with downsampling when accesses are periodic this option
+allows for an implementation defined randomization of the sampling interval,
+whilst remaining close to the specified downsampling_factor.
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 0b300901fd75..b35ed8e9dfa9 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -36,3 +36,4 @@ Linux Tracing Technologies
    user_events
    rv/index
    hisi-ptt
+   cxl-hmu

