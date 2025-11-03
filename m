Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71C2D7D41;
	Mon,  3 Nov 2025 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206554; cv=fail; b=N3gaSd3cGyTEmNdMQt3ml44WP7E7lK/xbKYRK04IytVlyGOkrA+jsOtBuhvImNgsJSzojIAk0U7teZOFvOgsn4mGsn8SFyAii4ARfqfrxipQ8z8Uj6PUA93E5McQSGGySFKwSoJsi87VuWBwcjhBmkKZNjpQCCC5Hb1xVIg8x8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206554; c=relaxed/simple;
	bh=lL3PHbQB9BliLrPOwqyoxNzEa2Xr3lLa2ZMWIrSgXbo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ShRnXCBkFAnU2Yeb6cWo8tc7cvWr/gQSarT1DRQkx6m2gOwsi2L/VA9KBvy8Q2bPG+dArm5FZhqJp97Xv+dQloqfBQDh4761dt2R5/WpJjYUEm1D9lHB38k7Dte+RXYmd+0P3HCLKf0LzOW+O1nTl2rDMQHj+vMFJSyuPgfoRQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LMmBw+Oy; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LMmBw+Oy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYSJX5UYgVCspSGB7C/AaO1Obl8GUAhuVva93eQ9VUmZQ+EEMx0vr7WuqvY28iFrsTnxtJSgINVBgKR4PFnGOnlPRu8n5MLaldOT68970TrGvzfxookCAuhutaF8EB2m0peX+cnaMdk21ngiUe8n2fpLzBkXZtvruq/scR3a49FepxnDeM66AWYdNwGB2Js9wAjL68IU9l4smtIjVPd3F6DiGaTmPVmEPw75mxPZHQdPH/JHkyNO3MNl9kdQ7WYoH1xzZo+zvNUFSzR88d5mEi4KsOzzr0VraCngPH27vxbbEylmJMTIN2ZO7ahW225YH4/y+RKPkG3sl1kJmiC80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgowNT4jGBUzcmPNcJ06gqG0j872POtXYzkSObd50OY=;
 b=uc1/j0HpMyXqu5WU1yDX2W8a60vAITgy10r18MkKvaSZZTFOYjWpztxy/mMxD7y/WiELaIMwC8zSqcpgu1QyWDSfReTNMvtrbkuvF1gdocWbgkVitc7zSud5WL0dtk6xgt98m4U/Aka+40CfBwNWT/Pw2ZZ3MfP7jMTJmKOx5CR0l1dfF70UssqS8/HdJv29L2lcINs0fspB1lK0R5EAju62RnfXj3n0hnm5EmU77vRUrDCvQbJ+5RUlwGAGcoR5QhJg9QOrPlukqvdk3Hob5gwGH9hMK43zOTBDdFR3Q5Cg4BeG8f5LFiEGjTt5wfpnKEq5mFG5HrWJ5gV/GdjN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgowNT4jGBUzcmPNcJ06gqG0j872POtXYzkSObd50OY=;
 b=LMmBw+Oy7/PpTgA2E0qI/thqT0csGbHDBWxuOIcrznbPbsiHDHk5cnhfReJe/3XVFoUYC5j9M1SKJ65San4IDPka9F6E+7QQcWXr+PtUV8fHfRmx69+Agr5oZ7xSpAGVnHOgeK8RveBqXEz+2LwOeT/KBTmyDEQMKuuI2fLVCBL7JS4C/ylyHNZi9EJ4/MLNIr/MBA1uHlwTq+EC2n2k9sGUBL3u/siYJwqQRIc8GmT9xwLC/13lvxRNveFnbs22eDYxtM/z12nE7lxjfaUZ2lzf/DAQgICql/Qsu6V0OSv1uOLPHYfwUYqc3hTvAoJkRQRtZGxzCWDMCTCj8++oVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:49:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 21:49:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 03 Nov 2025 16:48:32 -0500
