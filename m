Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7CDC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 03:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F044660F94
	for <linux-perf-users@archiver.kernel.org>; Wed, 13 Oct 2021 03:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbhJMD0v (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Oct 2021 23:26:51 -0400
Received: from mail-eopbgr1310092.outbound.protection.outlook.com ([40.107.131.92]:30357
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237109AbhJMD0u (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Oct 2021 23:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2fVyaJBOS61oxW0OxPSP2r35hHpxC/igqhbYcvA9snhNMfieEJ3ZF+GHx6fxUJDByoGTCiKpTKHGNY+vWbKhkOhrqQst1SXvk2B+CRus9GzIbpTQ7QhD+CuXPedxQ1Wvx7IKMUye+7MQfK7/N/58AkCCUvq/bbOgAnNzQxc1oWKkKkqIgr++aw88T4FCug+sJSeD63pv06BvpW86GcXwdhNgNEUEWdFBt6phUzpnoccQPH1a1Vx2Owh5cBeWFhQNiNjIcKJIaupUviuPdMeYl34itcLoNml8plnpwIx8KXOzsn9vYF7LK8ZVT/YYxGHAAZqAeOCm92nFZHQyJiWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMbiS//vwMsRIOo4ubzvqOTRyi+izql1WBCgmC+x+qY=;
 b=nq1OBzOghbu5d6vw8ETsZ9hsNmAK8meWrB2bNt/ligmJcKuCbPgcznIK7KIa0E+NoUeTUQ64kDohT1uUXNJV0KL9apq9vgi1485giNENhNWld5mVAYlzXMHlhaJE4YgnSpjDerOsFXSvAt88gSWATd5p7EH7JAiq/cH6aMWqyUlO78VKDKAl+5fUZwlsMn47IpNpCvoYgxrr3KPiPmVc+TRfNQOrE8U2K5nk7625zSrNb8i0d5in5bDofiaEODQRDpj61ncR/setYRGi2k6BBuYDi9+esuhpLf9QPTOa8Fv0bNKasCuurmeX4t02IJQrGrwOkczVvmoVuuBLtp1fBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMbiS//vwMsRIOo4ubzvqOTRyi+izql1WBCgmC+x+qY=;
 b=mbqIphHTGGpfLa1kZs4MQtNR/7jnniPL0elSNrl1fnv+w93Nsk9haKSztW+stEbn8mHq6HcymyNQKRMqRIq3IAbhrBdory9E8ojcyQNfFdz7r7Ywc/NfOTtfqgJhTkd6zNJtOh/NWOIEY3jRFsNWYRx2zWUxyFI33FVJeDHD56U=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3387.apcprd06.prod.outlook.com (2603:1096:100:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14; Wed, 13 Oct
 2021 03:24:44 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:24:43 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] x86: events: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:24:35 -0700
Message-Id: <1634095476-3750-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0020.apcprd06.prod.outlook.com
 (2603:1096:202:2e::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR06CA0020.apcprd06.prod.outlook.com (2603:1096:202:2e::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 03:24:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65e4fb55-95d2-40b7-8254-08d98df90007
X-MS-TrafficTypeDiagnostic: SL2PR06MB3387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB33878F88C724B846621A1482BDB79@SL2PR06MB3387.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yjkWyKU0RPmY/wmJi3y7hxyBQ03FmnctcaKeTGrEaNlLpix22XH61Iu5ihS7dKjYLvz3Lkq9424zIBkI/HTo5S+G4Giu5I0GX/rliMJGdLy0elU2Qvo/ywjKv7/uODrzs5NdrtTxGqeVrTLAHN0z+mxgWgvvcu0w7L5SBDmvjGHVGI9UC3vGOGoi3/RKsaa8Ilr0wUPi/BhKbkieckdT/WW/i+cCY5Qu26gK7cL24DFEGVkJmt4MJ+yTF23ZrWi6pf4PuisyrqtcdIEMj50AB3Y4Gz82TEmXWz439o3X+Rx56741DCLymPxQNq60qbRRxGzp3wbPlTNtIA/PONRNKMObJ5G0JYuGdeVupjdEv6lzflupBSOzyZXeQF8F/WVwEEkxNvG2vSoDCJSNy6w4CEcml6eXB8Q6Lyy02PmzLkSOJJ1Wb18i1Qv7lehDH68RRli898rVSUL5uY8BSDf3+TD2YgEjecevnR0ImK6Netw9MHEsxaAJTS+6V9Nj7HaLzLU7DvbYS8kNpefVxQGwJgDTxDuHmsqYAeTIvOhqJfm+hxzrJlBORlulQJwXs4t6ApIjcavyFFwsCJCcFlX+tZTa0GyTu2loJtoq0L6afUaQ1kAsgWY/9vncxOdmwZgboNq9eLOiIGccC3J6xsRE/Gtf0pUtSvXsQInx5uH+xP0lyJvbBVmEzK+XgPpqp8Vmpxi1k4oG1YaQxyyFAzAuMwA13GtcRPpyPrN3HzGk/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(86362001)(26005)(6486002)(316002)(38100700002)(5660300002)(921005)(66476007)(6666004)(83380400001)(4326008)(6506007)(38350700002)(66946007)(107886003)(110136005)(508600001)(66556008)(2616005)(8936002)(2906002)(52116002)(8676002)(6512007)(36756003)(7416002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3DidPQgwX4LIztJOmlaJAOTu6yLayPMXzyrm4WBBnJBzPie/WBB5meAcJYsv?=
 =?us-ascii?Q?OVGai4KpW0snsgbHEuTHaOeFJmiGcJ3DInx4NwyZ18M0I5ioHT274DVoh5CZ?=
 =?us-ascii?Q?UI0s6LgUGTL4WznGKRe1rNrzJOSRrPkMc7fDE5V2wKG1lZqWQRTVhyxPVnIn?=
 =?us-ascii?Q?wBZjDZzrOBX0In6WanJJ5h0gd/N7fkGQgMY6XJwl6qIaLqC0IzZQiuLqLtYE?=
 =?us-ascii?Q?TjNwhHggs/KDFRpwFZBLPtlgWtVs24fDSa9J/sqYT0NpF8IsZIm2POcZ8/wR?=
 =?us-ascii?Q?tB6w2nbN0kSG/na1SFaEePx/WjEWZGou6uXT0PxrbJNmqmzUbXWbsVa++qbf?=
 =?us-ascii?Q?jPYNXrVeFfMqlDo94yCbyl3cXX15uFW5CDsv8/eOO8lwuTTFMtVObyx2gl9A?=
 =?us-ascii?Q?RTOZj2oeFsceEM8lMccXUY6MIBlN5aPwwKrnzz2YnscK2tlGuac3CW7bCJpX?=
 =?us-ascii?Q?UttnNm5YxB/z4kLUzyovaQsHtD6yt8anVcsBSdG8rQyP9wb5FlFgfb7m/m5i?=
 =?us-ascii?Q?V4g333Iulb9QESXhrxNC0a7Nwy7gHmyMTlrJ4zfpFjXbuw5ntg42EauqIV3w?=
 =?us-ascii?Q?QFe7J1SrnSp1pXRKBU4RfBTeoC8iwwpikRETbai+jHEYTpIO5rX4IekK2bsV?=
 =?us-ascii?Q?Vznt142VmWqfqTBClTW+3Ui8xKZmMJ1fXoRU96OwU4xkK54yv7N+UTGV+8UM?=
 =?us-ascii?Q?vHxlCgrmUYRJ6q+04r8q1Ci06z8wVloLIgUEUklFQv1SHaW6zMOMc3NpDbZu?=
 =?us-ascii?Q?5besIEWUvOplxcy4dhE69tpIGe3PhD3vuU3Im2AuBw4eT3W62orICSYOJyUs?=
 =?us-ascii?Q?Sx3D1J7zBiU1ZMX0a+ZKbbLXYyqz7p4OAENh6WKjpA3LgQz0uCXcyBwfpjqF?=
 =?us-ascii?Q?OJ35x2hvZ5TO4E7aAAV8a+DDMHV6gGQ4TO1HngEAwde3SEhGBlgkdPfaj2Xc?=
 =?us-ascii?Q?RT6TLNWoBnpZYfkeqr2W/5Bvd6w9P6SsjtV3tDIIiqZmaJ9Y98XWjt/3WPIU?=
 =?us-ascii?Q?MgdBF9sWGi2/3ULzlI4vPjy9EfFtT0B2P0lbCv5bax9kdC6+eW6m0wc5XHYC?=
 =?us-ascii?Q?3Cr4z5tz8g+bZFLRa/qdjGTp+MEgUIfyHk33ZXNoheG2ZyfopePqAWCvCr5Z?=
 =?us-ascii?Q?U2RGfY08mobUM7vO+/djCdHCWMmKYOp7okI/NXC5carDF6wkVab4BMEKpobi?=
 =?us-ascii?Q?C0/X4s5wz2jO+F25mpA64mEtrjUPNwNZBPgL4Lkk7pMNP47/KzFHnWU6Bage?=
 =?us-ascii?Q?GlqvJimkMUmt5rod+eNNkCA/MZLXUMTh3kzwani4IZmpks2gTqoifqJXTN3a?=
 =?us-ascii?Q?lQ1cv2ICGsO4vtEVfJzM0Oku?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e4fb55-95d2-40b7-8254-08d98df90007
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:24:43.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 811HM0tMNdiQPwCiuaE4H/NNkGvLGr36kSMZGghiOicO2147c6j6OXunBoLOjUuWtlxg+Q8pbKGQmJKPKyBg2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3387
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the coccicheck warning:
WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 arch/x86/events/core.c       | 2 +-
 arch/x86/events/intel/core.c | 4 ++--
 arch/x86/events/intel/pt.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3092fbf..d82ec72 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2608,7 +2608,7 @@ static ssize_t max_precise_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
+	return sysfs_emit(buf, "%d\n", x86_pmu_max_precise());
 }
 
 static DEVICE_ATTR_RO(max_precise);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ac6fd2d..acc994b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5091,7 +5091,7 @@ static ssize_t branches_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
@@ -5107,7 +5107,7 @@ static ssize_t pmu_name_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
+	return sysfs_emit(buf, "%s\n", pmu_name_str);
 }
 
 static DEVICE_ATTR_RO(pmu_name);
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 9158476..846d708 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -92,7 +92,7 @@ static ssize_t pt_cap_show(struct device *cdev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	enum pt_capabilities cap = (long)ea->var;
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(cap));
+	return sysfs_emit(buf, "%x\n", intel_pt_validate_hw_cap(cap));
 }
 
 static struct attribute_group pt_cap_group __ro_after_init = {
-- 
2.7.4

