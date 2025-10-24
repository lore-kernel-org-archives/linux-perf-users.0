Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A7348465;
	Fri, 24 Oct 2025 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329873; cv=fail; b=KaCCx7LvDKy4R0zqy5BCPF0uh55Og+BDls/hjbzsoxATHboaT5pJfzu08tluoLr6An+2WBvb5C7+9h7VzUC+tl3sdqKj+pkS0/+2i2MnHlMY7KB5vBE6TGqiNebIVZ6mkpPQCgmEL7e+lvJ2PtAjP3c1D+ppUSJ1OR/9yyMB03w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329873; c=relaxed/simple;
	bh=Zm75V9xqCe3ocYoA+1TeZc5TVKO6ho9EZbfxiV6cEaI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Xr8gX45fOnlqzqTtiBoTg/mRONYFidX33OSZ6EKkwqP50lBDUpbyb04jY+vEWhaCr5x2ebkL0cWz2bvCEJKtpXoQEMHgX3QXD64ZDh1s655dyqnhfjHDzmWJ2FPa3+9la4baLLI9gTHnlkFDm6aMS2sCni5lUcsLMSgRorpYjcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QqOIQPkG; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QqOIQPkG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyIy1F6WYSZHRhVMkCjeXbcn8N3pqJmCtAR8QPUDSSf4DaRBLXr+Gi8hOJGiWr3mUjswZ84YShxufPDwUAnKiNPctFWAbmQKJkTYQQCaBL0QGBzSQY8KTAJ40oQcqVBSMznQUk0hqTKgO+nNafomc0WmUu7wwokbMrzkfrognfc/DmePLDtgGZAUmla/+rfirPjQ1RmeEmJC/GmhIqODmeUtZoa7gZVn4nU4b4m/XFk/0ZFsF5kHG3TJbqcix7JvRMxf1PM+NRnH2CYgucD60uI59jY5f0hiJcA29196aPsZLbPBdgAId0d2lPobMwmuk6rtbBi8JzyLDbBEA33rDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbSUfxVDDkfDi6aUaGzNrDK72d51CewGtRrWlvUNxmY=;
 b=oviBDPXhqi9h5JaQG18FLTI/B+/XY3eb1brOjf+P8CVuoqgRm0qXp/5bI0XEBR22VBpaaT1WeL41cXQ+xuOKGz0qhdaSST1Cc0ii6Nsmp2SqvFOJdeZNSynUluSgTPmFPE4Cg03rTq4vP01IdRxN4vi8t2Z/MUE/wEwZoJYFL8/2TrREmTx4mbGGXbqjMaaN4CKzHvYppfW6UKrb3suNjV+P9GnkgSr4zdUwiiBPOOGBKy5tQGnEAJhhfJjEIG4tELyAjiZvzQMsrWNH4Bx3v/8llFBZgNZkff9PUzPD4kh5UF65C+uo7MEftYbPsgrFCCl29W52m7bbiGY6pgHOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbSUfxVDDkfDi6aUaGzNrDK72d51CewGtRrWlvUNxmY=;
 b=QqOIQPkGb+b3sYNOyImgcu360uED+Cs/pOME3bi8RHnAp966h80MOeZc6Lv6OU3/EzvqZ3/X9NDhPuRT6pDPnqjcoXdDWeitZ+tt/lpXeA4d4TELfX0lhu2BrnKNlX/S7Qb6bQcvOC2oSkGCdeI+OtGb4mui+TSiYzmXO3pgtteGr5fDq+zGeeTL1nb/uJNjuzKR55214KLcLNxXsxYt6mN0n9a2Y2oe0rOrJ4gMrQ45ogWEhGR8CdfAfw3kFRL0JEhBdx7KpUi+SOeU/NtRAYgVAZ1i6QPibTEMNqKmnjZzygMihWNCrHNI6qBcmBI7p/dtsKn/TQ2SfvDhKtt4Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:17:48 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:17:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 24 Oct 2025 14:17:14 -0400
