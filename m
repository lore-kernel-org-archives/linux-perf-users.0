Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD59C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F14560F9B
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhKSLPu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:15:50 -0500
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:40929
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232004AbhKSLPu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Nov 2021 06:15:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B71HkPx0mOhk1nWR4ECbIcjgmt8ngD5vLyLXnZVMQeBkmTH/QQT6mbQ7SkrJz/wUC2QN1Wm/BInG6nkyeqNgkIOGrdSCva3MCsgkTuNGTovMSO+UGfBKB4z+fVnm+Z2OoFPJJDNCG3ofNnpG3lzWE8+Nt3ZIGFq53wmupeO0P5kXbPcT1P+vBDMI01QqHAm35OvdlaTgY6Acz1xFyQzQB4wIivdfg/NW3v3VnC6NgftfJu47TvJ2Y2jjNytEK68qS45KR1E/hiPmUvIu2oHOt0O02Fodv3C9jP0rMRiUw2ZkGACRyNZpJo9CayvQUmaLzwIE6+LZKJuSiExY29xL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IellHVAKutcgUqJTqWYnePIJwB2tiSzNGDOuVt+IZoE=;
 b=Qz1qe73Ontu3vhKKSCiQ8U7aPGl02abZJ7VN2IbmiYhdjL11BS2lj9vTxNnty2N27zcLIoWNko/U9jCYjce7Q+/U5ya1Iw1Aw5QUrD169+0aLx/cLALeivRxfiZRoMNCjID7AuZ9NrM0fQy4JhYy1KuY1hxJ5FebF4JqdQtGiyAP0xV9Xs0tqo8O2Zj535f0mYNY2c1Hdjt9MwIeDmNaDX2V6ajKm50jyb6OjUQg0TFTiIux2kHRcELLvxJt15T87zjaMuiDY62ZAPY4bjUOg0NMMTBx3YW4Vs1K3KX/L4Su/LLwMp7tjgHmvL6h1Gp/wm43GNiOFeiv2GIE/UKKFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IellHVAKutcgUqJTqWYnePIJwB2tiSzNGDOuVt+IZoE=;
 b=AZ38OOvR4ApuK+VBJD71Bz36rmNN0UTcdWv+qZ2xn9dRqUjNQ1qeU1OSpXi/O0N1TMfNLNPzDsbKz1dr0/omoZ1cEp7mE+mDNMWt/4toqZNk+9vfZsUd5ZhHWb1am9tbcL0yXGaTfh5wUYQdxgGPYWGVn1sbc4vSWJmqG8KJ6ZE=
