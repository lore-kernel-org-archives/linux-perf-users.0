Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87E335BD6;
	Tue,  9 Sep 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420761; cv=fail; b=Jp1D9WbOaHiMA0IjKiZ1MEMoLyNvKFBZ8tsSxkzF8VedjDGO/ydGBnG8bY8UT2vYyDbuHbn9AacugWh8MXIgdQlX8PDfo6gjqAj/HUZ4q6J8896SxVT0zGYuO4RmK+Nv5Hojge7MuYjAQiVXjtzDlv/YRugqaqE6P0l0nSfht2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420761; c=relaxed/simple;
	bh=U/o1NJobxDOBZSeQuFFEXPWcVd3V6KeA9l2IRpBNbAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mZGbHkHVCb1EdNez7mp4GnKYazqEowW6US/9I3dr+cUjYJW4/ll25sQNllV3dP0MBx7FtxNmjAJTxQ7axSIZnmPrYVgjtvbiWe+lQYMIgGxlLVTkcftuFEoDm5XxILqmzJFjdOz4xdwksWZkrhu7uCVZO91/oiZnFI5cSjsPP4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3mILpS2O; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=EALsRDbI; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3mILpS2O";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="EALsRDbI"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589C2C1n014025;
	Tue, 9 Sep 2025 14:25:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	aFYlsmqe+6u85NSQ1cZQmSyL0mQexqOhUzLdavjU4q0=; b=3mILpS2OalH4kWc9
	EJiBaW/FyT7z0ajLFQgMDwcuHWHaxRVQjo6V9NxWf+UcgdTey23+XE+Gej2sZ9gF
	sg69Tn0EL/rdbY/fXz6KXanZS3+cyEoLjhzYm5UvZ1P2IdQiNKSz5Bh2UJN06o6M
	BQVgpUDB/GIoNgChyX9cRO4IYvv2LXVFdL1nxvOrK38Jic7gWxuZvcCj9uy2XiVy
	LUyJwQwypoa1QJvwypfhpYRbJ6686BhQuQHg7ksna6rY4sRbcEdaYPsCCn+cscyV
	Y3qsrEOQwJOUc6CsCRZd94qsi5I3kNpUz+1MlAKltHKJOCEHXn+i9eENqYB1xijD
	48fxoA==
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 490a38391n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 14:25:39 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rALYJ/DJh1k8NeFzGIy9pAGiQdSTZBKLL1JSQmg3L1HCkfcgTYc9ivpZv2Ulq3InzT2iXY8Hp8UCAZ6oLCafC/CXlU9XRbRtfhvQwwd4pP/u4B9wYqIFGtofRfxq1sdC9Pa1C8BLFdvuI30ddCetaQUapdmY46rFWXcz9Q0T2QthnBSP8zKChKJDujW/QAoKXvT5hPoFZuhHAVv+13oafTTnPkpWArwQDSlnUHfWa1miANTsyMKrF0I5VGV271483LvrmKgcGHYprrpAvPGKYLbY4lgNAmjpjHqtbVGUTG7xX9E7Ol9bK+ocOqT0KWJIpgWi+s0PLNBhms7ThfiV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFYlsmqe+6u85NSQ1cZQmSyL0mQexqOhUzLdavjU4q0=;
 b=yoED81H6JSv+ZlUKhh6KW5FwIEygnSad1A/+ohBpOLSJn9M3naOdV71piMvJVVjNloGvn9rb0c9he7uEcCyozLBum+RD2MpVHKWU0I4Xek7fRRt0b0uYfOsvrD89nBoOOyAUEFurnsVYMKgBa6rY0eTqUOrfHxqBsCzj+jnWLZx8hPWoSGWQSBiytd/bFrE4EZqhcmkYgDDnO6UjGNgihbjpFlR+ADALqZ6Ek4kGckRO+woML/hifE4tHxh7LRpoIEHs6GZWDLrtXF/OlZ/UlexcJMyP8/NKnX5PIDK9RmnfaBNKQp/pnPWL4Vr9d2+HOhRncn3wjsqYJAb/0ptedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFYlsmqe+6u85NSQ1cZQmSyL0mQexqOhUzLdavjU4q0=;
 b=EALsRDbICx3V16O4kBoQo5V3xvwsVyna/7sgbArnKNiOk2WyPJHNm8UXclMsshQXFYZpUAg/lpSL+cGANM8KCbb5F2edhgVAyGJYaP3GrNihyoteir+KY9aJ6GC4EWXrj9SAAUQ2JOVKZ86Tjppl6lDusFM28Wo7S17WtegifhA=
