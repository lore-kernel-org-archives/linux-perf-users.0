Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0BBC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD3261052
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhHQWMk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:12:40 -0400
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com ([40.107.92.66]:4068
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234218AbhHQWMj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmQOSi019ewM+fCs+2w4APBwurfk4qmEVvg5g7QcKUhqmEdG6JP7VdHoZMA8NOsFYj8s+KwpxHGe4jVl9vojIe0OWDwmLikkjU/r6yxMn9/YoW7ExpiAeIp3yn6zotVeXRygLqC8EWyh3WOLPIo/gvDq3XWgApRMVS9vREeZX1FQkZevCxAl7nOM6+2CgNaDIEEu8cdldiE9qxbms+F5dfl8i4qOkY1ctM1IalZyrabvPhGjIqxO0dWC439IwUrp8i+GXH2tnSgR0s2lhJWKfWPXEeCNObG8P3bWDP+I3pQdMzpOb14XzZ/Fbtf398aFHLv+53ijNhagCoHoVCFyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjTb2evEOE4mj+jpG2UZaDBNJpWyCR4OhG9Gl6CPUyQ=;
 b=m9QjE0d4k8uvrSABbtoAwv3icuwk3z/MHVLJWvLyCjTZIsKNG6H9cE8v2E2Puv35ctJXZ4YgzCvrthIFU/leG3wjUuHN32l/8sYsi4CbBheiY1KVqRo4p6RfcWEC+EguyFUMR3ftUYOPiABSBn2PB5SZYDNaYO8DCLBfqdZEVgMgfaLTbmutkAp2De7oXiEvXXMmj5HsfIQ5kuWGzbVQb0nUPJE7CKcQnnKDoGYEFxpHWYqKfA6tejkJ98dn/E/bvjTzp9c6vzaoPjv3GR0ZZGRyi1R6YN9xY52ElK/ns9FNwPn182dlC6BpLphLwD4TV811g9TeCHgPpnSKK3ld8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjTb2evEOE4mj+jpG2UZaDBNJpWyCR4OhG9Gl6CPUyQ=;
 b=F+cYmgdEoDZMcI/e13cVDxk+NAh6+zSUgMJAQEQkC1pO0cKJq+xeBIovKZxi/LQEPsvFRan8SmBuSI6hvMJWCeZfp/PHeRxv71F4BjTeDvefxKMxZJnGuPf3O4W46IDaUHIqDnh/gGkNXTvAuICHlzvmKQK5SYQFgD0zRG+R5Ag=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB4977.namprd12.prod.outlook.com (2603:10b6:408:a4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 22:12:04 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:12:04 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 4/8] perf/amd/uncore: Use free_percpu's built-in check for null
Date:   Tue, 17 Aug 2021 17:10:44 -0500
Message-Id: <20210817221048.88063-5-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221048.88063-1-kim.phillips@amd.com>
References: <20210817221048.88063-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:806:d0::30) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA0PR11CA0055.namprd11.prod.outlook.com (2603:10b6:806:d0::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:12:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cb2a7db-5a35-437e-9fbd-08d961cc0b28
X-MS-TrafficTypeDiagnostic: BN8PR12MB4977:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB497777C7F3CBB05ADD7E129D87FE9@BN8PR12MB4977.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ms8C2KezHBDCjH92Ut6Udysm9bhNKBKgn8pM2gQXpAQ+y0jYbg9hepbEXvtDgDY9EPuhqvHhXzYzH5BRZ+XsZQvFQYTwHSX2y8HkZ86tNesdvMkUlSKtZMRHU17D0vnMyjUFHpX4K8b6ffFk6qaYUyHJqwXQH9dxBEW4pLdB0UWNw0rN5fHDAmPBKJPxQjRaVnP9zaI+uhJX2bxKuIpvtsdzziiCwqnAkIlSkf4q+XbcJSmNC3w9sQrIg1n1SfMSdwCxWGJgBJ5FgRdCtiH7VCSO0fePFaN6jVpGGeL1eIo3P20sh1gb8Aig/7VbQ8XF8dAkepRUetkClyTkj5G6kSdT/fBNR2fjTfSn/Zh3h+DhyuBYibQHhPq/+OC91/o09NbKEpSWoNdIuk93zz1ThahtNBAUgHSTWbWyjVkP8JhzbKENlljGieLMiY5/LJhoACF27e3M9MQgaGl86t5IN0Eme3a424w6sVxnqH0HcDOeOhYUZMKks6eCyvLU4kqfYuWGOUnjop3put99aA3lSTBewWgalV5JOvCvJiz4tkr58ZovUO4QVWo5dHyQQ058QTUdAFliN+NytrLHrTQtyu+EZe7uhAfLODL0eDk0rWVhFvZu3gZlo/U725kEftP1L52UsW9pTr9igNCjWa0pBoVfghUCrp/h7bO2BOWKjBtgfgxe/W3kCLZ8gV90zsd58+HKV5EhPqgjyge0mPuMdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(1076003)(26005)(54906003)(44832011)(478600001)(7416002)(110136005)(66556008)(66476007)(86362001)(2616005)(2906002)(316002)(83380400001)(7696005)(4326008)(66946007)(7049001)(8936002)(38350700002)(5660300002)(186003)(956004)(36756003)(52116002)(6666004)(38100700002)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F6lGlhg4Jb1Wi2k0kEcgemSoT5iqvxgJfWf0bl2mpDp2w7a3Wjp0xYGvDMHz?=
 =?us-ascii?Q?QpK3UTMlR/FwIPvoeyLqRlZjKZnJekKcrBWImp37N9yH2F/8EaIJrvMmN4GN?=
 =?us-ascii?Q?VJWiMM1fNMDXmcwX++rDnVJBSgSbs44reL7zCN/Jlxmkm4kCGXY8nN9cOFLV?=
 =?us-ascii?Q?V8Ejy52rln3BW8A4LFgNSgXlzdLE2v7SL/zjOknuc8KqPwgdxVB+FwmzLD9V?=
 =?us-ascii?Q?DqbeATfZbg+WGIQOT1I6iGFOtgohAS/n7pqGFYHwv959GKjiU/vQs0OcaGjb?=
 =?us-ascii?Q?xTSz6CkKooXrZVoEn6C9+0rxbf+WAzieQ6EYW1/zm8+qQ2PLIjVeeNa1JMxA?=
 =?us-ascii?Q?m6HoO+Nbjc42wX5NSH6rUpK7ttglxYSxtlfC7/qP9xtpc2cmY/Ie9MM3C7g3?=
 =?us-ascii?Q?2jcSyuo18lAfy/cHPUmDl8NuyGW6hcXwkmeONPDK3129BC9CAgVA7mXU3p/9?=
 =?us-ascii?Q?WosMoUrXsCP5JbXPjkxpxHpfRPhg+LRr9qbVJvi08LJQPZ0ZS7zY3EPsWd6j?=
 =?us-ascii?Q?ZMgCqgYk7zSKvQV4XAmYkR1k9cbqVAp0atVbsG5nywUJvT1c7tb9L3iSVOq0?=
 =?us-ascii?Q?hF0xmHNJ9MLLNmnavIHkg+saq0ZelccNRD0X3PhYpuvDLWK8Sd3usY7iO5El?=
 =?us-ascii?Q?W8yQMFtNowxMnOYcpbMKPLScPxkXR0gdnrVsQl1NJHbhXXeKo1DfAIOmcjWS?=
 =?us-ascii?Q?0kl3TOgJM1FPujAcoCHUDGxuQ+uOEgQyrmFz9V7CYWxCOVqD5QVfDng73z+m?=
 =?us-ascii?Q?M6v2y6xZ6IoCDY/GUGA9fkLSNIdKD0XlBg8rHKvGyDdltMc5EcsY+od733U+?=
 =?us-ascii?Q?jVIVRve3J3cNi7ZhgOMNyeicFTakAEeQ1MBBGDiYEBQ2Da7eSbBpHTRM36Nt?=
 =?us-ascii?Q?D6leONkFKJJ/u5y7dh1tCrYqMjnAM04USWLToemEZdKSSGV6u3l4CwlTJZ/U?=
 =?us-ascii?Q?WOBabjcl8UsiCe2OH1ci7kYnEuQ5GX3bnJpIDHNXdENcb015rE+aii01TfKR?=
 =?us-ascii?Q?F0fK+BS48qsvJ8HDWuiGy9v1QVk4mATOpq0YKGpDyWNb+3KRHuCxHtdFdMoX?=
 =?us-ascii?Q?AmZ/Z8DuqWLeNawqk5kMESAjd4wMg5s1UQFk+x3bdCugFQw/aDPMYeUeBr7W?=
 =?us-ascii?Q?cdMalIduH58vVdUj4ntBYIXsQyRZsqWjQD3WWOUiMhV52JKw3qHZdPHSMDA2?=
 =?us-ascii?Q?xF3oAdOGbm1kRjejewfwFrnZm9p/B38l83K6LLE0U3i+pruBIdTwCuj9X7r6?=
 =?us-ascii?Q?jqlqLKKoJviwP2B7Qldiv43zaXBe2O+GR6wd2ce9HdofXFT6RLvXQWE2n5UW?=
 =?us-ascii?Q?oL+XL0yJYMAtIag1AA61n4AG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb2a7db-5a35-437e-9fbd-08d961cc0b28
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:12:03.9619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+wVDtOK831wYOt7OJDjwQRe+o9kx53J4OBegtCAuNxy91ZOKkaTo9te7Zgp5BR7tUkJoHekQSIWg/Ye36D2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4977
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

free_percpu() has its own check for null.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/events/amd/uncore.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 582c0ffb5e98..05bdb4cba300 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -659,11 +659,9 @@ static int __init amd_uncore_init(void)
 fail_llc:
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB))
 		perf_pmu_unregister(&amd_nb_pmu);
-	if (amd_uncore_llc)
-		free_percpu(amd_uncore_llc);
+	free_percpu(amd_uncore_llc);
 fail_nb:
-	if (amd_uncore_nb)
-		free_percpu(amd_uncore_nb);
+	free_percpu(amd_uncore_nb);
 
 	return ret;
 }
-- 
2.31.1

