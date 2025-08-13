Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013052.outbound.protection.outlook.com [40.107.44.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1B23D7D3;
	Wed, 13 Aug 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073991; cv=fail; b=Lnv/X9Qu5n0HoOia1omQTAhgl651kX0t5EaYptoV4ZuZQR+b0/Ii9QpbonEBus+xPvVtDbJKSqm+ejV/H9aCcXqsN7nNfHfKuQFKMf84TlevOYrg+mCKBP2u2Y8qQDlUmwSnDqI4kGoH7R3UZss7Z/BMknEcCgspGMUUolmeQM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073991; c=relaxed/simple;
	bh=u7Wqkd1SQwnKGIaAgH2phwp4f2qj+9h7yzo/ux9PvNM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TQW3g2n5bdE9Cv9Ypoku8FV5ICriwcWl0BCvFW89auFqvhRpIIdcuLgAcSULU8xsYH/2tFiJAKPOzakobyLKyu9pLwvBpLH1BwQMwnlZ/rz6r/n05MPsP7zb3Px56Wr4KNd1lTNVSHQL5N2KHv3znSXevrXK9zXmSE8Y+v5+7dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZjZ3Ibsv; arc=fail smtp.client-ip=40.107.44.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZjZ3Ibsv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck/r1nmTnrVyJ3Bq7PNkPfDCRjcYWg7f07AGoovl1JcaSnN6ERq0o8sHCm/Rm63P6VPTRyAr8u3YYYgoAO1+cZ2PjWQoUY+30cvHBeNM2nbTO5hwNsG/Hfw+Uhz6BdoNRizhm8lt7Mb1J6C8v0CB4oaHxt7EO1OUvEp3y9K6CiYqPFBysffMaKnS1Gslp4pxepJe7zfVDGfdObHMm2Qv17Jb9RaO+TRJLGr06GT70EZzAy22JZ0X5aTN2fPf9LCdxyCZjaa8cbyAoT6mYKlkA1WWvlaaZpWMatZS4zLPXtHu6oJpvIJTE2C0xlmJeCnVsfvsCQ82KGSsEEOOYJpBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or0DxV32dsIA967oRYlcrPT2KL0fUWQ4QAl0TL/9GhU=;
 b=si7qx2OI+frP2+zzb14rZP3v8vV3ArvZ91yoyW6vZz3mFkbfpMbWsopimS9fR2/lnFkFXnToZG0Pt/MnCr/O9hu7AdHld5IT+lugUqfQ+NSe7mAiYsRQecAVhmVRnAY1nFvkxCa+0oUngkQ1AvBJEofb7xuzzE7j9EtxCYpQdSObYA0kCAio57xk0PnuKUMyrcCOSJqfH2aAnhzgPAWksP1IPdQYSWUgLhLU8ZJPQId1pLYr30u2IOjLN6p4Gj7ryIigdbYUaxfWdcdhIQYG7M2HHkd9aOkIkwlkXMNWzWmM+34dcXfXw/TXeUdmLWbuHStu7CVGSDpLMexmYcrZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or0DxV32dsIA967oRYlcrPT2KL0fUWQ4QAl0TL/9GhU=;
 b=ZjZ3Ibsv+0QR74V751UmVaczt6HOKAm2F1BzMhMxblXz47gAM2FlgQYPpXCrBFt5m+x1cPRJ+ZO11YlLKDNPREaYMHgVdmvUfxZ+P/YbdkY7SXPn27c7tUQ0xE4PP/8qW1JFZkWxmzwLKz1VL1Zusqxmmut19xkjzFPDxyASfa5YKI/yfk6OdxHNhGSutnOg7E3kHE+Mheqv5ahHVssYefu0GOPaukg/oZv/TwmZnIbQI81tr2zjR5/nlNpa8+oxRITQCBxGmqQJnYcN2fJw6/PA8gCNcotd1HhYA7WXtFDWRk3c/I6n5daVLm/Tp/pKpZmwcZdOcG78XKihMvvmfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB5294.apcprd06.prod.outlook.com (2603:1096:101:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 08:33:06 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 08:33:06 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] drivers: perf: use us_to_ktime() where appropriate
Date: Wed, 13 Aug 2025 16:32:57 +0800
Message-Id: <20250813083257.504573-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0e6aed-cf27-4ccc-289a-08ddda4406e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0adU03tRes/rSCoajbfBavL2s5Qdp2908viBkx9RVPRVgbJa50vW/gXut/QF?=
 =?us-ascii?Q?Z5QDSNTZ/X09jD5cws+DcEvWoPzXVtPdJvHnXyRgM58eSqXFgvD7t35c6G4R?=
 =?us-ascii?Q?fbl3T4+u2FLCDWjybJ5HjVQCWn5XamGGwSY9nalq5Dhpp+9M4w+Z+6ol8SzQ?=
 =?us-ascii?Q?yq5IjTljGAbWA81oPZ64CSDZYFYiHUJsaOCA8m66OJCWh4/uG9GbZ1dp4Sv9?=
 =?us-ascii?Q?8mDO64Sm5QrxHTg8QqMlahBbhFK0pBXqf+TOul3W3FYPM9M3jXHps1Buzbd1?=
 =?us-ascii?Q?bJfl4TiV1oxnk0Q0TQB2qhcXK33FXVb6DWMXr9mT7jYpkPOOT2jt5i+IcCtX?=
 =?us-ascii?Q?K7XL/RW8zc2SdpLPEkdVUCIgQYfbjvL6l9sbRGADBLKhvnNu+8r0uXSxMHEs?=
 =?us-ascii?Q?DWl02ziGz8rvzMkQuRfYm0UHePk+S384d8CvfdQCq1xpXkq0b5hnMTO5JVAk?=
 =?us-ascii?Q?w9OfHVD6035janMr6bj0jk2LcCwbTAIxnfuWdzf9O9F10U6f+nwc2PHm0R+3?=
 =?us-ascii?Q?kNAatHLsdu6CQWE3kL3EdhyZHjSoNTsVcs8Ksfwvl57NQ79ZMBZeQzbBCyQ4?=
 =?us-ascii?Q?Tf1oLvRMUZ0KVCEHw2O0el6HDlNFZ51efKgA8lOE6ILF2eNjTcFktUcfIjd7?=
 =?us-ascii?Q?/CkMXqDYF5fxRFNRlQrhNkItPK5JxusVKbxMT6nfsyfMG78dvQY+ICrlpBqD?=
 =?us-ascii?Q?bUyMk4QEpZp9BCrevwCIFxmghc6916CnmacjqXpnB6cqGvjGCfIlZ330SbsK?=
 =?us-ascii?Q?smLpNGfvLhh6KbqQOGRXp6WzpYduNRiuSEBRS0XRVOSaqCKAHMYx7JMbGxso?=
 =?us-ascii?Q?2+7owt/vnqx+3bFmWLXntRomv3A/CKzVzS59/uPXQypoe5T0ZIHPuLvxDK6c?=
 =?us-ascii?Q?Ex6ZX9XKS98TozYiYInEXoa2Y6tX+FouWDRpqN49PKTMV0dowvlswimTAP9b?=
 =?us-ascii?Q?IBjf6oIALaK927xKPOMn1f0+psy/MDB1hQ5nQ2aQ3m3yRzKiX812fA7f9zHV?=
 =?us-ascii?Q?yoEjuMNIYpNB+q5mZ27y/tel06eOjPaQQu4As5HjK0i6XSi9bzgxbqe6qMt8?=
 =?us-ascii?Q?jGVwsPeLGMKNfYXFxlQ4t1A396ZOZGkzsrtqBdJuiMx3Zr8NeSK0BmOdgqDg?=
 =?us-ascii?Q?EguNVqLEySFPb/54DfKtC4x4jCwnF9VUEGZIQMG6CnJYCmgl2HLHheAIDNPk?=
 =?us-ascii?Q?gsUt0izWD57LY2shdwFkjuz9VO6FIwsdJfdfdGUgEuIF3ibh32q37eT40aoI?=
 =?us-ascii?Q?yb45hKRJvcsMAOwmHxLRi5V3PsNgF/BUvdkJ3v/IGttPxVTFZGNRmFa+lb9t?=
 =?us-ascii?Q?F+29pURNJaE8oPpEe/dETZYpxNAfcxJrnKC3jo/o4dbUhPlTSlhqC48YRG8Y?=
 =?us-ascii?Q?L+2sFS8csRzg/RFcwybcQhg1Klc8+goE3w8I8adIzZHnx1lbAwvgvODD1uLr?=
 =?us-ascii?Q?JWrleJrvLHAa5OTmGtvsSLelmtURtQ0+XGhjFkmMhtoFEj/LMf0nxJWZo8R3?=
 =?us-ascii?Q?KJXkZOLxgVaN3bI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPi2Ba3E8iDNWLGQJsCEX1NfumzzKUKdL9JzMNzLAKzm3ppXteAiwe8pnKnw?=
 =?us-ascii?Q?kugACYFp258HqlC077lb1wNzyuNlB+ckUAYgqgJXdj35IJXLm9tv7wpJ/a6r?=
 =?us-ascii?Q?5lGRWNFyarh9VNqAYzNP5w8y9zXB1QkuhDrVKTUFf46kn8buy+Rmp1K24toE?=
 =?us-ascii?Q?GxkoCeA4YqRFMKUlX1Rfre9hct5huDH28v9Cuke4oCS0hISjploFZ7zqotdk?=
 =?us-ascii?Q?xxAlz8Ak6n/ossdfJxSHcLpZYbG/Fz6Zcob3hYnJQ11aXv9XFeSSLYC1QAbO?=
 =?us-ascii?Q?sVqdeZvxXccRRjsflTlHr7tE8+Jzno8P9+8tPBiRwflhjrJdI0+zMci2AacO?=
 =?us-ascii?Q?0uVwuDLHi2Bp0PeJbC46UmBWyJMe48wF4iFh73gFU6fpItuYdrUnQc7ReNCP?=
 =?us-ascii?Q?tx0L+MySZRQ2Iju+c0V6/7se5EiSw9lZqmWiKQuIfVrXohKTgEr3yZzHphWe?=
 =?us-ascii?Q?QxstkC1ICSAyhVeiURb3nSdaGoFczzP75fXSm4az5qA4Kc3s4yFjKUTuQDQS?=
 =?us-ascii?Q?htGJkkw45wX7fy1Ewt4QRKR4OfkHsXQB+zsCyWnLcaneOsL32szhJsNsxjWs?=
 =?us-ascii?Q?C+14yzKTETCly2Rr11DrT76l+PO18XnMPNw02pXuETdIYZ5dxQejAxURiuCd?=
 =?us-ascii?Q?pOSuHToD2VYVEd8+L4INrMpROUUtf3VV45XznwYdL7VE9I+BzFuNwKeGSs5y?=
 =?us-ascii?Q?CO1m8Uk7FZ4UZDZ+b3FxOGv7A3hUYb8WP3zO9Zm+fNVCP+iTCLv7sFNfCKSF?=
 =?us-ascii?Q?gRf3OfMaQPMgmiRC+Vddes9diDnaiwT8e6Q0cSZFNbLab5p7lkMTlKj6znS1?=
 =?us-ascii?Q?maH7wVvtjagoeA7wgLny356v7nBP9BHHpD4J9vqiR0cxUufeHNIfWdHCogA8?=
 =?us-ascii?Q?XQ50Y1/C6XsQw3esKqB6ydpjTu+fMUDWpksgRRCNabXWjHMw+l2JaZS3Sxkw?=
 =?us-ascii?Q?H2hHrUw+mMdx2SEtVR5uhNk3Q/v3bqnx8cWQeeVXUuP3SrFNV6yHXE0DLZcm?=
 =?us-ascii?Q?vLLSkgmtDhjtce6YRFg430WmVqeYj5+kdxxHuS/ULxiVXK4gfqvdJwY43ZWb?=
 =?us-ascii?Q?GLXjuJ+NaMv41UnnbPfUqcab2dz2cEOQbwWbCMxYoToD4IHDYeTEumzzaHBc?=
 =?us-ascii?Q?sxYK+bifH0eDsh7jni79EmNpPVbBLPdc/Zno89x8c+btiFjEkof5TFtLldka?=
 =?us-ascii?Q?75PslOdvi+zqIBS0puVjClYjL4YowRioXmxEPbdWqAWGwEoY7zPecJ9mHzA1?=
 =?us-ascii?Q?zKWfiCl8nGl9hvuQHCMVuS8WTVrtS7RuqscT2IwyEjf0zQQfiaXa8zmn7uyq?=
 =?us-ascii?Q?JNdX3h9B2SKshNmVO1CJ4tsoem7L+MVN4/n12RmMPBhYtDnNjt3baHwh39ef?=
 =?us-ascii?Q?zeanPt09Sj1Phc70cfsUbgQ1r6WQF3oR+jqt1EiMhWGcePykdDOSQTabeUa+?=
 =?us-ascii?Q?89UUgGPluk0Shj2gT2cUNJfpfQ/OdAewlQpw9IbqZGgiVp5hMDriooYyh3nT?=
 =?us-ascii?Q?g0LhAXP8QZWBPiR4wviYBzSmGZouDKGmG1MoBP7VaIcGilW3P4v5iZRpnaxK?=
 =?us-ascii?Q?4fLBfC3WMlGj+7ge2kkyBNyXUt874Ny9evwmvOuh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0e6aed-cf27-4ccc-289a-08ddda4406e8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 08:33:06.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPw/v89QFyF648mO4TBMl4j6VFO3TltA+paPdHDWnFsSiZr+ztbKsjhPwfG3YBMhToLO7sECrxP7ojqxJaGujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5294

The arm_ccn_pmu_poll_period_us are more suitable for using
the us_to_ktime(). This can make the code more concise and
enhance readability.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/perf/arm-ccn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 1a0d0e1a2263..8af3563fdf60 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -565,7 +565,7 @@ module_param_named(pmu_poll_period_us, arm_ccn_pmu_poll_period_us, uint,
 
 static ktime_t arm_ccn_pmu_timer_period(void)
 {
-	return ns_to_ktime((u64)arm_ccn_pmu_poll_period_us * 1000);
+	return us_to_ktime((u64)arm_ccn_pmu_poll_period_us);
 }
 
 
-- 
2.34.1

