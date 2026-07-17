Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012039.outbound.protection.outlook.com [52.101.126.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A4A318ECD;
	Fri, 17 Jul 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284392; cv=fail; b=KhhQIhU0PXpB7hxY1nko0ZbtAOaYhi59GtYSid8A8lIHXbHh7wKzBDTCS1CfROgHuZbci0XMgeF83TnKN7472Lba29eBLF/9Jf80ckM/c6sYDLEr/0WMvF0rOQlii9HFrkvf4CZ4MmHuZVjmDZZdSaRSnFFnxy+Kidud9/xKaFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284392; c=relaxed/simple;
	bh=3sP2QEhTd5HgNUghonoC1c1AuFXQoUVBMTMjM8JD27A=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FThdiulmtRFMa55TJw2DIWNdfe9oLtMXw4PZvCOvKy04q11y3n/4Z+9eVY4jOfrJJ44URu4a7/6RYwrvrRcmnR3sKSA3KDeF4jfLdSKJvWedJesWToJcm3EoMsswOTMGfAFvoyrNYWBwRnDz8o8m33THWpkJwSCnd4+tsgdrRrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CuSjcvVR; arc=fail smtp.client-ip=52.101.126.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CuSjcvVR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAsQf22LisV/lfKamXDejPZ8Miwhv9pHbC3POMUeAKElyp9+Z7whlJTzxQL0DsDoKk2/SMyeex2otvvmphuycl5rkvO6LBP7QbJ9a+8ELxPRC0lFOWMsMM++Gdg1Jht7xreA7yHOOPQfRaSOtBi0SZRm547BTAsYvsaBkox3pBGw2TavMb8HSZAIBmoUADWcNjO4HNMF4qonT3yp7qrlmvZiGLWyEs0Nvbi02M+cnqLvTJZodlkI0Rnyn5bmH3b3Ps5sVcZFVqq5JD1TigK0tN+682bCQixwuvAAORC4BHm1QMSoJ/ycJ+kGYkTlxBkUJGDLIIHHp+NHBpwzq9hRLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9EyU0iZnhU+t3tpRGWjOjeYdZ313otMwTLgAVl8MDg=;
 b=FRLs1/Sr2DrEMfMFBfvwEx88oROtRLx0TOPA7tb8N6V35oFoX51jJpXs8sb0Km5KiAo/7ibBpPQ86bWS1SDAyLHWqEm969BOC91IcKKBJ4MMONrWYemLx6DCWg+AEf5qe6BbnQcxUSL7QYBi5MdpxxFhw125wR2JHe+8pEy/BEsGUCwRLRGizFI7JFRrNuNsHoUEaHqlG0Exkadq5ZRNfZyyAW2Q47w1prD9l3s66bsUuTPa/oxVqkotPpat7vlh67NUO19YrEizrW23GLcFsGZ1pLL0Dky7R93QG0E3GU64uZq8Ex9kZGbxAQVsXvKzJQ0h5vOp7Fbs70F7D8wLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9EyU0iZnhU+t3tpRGWjOjeYdZ313otMwTLgAVl8MDg=;
 b=CuSjcvVR28DkrKGZJy+CPoFc30ZZmJJSFRZo/Rj6eueoxMxDoTFmhaPkIUsaM1S0JImM2hiLY3U3VksA2VBZvLZxLOh+WOdUYZSvgbiUYj7B0Jo3uwi0oYAaWcpm4MvCsoH/1FL5JHepDSxBL7OOhEsKeZansaKC9E3CbDf3z6kVr8j0BaTS04cac9zvrOpKMIy7Mg+5kLmwEC2BS2oTP73HKEWy+nTfwL+vOCisaEK+LeBNG4pUpPZsLf8kdlKAjzuIQcALni9gfe1riA3kwaP5esRMyPFuPgzjoAJK1WKvJoaXqpSZoU5ncENbYfGJvJtyRkP4Jm1FI206sSsHyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY2PPFF72AB57F6.apcprd06.prod.outlook.com (2603:1096:408::7b2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 10:33:07 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 10:33:07 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Li <Frank.li@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Yushan Wang <wangyushan12@huawei.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Chengwen Feng <fengchengwen@huawei.com>,
	Yury Norov <ynorov@nvidia.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Pan Chuang <panchuang@vivo.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING),
	linux-perf-users@vger.kernel.org (open list:ARM PMU PROFILING AND DEBUGGING),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST)
