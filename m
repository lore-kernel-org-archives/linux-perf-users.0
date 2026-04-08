Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CB3CF028;
	Wed,  8 Apr 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655908; cv=fail; b=dBbjS3FiihXuVhHNNSMtsbOZ0zRYYnqG73O5q5EQF6qs5XX2o57KieCEbC0XNrQ40x1FatFaOQfis3Rt+JOtacdh1a3c51w9FH549SNxlu8CObT9e/9WuG5hjgkIcuh3AF5RHDMdJTZYKjJ6jfo7cB3RBM6w59wjB+Zvkfqmc8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655908; c=relaxed/simple;
	bh=7Ew0YPQ1N/f06rKAR+EBYHM2O/fNjLVmTRnscKrS1zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZHb4Im6L1IXjF9Ds6MZTpJnvffEjTdovFPQNvcqHX1uQmlGZJf1EXvgdaOiZD5pyyHjbCA5N0+8II5ol0ttSMyVNRMjO6Hk6THk4ItMxp83vGqjAizbsKROdGM8feAqyxxRLVPVhShsXdyAjfkAzD4m/7b3UDmTUiW1G7tYbNoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=olLUChIw; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="olLUChIw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPNpxeJr0asuPgsEQQxmfSYDkdcH/kdWMWz66PvvoyMjjOHAkVfpBFXUsNLjM0TApeGMpzHA0ulrcpzen8xuaDKLjCBWflHieM6zVyLKeR9/odvF5pkZDKCy95Xnd0EIw/ptHQKy+NV7W7BqxFjEMYkLXYiLSbOGn4x7FZJJfiWtm2TemnepKlHBSMCTlHvL4wdMPh/W6zsvqPtcAzBc5x0TY8uKIex5uaGMJzw9HwWqp+30yEwWKP65hxPzZGI2yp0F5D3OvOXfcvLJyVC9jtik7X8pJ5g+sKu+hrdpw8hdwBGGC0qVV+5RemwhKBeqDMJZ89Zl/7am2FR5gxUxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGe52JVsv6Bz9kq0V8YIVWMrfrjEu1GAA3AFEROxN3E=;
 b=xlXb5oB5CPoAn0Z7yYzkW9XxOROmo1UKdmCvDxDJOl98Fpb9HvC235WbRiSHEAb9vqzFeFb8L3crRC/AanXXvpogFW9KD0GnnwJgEcVUWGq4MpQ9++BxNRq1CjEnyKSEBBveiyYHaTVeyR6xl4kLNs1tVHWRoslJ0g+GgFQL5FkZDoBLVxK77zPqXM+qRbYRPiqD3jULaB6NVx265r2v9s8p02sk2GXWmIfzvPyhoRYsfjQOrR6NFRUrmxT+vVGxcChKvHpXii5jZN7/i/yfw/2Hr9C5GBLE7ijQrmfCxlJSNkFUQb02XppxQl48m4H1cyCu3ccQYMrk7GHVLanZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGe52JVsv6Bz9kq0V8YIVWMrfrjEu1GAA3AFEROxN3E=;
 b=olLUChIw0cSG3MfDmUP/fbK8ZMkW6shdDnO00fbpB0stFIaY6tPI0pwM98UFeIaqkkrAK+qbkC6x7ol9UdF8x/M4zvaLwEj4EqHbL+f+OfVhPl//fmkMFWyOz7OAytaUoQFgyVTJv3u50ndrcy1eZIdMkffHg787m3Kn0I65yi2fB8Rrg/plhnURuYs7u/GC7YrbKtb6dyIPiRool+vSNK9rs+Zvkfgks29J+dkGXqO9ozBJ0g2tOImmO/y5WaX6U0cH95h/Vj6FovxUELQZRDYuy+B835zDkBfiNBC5iJU7kqLCH0H8F+gut0I0O0h7mjjXKyWykLlhSOeyPLG4gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8570.eurprd04.prod.outlook.com (2603:10a6:20b:435::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 13:45:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 8 Apr 2026
 13:45:02 +0000
Date: Wed, 8 Apr 2026 21:47:20 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] arm-smmu-v3: Add PMCG child support and update PMU
 MMIO mapping
Message-ID: <adZcaEKm3vIYSy3N@shlinux89>
References: <20260408-smmu-perf-v1-0-d75dac96e828@nxp.com>
 <2c1a1694-9597-400d-b441-714225b5377b@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c1a1694-9597-400d-b441-714225b5377b@arm.com>
