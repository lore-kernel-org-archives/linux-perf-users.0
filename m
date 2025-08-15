Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43153276020;
	Fri, 15 Aug 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250653; cv=fail; b=GUuZkF+tRPmvSjsAYjRkG7l0C6pidDSL/DclRUE5/ynOSBU+wT6yGN3dZnxvUOuI1+aQ+kFZw2LvxJrFVbJGwQAyjEjVtI8ykSa5m3xH/Bx6PZ0T0devSbH5X9WINvmyzhFdUA22aZxkBIxGXmDnt9Izo/h7E7q3y5TONkJuXw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250653; c=relaxed/simple;
	bh=D967ZE6ua8irdacHTxLHPz2Vz+2xmCEImyD0UkPGbac=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VQ6Uj/+FAKlKqd0pXWnm924Ko5tediWcV42JL1iRV93GypiDrkwmWo5uH43LdIYFCrbUDsFiWSKhHdMHw9a6FHQlT1SYyPCMxoExPtf0174U6L+xJLulBgSFDA5/2qH1zTWFRXWnCtRwzIBehhLvpMGWY2h0+8IHdpIAgRTdSr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NJZOHgeA; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NJZOHgeA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnzBloooppSW0AlAMbxtxjDcw+oG3maCxqVE87zMAkuCEzZuSSnh3L5fj6t/28zGE9VOlu0obrYxxA2UUXIdj75EeCJMMgDIYZAWZVtChrgj4u0jTY2oPm7z+sa/EWJRckNfag3OyZqBGTSgvFp39x23fz0wq1WAV/1TDiLADaVo6VDhrheK9ZoOECYWp8rHe0P0ECSHb5Qly0sCrz98flqOVNq9rs6FwVd4xks/hm/Q0zTRP0oCZdT015t6MstN19b2tBM+N4mZ71MAlgZtPueD2wk27FNZpUxYVQC1HJdew1S5wdU6xZ/FhgL6pklOG7uEtlGVqH989+AFCjJ9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udzTzmhQYJ/5lDtYEl5yKnL7VXtXjKLcTPDEmlM/Cvc=;
 b=b0G6+lg03/wIYdbNU3CD2lULP610Q6KGQZB0R3JuO7+e8RAqfNohCjR7yz4CNA9nqjn2r3PhfeaNfF0JBlxP36yc7tOE/SrSPdr67i8YoNVnehFI+BxkmFGgzo+ZIy8Yo+3pOUA6B1XoeeulVMjdgYAGqSuOHYeO6rPn3LEEN3lePNkQ2jQYFBa2tVy1tOI5/oOqJK++nNWL9rhw2+xPoe0KUowziTH8PgIK5G00/ZXjFoL8mAhwExiMxAnUK3tcIZznOLrpMuw02QSF3I3drz14aOto9Wi02YwtmamjWNYPnmN3DnqkxDBr9nWdnu/c8D3ZIK14v97BbXUxNE8BSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udzTzmhQYJ/5lDtYEl5yKnL7VXtXjKLcTPDEmlM/Cvc=;
 b=NJZOHgeA2/gW//zE8QPXTdScK0n934QZyIJ2QjmRXo1SdWvRf+p5KauuylTiJzoU4EllbNipoX89+dHofU4L6WASNF59jqBv8SmOVFdPk1HihKKlCdaZXZh6ZSCkiseUavZWTVcNOlwtcbdF3LnzuPlHcsVhdqo9Q0+zGizQiOwahIEivSF8oJ5H4NW2CaFk69i6+fEzE32+mm3fPDVZjhRh7hzLo2I8y/SAq+UilAv5HzqKXTg0OvHfYif6OamtgEYzcwYw0JNaR/tsqAUnOBxyrnhKvA7O5JcA6a+eZmJvvieKuIzOXDHYWoK8VRogd6UcNo3F2W696FqY07PSOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 09:37:28 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:37:28 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 15 Aug 2025 17:36:29 +0800
