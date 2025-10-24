Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB66346E7D;
	Fri, 24 Oct 2025 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329864; cv=fail; b=RQc2yJ+hHAX/h7mCGC+2SX0hgeC3ZuGCfUUvb+q+6pFp6BQiORxhrHHTCi8qxjNyzs2erPBfeh1sybeS5DtqV5DX31Dh7B2nTHCQdpiBFza/aKB1wtnJ7DZxZv/jnIhsw4q5L2iZNx69vmHG1kNTV/efNHBU9Aulg5syvSksrCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329864; c=relaxed/simple;
	bh=r8swxstYdfH7JP13mlqRiDOFoi7eOmtRK0Mk1iqdXPo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uEn94E9BoH5+pTf0qGOGjJzD5kFEdU2MSjqIwsn5rONpfAGxOJg8IOpdp7RVGWGpdIXnrMQA4kaS7qVNKcGnczbVhzINvAbAWFonUOC3zPDCgHdDSvDhgSnG6Qelu27abAttfRqgPJX/FFzichsrBVSTlKlzKRgcL3jOtZGBzws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y1Tpfqsb; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y1Tpfqsb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB8OUbsrR6u5K0P7VXDtwTsD8aBBwtyuaFLnDa3HAMPL0WYvis2bV+lhp5j7TjCYvfGA8ruN2c8RHwZiPZu6sn46VYri1osFBs8ZcK+aRkKL7tetYUaXNNaILxY7CVUbpmGp62VMVa+ZKICRGQDbAVYxGYlvbbcD4IyewoKf+MAkxMPL7/Rvjz6HyfnyNzS9zGFfUkKzwEPdqBj5pJFstxtZWDQueXQy3JoJyBF330bz0SQfJWwgRcNfJ+ycG0oyF4RxoMI4E78yAzVsmWPwafiVxn6nkbSLaQZnm7uQsXqAaanqzYri3q8hDm3IfoDGqYZU+OHD5gYPyTcf+ZEiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NAfJqXK6yR1bKhacRp2sfn8rR8lZKGyMVv+Hs+tgPE=;
 b=NB5jTbfSMfUt12AkFdnl7h6MHqlfGMb1T3+u20AcfMsFrfrNiLCt34Ee5AKQSyM/eKf48V0u/hLrXKhOSC1WTqPC4ZNZ2z8w75rw80MdI2IlKEZ3LibbpAzlX/o07/Dma9vuxhgCP/kQUO7LD14f5HbDXbykjmuSFbC0dpwqmL8cDrQASRYWYAydienlYASPl7OmN8RXbRBhxIuCgFZY4Ga39FLQ+ER5zlTq30xgYhuSLmaFbexh1/RThTOReUgvjIdKIY6FHQUCS4OlG0ej9Cg4lIQzAHYCu88eF0kQgfug38amQYjJTIV/TVikiPDAObAKkJop1hoPCXoNbPitEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NAfJqXK6yR1bKhacRp2sfn8rR8lZKGyMVv+Hs+tgPE=;
 b=Y1TpfqsbL0/fgJiScUl2QQMuubUAZ670FAkxCls4PUY2qzeWI2V1Jhc7KP8Zja+vQRbmdV1UOlCZE2+3DERzZRciHJhCINRy+0llGpFxGHrfPaggV/9QAmnSmY/Lso9RmdzQvGBH/Y98zO1QCX38v2a5SYm2pLajOxZu/huFkxrP2hTQiOerfUSfrlpJ83VyVQTRsNqmVYAJjhtJweijjnwE1Vwn8gJFVO9dWxZZu1mcg4Bgkeg+JfxefD/nsTlMBYfWchlzkaC/I+LC3McSfRlb17nzwQTm1Ig2y82eG4XgTL0yarODG6XNOmnrpRq+ti0DbN6QjW0kPJOd2o2nrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:17:39 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:17:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 24 Oct 2025 14:17:12 -0400
