Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC49C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 06:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhKWGy3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 01:54:29 -0500
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:10885
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229728AbhKWGy0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 01:54:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OndMIFuhJYZQEU/HerLY+E0kDKuQx6XV4EXdlgJh3WDSuK00KgiwSlSJ6tzsctw+MJCpFbw1iEYxpeTeTLLCeZsfXb5TOVGEq5yLrtR+3fZURgWW+X9nkSf/jMUtAYFMW4dffHmbeTDXvjHTByzlZjidcKphOiAclI0dl0e4P0srSojkg1ieZZR0kbR5wHvhyc4q35i9KOZODn4MuqPN36yuoLJ8PRwGNT9R+e5qej371I5cg1bp8lxWvOEXwkTRNJtcXQdSC0sgvj0Zk26mJH6JLZ4ymL/kLwVAqisJA40M3wIddW9qsd1Kz+792wW3q17iq9syY1gvxE05oX6BxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0a08nJebhPz1dpeTZAK6NlEgDly6Wp2mbi3ndr8i/8=;
 b=GfsCG4Ha3sslfm1ex9INrQanJJL4Oalyft3FfUQRJsq51SrYB+52JWKbrqNyMhkOpuSfPf9xRhYkKmAVby8ZnGc2GsEGA0komiwrFJBQtJ2qZ0uxSLOofeFcMdMvgRmM8DaN9C79Pa7pB3316GjTiTuANcdrIbri6n++0TXDFefgMEHdkN0bTtRq3GDApv+DeNe1veUFEEoYFyvS/5T5gRsb2Ti43UFYZOeTZr50PB7/PE87b0goPUTg6FFS/lDHZJb44wTkVCC5HGStlrLuUzbvTCD+b87SFPqt0yK9MyazyW24SzLoSZBSEEuWmIiCBt9FVAv6/+bMe3RSb0fGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0a08nJebhPz1dpeTZAK6NlEgDly6Wp2mbi3ndr8i/8=;
 b=wKHVb3qAIQ1vH6npMGbD343Gvb7TjXZaooSggRicg0BVozLUhYsq3qhBjdEDwU5p5sX78daK0Wn927VGOg3uK5utEhr0DvnvuQdWpN1+8oCGP0VUlEf6sTHlEjnuI0WI1utRi8Gw9UUs3fNZ9/mVvUbf25/8o233LbiYoyRsqCk=
Received: from BN7PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:20::26)
 by MN2PR12MB4608.namprd12.prod.outlook.com (2603:10b6:208:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 06:51:16 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::21) by BN7PR02CA0013.outlook.office365.com
 (2603:10b6:408:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Tue, 23 Nov 2021 06:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Tue, 23 Nov 2021 06:51:16 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 00:51:12 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <acme@kernel.org>
CC:     <santosh.shukla@amd.com>, <ravi.bangoria@amd.com>,
        <ananth.narayan@amd.com>, <kim.phillips@amd.com>,
        <rrichter@amd.com>, <linux-perf-users@vger.kernel.org>,
        <jolsa@redhat.com>, <kjain@linux.ibm.com>
Subject: [PATCH v2 1/2] perf/docs: Add info on AMD raw event encoding
Date:   Tue, 23 Nov 2021 12:21:03 +0530
Message-ID: <20211123065104.236717-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 355e2be8-9361-480f-8817-08d9ae4da5a2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4608:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4608397A53E130D5F278A4918B609@MN2PR12MB4608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdIKxECES/9ytTa/9ImMeM1XoEVGWXEGEFkCCdnzv4K4WDUiYr9IzCc3qgsoGtceC+q0HZzweX09ULfIn264ML7ZgmtplSAYfgDHz8N8TKGCFM1l9rMb0279S2uTa8gfDyEJAgtm8naxjLN4ijU7GEteORGyCWd8B9sfoytOHoK8CCwEF+9WTAxCkx9xiHECdoVYnRH8OErtwXsAK+m+yO69mR0ArsT69dndcKVMxqaoOISteDuJkZmfqiMUwNnVJ/3pPWlbOrhHIo89xZ3113Q0Rd8LtzhA3EkV9+SKL75g0UE3T7DQDDZ+lS7cPjb4g7cJ0VnDg/rCXj/5P20SY6DQbuhlZaGiU8kQm8F8DAzsz1wM0Uw5N7Kb2DwMIkolxNFc5OFontCNducA4gRn6USa6AWOBjE9R+gV10A5lh+66L58JtSrGeNKcCvuUY4FoxePvrqLSPpJyLD+2JLrJC1bNTThY9bHeiLmHNSmK9JDrMdpi3d01s7IWLAWROI5qMauvA8tfC1m3jMVWPjfKp6xlTm0Zy2raHQHGaz/smQiQJiMYddjBUcbFi9mIu0cv57fZXJz6cCC/Wne/s6DW9ff6s1a9H3e40eD0/2alebcbFbvN/15mEqEUDEvhWnNKzw+ZeASvT4HE5YYp2cx693wO2jTXQBUZm422hcvyu++FZQy2gdJuqNWJbzT2r1WFCXMnhE+dXTEWbAM7qWZ6pftOAIe7Bp0kvsjoodPL2PF0/CEkuh5IIEtzk5vNuxF3aKhAtNX0IOtO+AJPBb0iRxLNuujQkj7LD+vmX4NeS1aQYPMC//OZmu4I+g3fH6S
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(26005)(4326008)(7696005)(508600001)(36756003)(186003)(44832011)(83380400001)(8936002)(426003)(36860700001)(16526019)(2616005)(81166007)(336012)(8676002)(1076003)(2906002)(316002)(54906003)(47076005)(86362001)(6916009)(966005)(70206006)(356005)(70586007)(6666004)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 06:51:16.3803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355e2be8-9361-480f-8817-08d9ae4da5a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4608
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

In raw format, it may be programmed incorrectly as:

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

v2:
- Use the "op_cache_hit_miss.op_cache_hit" event as an
  example since the event select and unit mask nibbles
  are all different.

- Refer to sysfs files for cpu pmu when describing the
  "rN" notation.

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