X-ClientProxiedBy: MA1PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 8566f197-44c7-4a6f-5513-08de957508d4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ouGIJTl64hqTpReoQRaXtgI3PrRWPO0SAU5Wjl116DknOc+2IXCwUudkts6PKg6JrKOylZvjV0gyTpvpL4o5DATIms8DFF6BuFHr6Ih577nTDyCgcJtB1nllxC+GWD0UFkbreIEcNrNO2crILdrVZUnMkXg+zwGRHGQUFDMktnrP+KtaxWC5NP59EGk/LdH32zmnbhVd2Cf7TKrb+piZYHJ9Kc+BvsliTtkZ36LgDrhsGWLx636ruAmHRqRxCo8Mi9bNQQ7pwhjcSV8FtHWNqG5rX2VpVJyDX6TsGJe2HNr6lLRYDSby2nTzFB7fCnzB67Zqd0TP19QZwjZTbJJKLhfcXRlf6L6UlXfX5KB8uWW598Ba3yIUOoT+CcyOrcjGYmHSiMg/6RYAbRW3crWLMgOLUM7Fkq7BEKGg8Rs7A5XZugwcfJLO/YZ3EvGdlyjiwxSTFKMxqSCX+DoyyP2KygHudmI3HY5B0Cr84fYCYvDRw+rI+ePCAVfxVCGWu5t+DW+z25VKSGmV9F8i2tGSp3Hmt5kNrMw8D60T/e38l8W8djMlIsTM5mqWMb2Sukd5YF3sSbPDV67iM0pyYulwHWW0xokKEX9e0MzEDOAmXS0vhYzmw7V1/Z81q/gB5TJGFAXt1ipN9J7ku4XeOIzHE3wPbJhhkJmvh1eJJIEXq0lfGSU9xYsyYsbrMmiKz30DOfYcX5iZrBVQoxvQG5Yge1m83hIx7vyH2f7ohjeenPu+CscNgiubFME2xnwnFiSK6YwBHcMUZoNzS/20xA51G9381qd3g/2Q1sYgh2N170I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Pft1uz+V18nSpfOb7hCuQPYFJ8CK6j3+0dJUpHi/o2IY5yiMdlaNopo1MWK?=
 =?us-ascii?Q?KLAHIg4CO04BPe/j7ZrpdWXhPQ4OMSHC1o8vqWewRQm5efMx+dJPPjDhE4Gb?=
 =?us-ascii?Q?2R0hmziO7+iw2EGOXLVeb7KhI7hE3i3GribkGv7JmeKLHhFxHgHOjbs3bQP2?=
 =?us-ascii?Q?1ZZIzEw0lbSM2EDujkpS92qAQXxYMN5g1Ab0gA764pZZOOk3rLNF7HCFH/Cj?=
 =?us-ascii?Q?zd00tnpxRaQg+Ifc7LOhv9ZAKED4HPLkBRB2LWnnjbw0QqbH/OhaIE3DsocO?=
 =?us-ascii?Q?d07grmKKwNVu+HOJDPkFWFFVmuLZHncAcUc0MyCQ6u+IWa8nIEJYvm00HW0s?=
 =?us-ascii?Q?coIKE/bUTk1PNz5gbvBrdD5ZciyR29e2xxaHYHKkd6hVzKaZD2FQAgmQgRcq?=
 =?us-ascii?Q?b2yv8sVzRks6JNE9gaX76/6WfvOCNCluPTypgXFDuZ0OgdG8NllBc6GqdJc2?=
 =?us-ascii?Q?ic5kN3u4BnNY6aYsn3096SLEYcKjbnATIJe2YCRtvDqeGv+IyCCihG/Mp+RO?=
 =?us-ascii?Q?R1N/06C9KSpu6I8eK8fS+23ZDYo060GDbPHGc+jglE/1RUCEjpWsGI9j6cs1?=
 =?us-ascii?Q?apvWz8UDnaC0z182OOJc6uNf4TZhndN4id9dz3jXwaQoWHMGkdPReGYwBUej?=
 =?us-ascii?Q?yxpYa8i1UmSmy+kZr5hcpPATEZb0xWEJ6tWkmxjTi+wUTfo+QeNBVDNeTTXY?=
 =?us-ascii?Q?zjxaJXKF9lw8DlI+RuKr8wGWabBgk/txkD7VkGARb7AKC2rzwbRg+Jq4p1jH?=
 =?us-ascii?Q?6Iimo19aYB37pqywC+KVXSjy7gfYjL6f7EEQ6iH3mL45002yUKqoH+SM2Wun?=
 =?us-ascii?Q?3tLPsDCncj9Ri+vMeFV4T7wuUAnMVqQoG8LmUjiWoDCHUC2SKu3/+0ebiNwW?=
 =?us-ascii?Q?ke6+D2mAcjwi4iogQNv4iDKDknpxPsJtpEcpeDsLzm/2WYnNApIQblGNd04W?=
 =?us-ascii?Q?UTXpXIpzTgy/DTgwnQkNIuPIUUVZvSWATf0sIBZ+VQjmMifeEK6cuOJUHVP7?=
 =?us-ascii?Q?VemYypnCDM6tb+bLU5kQ0AaeCz72XbweTmptXsmfA1uafSfuxrz3cG05BYnt?=
 =?us-ascii?Q?QRRt6m4fhsXM8f2GY4ECvgT/hMa8NuxylMpJ1nklfjkfJmbvPF+bAEykjgm1?=
 =?us-ascii?Q?MPsbGVdeOxehhByRxK1QzwN95l6RG4n/9YNPEuq+2raUNRY7rXy2dPsHAfq5?=
 =?us-ascii?Q?bcsVtylkcrX1cUfaT8yschMeMi0dEzXk4NbTi11/FWj5A1Eolu7xFpS9dnH4?=
 =?us-ascii?Q?3NRnAhUzI6BBncXX6Po8H9NyOJoUOIzZVaAQLoWe7nBcXI5ripbC0wXfiYbv?=
 =?us-ascii?Q?k9Ag37L3vbeGyDCWo1UC+ZbCoCzXXeR/6pImJoWheifJdHQZ/venWdPy3PHm?=
 =?us-ascii?Q?VvSaBFeEIskU1yjHF0uFdXZ3vkqyEem5m5j2tm5r8H+mauumFeExWf3Z0oUx?=
 =?us-ascii?Q?9cuTcjW7jLzUG3NMQiaxC0gFRV55dHBNacc+K7zsv27hK5dAzYMpa4uHz7Bm?=
 =?us-ascii?Q?/DaI/ukv/1xIDIDAl5/nJSo/2p+DOEzhEP3RNXONoXWWp68TSKOWe7/u+NsN?=
 =?us-ascii?Q?utMal0TG1RyEZN0cc+7i5xja2qBYHU5WyzSETbmm1ZnipOHhf8ty7T+WQLoe?=
 =?us-ascii?Q?W+1UY8vuJsyBAS1Hp2Qa9m47TGUeUQAGBMb0twVBmrD/4MDXtNK7o/KAILIZ?=
 =?us-ascii?Q?a2DT/usqunezypWlz8ueLYFiu6jm3iiIBMnjU/TfbYHEAlJ3OMro29Xxkfqo?=
 =?us-ascii?Q?0qzxPzzeuA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8566f197-44c7-4a6f-5513-08de957508d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:45:02.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIOevKqM3/tKj8A2lRBlxAM7aXCyf5GYhzu8Fhcuh/YytjG+ejP84Awvkg1f5aKZ4GGrj0JiN+juH8skIIcsDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8570

