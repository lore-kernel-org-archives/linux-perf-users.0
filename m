Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012037.outbound.protection.outlook.com [52.101.126.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC143EC6B8;
	Fri, 17 Jul 2026 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284400; cv=fail; b=UuY0ZkSRkprqQDN6pUsuYjOYwvbR+GAXo2Nqe3OJDqDa0TQ2mm7dwsoAtsDOTlTZlOKX6Ajs6KzLuYjn2+GyrknXPrhW2+7BopHW5REXzmIg3AtnHuNmdJ0/z+ylROoC7XGEue+99nj/TnF1mUCACt/084VPT51HFpv0ufQUb2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284400; c=relaxed/simple;
	bh=zZM0APSLQ9vU+bsya1rDm0lnWuQpnxFdp+HltEISuJs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRsOreEoiKLbeUrXJSrtnY4fmjUUeKt4awgGWOJ+FmyrjvFZMoxB3rGk7vMKU9fCjoCDZNMFl+YV10atA8Mm7C4v8zMS9jbe5nupW4oNrfa6gR7Jy/HiEekyDnrvxHa7v+4xkIN6Z9r4EvbujKsHaWedhR1NtYEnU/WV2AF5Y1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=T6dr89Wb; arc=fail smtp.client-ip=52.101.126.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="T6dr89Wb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jski8lZJEeNsNNNwEICJQ+66LpUqnwPlwW13hKd4lBXyFsX8kWpvSzHwk2cNsr5vMLo6mAb8ZwsMjzXoL5LbUMAiSCpgToVAR/t8YIwlMF+P5GGEhGAqgN1C50P1wNv7+mV7Cqqs4TOfednhYXuNxjwlrg99vFySTIXEJmm3sPuZmgnugYAe5qRGbIHFZ4Rw0w/3/8NOoB9t05KA0ACZSl4xI2P3q6Xm+s6tNwp/BxQli9EoReByJhq9yNs8qP4p0DF1aYVm628+Xg9Xtr+SweN7yelrTFoR92gK6UuOXCZHXJ6XJo1fK37A5mgn2KNmhTxfs/3EqNzKdJZ4I8peww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqLKOy5Dwlv7qZqjc6PzehiBiHD7xL1s2xKrnFHLXQk=;
 b=UXAoWWvGhZRe1cN/txMp4rwkspTg3pNXL1u18qbzo+EcjDOmr5bkoPQLTl2Ja8pBR4EuS3dgP1N2ksFCgRLudnCGFlyReyJYXcU9hdS0iWIFPKOzMiCcbjrkYRh58jUYoBkc1xB1zqSRTGLIKmdRKv/K7zXMt5+c3yYxrKPMOhCDNTOPDX8pf9FhjmkuvFPU9fsINTjr1eG6noHLImBfPG3bdCAvWLMIgKZ/gnxnGM7lVtFVnE2qb8ymNlAgXkFMmIhrFpbTKOg84QS33I9JkjxxQWCXwathtxnECnbSjniDTqHk4OlKqrCTmjWuhle1i2jr6+IlwdomkoCVY3MViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqLKOy5Dwlv7qZqjc6PzehiBiHD7xL1s2xKrnFHLXQk=;
 b=T6dr89Wb1wiJ36r7/6i2R16PnvNKJdk7cZ9z/Ae4w7sGmSMdL29MpuC29cPX1ZJCO0sWgq+EtdpraqKFlyg9Vr4JCPWgOW+yBdloU3mApnkSCxw45V303ySRxGSovr1W8+vIaJBeWcWJoOryfVENo1LzxdDuLSVaD0OCOiKYM4I5G1CyzcaBIhg2bMll7mvFKS7z44MFrx51UflY3Dv4Lyt6CUQPi+uQgJRcoeKHv2TzqqNEmZWVVrMLP5D2s4bEU+Z7bZWlr1eMCkSopcStHmML1ag/sE6kLQkYs1C/uI4rf/5dbsp+8x38+7TvTOuxslq5/tqiNOy9c5Ye59XjAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by TY2PPFF72AB57F6.apcprd06.prod.outlook.com (2603:1096:408::7b2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 10:33:15 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 10:33:15 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Chengwen Feng <fengchengwen@huawei.com>,
	Yury Norov <ynorov@nvidia.com>,
	Pan Chuang <panchuang@vivo.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING),
	linux-perf-users@vger.kernel.org (open list:ARM PMU PROFILING AND DEBUGGING),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] perf: arm_cspmu: Remove redundant dev_err()