Subject: [PATCH 3/5] perf vendor events arm64:: Add i.MX94 DDR Performance
 Monitor metrics
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx94-ddr-pmu-v1-3-edb22be0b997@nxp.com>
References: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
In-Reply-To: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
To: Frank Li <Frank.li@nxp.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, John Garry <john.g.garry@oracle.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 Peng Fan <peng.fan@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755250614; l=17935;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=D967ZE6ua8irdacHTxLHPz2Vz+2xmCEImyD0UkPGbac=;
 b=qQ5cZ91SDqtxrCItG23dBFszfZmrguY3WiDgkU/sgOOr/Fw7DZSPGeCZQddRSxrJZSk3V7WDi
 c7JsXVAh//yA5eirw+T4J5GDpODep/CxetPoaJz/ZSKW6qmBCMtxCfc
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 83260447-33e4-40d5-b239-08dddbdf59b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUdKVk5FWFJGNW82bDNmaXhVU0NqQzJHN1VBTlBRaXVjRzZnR1JoV2hlNGUr?=
 =?utf-8?B?eWJrQVlLb01tMm5JZ1Y0UW43MWJMbEt0UGV3U2hkUmJya0h0NHJoSXZpTFRr?=
 =?utf-8?B?ZjdFRVNvOEZZa0toQjUrTzNDTmhkYWMvU2lZK1ZZc0FSWmF6WFhsV1YxSE9G?=
 =?utf-8?B?YTZ4T3duSWJ1azlUUy9BYVp6SE14SkZBVFJkTDNEVTlZaFN6SjUrNFN5Rlho?=
 =?utf-8?B?SWFrZ2xEZmwvRzh0a2JQTzc2cGNNSU5SZGorS1huRUVsUUdkNmdka3BKdTd4?=
 =?utf-8?B?V3QvYWMvdHFzSTd2YzVGZnQ4cS81NnFtcUdzaTA2SE0vUXJQUTNQZkRYcVMz?=
 =?utf-8?B?Qy81aTc3NzVDMjBtNkhJNGJoZ1BLanp4d0R5TGZ2Yk9qSXhuWlFqSU0xQmI2?=
 =?utf-8?B?VjlSbU8vZUV0bVNCWm4zTlowbjlNWVdSWG5yTlJ3Q2c3WHJkOVBsM0VJMXRH?=
 =?utf-8?B?elV6NDZYZnZ6eEJpcHJLNEZjMk80U1A5Umc0eUNjbU0wR0hqQkljOERJOFgv?=
 =?utf-8?B?OGV2VGRQcDdSQXpQc0toNU9OQlg3ZllhNlhCYUFFYVQ3WGxOd21MeUx2K092?=
 =?utf-8?B?QmxiUDMzOFB4UXBBNkdBazdxYU1BS3hwWTdlMzk1ejVOU0lJR2ZCWHJWOGl3?=
 =?utf-8?B?MStIeVFLeTV4a3MvZXMzTVhtbzRiaUp2NVd0MkRPblBaZU1iRTdIQ1ZSbWdZ?=
 =?utf-8?B?R2RJcVhmSGRrcXZjY2U5WnlwcFM3MGpySmFyUG9iQ2tQSVdwdFhRa0U2Y3B1?=
 =?utf-8?B?bmRWeHNXUG5YU2FvdXJKN3ZockxpampCaitrOXlpRGpiRzVDSzVneU9PWDZa?=
 =?utf-8?B?NW8vZ1F0dnpBVG44ZXFOaEVPM3Q4TDZxZkRZeVVBQURWVGJiZ1h0U2xyRWtF?=
 =?utf-8?B?MmhjNjZhSGNnUnpTTmhZOWdoZnhLRkk1VkFsWUhXOEM2OXpTbHlINWdZMGQ3?=
 =?utf-8?B?ZFNtTzZKcDY4YTljakdMaDRxYk16dXU4clIvTzZDUVlkMEhWR2RDOFJZcGRa?=
 =?utf-8?B?Siswb0Y0K2JXYjFsQm9COXRuZHRyU2R1NFR0L0NYcmFGOFBJVXNGazJ6RDlP?=
 =?utf-8?B?NXVMVytjMGdIQVlacHJLR2FTK1UxRWZGNHJaYXdkSG4xN2RpWXBCc0Y1aHo3?=
 =?utf-8?B?NmZlcTBXNytkZE9odXhNaFg0Sy9VUmpqWkxnalc2NzNQWUR1Sk90QzBwNUkz?=
 =?utf-8?B?SkNFQWZUclVDbmRsUmpqWkxSaXdkODdldVFZRWNVWVNwNXJZdUVtS0VSeG9q?=
 =?utf-8?B?T29jeUlqc3gyN1FQM0pra0R2ZHhiT0NPOC9qazNIN3Z0aFRJUFllK3greHI3?=
 =?utf-8?B?Mk4xNUtLK3lZOWIvVGR6Q0dROEtKd1RTNk14M2MwWWNSY2ZnTnVqNTJTQXJ4?=
 =?utf-8?B?aFIrY2tPWllxY2xEQjYzd2M1TkMyd3g4dTVUbzVnZWp1bzBSaGtvdDl6R1dV?=
 =?utf-8?B?R1VaaUFtS0VBK0Jod0FvMFFVYmhLQ1M5ZGxHSXZoYUVKMTI5bExNa3IwZEkz?=
 =?utf-8?B?QlVrTUFOZkxSYmdDNFRuZEJ0dnJOY3dwL2pEMTBza0w5dEl0UThqcU9rS0tP?=
 =?utf-8?B?RGk5UXVSNXVDUFlKb0ppZFNVcDB1d3UzcDk2QllzVjE5V3FKSjZhby9DSzJW?=
 =?utf-8?B?ZWNjVEY1MHkrL3JPM29icXFLYXNEbktHYzNEQ1djNE1ENVVKRGhrTktkK05u?=
 =?utf-8?B?ZnRzRGJNQ2VibjNlay9HeFNBVFZkWFZCcmFoWkpPYzE4RUpXR3NHZFg0TU5o?=
 =?utf-8?B?QXlNL3hmL2V6S3gyaXphdDVndWJLVWdndDJ5d2Y1UmxWb0pPTUxTZElnLzZH?=
 =?utf-8?B?amRlVm1yaTlIMVRaVGdBN3FkenZFeE9SNGs4YU1aUFI0SkNnUWNORjBGb2Vh?=
 =?utf-8?B?TXlZbk9GTVNvdHphRkZDY3Z3UFJpcTkvU0JydldnbmQxWUV3U0Z1UlhmcXNU?=
 =?utf-8?B?dVFQeTJudFdSaW52VEZIQ0R0WmRSakJKQkdlTCtVWEpCenFvbTBOYTZvcGlv?=
 =?utf-8?Q?o1rq3bEfbixrRmd0KXllI0QgfMtOyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGxsSitSMC9BdForUTZNNU1kVDg2VnBlWXFPZCt3a1dVbmRvL3JpN0JzSjJj?=
 =?utf-8?B?UUU4YTVJb1lGNGhsNSt1VXNsZkkyWlBKUlRidVQ5ZmVHbm9hcmV3U1MzR1or?=
 =?utf-8?B?dVNMZU0xY1RkVjVRMktTVlVZNW1jOElKNm0wVWhYUUYzRnpzZGRyQkxleHdB?=
 =?utf-8?B?Tlhibm93amFiZkwydTBTN2NLNE5KOVBjeW1jbU53N1lTeXNHZk9UR1NCajMr?=
 =?utf-8?B?WkJRL0RzTHY4TmhsOXdpME1YVWxqQUVEMVJ0TG9HditaNWJxT0l3Q01FKzFq?=
 =?utf-8?B?WHV4TUlERlFIeHFEL0lQcVJpV2FNeXBOOS9lb2ZqckJBZk8rWS9tMmlxSXBL?=
 =?utf-8?B?SUNkUE9WVXpNamYxcGNSZk1WbmN1cHYvdlgwWkZtM2poQktHQzFKbWhFSWJs?=
 =?utf-8?B?VlV0blNML1RLTUdBYzNpdmhPWEN2UVlxcXcwK0QxZ0ZLVDNLT3VuY1loZUFI?=
 =?utf-8?B?YzBsc2Q0ZE52UUlHWHA5TnVPNnV2UGZtQktmajlOczZBdU9wdEFnTUx2Z3F5?=
 =?utf-8?B?WXFUR3FrL2UrMWk3SFYwQ2IzQytNRFVNS1VjSFQxZkxSSnB4UlEvYTRVeGxz?=
 =?utf-8?B?Q1B4V3JhRzNadVMyOGlWNEFlZjBkVFZRWEdqV3N2VVFhYmlxR0hkMnJ2dG5y?=
 =?utf-8?B?VlcvVXFxSEhOVC9uSTVVN0xaUUk1Rm9YTFZiK2cyd05lVThyT3VOak0zS2FR?=
 =?utf-8?B?WG9RVHdzT2QvWmNBbzJ5MlE5VVNnSzJhcklyTXM4dElFZzAwb2hCRGNYYjlz?=
 =?utf-8?B?WnZCSnp5cHJqNHp0bDdVeVB3Y0hCWEpIOHZQV1NzNURRQlZLQ0FqOStwTFJD?=
 =?utf-8?B?bFgxeEt2bDBUL01IbXFySWtRbW8xZ29ZdWZscThyMVhlWDlWRmlmVUV4SGVy?=
 =?utf-8?B?SDBVQ1QwUlljSzAvcm5UUEdTZmVqck50dlUvSUdZeWtnVG5sRlZESGs4djgz?=
 =?utf-8?B?Z2dZcllhT3NlU2h3Q2s3ZTgyWW9neEx0M2JIM0VwSGZ1eVBPWmdyTkxaMkNi?=
 =?utf-8?B?TGcrQ2FTN2M0cFN1VGxWUmxLQW9HT2xPRTQ2WVNpdU8zYjIveWJzSEVBcGps?=
 =?utf-8?B?alI2Uk1wZDhmWkQrUTM5YzVkY3dKQzVhTTNpeGJvbE5ESHhpMldLVm1qUWNP?=
 =?utf-8?B?aFRTZm0yTEVRazZXSnVVRmg2RE02S3IwSlZrWDdza3VBc1lXcERIc21FTGRK?=
 =?utf-8?B?QW9OT1RrazAyNzdLaDhWWFdLcGxCbDBWOU9qaTFSNUdYT1ZtQnJ2Y1RuT0Yv?=
 =?utf-8?B?S0w1TGxnV1BGa25pQTFQZ2J1eEZxVG9nTldyTkR3bDJwdm43V2M1MkY1b2tX?=
 =?utf-8?B?MEtKTFE5T0VIb0ZZNnJiSlRhUkM3U0RkQWlDRDNhZXJaSkVEUXB3RG5RbEZV?=
 =?utf-8?B?dFcvb3laOTVJZUt0aFBZZ1NtVUVzZys0eHZmYk1PU082QXFteGd3bDUzVEsv?=
 =?utf-8?B?ZXlLTEVmT1NUOUtEMG1vZTZzejUzN1Z4VXJJVGwwVFZua3NpZllGYkV5ZnJ5?=
 =?utf-8?B?R3dwTWh3SXlLL1R6Z2s3cnJvNUNQNUN2THhGRHI0ZUhwNHp3MUNKT2VPMmli?=
 =?utf-8?B?RVV2aFFuSldYWUVFbm5iZ1dZRllRS1doQ2dEclZtMzJ2bHZmZGo1NlN5cTIv?=
 =?utf-8?B?SHIxNE52L2g5TXFqTzdTZG9wZHEvUFJqQlFkMlIweEdDK1lzSE1rQm9Sd0kv?=
 =?utf-8?B?QlE1MVFmdnV4K20xcFRJYTBHZ1BrbFk3RStoalkyNW94RUQyMlM1aEJhYjJE?=
 =?utf-8?B?K2U3VWZ5bUwzRWZmWU84TnlYWXZVbWwyc1lXbHdHQTUzdmthRmhNRUVVeUwr?=
 =?utf-8?B?Q2kyOXFYTnUza2dxd0JkSGtQd1NxQ1ZHemwyVmE4TkQyNDJPdmNSbTFQNDZQ?=
 =?utf-8?B?eng1aWhZL3puSit6UXBNaUJLdE05L0tRN1Z5a0tuM1VsYy9pMWNGUGpSNkda?=
 =?utf-8?B?L25meU5XbTBSNkNwSjNWeWJWYm1aS0tOQnJYeFhnNzduSlZNL2dRcnVLc2t2?=
 =?utf-8?B?akZuSWs5RFFJQlBKaUlvZ1NaSGJOaHlucVhEamQ0dk5OVjdicEQ5aGJwRmYr?=
 =?utf-8?B?VmUvQ0FVZmJ5YldGSTNuMEVtSU56UjJsY3BkQXZIakc3ZS9uUStIRWRSQWtQ?=
 =?utf-8?Q?zqTyWun3ADRtwoBqTQQrzf87N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83260447-33e4-40d5-b239-08dddbdf59b1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:37:28.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+ECf3MRV4I18yHPg7j7VqH9aMlFb+dbOKNkSkU/N2FQQPgS4pTT16q3OjijAlZD/KCjqFVWfo/18fwng3iJJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991

