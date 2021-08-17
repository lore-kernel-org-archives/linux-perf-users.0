Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD93C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D85C61038
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhHQWQD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:16:03 -0400
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:5774
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229869AbhHQWP7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:15:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joZcrQrreqvhKUu+xBY8koJa/dz/8NfQOVe6lj4GCZwbqJUvVaTx4hFM9GEVVFHyKRDfdtpL01xv9eF54kuKdGaWCsPYlgjCBytOU+XtiaX/fi/Kqfbsl/ViOjbXzW+CI6gouHw//rDhlK+jjzIy2zolRSU5kAjbK3nQQdSG/1N3dNt6hsK9f7CtCTDWHcxzYBk0Rty87vzUKuXzwWJWnH+fNSdfdgU+yvRLICyrQ8HlMqgnq3Vdzobi8uP7uUE9EwKR44AnolgFMnSGzo5U0rkydpUHmfqhYP+pFzOSJkxv/xETXMBXZduyFg156an8FiHhW0E6txrMM4HIZ6VWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umZs9KRIWZrrCR1hoTYb52PIrNNVcbQb+cIWlwQqUSI=;
 b=fidMpcTxxsDU8e+DXYMknego8hC1tJUO9HjYVhzTBv5O1lSdWrCEXkfxs0Tcn1ox1AerHEwRIjSDQCMLKNFiNYw19/Hv8IoxkOFxY1QoyFFf9G/JCWZonsNJavD/d0j10LF/YYoTK8PovA1lHx8SJTsvRJ0fnNzQN9NQ4veDFNBe4lo7PzmMj/B93oMLMqgD2VhJm2pC+eOMbJaH0zPHQgDFapGb46gP+BhwnoJy71UBGbwTBIgG7f2PpG0utm2QMg+sKY5fkukd3mK0uMsi43tNOFV6ljxp1t5rt6eg4mj3yYMYpKSzMRcvIz84b2zd4/X8uZ2Kr6lftFPPkRhkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umZs9KRIWZrrCR1hoTYb52PIrNNVcbQb+cIWlwQqUSI=;
 b=dY7o6nDxekQ0Q/BT0TWMvZ0y0P0U0PX39ouBRfQ8hkdaTEKUJJy6V5bAzyv470XKHftJdrmdJwKuU7u9+oyX0XsV5x/xrZ0zvykl1kO8MXWoHqul6kC05TJ8Ly/oYLkZai4aPAcYBlqcFNkFazdYpmqU/Qs98WsIp0Vs2Af0mGQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3090.namprd12.prod.outlook.com (2603:10b6:408:67::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 22:15:23 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:15:23 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf report: Add support to print a textual representation of IBS raw sample data
Date:   Tue, 17 Aug 2021 17:15:06 -0500
Message-Id: <20210817221509.88391-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:806:28::35) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA9PR13CA0180.namprd13.prod.outlook.com (2603:10b6:806:28::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.8 via Frontend Transport; Tue, 17 Aug 2021 22:15:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a603da88-259d-406b-ccfe-08d961cc8229
X-MS-TrafficTypeDiagnostic: BN8PR12MB3090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3090153154F3E971CD08D78D87FE9@BN8PR12MB3090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vfwbeoRs4xJrYolcTIsIBL+g8dh8Kwtej+ffmkNy8VIReDjnGEaQvN0gw0lW6bj/bmhSCM8ji5Z2jTYVPfm+FcBBbMX2dmVeQjWIUlO9aDx+uT7GfFhb/RJbGKmwfc/ueDHeian1yULmvk4cnywxKJxnSlhdSZu91wg6YYIqc5sURBVN2YG9uHfCit2zUx+GY9wX2V1DhAiVDdJ1ld3i15BPaGjB3hP6lIQuuLGQfv1mG22u9GN3kNlcmoTu+XNras7qF7h9t52Yuk78q/G8uHeSeimalLFSM+EjJBcRaP7iYUKV60+x+P6sGFuM0qUkIlA1+cvbWwauXL4RSm5trFXE68A5SUaYyQEmTSPB4oMng2dB4tdMbHyHQMZjwNnTn3k8TSDCG8505bbQlcyuIk6u8dKMa+N00KjF1/16EVOtR4xxECXgvxd2yjh2xS11SUTLcg1uxWjyOWPjFF5ZlCKu/7dYRvMbAMETBXGd4rTa0rK0jZICQSfvdOfYikh7z2afJNAIFqbPyLmGpzjx6C69xuu9ENBTM2aCSaSMfFvPijMCRemVpHARI1C7voH+ZuHhL5bf9dDUUZdKXsiO0Ty9vrJTr7YVSTf77pwI6UuURQ8o6lTnjisJg0b1r6aYVwSlRlD1lXSb0/MIcM8I6dUOmxiORNT0nnGefLJh5nftodwLbMEhwuBOZUpl2l+rvW/4/Efb0OH9fpOhkckkom0fCkd9GmyO2wLT8SjJzX13OPAjtCOUsgxhRPPeAEthwyxyNsCSycDaXxNKAWLf50ZZ+mH4eDw2REhOPFneQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(38100700002)(38350700002)(44832011)(4326008)(186003)(1076003)(26005)(2906002)(54906003)(7416002)(66946007)(66476007)(66556008)(86362001)(2616005)(956004)(6486002)(8676002)(316002)(83380400001)(5660300002)(8936002)(36756003)(7696005)(52116002)(508600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYfGFE+dOKEnlgGOm/uOkL9Xkd/eR/Jgnz9zmyCun8rPEz0nUd/5fdbtTqJb?=
 =?us-ascii?Q?yJkRmmdRIokwpDNmQqyB87VRPLY1RNTLhrtonnA/rdLtEhSew0/cOEZDCi1b?=
 =?us-ascii?Q?wAZ5WklvR9WV8X3Kq+RrK/rpoBxs0U0CIwGNfVS/ZGUbpKKRFv9ECsqq0w2Q?=
 =?us-ascii?Q?M3QwD13xsI9Lp/DqudqtIgbirVZC5KjjQfqrPNE8mfOVe9/qxOP3QflTP+Z3?=
 =?us-ascii?Q?pBORx6kpYnO07VsKQf2Vl03YIvoS6/wCmmTymXY4wg8XL+skvx6jkHGy1g1I?=
 =?us-ascii?Q?da/ThOLiXRlzEe+Jlgln3QwPmJV0l1iIipuYRnEU8oLBsaKILaL6EFKbaIaJ?=
 =?us-ascii?Q?dTxq1hwK+nOpQ1ZaUEf3wJrZOkEC+T+K6SzUwjYGtt6VgE+E9vh8tzmVICGz?=
 =?us-ascii?Q?eHBUbhTtKQGShZOroDps3/KZZ7oYxfGPPPK9ildvkFXPwX2G7lUoshGkwCGC?=
 =?us-ascii?Q?Y1AqZFC1izwGdLSvmzk+KjyRyKmzUITJbbl8Gc3aL0x36+6ca6GTdYqsIjDd?=
 =?us-ascii?Q?6S7V7R6EUBJTzdqCCI6T/WD13qUVFC7RzLJC73qlhsZJ39h19kKju22+8ZeB?=
 =?us-ascii?Q?KVKhyIsK3kyYlt9ee19OcTCK/a21tKOKpC4mAhCSNdNMk94rBY6N9hP8gvwR?=
 =?us-ascii?Q?IAwYTaIUfnR5oVp81Iu5VI7075ajhBzWoT5UH/epVC+yUFCfSCe9CIbDwXQJ?=
 =?us-ascii?Q?vTvk2HS7z0nrk/3PQcqz6w9Ob825bj0KwlzPVfjoc7yUBjYQLsXBuXmotVPe?=
 =?us-ascii?Q?C4c8AjZVxWkGnun/kwFHhT3zXOkhvqWaVDaO7Tl8VmH8XWsHRcwtz71Lg+Yc?=
 =?us-ascii?Q?N2q/4vCjKvjmKeLwMTO4zXPFA5sZgzys4FJfUCnQ9h6Gg1FTsb0SKfzXTdF7?=
 =?us-ascii?Q?JeQ84XhKDwRCJeDTKv5i+wdCv53tycbjikkFd8SWuw9uCB6Ks+QszE9zN0eh?=
 =?us-ascii?Q?UWwYgDz4FKwm0qkJemIdUCvBk/+T6NF14e+122p0D1t3V4/l5lai6M/KArze?=
 =?us-ascii?Q?HzloNkJRJu5uCwTISmpGEzM57SF6cQTZQtDtphDLNlw/Ph8RHIoAwG157Ohx?=
 =?us-ascii?Q?0aTqX3EjU1dww7aKKzWsuQ4AaoDnX7OAi7r/EFJ+YZOGv4qNIwU7udJl7spS?=
 =?us-ascii?Q?DUjphB0qorGnE/1CN3fH/8MLRuCMqQ9D1A43XjEPgyJxiF/BssqD/0BRxpQm?=
 =?us-ascii?Q?zfy9iGaKh4Yc85mhPtPGMC5I4FUEmfisK50PL8DbMgzC348lYsfvDdlIZs6X?=
 =?us-ascii?Q?O0T9FSi0YHhrI1t7C1yMCSgWmDkRgEzP8m4L00UChptgZXLZzIrZREWocS8W?=
 =?us-ascii?Q?QfN+eqDOHnZIasSiuuIOINBK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a603da88-259d-406b-ccfe-08d961cc8229
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:15:23.6514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSm28Svouwv6uv+/YZWsgGxG6Do7I9XTlUws3sn/OGQ+T1T/BGAoUm8nxCS0URMp8G8uRBtxc47GwNy4XVV+bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3090
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Linux perf tools users and maintainers,

The first patch in this series prepares the perf tool to support
retrieving cpuid and pmu_mappings data when in report mode,
information that is needed to accurately decode IBS data.

The second patch adds a header file tools/arch/x86/include/asm/amd-ibs.h
from a separate kernel-side submittion [1].

The third patch allows the tool to print a textual representation
of the sample data recorded by IBS.

[1] https://lore.kernel.org/lkml/20210817221048.88063-9-kim.phillips@amd.com

Kim Phillips (3):
  perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings
  perf report: Add tools/arch/x86/include/asm/amd-ibs.h
  perf report: Add support to print a textual representation of IBS raw
    sample data

 tools/arch/x86/include/asm/amd-ibs.h | 132 ++++++++++++
 tools/perf/check-headers.sh          |   1 +
 tools/perf/util/Build                |   1 +
 tools/perf/util/amd-sample-raw.c     | 290 +++++++++++++++++++++++++++
 tools/perf/util/env.c                |  78 +++++++
 tools/perf/util/env.h                |   5 +
 tools/perf/util/sample-raw.c         |   8 +
 tools/perf/util/sample-raw.h         |   6 +-
 8 files changed, 520 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/x86/include/asm/amd-ibs.h
 create mode 100644 tools/perf/util/amd-sample-raw.c

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
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
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org

-- 
2.31.1


