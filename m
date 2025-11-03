Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3232D73BA;
	Mon,  3 Nov 2025 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206552; cv=fail; b=UWHqLjLPTQK9M21rr0sfMoRo2X96W5Hk9RoBkxmZeID9jq/uajsKxUiNkcV0utJdRQPUavz1/o8FuOp6JBShK1Pbrk8GaIdPCU+97jJViO9vzSlJXLIo4V8TnTzob/HwY2kprdFzw7M+FIHcONq6jisGcnsQgL0b8bEBXoJvxZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206552; c=relaxed/simple;
	bh=grZUEOrAP5fqry2Hb4pEjHWtp9K4eepvM7LwH4nAJs4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mvSoERpiQIXYbGWOmYqxtX6x0P6++05LFIlEp4MBtKuH6ELIM6G8ZFN71FVZ23g+wqSmFNmElyi+UTFoPTYwqcdLV73fWC3GsYydtiWUdcRhb9Omzr6iWpGJyLtAQC8ilWtrHKsMGjFN3DslMk8qVcP77R4ssdKbdrvrCyKkkbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q11ftSkb; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q11ftSkb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7fObbmtnp3+Oacf2KfozneQ7ztK0/Q97ex3KiOhXQ8RCti9T/nmJQP0DE24MYeOArJncwstltZlzD6qoENUo8x/UWU8atosnl49MmEl/kcR1tv+JLc/clfoSzqQeGGyJ3EyLOcDYYYMD/bNmYAbPSP4WchaKCqu/JiOmzKwlktkFkvXxX3ttIHw+O4sr3dWIBK4t34m+JTA3093HbaUMlkAHNen0fCl5uW4Tm8jTGN2+lPbC/kR9t2nDZB6piqYfBCPK/pGdEKPHBAdZysZ08xosmiaUmpYeRrEsCYsTUPmSrU5tme4DD8HwjJe1HD/UTAUaCDkwconem4NxqxYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LuYeDBogM+EkdzEHliXToMNWnLSLlmdZUYDR+g37Gk=;
 b=Eevxpkn7prZjkMcqxWei5Aqa9ro1doX7cLm/cKRpFz3qcGaSTl3HbAtw914Epq34MpMecEs76ndcT+pf4KcC9cCiSlM9D8ArH7wAMWZzyCeo8b4a5m8uUQ8wGgBp8BNpqpFXlZPXkXMGbdUeqyajqFL0tLsig1sr1S8RjVFy9f6D7NT8vsaY4qrtHAQ3DiYyO/gHROHtNHDXPRBTYO592unr25lYL22HPA4HQRhxjpujZr3y3C6aZFl4lxAhT439mJrP2ZSSM+zi3iEWzbCp6ExK+v7278rZZUn+Y6RQQM6p2E0+9cc28eogDZpWnI6HoyeWik5uLngtoxnKZ0Xanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LuYeDBogM+EkdzEHliXToMNWnLSLlmdZUYDR+g37Gk=;
 b=Q11ftSkbSxo8pZcoF1pkASXAvKbkedTvDWERe49qUkBBvVez0VdDbWwHwPxhdljT783wyDP3bx1nJOyw0jBmX8E1pDnt0/dsCkAuBO5q6D4hIqNAjDoDHtSGvxQ1Jjv1B1bOAo2j8eC6gR8WQZ5phBm2TM0Ied2WOIwct65zT8hjvvyUcs30jj3kivxbyuM6HLl++N7+EljE5iCn7g71342z81D88R5xgh32Dsp5h6/yw9zFfDHbltFPTdiqvQR14vwNnsAtl9dSa98LKYYRi1PzB3GJw1Nsts39JeW6Vi5rDAsjYdxTFdl8iEEKlLUtJAmzFlE5VINIfP+eN/xqdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:49:03 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 21:49:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 03 Nov 2025 16:48:31 -0500