Received: from DUZPR01CA0354.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::6) by AM7PR10MB3779.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:178::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 12:25:30 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::a2) by DUZPR01CA0354.outlook.office365.com
 (2603:10a6:10:4b8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 12:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 12:25:30 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 9 Sep
 2025 14:18:20 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 9 Sep
 2025 14:25:28 +0200
Message-ID: <9a46c8a8-1d25-410c-9fa2-267eb4040390@foss.st.com>
Date: Tue, 9 Sep 2025 14:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/20] bus: firewall: move stm32_firewall header file
 in include folder
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
        Julius Werner <jwerner@chromium.org>, Will Deacon
	<will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
 <20250909-b4-ddrperfm-upstream-v6-1-ce082cc801b5@gmail.com>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20250909-b4-ddrperfm-upstream-v6-1-ce082cc801b5@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|AM7PR10MB3779:EE_
X-MS-Office365-Filtering-Correlation-Id: 8101f005-b32e-435d-1155-08ddef9bf742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlhVMUE1RVVuK2tJYTVyUFR6Sm9NKyt4RXlQQ2sxR3c1RG81T2ZWOVZBNnRO?=
 =?utf-8?B?dGNQbFhMdHhyRU5PTEhNSmpIUWZDNzlteE1CM0R3RFQ2QmNReUIrNDdlbkRj?=
 =?utf-8?B?TFhCcmk4dG5sQ1oyOGhtNHl2bE1ZbDBoanNEdlRmeFNrRldPaERHb1BseXE2?=
 =?utf-8?B?VTd2L0RWdnpXc2VCcFRncjhDbDBISnJMcDBxWnFQeDBuZEV6RmxvRnFjQ3dk?=
 =?utf-8?B?QzZIckRkNk83cTcwMHF4V2NzUC9SL0pJTW91VUlXYTNlbmlwWTVHbjZsK2lT?=
 =?utf-8?B?bUJnVkR1cVBZOTlNTFVxbzllSkJBaWZjdjFUWnpqSzloNWpPSWgyWDFkanFS?=
 =?utf-8?B?ZkRkMXpEdjNzRFRSaDJBV1g0YUlFRkNWb2VDbmVLY3dZWDFIRVluMmp0RVFl?=
 =?utf-8?B?T2JOcGhORXJFSi9pbUhNWkhqanlTVzNMcjBMTHkyN3plUmVJaGt0OVU0Z08x?=
 =?utf-8?B?cVEwdE9qZUh6NGs3aFk2aXJJS3l5U2ExR1FIZklXRDRIbm54eTZyb25qNXB0?=
 =?utf-8?B?OTlFbTE3YVV0TFJFL0FwbDkxVnJQRkc4czM1U1dQWHZFNGZvcHNXYzY0SVFC?=
 =?utf-8?B?QWpWZ3FYWW8wTzhvRm5WRzB3WUFDcmxSU3NKQUZmSGJRQ2hOUTVRUHF3dlY4?=
 =?utf-8?B?azExZS9DNGZwMy95TWtpZ1c4bnFQa1JiaExXQkV1L25IazhjSEJvMXZJK3JN?=
 =?utf-8?B?QTFlT3FTd2xlNmdQaHdsYnJkVGhWN1N4ekVPcDhEZi9ra1pGbW1EbXdvTnpa?=
 =?utf-8?B?VVVlRFJNR1g3T2NpSXlWWjQ4a1d4Q1R5Ty9tSTJzanllNFhQeFhCeUJJQjFR?=
 =?utf-8?B?ME1sV0UyWUJJeHQyQmlac3hPSHZ1NExVNWJkRUFyYTN3elkwTDF4cWQ3QVpV?=
 =?utf-8?B?bFhrR21vdThqR2JOQVNsdWkybnZETThBcmo1dFBnenRzSDhsak1aWThZUlpn?=
 =?utf-8?B?NHZSWVV4U0ZuRVRGVEljdkR5ZTRnaTU4cGZvbFlmbm54N1AvcEZPaXlSVEVh?=
 =?utf-8?B?NGFUMWJYOFdZRFRuU2VVRjB4RDF6YU1MaEV3Um9sbE5LQ2NFdWlTSlBTNERk?=
 =?utf-8?B?RVZxalNhbkpidDNSOExpZlkzWjcrbFZpWVBSa01mdVQwWXQrdXl6N2xXRlNu?=
 =?utf-8?B?N3lMc3JZWUZnTDE1S2xwdFk1QnZ0NEVuTDdBWVl2N0RJQ0JnV0JraE5SVHJx?=
 =?utf-8?B?WlAxajVOUE1RcUJvaUhubGJPcWlQUG9odWFic0x5cDZES3ZxMGRIL2Q1YUJz?=
 =?utf-8?B?VDVTQWpzNlA1aEg0WVNNZTE5aloxM3RiaDlJWjdlTlFGOTN6cHdsaFF1WkxB?=
 =?utf-8?B?SjAzY3hoU2NoZWRmeWVhNTQrMnN2THdHVmE4Q3Z4Q0gyajlIQkp6SVIySm1F?=
 =?utf-8?B?a0E5bEpyc21TaDl5eUdGOTVDdUlYeThOOVp5NEFJRVIvUVlUWWxRWDlJNmho?=
 =?utf-8?B?UUVvU3hxQkNUWUc4R2V3eE5wNENEVmNIWUFTZENqeVBZaWZQT2JIUXk2ZGVk?=
 =?utf-8?B?Q3U0ajNyR2xNTEF6bTAybU5PdDRhUWFIcEc0RXpEb2tCbUlucmEwblpla1g3?=
 =?utf-8?B?M09vdUVYTEFYNGFTZG1YczFmdVpON3ZmdmJBdDlMcUdJdzJ2eVRFMUZ5VTVs?=
 =?utf-8?B?NkxMRFJpYXgzeU43dDdNWUZET01zRmhndVFQWVlIc013dkhGV1htbnlrekVO?=
 =?utf-8?B?SUQ5SFMrL1pBOUoxUGFTdmprdjBwMGhpVk5leENiNG4xZkVKVjlGck9vSmxY?=
 =?utf-8?B?REw2eDdhRm1PU04rSUlmRlBjTnptVjFJQUNFNUc3TldvN3NWR1VESExwYTFX?=
 =?utf-8?B?YmlLSnpwSmpQZEk1RVpuSEdlQ1lheGFkdldNY0xndFpWQXVzQ21rdVIrRmMy?=
 =?utf-8?B?UnY2cFNTU0hzQWhzY2pCTXBSYThuWG05OUdobVFpcGtSdTYvaDVFeDFQTy9T?=
 =?utf-8?B?Rk9yTjd5RC9YYVhwN0JvUjNPZ0plZjhFUnhTaktNMVRoUUpwUk1jdURDZG9L?=
 =?utf-8?B?NmNEMjZRczI1dGFWNmZQZUFiWVlZVk9SRDFwOGRXai9oUnVqVmtuamVSL0Jz?=
 =?utf-8?B?WkRJTVFxN2FEdHlmcDZkZkhabHQvWnVYaXRnUT09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 12:25:30.2899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8101f005-b32e-435d-1155-08ddef9bf742
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3779
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDIzNyBTYWx0ZWRfXxp1BTVx8TN30 ie6/OxZuxcOIt4+NpzcGZciNK635mGxQdjJwdzwG7kKVrBgKqfhNOotXZXJowz7y5e44TH9tniA KeffLad9gwNZOzEJqtszz0fZ9r7pPgqiJSFS55LMmNjSEETRPOTHZe8qWccTQd9qAvBtd9XhnEq
 7OIPBrw2X/A6DDvlafrM91mbK/GJUrw2rEmSlxz/Gcox0Yx7Cpa1Gu8Yrkp+8lw9o4FIgJVv7+M c4WvqlgKl3ERdPVMdNkRzdOMlPr0MrPasVlT8IdObOVgquox+isBzMUbJNVKJ7SCzOAR+/KvFpA xEcklRxpG4yTahymSw2/JFd7Olzqgh8UmDnZSek1FQ8iQCkjqf/og94Kzi03OMUuN+OM4lFxiQ8 ZvaqynYr
