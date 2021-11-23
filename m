Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25D2C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 08:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhKWItg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:49:36 -0500
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:47700
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229617AbhKWItg (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 03:49:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZFaT2l8+SCGYlRUaR+fNI6zQ5sfrj7Sl/nTXnfMWQaUg4LolNuyGkmDauoDeqNj0XgG99Dukl2fggUjRH3ngPnJcPL2+Nfl+2+blBa7l3Aj+allflaV7kj98j41TuP5SBBwrnF2865wMV6llASJle3Tjqya5x9kOSqH9E+iZ4ZhQp/hqw8Li+s81u952fzEPcVnaWtiHKRyKFMhfFZ838zmDT1eFbl9N1UDRn3sz7i0/3qwtE7xCF1t8pojPmSkCKSnDxYfS81Ee9ULFhXGXgbc+gIXRme6Iu+GYxQJVGpHG4xeIO7OlFkguTpJHJzethuvrkT/FVPThb7+fp7iQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxDDrgRyqnfcIFvv/zxemAPl3FIWMUTk56DRJh84pLM=;
 b=Zy0SaH8ev33ZAHO+IJVOqLX5yZlz0ZZ4RJOtMt0oNVcTp1FfxsUBalEN7SOAmGWEsVyhNSa0ovqEfLP4j5Fc7mCh4RAv9iuLI53HRNQEoPTTVyODqO3Qdk0VOWsus0D2eqC6qjMjkb9oMfF8vvPfZH0DCuusrbvkEydDYPm+v+7w/VkoxlslmGWiJWqFV3Ey6VVcBjKr5TlZyQPesr0eul98mUgxxqe1ueY+jRgLmPf5zN/dP6m96i0HiwvMeNF+CvzdnZ+2dqc8f4CLa1T9/bWAVNQmw8FlIo+0RTINAW/D29o46uyKoSacDU5kYCcnQefdM6gxSUBxWIm3s6ooyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxDDrgRyqnfcIFvv/zxemAPl3FIWMUTk56DRJh84pLM=;
 b=a6hfdWpR19tdvTt7q0qjcMDoBVIx++Rp0rnfv1wSdIF1SqPle0NbSKEsiodSZ/DH/w+qAb05Foj8l7lcRLlNXKs4vLaeYMxT+kYfXiqNNLHNU+fBhtEEUn1p0BK6VB/IeEaXG+Uyfu1TyYqIGF5Z71TBkfyqHouMMIWA8jdpscc=
Received: from MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::18)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 23 Nov
 2021 08:46:26 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::bd) by MW4P223CA0013.outlook.office365.com
 (2603:10b6:303:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 23 Nov 2021 08:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 08:46:25 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 02:46:21 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <acme@kernel.org>
CC:     <santosh.shukla@amd.com>, <ravi.bangoria@amd.com>,
        <ananth.narayan@amd.com>, <kim.phillips@amd.com>,
        <rrichter@amd.com>, <linux-perf-users@vger.kernel.org>,
        <jolsa@redhat.com>, <kjain@linux.ibm.com>
Subject: [PATCH v3 1/2] perf/docs: Add info on AMD raw event encoding
Date:   Tue, 23 Nov 2021 14:16:12 +0530
Message-ID: <20211123084613.243792-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 733b937b-d17c-4b05-8505-08d9ae5dbbe4
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54605A0B1D4EA8DA8E3E8FA28B609@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGLkJsaL9pVTUUdlVkenvzZtrUyUmrdXXui23Qc1oI9GpLBy+OAkDTFTwiJNjLQeNqJdiGRM5lVfRWeqBYBOlE8HYrkWHZzRAtqdf2TL30mbFWu/+9VZubh9NGhySEJZhcZ+utu3Vc+D8JKejGUB9R/3C4Gshl/H9BXCVLVkfrgjz59Sb74gIi0BBn3Tl7nj093Ze9o62Lmtyd6jhXQDxxRRYFsfq/Gbd7IomDQMXLaxYIaiXYTotNf74jlJEg8O/f+mW57wsqgi5WQ+ucdRs7rqbojSAhEaymYqD08bvTRM3QiHbigoBbmdDk94Rx5Cc4rD3PH6KWQR1bKhjzX+//jt/oGeG/TBjz0cHyzW7OeiHf5ZcdEwHZLNVJgtgKz94wzQ2AQEXt88wH1P7hQ19oaqqoEY7GveYOo0v6phVkUFyp53KETlUyjgPtVxXbDlt9aFJ2l0Us13kmf7YliK9tpyurkLsW7ISo/aAsPTCKNSr2SzkSGWiExtnAO3a2e+LaZ/ixyQX2FOm84S5fDfIm40Vqgb+5qbvoNTt+CRPpHxpzJThvjkqOnp/xP+Y0E/E8JBt3Xx6ZpiN7k8pdXKa+VatDfY30XlIBqU6MUfc0vUS9QZDJZ+86PSfnd2+/GO9HYzm2HNPSdA4tewxQyHSclLJ+TG/SvNuDn+mstk/PrpKtWDcLqN4C9BfaV7WWnWF0unibQlqyTQaE/05nLzi8nYCHQqxa6IJAdsRYHTD9JrDIPA4hAjDv1ovYLTDIAjyUztaAd22+UGMnYhbihvDn/gJHeCGVdPrDimMUkgO0MeIGPy9T8wfA7VeeUMohyIkACA6lal1EBub2dHxVMV2s3z3iqk+QtmbV6YJHQSYWE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(70586007)(47076005)(508600001)(70206006)(1076003)(8936002)(966005)(2616005)(7696005)(8676002)(36860700001)(6916009)(426003)(54906003)(26005)(186003)(44832011)(336012)(6666004)(2906002)(81166007)(86362001)(83380400001)(16526019)(316002)(356005)(4326008)(82310400004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 08:46:25.5573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733b937b-d17c-4b05-8505-08d9ae5dbbe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

AMD processors have events with event select codes and unit
masks larger than a byte. The core PMU, for example, uses
12-bit event select codes split between bits 0-7 and 32-35
of the PERF_CTL MSRs as can be seen from
/sys/bus/event_sources/devices/cpu/format/*.

The Processor Programming Reference (PPR) lists the event
codes as unified 12-bit hexadecimal values instead and the
split between the bits is not apparent to someone who is
not aware of the layout of the PERF_CTL MSRs.

8-bit event select codes continue to work as the layout
matches that of the PERF_CTL MSRs i.e. bits 0-7 for event
select and 8-15 for unit mask.

This adds more details in the perf man pages about using
/sys/bus/event_sources/devices/*/format/* for determining
the correct raw event encoding scheme.

E.g. the "op_cache_hit_miss.op_cache_hit" event with code
0x28f and umask 0x03 can be programmed using its symbolic
name as:

  $ sudo perf --debug perf-event-open stat -e op_cache_hit_miss.op_cache_hit sleep 1
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             128
    config                           0x20000038f
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------
  [...]

One might use a simple eventsel+umask combination based on
what the current man pages say and incorrectly program the
event as:

  $ sudo perf --debug perf-event-open stat -e r0328f sleep 1
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             128
    config                           0x328f
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------
  [...]

When it should have been based on the format from sysfs:

  $ cat /sys/bus/event_source/devices/cpu/format/event
  config:0-7,32-35

  $ sudo perf --debug perf-event-open stat -e r20000038f sleep 1
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             128
    config                           0x20000038f
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------
  [...]

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
v1: https://lore.kernel.org/linux-perf-users/20211119111234.170726-1-sandipan.das@amd.com/
v2: https://lore.kernel.org/linux-perf-users/20211123065104.236717-1-sandipan.das@amd.com/

v3:
- Mention why simple eventsel+umask combinations will not
  work in the commit message.

---
 tools/perf/Documentation/perf-list.txt   | 34 +++++++++++++++++++++++-
 tools/perf/Documentation/perf-record.txt |  6 +++--
 tools/perf/Documentation/perf-stat.txt   |  6 +++--
 tools/perf/Documentation/perf-top.txt    |  7 ++---
 4 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 4dc8d0af19df..a922a95289a9 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -94,7 +94,7 @@ RAW HARDWARE EVENT DESCRIPTOR
 Even when an event is not available in a symbolic form within perf right now,
 it can be encoded in a per processor specific way.
 
-For instance For x86 CPUs NNN represents the raw register encoding with the
+For instance on x86 CPUs, N is a hexadecimal value that represents the raw register encoding with the
 layout of IA32_PERFEVTSELx MSRs (see [Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3B: System Programming Guide] Figure 30-1 Layout
 of IA32_PERFEVTSELx MSRs) or AMD's PerfEvtSeln (see [AMD64 Architecture Programmer’s Manual Volume 2: System Programming], Page 344,
 Figure 13-7 Performance Event-Select Register (PerfEvtSeln)).
@@ -126,6 +126,38 @@ It's also possible to use pmu syntax:
  perf record -e cpu/r1a8/ ...
  perf record -e cpu/r0x1a8/ ...
 
+Some processors, like those from AMD, support event codes and unit masks
+larger than a byte. In such cases, the bits corresponding to the event
+configuration parameters can be seen with:
+
+  cat /sys/bus/event_source/devices/<pmu>/format/<config>
+
+Example:
+
+If the AMD docs for an EPYC 7713 processor describe an event as:
+
+  Event  Umask  Event Mask
+  Num.   Value  Mnemonic                        Description
+
+  28FH     03H  op_cache_hit_miss.op_cache_hit  Counts Op Cache micro-tag
+                                                hit events.
+
+raw encoding of 0x0328F cannot be used since the upper nibble of the
+EventSelect bits have to be specified via bits 32-35 as can be seen with:
+
+  cat /sys/bus/event_source/devices/cpu/format/event
+
+raw encoding of 0x20000038F should be used instead:
+
+ perf stat -e r20000038f -a sleep 1
+ perf record -e r20000038f ...
+
+It's also possible to use pmu syntax:
+
+ perf record -e r20000038f -a sleep 1
+ perf record -e cpu/r20000038f/ ...
+ perf record -e cpu/r0x20000038f/ ...
+
 You should refer to the processor specific documentation for getting these
 details. Some of them are referenced in the SEE ALSO section below.
 
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 3cf7bac67239..55df7b073a55 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -30,8 +30,10 @@ OPTIONS
 
         - a symbolic event name	(use 'perf list' to list all events)
 
-        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
-	  hexadecimal event descriptor.
+        - a raw PMU event in the form of rN where N is a hexadecimal value
+          that represents the raw register encoding with the layout of the
+          event control registers as described by entries in
+          /sys/bus/event_sources/devices/cpu/format/*.
 
         - a symbolic or raw PMU event followed by an optional colon
 	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 7e6fb7cbc0f4..604e6f2301ea 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -36,8 +36,10 @@ report::
 
 	- a symbolic event name (use 'perf list' to list all events)
 
-	- a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
-	  hexadecimal event descriptor.
+	- a raw PMU event in the form of rN where N is a hexadecimal value
+	  that represents the raw register encoding with the layout of the
+	  event control registers as described by entries in
+	  /sys/bus/event_sources/devices/cpu/format/*.
 
         - a symbolic or raw PMU event followed by an optional colon
 	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 9898a32b8d9c..cac3dfbee7d8 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -38,9 +38,10 @@ Default is to monitor all CPUS.
 -e <event>::
 --event=<event>::
 	Select the PMU event. Selection can be a symbolic event name
-	(use 'perf list' to list all events) or a raw PMU
-	event (eventsel+umask) in the form of rNNN where NNN is a
-	hexadecimal event descriptor.
+	(use 'perf list' to list all events) or a raw PMU event in the form
+	of rN where N is a hexadecimal value that represents the raw register
+	encoding with the layout of the event control registers as described
+	by entries in /sys/bus/event_sources/devices/cpu/format/*.
 
 -E <entries>::
 --entries=<entries>::
-- 
2.30.2

