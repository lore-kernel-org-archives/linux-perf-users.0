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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23F7C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A526102A
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbhHQWM1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:12:27 -0400
Received: from mail-mw2nam08on2055.outbound.protection.outlook.com ([40.107.101.55]:23393
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235401AbhHQWM1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:12:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZxPZQNxMspo372h5QNWJfHERyIQpCTLoXwDs7BbryNWq7Ir8i19pkZw6reJq4YgxAVeeZCdM1dl5nBMiZYl9AySyyn3k/oQ1F8WGUmr1H+rGmtJkyymZH/QSQCaDwO478ixTMIy3KrDbynRzmxTMw1Xk49Vv8HT6fphXfM+Duy+fMR7Rl+GsjV/a37wB3LDiqCy7zgyvGZBLfcKxtn9ZeuKm04UI87g8FMuOrqXqB26ktJsWILEeZ5YDWyu2tp/ERJjm5MOgC+sM6sAkBqDOcr0xdS8A8MbcOvkR0pa/QhgZjS56I/6TpEn0019dIxoz6401nL+c1WwS8suMb/izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4srd4JxKYrI3r7xIR0GEkb4eb+7Vc0GJTSle7abFXU=;
 b=FQTdi/as7DvaEjad598e/vt4jKpkwmsRq7wBYWcgDpxzxykE6xHJNyg3j21gssVmuONY48+356Ep1NQWxt+ikR5wp8eTzp+RMJn7yQNGFcEa12reS+TxPoUeeqIJfy3sL9da6912yqJs7dQIg2R7uiecsVlUyCG5S0s94QYoQpt3nuasQMafLxxaIucfCfqqVXsFzpdEWXteHldc0bOAo24H3tk+UdE4r0GC0vqBtLxaYUhff6yA26iheaHP67SezJMBM9GnC1LTW3TVtVfBGwekdjXqBmqw6TUAVFMwnlOmjJwtV3fCB2r+Wj0gI/pIWu7d+nrGAFwSL9jqDocHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4srd4JxKYrI3r7xIR0GEkb4eb+7Vc0GJTSle7abFXU=;
 b=piGppS7uWmsWZjDRiVK9fM0Bp3LWgmNCozs6XarfcHc4WTW18hBhbaO0qAtW11y0+Wb4n2ZIyghnGDtiNw4g+qEptwJXB5IH2YRlkNjcFQ4SeOnzJcfqg8tYYoX2BJ3DmHrcP4i0tiyFb0LMYY40JNV+a0iXNN+0ULAIVORevwk=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 22:11:51 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:11:51 +0000
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
Subject: [PATCH 3/8] perf/x86/amd/power: Assign pmu.module
Date:   Tue, 17 Aug 2021 17:10:43 -0500
Message-Id: <20210817221048.88063-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221048.88063-1-kim.phillips@amd.com>
References: <20210817221048.88063-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:d3::11) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA0PR11CA0006.namprd11.prod.outlook.com (2603:10b6:806:d3::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Tue, 17 Aug 2021 22:11:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 096be248-84d0-4851-bf6e-08d961cc036d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB35057969754276266151E3E387FE9@BN8PR12MB3505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYRwqLPHOoQxLIz/8HPgqFIqDNGNUx5RBoEMhfS9/eCgfRNpKtNALPy8Mi7lxGsVgIesDiNaUAjwZzgwTkpJsIs5SonYe/U3nlGWeYC/s86IhP/WzTwzctJXCM89rz6C9VnkTg99uJnzByhqWyhy+lC18NDt+n+bdI5GhWlLlzTUN2JFXPgv1gbih0esqDOnzimlD5Z+8cckAJxOMWF0nMWkkldrQaGcbHzTGcudtY63nOvF+W3ne+hH2gf0Tdxyy/XLVKKWDlarYaZkDKke9bQd1Ovn9gJ9eYvPLgkA52joS4SS4WpQ584NO5nqGANRZeiADBdKamv1u7OKv+4y1+f/sQQr4r8UQldTf2LhU9vTflb9xurMbzysqOEPVVE5JHYal9tPV6kXJ8VV5F1y61cAjQNmnTPKoipLzwWKEV2H7KpFrpwM1tiXJSuIoy2a72iivLejzddRsBtfZdR8j8mVJHVupLnI40A00tRAnI12cxHafRk7gBSGiSx0/dIfe9lm7t/vRNEqG1igZsrti4zeYNQii7YzXuU3BbAryr3SuU2+vK5XdlK7KQsK8djiwhP3+ei0WFZ3g0O6ZtT0n6J7EtVRH0VijBwv+EvsLSzqKhzyXxYkpmXRIkdBtGyndbsm9AMBiR1fAJTsRaq9WIxkSPwBvXRIjcNNB2XjndEp5CjYYzKIDMp7ehFmzfS075jmPL1sBPNM/Jf+fvzYYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(38350700002)(66946007)(52116002)(110136005)(86362001)(54906003)(6486002)(2906002)(66556008)(66476007)(186003)(26005)(7696005)(7049001)(5660300002)(956004)(36756003)(478600001)(8936002)(7416002)(1076003)(6666004)(8676002)(44832011)(4326008)(2616005)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yy1HDWWEXv/yKzvhaWtpGuL+u9yxc2xaQLsdyDTXgvhZMosbT7GcgBYYLyVH?=
 =?us-ascii?Q?QwaXcEqtFfHXl2AWALPHFcRAv45IyNSHt/M15L5jnau/j5QSibQU8XD+ckza?=
 =?us-ascii?Q?J/Ag/riPZ0w5Km8eZiqayLJgxrkaAyi5dHaAFv8mgcXmLcL897Og4QjLdPsZ?=
 =?us-ascii?Q?DNx8RC6zTurQ54sDBTFYc/2xx5RdHlbmBxKgkt8SHR3u9WZtXA6m3ii6iE9f?=
 =?us-ascii?Q?QGaSaSLYQ+zTW6Ot6s/Y1u7BeW7R02z3y5Es9JrsflAc6Su9qg/R34mIq+7e?=
 =?us-ascii?Q?ryZKKpC/lsR5pC0mJmW4MJ+AC6g84C9GY8oweF0h1AoKKsHT9t1AABHBLHyK?=
 =?us-ascii?Q?Pzayxfv4NVK7Hhddp+vYvRj3MOL7CC0RrQIRNJl3u0ZwKo6RGZ/gJR15DL9m?=
 =?us-ascii?Q?u8uowphFlww/XxfU4hHr83oLvShcgdKZU7r4KpOmaiY2oXxs33HCQ86xbDKd?=
 =?us-ascii?Q?oesD/9IUa8zOCjyadsPzMweOqfU/IukYj8sjY5jSvSrmKdZq1zhE63c3ayiM?=
 =?us-ascii?Q?PyUTtmL/3QR1liFjaNTfwmn4CCKYaXgHj3FGPRdPsml3Mqa+Al/DmAzBcJ9D?=
 =?us-ascii?Q?brVeRV4IWBvCfNcnO+N3U/DQDMxJzwYSaok29o3BTopNQvI0oi8CTT03x9bX?=
 =?us-ascii?Q?wMHTgz3VAOjs1J5/SX8T5ja85xOcHXe+6SOLj4b9Cin03TqENd5VX97kPLkX?=
 =?us-ascii?Q?8p+e/vWzG3MsGwSuyuNdmD2KHWvqGetp4zK27BDno4iuL5skaNLQQiKG7V2M?=
 =?us-ascii?Q?PqL/hKKchOdjZxkpOcY/PTul6uYG6xAvagh2AT8rkqnh6Ifc/j0NMUii0N8K?=
 =?us-ascii?Q?J03jb/NQDalxiNFFl64ZXw2AopbDb+pTazR61hCd6SVP2WHEBB888RhswsBP?=
 =?us-ascii?Q?qLAa4d3Td8+GSD2RqVXMCb0aBY0V0eA7ZZQyrAuiLByGsDPJtWQxGbeXZZPu?=
 =?us-ascii?Q?4eBGt9cBk5cWzwmTkOeNFqghr6x/8zSciXLGaaiF4V99AhzkYphVARR8wFqa?=
 =?us-ascii?Q?WeYr4s0aF83q/frLPxwqCPYw1hTVJ5cjbzCWBcwIWniIn+oppxHNGnoXCE+h?=
 =?us-ascii?Q?sRa6LtEb/0EVQt+l961meakYryhruxf5qWkEvqmM5WMtsCYRgO/xJryuG7HH?=
 =?us-ascii?Q?QrkbWnc/8BbRe5mXNnYLSXvdsILlka/Chhfl9IB7QdpQu+jJWncRuBzovdcY?=
 =?us-ascii?Q?A1ixYGgc0lI4tFrKJGtZCkSm9V1IMMlFR6rQ7nDleBGckgar6zJQNYbqvkgI?=
 =?us-ascii?Q?Rcl5/LYRvCFgNKs1QX64mEbTGAJ0HadLk/XIfcx7hkCziMLQHYsdrkZzYROp?=
 =?us-ascii?Q?Tn1qem35lU2v6iPkUT1myQAd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096be248-84d0-4851-bf6e-08d961cc036d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:11:50.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13Qf5fB9yq6wnYyrplL696pJjhUmgdQk6M/v+TKPpDIHfbp6Y7Qn7k+8pnq4UCN5FaDeYPgykTh76SMKVNAzXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3505
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Assign pmu.module so the driver can't be unloaded whilst in use.

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
 arch/x86/events/amd/power.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 16a2369c586e..37d5b380516e 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -213,6 +213,7 @@ static struct pmu pmu_class = {
 	.stop		= pmu_event_stop,
 	.read		= pmu_event_read,
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+	.module		= THIS_MODULE,
 };
 
 static int power_cpu_exit(unsigned int cpu)
-- 
2.31.1

