Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2121.outbound.protection.outlook.com [40.107.92.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2818C012
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917426; cv=fail; b=lmPNNaRsXAbfslPU3ZRaGHV/uEmis3Vy4kZCh65+VH5r9vPiZ0oNqRMjWBUes65jqke5P8/+9M9nLIhSAl2Mqt2Cap79fMNEoIwGvc2ImmyRkMEFAZPa3dPirc+GhxVzZ4PN1YuAp09kX8p62P4GMYwxb8GdIUSEG9VSvcNgoH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917426; c=relaxed/simple;
	bh=Wm6fY8wTUvEk3F1Ok1pcZgU1x0Ts3RtUnnAP7gYdzRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jVRF5Gx6nmSiwXVmd65tDPOjlAvqjYwRx/eaugEsYsGEK2n//po+QNmnOWSNS10VWvsnL8eRguz+qRruHAc9sZmpmCnJSoxMUCfzYY+Y2nlV7vcYxtKZ9/5xOECSsOS68lko3pX52FcqICvJyz/Nix5vYDyaAsGabDj2a6TP9bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mdX+Iivl; arc=fail smtp.client-ip=40.107.92.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mdX+Iivl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRKyZ50hb6mxYO723rQHuPRLrhz3GN1+pKHRdIse5X8/l6BzWU7rQ/YOQZqmGBUc4vVG5eOYoJ9EZYP08PDua/nN/ocwDdx7ZYYcNfkkkTk+WRQMn0pKnHBWk68wR1FVHLi172tBDR4Z+XLMYue4oo7OJZ1A7GruvXyken3yQt0XGCGXwwW7bj05+3KsH9RGonEDjTLScIaFhnZFYJVJlc+5TRUC29gCWn32QsrVDrPzLt768zHMjHF/6wqK315NA4z1XFwQNnwJqH4blvgvxYNcANcgR6srsZClXiWYYpOu9qNv2us6fpzw+ozyQgWYM7YOgfVG+uT6HKEUZLOtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiE8twlbfqyo2soIykexS6EUqxRW3kdCuY5H08Ox//w=;
 b=tbVDYeq09JNIVcX3xyqwtcSunFup/8VWTqgXrpNfOok+AB+1/lyhFsR/yaOewzJTFRY7yaxt8NG3t32Ggd4imr0FJIvx/HfPPvKAdMujw3lfiEbPkPueuUIUnuT/L02YtNfvpXiRq1n3ewbyxOmQx79t2yhlvuRIjr9K+h0akgOZKOMyS8fMzwYgWyVT04IbY3lGkJu08mNbLJNfvQF9TehYyDU1Vr6Db8zLpH3ORH5nf5Zte/cI5GV2gmaB59+GKKfgelywsSodOSko4eAbtqqkKcFDBIc8IE7bRQ6GMZQAgT6Z1OE3b/gw+KxY1P5hh+E6kqJWmGkVrrI0Y243tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiE8twlbfqyo2soIykexS6EUqxRW3kdCuY5H08Ox//w=;
 b=mdX+IivlEbEQG2le6fTmg9gnKvPPXftduu7wyTo3yHrdqQ6t7b8DCfCTJAS+1K09Zjwc243h681FWHtTYv0Fp0q/oUuLf+/pWs7N+RFiq4d+4NsWpyUCCLL0gp39mpGo4o0zVpKVAv0TlfSMQO9W4XHOLN7BOaZraOlHJFCYKR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 DM8PR01MB6919.prod.exchangelabs.com (2603:10b6:8:14::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Mon, 9 Sep 2024 21:30:20 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 21:30:20 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V8 2/4] Force MAPPING_TYPE__IDENTIY for PIE
Date: Mon,  9 Sep 2024 15:30:00 -0600
Message-Id: <edbd1797fe9accdcb19036c92600de0f7c28350b.1725667397.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::20) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|DM8PR01MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d484c30-cf86-429b-8982-08dcd1169ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IUryjpbGXROCkyT4qFzAqJsl454NfAD9+NljWYUQrp8+/ylkhcrkX4RoUv0q?=
 =?us-ascii?Q?AHWUhXyhQdjfRC15X1xe3v3xaXmi5A81m5hR2q2DaQzV9+xc/yeNEZxPcwKM?=
 =?us-ascii?Q?FmkgKaRKQpkucgBmD/neuJ20qtfNvx/ME2nL8cKYyXfa/2PvcoyFnc4fTtFV?=
 =?us-ascii?Q?uvjOoQKrfYsobVebB5wU+zHT92XcEggwgnAUnzimMp4DRLt4F31PBzbyU1bh?=
 =?us-ascii?Q?iSXxf80xiB2AGOGaw1STAjX0zHz5B9NkakZKaPcGpHcYAxpIIW9XOZVHhiWR?=
 =?us-ascii?Q?DL1gUfvqruf2x1dV+gxD9LAqejgWsAdKZjAZJuZEIrya6FxegZEHumPe1LxG?=
 =?us-ascii?Q?PYBu4oNd0WJyLh+r4UrbGwpFpTVmtnH5AVAaalAW8u6U1pxYRw1v/ymOelOx?=
 =?us-ascii?Q?i+N0bYIRdky1X4mXLc9ZeQLDdhMAurjtRd6J0IwFzD2cjFa69Y9AQJGedHam?=
 =?us-ascii?Q?pIlCCznLuohsBs+z6HlfFaCjD7Jtm5NpiAM9ZLgJhkdpDCtsFfoL/zS2EHhM?=
 =?us-ascii?Q?BsYXkJEpujpbg9I913sB3be5r03ARS42Nr+fW5rmbvQJBBaIhOHK/I11D45q?=
 =?us-ascii?Q?8koAU8cGwCuqC5e3jFhbQQ0awgLgM1MdKOxAycWjKLs/qtK5fj0/c5oBtwc0?=
 =?us-ascii?Q?OTOVA/EMqHZaXE1dh1MGf+LvvtHazN+FEp0IuQcUSRjBayABtiL85CnsLuk3?=
 =?us-ascii?Q?a0weyy9gNhlBGdj8XNFNxO7p4WNN4iWzy8lzzcN21PXI2xbPKMj6U3u3z4hr?=
 =?us-ascii?Q?Uq1d3fyM3ljnjKhEPeY4SsSp/kyEk/R/yAXxGmTazA+WK0nuAe0MR6M+W3aN?=
 =?us-ascii?Q?Pt+7prNpvy1UUcfN0CHJsbjHPljhd5SI0TXnCufOP0gu8qKFQRb+kgI0e5Yl?=
 =?us-ascii?Q?11N+BjMlq2x8sL8hYR3Ex6+5ibB2Uci8VK5gRcobZDuXH8ag6SnIFrHo17oy?=
 =?us-ascii?Q?jNpz1BNA23z3lVSB8XjFdI/IIEZnSIDidaQV8SfykSLxXRmTKW30N8CbDnRK?=
 =?us-ascii?Q?yXsu1t9GgQYzARyTyd0J/oVApjPzq1+8xGyLChYbLpDGRZcXA7Cj9/009p80?=
 =?us-ascii?Q?aB1Mn+LT3OT4odRMFD4zMM+mnL7BZznr4h6zyQXoals10JbzTFIAkh5+Qreu?=
 =?us-ascii?Q?8T8JRqtDjrk77aXn3iP/9vVBqkecuIJBFa4o0JA4O3wHyd3h9updlXKuC8V0?=
 =?us-ascii?Q?c3a9RkZaG/uvPSl41V+dqEbVA29QdbJ0rntkx202HmEe+zsmMM0ShdWOsblL?=
 =?us-ascii?Q?Q9/set0AdkqofEnfBps0H1gTG0fFzohEnuxfbi+b0ae7eNhrbP3Y5NLNtkVE?=
 =?us-ascii?Q?rMExRKiJAFoHNWcuPv58LZasROmVjgE2eh4Yj3D+Cw1erlUPtmk+hUjw5OLR?=
 =?us-ascii?Q?hcyroUlewSL660NE6X2nxTpqVbyibqJ2xJ2iSBfv6jHKaVvYGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMeIgkfrXjqs74XmzcXg8RsSY71tGT1F7m+gHZRIj1hDIwv8pjR/Yd2WqGvq?=
 =?us-ascii?Q?a4FGKduzMpUqgEst8knvdnbu9HOzaaC1VEQ6RwaqsqYaBUNshU3T1ZQZoAg/?=
 =?us-ascii?Q?mXb8KLDr0KmUjsf0BiVSY5PZO+e8LEkw4bo/GFIVMM0xX7x8aAp7W66HFy4a?=
 =?us-ascii?Q?GLklLpwGD6ALNfbGdDQ0gRxSJma5uKdAQwO/myyqh3PR/DBNlMoF4RTEtTtV?=
 =?us-ascii?Q?KcoRBbfv81SEGKWFzhQIdxZYgE+mhh7X9XMIzDnRb6yKWCkPak++JsGew5Y/?=
 =?us-ascii?Q?EyyB6r2MLj/1kghBWf/ZXI1bCEkeRO06CaZIAsNxBoOk/ZbV/csxe+RM0dUU?=
 =?us-ascii?Q?v4UUrdIv8wyhn1tGabq55y2A+EGAdv4C2qQm6ooxIotebYFI0xAHNuOk9fXy?=
 =?us-ascii?Q?gxSrPEZLUV7VEe5yQbzEW4qQgoxyCLQQ0WPg1Uay7w3Q3YMxxxnwoFSUFzSC?=
 =?us-ascii?Q?3ahGWyvhrAXCoakqm+KFQhRa4AQP2dmAVnhSjldLBVFL10Dt5jmoI0fP3dqK?=
 =?us-ascii?Q?OxqRgrZFkiH4+DS4l1z3gzflyYYWWl2nBBOJnCyBbB6SBhQgdIqAbNns9/vS?=
 =?us-ascii?Q?lVtcc0m5yq5dbJVKGIluygOhAHpt/hrLQ+0/sxRGFoaYeAGszsfHclcnYuZc?=
 =?us-ascii?Q?8lijQPAi9kVZZY32r631EX6y/82CeT5zUkEg3J8JFCHYkTKP82+c827fIaB9?=
 =?us-ascii?Q?bw7b/BhCGJTkyRr2Xamk9WO0KhSsVd/1WAMZcJ+kxLjXX/WGYz2mjwKz7a4Q?=
 =?us-ascii?Q?Kj9YoZd1s6Zt4kKWkqCO9niF/XLCI7V8iAZlWia1ZzfZfmc3lUoEvMx5hl+9?=
 =?us-ascii?Q?frz5RbYI7kEJkAQrxk58tdk/AQJbVGdpFkhe09Z+sdQ0aI8Ktrz4xQmg3QbK?=
 =?us-ascii?Q?4Jd2RiSmKYa3k+Qx/dz3as4syXlexen8U3P02M/0TkzH2L+sNLJSB7AlJYMe?=
 =?us-ascii?Q?/yPeAP0GNcMOjSKXbM2HBSAdSeaxabDovMtiLQ6zuHU0Ba3oDzCgSqUA3PRe?=
 =?us-ascii?Q?4M6xpRkQtmjy2PYovNH1ibliraJ6iYs7jY8rk8Wjw5NugBoEzoLRDmk8SrJz?=
 =?us-ascii?Q?G0S5b4ygnGzB+aOTBcdUl2IPCVAsIOIbMfTVVVmb6SeXuZtlzvxVWr1DNWEb?=
 =?us-ascii?Q?r4+kE5L4xE6fuhReQFrCR1pLxraMntg94f3I5sjGKlk179dZMNYaOsuofdao?=
 =?us-ascii?Q?Q7ovFOCbep3F9k+RXmn2eReVY1w6UEsN/nS2x3/j0VB0R14opb6HqdwYAEtI?=
 =?us-ascii?Q?kObaxGVHJqZeVzRJdC5xBLTo0U89gLqkCCoKwi+flnNP/uEPCwCHGwlTwABk?=
 =?us-ascii?Q?9BClkeSjNYV9MO2UqgCtUPPoIJOsD4cOsYxpdJ0G5TO9ogRLgqygLNJjUzar?=
 =?us-ascii?Q?0TMTRdMlFI/FjWs3GxshtviJqlcRNOMk/ISu2KqQq0RRywPXFMI5DWYxoOBl?=
 =?us-ascii?Q?oj1VpocSh6Upez/Mycys/qDDbLHZ/h3/0+w+8iPO83x6Qgn4aONX2jFdtLL2?=
 =?us-ascii?Q?eyOkA7+zrcXSPWrhGSiysopIY+oey1jasYxrku99xXGIMgthdNelaMS1fxi8?=
 =?us-ascii?Q?Qaef8Ia3B1Vcuxej/rJt3ydjKlW1aU4mckX9BPGvVNKSFWx0Ar8bEhYUE7Cc?=
 =?us-ascii?Q?G+dQ5qZs7xB8H7hiDpItOMHSWkOljMLw4LauErAdixLC?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d484c30-cf86-429b-8982-08dcd1169ac5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 21:30:19.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46AZ1sPm7A70AzYTIXHh0eOY4WdXO6wDkgNzxipKc0j2zPF9EE/kA/NJgA3PkvqMiUFmYSdQGFIJIdYt+jhmIuWPXYQsYVIp6dT0d0bWvFfmlmFLXuWhj1wmTZKvif7M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6919

Use dso__is_pie() to check whether the DSO file is a Position
Independent Executable (PIE). If PIE, change the MAPPING_TYPE to
MAPPING_TYPE__IDENTITY so a zero map pgoff (text offset) is passed
into the script.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e781c8d56a9a..c846faec177b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -173,8 +173,8 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		assert(!dso__kernel(dso));
 		map__init(result, start, start + len, pgoff, dso, prot, flags);
 
-		if (anon || no_dso) {
-			map->mapping_type = MAPPING_TYPE__IDENTITY;
+		if (anon || no_dso || dso__is_pie(dso)) {
+			map__set_mapping_type(map, MAPPING_TYPE__IDENTITY);
 
 			/*
 			 * Set memory without DSO as loaded. All map__find_*
-- 
2.44.0