Received: from DS7PR03CA0296.namprd03.prod.outlook.com (2603:10b6:5:3ad::31)
 by CY4PR12MB1255.namprd12.prod.outlook.com (2603:10b6:903:36::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 11:12:46 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::5c) by DS7PR03CA0296.outlook.office365.com
 (2603:10b6:5:3ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 11:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 11:12:45 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 05:12:42 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <acme@kernel.org>
CC:     <santosh.shukla@amd.com>, <ravi.bangoria@amd.com>,
        <ananth.narayan@amd.com>, <kim.phillips@amd.com>,
        <rrichter@amd.com>, <linux-perf-users@vger.kernel.org>,
        <jolsa@redhat.com>, <kjain@linux.ibm.com>
Subject: [PATCH 1/2] perf/docs: Add info on AMD raw event encoding
Date:   Fri, 19 Nov 2021 16:42:33 +0530
Message-ID: <20211119111234.170726-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6be0e724-b176-4cb5-bae3-08d9ab4d83a1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1255:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1255977A4BC5E19C9610A3228B9C9@CY4PR12MB1255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0vBxABEvUhDwfai6sF8bIrB7ZuqR7boBVL02do/264bi184JfxFyH2O0Dol++xPW0L6Juqo0WPQ9EW41wvGZp21junYgtOcYyNGc5v/yobOu7/dxn5x1HW9mzBrdDAEJKufVKZiubw/OPMKw985r8Hxj/guunASLG8WZsFgx5UQwG46sZHDPF1upelgyWJQlFasCti9fcDFWCfnhj3lvzcb3fhww5MOQJV62sjhxIKfM73OjknFXly2C7WfXu/0GILxKvaDlMz2yycPpfw4wikQV6O79XfdhxSWwR3XBBTZOyh68N4oPgQSI7zewpB/CiLsW1qkyYDfxkq7uLB2BcrXYGWQ3dvlEHuqz8nynakq8KY/W8vptGMpWMUdcsVt7nvNzZoGMOifH4n4OeOZ3yTPJ6BEeb/y+brvo+J6fS9gSooDCYNx0SPpVbc6YTGZzNBcfQUXt3TOJDZOqSuOr8CTc5Mq4u800jKlWCYdobAjY5ZpKVPkHZaJgVpas+3LQcep3EwgiQ79aT87iwhyDsUq+myrrklCDCdenwkJhSswL4qTqAjyVCBwU3t+f5ovXZnZiCKYnNM1D9sKrZuwqJvvIk1FRbx5nWt9I/ndiU/yI8+FMSJos4yf4Guj0H1EfaWme7U5gT+e4Hv/6GwjwINnP82/7EqOqn4XVQhlB/vz5zPgMc/WpuQ5efbl+BM5j+Mpumnc/OJMM0RLkWvPbHhQIbMDaqjXdRc3wIOyTR0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(6916009)(2616005)(5660300002)(83380400001)(44832011)(36756003)(4326008)(26005)(54906003)(82310400003)(426003)(356005)(86362001)(8676002)(2906002)(1076003)(70586007)(6666004)(81166007)(508600001)(16526019)(186003)(7696005)(316002)(47076005)(36860700001)(8936002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 11:12:45.8092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be0e724-b176-4cb5-bae3-08d9ab4d83a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1255
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Processors from the AMD Zen family have events with event
select codes and unit masks larger than a byte. The core
PMU, for example, uses 12-bit event select codes split
between bits 0-7 and 32-35 of the PERF_CTL MSRs as can
be seen from /sys/bus/event_sources/devices/cpu/format/*.

The Processor Programming Reference (PPR) lists the event
codes as unified 12-bit hexadecimal values instead and the
split between the bits is not apparent to someone who is
not aware of the layout of the PERF_CTL MSRs.

8-bit event select codes continue to work as the layout
matches that of the PERF_CTL MSRs i.e. bits 0-7 for event
select and 8-15 for unit mask.

This adds details in the perf man pages about using
/sys/bus/event_sources/devices/*/format/* for determining
the correct raw event encoding scheme.

E.g. the "ic_tag_hit_miss.all_instruction_cache_accesses"
event with code 0x18e and umask 0x1f can be programmed
using its symbolic name as:

  $ sudo perf --debug perf-event-open stat -e ic_tag_hit_miss.all_instruction_cache_accesses sleep 1
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             128
    config                           0x100001f8e
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    enable_on_exec                   1
    exclude_guest                    1
  ------------------------------------------------------------
  [...]

In raw format, it may be programmed incorrectly as:

  $ sudo perf --debug perf-event-open stat -e r1f18e sleep 1
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             128
    config                           0x1f18e
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

  $ sudo perf --debug perf-event-open stat -e r100001f8e sleep 1
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             128
    config                           0x100001f8e
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
 tools/perf/Documentation/perf-list.txt   | 36 +++++++++++++++++++++++-
 tools/perf/Documentation/perf-record.txt |  6 ++--
 tools/perf/Documentation/perf-stat.txt   |  6 ++--
 tools/perf/Documentation/perf-top.txt    |  7 +++--
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 4dc8d0af19df..9c54c0566fda 100644
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
@@ -126,6 +126,40 @@ It's also possible to use pmu syntax:
  perf record -e cpu/r1a8/ ...
  perf record -e cpu/r0x1a8/ ...
 
+Some processors, like those from the AMD Zen family, support event codes and
+unit masks larger than a byte. In such cases, the bits corresponding to the
+event configuration parameters can be seen with:
+
+  cat /sys/bus/event_source/devices/<pmu>/format/<config>
+
+Example:
+
+If the AMD docs for an EPYC 7713 processor describe an event as:
+
+  Event  Umask  Event Mask
+  Num.   Value  Mnemonic                                        Description     Comment
+
+  18EH     1FH  ic_tag_hit_miss.all_instruction_cache_accesses  Counts various  Use umask=1f to count
+                                                                IC tag related  all instruction cache
+								hit and miss    accesses
+								events
+
+raw encoding of 0x1F18E cannot be used since the upper nibble of the
+EventSelect bits have to be specified via bits 32-35 as can be seen with:
+
+  cat /sys/bus/event_source/devices/cpu/format/event
+
+raw encoding of 0x100001F8E should be used instead:
+
+ perf stat -e r100001f8e -a sleep 1
+ perf record -e r100001f8e ...
+
+It's also possible to use pmu syntax:
+
+ perf record -e r100001f8e -a sleep 1
+ perf record -e cpu/r100001f8e/ ...
+ perf record -e cpu/r0x100001f8e/ ...
+
 You should refer to the processor specific documentation for getting these
 details. Some of them are referenced in the SEE ALSO section below.
 
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 3cf7bac67239..43d945e12d97 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -30,8 +30,10 @@ OPTIONS
 
         - a symbolic event name	(use 'perf list' to list all events)
 
-        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
-	  hexadecimal event descriptor.
+        - a raw PMU event in the form of rN where N is a hexadecimal value
+          that represents the raw register encoding with the layout of the
+          event control registers as described by entries in
+          /sys/bus/event_sources/devices/<pmu>/format/*.
 
         - a symbolic or raw PMU event followed by an optional colon
 	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 7e6fb7cbc0f4..0f279b5498e4 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -36,8 +36,10 @@ report::
 
 	- a symbolic event name (use 'perf list' to list all events)
 
-	- a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
-	  hexadecimal event descriptor.
+	- a raw PMU event in the form of rN where N is a hexadecimal value
+	  that represents the raw register encoding with the layout of the
+	  event control registers as described by entries in
+	  /sys/bus/event_sources/devices/<pmu>/format/*.
 
         - a symbolic or raw PMU event followed by an optional colon
 	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 9898a32b8d9c..21028910561f 100644
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
+	by entries in /sys/bus/event_sources/devices/<pmu>/format/*.
 
 -E <entries>::
 --entries=<entries>::
-- 
2.30.2

