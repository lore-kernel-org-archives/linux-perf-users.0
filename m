Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AF3C00140
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Aug 2022 10:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiHRKBm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Aug 2022 06:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbiHRKBk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Aug 2022 06:01:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846BA979FD
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Aug 2022 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660816899; x=1692352899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7LeBf56IOf53Pscm0kXsYB8ERlNBj3KIW3jRU3mlLxE=;
  b=Ekr5KtE7iuTJAcQjrDHOHLwtvmlwpu/Ku2Odu5WJbKMZcpat5YooWK7p
   k+LJ9dmWc4rml150BMJIItzmPiSZSpXAfp/iPhJROcNPur+lXaZHnPC7X
   FygTZ6qjsbr31GNA6ewCFuAwElT7ulBjSSzHJ75vBiI5usQbXnrmipeda
   0c0dvg47mGODddoC7Y8WU8C1l00aqfFS27SIrAoWYso3VcibJt6lBUo23
   nlp3JUX4vfiig/IwnxFp8R+sxGEsxWSIxpmnDrooWc/PKCAV06QSsyveJ
   HnSC8xAgtdtkkLH6uJVPioUTGPYdwnFrWe6IYoj2Jg0UTOiwnNe+BDHAx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="354458901"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="354458901"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 03:01:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="558470097"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 03:01:39 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org, zhengjun.xing@intel.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf tools: Improve hybrid description in perf record manpage
Date:   Thu, 18 Aug 2022 03:01:27 -0700
Message-Id: <20220818100127.249401-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The Intel hybrid description is written in a different style than
the rest of the perf record man page. There were some new command line
options added after it which resulted in very strange section ordering.
Move the hybrid include last.

Also the sub sections in the hybrid document don't fit the record
manpage well (especially since it talks about all kinds of unrelated
commands). I left this for now, but would be better to separate this
properly in the different man pages.

It would be better to use sub sections for the other sections, but these
don't seem to be supported in AsciiDoc?

Some of the examples are still misrendered in the manpage with an indented
troff command, but I don't know how to fix that.

In any case it's now better than before.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/intel-hybrid.txt | 10 ----------
 tools/perf/Documentation/perf-record.txt  |  4 ++--
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/intel-hybrid.txt b/tools/perf/Documentation/intel-hybrid.txt
index c9302096dc46..e7a776ad25d7 100644
--- a/tools/perf/Documentation/intel-hybrid.txt
+++ b/tools/perf/Documentation/intel-hybrid.txt
@@ -21,11 +21,6 @@ cat /sys/devices/cpu_atom/cpus
 
 It indicates cpu0-cpu15 are core cpus and cpu16-cpu23 are atom cpus.
 
-Quickstart
-
-List hybrid event
------------------
-
 As before, use perf-list to list the symbolic event.
 
 perf list
@@ -40,7 +35,6 @@ the event is belong to. Same event name but with different pmu can
 be supported.
 
 Enable hybrid event with a specific pmu
----------------------------------------
 
 To enable a core only event or atom only event, following syntax is supported:
 
@@ -53,7 +47,6 @@ For example, count the 'cycles' event on core cpus.
 	perf stat -e cpu_core/cycles/
 
 Create two events for one hardware event automatically
-------------------------------------------------------
 
 When creating one event and the event is available on both atom and core,
 two events are created automatically. One is for atom, the other is for
@@ -132,7 +125,6 @@ For perf-stat result, it displays two events:
 The first 'cycles' is core event, the second 'cycles' is atom event.
 
 Thread mode example:
---------------------
 
 perf-stat reports the scaled counts for hybrid event and with a percentage
 displayed. The percentage is the event's running time/enabling time.
@@ -176,14 +168,12 @@ perf_event_attr:
        604,097,080      cpu_atom/cycles/                                              (99.57%)
 
 perf-record:
-------------
 
 If there is no '-e' specified in perf record, on hybrid platform,
 it creates two default 'cycles' and adds them to event list. One
 is for core, the other is for atom.
 
 perf-stat:
-----------
 
 If there is no '-e' specified in perf stat, on hybrid platform,
 besides of software events, following events are created and
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index cf8ad50f3de1..0aaaaa7aee68 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -747,8 +747,6 @@ events in data directory files. Option specified with no or empty value
 defaults to CPU layout. Masks defined or provided by the option value are
 filtered through the mask provided by -C option.
 
-include::intel-hybrid.txt[]
-
 --debuginfod[=URLs]::
 	Specify debuginfod URL to be used when cacheing perf.data binaries,
 	it follows the same syntax as the DEBUGINFOD_URLS variable, like:
@@ -768,6 +766,8 @@ include::intel-hybrid.txt[]
 	only, as of now.  So the applications built without the frame
 	pointer might see bogus addresses.
 
+include::intel-hybrid.txt[]
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
-- 
2.35.3