Subject: [PATCH v2 4/6] perf/imx_ddr: Add support for PMU in DB (system
 interconnects)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-qm_dts-v2-4-7a7e07022ed6@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761329844; l=6526;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lpBaGVASVzewcDssNHRMOg1gqUyfw1BHNIjAmz2d/XY=;
 b=M2OtI0V+5mKFThbUYCFKBFVlnT5gJB6wTJ1dx4qU6CUOa1TTdDby0XbmuoyeGfjsmXouHmV3Y
 sjkDVxCNd8sCHKhnN/9tm0X2p3s9355MXdFoiwlv9O8zLlfh7RwmDUi
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
X-MS-Office365-Filtering-Correlation-Id: b15ebe3b-7dde-485e-7282-08de1329a2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RThYRTBJa3g1dFhQa29sVWpUc0dXRVllQ1gwRXdKMkhBV1pSQjBJb3ZmZmFM?=
 =?utf-8?B?Y0svOE0wV2ozQ2owNlhlZEZCb1ViQ0NzYXhkcVcxOUUzVVljMm5qc1F2NUxu?=
 =?utf-8?B?SktsTXI3d3JrZDE2MVlpWlpOM1YrYlpMc1FJclZDTXR1MUVMNS9WR3Y5RUVy?=
 =?utf-8?B?YmRsTmprR0p6blZuTVltUmY2OTBZeWFSTUFwaTZxb0IxRCtYeW5RTWV5bnNF?=
 =?utf-8?B?MVROQXVSK0VZVFZJRDc3SjArTmFMZUx3NEp5MUhmUXNJY015dTlxVFZXRTl0?=
 =?utf-8?B?RzdubHJKSStGaEw1bWY3eFNQR2gyL0d0cTRnZjFZWkpZcytVZ3hQV0FZelRC?=
 =?utf-8?B?Mmx1enFsYjNUMmNFMzkrdE9MajZ0K2psZWRaQys1eVZsakp5eml2SmVzUGNn?=
 =?utf-8?B?RmU5ZHc2QWpabGNZdVRSUmhoYUkrNWFDYjZIdFNjcEpwb2U3UVVEekhmSlVs?=
 =?utf-8?B?M3RZMjRHc29wY1BaUFh4Z05YUkpIUklrR0JtWVdDK2ZSRkpKSzQ0OHhnYWk2?=
 =?utf-8?B?bVFLSE01KzFUemh4MlpjZ1hYMjR3a1hPdVRjVEk3eWc4NzVjNDNtWnYrTzBv?=
 =?utf-8?B?WWhleWthSk5GL3FUSktTZC91VlNlZXZRRmhORDh2NmpQR01WczNYbHdaUzhL?=
 =?utf-8?B?dzRObi9IMkVyUHZTbDJrM2NnMVBkVjAxcEZsamVWL0twQmhDVmF2cnNOcksx?=
 =?utf-8?B?ODJyekZsMkNGVmwrbnRBSG0rblhERlNuRnBxYitPS0hJYUg0NHJnTEFxdVVB?=
 =?utf-8?B?WENTaFg4aGRZZDBqTkoySEgvUVl6cWFQL0NuMERDd2xNQlE5N1FLMGkrdW5y?=
 =?utf-8?B?NDhDcUNsYUN2WENPaVk1VjZOblkxVysyOTREWjhnSFhNSG5qOGFQcUxvN2Zi?=
 =?utf-8?B?WHhBQzVPWk1CNmg3TU5FNjVlQTk1Mi9oZ0QzRXJERC84dUFqcFZKaWNGZG5F?=
 =?utf-8?B?eTZpbUJqR29oOW1HVFRYNlpDSWtYQXdpdnRCOGZtSlFUTTZGYjY3VWY3WVZC?=
 =?utf-8?B?eDhlaHF5cGpXTGlEbnd0WnZwdno0cjJCc0JIKys3UHJma2E3UXhwdGhXYk9D?=
 =?utf-8?B?ZUp4ZzV4RFk5cmNSZXdCNGpaV09jZWJOUnRDdVUvd2YyeHl4UE1wSGozbUYr?=
 =?utf-8?B?bUZ0R3V4U2pPeVd0L2VxQUdsdVJmenhlZVhFRkpVblIwY3gxeXR0Lzh4TTBx?=
 =?utf-8?B?ZG5KRHUyQ2dTdjRmVGNQUlJjL1QvbTFGV3lpZUl1cFNkTjkrQ1FhV2tPb3BS?=
 =?utf-8?B?SG0rQkh0YVJQZ2VPN01QMVdUU29ybUVCK29Mc0JvNUVZa3pDKy9zaTBPMlAz?=
 =?utf-8?B?a3EvQi9QK0lHcUxubmxCcmx1V3g0WkgzRGpKbWlHUDExMC80ZHVvd3hoRzg3?=
 =?utf-8?B?RDV2akdGL2FkVlFkckRzejg5VjVsVENPVlZ0UURLZlZTT1hPM244K01zQnBX?=
 =?utf-8?B?aVJ3ZjZCU0hOandDc01hbFFXaDI2ZlEvd1M2ZDBlVmZWYkZqQndROVBnMmpy?=
 =?utf-8?B?UXNLbzhtZS9Dc09CZkxXY211TVFBaUkvc0VtaGhSVGIybXBITjdHdTRWZ1pz?=
 =?utf-8?B?QVNaMHBlaERXLzVqdHN3Q1BNS0xmRmIvUEdzQlY0MFhabFlRY292Tlp5eVZM?=
 =?utf-8?B?bkg5MHkycnYyS3lYTWNCSnRvSFVPTy9zYlJVZmp3V1BpeEt4OVdzdFM5NjFI?=
 =?utf-8?B?d0tiT0RFMmdNL3lLNCtpRUNITUpPWjd3blNxK1FQN3VxS1BHM3EvUnJJUlcv?=
 =?utf-8?B?OXhYNG9TQ0QycFFaQ3JoREFsb0ZXQmdkdUhlRUl5blA2VTNxTjg1UGRqT2JR?=
 =?utf-8?B?RTJnbTRvWjQyaUFtcUFCTUNZd0hGbWJuU1pNZHpsUnJHZ2xjdzZXajQ0Z2RE?=
 =?utf-8?B?Z09hN3pZeThCUXlCSHhhYy9xUFRIck1oVnNRU0VtbkZVa3dLTS96WnJoY3M5?=
 =?utf-8?B?Ni9BekQ0WHIrWXRaclpMVlFncklOalI3M1Jyd0VmN2JJUWp1QXBLNzc4M2U2?=
 =?utf-8?B?S0RBQmdPOXJpM1N5SVVtNzNaVFRweVR2UEFRNEZib3Z1MWZWK3RhcGF2SHNK?=
 =?utf-8?B?WmNjWVYxanZndDRPNm5mY3RpM3BvVk5aSVFiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkQvanUxeUdkd3hxZk1NZHRSb1d6MTdQZnhoSjhyaVdFR0lQcHRJdDg1WG1T?=
 =?utf-8?B?TzRISGRNTHo4cWNoU3VidUtiZlFBUUlFdExaWm5VZTE3V0xXZEdFb0RROW15?=
 =?utf-8?B?MS9kTkpBcEVXUzZIRE1ISUtnVEFnM1BwdWxQY0NjamlyekRkRVFBZERyOHJq?=
 =?utf-8?B?SHBwUWxBY0hUQ3A4NVhKWnhIZU9ZaUFHQWZ0VlllZUJFa2hIaTUzcUtJdEwz?=
 =?utf-8?B?WG4wMlY4VU5ua3pDeGRGZDNFeWx2a043WTdGV1hDcFdUQ3BlaXN6QXVFb3RW?=
 =?utf-8?B?cWIxd25hZXlsN3FQaEZQRWlSOWg2STU4Mkd6TmVJV2ZpeEY0UmV2aW8yUWFy?=
 =?utf-8?B?bkRTL0ZTSUsva3JEQytCQ0RvOXZMSW1Eckx2VmNRWDBKUXZDZjI3akVjSFRa?=
 =?utf-8?B?UTNPemJGbXlQUHNocHF2c2Fmaml0RmNGNE9qS1Z2cldyZkc4U3hlODZmUnhC?=
 =?utf-8?B?ZHYxT0hCaVJtK1hyVEhlUHNaOCtVWEs4MEp0OVRQVHNLY2JoaVFsWnV1NmZQ?=
 =?utf-8?B?eGdDVnJLREpTUUtqait3Tk9PN0svVm9NUGxkOWU5dXVReGNTRWdHaE5WSHJE?=
 =?utf-8?B?WkQrR3dMRlhaMlNxZTZpeDRTZkpqZDBvdHoxQTV2MnV5ZnoxU25IWHZSbmFM?=
 =?utf-8?B?MDBRL1FKL1hRWWZYR29Jc2xQWEV4MnRydWpUVjBWOG8zcTErMnBsTWs3MGR3?=
 =?utf-8?B?blpVak1qazR0b1dGajB3aWxnbGpUSWJnejZ6QzF4VHNGMG9MNVYyOXJHaG5O?=
 =?utf-8?B?bm9ybU05bmZUY2hUV0ZZNUpraytCWnFaQ3RvUGZFSUxtRzM5YjlpK05XNEND?=
 =?utf-8?B?T1ZIb1pzU01VamU5K2F2MFY2cDgvcEtXZGhlaUh5WjdIekZvTWNIYmJOL3cr?=
 =?utf-8?B?ZHFHbm5lc0kxZnoxL2g4M041STRYemkxOThldm51cXU2bzZ3Vy9rdlZuaHdX?=
 =?utf-8?B?Z0FzN0RGT0RWei9VQjdTOXZab1F6SUJiSkhVOEpxZ0gvcXdheEJPRkdLOExE?=
 =?utf-8?B?WHJhWmxvNzN2YUdwakNFaWNHS0JHQjBkQktqVWtCY0paWFR6SkpJN3JaS3VY?=
 =?utf-8?B?S1FuSGR4REtSNU9RcUZtQ01oWSt3SXRCUlV4akgxaTNQSTFHTEo1elJKOXp6?=
 =?utf-8?B?SkE2dCtKK3dWUHZvTFlmOUZhMFZaMjF5NzJ0c3dNWmRoZHI3STBFa083ME9G?=
 =?utf-8?B?bVNhZ2lmNUpYcDVEN0VtQUt2MWRDWE0rQU9rZWs0UnNFcEhFeUlxUmlEWVRO?=
 =?utf-8?B?aTdtRUJMbGIveVFZYWNaTExyQ3owOTJGTy9UQk5weWlOazVyMHRNU2lZbWI5?=
 =?utf-8?B?VHFwWWhXUmhmUVpIVDJGMjdDMmpqamlvYU0zTVgralBjL1VkeU5YbFg3bU5x?=
 =?utf-8?B?S05OWkd1R2JLZ2FGNExCOGNGTHVmNVQ0V21McXVCdDc5bW5tN2lOaWtmRVlV?=
 =?utf-8?B?d2hYcUVUbUJMdmNYeGJnTUJ2WGFuT2FabUpaeFBwQVFTZFJkMGM0cTNudkRU?=
 =?utf-8?B?ZjlUQmlkbDd2NHpGOEhZelI2TG9RVVo2b2R2L0IxWXEzanA2NCtjTlo0V0xn?=
 =?utf-8?B?ckxrOVdnNXVYNU5FQytGclAyU0QxNGxYWW1BYXVMVS9jeFhJTWZ4Mkszdkp6?=
 =?utf-8?B?YmdFWCsrQW56SzJhaVBQcWlrMDlpNVFMU25iZmxzelZNcVpGVmtwZk0zUTNm?=
 =?utf-8?B?ZkVIR2ZjYWo4NWtBeEVuTEt1QXBESWhhSVVXWWF1dHlWY25YOTQwOGNTQkRn?=
 =?utf-8?B?eTVmTjRTZGp5Z051Vml6RHllcDdJeVFMcUlUTWVDT0g1ZWtqTHdRQnNSQXhI?=
 =?utf-8?B?WnBMT015cjFkSmgrUnUxMERoN0drSlBId1ptS1JuSTUxU2crUXUyRUpLY1FT?=
 =?utf-8?B?T284ZGtMd21zVm9ub0pPM0Y3NXNtYUk1bWtOMlRPTW9LUkFWMHdPNExxeVgz?=
 =?utf-8?B?eFcrUHBFaTVyK0FwNGJSRXpNaURhcTBqTXZLMjBrakdvWjJhOStZS1daakZn?=
 =?utf-8?B?U2tTYmxWRDZyMmRvZDFvTVZlNFIybHI1RW5NbHN0eUlQWnhYcE9tQlF2K2ZK?=
 =?utf-8?B?RXVySXQ2YTNqdHR2TmtVOHF1cytWbkJNUjVsbXd0VVN3WjFVTFZJYytwSXB5?=
 =?utf-8?Q?lJRRaca6RdkP35uKnBfiDzTAW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15ebe3b-7dde-485e-7282-08de1329a2f9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:17:48.3988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EepdTkRNXpW8d5x3FRBSkfBB827Yt9zos7PFB+4GxurBmIT0tyTJkYwELKEbGCOBt19KVnGNpFyRALYE7hW1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

