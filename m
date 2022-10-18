Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E223C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 Oct 2022 12:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJRMNS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJRMNQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Oct 2022 08:13:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E28B3AB38;
        Tue, 18 Oct 2022 05:13:15 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MsCNX1dkJz67G78;
        Tue, 18 Oct 2022 20:10:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 14:13:12 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 13:13:11 +0100
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
Subject: [RFC PATCH v3 0/5] CXL 3.0 Performance Monitoring Unit support
Date:   Tue, 18 Oct 2022 13:13:13 +0100
Message-ID: <20221018121318.22385-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
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

Chances since v2:

- Various minor tweaks from Dave Jiang,
- Rebase on Davidlohr's generic handling of IRQs in the cxl/pci driver.
Note that I don't think that infrastructure is a good fit, so part of
reason for this RFC v3 is to allow us to discuss how best to handle that.
I've added a bit more detail in comments on patch 3.

Updated cover letter:

The CXL rev 3.0 specification introduces a CXL Performance Monitoring
Unit definition. CXL components may have any number of these blocks. The
definition is highly flexible, but that does bring complexity in the
driver.

Initially posted as an RFC for a number of reasons.
1) The QEMU model against which this was developed needs tidying up and
   review for correctness. Latest tree at
   https://gitlab.com/jic23/qemu branch cxl-2022-10-17
   It's backed up behind other series that I plan to upstream first.
2) There are quite a lot of corner cases that will need working through
   with variants of the model, or I'll have to design a pathological
   set of CPMUs to hit all the corner cases in one go.
3) I'm not sure it makes sense to hang this of the cxl/pci driver but
   couldn't really figure out where else in the current structure we could
   make it fit cleanly.
4) Open question about the 'generic' handling of interrupts in cxl/pci.c
5) I'm not sure how to expose to user space the sets of events that may
   be summed (given by a mask in the Counter Event Capabilities registers).
   For now the driver advertises the individual events. Each individual
   event may form part of multiple overlapping groups for example.
   It may be a case of these allowed combinations only being discoverable
   by requesting a combination and checking for errors on start.
6) Driver location. In past perf maintainers have requested perf drivers
   for PCI etc be under drivers/perf. That would require moving some
   CXL headers to be more generally visible, but is certainly possible
   if there is agreement between CXL and perf maintainers on the correct
   location.
7) Documentation needs improving, but I didn't want to spend too much
   time on that whilst we have so many open questions.  I'll separately
   raise the question about pmu->dev parenting which is mentioned in the
   Docs patch introduction. (oops - haven't done that yet)

CXL rev 3.0 specification available from https://www.computeexpresslink.org

Davidlohr Bueso (1):
  cxl/pci: Add generic MSI-X/MSI irq support

Jonathan Cameron (4):
  cxl: Add function to count regblocks of a given type
  cxl/pci: Find and register CXL PMU devices
  cxl: CXL Performance Monitoring Unit driver
  docs: perf: Minimal introduction the the CXL PMU device and driver.

 Documentation/admin-guide/perf/cxl.rst   |  60 ++
 Documentation/admin-guide/perf/index.rst |   1 +
 drivers/cxl/Kconfig                      |  12 +
 drivers/cxl/Makefile                     |   1 +
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/core.h                  |   3 +
 drivers/cxl/core/cpmu.c                  |  69 ++
 drivers/cxl/core/pci.c                   |   2 +-
 drivers/cxl/core/port.c                  |   4 +-
 drivers/cxl/core/regs.c                  |  64 +-
 drivers/cxl/cpmu.c                       | 945 +++++++++++++++++++++++
 drivers/cxl/cpmu.h                       |  54 ++
 drivers/cxl/cxl.h                        |  16 +
 drivers/cxl/cxlmem.h                     |   5 +
 drivers/cxl/cxlpci.h                     |   1 +
 drivers/cxl/pci.c                        | 125 ++-
 16 files changed, 1356 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/cxl.rst
 create mode 100644 drivers/cxl/core/cpmu.c
 create mode 100644 drivers/cxl/cpmu.c
 create mode 100644 drivers/cxl/cpmu.h

-- 
2.37.2

