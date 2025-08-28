Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013021.outbound.protection.outlook.com [40.107.44.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658323A9A0;
	Thu, 28 Aug 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383927; cv=fail; b=ailGKi5t9lAYQdBLwN05wO7svejFc26Z/DMlwvAdmOUM6I5amcL6kVf3L1WIKHCIuDZSL9K2CDFJ9J86GgUCC9ZzTojsKAneRqDfhPZSaOH4i7vdFEC9ZWsAwOIAFx5FDjMVaLmTTge83DTnT/H/V6cd4sodEtZDZar48LSsVGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383927; c=relaxed/simple;
	bh=T7eSVad3rzZsIMbkfAiYL9cWnneGGFJIxPVpylisKL4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D5jYrMBWrOFmaPdLdsnV8Wv1l46w/QcLb1pBzEkP+agW2WL8L8WS3dnAXvAxUtuEOshyGz2Em4T9KmysfSOKBP2cMTHKzHN34iG5hiSdgwmX/JvvU72qQcwQiNkICZnL+joHoSTJGUopAOSXYHSHtiskS6WLs+deRQb+e6oK/Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=W4bNmMBI; arc=fail smtp.client-ip=40.107.44.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="W4bNmMBI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTY3ptHPbHscMomoE0IAntEbtwgdOn1BdvMUed//jB2uLzJSMkrnazgjP73HniGoUMQUFu8zb080Coz1bjaLSVGIvZaoklrF1iXm2eCkxij07HNfcn1iR75KOy9YAyiKiFmmasy673ISS8+Ue4xnaKnnM2mBX7Q1ob3UPnoTjorx3w8hvaLkAiUh2koZzonigu/QCje2irnkWjY4yDhD0CRPVjS6Cs99y9szXxFWCtURDYrkgQ0BdzBPPv8vaoYq2hhKAeFYdX4TKBKCEGkEN122WMluW3yT0vjnF7kQZ7h3OC3SdAPeAoXzeBzSPzzDrpvFY0TbCF68LK0wn/wGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VRc3cV9VAe1KrVd2GMCa46k3VUdGpFsJDSq+luClWM=;
 b=RmCkrJqSUzpFnYjblvLRJiF60m8LQJnK+jmycwdvO/nRoZg8XjrNCBBdTx5FcSrkdUb7WKoA1Ol8xQCM7Jit343x1U4v3iTUwgbUQ/M8Q2kNGLScev76QiMF3dD6R+gppATjj/jTtn1EHJwOlsrxWW5JYLgf2MiccGH1gh3ZE2Tda6tWcVUhi1abKgWwmuCXFN5xXyeaF4guNrP9xpqCjl5hjwTPf5vxarKTlXlFOv5zdU8lhOKgufpcbKl3c4VnW4tHSaKcr0BKJuGfCKekeSeYoGBOlygUq6Czu0BWkDYMDDY6svA4KJik79g8XZTQqvic2kRWbXJ6Sh8HpVVhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VRc3cV9VAe1KrVd2GMCa46k3VUdGpFsJDSq+luClWM=;
 b=W4bNmMBI0/ymMeIm0r9B6+Z8dl75S7/WcKJSd0gOnv52SkmGsxT3IpQ33yd2u9xlVVjfwrCnty/baucNSpu95DMy0rVZiFx72uuFgZsYyclsYzF/fNhFw3cy4EdBkGN1lCTOsGu6G+G1nqBlzEQbNvRmHy9udtly9YZkDNm/zdhEnN9j8q9kbc0/IxuwcwRjazbsn+LxZHXfQzNqWTw7Q+fCCuhr0P7Q5/b6D+gR7vVZYHo72lIz3S0PySs8ApUdw5Fx/hKKNh8ZzejpY2RTuHBAj4+eQDzSx6SZyNgRUYNvwAJniVFx4n0LsZenCtunrnnfkEB+cYQuIqpSCwA80Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7287.apcprd06.prod.outlook.com (2603:1096:820:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 12:25:22 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 12:25:22 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Atish Patra <atish.patra@linux.dev>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org (open list:RISC-V PMU DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING),
	linux-perf-users@vger.kernel.org (open list:ARM PMU PROFILING AND DEBUGGING),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] drivers/perf: riscv: Remove redundant ternary operators
Date: Thu, 28 Aug 2025 20:25:09 +0800
Message-Id: <20250828122510.30843-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa58db5-8074-45c7-5114-08dde62df528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GbzZmm4I+3Bw/eAYbixEESKK0PWi3cND5Fo34IF0IyrRgcigVWH/E1QM03Xi?=
 =?us-ascii?Q?Un6su/Rw+R+1g2WhQoh6lYBCesFoUVZ+gdJtSeQ05hwuQLc/aBv+9mL125Hj?=
 =?us-ascii?Q?wcfz3P+CGIhNs8r5+fw1bRolQ+3d8/XP3vMPdfI+RdXjufwW5bfZTQhDvxE2?=
 =?us-ascii?Q?mAQJnGxFHnFSRboAoNcLclzIiReVn9FKnopOvm3dvYf2oISfD/grOb1h900h?=
 =?us-ascii?Q?cUOmdYdU68ESzKAmuNSoyzl6oOYaDYgk8QpYQN+wyC1mFSzJs5mNehnn04al?=
 =?us-ascii?Q?04J7zJr5JbppOuyb+PROjU8TAbtexwFEf9x1knwk58nusTTkC/6wI/XDET9o?=
 =?us-ascii?Q?OpPPd+77tVyJkfS/1ByOYMyC/fsC9OaI7D81GwhkmapyEUf64IFlSHbOVpEz?=
 =?us-ascii?Q?wiY6lA5yPDKJqJXidXjOZnFXkd1Vvmt/QKmGsA0S8/0rnDxpdauaGjzlH18x?=
 =?us-ascii?Q?CTivvxDhH2IkqmZ6rURdmgA5jVmOBidiPzGOOHwcrfSrQlTkJNsL0aNh+I9O?=
 =?us-ascii?Q?2UGBqsBYIKD/FmS3+6203LsdeNIWtnppbKmuyJyNOVGphT9auBIU7mcMIGdO?=
 =?us-ascii?Q?9s05W0YiBSygUCfowoljJNz4PB8Nn5JYPh3sXD/QpUBbkDYZChgGv+QwAChu?=
 =?us-ascii?Q?faUkJo4VpUG8RY7ZyrT7op542H0PRMHh+m8jLGSH5tRyQkARrLNcALl/8vWb?=
 =?us-ascii?Q?j3WRUaDcXE1PuAk8IIKsqew2RGyLp5nF6fAJtD7tq7enn9QhNOPU/Z4Ixomg?=
 =?us-ascii?Q?+bb727Jnot4cXKcD1yp0OjTVjvZjD3JBuXOaU4Y/gJe6SZqfthXSpVql1mLP?=
 =?us-ascii?Q?/xQEZeQC5vorBCdnnMfPJXBQ13FKePjRZ6wfQIAWbcc6BxKDVLlHsi+MEbtv?=
 =?us-ascii?Q?2drQ94VqbiPN/RmKqQpm1+M2ceZNrb115CQHoWAOFEuCfz46zJdwVfK+Qk/e?=
 =?us-ascii?Q?tGpgT83ZieNYzQWyF0wP+lILjrE0e+9/HrfkECRaBnXRMpa64qlrNTY6BD/p?=
 =?us-ascii?Q?opqMg5Cl6DjraavvsJvoZ3Tf27pQcyFRi129KpT5HQF+a9cL/65HXCleyNGW?=
 =?us-ascii?Q?GSlPGZjaGoW5nSL0yee1/PNf4UC2/MC2Zle+vP1LK7s267Q3Y5ircdeMI6D2?=
 =?us-ascii?Q?gXURj/2m1PERYB1mjqjYY2bz4nVJ6vT4ArcbPWCtkFbraEYmjjF3ln09fRlv?=
 =?us-ascii?Q?1OYswMqADmJIMzeNH/R+5NAdKAcq8+ltRXmvILKNS0Y9EmnA8tuqSBMN9gM2?=
 =?us-ascii?Q?llXkPkGZXjfejcq37NjxI0dGrGraOUP3ljvUgfjh7PpBqInso49BmTEEQPJe?=
 =?us-ascii?Q?l5uKvf2ukjPtze6tyrO3gKxvsdSiAkLfZSWc8KEwJOvjz/SsnTP9qlmtMqqV?=
 =?us-ascii?Q?B4nNrOozkxKJObKrkW4mv0GfRhmuYLL7D2pAfvIwgUWH8kh22CXj8ojfDVrE?=
 =?us-ascii?Q?xQ5fgUMus0ANK2QcnjG7O80EHa9y33ata2zEIkohOHxuDt7tyDzCtNiiXTmd?=
 =?us-ascii?Q?xeGhvJshXj7cHjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HqCR/QN+SZWkdXeahd81DSPWEGc/KkyWdLRWzPednINbQibf7Nw79gyeAkim?=
 =?us-ascii?Q?uTb/k1F+slu88MBplFe5IV5YU6ZeZMwXNGWKsdhjMpbW8aD1srT40m/TqMEb?=
 =?us-ascii?Q?eRnoaOoo53dmAWcZDwd3rGRvpctL93Uq941RP6RAxk1mNxsN9HHxiEPv/970?=
 =?us-ascii?Q?8XplzJyZdLH05s+xZtYLFb3K6HDVRi1MnxQOIbzVZaCLrKrIA9FyIizRrspr?=
 =?us-ascii?Q?LJB5zXN387Y3ZjeINi8W5E+ziA6kfmtuIQtA8JsT0TE6PE0GnKymwKRQSk1n?=
 =?us-ascii?Q?9XLuCk+5HMUF8olrewf/g0asdMZCrxJWgMAWbflbNLOEK7j4moBH8msDhxLw?=
 =?us-ascii?Q?UdK1xOLnbMjceU3UUKj+PVQ4a/WfoQmxq8LXhSTsuxMqRyNsLXxOXnd9lxGJ?=
 =?us-ascii?Q?lpHWNbBnf7JyQ42GXtgQqrw5o1wKLNrEsGzqXAWbdPgAV+B3fbgrEzVb4K3l?=
 =?us-ascii?Q?VKLfQJI9Cdis9zPWDFiksRlqr4IRgOrbOFZkc5Xml6rzteetrCb/MtzoIzzm?=
 =?us-ascii?Q?/ZsUwWZduc13P787U+AHvdZKevToKvFTmzGmj+06mfDBk1CmfCHeo/rJWp37?=
 =?us-ascii?Q?QJXTH8Nc88yr5KGGLim/zbbZCC1oYgSgEhSexlPTtDmziKoYUBcklTG+Yw6v?=
 =?us-ascii?Q?Ejz+7Siqbp/wQUEQpqCaWikztn4o2d7Irs7mbpAUMndhG9ZYWcFer9Z3U2d0?=
 =?us-ascii?Q?Ss9BnJr9refOw/Fa0IcxJ+toaYEH27ntbZMKDsuvkNtyrr0LHPcnTTj4e0kR?=
 =?us-ascii?Q?ihe0uzDxZ3tHdLjGWcTJBPDk05mNgZmw525B6kKPIcSaMY9j3+UKOCMjArHq?=
 =?us-ascii?Q?i32KUgWtK1sIePBXeWgWDyjxYUwPv493zP2bwRfkj9uVVU+jb8U+7K4ffSXM?=
 =?us-ascii?Q?uvqwm+o5VVFgCoLMHrS9XrNZJFwRDOrfbeGHN9SXyFK44PZROcr8R5urUVgb?=
 =?us-ascii?Q?Eik5xky1JCLcq3V+s3G/hRHdcLT/X3RitXGymDYWg1BMg3AVmY+Zpo2ocjRX?=
 =?us-ascii?Q?6djvwhb2wnNBXyfQIRZoiDywjTVom42WLWPtjzO1SPYQsVfj7MK/gnLohZiq?=
 =?us-ascii?Q?AIQv8jzCYG46YRKTIgxm70PU9yrt5FkCfPsw9mOyLLeqxxgLBbdl4cJHAIM+?=
 =?us-ascii?Q?wZrx58k8WjLEAj0CJ09TB95eMR9KqSWL2Oj38rWidCazdfnWAws2cjbE1aq+?=
 =?us-ascii?Q?/YsF9LUbKMQJAH+TOEZMISOE7miYmcBs6N/6xX+JiNW2ecOTyhYtlWu6SqDj?=
 =?us-ascii?Q?625rmXIsrsGD9HFAbpwcM+pu1I6yto3Bj4ZZ52i3G+Hrw3pgFduuqenTl3Y+?=
 =?us-ascii?Q?BCp17kavbzeihGHOlbnO5q/W8doMCkrUtYLB2g0mfoFwFuvcGLfznllyLMIV?=
 =?us-ascii?Q?J5+lc2RKAsS72kTsHeU/mkfHa3lZ+fVb+Hqm5MaznBf1ZYHotDl1QDupbT1E?=
 =?us-ascii?Q?x1+gbk3ybotJ9FFD++OmgZJVifhAUedPDCLfOv4OAiACkrmOeGo6VSYwJ50/?=
 =?us-ascii?Q?XXUF06yxJt6PqyXfrnLkXv6xUWInMtuiEJ4SnYQMXEEXbXZQeMmB+ewMdqwi?=
 =?us-ascii?Q?R/+/sPuFVaiYBVA5KdpMcIivQh6+Mr4nVT6VlYuV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa58db5-8074-45c7-5114-08dde62df528
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:25:21.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjYtOgT4P5NUsQ7kNCANegKsFkiGOQE+ZLuaD+iCQbpRiGcySAaHNQPjvoA13ezT6eL26YJO1Fd2YETQycDLNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7287

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 698de8ddf895..c18dbffa9834 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -339,7 +339,7 @@ static bool pmu_sbi_ctr_is_fw(int cidx)
 	if (!info)
 		return false;
 
-	return (info->type == SBI_PMU_CTR_TYPE_FW) ? true : false;
+	return info->type == SBI_PMU_CTR_TYPE_FW;
 }
 
 /*
-- 
2.34.1

