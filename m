Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0F5C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 02:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFE460F36
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 02:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhKLCgw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 21:36:52 -0500
Received: from mail-psaapc01on2121.outbound.protection.outlook.com ([40.107.255.121]:2112
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229908AbhKLCgv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 21:36:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JapxLrOZIJpR1dDduapo0FBB3KZNo/+3oJQASVCD9Z768kB/4Ett/0mjFiM0TegnJDGF4JwUyTKTZhBxOdm8YhRS9nSsVoJoySoIS5RumgnKAHjZ0Pqy7yikMdbZ8FAdmzniT6fbyX0cXCnnBOt17EbiH53LGcv5sit5AbAj6mvbXFTeleoDUnsxtl4khE/5Z6ZzHBBHqJwqugtMujBdP8loSuNV2nrtYQIg6kBWHEYNiU6/NdtnD7gXUp2d2KdLjPMqlQeG8mfvQUl6EvRvJWBn/TBhQv4o5tOZAlv213H1kmFdFszKWO9mf6+nK3Xp8v/qzPF1hh8HQVV0tvbzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I5VDXbLpw18FRCFLf6jq03In7pM1VxRJxXuOWoqaZc=;
 b=N9bZFkKtggtx/F3mrsAeb5BZiv/EILNCH4bCv+sySoOMMhxcOrlws7RMRC+CkJinq9pAq8MLrXi4nprZzFrlY8pmHBRPpEp4vD21YWH0dGDpTWT7khwLNo9/xEULxMwmaVAEmrZN3mSefmWmE7b45YI2JnhRktoViCDr3kf55WLpRROg7rUFCDw1OU6C3joqwkVs1+mh0dohvnB47fec31fTMDh+Dr/s00MRkJ7DBrrdHxFRtt+qMOlbjMo3S7lLiMOxTdzAzYdcAXs4txgMb+ehgpTatxvk7tFRq2X79iDLW2flVhiY746N7z2062ICQWCCdsZxXpRhzXhI0E/udw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I5VDXbLpw18FRCFLf6jq03In7pM1VxRJxXuOWoqaZc=;
 b=UDr2+DD1NinRddSt1grnnI87q38w8jukdG9XwU3dAMEpsLEkmAyeXRR1LsjQ7kFLlzourCeOl9D6GkF17sTM+aB6ExarcUbmppDHgQ3zbT5+Ak71xaOoKO8WiJxWQ50gO5yD31PaN1aMvmi7QQ3g0Ray1aAcp09o32v+dK76AZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYAPR06MB2191.apcprd06.prod.outlook.com (2603:1096:404:25::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Fri, 12 Nov
 2021 02:33:59 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 02:33:59 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] perf cs-etm: use swap() to make code cleaner
Date:   Thu, 11 Nov 2021 18:33:44 -0800
Message-Id: <20211112023344.3642-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 02:33:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f504231a-1c6b-4bd8-e21b-08d9a584e1bf
X-MS-TrafficTypeDiagnostic: TYAPR06MB2191:
X-Microsoft-Antispam-PRVS: <TYAPR06MB2191B4E62403962A544537C7A2959@TYAPR06MB2191.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRnFdbyNrk/hhcaRmRE0iOCS6ufDSsyArNxkutkY/zLasPHe6daPLNLUbLSWL8aPprJvQcthxcLL0KeuvYeYf15EyU3sU3+YDKnwWGvQOJmzJMIjAmbTUL5FqY6xY3oW5FwbgwNRBod5jzE1UM5Ic8SlP6mPDUwPrhGEWBGZH08GXpDAhZdAhx2EoohwmkwrTOPN5GAzGopMLryMANICViKqxZiVWCdczbfWnUfAqFQIP+cBPgt8EpaoAhsqjgkBDPyZuoBMMO6E6avtkXdW3NbSUE4LVM3FtTQ4kjHKCOF7E/iBlwasb9RsHB03uIavGhqMYnzv4C1ZNIr+AsSBwaHR2L7Kvnu9wokTVegVJL95i+s02IkWRmMnTmqSJ3A80OpKzvsMaqAs3AsLx+OUuczmPoWJS+lUrV9KX24XC458Wz4vvP8h87HJP2l366CHkM8FWAmezOqXhwHaopc8vn/xn8e4h/Oik1q8hjNvwvio4f6Wolz7Yj5AA+SAnwLXCl94ruhOgy+AVGghdyiFxXtR0SNrkjjXtYjlucSldwv6WXDEhbUznrCr4xLXoZiehEwxgtgv1iOXZ56dPXkM7VSO2TOwiXQYKvpg6rkJpeOEfLPNTzSxyeB/Lj72yj+/hsG5WfSRbhEUy6O17ugUaO+LKi0xAAY6hcQkS63q5fufU/2wdCmad6+C4rWLI/Xy3CLoaZ+7pIWZjnLRxdGrptSkweCmQA1uy9/2cM81++M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(38100700002)(36756003)(8936002)(4326008)(6486002)(26005)(38350700002)(2616005)(921005)(66476007)(1076003)(66556008)(52116002)(6506007)(956004)(83380400001)(7416002)(2906002)(8676002)(107886003)(86362001)(316002)(186003)(110136005)(6512007)(4744005)(5660300002)(6666004)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c2FRVk7HKgb8lhTQCWGA2drguo0dDeBFkqTmz7BXCKzJ+sZ4hDSl9Um31mKw?=
 =?us-ascii?Q?gXNlWx8CePwA4zxekuPm0V6O4NniY30SMMa3V5Z9BUXr8/ql1ULx+Tgqt/Xn?=
 =?us-ascii?Q?4yIVJNHOEAUrkqa68H6/KTqGKS2zRiQJg8L75rM9AkobuuNCPxac9YDDfxDD?=
 =?us-ascii?Q?2zLqBL9fW7HJ+qO38qErnrYZ9Adfr6G2e9uoErQd/GOPIY0RMtj1vDDyVKna?=
 =?us-ascii?Q?kgpFpn78KCpxRjokDCLWSLV/27Ci4/KHcabUwpEr+UIa5FqmR3eE4/UcIugU?=
 =?us-ascii?Q?Z7bcpZEAJpgjaPCaxqFT1zeYiTnx0pDOPaOUV6Ex9FCpIYVHZii4Q2vQNw9t?=
 =?us-ascii?Q?shHQCR2KdPtRARmRrnJLEc5zdkU9hqHaGuGnYKbltMKC7erGU2Yn+ttBsN6I?=
 =?us-ascii?Q?1shTALRcOaPNMNjpnnSHBtF70bdA7xFsbGmUOWxnTUSjc9cDzRkuJOsQbpbn?=
 =?us-ascii?Q?2mQyAc21t4Q4YS2CNt07jAgI3GXHquOBqFLEg3voFVi8cz+cmzmw/AwmQTjD?=
 =?us-ascii?Q?ugXqJrM1cuchk9nokROres5UjevMzUjwpWUegd0vFB50woYOiC9QPAQwi0+2?=
 =?us-ascii?Q?rakkxlb5s6YADTzJweYPNbRfJAHzyndrbW1JFzK4Lg8fuiGCkGofS/aRNZuW?=
 =?us-ascii?Q?Zn0usRVsqYKVQ1fFXgk4hP16LFbnNtU/ocrWXqbNBmTxjqoUliCmhONgubZn?=
 =?us-ascii?Q?8jk8oj91xAtrELkHpxNH5mWNE3F89Gh8Fntsv/wRZ1Hy5Jyn2Ei3WhxD8WLl?=
 =?us-ascii?Q?OBNGH1wVg0A1bJJUTwLrbeTgzwWIpOGkb8AiagIUKtSnJXIiOhaHoINC3Pa4?=
 =?us-ascii?Q?4UHKKsTkeZrFKkrNjS1bHtpzsREf8/+p2VZYPC2wq+41STnlMxguUqqGHz/g?=
 =?us-ascii?Q?C/7NACSSj8ZEXOCrhwow+eqrRsz8y4F89wCy0OLDVvnXBwWabqKzhtlsSlyz?=
 =?us-ascii?Q?ZiFDDc6T2vV0IoGq/6l1x1MG8tw5q/YhKe7wAaCL3RYj8z5t9Pu2Io2n7c83?=
 =?us-ascii?Q?BcwSQxvJD5jaQi47x5GdWW3Y/fDJYgeut1/pQx4kpgHDeP3t80iR3Ujri6b6?=
 =?us-ascii?Q?b5a3VlaZvfKTpiRYnKE6eUHtcMEl3C7/cwVJVyuXfS0+0q1X4TorXAcbsgpn?=
 =?us-ascii?Q?MB209W+PCzN/th4WQXE6h95Dmee3VQR/VNh+QmQ3Un55fXCfNrKARVw+/MXl?=
 =?us-ascii?Q?2LEqLPJoQEo5EDZvEw5bzqCxrPOlAK83OA+oWkYMBKNV37bDqJcOofnOUoKq?=
 =?us-ascii?Q?CoQCK49r8SrfoPBawj5/FklUOzJGFxib6OSjrp1r/6t/oo3fqP1pEGL0A83k?=
 =?us-ascii?Q?X1MKyg7ixN3Sx6OBopMELUWsG2c6iHBhPj5yVl8KaEduJulA1s08LhyhCg1K?=
 =?us-ascii?Q?mM9kU18bpGQPXCLl6drlrsui4wCbmeB4tMwGg6HTG/hcz5R3T/eVGrL0wMR1?=
 =?us-ascii?Q?cl04Sv9INeR5oa3nYyox7gx5+PDHovRY6kJyAc7gcIjY+yf4556+M26h/ASa?=
 =?us-ascii?Q?2v86ZT2JRkXFYkxoGOV2g+EDVMA2EOFlrjdP+oZh2D9NKnoWbCAzkAguI8fU?=
 =?us-ascii?Q?zdIciOD75lwF0/O/9ZyoH08R6d97mcQkDWirvIi4AOw7xfmo0KeBGBqY5Dub?=
 =?us-ascii?Q?lVvrDdxQIR6gPgERlG6ermA=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f504231a-1c6b-4bd8-e21b-08d9a584e1bf
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 02:33:59.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Spqgck8ZeJZrH+lbTGaXk8+zsOnFd3X/as89qRm9qFu9KI4+Amh5GlIImpwodwsG2hGb3+tp5jd2cfGtL0ShUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2191
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 tools/perf/util/cs-etm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f323adb1af85..aaa3ec725002 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -408,17 +408,13 @@ struct cs_etm_packet_queue
 static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 				struct cs_etm_traceid_queue *tidq)
 {
-	struct cs_etm_packet *tmp;
-
 	if (etm->sample_branches || etm->synth_opts.last_branch ||
 	    etm->sample_instructions) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
 		 */
-		tmp = tidq->packet;
-		tidq->packet = tidq->prev_packet;
-		tidq->prev_packet = tmp;
+		swap(tidq->packet, tidq->prev_packet);
 	}
 }
 
-- 
2.17.1