Date: Fri, 17 Jul 2026 18:31:18 +0800
Message-Id: <20260717103123.34887-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717103123.34887-1-panchuang@vivo.com>
References: <20260717103123.34887-1-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1defcdc5-efa5-49f7-5f49-08dee3eecf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|52116014|366016|1800799024|921020|38350700014|6133799003|10067099003|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/kuNCv1tH9ijh2YmzZ/imwyKd8r5N4N5FFdvFXPvJmw+khtGXzEo/EAVm+rDzNEgIs2m2hQZZz4OwcrSsyAtCVhZnd9sUyU+uBzseqocZA/OY7R4GglSqO1+tEysLLVeGxMvZEqGtpd4VCzrCaMmEcSs6PkJGKn2akQS4PbW5khq9q31GYG1IhUS8bx5okBQNMIPiwJleOIVtZEEYhNEeBSTOA1K9TZxTFKqb87PcmD9m5JkK6g+Iwy25ySwbpqG5+TLvds+BPazom826h9eBMAiAUmF5DNnKXRCHdSxmDLi7qNP0atnCbqKKOrpfeJ7tyKwlPeYR/SIQMeiNc2X7twXy07WTdPneeiaqvRkychMBLCMKrtrEQPiXcDwAqkj3zYv7ccxWouSiJSxkzHsMJjP9YmNyCrTWWoUy5opXyxRo+RM/gjTKoD2wWGZxmAXclT/hYrYEeN3t+pBf1N46gOBNEGl+EhL1JdA9DPc+O28M3kGKo8ZK6e/544Jk3F+UG6QU0PJ3SNuwHeMWsDH5s1lzK+dYWm6/8Hl9Z8o+P8UxFH4zI5VwgyWxLMHuwn3gFTlzj9FpJz7n8Z7DnNncC0IyXgrHWo1IBK+9zlcKw3MrNcmhpgIEs+i+rwaC4e/NDwptV7fZEZt0WFg2GNKS1LmRi1T0Y/3dieSeAnbIqiM1qmXVd+pIQ3mEivDJxdFBJIhCiFdrzGhG1XXmSUmmlISqi5aEAfDGAyRz97aBWOySr+K2gUy6sYtYkCevmnv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014)(6133799003)(10067099003)(22082099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AheHZeIWrNeW+gm/IyqyXR91+h/QRnO50Ud6cWMUostDqSBUX+BlcAkTXkRS?=
 =?us-ascii?Q?xbG25TILd1rwRWl8pD5b5rl7+EiGTgpnLeIUixB17mu7+WElzloslxMYKR0w?=
 =?us-ascii?Q?Ml7N1jw1H8FkdSnZPsQ+fX2qMzRl7XbQQrr+o8nj4P0DN5bTwvXBLNLhWAB5?=
 =?us-ascii?Q?nF39d+tkv+LbzL7iTyfW2uDQmJhEHtRJ4rJK1WcEpiZd9kkfd4VAbvz6yJwG?=
 =?us-ascii?Q?dLPZtDLi140AaJOxU9hgShQjPRivZAPlu8OJiu7CDC3QxzpE1VY3Wjbg3utU?=
 =?us-ascii?Q?FKgvefr/mDFDlNXXWcoW7m4tsHOos0hHMedNW+2mRyxIYeT3ovXIWRmKs7V1?=
 =?us-ascii?Q?3qe+SDaA/zn2IjmZj66daazpazQna9+duH1AYq+HjkEmJBpFi8Zs0e2ecC0G?=
 =?us-ascii?Q?yHlgVMEmIY4Rh7DM5kIWTIukYc7G+gmONpoHsW3hqem3LipsGQGQ3AMEinOa?=
 =?us-ascii?Q?oeOMuXk6E/bsEH+8FrYm2Izx2EBNvmMtnJZbQx59rNGrgde6pjQsWI87HdyL?=
 =?us-ascii?Q?Q+riHeBVB6Q7pBo3mMMwObr2VjHsUTZCs8dTrjJDvZgSLkEFhGj+g3PBH/oq?=
 =?us-ascii?Q?jzi4ep5fnKW4qulKZOXHdugrOobmIcTosT2N0piB5WgvbwZd0IFmXrTin04f?=
 =?us-ascii?Q?Vbihcmp9ckxS0bz7oqkGKlH61LdCrsuqo7r0ZC/CdZMs3dPQvqFH0bxbFGCS?=
 =?us-ascii?Q?vZNzpb58GGeAuHU/pTPeGeeGagTxFyzif5nypzNCJzw+1/c0ghRbUBIa+87X?=
 =?us-ascii?Q?Ts2b0ELzMraiZU80eXzzTuIsvBGL4ye2HX5FABWPTMV8efv488AEUkwHJ+lI?=
 =?us-ascii?Q?z0Bf+1quf9rgkLbKqV/2mTuqCRkUNk2pGWBGyYweQtp079Fp1qn2czFiRohT?=
 =?us-ascii?Q?8bwYj563Xgc7KXl5nLMWgFzA206opE/JpU4K3u5TJqVLgg+EHjSr+VeDZQnO?=
 =?us-ascii?Q?/x5syAINI7t6v/Dz7npuYDWs7NnBd7e2jSOj0oa4GD55eCST+zb/EAlcK9Bl?=
 =?us-ascii?Q?SRPe7CLVyB62SQuwE40J/c3RlNRtasyZGs7nH3W5U/4xYzF8WcguiqkIHE/l?=
 =?us-ascii?Q?0eMjfCtkxJF+Ke/FluTe7mpwoirKIClhLrMNv7761jUjcoDhDW0c8JGu+cvw?=
 =?us-ascii?Q?/AI2efn72uED/tC6rdNzsdPfyHqzsedHnd8rXspse/yrhZU3e1ZnQXVfDXdP?=
 =?us-ascii?Q?XPJhq30Od1bbjldbXwFFExy+uB2qnMRX4Ml0TLiJt1hOlmfRUqYmXd0+VIRj?=
 =?us-ascii?Q?ckGNkUZK1xxQE6nRbh+YRzNqRnJQybiTKjjB3noT/ZoKDUNK+3Vvytn9hP35?=
 =?us-ascii?Q?tDA6D8aSjhrYDsvjXKqIbf+1UVQyZsY3sTvSoO1bzFRH3DfqJJYx0dFwIMRd?=
 =?us-ascii?Q?ADDCVY2XlLKah+9k+eXQmQceHNlO2PeFH1qxDSaaluXngtT8niaOJvFec8Hb?=
 =?us-ascii?Q?+l38lea+1fY6GpjfmR1KW9/g5Q6x9mM8RHQOtrPs5+nxJMqQxs7SrAryH9XK?=
 =?us-ascii?Q?ELkzzISOy5robwVEv0HajwQWdvlGoB/Tav9W/kgNISceuJqN4+lAlC2P98gx?=
 =?us-ascii?Q?inxCOxTYkZsOIJXrIu+7IVzItBpuZdjZWOpDOIj0K/iqJru3DCOSFZzQg5oc?=
 =?us-ascii?Q?1e1Jyb+elp+3hA6KP7aP4WHw2QleKnwdKiNHjGfZfDt9uiNn+2Em2uwQYO+U?=
 =?us-ascii?Q?/3PNo1CsJp95r4nfhi5++VzpwbaOmY05Gy+OUhj3Pp9vwpA1N+uLzJAVa7Cf?=
 =?us-ascii?Q?mTUj0/IxRQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1defcdc5-efa5-49f7-5f49-08dee3eecf2c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:33:15.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9kBKpyjiPg6SAm2Ya2+8IJc5QcvurPm3myFWObqivbvZRy5niRnvUCeyW1BkGZNeYDkQvIkO4l3pbv3/wBXIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFF72AB57F6

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e6292021f653..ae754363fba8 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1070,10 +1070,8 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 	ret = devm_request_irq(dev, irq, arm_cspmu_handle_irq,
 			       IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
 			       cspmu);
-	if (ret) {
-		dev_err(dev, "Could not request IRQ %d\n", irq);
+	if (ret)
 		return ret;
-	}
 
 	cspmu->irq = irq;
 
-- 
2.34.1

