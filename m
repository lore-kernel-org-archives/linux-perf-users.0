Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CBC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Oct 2022 12:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJRMPv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJRMPu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2022 08:15:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72278A285E;
        Tue, 18 Oct 2022 05:15:47 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MsCRS6tHMz67PDP;
        Tue, 18 Oct 2022 20:12:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:15:45 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 13:15:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC:     <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-perf-users@vger.kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [RFC PATCH v3 5/5] docs: perf: Minimal introduction the the CXL PMU device and driver.
Date:   Tue, 18 Oct 2022 13:13:18 +0100
Message-ID: <20221018121318.22385-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221018121318.22385-1-Jonathan.Cameron@huawei.com>
References: <20221018121318.22385-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Very basic introduction to the device and the current driver support
provided. I expect to expand on this in future versions of this patch
set.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
RFC:
- I'll post separately about this shortly, but it seems very odd
  to me that there is no way to assign a parent to an event_sources
  device.  As a result we get the messy approach of playing match
  the name to figure out what the CPMU instance is connected to.
---
 Documentation/admin-guide/perf/cxl.rst   | 60 ++++++++++++++++++++++++
 Documentation/admin-guide/perf/index.rst |  1 +
 2 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/perf/cxl.rst b/Documentation/admin-guide/perf/cxl.rst
new file mode 100644
index 000000000000..5105ae484e08
--- /dev/null
+++ b/Documentation/admin-guide/perf/cxl.rst
@@ -0,0 +1,60 @@
+======================================
+CXL Performance Monitoring Unit (CPMU)
+======================================
+
+The CXL rev 3.0 specification provides a definition of CXL Performance
+Monitoring Unit in section 13.2: Performance Monitoring.
+
+CXL components (e.g. Root Port, Switch Upstream Port, End Point) may have
+any number of CPMU instances. CPMU capabilities are fully discoverable from
+the devices. The specification provides event definitions for all CXL protocol
+message types and a set of additional events for things commonly counted on
+CXL devices (e.g. DRAM events).
+
+CPMU driver
+===========
+
+The CPMU driver register a perf PMU with the name cpmu<id> on the CXL bus.
+
+    /sys/bus/cxl/device/cpmu<id>
+
+The associated PMU is registered as
+
+   /sys/bus/event_sources/devices/cpmu<id>
+
+In common with other CXL bus devices, the id has no specific meaning and the
+relationship to specific CXL device should be established via the device parent
+of the device on the CXL bus.
+
+PMU driver provides description of available events and filter options in sysfs.
+
+The "format" directory describes all formats of the config (event vendor id,
+group id and mask) config1 (threshold, filter enables) and config2 (filter
+parameters) fields of the perf_event_attr structure.  The "events" directory
+describes all the documented events show in perf list.
+
+The events shown in perf list are the most fine grained events with a single
+bit of the event mask set. More general events may be enable by setting
+multiple mask bits in config. For example, all Device to Host Read Requests
+may be captured on a single counter by setting the bits for all of
+
+* d2h_req_rdcurr
+* d2h_req_rdown
+* d2h_req_rdshared
+* d2h_req_rdany
+* d2h_req_rdownnodata
+
+Example of usage::
+
+  $#perf list
+  cpmu0/clock_ticks/                                 [Kernel PMU event]
+  cpmu0/d2h_req_itomwr/                              [Kernel PMU event]
+  cpmu0/d2h_req_rdany/                               [Kernel PMU event]
+  cpmu0/d2h_req_rdcurr/                              [Kernel PMU event]
+  -----------------------------------------------------------
+
+  $# perf stat -e cpmu0/clock_ticks/ -e cpmu0/d2h_req_itowrm/
+
+The driver does not support sampling. So "perf record" and attaching to
+a task are unsupported.
+
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 793e1970bc05..db7828f1f4ef 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -19,3 +19,4 @@ Performance monitor support
    arm_dsu_pmu
    thunderx2-pmu
    alibaba_pmu
+   cxl
-- 
2.37.2

