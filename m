From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH] perf s390: always build with -fPIC
Date: Thu, 30 Nov 2017 09:49:25 +0100
Message-ID: <1512031765-9382-1-git-send-email-brueckner@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751395AbdK3Ito (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Nov 2017 03:49:44 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAU8icF7125204
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2017 03:49:44 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ejcwkd0yh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2017 03:49:44 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Thu, 30 Nov 2017 08:49:41 -0000
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Linux perf users list <linux-perf-users@vger.kernel.org>, Linux s390 list <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, jonathan.hermann@de.ibm.com

On s390, object files must be compiled with position-indepedent code
in order to be incrementally linked or linked to shared libraries.
Therefore, add -fPIC to the CFLAGS for s390 to ensure each object
file is built properly.

Reported-by: Jonathan Hermann <jonathan.hermann@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/Makefile.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ed65e82..0833d9f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -55,6 +55,7 @@ endif
 
 ifeq ($(ARCH),s390)
   NO_PERF_REGS := 0
+  CFLAGS += -fPIC
 endif
 
 ifeq ($(NO_PERF_REGS),0)
-- 
1.8.3.1
