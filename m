Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50728C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 06:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31167611C0
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 06:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhJFGZ3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 02:25:29 -0400
Received: from mail-pu1apc01hn2234.outbound.protection.outlook.com ([52.100.183.234]:32466
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229638AbhJFGZ3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 02:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eph6sn9DxMCSSMebVh9X2K3o+/8wf8gWBu5Nsbrzygv69E84Ei4FfhwMhrEFZczKlNhcEVeFfPbbhmGWSD96ZWNhrXtiGpuqvFeVr8RoN4OfQuoB22EXJViBZJ3cCaZxR9kSWKa1KyMcfeYfyBqb8TJjsN3Wq5SFmAyVHdaDSJjjOaa6zitz92TU40Fu6fzcUG5oUeNQGOt6Fc2P9CI3bTXxFtO+W3AZVOXIROWyYTAIhg1edLg60Vv99Rlx/wQy9s825C9eahKRS56ORzbBpi7sbGCMIkeuuqMWGuVFkOp1ZutsQycZbcLPYLqjPbLlcp+8Vvhcz2R57dNZ/bA8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PfbAO3nWcKjtzbbdlYI1IVx/c385AmgJevkH2By2hw=;
 b=hwqMYh6VfB3fFchu/xjSyX3zDrlVqqRJju6Qwybu462dMh6sPZEi+Cq7Ruil1L+jGbPyRBzUOTv1G90uD3zo2H+8DwrajPQRBytyQVOp8pq6hCBiC3Undr7HSDPALcApTEsaK9uh0eX9T+JlCUmoSxP7Zdx435DseLhOSuEJK0E+nfCGB0pQiy2qArThb3ejXWIEStfmEC46eiRj/hU2otig/TBptnhdnmEe0/OIm++AFiGiiQgQvkNPzy9UonY7enQKE4sqB/xN0xb/y9q0qsrDRCblvVi8Liv48N1y9iTrNQ4N04XUOCK2vggL5TjjXWE47ISvmXQqnwtOaswtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PfbAO3nWcKjtzbbdlYI1IVx/c385AmgJevkH2By2hw=;
 b=AIiMecxOSWIBYzAhaZHqsL0KDeodXG1eGU5HPJ24bOz3NBvqI91s0o8eUr41VgE+5k5E+kC+ELzPvpHaJ+CU0CPpkQ8gbJjgDFBZ2R49ofaDb7/J1uEjc9l4cmNHXgmxBvtlXRBNHl2DjlSvVR29/qbpclHachUccNjzQtsHNN0=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB2260.apcprd06.prod.outlook.com (2603:1096:203:40::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 06:23:32 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::39f9:6e98:b084:c138]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::39f9:6e98:b084:c138%7]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 06:23:32 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] perf daemon: Remove a duplicate #include