Subject: [PATCH v3 5/6] arm64: dts: imx8qm: add ddr perf device node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-qm_dts-v3-5-2bfda8ee14c2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762206519; l=2726;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lL3PHbQB9BliLrPOwqyoxNzEa2Xr3lLa2ZMWIrSgXbo=;
 b=tE/iosOHrAm45D1KCK0+dGSKVMoWlPGjNnyoE+A1+Z67rAarARA/1ye4OIktqnKjY+96j1ISl
 wbR/7U8a/40BcWaAYRq349A2JTWHlb4IuHSBeFvrgSxX9EdrrlpiMvV
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
X-MS-Office365-Filtering-Correlation-Id: bc317a74-b66e-4a8e-a9dc-08de1b22d124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzlwZEVINjVmRXZTYjI5K2pQbGRCd2lsZkZWSUtJM1NxUnNiZmU2cjZnNE8w?=
 =?utf-8?B?b2VzTkUvS0c4dDBwcXQxZHdhcnRaZURycDlpOHdlUFJJdmVtV2NZaXpBaWVh?=
 =?utf-8?B?RWdXczRUSXJyT001SlFDV25PVnJiQzdzODB1Ui9ocnZtMjFRa0IySlBSM21T?=
 =?utf-8?B?aXVGaVdKVE1MQTJrcVZlcG9lMit4bGdFbEt2Ly9zekduUHREcG4zNlhxTHlE?=
 =?utf-8?B?YllPZ2E4R0FFUnFKeWNCSzJiM0RNc1Y2RGZlRENtTkVjK3hZVnUvRUR5Skxp?=
 =?utf-8?B?bjZrekl3YzQ3dGV4d2hVT3lEekg1bEl5SFdUQS9HOW80UkNjZ2FLb3l6QWli?=
 =?utf-8?B?YXhEQ1dUWHFud3J1WlYzWENRaXYrMlU4UEw2WW55eVN6dXRDUXBYa1REYUhS?=
 =?utf-8?B?OHVoM0hiWEtIRkw3KzNXRUtuM3pCTWhlNEtGN0gwTW9GQmRJKzlhU0dRMnVl?=
 =?utf-8?B?TDRrcVMwN1MyTXZRNjFoQ29GZXpaNGphY1BsazJEckMyeGFtUDFNS1ZzOUlN?=
 =?utf-8?B?MnZNbFVQSEdYMkVldXFCblBGNGp6RVNhV0FWa2ZJNGVqcGZXbjF6T0gzcGp5?=
 =?utf-8?B?VzdSem1TTmJGcW9rNWNOQVdyQkIzdEFrbTJLVng2UWFqcFR3Q0ZiY0MxWkUr?=
 =?utf-8?B?ZTlVSE5TMUIwVjk0U2NuK0hLeWJKVmpZQzJNZ05FT0dBWWFBQUo0NEZzYVdw?=
 =?utf-8?B?b1VTVllPSWRBM0pQcXhmYUliWWtxU0lkby9WU01kVzhpbDNuV0gyd05ybFNt?=
 =?utf-8?B?OVhMR2tNZEEweEViNWNQNzB1SUN1cS9LK0R0VXpObUpVS1oyNFdpNkN4Vi9U?=
 =?utf-8?B?MjA5amR3c1F4cWtJYTEvRFgxUVZmR0I5amZXS1dCTm5oNXFVeDlmZjExWGRO?=
 =?utf-8?B?b1dpVU5MV0w4SHlqMVptNG9Bdm9vdnZRcSt2Z2MvYmo4Q3ZWODRzTFB1Qk1V?=
 =?utf-8?B?SWluc2o3VkhiSDFJMlhIeXRBQjNQSzB2YjczMXpnMU10WTJKbzZTbzhIOUhT?=
 =?utf-8?B?NGZsUUdzbkhXbXhObjN5eGJKeFZvRnU0WkV6NUZ6U1JWaVBaTXRXZ3RNakJE?=
 =?utf-8?B?VUZLMm83VzZ1THR0Ym9wR2FOc3hXdmFnUTJSS0ZEbHE5Q1lLU1RZSHpaRlJp?=
 =?utf-8?B?NEV2NzQvdEZPMVVyOWE5MXcxRDRROVBMNnFyNHhuc3lSY0l4aWdmYmU4OXRG?=
 =?utf-8?B?a1dEVU5EUy9oa0VLNXRiSWRQeDdpenkrL3dxY2hrcTAvak9XTlprM1JIb0Vv?=
 =?utf-8?B?dndMV0VYTkhkRk5VYkxLTjBlaCtsMTlzU1dXWG9QWnpWZXpqR1doRitiR0tQ?=
 =?utf-8?B?bTlXRFRTcC9OUk9JenR3dXRBcEcrRkFEVys1YlB5cUpQNGZTZSs0T1JONk14?=
 =?utf-8?B?Wmtsckd5ejBMYzlBOU1VOFdUaGxzNEJXTEJHU1ZaYVNOenBJV2M1dG5JU2hW?=
 =?utf-8?B?cDZXZ1RzUzR6SnF3aFdZaE1PMFdiZURHTDFLQkdHRFV3YVNmc2dDQzgxRERX?=
 =?utf-8?B?VUUxejBkRTQwc0VqYlJBUEU5aXpBeXhxQXBTYVo2cDBQWmtGUjkrZHJZM0dZ?=
 =?utf-8?B?MGJCN3hUK2pLZWErY21OUEQ3cy9wYmhrMEdqbzNpanY1Z1IrOGt3NXUxM1dj?=
 =?utf-8?B?VkNWTW5KWFJJbjFwODNqd2ZxTHpBSVJ3Z3VTR2RLcmxoVjdMOVhibTN2ZFdv?=
 =?utf-8?B?OE1uWi9SVFl1V0ZMVU1mRlFCQUo0dWc1T0podkxRZGYwV1RKMEtvZVBaRFJl?=
 =?utf-8?B?eENyK29ZV3Y3UnU5aDBlRVB3UnFHRWhtalA0a2s0SktoN3o0OTFlWWF3ODFi?=
 =?utf-8?B?cmFxb1o1ZmpHKzk0bHl6T3B4L0Vsd0lkdkVjVjZVLzF6bERsR1pNZUVqZzlU?=
 =?utf-8?B?NkRlYlloZkhFNCsxQnV3eTdOT0FGZmY4OFgzMGhSeGgxVitaOC8ySnpMQmtw?=
 =?utf-8?B?aVJhMEdTOTN5WExCSTRYYXM5L20ra0wyMVZ5a3JJc2ZKeFp4ckNpK2psQnQv?=
 =?utf-8?B?NkIxdHFGa25GbmI2VTA5WGtUS2RoQXhDSEIwaGxGRnhYTlkveVF4bjhqQml5?=
 =?utf-8?B?dml4allodTUzOEtaR0c4aC9IaW8rZWZuRUVUZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlloUENKVDVVTDdCaUVOZnZ0bks4L2VMcWZ5VkI5b0UrSlRWQVdxM2xGdkRR?=
 =?utf-8?B?TGVaUFdFcjJoMURoREdiZmVHZ01GdzkycDlXU3RBUnZ0ZXo5OGRJK0pIT1Bx?=
 =?utf-8?B?Rk5wcE4yWGhYbjVCUVdkRGZZL1RSMGljcXVoTk1TZ1AzOUJVd0ZtYnlwdHhB?=
 =?utf-8?B?b3NCaXIzeGlBVVV3czdCQWlCQ3BiV0xwVTRFYXdxZVBhampIN05YTnA0bDVh?=
 =?utf-8?B?a0pxSlNZVE5RVmRwUU5mclpBaElsbFhZeEVEZnJBS2VFQTN1UmhISWZ5RVlo?=
 =?utf-8?B?ZDN0YUhDQmJQdXJXWXlEaS83MHQ2eVZGRnU5UlZqdEVsQjdrRGFyYk83aHZ5?=
 =?utf-8?B?YlJKSGxoUWZYR1A0RURsSnFnUEF2Y3lpejlHK3dMVmh0eUZCdmZGSkUzajhm?=
 =?utf-8?B?Y2tvRm5tdkgzM1FCZm5zTEFrSTNCNEp4dERXNmJnL3dVelllOENMeVVORGhW?=
 =?utf-8?B?OTVVdnYzeHhWMkh0UG9jNDJEejJ6MHhnRU9sZlp3NFRJaXJrTG5EUHFrcFJW?=
 =?utf-8?B?VGxjNVRwUnZHZW9rdWh2L3JyMHlHVlpVZjVicFh0NmxuS0doVE93bnpabzV3?=
 =?utf-8?B?blY4eHlkZ2RqTWo0ZnVTOVhkQ0ZRbzI2TjhTdDRDa3JRNmhHbGtjNHoza1lW?=
 =?utf-8?B?L24vYjR6MGNNL2hhUjh2eFlUUHcycGM0UWx2U0VObW5wbWtTRjcxYnVweGtH?=
 =?utf-8?B?LzB0ak5HV1krZnlDUkw4aDZuSHVNdmdxRkVUYXlEdWw1eDFsVGtjLzg2Yk04?=
 =?utf-8?B?Ym55d3U2NnMvOERTQlV2UlpiU1JOWmRNSFZrZ3EzeXpiZzIrVW9kWlRodlFO?=
 =?utf-8?B?QldEU0R4RHB0YnNXaVA4dHBIU1UyYzZ5YkhIOTFEKzBDK2FoSkNLY3RtMzJ4?=
 =?utf-8?B?cnJ4UkgydzVyY25kSklpOGJhck1sRThKZC9mWDR4dnJSd0RZWlVreEdORTBl?=
 =?utf-8?B?MmV3a0JDNGNCcG9PZmRraDZreSt2c1JCT1hBdW5Da1U4U3JXWEY0UFRTTWlp?=
 =?utf-8?B?UUYrbDFBZHZrKzRZaWZhTW5LbEMxQUNwSi9FMTl2MGRwYkR5VGZlNy9DNmF1?=
 =?utf-8?B?RDlFRENYUXR1ckNYMzRNWUdZdnBoNlpSclBydm1OTGxRcGdlTW84YllRMWhk?=
 =?utf-8?B?OUZHZnNydkoyQnN4RmlXcXhHWDdtZW9PaDRDU3dhamlybDZKcFhyYXplTmhC?=
 =?utf-8?B?TDY1SVdPTHhDQlNDQWorUGMxcWxhS2NqYlgrZGh2d1JNQTN1dmp2K1Nyb3JK?=
 =?utf-8?B?YzFLbFU3VS9EYTZlVkI0V1NtZTNzZVU5eWtrOTlYUWZoNVhRTUNvbVJhRlZR?=
 =?utf-8?B?SXNXbzVseUxHN3FEbjVOSTBYSGRic0MxSjhEaFVlMmQyK3d6Z0REaWNPb3RU?=
 =?utf-8?B?VHhhQjZsYVRsUkY4SjMraGoydkRuMklYaTd3RjVUZnQzZ1lKU0VvdDV5MGdQ?=
 =?utf-8?B?TGpWYTNGalltazVqalNwRkY5ellUZWJ5UlNlY1JORDZqeUlqODVwdXRBU0dG?=
 =?utf-8?B?dzhNZ296UC9OeFFxc29JTWVOUStCK1doMUlaMzZrM2pCeEcwV3AwcjNPcW1V?=
 =?utf-8?B?Z1ZQMG9DN3EyRkFrYklvOGJ4NUR4N0h1cnh5cHRWdDIxVURCdnhWeEEyRlFK?=
 =?utf-8?B?alNReCtaQTVuM0R3K1ZsYVJSOXYyMUFXWGJ2em43elRxcElkVlhCUmlPL3NZ?=
 =?utf-8?B?N2R6ZEZ1VnpreElab3U5T0M1NDFxaFpJczRzWU9pdkFuRmxGMTFSZEM0dk9D?=
 =?utf-8?B?b29kM05LOVZHWkFFb2VRaXVkSVU4TXQrNTEyelh5ZERXUCtLVFRtOXNYeHVx?=
 =?utf-8?B?ZmxZajZoM2JwREZxRXVwVTJibnByT2JXZlUwYXJRNyswc2V4TU9hVU44MExK?=
 =?utf-8?B?NFM5TldGMG82dmhydE9MdVhKUUVWbTJ6b0dHbWhIUjMwdTVZK3I4QXdFK0Ru?=
 =?utf-8?B?M3h0WEZpUXFCTHZtRjhFRUlrSWliQ0FwM0FIUEF5ajVxeU9mK296aDJnbDVD?=
 =?utf-8?B?VkppeFlXS2RHYzlJU0FqUEVhcmp5QmtlSmllcWJldVhiQm9pQS9tYy9WMjdZ?=
 =?utf-8?B?YW4rSnZ6Z0pGWHpES202NE9pOEU2U2VPem5ncVBzMU10RFl4NE5pNWdPRy9N?=
 =?utf-8?Q?t1JadobbZPmF2vpntI9Z1PZm+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc317a74-b66e-4a8e-a9dc-08de1b22d124
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:49:08.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIFO9GPX9sQkPnA+WPgWQiS4MyeAGZfV4gq9Na8y4UVjXwdOe8avWlvMCgGABokKTiKqRYZ5QxltM8M8q3/pog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503

