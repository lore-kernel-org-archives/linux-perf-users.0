Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E520C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 21:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EA061154
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 21:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhJDVnh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 17:43:37 -0400
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:8577
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236686AbhJDVng (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Oct 2021 17:43:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obH2qTapiAECRsez7bSmas8ku4ex2bv26Y8H03pJVaYUuzwnDSxrHPlUHAMpX8qqDXQEZ+LqhYZODz/kRrbRkRaNW4MvvAtLu7zptj7Ukpman+AzsXZvGaSMwrpXoft+8/ynBtDnyO2qv4uD48g2lmBsrITKBaJNCgyi7rmf11S6dXMaGmrkx2068B8xjhyJ7Dz3vKrzZe6UzA+zrc57dEMLqjDa8wqVEtDev8KQP5qOkyiFz5w/20gort6C/+z/Xhwn/UZ6p33QX7D5RUMadlNaJO1oL9bL18Ixd4DEfdatmN2OF/PdIhWkUHTfQM8l8eA7tyJ5Vs4DGcc6vYP+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRmCtBDlFvX1x/oke4PPNiF9MrTEOCM/UU/r2y5vre8=;
 b=ZQen5oYEqZA+yiYPyBZ84sk2XesfSQx4iMenFbI1KAwgt9vcFk94g9/hJosgQ0XcFBrOsPBpyI/uWYfQ1/yg+iUeVQWpAaxlMM936IYTJCRhaM8FQ+0RBgPyFqBfbwQ8pq2VGqLjCqSHpdDiDWlKRmLxeAQNXmkOZBCOnC+q5dQr9kbnrfAVm/KhcCz/UzRPIlMkclP5+EBSu0uAYLFFcQJTQpo4g+dNX8KJs4u88+CIaOCMfHq3AV/A63k3JMRncWM89r4Qv0Pzf02J7SsaV4h1y+4HeLsXB6W4XJj8R429Eg6Adefzl4fH8g/Jr+d7jI0pyjwaK7w4ozzrl4RrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRmCtBDlFvX1x/oke4PPNiF9MrTEOCM/UU/r2y5vre8=;
 b=1jJ/aoAUb1X71jUYLwcEqlrsX6aMAvpztgcH12PjBuUpsyOemOeXkD2Nr3rwmqnoxz2oFpJOPr0qabFh2PuHb+0rbVEJuDa/ppZ02lRlu37nYmngkxM++QREhn8rhLDBG7Dix8bH8GyRV8wwlcjDJlTgrBGRiq5oNWYaFSDLbdY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN7PR12MB2772.namprd12.prod.outlook.com (2603:10b6:408:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 21:41:45 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 21:41:45 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/2] perf tools: Improve IBS error handling
Date:   Mon,  4 Oct 2021 16:41:14 -0500
Message-Id: <20211004214114.188477-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211004214114.188477-1-kim.phillips@amd.com>
References: <20211004214114.188477-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::11) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from fritz.amd.com (165.204.77.1) by SN7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 21:41:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79709a7d-4914-47cf-b995-08d9877fc2c7
X-MS-TrafficTypeDiagnostic: BN7PR12MB2772:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2772A8DA6CCF40ED24AE842C87AE9@BN7PR12MB2772.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjKuMhtJ9GMgrzHx6GhL0TR3M5BKVHKnE7MHNbspnJ/YmNsjJyuFEyD4zVRMHvrCgxKSgu9Lly21iFqK2JpQZSa5L5YAfwNCbU3KcgpwnfJlhueQ8BykHjDf6dcYLK8NucrOTAgrYEz0Xmaeggc4VDH9hYliMN1Ohku/FPUXl+6plH1qHUInBNx4BkjnbaUZTXGzxRK9pAw33bBIlOTzEHyfC4J2WV26rgZ5WMxFypqxhfGIgf39jvlHK1fKXqEqAnPi0qSRY3QanUYo6yDO8boMlnknKGdLfgVFH4txlR9lEsUla+84s9PJDRxRV2sa6Z8abhtgOql4gp8eGkIYSTCJfmx6iGF8FfqgewlwWgMmeFpWIu+2nLXpiUW8V1Uwk2apCXpS7t4+ia3Yxt7vMh+noFROZ4u3TlEuFjZqXsZjqAmCgsSTXngZlhAUzoxdJla796236LmbK0jSaoZstA/BrPf3yRAaqWKNkwBKdbMGQB0dHETw29qX8R4HqsUb4w1Ce1H82iq3UcqnZ/Jk3+Ih47G49L4T0SP72rhsWKgtDGMRbp0GO6ff9W7YBKriMuM4s/BkVI+0JBTW+jLXaNaWR2gQYrIa+3TEKUyzkypLWmr6phqDLi/sGNONGG+UThgeCi4lNkNSEufCkvpgBZVdSjr6IUtbE2JFPpUU9/7pgqOVLkpwU296rSjkgkvWrSjaY/sN9+hnGSUehxcudg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(8676002)(44832011)(86362001)(52116002)(26005)(66946007)(66476007)(66556008)(508600001)(7696005)(7416002)(6486002)(38100700002)(316002)(6666004)(1076003)(5660300002)(956004)(2616005)(38350700002)(83380400001)(36756003)(4326008)(2906002)(54906003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgYq4JsjW1Hsbf+uByH1QaHihoEGND8uZvW/hzRX2VeupqsyEfeTYkOkfYLB?=
 =?us-ascii?Q?ckiiuLPtwiKhgfeelzEtP84TwFRmeP6IUdxVgCKrjvzOW5Pduo3YlXftC7CM?=
 =?us-ascii?Q?j5/H36C1YyuDoWGDzWppRBp20WrSMfhIjTrabPIDaDQZAwNhKprR/xunwVzG?=
 =?us-ascii?Q?baA97dMg+Kc65CjB00mtU0EkYNOterhxzvfRi8ilfD/2vw61KxNHPcNki7Kp?=
 =?us-ascii?Q?o6zbZHIn898sRrM5e1B6E1KeB/8neh3fbkLFXITqklW5npBuKnzee/RffJ9y?=
 =?us-ascii?Q?jffPaiiaADZCEnn4Q1oyOlfyHdzNGYFPcas09JUmw9hxsY6p0GDmtiy4piYn?=
 =?us-ascii?Q?W3aA8b8lJWm7EpBHvqqpeTpgLpsH8XeRWm3Vnb7ZQ8fhgXD0zPPx42j4UgqW?=
 =?us-ascii?Q?6FB5APIqTl7KnuDWeWH+62wDPdsTvIXXx6+73z7kmtlKx9Gw+oAHkuTwm47B?=
 =?us-ascii?Q?1g0o1yIvVm4l/F8vF7v2KMglbtS+dmlUAft0k0OyhMh69dyIThf01iDl8wSn?=
 =?us-ascii?Q?336NZ8VO3hq5U9f6K8UI6m7ZlOT2IJ6RBhRbIN3m+KeX1AEAMLlfMINAOBBl?=
 =?us-ascii?Q?taIsl2Otvt30Ek3IOR24gN1HdDapmgtkfse3AL757yqvle6A5xR3mHhox+xb?=
 =?us-ascii?Q?5443woc4xyMN8zruUHeRTLJhsQhu3SuooWxK9qec20s6tPh9hElLvGZ7Kf1g?=
 =?us-ascii?Q?lIke3M9aZdnRPT/lCJkBA9W60lxb89AKZbH0kNbbOhvlQzF0qXdApu2/oDmt?=
 =?us-ascii?Q?Ze8A7aQTAwyYk0uwmQ1YWiWGwNPQmD7vQzURt1Za9QsdejT1qWr0wSGo8Rv1?=
 =?us-ascii?Q?3aTWSN8H6FfcOgRZB6kt62DNm8BwzzNlQFMHIpgBiFBjDvnM/XxNbCkZLbrU?=
 =?us-ascii?Q?AdoaCtlZsOSSFa9r/Q99IEX2Vpbw3GWc9SUiyGQmME7M31dhYrR5iOJYH75d?=
 =?us-ascii?Q?Xmg3O8qksjyZI37RywXpwUcN4ZTcBz5TRbmY0CWKOcTNDY35bZClzerMx+Lt?=
 =?us-ascii?Q?wkdlbqMAWIK8pOL//uPT09i3KfXRn4MpU74FGfSCJ+ezEnG1S04oecNe77XU?=
 =?us-ascii?Q?olaNwHX7wlOR0iXoeiBkxi5VssrXWic939fjaA6JhZ1FX1hmJTZUCTL3QkjO?=
 =?us-ascii?Q?gQeiOPkgtMA9dyIA5ZGKtGTcnU+mCQvLYx+kF5JD3f9mRojX/lFtvPRsiCl5?=
 =?us-ascii?Q?z80IhjzCt06DNcQ22oY+bvgmFYyhN0V+qPkHHIfS7+5iq1cZ1F88IbtivZyb?=
 =?us-ascii?Q?lmwTtn7K5goIQT4aBfLoG+7rd7DFP0BgZDIBm2OirtCQeG8Nf0QxnUKFnVwb?=
 =?us-ascii?Q?+iWCA8pcknz51Mz3V6C+IDO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79709a7d-4914-47cf-b995-08d9877fc2c7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 21:41:44.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uk/jL7sdzctHI9W+zMfShEouYKcH+ON1X+W8usF5fcNgAT9DujwxEQur3CpJ+H9oWnf3clKfgIEmyAB9DU1BuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2772
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch improves the error message returned on failed
perf_event_open() on AMD when using IBS.

Output of executing 'perf record -e ibs_op// true' BEFORE this patch:

The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//u).
/bin/dmesg | grep -i perf may provide additional information.

Output after:

AMD IBS can't exclude kernel events.  Try running at a higher privilege level.

Output of executing 'sudo perf record -e ibs_op// true' BEFORE this patch:

Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (ibs_op//).
/bin/dmesg | grep -i perf may provide additional information.

Output after:

Error:
AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b915840690d4..f8a9cbd99314 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
+static bool is_amd(const char *arch, const char *cpuid)
+{
+	return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
+}
+
+static bool is_amd_ibs(struct evsel *evsel)
+{
+	return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
+}
+
 int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 int err, char *msg, size_t size)
 {
+	struct perf_env *env = evsel__env(evsel);
+	const char *arch = perf_env__arch(env);
+	const char *cpuid = perf_env__cpuid(env);
 	char sbuf[STRERR_BUFSIZE];
 	int printed = 0, enforced = 0;
 
@@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
+		if (is_amd(arch, cpuid)) {
+			if (is_amd_ibs(evsel)) {
+				if (evsel->core.attr.exclude_kernel)
+					return scnprintf(msg, size, 
+	"AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
+				if (!evsel->core.system_wide)
+					return scnprintf(msg, size,
+	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
+			}
+		}
+
 		break;
 	case ENODATA:
 		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
-- 
2.31.1