X-Proofpoint-GUID: 05B7j8d6oYHp14w3Z4fjDkMuLGwblaEB
X-Proofpoint-ORIG-GUID: 05B7j8d6oYHp14w3Z4fjDkMuLGwblaEB
X-Authority-Analysis: v=2.4 cv=WLB/XmsR c=1 sm=1 tr=0 ts=68c01cc3 cx=c_pps a=2vZtlp7YgANTt9DAkY0oBA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=pGLkceISAAAA:8 a=YYNlyAMbr1-TTnqoXNcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011 adultscore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509050237



On 9/9/25 12:12, Clément Le Goffic wrote:
> From: Clément Le Goffic <clement.legoffic@foss.st.com>
> 
> Other driver than rifsc and etzpc can implement firewall ops, such as
> rcc.
> In order for them to have access to the ops and type of this framework,
> we need to get the `stm32_firewall.h` file in the include/ folder.
> 
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
> ---
>   drivers/bus/stm32_etzpc.c                       | 3 +--
>   drivers/bus/stm32_firewall.c                    | 3 +--
>   drivers/bus/stm32_rifsc.c                       | 3 +--
>   {drivers => include/linux}/bus/stm32_firewall.h | 0
>   4 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/stm32_etzpc.c b/drivers/bus/stm32_etzpc.c
> index 7fc0f16960be..4918a14e507e 100644
> --- a/drivers/bus/stm32_etzpc.c
> +++ b/drivers/bus/stm32_etzpc.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
> +#include <linux/bus/stm32_firewall.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/init.h>
> @@ -16,8 +17,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/types.h>
>   
> -#include "stm32_firewall.h"
> -
>   /*
>    * ETZPC registers
>    */
> diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
> index 2fc9761dadec..ef4988054b44 100644
> --- a/drivers/bus/stm32_firewall.c
> +++ b/drivers/bus/stm32_firewall.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
> +#include <linux/bus/stm32_firewall.h>
>   #include <linux/bus/stm32_firewall_device.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> @@ -18,8 +19,6 @@
>   #include <linux/types.h>
>   #include <linux/slab.h>
>   
> -#include "stm32_firewall.h"
> -
>   /* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
>   #define STM32_FIREWALL_MAX_ARGS		(STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
>   
> diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
> index 4cf1b60014b7..643ddd0a5f54 100644
> --- a/drivers/bus/stm32_rifsc.c
> +++ b/drivers/bus/stm32_rifsc.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/bits.h>
> +#include <linux/bus/stm32_firewall.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/init.h>
> @@ -16,8 +17,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/types.h>
>   
> -#include "stm32_firewall.h"
> -
>   /*
>    * RIFSC offset register
>    */
> diff --git a/drivers/bus/stm32_firewall.h b/include/linux/bus/stm32_firewall.h
> similarity index 100%
> rename from drivers/bus/stm32_firewall.h
> rename to include/linux/bus/stm32_firewall.h
> 

Hi Clément,

Thank you for keeping up the work on this series.

As the firewall header is moved to a dedicated firewall directory,
maybe it would be coherent to create the same kind of directory
for the sources as non-buses drivers use it. I can test it on my
side if you're willing to make the change.

Sorry for the late comment.

Cheers,
Gatien
