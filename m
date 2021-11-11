Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A1C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 12:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CC6611CE
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 12:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhKKM7x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 07:59:53 -0500
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com ([40.107.92.65]:20065
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231739AbhKKM7w (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 07:59:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8lMPGN4nufkGiC9wb1Mx1v51inZJSirai92yoG5hYKpRcb60BNqzYFheWSSa059FQxewNwxyetIQ7/kuPPVR8Rhdg1ue5Tl9iue1ULl90LyMveUcpkTjsVgc2xA+ySRnheTX3Gqn9PFP7k2MtL4ygr7sZZjUrPq/l6Buch3od1gND1z33ay+vPK4bUbbjPAzDXHdRQxXtEVm7qtUu14AtPjtzZ/kT2OVh9yY1fbODf+/Puepn9dVZ+zLz0W890RWLOm002d/jV9+r8WZCFlzP/eWgwsl3fuceiuldmZsFyg1T25rjrrenBNl3/ctZftkhkOUOZs4TDiHrsOvBhYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWFnNZKtVDPyA1GyXuX5j3l5TgvChuKwY3mrbFDkKhI=;
 b=fEc3zMyEYoZ9nta6XfaF5zHb/aw2fHEEHX4U7w8+9cul3/ggBge8ENlzLXWr2NrDJNvpXgMDjXFf4FLdrmJu6JQSxFZxeUh7Ve+4G/SsKO4k3ynqv6Fyt9vJI74c6YhSqySIFoD8HuD6GJMnE6V4vQfdZ+w+lKu/ZuQW8M4s+tSVyJ/KX+VAdX23xWGX2i9EGW6Rcex+8SJOiGVXJHDO73ngvJR95xQpn4uLPbGgVWrsQBQBuK/HePTQvN2atEJPwCjvCOyiezE1nRAFn4LwS7gtflnfWl9Vn7904mXWqdhwHV/Su9U/3HWoxranTZKIkmVjGPfsaPfhG7OAx0CdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWFnNZKtVDPyA1GyXuX5j3l5TgvChuKwY3mrbFDkKhI=;
 b=roUaPjBP18L4BFHJINTsJwKpoHMLuRGmDgGLl4QBaT8hjrsbyE7TcSDHt57sVGyn3l3PYmCn/wzB/sThHBSmya/YzOou6M7wZwsOHQPbJS5l3Sf+iPCqHFBH9GT4j9BaXLbz1w3w9xaeWoYBQdttOFYTPbGxOQzduK9mDqnrayg=
Received: from BN6PR21CA0007.namprd21.prod.outlook.com (2603:10b6:404:8e::17)
 by MN2PR12MB3789.namprd12.prod.outlook.com (2603:10b6:208:16a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 11 Nov
 2021 12:57:01 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::48) by BN6PR21CA0007.outlook.office365.com
 (2603:10b6:404:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.2 via Frontend
 Transport; Thu, 11 Nov 2021 12:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 12:57:01 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 06:56:54 -0600
From:   Sandipan Das <sandipan.das@amd.com>
To:     <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <rrichter@amd.com>,
        <linux-perf-users@vger.kernel.org>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <mark.rutland@arm.com>
Subject: [RFC PATCH] tools/perf/x86: Use alternative format for AMD raw events
Date:   Thu, 11 Nov 2021 18:26:46 +0530
Message-ID: <20211111125646.581021-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fbc0ba1-f8f2-471e-5be2-08d9a512c108
X-MS-TrafficTypeDiagnostic: MN2PR12MB3789:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37890D5330B703C43AADDB078B949@MN2PR12MB3789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZkLybFs0vea8LBo1Jg63OtSlnyL6IDi3ntOlfcRbPScvldoQL6zjWNhtpdWFhkR5Cs0xkrwTZX1l+dbahMqp+4SrY+sufilWC9bc8znO6PnaOumm+lnX2JidMDPGY2fuPVMLo9C9/aemh7aAnyzb+iDkVzGRrdTjmawtoi0het/qyce+LYBfx/y4VUOvmk8iXdAs9ZovaibImr3LwJ4X8k10W6p0uN2gtdF3oYzMK7p3YfN8I1Q2KBCp5IuibJ5riVwdDSty8kYoEjNlktAi9ux5XqR5mQDTiwfeIyF8WAHC1z/ovW6bNqunrNfV8h6mjkzUUFEks5WbHKomhpFdvaT37FJ1XeR9w2zVllMhAAQIqZI+EwW5oF0KxYaI3kR8HjWqnxRjX/oUPhARjIX+9OHup3d6oNg+s14YNQAoeJP8lh88ptLr2bBKj3XzDDMcAZrjjBEHlkpeHpIgT5ziHrRRtclvqy8JWjL/YtH1M4VlWAGMkXFd7YR67vP6Bwun652LqjTL4TVLxhbYPpAUQNvhKqhQ5AoHaOVGmwUjDNysFinMPqBNjiZgJ9CI7xacv+pSL0+mDr3zo+PRS1GphgaP5DQni+c5uwbNn70oRjbC6Ec9EuVKuz6/eWhJZYlR05le2y4FkQYJUxVLAT0O3fYKMX/JBMOaoiuroD2UQtXhww1EsSH+q/QTDerMweMY+VdDPe5drEVg4P2HsL0eF5VXdrWdFKP97WfWBemVNOwq/y7/jr7KZLYdSOwMOYKhplxwynQFUWqNxXXuJys7crbERRIZ6v7m43pt3O3y5dfrfFObGC1tLmWN83Jq5zq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(44832011)(8676002)(4326008)(6666004)(2616005)(82310400003)(6916009)(508600001)(36756003)(1076003)(36860700001)(70586007)(966005)(336012)(316002)(83380400001)(5660300002)(70206006)(8936002)(7696005)(54906003)(26005)(81166007)(16526019)(186003)(426003)(86362001)(47076005)(2906002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 12:57:01.2252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbc0ba1-f8f2-471e-5be2-08d9a512c108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3789
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

AMD Zen processors have events with codes that are larger
than a byte. The EventSelect bits of the PERF_CTL MSRs are
not contiguous either and that can affect usability.

E.g. the core pmu has events with 12-bit event codes.

  $ cat /sys/bus/event_source/devices/cpu/format/event
  config:0-7,32-35

  $ cat /sys/bus/event_source/devices/cpu/format/umask
  config:8-15

The perf man pages describe the raw event format as:

  "(eventsel+umask) in the form of rNNN where NNN is a
   hexadecimal event descriptor."

Assume U and E are used to represent nibbles of unit mask
and event code respectively. For basic usage, most events
are usually encoded in the UUEE format (eventsel+umask) and
it works out fine since it matches the PERF_CTL register's
EventSelect and UnitMask bits.

For the "ic_tag_hit_miss.instruction_cache_accesses" event,
which has event code 0x18e and umask 0x1f, a simple combo
of eventsel+umask in UUEEE format no longer works. Instead,
it has to be programmed as:

  $ sudo perf stat -e r100001f8e ...

Although a user might find it easier to program it in the
UUEEE format as:

  $ sudo perf stat -e r1f18e ...

This adds a quirk to convert a UUEEE format encoded raw
event to the native register format for AMD processors.
This currently works only for events targeting the core
PMU. The PMU type and bitfield positions are hard-coded
right now although they should ideally be dervied from
perf_pmu_format structs.

The UUEEE format comes with some issues though.

  [1] Enabling edge-detect (bit 18 in PERF_CTL) is not
      possible since bits 19:16 are being used to specify
      the upper nibble of umask instead. Other settings
      like OS/User mode capture (bits 17:16) are unaffected
      as they are set via exclude_{user,kernel} and not via
      config within perf_event_attr. For pmu syntax, it is
      still possible to set this with "edge=1".

  [2] There is no way to distinguish between UEEE and UUEE
      and it will be assumed to be UEEE in such cases. To
      use events which could originally be programmed as
      UUEE, one has to use UU0EE instead. Alternatively,
      with some minor tweaks, UUEE can be the preferred
      format but then events with 4-bit umask and 12-bit
      event code i.e. UEEE will break unless specified
      in Exxxx0UEE format.

The effect of the changes introduced here can be seen below.
All data was captured on a system with an AMD EPYC 7713
processor.

Before:

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

After:

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

  $ sudo perf --debug perf-event-open stat -e r1f18e sleep 1
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

It is understandable that raw events must follow the native
PERF_CTL register format but it is worthwhile to pursue such
alternative formats for usability?

UUEEE is something that works for the core pmu events. Data
fabric events have a 14-bit EventSelect field and will need
more work.

  $ cat /sys/bus/event_source/devices/amd_df/format/event
  config:0-7,32-35,59-60

More details on registers and events can be found in the
AMD Processor Programming Reference (PPR). The one relevant
to the EPYC 7713 processor used here can be found at:

https://bugzilla.kernel.org/attachment.cgi?id=296015

Infomration on PERF_CTL MSRs start at page 185 and PMU
events start at page 445.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/arch/x86/util/Build          |  1 +
 tools/perf/arch/x86/util/parse-events.c | 54 +++++++++++++++++++++++++
 tools/perf/util/parse-events.c          | 13 ++++++
 tools/perf/util/parse-events.h          |  4 ++
 4 files changed, 72 insertions(+)
 create mode 100644 tools/perf/arch/x86/util/parse-events.c

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index dbeb04cb336e..c6bddc5eea88 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -10,6 +10,7 @@ perf-y += evlist.o
 perf-y += mem-events.o
 perf-y += evsel.o
 perf-y += iostat.o
+perf-y += parse-events.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/parse-events.c b/tools/perf/arch/x86/util/parse-events.c
new file mode 100644
index 000000000000..d06e833c6d44
--- /dev/null
+++ b/tools/perf/arch/x86/util/parse-events.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/string.h>
+#include "util/env.h"
+#include "util/evlist.h"
+#include "util/parse-events.h"
+
+void arch_parse_events_fixup_raw(struct parse_events_state *parse_state,
+				 int type,
+				 struct perf_event_attr *attr)
+{
+	struct perf_env *env = parse_state->evlist->env;
+
+	/*
+	 * AMD Zen processors can have event codes and unit masks larger than
+	 * a byte; transform attr->config to resemble the PERF_CTLx registers
+	 */
+	if (strstarts(perf_env__cpuid(env), "AuthenticAMD")) {
+		switch (type) {
+		case 4:	/* cpu */
+		{
+			u64 event = attr->config & 0xfff;
+			u64 umask = attr->config & 0xff000;
+
+			/*
+			 * Skip in case of ExxxxxxUUEE, UUEE, EE and E formats
+			 * Choose UEEE over UUEE, use UU0EE instead for latter
+			 * Choose UUEEE over edge+UUEE, if desired edge-detect
+			 * can be set via pmu syntax with "edge=1"
+			 */
+			if (attr->config > 0xfffff || attr->config < 0x100)
+				return;
+
+			/*
+			 * Choose EEE over UEE format, use U0EE instead for
+			 * latter and if desired unit mask can be set via pmu
+			 * syntax with "umask=..."
+			 */
+			if (attr->config > 0xff && attr->config < 0x1000)
+				umask = 0;
+
+			/*
+			 * Move the upper nibble of the EventSelect field from
+			 * bits 19:16 to bits 35:32 and shift the Umask field
+			 * right by a nibble.
+			 */
+			attr->config = ((event & 0xf00) << 24) | (umask >> 4) | (event & 0xff);
+			break;
+		}
+
+		default:
+			return;
+		}
+	}
+}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5bfb6f892489..7179ed39d757 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1437,6 +1437,9 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 	attr.type = type;
 	attr.config = config;
 
+	if (attr.type == PERF_TYPE_RAW && attr.config)
+		arch_parse_events_fixup_raw(parse_state, attr.type, &attr);
+
 	if (head_config) {
 		if (config_attr(&attr, head_config, parse_state->error,
 				config_term_common))
@@ -1608,6 +1611,10 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		return 0;
 	}
 
+	/* For raw pmu events, attr->config is already set at this point */
+	if (attr.config)
+		arch_parse_events_fixup_raw(parse_state, pmu->type, &attr);
+
 	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
 		free_config_terms(&config_terms);
 		return -EINVAL;
@@ -3402,3 +3409,9 @@ struct evsel *parse_events__add_event_hybrid(struct list_head *list, int *idx,
 			   pmu, config_terms, /*auto_merge_stats=*/false,
 			   /*cpu_list=*/NULL);
 }
+
+void __weak arch_parse_events_fixup_raw(struct parse_events_state *parse_state __maybe_unused,
+					int type __maybe_unused,
+					struct perf_event_attr *attr __maybe_unused)
+{
+}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index c7fc93f54577..1f183903c586 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -218,6 +218,10 @@ void parse_events_update_lists(struct list_head *list_event,
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
 
+void arch_parse_events_fixup_raw(struct parse_events_state *parse_state,
+				 int type,
+				 struct perf_event_attr *attr);
+
 void print_events(const char *event_glob, bool name_only, bool quiet,
 		  bool long_desc, bool details_flag, bool deprecated,
 		  const char *pmu_name);
-- 
2.30.2