Add ddr perf monitor device node for i.MX8QM. Change imx8-ss-ddr.dtsi's
compatible string to fsl,imx8qxp-ddr-pmu. i.MX8QM overwrite to
fsl,imx8qm-ddr-pmu. All fallback to fsl,imx8-ddr-pmu.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi   |  2 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi        |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
index 7d5183c6c5bef9b57f2ff92c5184272e43054a03..37e68865b026deb73ffb6a52207f5c05a0dbf5fb 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
@@ -11,7 +11,7 @@ ddr_subsys: bus@5c000000 {
 	ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
 
 	ddr_pmu0: ddr-pmu@5c020000 {
-		compatible = "fsl,imx8-ddr-pmu";
+		compatible = "fsl,imx8qxp-ddr-pmu", "fsl,imx8-ddr-pmu";
 		reg = <0x5c020000 0x10000>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..c831567cfbc1f2df7e3642c1f0ff080551462543
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&ddr_pmu0 {
+	compatible = "fsl,imx8qm-ddr-pmu", "fsl,imx8-ddr-pmu";
+	interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&ddr_subsys {
+	ddr_pmu1: ddr-pmu@5c120000 {
+		compatible = "fsl,imx8qm-ddr-pmu", "fsl,imx8-ddr-pmu";
+		reg = <0x5c120000 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 5206ca82eaf642a32299147e9c1b45704075e2b2..9ff0d56fe97078cabafb66db95b4ea82f95ebec2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -635,6 +635,7 @@ vpu_dsp: dsp@556e8000 {
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
+	#include "imx8-ss-ddr.dtsi"
 	#include "imx8-ss-lsio.dtsi"
 	#include "imx8-ss-hsio.dtsi"
 };
@@ -647,5 +648,6 @@ vpu_dsp: dsp@556e8000 {
 #include "imx8qm-ss-lvds.dtsi"
 #include "imx8qm-ss-mipi.dtsi"
 #include "imx8qm-ss-hsio.dtsi"
+#include "imx8qm-ss-ddr.dtsi"
 
 /delete-node/ &dsp;

-- 
2.34.1

