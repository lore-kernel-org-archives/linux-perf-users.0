Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BCEC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 09:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378740AbiEMJC4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 05:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244217AbiEMJCz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 05:02:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0788FD6D;
        Fri, 13 May 2022 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652432574; x=1683968574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=45+/AEx1UDTyL/FaFySGemKP+J4KpV7f3tcTiOxPaOQ=;
  b=AnJn6sLq24OSb5GELbIFg0uTfn2hlTU8E5gRy2vzWVkgVxVmmERVMPuv
   zzQ3pvhjVMsk7IGBHFdwzEVmwSVKUH4EOb5f6ExnhJ5gG3ddIE+bUGY4M
   3edkZDVifCpDvZLNJjZulhuRyoKd7bX/SWuRGHdz9wdxx3ePstx4lyawl
   qGIjfyHDaqHZzsJD8MdBiCW6rTSEPWYK01n/cuc3UqJmgM46pPqkj35nY
   tFSFmwHcokCrGWcx8KbWmp4quHHTQIXibOrql0xUjo5B88Icv4zFDqCcZ
   iBFd9Xb7+UUL3Qeby83GF0ZpwKeHSUbTomcnEt0JnXaaJz7jjPzCuBPVQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="330856451"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="330856451"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 02:02:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="595129522"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.36.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 02:02:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH 0/6] perf intel-pt: Add support for tracing KVM test programs
Date:   Fri, 13 May 2022 12:02:31 +0300
Message-Id: <20220513090237.10444-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi

A common case for KVM test programs is that the guest object code can be
found in the hypervisor process (i.e. the test program running on the
host).  Add support for that.

For some more details refer the 3rd patch "perf tools: Add guest_code
support"

For an example, see the last patch "perf intel-pt: Add guest_code support"

For more information about Perf tools support for Intel® Processor Trace
refer:

  https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace


Adrian Hunter (6):
      perf tools: Add machine to machines back pointer
      perf tools: Factor out thread__set_guest_comm()
      perf tools: Add guest_code support
      perf script: Add guest_code support
      perf kvm report: Add guest_code support
      perf intel-pt: Add guest_code support

 tools/perf/Documentation/perf-intel-pt.txt | 67 ++++++++++++++++++++++++
 tools/perf/Documentation/perf-kvm.txt      |  3 ++
 tools/perf/Documentation/perf-script.txt   |  4 ++
 tools/perf/builtin-kvm.c                   |  2 +
 tools/perf/builtin-script.c                |  5 +-
 tools/perf/util/event.c                    |  7 ++-
 tools/perf/util/intel-pt.c                 | 20 ++++++-
 tools/perf/util/machine.c                  | 84 ++++++++++++++++++++++++++++--
 tools/perf/util/machine.h                  |  4 ++
 tools/perf/util/session.c                  |  7 +++
 tools/perf/util/symbol_conf.h              |  3 +-
 11 files changed, 197 insertions(+), 9 deletions(-)


Regards
Adrian