From: Joakim Zhang <qiangqing.zhang@nxp.com>

There is a PMU in DB, which has the same function with PMU in DDR
subsystem, the difference is PMU in DB only supports cycles, axid-read,
axid-write events.

e.g.
perf stat -a -e imx8_db0/axid-read,axi_mask=0xMMMM,axi_id=0xDDDD,axi_port=0xPP,axi_channel=0xH/ cmd
perf stat -a -e imx8_db0/axid-write,axi_mask=0xMMMM,axi_id=0xDDDD,axi_port=0xPP,axi_channel=0xH/ cmd

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 65 ++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 2a8426a74af98cf46725c2c70534829e198746f3..328287ab6326e3832aed85633957196548435d67 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -53,18 +53,27 @@
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
 #define DDR_PERF_DEV_NAME	"imx8_ddr"
+#define DB_PERF_DEV_NAME	"imx8_db"
 #define DDR_CPUHP_CB_NAME	DDR_PERF_DEV_NAME "_perf_pmu"
 
 static DEFINE_IDA(ddr_ida);
+static DEFINE_IDA(db_ida);
 
 /* DDR Perf hardware feature */
 #define DDR_CAP_AXI_ID_FILTER			0x1     /* support AXI ID filter */
 #define DDR_CAP_AXI_ID_FILTER_ENHANCED		0x3     /* support enhanced AXI ID filter */
 #define DDR_CAP_AXI_ID_PORT_CHANNEL_FILTER	0x4	/* support AXI ID PORT CHANNEL filter */
 