Subject: [PATCH v3 4/6] perf/imx_ddr: Add support for PMU in DB (system
 interconnects)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-qm_dts-v3-4-2bfda8ee14c2@nxp.com>
References: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
In-Reply-To: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762206519; l=5797;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+aGQhgrvI74pS1DLhxhbwa6pn1/d649VKFuGFeqXK0Q=;
 b=Fj1FrTwo4383Tdde7WvdAfjN2ynmxWqk/mZOdceQiG5647sJNEvxD88xiB5TVoGiaDKEXbb2K
 Jo7PsvjYp8SD5rI0bZ7yMvIhlJ9pn5psv2X+B4lv0s9TwkNmoMP3p4m
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11503:EE_
X-MS-Office365-Filtering-Correlation-Id: 097a1f07-ba04-4853-27a4-08de1b22ce4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1g5aUZ6ZHJMRi9VWU85UklBMzJrRnBlZ0ZEckJuam1WVldVZWlVNHQyTE9l?=
 =?utf-8?B?dm5nRDZvSTh1UGgreVVJTko5RUpEQW51SDcyVmpFbDZKZlFOUkZpaWo3blJK?=
 =?utf-8?B?TlZKbExiYlZKMG5mWmRiRzk4V3VmQk1WZURHMHdBMGZrRnh3NWJXL3d2UHQ4?=
 =?utf-8?B?d3oyQVZLUjAxMktqWCtDdGJKcVBITmNiczh0T1JPakt3RVZ4ZXFoUWdPNms1?=
 =?utf-8?B?K2g3NUFRQ3E2K2dWQ1A3RW5oa1VhTzlUMTM0WWE3a0x4LzJPb1lFbDU2RllQ?=
 =?utf-8?B?Zk9WVkpRSVdodXV6QVM5bEMrVHJjNXJSMzBnYzFOdU5rcjFtbUtkcTltZFRG?=
 =?utf-8?B?RkxmRTJ2bHQ4R0haaHpHcWZxdmRjK080cDZsMUxpTWsxSEtjVmJsenRhZHdI?=
 =?utf-8?B?ODNtc0tIQTBpRDdjUDRYN3RDakZrSFMyT2RraG5wUGwrZ2lIS0kvTzNReFcv?=
 =?utf-8?B?Z0tOMnNhQTJsSGFVdmEyUFlZVWx6b3BwTUZ5QmFQTXVkcDExbENYV0x1SDlh?=
 =?utf-8?B?eWdidWhMd0JGcG91bDdlZXpBMlZaS2psNmxyT3RObXNSVjhmRlpQR1lZR0lU?=
 =?utf-8?B?RzdLZUIzMlVxUENJQURZNE9pVHhpSHFsa2l5aHc0TVIxdjl3N2M3Z3lOL3Jy?=
 =?utf-8?B?QUE5ZEVuM0x4RGhjYmlxQzJmalYraU1aZlJJSkdqY05kZGk2U2VtcFJ3S0FD?=
 =?utf-8?B?WTFqd2lhaEh1dUlXd21RUGptK3NNM2dleTQ4ZGtGQzE2dU1zMHpoZjU4NFZv?=
 =?utf-8?B?TnlQSmZUSWdiNnRraWkzS1VpUzVGZUtLMVJoU21kdWEwMlYwWlJxamNMMjlF?=
 =?utf-8?B?eUk0YWpHUE1xbzdhSE1zempCejQ2MVFET00xeksrVnFST2FjTjVFaXY5S09Q?=
 =?utf-8?B?NEpwMHQvd0tFbXVUTXJ5TWViY2g3czV6K2txc0Q1clRYWWZaK0RSdWU3emV3?=
 =?utf-8?B?R0xjM2ZJU1dVVGxhR2lWK25uYUhMSm9tMlNkMXVLbUpKU2pWTy9WVkFJU0Vk?=
 =?utf-8?B?YURHTE1CY2dqNytwL3VlNVhaU2lFbUJpc1JmUGh5VVRmb3M4Z3VNRE9IdEha?=
 =?utf-8?B?VFlhLzVVQ096UWFOaDJneDhQQzgxUHNXbk00NWcxWTNrRnVuOElDT0tNSGhR?=
 =?utf-8?B?Ni9meStLUTNsR09YV0RWT2Y3YUM1RWxCUFlvSk5MandrT1JxYktabXZZZ1ZH?=
 =?utf-8?B?RWRUVE0xU0VSTTc3TWtyaDlyU2tGTno3SUxxZXRrbTVQTWp1eFBxc3ZnZ2cr?=
 =?utf-8?B?a2RTcXFPM09WSFJGRFlla3dpK0FJUEJtOVF1NFJ0K3o4MlJUYWYwblJtQzdl?=
 =?utf-8?B?bk9FeHRhV2l1c2x5cnJ2RzFBK1VOU0RxeTZiYUNhbERJODF2RUdSbmRwTUc4?=
 =?utf-8?B?d2Q3KzlMVGNoMkZHSjNMUE85TXJFZFNPcmJDSUszVGFwZnBxQVBNSEZFYm9X?=
 =?utf-8?B?ZFhTTnlERXZEMjdaaTFXVXhYU2NxL0VOMmd3eWQrc0lraDdqMlpTcUZJdVpz?=
 =?utf-8?B?cE95MEFibWRFcXhFUlhGWFhjMmk1QktERldVamNsN045UkdkSHltaFd1aUcx?=
 =?utf-8?B?NGtvZmU2TzFyN2Y5K2U2TmFROU5Gb2p4ejFtZFkvYWp4cUNMdkRla2pweGlN?=
 =?utf-8?B?bktpU3krVWhvejc1TXh2YlA2OVAwaWlIMVRFenFVTWtjUVFwWEgwcTBiZWd3?=
 =?utf-8?B?aFJvZysvNlhNaURRa2VjMXlpQjJpZ041d3c4eVA4dytzQVBFV0NuUEVBTmd0?=
 =?utf-8?B?ZXVCcGJBdGUrekcvT1czYzB6QmpTQXdJdnhNanc3aHF0WU83YXFndlp1bUdE?=
 =?utf-8?B?Sm1XZ2E0b0JrSklqaWFuREVKZmthdGwycmhaMTg2MFRLVStXT0ZRWUxYR1cv?=
 =?utf-8?B?ZnFFTDdMTVVvK2crTEc2WFIySzhWVlQ2V1B0R3YrUEptYmFTQnBISVZFRm9W?=
 =?utf-8?B?b05LM3NkSnV2eGlWRWZoR1JiQ1RWV2pxMENvZklUc3ltczM5aVZpeXBTWkhm?=
 =?utf-8?B?cC9zWWR6SzNrMjhrRWVORTduckEwdTJ6YnhBNVYwUENHaWFQUFBzcVRvaWpD?=
 =?utf-8?B?Vk0zS1RKcGFyNjZBZDIxRUZ4WElDeFlJSnFtdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnZNVHYxdkxvampwWnNUN3ZCWXV0MWVLaTdueXM1QTdTZXRQS0Q2TGsya05N?=
 =?utf-8?B?ZnNOWW9wQkZxRDdZR1BFb28xWm9mckhqYVhqMzk4VjhRMExER1dzWkNRWjVU?=
 =?utf-8?B?UjM3OTFjQkZHOEFyUzZ4VFlnMktuTHVFTndpNUQ4VlhQUm9hRW10VjdjSWEx?=
 =?utf-8?B?MjByU1IxS0VaZXBDdENySjQzK2pQMXpHcm5IQmhaSlBFZjlKYnJWRHBoeW02?=
 =?utf-8?B?ajFqV0pPandhTEp1eG8vUXl0ektUdk42a0grbjVRQ09UNFVVQTlZWDA1ZHVW?=
 =?utf-8?B?Q0FBMGZwcEdqQjhOcVk0Wmpna2c3RnFmQUhXZFJDV3A5T041SngzdFhUTEFw?=
 =?utf-8?B?NWlaZmx6RW41UVV1SVU3RzVrM3g3bHgzWk9OMVl2N0RpTytwZHVWcG1TNUtZ?=
 =?utf-8?B?dURDdGxOYWRORldkV1pYamlBc3p0aWVuQ0xOS1ZtQmlsbjhvM1pDY1k1bHBo?=
 =?utf-8?B?VlRZU2tSZHdvdTFyeGp5L1V3VWVWN2xEbC9tSUtBRExzaXlkdXR1ZVFZekpa?=
 =?utf-8?B?R3daZXJJN0Z5R2RXeHVYVVc5eG5SWm5jekJCbzY4RnpsaTJYOHhTMWw0UUJM?=
 =?utf-8?B?RVdWdDROS25Zbzk3ZEc1MU43d1AvbENGWlUzZWhEWWk1ejhMMytnL3B1TllJ?=
 =?utf-8?B?ZDNnUVdYUWlDOG5WU2xEZXpYNXFTemduWFZzL1NadlZPN2swQ1FxSzRGQmpZ?=
 =?utf-8?B?ZzlKbDIxdGc1VUs0VHIxQ3BaeHRkTFNxVW1EbmNaSFA0cGdXWlp2b0pyQjNn?=
 =?utf-8?B?WnJNOFd6akVMMmRzcmVkUFJlOXF3SVRBZEtpQzZMdmVCNkFDL0k0dzcyU0sr?=
 =?utf-8?B?a0tLM0dWM0pROE1GT0RqYWFWUGZuRkhSWGhvVWE3TERndHBiRWxHREk5eTFz?=
 =?utf-8?B?WFpZeVF3eHFMTEFDbkNFMjRialZVV25MeG1kOURSd0RhTFRBQzdWVW1SQWtt?=
 =?utf-8?B?VnRoZkdTcE1XYnFrYWhUR0NFTWFLYk1kK0VYWmRXNzIzVi9xdXN4R1FBVmZy?=
 =?utf-8?B?dDM0OXpiakhyWkM1b1BrNUsydlA4NC9jMFNxMFlmM2F1d1JlOEs0bGNoMEFy?=
 =?utf-8?B?aEZrNHEycFJUYWUwdUtSbVFkUGdaMTA4ZEZoTDV0Q3FMaHNIa3piYlFGa1BO?=
 =?utf-8?B?alBMWWJFNnFXbE44NGF2MzR3a3VhblJaY2Z0emx2dGljam0xSVpFUDQwY3Zo?=
 =?utf-8?B?VXpaWVFEaFZaWWh1L1J3d3lrN0NReUgzQTNmaEo4Q1AxZTRTc3lUNit1ZS9z?=
 =?utf-8?B?dVFWbVFKTC93RnBVSFVBSGJ5SlpTeFdVeG5LazNwdGo0VzBtSHVjMmVFejdr?=
 =?utf-8?B?Mlo0ODJyNHRRT3RRdEdHOGpCVEhJWjgxOEJMU1dWU3Q2YmptTDdPVURvTExM?=
 =?utf-8?B?U2lzRnFqQlM4RHN0RitocFRGRkJPdGQwaSttUklxVHVYTVQ5QmJVd2w2Q0lp?=
 =?utf-8?B?U1FadVlTTjFGQVlnMkUxVjl5T0lzRUVXTUozVEhyNHd0V3h3dnFxcno5RTNM?=
 =?utf-8?B?ampXRUJ1elB3U2N3b1N4dk9rdjhqYnZHN3pkOXhEUWpjY1c2MzZpSU9oMUc3?=
 =?utf-8?B?Rm9JSGQvbzg5emtCM2paN2RQYmtpNVBGaS9NQzhSUUlGa0R0WHR6THRlV0tJ?=
 =?utf-8?B?OFV1aDU5Rk00TGtmMEZOQUUrTUVDN0ZSK1gyOWJub2VFVXRlaVdNQXZyU3Rw?=
 =?utf-8?B?MTNRTGNJaXluSVM1OUFVVWlTYTh4MTl2UFRwZzNmMUQ0SjF4MFd1OUlLVHF1?=
 =?utf-8?B?R095L2g5RHlnMVJ6Nk90V3VLRzVMVzdJSW1HaENGdTNucTBxaWJ4TTl0VGNT?=
 =?utf-8?B?REtLYTU3ZnVEN3lwMHJqNzcvVnhBTGtEZ0hUajhqZmUvMnhRSzB0SWh4UEFW?=
 =?utf-8?B?Q0I0UFlCVlNmSjlhcXVlT2VRd2krTUt5NCs0bjJWYlNGK3AzYjdtU2tZSmVX?=
 =?utf-8?B?TFBOcjZkZGdkVU83ZlNnWjZsMXpkaWlQSHRaMEdxMkk3QkkzVEl4YUpiaU5E?=
 =?utf-8?B?WmxMbFBBVjhLbzBQVzEwUnVjUDZaclEyVU5CdjF1blJTMS9Ic0FpWVU1QytD?=
 =?utf-8?B?dHhpZWx2M2ZHK3hFcC8zODB2YXNFUWl3WXNIdkh2YVQ0YXJDNGNnbnh6VHlU?=
 =?utf-8?Q?eygPHkAZEeomPCaPoge3TVUoN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097a1f07-ba04-4853-27a4-08de1b22ce4d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:49:03.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtCongT+yMpCNTFH5tVCdlbxp1oegRSARlosY6jLrMfEwvabXbe9k37cj3F49AJfEtn3k4DuzEel3HdxUqrWMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503

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
Change in v3
- use is_visible() callback to show support events
---
 drivers/perf/fsl_imx8_ddr_perf.c | 67 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 2a8426a74af98cf46725c2c70534829e198746f3..bcdf5575d71ca264e4e5dcf3a9e1b9618d553f98 100644
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
@@ -285,9 +301,37 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	NULL,
 };
 