Date:   Wed,  6 Oct 2021 14:22:34 +0800
Message-Id: <20211006062235.6364-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from localhost.localdomain (183.160.233.131) by HK2PR02CA0133.apcprd02.prod.outlook.com (2603:1096:202:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21 via Frontend Transport; Wed, 6 Oct 2021 06:23:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be8f6f50-dd68-4da1-66ff-08d98891d1ec
X-MS-TrafficTypeDiagnostic: HK0PR06MB2260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK0PR06MB2260761BFF454945F55739F7C7B09@HK0PR06MB2260.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c06EzwxIdZxNb5ku6DgDAXxgCzIdwadKVHzjQrKT5D2LVOk2f452V2G0GGRN?=
 =?us-ascii?Q?u20jXRDzac1WLby/HhnGi7rW912KOyfEcCJd8fXNVfhoDlrgL77xuqguHj6Q?=
 =?us-ascii?Q?R22VU5UtNQw7jjAy82AFHc2uflemW+y/37wCTvWv0qvxDNDVAndNRJ4kdX15?=
 =?us-ascii?Q?f0U6AtYHDaowZA6w1+tDvoTnijqoc2tFZ8Z52m5nSnPUsw2kTN5LrXxd+xdf?=
 =?us-ascii?Q?PXYFhqc0xzYNc9w09vxzZ9c+bKIUTg/u06dHok6wrFDFAWcxRlulY/jNtG3v?=
 =?us-ascii?Q?kTKA+31q41r5rI8nAx9NXuBGrp1NAO9kZphQ72/dKh9l6XGrLJGvaphuX2oY?=
 =?us-ascii?Q?DQ3yd8p2qMvTsWo+VbMNVJvomYbCJs1LRRAPZa8qmo03G+4dJio+2pmEPP9V?=
 =?us-ascii?Q?SUdpllHKb82f1l8lyaVbUk2d98I0p1qBR+0THUj3prz3nQpgDblT3W/Bb5rO?=
 =?us-ascii?Q?ERdXYK2PnHMXsR/0dT7J13JfyeNGTw+YXMwZHlbPsOJKmQhx3NYXnaZRBcj5?=
 =?us-ascii?Q?BePRo6IOVurdjU8urrjB82bNQAYvhErM6YrvSHWmgzm7mov9TTmgbhY7vL3B?=
 =?us-ascii?Q?gV7Pt/ytgeFXNYMsK7K31g/fq+8ad+XP+EJJf8YRH0wpJ2AMPVjkQO+pHzTA?=
 =?us-ascii?Q?Ib8KMrH6bTpseopD5qeotUGRbIJ9EvEto4aX8eREyRfrhw8OaHAZgYooT0KO?=
 =?us-ascii?Q?N3NTEM8XfA8y1tM71grqxCjTbZY/1gPaoj7EmMOn7KsyC+pjJf2H+6wW/vEP?=
 =?us-ascii?Q?XpR2ywM48xVLokrvE+LiV3YyAGhCcoqcZ4Q9VYCKI/s4XHu2Dura9UTkEe/y?=
 =?us-ascii?Q?I4ZTuM5BDtqj9CCiU/kmx5DgLIgXusTNVN2Vm1APEMHQ3x0uej8dUdMmjT9Z?=
 =?us-ascii?Q?vnQVmNf7+aF+0+jJhCsA9VLJG9Xoy8K4h8Osjk9Pq23ZtWn4xBBDw6E7IDyV?=
 =?us-ascii?Q?B0ixo2EQYJs/kP8LCnJj+48d50IYMjtczbH/ArZS0ZsZaJ6uOMr1albE2uLD?=
 =?us-ascii?Q?FOQC1Hkol1lz2uvSZCUHrmkHXUIBAZk5NSgDOYd0mFwmv9Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(6486002)(107886003)(52116002)(8676002)(316002)(110136005)(8936002)(6506007)(6512007)(86362001)(83380400001)(2906002)(956004)(2616005)(1076003)(508600001)(4744005)(66946007)(66476007)(38100700002)(38350700002)(66556008)(5660300002)(26005)(4326008)(36756003)(186003)(122976001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IxM/J3GxrQHQdUgrKus+Sh/Qkr7osY3bx16WN/kptKoBwVKJGYz2exQhoQgN?=
 =?us-ascii?Q?ja2aZt+prLABgSHrpRUTlTr1do6D+991yHTdcYxWFZVm7NZzVI/kcihzB0S6?=
 =?us-ascii?Q?EOAL1f1l4YjCaSjTYi+oRHpP7mru4brWbnjZSVfk9sO3l97NZxFP9D957ri/?=
 =?us-ascii?Q?FYWuR3kvY2O0oeI5LpI5IDhJUdOtxNnBcSgKoTriOX4InmDgFVaHzsOeZ2TK?=
 =?us-ascii?Q?c9VWZv77j6ohExYJBCvTOQHY+mtnVk6n6dbdMOh5McV72hPpkQzSJBYEhUl2?=
 =?us-ascii?Q?howCdMP6hYFlG8/V8UzCP1vrq4KwJHB/Kku3uBvCSeD3m6NfN50i7r9vwntH?=
 =?us-ascii?Q?UjfdPumu5AEzwaGh2t44CFXpg/vE2sL0wD6Uo3jjrva4fL4bxw4Oo+TbH81P?=
 =?us-ascii?Q?pjWaXFWTBz31/XcEOb2KiNzaj3noidpllg3vjIgrMqF3DbU6UaDJbphFgHbx?=
 =?us-ascii?Q?j6tN7hY0khGkB5OdiFFBAiEyJrdLa1gL+GsC93FkLGQeBbGCiX+G+Cp0SqFN?=
 =?us-ascii?Q?qWxCtCpWMn8pxoOIDsVXiN9AEDwGJ8cfz0YVOgbkq7rlIcfGquL2s4f1UGIT?=
 =?us-ascii?Q?eEOncMUrwjRXS6G+0xsk20/s1lIKKGj2eKJYqUY7q0YBM2w0h3XqlauxzPW/?=
 =?us-ascii?Q?AAqGTL33P8YVvJ7iE9U+qIvuI9WcqTJGqmypbYxZrEnSpBZMDmPe+0i5SaZ/?=
 =?us-ascii?Q?WCTpySBpCBTru0aUwcAg46vS+SsQWbLNcZSWsNdUt69+ejbQ26HqxpCO3DEW?=
 =?us-ascii?Q?hdPLF3cPRKfB+NUTMaKexIFRJNWs40uc6aOPOi3sVsGKBIXoHkgrjCRQIQpB?=
 =?us-ascii?Q?N4le+gKGYWwBUNQ7fJo5O1msE07l7AGLYyEzRKBcbH1C8t9WXiKPVkbdb+7/?=
 =?us-ascii?Q?Fuc3ScDi+qiWMmwyQg5Dmi3JZXYq6Sp9KRcKMKHArGbFUqxy+5oV64euMEsR?=
 =?us-ascii?Q?wtXcHazU9t71H4bgL7s+M9WEUA5UBk2Us28zrLcoTYXpfqK1IeFyZmbyiQ1h?=
 =?us-ascii?Q?/JE2CDFbLPLTt0ROzvqTls2bYRToKZ1TfS9dBYlARjQWpYPpZe+QR4CTwT5M?=
 =?us-ascii?Q?cZ/2MPJS5lz+bER6IrXoZYcvzBzdxFGbbWYZ+Q5mxPDmImxo4tCiQB4mLm8m?=
 =?us-ascii?Q?JhafXhFgpGwq+l1KDcHQABSdUColSZPse8rO2DTxXR2gmdjF5mMOIlC2fFZ6?=
 =?us-ascii?Q?bXfJW4mi4PSJHYu6gcIvRpCpluSHrUN0teK6PMXFqqbO3xBsfI7l8yIDbR8O?=
 =?us-ascii?Q?WFjBmTYbLCOtYjgA3R8jOmyHafhHaS/hvqWvPbPySOwt9CVkncUn1voQ3uyI?=
 =?us-ascii?Q?07ntPNQtj84TwqpkVwAqNIi+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8f6f50-dd68-4da1-66ff-08d98891d1ec
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 06:23:32.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSO2hJ602n07zTquYvlmf/qZYjoY476uJ4pCEg8CEId7lDjehL1ZiURUn5a/7Lcu1z+fg8Gci87oPnu1waimzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2260
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There is a "#include <sys/file.h>" in line 10, so remove a duplicate
one in line 1124.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 tools/perf/builtin-daemon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index c13201fb09c3..6cb3f6cc36d0 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1121,8 +1121,6 @@ static int setup_config(struct daemon *daemon)
 #ifndef F_TLOCK
 #define F_TLOCK 2
 
-#include <sys/file.h>
-
 static int lockf(int fd, int cmd, off_t len)
 {
 	if (cmd != F_TLOCK || len != 0)
-- 
2.20.1