+/* Perf type */
+enum fsl_ddr_type {
+	DDR_PERF_TYPE = 0,	/* ddr Perf (default) */
+	DB_PERF_TYPE,		/* db Perf */
+};
+
 struct fsl_ddr_devtype_data {
 	unsigned int quirks;    /* quirks needed for different DDR Perf core */
 	const char *identifier;	/* system PMU identifier for userspace */
+	enum fsl_ddr_type type;	/* types of Perf, ddr or db */
 };
 
 static const struct fsl_ddr_devtype_data imx8_devtype_data;
@@ -98,6 +107,12 @@ static const struct fsl_ddr_devtype_data imx8dxl_devtype_data = {
 	.identifier = "i.MX8DXL",
 };
 
+static const struct fsl_ddr_devtype_data imx8dxl_db_devtype_data = {
+	.quirks = DDR_CAP_AXI_ID_PORT_CHANNEL_FILTER,
+	.identifier = "i.MX8DXL",
+	.type = DB_PERF_TYPE,
+};
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{ .compatible = "fsl,imx8-ddr-pmu", .data = &imx8_devtype_data},
 	{ .compatible = "fsl,imx8m-ddr-pmu", .data = &imx8m_devtype_data},
@@ -106,6 +121,7 @@ static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{ .compatible = "fsl,imx8mn-ddr-pmu", .data = &imx8mn_devtype_data},
 	{ .compatible = "fsl,imx8mp-ddr-pmu", .data = &imx8mp_devtype_data},
 	{ .compatible = "fsl,imx8dxl-ddr-pmu", .data = &imx8dxl_devtype_data},