On Wed, Apr 08, 2026 at 12:15:31PM +0100, Robin Murphy wrote:
>On 2026-04-08 8:51 am, Peng Fan (OSS) wrote:
>> This patch series adds proper support for describing and probing the
>> Arm SMMU v3 PMCG (Performance Monitor Control Group) as a child node of
>> the SMMU in Devicetree, and updates the relevant drivers accordingly.
>> 
>> The SMMU v3 architecture allows an optional PMCG block, typically
>> associated with TCUs, to be implemented within the SMMU register
>> address space. For example, mmu700 PMCG is at the offset 0x2000 of the
>> TCU page 0.
>
>But what's wrong with the existing binding? Especially given that it even has
>an upstream user already:
>
>https://git.kernel.org/torvalds/c/aef9703dcbf8
>
>> Patch 1 updates the SMMU v3 Devicetree binding to allow PMCG child nodes,
>> referencing the existing arm,smmu-v3-pmcg binding.
>> 
>> Patch 2 updates the arm-smmu-v3 driver to populate platform devices for
>> child nodes described in DT once the SMMU probe succeeds.
>> 
>> Patch 3 updates the SMMUv3 PMU driver to correctly handle MMIO mapping when
>> PMCG is described as a child node. The PMCG registers occupy a sub-region
>> of the parent SMMU MMIO window, which is already requested by the SMMU
>
>That has not been the case since 52f3fab0067d ("iommu/arm-smmu-v3: Don't
>reserve implementation defined register space") nearly 6 years ago, where the
>whole purpose was to support Arm's PMCG implementation properly. What kernel
>is this based on?

Seems I am wrong. I thought PMCG is in page 0, so there were resource
conflicts. I just retest without this patchset, all goes well.

But from dt perspective, should the TCU PMCG node be child node of
SMMU node?

Thanks,
Peng

>
>Thanks,
>Robin.
>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>> Peng Fan (3):
>>        dt-bindings: iommu: arm-smmu-v3: Allow PMU child nodes
>>        iommu/arm-smmu-v3: Populate PMU child devices from Devicetree
>>        perf/arm-smmuv3: Avoid double-requesting shared SMMU MMIO for PMCG
>> 
>>   .../devicetree/bindings/iommu/arm,smmu-v3.yaml        | 10 ++++++++++
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c           |  3 +++
>>   drivers/perf/arm_smmuv3_pmu.c                         | 19 ++++++++++++++++---
>>   3 files changed, 29 insertions(+), 3 deletions(-)
>> ---
>> base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
>> change-id: 20260408-smmu-perf-754367fe66c8
>> 
>> Best regards,
>
>