Subject: [PATCH 0/3] perf: Remove redundant error messages on IRQ request failure
Date: Fri, 17 Jul 2026 18:31:16 +0800
Message-Id: <20260717103123.34887-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|TY2PPFF72AB57F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b580584-d9be-44cc-32f5-08dee3eeca1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|366016|1800799024|921020|38350700014|6133799003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	g6HGMlurLTQTkBUK3FpsH5Higa/cBRpRSG6bv6jOpbd9sjL2eS+exLvRajKkkb47lVGHew8bqa9LhVfkCKO0NN+W/7W67N5ab/kTjL2IaIn5fxmbgeRnI8RI+BYS/YMS1nyffB3w8+Ck2EpQrUtC6JqJjGn89anWETTKC/IlxzoTLPfQ0NM6ZlH83sHskSSL4/j6OnbNqEf6HPhWNPfmUx2BkEQ9yMPC0lBYoSYeEHsZYIHbYPGwarXzjYJf22S1T+Tmr+WnBi75XfBXavJDikPjw9NmFIa0/cgwmCA7n5kJyn//rMTVrOoNcJsdlkbS4VlUQA/VJQGMcoWofGi8YlJwCPNF6as/ClqsljfeYrSbTc1uvEGpSdHkElI+mQixu3br5Pw5B2aJ2oBMJrJmTfJ9wavjZC+LSL0gKOqEAnWM1QROHsguK9Mt9zQt+YPrbWkM8XXDf0M3sYDLykNQZgKXaTn+HE9Lf1wjmH7KGGl5nYKZjrTUuu1Rs80RGdMxBEjzS8HJMrweEtE8YRTdZ3wrvcb+8PqY1/h6DkH8oMfVxNZKMsVFh1q7iLAf+PvtYIkNo8m9XiA1YVTVoa/EXxN0JWHh49wAAo9m4q/PUAnktKpYO9CfZXs1FoUmzOdfUwh6hrYnP+LVQHX5eZPdjEgBLtVfHmYCSuMKvw7cYTokQgABdz5FZX8GWUL7GGoGJLRBZB15VqCmZuORUFRicUE75CHaiHqCzxlfIbIW7Nf2NcoZ7Dgn+AfttQQxa1oZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014)(6133799003)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oy7V+G5OWVwGK2njvEITEzfupOFNjuj/ngXkUJQDOarKNmSEK/3Y0UXeYdWv?=
 =?us-ascii?Q?5fu4C3o0k8Mm0M2N6HIfX7P0VI2JvoCeuPimA0u4WZ0YBVGUzT0MNWzcjPXD?=
 =?us-ascii?Q?wsLmxqHzPbwWCRy3exDcc5l8A5Hd49pHQejkcph5uDQ5T2swmfccOtvSAKG1?=
 =?us-ascii?Q?rf4z5vWR7UiIo9+MunvtYQJOXcN9a6WSnAE/6+hDr2HIrxnywKMW87rdGOZy?=
 =?us-ascii?Q?BCdm6NxkNQqYwByQ1bkm6Y8AJEqOyrfTro2w+ZLVZxSjjBMirVStFzdYs+tC?=
 =?us-ascii?Q?ut8U+KqBvzQcRA9Pibco8EGlL36mPCZVklWE1H8fCc/VPC7gGrGhxjocbbZJ?=
 =?us-ascii?Q?NAigLTrCHCM5VsAZ/hhuInd9xiSnfoL6IeVlc5P0pCORFRyFBtzFILTuLXPE?=
 =?us-ascii?Q?Apl2t2Jyjwom3VtT0AMYDyv4Ki1DAudfrUatNqs0DcGjXdKZwv9A0iWQlbls?=
 =?us-ascii?Q?E7NBrUJI+ztN2/3i4lcZRS8UXhzAaK5a/rodQ8Gc81OMoGrDYjPooeQ1oyj8?=
 =?us-ascii?Q?T9gneF4riqGsw05ZWu5FOTegLSDC6vdbGnBHulm7wb58KGGdUpVOF2meaJR0?=
 =?us-ascii?Q?aH3xZtfQ+NnSdcHyBnQMzi3kNdzDD6ffkOXpqXShO3R2RCbB4C1HmSY8sUrg?=
 =?us-ascii?Q?P4eIFBfiCy0BUEdPP7VnWRYB8Gmtz8PPp1qgS3Q9ZgFn87JnwnZwzbpEg3y5?=
 =?us-ascii?Q?bo8WoBtZcQ9mHoNvqo/FZRPsVE7vBaIQJ9K3JsbHpKrmrwOZ2Yg8u4frOQzq?=
 =?us-ascii?Q?+99UTbL8svV5yAr9fuzAXTXw0a3lXw3vZc190nu1o1+HhJ5QVZZKE0roLHw+?=
 =?us-ascii?Q?gckmcCZRACbemi0ob/3N9CkB3jTPyEDwJitr1SlTAXE9hBO80a3L1+6aeOYG?=
 =?us-ascii?Q?knuaWNrzcFhJXiUqfVmd/vcBYsbRK8YbXAZGXp93wuwnUjrJdC/wEI6tnXu9?=
 =?us-ascii?Q?NOQiNaC5y8IhWgOG70m8n0pKd9opXlPToO9esphLHM2TG6nHqanPp/xraK92?=
 =?us-ascii?Q?FDRGptr7GEXeTWvNVpg59Wm85ZhMSkSwkKK/LqGMNSXUSX9l8odPGDFDnN5n?=
 =?us-ascii?Q?gcz4mtKSSbfIALBhq0ML34QyJD5OxYfeAtjSCyiQYzMUq1RxyOmkKhfyswrR?=
 =?us-ascii?Q?Gp+YPl2h6iJZ9b5YjHOMX744qQeyh637NEoY5iycDRzPEg6kCZY35KLaeSlS?=
 =?us-ascii?Q?tExL9IlfmnqwYu0rFJvHx76ahThkCGNnNLNe7KBfSAsPdfsOLsQjZQV5Fa71?=
 =?us-ascii?Q?OdvukVjLLRZTmixzDYywf//keSqlqQae0McPU3bHPl5qTUQy28PXi5mZ+e3a?=
 =?us-ascii?Q?enKG2N/47AajS9XdE/YDjWIn5uuMU7SZo5mMHfBy97JcZFKmLIJzyz8Hhgu/?=
 =?us-ascii?Q?t01Jn2Fwd3BsBqvWMQE8hXk32Pl/vZfETo1i6wIJo1Px2ISvpJxPNcQtRSiu?=
 =?us-ascii?Q?gxy/SK3eRwELME9e3nD+ljAcHFdSgnY5LthPUjBQs3p6DhIdzNJoFUO8b5Dx?=
 =?us-ascii?Q?H0CiEsUH611aPc/XoFmmZCjDUhLdzl189dPgjno3WdWTzZPyT9NY12B8eLvH?=
 =?us-ascii?Q?jCTqFlSQKAbDABIBa5bT1+ddrx9Zb/egY5Vp6KjMLWLGrF6UptzZZtB8fu6/?=
 =?us-ascii?Q?wzMCA5UcVdiwQrFcWZwU3S6LH0m8oOVvPbZi8q6tABUfRRJTaNGCCE3QXqwu?=
 =?us-ascii?Q?OBIhBXhLZlRYBglJNCH/X/vZ4gYeyHzkyTzMEntRQUw5d3lVjgOzuSDrqGdn?=
 =?us-ascii?Q?EQaB/c8Kxg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b580584-d9be-44cc-32f5-08dee3eeca1d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:33:06.9494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l94clO24hZ09KViRlFJoZqPkaDRTkpT6lENXXHwmloGLJvPRR0/9r1ddhCmHJnMIN6VDjBBVolIakmbsl2p2YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFF72AB57F6

devm_request_threaded_irq() and devm_request_any_context_irq()
automatically log detailed error messages on failure via
the devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in perf drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (3):
  perf: Remove redundant dev_err()/dev_err_probe()
  perf: arm_cspmu: Remove redundant dev_err()
  drivers/perf: hisi: Remove redundant dev_err()/dev_err_probe()

 drivers/perf/alibaba_uncore_drw_pmu.c        | 5 +----
 drivers/perf/arm_cspmu/arm_cspmu.c           | 4 +---
 drivers/perf/fsl_imx8_ddr_perf.c             | 4 +---
 drivers/perf/fsl_imx9_ddr_perf.c             | 4 +---
 drivers/perf/fujitsu_uncore_pmu.c            | 2 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 3 +--
 drivers/perf/hisilicon/hisi_uncore_pmu.c     | 5 +----
 drivers/perf/qcom_l2_pmu.c                   | 5 +----
 drivers/perf/qcom_l3_pmu.c                   | 5 +----
 drivers/perf/starfive_starlink_pmu.c         | 2 +-
 drivers/perf/xgene_pmu.c                     | 4 +---
 11 files changed, 11 insertions(+), 32 deletions(-)

-- 
2.34.1