+static const int ddr_perf_db_visible_event_list[] = {
+	EVENT_CYCLES_ID,
+	0x41,
+	0x42,
+};
+
+static umode_t ddr_perf_events_attrs_is_visible(struct kobject *kobj,
+						struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct ddr_pmu *pmu = dev_get_drvdata(dev);
+	struct perf_pmu_events_attr *pmu_attr;
+	unsigned int i;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
+
+	if (pmu->devtype_data->type == DDR_PERF_TYPE)
+		return attr->mode;
+
+	/* DB Type */
+	for (i = 0; i < ARRAY_SIZE(ddr_perf_db_visible_event_list); i++)
+		if (pmu_attr->id == ddr_perf_db_visible_event_list[i])
+			return attr->mode;
+
+	return 0;
+}
+
 static const struct attribute_group ddr_perf_events_attr_group = {
 	.name = "events",
 	.attrs = ddr_perf_events_attrs,
+	.is_visible = ddr_perf_events_attrs_is_visible,
 };
 
 PMU_FORMAT_ATTR(event, "config:0-7");
@@ -737,6 +781,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	struct ddr_pmu *pmu;
 	struct device_node *np;
 	void __iomem *base;
+	struct ida *ida;
 	char *name;
 	int nclks;
 	int num;
@@ -761,21 +806,25 @@ static int ddr_perf_probe(struct platform_device *pdev)
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
+	if (pmu->devtype_data->type == DDR_PERF_TYPE)
+		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d", num);
+	else
+		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DB_PERF_DEV_NAME "%d", num);
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
@@ -832,7 +881,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 cpuhp_instance_err:
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
 idr_free:
-	ida_free(&ddr_ida, pmu->id);
+	ida_free(ida, pmu->id);
 	dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;
 }
@@ -846,7 +895,11 @@ static void ddr_perf_remove(struct platform_device *pdev)
 
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