Add JSON metrics for i.MX94 DDR Performance Monitor.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 .../arch/arm64/freescale/imx94/sys/ddrc.json       |   9 +
 .../arch/arm64/freescale/imx94/sys/metrics.json    | 450 +++++++++++++++++++++
 2 files changed, 459 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
new file mode 100644
index 0000000000000000000000000000000000000000..aa7b58721dc7e23dc9d9905a79e0c1778b7bbf11
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx94_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx94"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
new file mode 100644
index 0000000000000000000000000000000000000000..629f1f52761e2210ef43a9cbba175871817e1230
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
@@ -0,0 +1,450 @@
+[
+	{
+		"BriefDescription": "bandwidth usage for lpddr5 evk board",
+		"MetricName": "imx94_bandwidth_usage.lpddr5",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4266 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bandwidth usage for lpddr4 evk board",
+		"MetricName": "imx94_bandwidth_usage.lpddr4",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4266 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of all masters read from ddr",
+		"MetricName": "imx94_ddr_read.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of all masters write to ddr",
+		"MetricName": "imx94_ddr_write.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of all a55 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write from ddr",
+		"MetricName": "imx94_ddr_write.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 write to ddr",
+		"MetricName": "imx94_ddr_write.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 write to ddr",
+		"MetricName": "imx94_ddr_write.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 write to ddr",
+		"MetricName": "imx94_ddr_write.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 write to ddr",
+		"MetricName": "imx94_ddr_write.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m7 core1 read from ddr",
+		"MetricName": "imx94_ddr_read.m7_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m7 core1 write to ddr",
+		"MetricName": "imx94_ddr_write.m7_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m33 core1 (in netc) read from ddr",
+		"MetricName": "imx94_ddr_read.m33_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m33 core1 (in netc) write to ddr",
+		"MetricName": "imx94_ddr_write.m33_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 read from ddr",
+		"MetricName": "imx94_ddr_read.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 write to ddr",
+		"MetricName": "imx94_ddr_write.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
+		"MetricName": "imx94_ddr_read.cortex_a_dsu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
+		"MetricName": "imx94_ddr_write.cortex_a_dsu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m33 core0 read from ddr",
+		"MetricName": "imx94_ddr_read.m33_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m33 core0 write to ddr",
+		"MetricName": "imx94_ddr_write.m33_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m7 core0 read from ddr",
+		"MetricName": "imx94_ddr_read.m7_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m7 core0 write to ddr",
+		"MetricName": "imx94_ddr_write.m7_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of sentinel read from ddr",
+		"MetricName": "imx94_ddr_read.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of sentinel write to ddr",
+		"MetricName": "imx94_ddr_write.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of edma1 read from ddr",
+		"MetricName": "imx94_ddr_read.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of edma1 write to ddr",
+		"MetricName": "imx94_ddr_write.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of edma2 read from ddr",
+		"MetricName": "imx94_ddr_read.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of edma2 write to ddr",
+		"MetricName": "imx94_ddr_write.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of netc read from ddr",
+		"MetricName": "imx94_ddr_read.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of netc write to ddr",
+		"MetricName": "imx94_ddr_write.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of aonmix read from ddr",
+		"MetricName": "imx94_ddr_read.aonmix",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of aonmix write to ddr",
+		"MetricName": "imx94_ddr_write.aonmix",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of npumix read from ddr",
+		"MetricName": "imx94_ddr_read.npumix",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of npumix write to ddr",
+		"MetricName": "imx94_ddr_write.npumix",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 read from ddr",
+		"MetricName": "imx94_ddr_read.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 write to ddr",
+		"MetricName": "imx94_ddr_write.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 read from ddr",
+		"MetricName": "imx94_ddr_read.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 write to ddr",
+		"MetricName": "imx94_ddr_write.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 read from ddr",
+		"MetricName": "imx94_ddr_read.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 write to ddr",
+		"MetricName": "imx94_ddr_write.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of xspi read from ddr",
+		"MetricName": "imx94_ddr_read.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of xspi write to ddr",
+		"MetricName": "imx94_ddr_write.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 read from ddr",
+		"MetricName": "imx94_ddr_read.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 write to ddr",
+		"MetricName": "imx94_ddr_write.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usb1 read from ddr",
+		"MetricName": "imx94_ddr_read.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usb1 write to ddr",
+		"MetricName": "imx94_ddr_write.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usb2 read from ddr",
+		"MetricName": "imx94_ddr_read.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usb2 write to ddr",
+		"MetricName": "imx94_ddr_write.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pxp read from ddr",
+		"MetricName": "imx94_ddr_read.pxp",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pxp write to ddr",
+		"MetricName": "imx94_ddr_write.pxp",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of dcif read from ddr",
+		"MetricName": "imx94_ddr_read.dcif",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of dcif write to ddr",
+		"MetricName": "imx94_ddr_write.dcif",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	}
+]

-- 
2.34.1