Subject: [PATCH v2 2/6] perf/imx_ddr: Move ida_alloc() from ddr_perf_init()
 to ddr_perf_probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-qm_dts-v2-2-7a7e07022ed6@nxp.com>
References: <20251024-qm_dts-v2-0-7a7e07022ed6@nxp.com>
In-Reply-To: <20251024-qm_dts-v2-0-7a7e07022ed6@nxp.com>
To: Frank Li <Frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761329844; l=2517;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r8swxstYdfH7JP13mlqRiDOFoi7eOmtRK0Mk1iqdXPo=;
 b=SuBO9XZuCcty3MFFW6MTkT5Ij1c7/HhESYXi5uBaNiX91ALOuaKTmg1erCChY5Iy2pqfv4I0R
 MKIbDo25PFXC+zAewfWDP0wGDocVYcIqSJTvIrf/bL2d5hJBFu1egBz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:a03:80::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: de1770d1-339c-4b0b-f381-08de13299d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVZGcXNMbVI5WndpNnp6L1RPMlQxUjd5ZnhhRGorOVJlS3RoRHRvdXEwSjMw?=
 =?utf-8?B?M3ZQVVZ2Tzh3aXptNXBzd0NSaHlPa2tRZXhIQk1JZitqMjVJZVFkNHBHV1Va?=
 =?utf-8?B?LzFTTUdTbExQeWNvb0tOV3lCNUdkVUhhRWY4WHVLMFRQVDJLRGJvUTlMN1hZ?=
 =?utf-8?B?QzJzVEJMVmYweHJrelIvU2FxT1lBWkU4RitZZEhIQUppcC8zVmlIbW9TdWd3?=
 =?utf-8?B?QnB6L2htQmNDcDFxM3dQTHRWZlRNaUhhZnFPSTZicmVxVnl4R2E2MWduQ1hY?=
 =?utf-8?B?aURYbW5mNXJEWVdUUnFvcmVhWHhoWTJRRmxSMWlFc255OVBXUEFEdDJHME9x?=
 =?utf-8?B?cXR1WUx1elg2MW1RakNGaXBCR244LzZCeElic3IvdVpGM0U1OHpiOHh2amI0?=
 =?utf-8?B?OGNPcE9GUDdmVEg3RVVBSzBDUWtSblpOdStzZGJENmtzOVdiWEFCNUVwaEpH?=
 =?utf-8?B?MzhVZFVrVUVJaTU2QnZ3TXRjOHdCV0RhaVYvakU0c05hdHcvbEpVWjhKeUZy?=
 =?utf-8?B?Q0JxYmdKc0NpRUZSUnVpbXpYLzQyUFFwVWRTcVRkUWpPT3pkdm5wNG1ocFJn?=
 =?utf-8?B?aFgrVHdPMHk1L3F6Q3UyKzIvMFllQnozTWtOZ0FZN2R3aGp3SmJvT3FOcUdm?=
 =?utf-8?B?MjRVcFZHUDR2V3F5eXpaNXhNcE0xaXVyY2NIUEZjb1dzVmF2SHVCV3ZVSDBH?=
 =?utf-8?B?QUZZTGtWRFNadTlVNXpQZWVhSGpRVzd6bnRMU2YzWEFVUkJ2MWZXbnZDZnhR?=
 =?utf-8?B?ZVJHSmtoS0VpMTg3WXMrY0k3b1VCamZXNGpCSFFVblU2dVE4NXZsRjMvcGxh?=
 =?utf-8?B?VitqOEIzc0daSDJkZTlTcXJNeStsdUtwUkVkSXVyS1hyTXlkNm5yM3VRb1VL?=
 =?utf-8?B?U2dYLzEvRFRucEhFaWhBVUJtY1JoOTNvd2RKRUd4NXdCdENMZlFRNitwc0Ny?=
 =?utf-8?B?SHQ5NDdweGRwSUd1U1hva1hUbTF6UGVHN2w1SzFVOTBlODcvclZzWlpWZ05j?=
 =?utf-8?B?UjNyZ0Nyb3pSRXNJaWl4NVg5SFVVVGxPUTl6dFRLY04vNHB3bmlsaGx1cG9i?=
 =?utf-8?B?OTlFMWk4dTVaNjF2dFFqU2xlYmRiKzl6cHZJL1ZRMXRwVi9DZ1BwdEVjQ0xM?=
 =?utf-8?B?cjJDbzZkSG1GeG9XYVk3Y0pIZkdBSUc1Wkp1UDFKYllqU3VTN0VTbnRhMXdr?=
 =?utf-8?B?NlFKNlNqMUJvU0tiYlhNVjd5VkkydEFPdG9WUi9ralduWjdNTXhTRThBYzVq?=
 =?utf-8?B?WWViTjRtWUtKQU9PQ3l4ZHZQOFY2OGkrQXBpWXkwZzhieHhmV3NKL3BvakZT?=
 =?utf-8?B?aHBtSTZHVzMyKzl5eGZ3eUpYNEhBckVmbHJ2NTNqU3pOeks1Uk5IMmR0cUhX?=
 =?utf-8?B?SlZnWVd5YTh1M3VpQkV0Y1Vhc0tIb0RVdU9aVDBNK0V3ZWlkamQramF3QnRF?=
 =?utf-8?B?SWl5eU9wb0ducjQ2U1lJamYwNCtTcUVaWHRLTDJ2cHZQdGFKdzFrVFJFVVFE?=
 =?utf-8?B?eEVOSllWK1hhY251ZXRuSVRZZ2dpb1ZmbUNYZlVSbDJHL3VtcWEwZU5HQ2s3?=
 =?utf-8?B?Qkp0ZTBQQU1sLzZjanlHTlBJek1pU0ZpWFZqZ2svVGxDdktBUHZiTkp0bzBh?=
 =?utf-8?B?ZyswbkJJdFhqM3lXajI4RFRPa1ZVR0VXZ1lBdVNGaFM4T1pKSkVyS1BORUg5?=
 =?utf-8?B?aG9SQlM0L0cyYkVaU2lwRGZtNHY0Uzl3bS9nQVprcW5wZDVOVzZ6WVFObUx3?=
 =?utf-8?B?ZW1zUy9ZSGF4MGM4ZU1sNVU4NHg1dlB1STd3bEtSZ1dLdlFGUzllNU9HZnM0?=
 =?utf-8?B?MFVYZkNUalNobi9Pa3g2Y1IzR2JQRUY1QVZVVE5nN09halFIVm4vQnFtSkRJ?=
 =?utf-8?B?RW5yRGR5bzdYWWU0SDM2TVRpSjdIb1Q5cUUyYXY0UC9aL3I5YmRSb3pUNm9m?=
 =?utf-8?B?aDJqQ3hSMFV4RkNFYnJ4a2NOZklQc2xaTWsxNHprNWVxK0FFckxVVTc3c0dN?=
 =?utf-8?B?K3BoSGNqdmhRekgrNjNGYnp4Q29mdXRvZndNMkJSdE5qOW9BSmVjMHRkVVVH?=
 =?utf-8?B?ZVY3K2RVMnRjWnlSWmFQajJvSTVpZDZIdTBEQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGl3NExkMVliVllaNTJnUGY1YTVrS1lzOE1QTnZRTXRoN0ZyNGYvV1RQOFl3?=
 =?utf-8?B?ZUdlOFZJSW5QSlFPaDBoV3BER0tJK0ZWRWRoSW1adHp1RU84eGd2L0NmT2Zj?=
 =?utf-8?B?WDljMFRVZEJTNVBsaVZTd04zZWk0aXBkK2JPRUhqSTk1R0JFay9veWNnVzNs?=
 =?utf-8?B?VnozMm9wczZZSHFzNElHRC9XY1NQRm9sTDhWUzJOTWZaTmFwd2ZRaG1iNk9M?=
 =?utf-8?B?Skp0ZmpqakJsOFNISVVIT1hBeEhSUzhGanBWM2xySDVyQk1UcW9sQTRxZkdz?=
 =?utf-8?B?LzgvZk53ZEVWQUZNUGprMmZveGVpcFQyM29hcFMxeFBGWUJvSVU3WVE3bDV4?=
 =?utf-8?B?L0xjeXpnR093bXBtWXNab2g2UXgvRmFIT3V6RjdhV0ZUeHhaYU45TDdOV1Z5?=
 =?utf-8?B?ZW05K2ZZYWVjVVhMU0wvOExRMk02VkRWZk1YZUVEYWlpRHBWUjd0ejBpbDMr?=
 =?utf-8?B?OWpuVWxpTTd3bTVKSTQ3VmQzenhHRjBVa0I0MGxHaXVqSmEwWTZFUlRHUS8v?=
 =?utf-8?B?NmtmQnowbTlZd2lJYklVOWw2YlVEbUdodHhpNlFtYitvZ2pMYjFQN1QvUHUx?=
 =?utf-8?B?ZFFML0lCbXgxOVhnb0xQRDhFS3FiNDFJMVhqY1RiUWRJbCt0YStZcndxNElw?=
 =?utf-8?B?VmFwT1pYT2ZMTk1sbUUyVmZoZHRQNHNJQmttNGY4bUYyT3F6bE5MUW5kVXNt?=
 =?utf-8?B?d2Fram91VzFvYVgyNEhOZWMzbjdiSFFEL1Nqc0NkbGVYb21QTGdVaHBPcTM5?=
 =?utf-8?B?ZjNXTHIveGp1VUgzQU1DZHlCUHAxdS9RUFdEWGtJeWdEclY1MUFBUFhxTURV?=
 =?utf-8?B?VDJuTVlxTUxVV3R3ZFlpTnY5ckxVMU9PbXZTMEFBRlhabEo0QlFJZERqRXA3?=
 =?utf-8?B?OEJzZTQ1YjJJblZQbjNlcmg4RzBoVFFhNWZIVXRtb2FJYklqbkhjWHdaWk9O?=
 =?utf-8?B?SmtWRm9yUS8xdVNaMVlzWEpHaTg3aGtyR3ArbWwrL2pPb29YSkRaNUJ0OVg0?=
 =?utf-8?B?a01LaWZBUEoyV1NzamRwK2VkRkUrQlBKbnVuNXBjM0llS0czckdkUHRwSHJl?=
 =?utf-8?B?cmxueVg1KzJpVTBKMGp6RW5wWnBVdGtSWk9NUzFEOFNMUlVnTk1telc3Rnhz?=
 =?utf-8?B?clRsaHU5cGNTQ1BCMDZWTlRFZG1jT2RIbFB1ZVdBbFl5SGR5ODlXR2VSNXpV?=
 =?utf-8?B?NnRGNmJ2VkFGbDVyTU0zM0h5VUQ1SHpTekU2WkljU3A1bnFKRjUwNHZhVUVj?=
 =?utf-8?B?YTNHMUkrSTVpaVRrektldUpGZC8rRFpiUVJmT1dWaGduNWFQRzZZVXZPSzVZ?=
 =?utf-8?B?MDBUQ1pQMjJmOHZxS1NjS21hM1dEQU9JQzZaak5WM3Y2U3oyUlF6cUZWNUto?=
 =?utf-8?B?T1ZBTXhiNE5VR1ozcHQrUkZxV2p0Skw1ZDRwclliWjI3M2JSbkEzN3VScEJT?=
 =?utf-8?B?YTZqMmdtR2hIdUxxcmlIenkxOW9GM3ZIYnA1SmE2cHVKWkdnVW9pMkNIdEti?=
 =?utf-8?B?eUVEMEt1RFNTblhzSE9UOXpjRVFQMUpuOGVYRlAvWTZVSUVIUEN4UEwwZUsv?=
 =?utf-8?B?aU5NTzdQMlNtWFdmdlpkMnRaMDkxZlVyZTFITHVjVjg5Mmt3NnBMdGRQZzRI?=
 =?utf-8?B?QUd5dElmTFdFTlRYMFdHeFBFSDRZcGRFUXRTZmRocjc2SkY4VEVpeXJnOTZI?=
 =?utf-8?B?aFJ0MUIrNUJpUFNhcGVhRjMyaVBIOXF5WEZRaWtrOHR2VVNZMmFiME5la3pn?=
 =?utf-8?B?MFhYc0lPSlFac3pHOUJvNXplc1FiTG5JWXJNSktBYjVtSUQrMjZVOHcwYzl1?=
 =?utf-8?B?bndDUnl2aTNqU3N4cy92MUJ6RFpGTld3NlRjN2xmcmJkNHJrUkFVWTV0M2wz?=
 =?utf-8?B?VE05TExuZlo1YURmS2hyMThFSDdZc3k0OGk5NktGRTYzRjEzVHVlSkwzeXM1?=
 =?utf-8?B?akl4R3grd3RDbTlzVWVZVHRNeThxK0NaVnBwd2lmTDJHNVVFUHMrZFZlalNo?=
 =?utf-8?B?SkJxNlM3b0tQdksyWVdQVW5vUWJYd3VLTUc4bmZzTFhDTXJBY0hta29DdTRW?=
 =?utf-8?B?M3Zmdm5wVzNGRmJ4K1NVUTVtQ0txM0tYSm53MlFEWUtVT3lad2VZTzl6ZnNH?=
 =?utf-8?Q?S3PBPVQSAs8DYpoxjy0A0ruEd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1770d1-339c-4b0b-f381-08de13299d45
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:17:38.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VGY/bBLM5Xa6vKsWg+TkxDis09FxFoPyj6KjqHB7pRCh6keqSVhL60TgJsg5WiNzAkmSBcS0VprgKK3aUskqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

