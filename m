Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EEF4594A
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758519460; cv=fail; b=PP7JhnTNOGgyXZAgpDhPDl+oQhKp/Sf+16DElQTeFhdDPmBiNMtGq1OWNSa4UJNNFEaJUK9tGlnHoGzeIQjzptgNljwZpg1JdtzopVnXUVVASU69gcrOhMynED5/zyPsbUuCZj57JYKwFrtO9o3Y/gYYyLj8cgQxnMkYWlwyg4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758519460; c=relaxed/simple;
	bh=JmyYoSnRey8xYw19jmecc+pnhYjVc9ejsOTwEECNxzo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dZ69VnE/v8KGUSq1ZMT7vT3Uf+IqkiMDwNYZj4GtCoPE4IfHF/3eyLEXax2tBji8EGw+tdnEEWc565JcxoWsH4RvWXT3nHG7KlpJ1zl0n9iZWlqa8X3OfOBWeixZEKiTKmYCTKo2JFvYF9ByNReJgTaUoag0F9rU0JH8l3sxZ1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com; spf=pass smtp.mailfrom=criteo.com; dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b=xasyM2fp; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criteo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b="xasyM2fp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzBEvIWUw7RlofJOe2kNEb0ZYQZipUBdrD/csdyoBlahe/Dl1JEG1IpsPbbQHLhkFyrviZq361r+ciz8NvnkPZ8ElDK5Hd2aStiCDsObgfBaPtHDPBEQZ8RrSrBpKuzhmYHThLSDMwpJqyMlhUzR7PSMZvCCkpUmJsl2pSEdW6+Wvr2low53h89VXDGSph+Y1s8NKYmyp1hr/UoneSQ3ClQiUj3uxbHhigI5Y9bbiZd1jwGUnm4s9M/PFKdzNlui2QO4faLK5U2PYyic5XoqIn3mD4sDl/CxWE0P7uSoCn4mlBYPFusLFSk18ZtfHUL2Md9JRRRFT42DF1kHl/D4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTyQ3s8xwGD9PYj0Lohowy4QGUzEnkqZ/ReUiirz0zg=;
 b=TZAsrdoyJWGORwrtnlBENySf2PqBGiLIitFy3AWpRZFKU/b423iSJ15bb1QHmbfMzhesyYiY+SwoN52rOOKUwYLQFCt2amueCCCFDIFVl2jfX1kvxQT1/54aJBnV646m3HiD/LE4QLa+kZYxfWxI1pWbo935bz8Zmr4hVmYtB/v2peam4fbpAA29t2IEkw4HW+QKcRsEbz7MbNUFOVElukGtDqhlb9+GR1fsGn9koj83sl3oosFm3vp2Ct9veXehai2qRYfnf9IynbT+Tx3aJHKLYNLmPApAqMgRK+j8LYnZCNiVTTRiAK2QMkEHB3bOCYUHG2efVCQMQE2frVUTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTyQ3s8xwGD9PYj0Lohowy4QGUzEnkqZ/ReUiirz0zg=;
 b=xasyM2fpHZcMKMK3HTP5L3FNWjGlihlwGavgwl8yKWlfrKury4Su7XnbUKOfVqvCkxpsRGXFyUKEL/dv/ERkKBvOHxBecBvvNOaH9KiTrAvSVvZaO0GrU+XZN+AHLFWZTSC4gpOSOme3B2Uux59cuvPQbGLOxi0uwokJC+49PXEIfwjCso4SDHmS+Bw49C9R0zkehBeCwOkOnNLtvbfllUw0KeUhXtQGy3imznfnybw8nzY8baDeJBJ/5wmsKK9YOLWnWIs8sPJi/eBG3u+8yMW19+xrIUOd5udHtPiaMXBNVKH904vuf7gQsdnmOkSaSNp12XEhmlgeg3Vj3rwIQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from VI1PR04MB5199.eurprd04.prod.outlook.com (2603:10a6:803:62::12)
 by VI1PR04MB9857.eurprd04.prod.outlook.com (2603:10a6:800:1d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 05:37:34 +0000
Received: from VI1PR04MB5199.eurprd04.prod.outlook.com
 ([fe80::96c5:db9b:a002:2d93]) by VI1PR04MB5199.eurprd04.prod.outlook.com
 ([fe80::96c5:db9b:a002:2d93%2]) with mapi id 15.20.9137.010; Mon, 22 Sep 2025
 05:37:33 +0000
From: Vincent Minet <v.minet@criteo.com>
To: linux-perf-users@vger.kernel.org
Cc: Vincent Minet <v.minet@criteo.com>
Subject: [PATCH] perf tools: Fix arm64 libjvmti build by generating unistd_64.h
Date: Mon, 22 Sep 2025 07:37:02 +0200
Message-ID: <20250922053702.2688374-1-v.minet@criteo.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0300.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::12) To VI1PR04MB5199.eurprd04.prod.outlook.com
 (2603:10a6:803:62::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5199:EE_|VI1PR04MB9857:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f03816e-146f-4942-dc23-08ddf99a2128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/sWG0s1zlGlvMp/1ax0CXYXuX0pdqvAofxWf1Q8EBPCYERbGMgb64zKD9ey6?=
 =?us-ascii?Q?6jXZOKRUFRJkQq1dswuUO2ZAguGieXZlAeTlcE7ujXsKzbpLLqjA0iKd7+lG?=
 =?us-ascii?Q?LVCW73vo1Lux57dWTXXwPLLj9fJe4fhKKS4NPcOfzAYIrkvX1JsUaFJg07t3?=
 =?us-ascii?Q?pUuMkNWjPiXZpe4fehSjfRPJ4T/WKNQyHKENlMvXu7SAhzxJnGkdgqapSgTe?=
 =?us-ascii?Q?Gx94Lq7KFSr5HWfFkrzVOobssrz2rIotWfcQyaKo2enTYZ6X9y4RWaLnIxHW?=
 =?us-ascii?Q?8r+kIvGvwz7KySSsY3C7m8cvtaNWRrnDasvZj1fYcWI+afPjD47fUHm3Z9bR?=
 =?us-ascii?Q?b31blrDGdiNPWurq5y8gFftvRvwauqPWYwpC5K3C+FK3P9LgAkRtzTeYVgZG?=
 =?us-ascii?Q?B8mjdlHHSOC/1RHYmctAi8/y5aN2nUdVkKjBh58/43y1y+4I5zd4QD/5z4xn?=
 =?us-ascii?Q?3/TCJLdvA38gPCKstCku2yIrX1AIPU9L++qfJJYBFqrNHUDiHYO0JL5Y9sx8?=
 =?us-ascii?Q?pQaxNfSkZfEvvktnFVhci19YIubNGyOfNjusjQeNslefyAd1LuDD1PU543mB?=
 =?us-ascii?Q?afBYUeEenksSphSnEz2bE8a1KaJy4QW09nKDccTt1nXrSXX1RU4tkT1otMDz?=
 =?us-ascii?Q?slgv4m6kC2ZHUDg/c/E5nrSP9khw89CdbJEf+Lwbsb2oMGAZdiYq+giAz6if?=
 =?us-ascii?Q?hGWzcbN/hjuI50QpB0g4Sb4yiUkQF8eRhplMwV+mIUVXAcjS7H/UxUTSel0w?=
 =?us-ascii?Q?pkKn000p6ZcqLvfNXkMEoW3RZTlB++soozfz7u4xNrit5Ci3TlYyQLkvEdXo?=
 =?us-ascii?Q?PYadJBZyNlR1HGv8ZUGXtt0KeRMhme3FLNMLO920+DxAwIrnaIx/a8TBpHyO?=
 =?us-ascii?Q?310YI5Ky0soax5OS+Riv2/7St8BfM29Se9488GKEK3JrnbLByXLxR1nF/Kd9?=
 =?us-ascii?Q?b3mg366W8pEENw9MWs81F0U19I+v3IhYVq5baR2Lz/bXynLQNHeSY2Uk+xmQ?=
 =?us-ascii?Q?GWf90Trc71S1orVT2NW7WEh4CP7kekW4sD9ye1bnuyF9r6EW6hVmvQlEcR6x?=
 =?us-ascii?Q?z8sJYPKE6JEQt5Ju/chPxNvkWTgjZmv8jmhXeCaI+aa0okhi/W04X8KrmFQE?=
 =?us-ascii?Q?Ozb73F4EiAsts+NEE2kectgsFvCC0qTnIOHwez8du6tJ7niNR48qKLbQxEOB?=
 =?us-ascii?Q?F2kP3iiqsSvz4wXtvGCiWFRqomgeCmLL5tfhytJ1vEA71QvdMhBI3WvYE9T9?=
 =?us-ascii?Q?glsAnnw9Nv3QGlZWcdtIb/6TzNLsWm44qCecWYV927B7Pv5vq1oSQmSOsj2V?=
 =?us-ascii?Q?FbYlK0QBwZ2KBqaNQkIV3v8qNpscoFjtXvqIEUuhVbPIfHt1A+ZMxmOrcWc4?=
 =?us-ascii?Q?dGkHlh3msIlKekQYkCI3E8MSv/MGz30obxHbtxksIdoxwFY+oNMUkVgOYOsh?=
 =?us-ascii?Q?4uk9omBkevc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5199.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BgTWpQUKpReQn49R0JtoBpL1cCOsSqSa2e2yNpfRd6PjuVP9gHoOnYgs+o7l?=
 =?us-ascii?Q?+lvwNothVYqtcf+wzIHzobyY7u7V1Mr/7167j8Wc5v8/SnBkgk2lqTiNVXZm?=
 =?us-ascii?Q?5etAXQgYU30tXcOMpsfuIbBf6eShCscYLeMT08hmKWcTZeDYDkyMhgoLjrKg?=
 =?us-ascii?Q?VBAw052SyeB6HJCThU0MHGJMMCpGIJXBBIDl4kNs+gjw/N1UO9Ov78loUAPy?=
 =?us-ascii?Q?9GSYuu8yocBjAsXAfF4Ipj8NnuCmktdsbexHv2Dag6lHXCOMfv3dYTPCD+p2?=
 =?us-ascii?Q?cBl/OeWtHJRmQz6PMnzMLw3fgLt4OTiqAdIxMvbX6nWCcuRGz/nuWdPi8hkp?=
 =?us-ascii?Q?lIJKVGjDRTtcCwTTpfkSHO7PVAucUCYLB09hbxrZZAzmZHh9gxtPAeCg4UE6?=
 =?us-ascii?Q?7jV/ckxOD1GQMQj3NEHQLGZRdZph3y0kZHQFTA6zLaWX3gz0BbY8ze109YPs?=
 =?us-ascii?Q?+YWkqfsoSjAiaZ4Us9bEstKPIcYCThU6uNJS9kJRW34CObm34ibaS35nPhxW?=
 =?us-ascii?Q?hCLIXt5SziWTNgXTT5UHjK9CpxbM2CHa4gWCapVzhEUDkQzw+bD9UBYS0lPB?=
 =?us-ascii?Q?j5Zvc2MIQgouoVXLCvOkmi+oE06tSYZKUPlrA6qhx3/g8VpWxZHtJMZOG/lT?=
 =?us-ascii?Q?oUl9r4P0gAsgohiBf6VhgPfBWeO3RjawfiSAHuizYN8JPQ2aAhTb/etpbOhg?=
 =?us-ascii?Q?bUPVl/7czzHc7Y9Wmo9HIKB88wHJsRE+PWplPi91zWEj+ddCQROMu9OFm6WT?=
 =?us-ascii?Q?EzVtSf/t0p99ob8Mm79cwyA9+ajpajBuWWNa6zuoOWEYza5jlWzCqBFS6xsu?=
 =?us-ascii?Q?OIznDuZM1LSKWSCWRmwEbEm1glvF8rXF6ZKnnSNbbNsnNAxWgaMCqNc+0Ycn?=
 =?us-ascii?Q?fXS0nrnRjHh4E1d4Q43vmfo+gdddgH0Hfl286WpB7NrkoP6YAL6ZhDYEWCaS?=
 =?us-ascii?Q?J4sQVacoqAn7+BmyLtbPGVDKyvpmb0ic7NNsar/TlNlas1vesPVfTgj6x4xm?=
 =?us-ascii?Q?6uq8xa4zkR5HQ6b+kC3D9la0b9/mA5mb53fTRAYq6f51VInNaumTyEr7tRxR?=
 =?us-ascii?Q?Rk0UcUIMSKiK6L/B2l2tw3uB6h/2SRerPPnW/BnLa1u4+tv4zrACQmvNG5s5?=
 =?us-ascii?Q?lXcej5x6o8QZUw8DQJsC7NJ1C7oHwpacthqHCyfmBR8M4cg5aitZPl8pG30E?=
 =?us-ascii?Q?EXp7iQRGCUOoT5U+kQHFjTmH4RACGIqTFJxXHRU3OPSYriZKZspotmwINbZW?=
 =?us-ascii?Q?Um+ptjDLNjuKuKpOs7oM8kMiD+jX9lysTZiEBywB5yyFkP3ZLPQdEuA3C4UR?=
 =?us-ascii?Q?8syGH26oqwpY7yvnC8X6EMFOCeu8V1HUF24Caowlyme8/Nuz0sFUpsnEtZNg?=
 =?us-ascii?Q?L5RNNlCWkMu8aFF/9UH8SDY3UTxljBBZTAeNsG97RzVm3mNtIj/1ccF9Zhcq?=
 =?us-ascii?Q?12fWo0LblVhIuwouIUVlB+HHxia1vyXE1/A3JX7cp7tZ+q+dD4Qf2JoTFNW3?=
 =?us-ascii?Q?z/+BbN3oyFsjANMD8Z6af8hlkDhPPGt8p4iw602blWP/VIuiBQx46EeR/uUc?=
 =?us-ascii?Q?owzDN+1sGgIBS21JMTyVG3/lciQFm1AdE55bKky7?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f03816e-146f-4942-dc23-08ddf99a2128
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 05:37:33.5274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWgF48AedsAevQG0E2JaGxlmXnuEN2dpnPIUUvGU6ECtTOSWD2TEwcjJ9Ej9xAOeGxOYrBFcZzljK1bI6gWL5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9857

Since commit 22f72088ffe6 ("tools headers: Update the syscall table with
the kernel sources") the arm64 syscall header is generated at build
time. Later, commit bfb713ea53c7 ("perf tools: Fix arm64 build by
generating unistd_64.h") added a dependency to libperf to guarantee that
this header was created before building libperf or perf itself.

However, libjvmti also requires this header but does not depend on
libperf, leading to build failures such as:

  In file included from /usr/include/sys/syscall.h:24,
                   from /usr/include/syscall.h:1,
                   from jvmti/jvmti_agent.c:36:
  tools/arch/arm64/include/uapi/asm/unistd.h:2:10: fatal error: asm/unistd_64.h: No such file or directory
      2 | #include <asm/unistd_64.h>

Fix this by ensuring that libperf is built before libjvmti, so that
unistd_64.h is always available.

Fixes: 22f72088ffe6 ("tools headers: Update the syscall table with the kernel sources")
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e2150acc2c13..f561025d4085 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -941,7 +941,7 @@ $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
 ifndef NO_JVMTI
 LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
 
-$(LIBJVMTI_IN): FORCE
+$(LIBJVMTI_IN): prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
 
 $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
-- 
2.51.0

