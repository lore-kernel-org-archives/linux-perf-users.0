Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3438E2F0C43;
	Thu, 21 Aug 2025 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774162; cv=fail; b=V1lK4FQc74Q+Gx9hZv8XKGSAe4zDLjW36ZxRzi0UWXtHfSvfbT5k/VIhf4/q2sYdbG+MmQ2tONZNec2k9U5xK/cNF368wMcW5qihnUkiCmEX75RcReA7hrQ/FUHAPqyYssKPlxkhsiv6fsj9IngH2ZTthNyPTmUrhDFYvgsnlx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774162; c=relaxed/simple;
	bh=F/o4Pwb0gfXDHXZJOnfIauiM0ksjIEVZ6pHtGpP/jlg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YWgTWOTgM89DrgDHy3P8dAXolEqmr+ODAip4DJ6GVIHtTn4VB1+xDrYtshahA2vFEB0CNvnkRghH2Ay/gaaKC8yk73lYRyFNB14dPjC961RJWEo/G2XjnYknjyJN5u6nTeurkELixNiB6Ug5FI0AK0AfFUEQakmAwDdL1LV/sgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BmwmBzx+; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BmwmBzx+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0s5igjH1P6TRLyBE+6X3Ptcfqk1n3jsZcHxysWnkhOzazclu9UsV00mo/8yGd0U1loLnHjrTQIPp9hRoGC+Q6c1FnWk9yj5D1GEHeYIQxBg1oMapCSiLI03csklV4Ts0nK+x/Lgk57Y6WWP4eEOhOrKKeRTCTLSlVw0pyVBwQ5kpRH6xPxGIdWbct6fDp5wzuvgIeWqWB1wnuWEggDE61Ru29qOvjdP1fDcqLF3x9+R6st66ziFX69gGH8fEMJsoEjBtNdgw9OOnfpfoIo6oSgddTb3s+1B0Z6VLjU+HOuNl5jl44pfzAdntG+s2DA5PK0WVzcJ2ARytC3M7L+4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9Nc9sMhaMiSjOfXPYUD8//YgNQg98gLtpHeYD98Fi8=;
 b=VvP247k1AvTwSjiETA/HSwdLNB/hJbpCWBfovrlS3PMaHN49BgNHKsQxDxEY8TIdeQadG+EBMrUOubvdLyydJ4I0jthrrqC+UThlGyHU2poorlQm+axYofUEaF5Q0JnPz+E7s/KXNfLbzHyxRT9KUr+oB36UrHqrPmX7T1iNw55888BiTcOP/q7ET66bJtvykBSuRdmR4nLLd9KAAtRUGPFvb8s9YGVO+i6mJnJ1IfzIo8qV5ydLrUDiJyu7lAmi9xpM4H7E+QVeZ/n4+28g4jqNv0x8ARpC1ojTZwcIOE0j7eylFYotL5fwW/3S8bdafBM3Cwh2OOCQb7GMvjfBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9Nc9sMhaMiSjOfXPYUD8//YgNQg98gLtpHeYD98Fi8=;
 b=BmwmBzx+tjicQqOx0hUGceVDKaTilNldS6N3s6WrYtByXs2X3N9pahfZPo8iWVlN40ocHDUjL9NaS6rxjzwTexUsnAdBd/CqZTRvZQywY5AdNux6oNiohIqZKWLVNrVVOj3Dn4ERV7tFgKvh+IfV0Y0k1oEzPtaijDzLXk0dTrK0CaQExffbEjAeEjsRk3/0lgbdRNnYQzQHJYvt3+bu5mFBm8Tw6h7LmGzUdG9IE3DF05XzoyQTA3mFdBrUzmpx3WqPn20+5T9JwNFzvc2IUNgJovwy51g1BmjphrkrJHXNF4OBYExFwN4DTlU5iyPONRYrrmvz6CUY6+Afx2JQng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI0PR04MB11540.eurprd04.prod.outlook.com (2603:10a6:800:2c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 11:02:37 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 11:02:37 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Thu, 21 Aug 2025 19:01:52 +0800
Subject: [PATCH v2 4/5] MAINTAINERS: include fsl_imx9_ddr_perf.c and some
 perf metric files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-imx94-ddr-pmu-v2-4-052c6420605d@nxp.com>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
In-Reply-To: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755774118; l=1109;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=F/o4Pwb0gfXDHXZJOnfIauiM0ksjIEVZ6pHtGpP/jlg=;
 b=7tABGGUSizP/G/hjv2FxNmx2YyoMr7KH3+CWayR+8JrULbS1+qWZ+oBVIB0USvLeP0lNHL+Tf
 +wd7DAcIXp/DiB05esTqF2gFbPQ+5nmHoW2zkYbXHoxGSwmDD35j3Tn
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI0PR04MB11540:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f87d1d-b00e-46c7-a4b6-08dde0a23d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzJFMGE4dlFrYXFBSldYSUVWVWo0eUt3VDR6NnNmSXpacm4xdzhkSGlrRUZw?=
 =?utf-8?B?OW1MZzBlQUg3S2Jaays2ZGlyYVJHK1laVFBZcDJ5SXNKUEJNVjZZUm5lNE5Y?=
 =?utf-8?B?dXQ3LzBrdzk0MkZHZ2pUeDZkTmgvdGFFOXZSSzhLUUpmZFdGZEtPay9LbVpB?=
 =?utf-8?B?NEJ3UHhmNWQ0UUtWSkNBQUdnWnJZZ1pwbWJNTUp2b0pUdGZSZmFXVUZMTzRh?=
 =?utf-8?B?WGVYRXB1aVpTdHp2QVNtZjdBZUVFUW83U2FtNS9weWQrL1lDc0lvcVo0YUlz?=
 =?utf-8?B?QTdtSGJKVjRCYnFRKzRQZVkwMTRlMzUvNkhrbmRhQVRBU0l4ZXNXaS93bGQx?=
 =?utf-8?B?dW9pK3RGeXVTNWpCb0FrSXRDQTdyajkvNExHTEExNEFTVVRoaTJZUFNyUloz?=
 =?utf-8?B?b21EeERickNhODJDOS8wQ215UGpMS2NzeWxGdTdKQkt6MmViazRXeEtnVW1t?=
 =?utf-8?B?OGsvcmpiakZwdHVZWnBrbjNITlhaMmEwZllEYllNdE9UTmQ2djBucm9MeTlF?=
 =?utf-8?B?ZHFPRGdHNU1PRmp4SFNISWYzeWJmMHZlSW04UUdLR0VtNEl5ZnYrN1JBZER1?=
 =?utf-8?B?UjczdVlJVE5iakFNY1huY0ZvSzUvbjJTUmZGcktJNkVKWWhHbkZWSTRBbFpk?=
 =?utf-8?B?RFV5RmJzS2xqdkpPRjFuTzdieG0zZHZFQ1ZXblRGMU4xUHBGWW5uZWwyRjBj?=
 =?utf-8?B?aWgrS0kva3Fra0Z3dUJMQ0ROZHN2ZmNROHFjZFNQWVRZZGFUUWhiOEdQOEJv?=
 =?utf-8?B?UDh5N2ljb0JBR1pMTTgzNEUrZ0tVdlU5b3l3Mm1CSXNmWEFkQWJLZjBucU12?=
 =?utf-8?B?cHpMMmVMdzg3UzhOUlNEY1NUb1ZpNEdTc0xTb1B3ZHFjRTlsWldvVkY1ck5D?=
 =?utf-8?B?NTF6TTI1ZzBrTU40bklnTlE4ODI2V0JUNkhZTHZJbWtvb2lLcy9sQk16OUpK?=
 =?utf-8?B?d1FUbmpDSEQrV3IzakIrZkpTNFc1K29NcHc0cHZjSDZLa2hIS3dLQUJmMUhP?=
 =?utf-8?B?NSs1N3BOUDg4bmpxa3BSdEptdVBQSkNSZnBjYjJJbTg0U3U0MzRQTXFPR29n?=
 =?utf-8?B?cVpqWlhXbmxYTnNaTmVBWUlEYnRjMDY0WU1ud1djSDNPT1ZGM0doZCt4NCt5?=
 =?utf-8?B?eC82MzBKdzVKWUp2eVFEQjZOY1JDNTBMYS82b1ZqRklVUkp0Uk1NWWtId2hK?=
 =?utf-8?B?UXBTc2dEZERNUFZ6Z2IvTlJQa25zdVlTMVY0d2FUTkhiVXlRa29zeHNGc3hy?=
 =?utf-8?B?RHNsTjF3d3ZaRHV5OGxkSHFqelh0MEZuMjJ6ajIycEZFTVozK1RWWmlLSlF2?=
 =?utf-8?B?amxSbmpTNTQxanYwbExoYmxHWEJTeFRGUW41NXVMTnNmdW8vMnVwT1BqTFNC?=
 =?utf-8?B?WEs0UVZ1RVhtcUsxMlpsOExSZlp6OUFvdWYvemorVnkvRlU3ZnJtejdUOWRX?=
 =?utf-8?B?b3RCb3JTTVNkUDV0dVBIbkZNTzd2Nk5OTWdFNmxtaFczcDMwdy84R3Y2d0Ju?=
 =?utf-8?B?S3Y0U0tMd2QzZ21Jc3RPMm5ESDNmbTJuUkk2cWRCOWZBaUx1WDY0NkhUbDMx?=
 =?utf-8?B?cEN1S05NNGNYcmNwNlZsVk1RazJKUTlIeTNTbFlxVlVObUZTWWwzanVWcTdJ?=
 =?utf-8?B?NTY0R3NSZERKNERLaVJsbHhiWXE2YXZwRFBvMHd0WGttQWg2RXkxTzlUb1ox?=
 =?utf-8?B?d1J6MjF1S3NWZDh1aTBkSm5kbXZmMzBML3dINkJrLzYvbHRGREIrOE5LK25W?=
 =?utf-8?B?THNZMnd6SUR3TnMyS1dib1FsT284UTRTNU1kcVZ5anVoV3piUGJodXZBd0M4?=
 =?utf-8?B?akU3YVUzYU9Gc1N5OFdJMWR3bzZuTzRIcG1idE5XcmdHMEU2REpiOUJqcXpD?=
 =?utf-8?B?Ty96QkM4dnVQZTM0eVRCMUJEb3pwLzBTOGdnTG5Gcy9COVBPNTkxcFkvRHd6?=
 =?utf-8?B?RTREdmlBOWpIL0I1U3A4SDRjMG10VjRxMXBiQjdHeEtMWjBKVXVFdTFZSFQ5?=
 =?utf-8?Q?oJUSAvpxRezarVrWwSelaLQRlo+hYk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NCttRkQ3WjBENFQyZElVS09CaGcxNVN0eEJFWTRISTVqZEQxVmlxQjhjVkVt?=
 =?utf-8?B?bnYySTg5ekVrMWF6bVlSQUdocVppejZqWGVzYnhqYkRtL1h4MzdiWE05R0hM?=
 =?utf-8?B?SVhTN1RkM2xpRGo0Y29TY2l2UUQrRytkTThpSmI2RHc0SDE1ZnZ6MzBRTmFE?=
 =?utf-8?B?elFTWlFUem5ETk1LOEhaM3hDakpnYm9zdjNDYlFqYVhEVlVtaWdXUUEwZnpv?=
 =?utf-8?B?VGlnVXpGWGRET2cyRGtqVVRNWC9KUWhzRko1YjJyT0M0YWYxbVZFR2JucGV0?=
 =?utf-8?B?R3JWQk9BdE15d1VNTXhoTjdYWUo2TkYrbHVFNmVzUnZLaXdlSTJLYTBMSGt3?=
 =?utf-8?B?QktHR1lpV0Ewdm9mRHJsdzQzdHd4bDRzV1JtUnlYREV6aGVWdG55ODBQSjVZ?=
 =?utf-8?B?ekh5c2hJeWJOcEhtd2NTS2FSR09ZYWl1eFN5enB5bTQ2VmdXc0h6eWtqZTdn?=
 =?utf-8?B?eDltRXBDY205N0Q2ZUdJT2RaRWlNQmkrTmxSSzk2V2FkMldVYWtoYUZMbW1W?=
 =?utf-8?B?N2FjQVhLYlNWWlNoN0tIcDdlMjlBTzRQUjc3b3lsb1djYVJqMGFIK0UrZUR4?=
 =?utf-8?B?TWVYN2RVVnkrc1JGc0tZcTdqdnp5bHlHaENWaDZEN2Y5RFJkRjhtbGtGZU1J?=
 =?utf-8?B?VTNXbHB1UjN3OWx5dE15NnN2SXVndVl0WGFxaW5Jb0dYVlVWRlkySXN6c1Na?=
 =?utf-8?B?c2pRNFZSdS9ObTdFS1lvWHBwVlM5RUxqRnI2dzF2VHE2TFZJQ2Z1cFpUYU1V?=
 =?utf-8?B?RkJnaVJQcEZpMFlzYXhaZWFKdUJPeFNoQlFRbi9ydGNta2pXTm0wUWp2RWpS?=
 =?utf-8?B?ci9nS0sxVndZSytHajFmTlJnUXNDOEY4ZDVVRWdmS0Zmcnk0dEZGWTIyVjFy?=
 =?utf-8?B?ZXAyVlQrVHRPQndUeXBoa3JMOWFnR3RlSlNUYWpqenZlUXBnZFJ4dEtZTUQy?=
 =?utf-8?B?emoxNU1NTmllRi9PTWtxcTVkWEpmZjlhaDcrS2xzc3llK3FnYXE2eGtPdUJz?=
 =?utf-8?B?b1hsSGo1T2k2Rm5YS0t3akZpeDkxRTc4NDJkNGtKQVR1QlZuQW5aQWE3aVN4?=
 =?utf-8?B?RVVlbmpDWWtRd1hHWFNXL3prYmNkZDVTQi9GRFRPYnRlM2IyRjZaSzl2N3VF?=
 =?utf-8?B?Z2RNN2l1U2gwVGRCelRIUSt4UEJWa3pBZThaeFh1cGhlV1hNcUxyRUFZTmVH?=
 =?utf-8?B?TjRBVUxtU1JjVWhnQnJMY1hNblBlNUI1YnpzSUVxeHErNWcyK05xU3hXOXFD?=
 =?utf-8?B?UTY0cmx2L3FJSzRsZUUranNrMGM2cjVGbERRd284MVJ2WlhQRmlNK2tReUNZ?=
 =?utf-8?B?UmZEVzF3RW1qYXZkOWZoT0JQaEI4WVNocjRGU3hjK3pKNFo3LzhNUTlJQjNE?=
 =?utf-8?B?SmlyU2Ira1N5em8xZDZkc1ozdy91dEZLU3E0eTVKUjRzY0dXMHE5a09mSUoz?=
 =?utf-8?B?eEFYSEhxam5IK0ZDOFQ4MDg3a1U5V1lvQ2NWY3BNU1NxdTVqZkluc3dJTStt?=
 =?utf-8?B?Q2NMMWZJdC9KYkJVWWJvSUxMUGd1OER3UHdIRWJsRmhKUDIydUlZcWJLZDdk?=
 =?utf-8?B?QVl0cmV5Unh5ZWpDQXdMU0lxdW16UmFNSGRnTkhqSEVLU1phUkp5clQ2enh6?=
 =?utf-8?B?UlE3ekxrSWdXTDBBTFlCYUxKZmgyZWpLUFBwS3QySUc0SjNPOFB2ZENwKzR5?=
 =?utf-8?B?N1EvN1BFR1BuMWdKRWpiclo5T05qbENUZkkxcHFnKzRsREtiaHpwamp6U1lR?=
 =?utf-8?B?NzVTeWg1TUk1RDQxUkUwM2JmV1dCdUdQRWNGc2xIZ3dOcnIwSlBCSkFYVTJh?=
 =?utf-8?B?a1U0WGZpeWhFMzFqb3dDMnBocTFoR0xhaVZ2OFJoWUV4TEtWSVU3enhVYkVN?=
 =?utf-8?B?dzFiWHJaQXlXUC85c1pwYlg1R0Z5VWF1NEFKRjZ4SGhlMWphSFB6eHJTSkFp?=
 =?utf-8?B?K0N1SEc1RWNrVXNTa2FvV0lPdzVCem0xZkZVQTk3dnVRKzBrYVZGOWs0UThD?=
 =?utf-8?B?aE9DUXFjTHo2bm9KWUFNcjNOQWhXTnIrTUJTV2t5V3NoWVdnbHE1OUVwaVox?=
 =?utf-8?B?aUdrcXFiRDVoYjBPbnRnNDdaZjZmTDNnYVNSdkY1NEljYVNGZEUzeXNSVDhI?=
 =?utf-8?Q?yxAXO3DFp2IhrjkfupOatBXHA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f87d1d-b00e-46c7-a4b6-08dde0a23d42
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:02:37.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /c4dmgNn5e+brptiwUpTMsmMIHlSgK6phKL5M/m8A7aZbHbLgCayTXWCG7CKOEe4vWdkfrNAJTZ1haGZinz7VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11540

The fsl_imx9_ddr_perf.c and some perf metric files under
tools/perf/pmu-events/arch/arm64/freescale/ is missing in MAINTAINERS.
Add them and add me as another maintainer.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add Rb tag
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eeeef7bf25500987bc1a278758c82c1c68a55a0..163d6591f169d250a77c8c27cc78e0e9b25cefb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9780,11 +9780,14 @@ F:	drivers/video/fbdev/imxfb.c
 
 FREESCALE IMX DDR PMU DRIVER
 M:	Frank Li <Frank.li@nxp.com>
+M:	Xu Yang <xu.yang_2@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/admin-guide/perf/imx-ddr.rst
 F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
 F:	drivers/perf/fsl_imx8_ddr_perf.c
+F:	drivers/perf/fsl_imx9_ddr_perf.c
+F:	tools/perf/pmu-events/arch/arm64/freescale/
 
 FREESCALE IMX I2C DRIVER
 M:	Oleksij Rempel <o.rempel@pengutronix.de>

-- 
2.34.1