Move ida_alloc() from helper ddr_perf_init() into ddr_perf_probe() to
clarify why ida_free() must be called at the error path.

Add return value check for ida_alloc().

Rename label 'cpuhp_state_err' to 'idr_free' to make the code clearer,
since two error paths now jump to this label.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index b989ffa95d692fce2d42eec08fbc70520c21b8e1..5ba34c606213d255edf27081bb9f63763cca3066 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -645,8 +645,8 @@ static void ddr_perf_pmu_disable(struct pmu *pmu)
 {
 }
 
-static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
-			 struct device *dev)
+static void ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
+			  struct device *dev)
 {
 	*pmu = (struct ddr_pmu) {
 		.pmu = (struct pmu) {
@@ -667,9 +667,6 @@ static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 		.base = base,
 		.dev = dev,
 	};
-
-	pmu->id = ida_alloc(&ddr_ida, GFP_KERNEL);
-	return pmu->id;
 }
 
 static irqreturn_t ddr_perf_irq_handler(int irq, void *p)
@@ -753,15 +750,21 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	if (!pmu)
 		return -ENOMEM;
 
-	num = ddr_perf_init(pmu, base, &pdev->dev);
+	ddr_perf_init(pmu, base, &pdev->dev);
 
 	platform_set_drvdata(pdev, pmu);
 
+	num = ida_alloc(&ddr_ida, GFP_KERNEL);
+	if (num < 0)
+		return num;
+
+	pmu->id = num;
+
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d",
 			      num);
 	if (!name) {
 		ret = -ENOMEM;
-		goto cpuhp_state_err;
+		goto idr_free;
 	}
 
 	pmu->devtype_data = of_device_get_match_data(&pdev->dev);
@@ -774,7 +777,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cpuhp_setup_state_multi failed\n");
-		goto cpuhp_state_err;
+		goto idr_free;
 	}
 
 	pmu->cpuhp_state = ret;
@@ -821,7 +824,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
 cpuhp_instance_err:
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
-cpuhp_state_err:
+idr_free:
 	ida_free(&ddr_ida, pmu->id);
 	dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;

-- 
2.34.1