+	{ .compatible = "fsl,imx8dxl-db-pmu", .data = &imx8dxl_db_devtype_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
@@ -290,6 +306,18 @@ static const struct attribute_group ddr_perf_events_attr_group = {
 	.attrs = ddr_perf_events_attrs,
 };
 
+static struct attribute *db_perf_events_attrs[] = {
+	IMX8_DDR_PMU_EVENT_ATTR(cycles, EVENT_CYCLES_ID),
+	IMX8_DDR_PMU_EVENT_ATTR(axid-read, 0x41),
+	IMX8_DDR_PMU_EVENT_ATTR(axid-write, 0x42),
+	NULL,
+};
+
+static struct attribute_group db_perf_events_attr_group = {
+	.name = "events",
+	.attrs = db_perf_events_attrs,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 PMU_FORMAT_ATTR(axi_id, "config1:0-15");
 PMU_FORMAT_ATTR(axi_mask, "config1:16-31");
@@ -310,7 +338,7 @@ static const struct attribute_group ddr_perf_format_attr_group = {
 	.attrs = ddr_perf_format_attrs,
 };
 
-static const struct attribute_group *attr_groups[] = {
+static const struct attribute_group *ddr_attr_groups[] = {
 	&ddr_perf_events_attr_group,
 	&ddr_perf_format_attr_group,
 	&ddr_perf_cpumask_attr_group,
@@ -319,6 +347,14 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *db_attr_groups[] = {
+	&db_perf_events_attr_group,
+	&ddr_perf_format_attr_group,
+	&ddr_perf_cpumask_attr_group,
+	&ddr_perf_filter_cap_attr_group,
+	NULL,
+};
+
 static bool ddr_perf_is_filtered(struct perf_event *event)
 {
 	return event->attr.config == 0x41 || event->attr.config == 0x42;
@@ -655,7 +691,6 @@ static void ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 			.parent      = dev,
 			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 			.task_ctx_nr = perf_invalid_context,
-			.attr_groups = attr_groups,
 			.event_init  = ddr_perf_event_init,
 			.add	     = ddr_perf_event_add,
 			.del	     = ddr_perf_event_del,
@@ -737,6 +772,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	struct ddr_pmu *pmu;
 	struct device_node *np;
 	void __iomem *base;
+	struct ida *ida;
 	char *name;
 	int nclks;
 	int num;
@@ -761,21 +797,28 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	if (nclks < 0)
 		return dev_err_probe(&pdev->dev, nclks, "Failure get clks\n");
 
-	num = ida_alloc(&ddr_ida, GFP_KERNEL);
+	pmu->devtype_data = of_device_get_match_data(&pdev->dev);
+
+	ida = pmu->devtype_data->type == DDR_PERF_TYPE ? &ddr_ida : &db_ida;
+	num = ida_alloc(ida, GFP_KERNEL);
 	if (num < 0)
 		return num;
 
 	pmu->id = num;
 
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d",
-			      num);
+	if (pmu->devtype_data->type == DDR_PERF_TYPE) {
+		pmu->pmu.attr_groups = ddr_attr_groups;
+		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d", num);
+	} else {
+		pmu->pmu.attr_groups = db_attr_groups;
+		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DB_PERF_DEV_NAME "%d", num);
+	}
+
 	if (!name) {
 		ret = -ENOMEM;
 		goto idr_free;
 	}
 
-	pmu->devtype_data = of_device_get_match_data(&pdev->dev);
-
 	pmu->cpu = raw_smp_processor_id();
 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
 				      DDR_CPUHP_CB_NAME,
@@ -832,7 +875,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 cpuhp_instance_err:
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
 idr_free:
-	ida_free(&ddr_ida, pmu->id);
+	ida_free(ida, pmu->id);
 	dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;
 }
@@ -846,7 +889,11 @@ static void ddr_perf_remove(struct platform_device *pdev)
 
 	perf_pmu_unregister(&pmu->pmu);
 
-	ida_free(&ddr_ida, pmu->id);
+	if (pmu->devtype_data->type == DDR_PERF_TYPE)
+		ida_free(&ddr_ida, pmu->id);
+	else
+		ida_free(&db_ida, pmu->id);
+
 }
 
 static struct platform_driver imx_ddr_pmu_driver = {

-- 
2.34.1

