Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2130.outbound.protection.outlook.com [40.107.220.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797714BF8D
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887096; cv=fail; b=cG6cfHRKa24ys3EWjfMiunFCVlhAlRuW3uCCVUI7VouJmOzXfLjn0pv0wxb0ZnKZsdNAKhSPEIdiWgilsLh2XnumM745FcOq5F+ailiXyjan3SEw0aytu4ZbjVgdMM4jGb0RfPM1HfMNKSTdLEjFt8h2fP538/g6qMKG9fahxOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887096; c=relaxed/simple;
	bh=fOtGtNIfviqc+tR0octYlWhz/Ce085hAZNdrGONbAII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGh+OFnJs836qxXX/xFWeAXdZVvVne1GFpZDXfhBQCuroMPpJo3SDZ8PbS74Yqd+K9FkXRXgEuRCZliL6mHPzLlz1c+3pRi99bdK7T0GIm4me2FYvuMOqME7Si6o/JesHTxUQ+1NtGGdfyc2nVvhBmx+kGvOChTya/7YFGGLdic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=k68RHggu; arc=fail smtp.client-ip=40.107.220.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="k68RHggu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qS8SyGpc2a/MD+14mZKcNJK7KwrBSLTGefkcWOdM44Y+bhG/Jrp3Vll6dqcm0nNPhVfEFuEpF0Bzy6nWMVzKwvBpgZoTgEHo3YfU3H9osjLeytcFp5MULTKkFOsgzk4v7PQ0T/DesLOGgQeN0Bhm7cLq1DGq/WTA3Er/KLevTbfEeeL5DIybwlE2U3j5uMy6qoJwqq4bsOQdShLDcP5DKd/pqaWQR3Fwv0zY2fTznDO/xoatTV7GehmFTtBvJHwRFWUWLGOQ4krGnSQMEV2YzueeQuDVbyIB7ByireEzLTI6qa7mjT04ZgIQ4Je+u0XeHPxiQ9za52B2TTJf5Wor3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YigPosKCyA+QVqyfOxzq74WG+dtaoYHC96nYTYgVgG8=;
 b=ru4ET4lPgPT2/SYTT1G6ce5xn0bIwIS4Qxs/eHQL7iA3spyL8LLch3AhSl9BQe29PEWx+gLxjmBZ0bs0BUPuzymjRRWpjGd/NwThX/42pHzeOaTRejA6obrWYs8Y0zJCVJl1gxux3/Ml8fdN4SHbVcnbu+e7gUbU5bbZAh/X9/zfuwBdoajEDBh3byrpxJap8tlZxFMyGYA+XIGSsuwTjekvN2BG6lLNz9mPY6XW/4BD+Gm7Tl+j3KDlkCYkprEIGggbNueVo9JhvOG0EfnCzIUo/4GmPrw6pjY5bldOqeFEnTh6MFUB7/ulUQ5ETOxsxngZl0cVHA5M5WO1TBuubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YigPosKCyA+QVqyfOxzq74WG+dtaoYHC96nYTYgVgG8=;
 b=k68RHggu5UCMTLtC5g+VjxrhVe0Pkn9Tnb+AfMoJHeHJcO1D++IvM+x20fV0OX5PYY7Udb8h7r2IDlYBGycslW90e+fwu/eZFN8xazBl5oQjugEQIrnsIsQTiYiG0GVqoud9t6jABmI7OwuKgcIdRjIIwPcuhEXxmvghCiKpodw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB7895.prod.exchangelabs.com (2603:10b6:510:28a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 23:18:12 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 23:18:11 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: PATCH V5 4/4] Adjust objdump start/end range per map pgoff parameter
Date: Wed, 28 Aug 2024 17:17:55 -0600
Message-Id: <e2d4a059d4dd4c8dd0efc95383d982efce39d8cf.1724879699.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
References: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH0PR01MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 9514fe2f-430a-4bbe-4a47-08dcc7b7af55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUdmSTQ2WE05V0lmRGo3b0Z2blRBLzdMb25vdE5mYXRTbzdhSEpzQ21Gb1BW?=
 =?utf-8?B?OS9WVzZnWUVOZ1VSaW5GZXdaU1VYaDlacFdDN1dzODVFdW5vSk5MYUt5bkY4?=
 =?utf-8?B?NWtxT0xHNG5GeFFPdUFGNXJyL0huNXVRWmNNVThKNWdSeER3bElWaFJUSnBq?=
 =?utf-8?B?YXErSFkremlSOTFkQ2pCaWRNU1N3T0w0ZnV5OTQvbGNFWjFVVWh4R1RjV2dE?=
 =?utf-8?B?ZG1sZFUxMEI2MjMvNSsyUWtubGRjRlZSWjE4UHY3cURjNGt0dytnU2c4Tmpk?=
 =?utf-8?B?OGZnSjZ2SG93QWk4eW9xWnFzaHdhL3doS0tJaVFrRmZLNDI5Wno2dVIxRTJW?=
 =?utf-8?B?UVovT2VXVkRNbk5WVm9IVENlbXUxRzhQQjhPeityaENxUVJvREpITTMzbjNk?=
 =?utf-8?B?K1JvN1ZTOXZBdWErVHdiSGFZR0pzVEJnNGtDenpzZ09VenVYUTc4VW5wYUZG?=
 =?utf-8?B?c2tQV2hqUVhpVFpDMHVNYUhJVU1kT2FCNzBBVS9rdTRuLzNyYmZEeVJLTlF4?=
 =?utf-8?B?QWJCcFZzb29OODB3MS9pUFM2djk2OHBWQUd0VXFzcjlUOVdVbkFONUk3bHpU?=
 =?utf-8?B?OCtqa2Mxb3lSeGhoaW5ta0Rnc3JIS0lkVmRrQnp4ZldvSEZpUlUrTkhPc0NE?=
 =?utf-8?B?TXM3T0RkNFdubmpLVldRMm00S2gxVlFqMHVzY3pJdG93NUFyM01rUmpOVUN4?=
 =?utf-8?B?T3JmeHlic0NaLzhMUytDRnRGWnNrTEo1YmJ2bENINlJ2MUxFa3hQMUY5REVz?=
 =?utf-8?B?cnZFQVU3RFc4Z044ZVlBbE5uRklNaWd0WmFYVzZyaSs5eHg2bVdIRTFiOE9I?=
 =?utf-8?B?SEV0TnZ0R2V5RjdtMGlMRHFVN1RoSFU4amZ6c3NJQXF5VUdJWDlBS0l4QWFt?=
 =?utf-8?B?c2FnMFBiaGVQR1JtZGJxMzZvT1dLenRVdCtvaW0xZ0Nwbk5IcFF3UFltUUF5?=
 =?utf-8?B?WkdGQzZrY0RmRkphUHUxSW14MU9UeXZZZEFlV211b1FXMFhtM3RrcXp2SWdp?=
 =?utf-8?B?V2M3VVlYNWRza1V3MG5mYTJkR1FWdi91SmJ0RkEzVUdlUlBRR0krL3B0ZXJ3?=
 =?utf-8?B?QjBHbmZGSWxYRTVyQm1wWWRXQUNySENuNXlxRUlxUk5kWVFnaE0vbWtGTVNr?=
 =?utf-8?B?eGlUeEg5TXBxWDBZSG1FODlDSTluaXRWT1RJR3JpdXQ2MmRSdEJwbkl3Qmkw?=
 =?utf-8?B?WHg3SHV5VnVIRkgzVVJ5MW5YQUpjSW5sc1ZzS3dKWHpvQ1QvaE1vU096RnU5?=
 =?utf-8?B?UTZkaU5XcUV0YXo4SkYyNisvWFJhb29wbWNuWC9pTStDZ1Rtc3kzZGo4SkIv?=
 =?utf-8?B?dDZxeXhTTG01Ty9yN1FmMnJqWk9ub1lTN1FjcXFCTmZqMjh1S3YzanE3b0Zt?=
 =?utf-8?B?ZWNDQit6TlEvWkxYSU9SYUQ5NGlCWXhPeHJESmZUTVN0b1dzeE1hZTJmVWt6?=
 =?utf-8?B?MUJQNWZGMUZDRnRyNlRhODliSktucTRIcnFXR0lEMVowV0FHWUVOVzdlNzFV?=
 =?utf-8?B?cWFxUU9rZld5RnQwMGxiRWVFV0xCZDFTb1QvQnVMbWNONGNuNmIyUm01ZktZ?=
 =?utf-8?B?NU5rUkFTNW1BN1FkYU1wNjNHTXR0c3NlcjM0d0JGcjlFTGRyMlh1b3A1OFZQ?=
 =?utf-8?B?d3VFUFczcmIyV0ZhUWVMSk02VjA2WnFLa2k3WkZxTXA4VmpYYXdUZExyMVJP?=
 =?utf-8?B?NlBnUEM4RTZHUko0a2ZwQ3JERXNxM0RSR3Y1MEg2V01UWTcrZ24vYnI1cWxk?=
 =?utf-8?B?U2IvMDBUa1RTcUlmanphKzVZY0tTajdoOTFqVFprN3dhdGJ6b0wyK2daa2VC?=
 =?utf-8?B?UVlsbDluUDBvQUgvb1lCanhFejd1SzM0WkZZblQ1Vm5IK3BIMGdNUkxZSDRp?=
 =?utf-8?B?MXIrQWc2VVQwM0MyVnVqMUwyb2xiUnVhdWtNU0lEZTUyM1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxQQUZRczI3U2JmSDlNOTkyZ3Jhdm0wMWVVbGxkTnBuK0RtSTlRWkxOWlFp?=
 =?utf-8?B?NmkyMkRxQzNnMEl0UUIzaUNGVnltS0tZTzRtQlRuTDQrZDJrK2xGOWRmSUVZ?=
 =?utf-8?B?Q2pzMDdnbXJlcXF5YkUzUlVvdWRndytDd2RzdGFLOWVGUXdZdUdGSzBtV3dZ?=
 =?utf-8?B?UmVJTDF5M2xSdzJPbmk1eXE4RUZSL1h5L1NSWVFtUFJESEFpQVdmQ0JpakhI?=
 =?utf-8?B?Mm80RnZlR2piOC9mbkJ0c1puSzJEaHNwREZhSGoxV2U0R1F4cHNZZlE0T2Nq?=
 =?utf-8?B?S29WdUR0TndtRVFqeWpIVVZUQjFGSjZYTzRKTXZ4NS9MTlorUUZrdVI0b2ZF?=
 =?utf-8?B?VnR2cFBnSjZ0ZmFPZTBDL0xra3FFUHdhY0g2WG5RaDB4ZWZNamVRTWUwNUtp?=
 =?utf-8?B?b1hubXBHOWUwY0tseGFlZ016dmtFSG5mc1JLQ1Q3aDBuRUFOdTFrenp2eHdY?=
 =?utf-8?B?Q2tnUnRUUk5TUXNsUmhOdkFIY2NZTTBxU2sxelB1MkdTSGEvd1RnVGwrRis1?=
 =?utf-8?B?MTFsK0x3VE1ZSThRcTdRdWYvL3BjMjEyckU3bFp2SlFZUk51Zk8wTE5GeElD?=
 =?utf-8?B?T3ZuY3hYN1B6NE55UUM2WHBKalAwTVRiTWJ3ZTRIcmZkUGJTbWkzeU5yS01W?=
 =?utf-8?B?MWRCTFR5TzloWFdrYzB3ZnFCMS9Vb2lEKzAzaEJ6TFlYdXk2ck9pR2lQOVBq?=
 =?utf-8?B?c2VpcGRwQnZIWEtHaWV3a2xwakdsS0l3Wjk5L2Q4bTRnbi8rV2k0V3JDdkF6?=
 =?utf-8?B?ejBZYlJzMXRxV2ptbWh2dDFYSHhJR3hGQzViejFRaVJQY2FTajEvWi8rWHkx?=
 =?utf-8?B?djRlNmRTZ2lWM25HWkpsKzJCUENqYzRxR0dGWVpvMmpXZURrUFVBd2ZSMkV0?=
 =?utf-8?B?SGZEZU1rVXI2b2tnVDFaaVc5QnBMU0RrMFZtSUpIR1Fua0tmOGZqdk8rOXVs?=
 =?utf-8?B?bFdMSE9BVGZPMHdTZFh0blVUN3oydzFJalkzNFpyRnEwckpGbmkySmNoSjFL?=
 =?utf-8?B?Z1FhVDZFRGtTaG8wSEVlZ0M4eHFXbXErSUdlTE9zendwN3I2RzdlRkx0TVAr?=
 =?utf-8?B?MTFvZWhqc3hSU056UHJHWEhTeUtLUm8zMFgvVzRZTmR3T1dXdzJpTXZueStt?=
 =?utf-8?B?QjBTdTlvMkhDMEd0MERjVkNLa0xYeUZ3UlpHOXAwWWt4eHhSdjFZV0JqMkZk?=
 =?utf-8?B?UTFBUUJobEM2a3JxY2NNOC9VbitOVjlpRnNKNG41K3RKRXlZQUI2dFFEK0ta?=
 =?utf-8?B?aExPNCtINWZBMk5tazdsWEZYSzY3cGhMTW1QZGFhbUo1K3Z5Q041MTdITDky?=
 =?utf-8?B?RGdzTW8zNjZ0Z29yN05hMDl6cCt3YUpLMWZYb1hTUSszdjFYdnlNQk94SjVk?=
 =?utf-8?B?NU9VbnJBdGV0ZUEyMFJvbnU3TUdQT2hxYVkvUEsyWldtdFZYLzJTR0RCSnRh?=
 =?utf-8?B?SnZBalBLcnJMMmtURHl6THFENDcraWFsYkgzSkRaMzE1ZWt0R0dFcy9tVlA4?=
 =?utf-8?B?RDNqSDlYenpqNnpmcXpnZGVic0tuZHkzamc1aW5RbVBIU3drNVNUc1V0WDhC?=
 =?utf-8?B?Q2p5N0FBcE1XMll0b0RyYVdVb0ttNjM3T1pkWStUOGlDYkUwRW02OWE4YTUx?=
 =?utf-8?B?bDlvV04waWFzQnZFMXd6Mm1CYVp3WFF2Q3RJZFJKdzJlblM3OEMremh0K1dn?=
 =?utf-8?B?QXc0RFBUZHJtNWV6UHZBWFJMUVdOUFZMSzZIL0dKdVg0cGRyZlFUM2JyODJH?=
 =?utf-8?B?ZTN0czEzRjJIaS9vajVSRGxWQzdYRWhJelFEbnNlOXBJbk54UE5vTmR5eVZC?=
 =?utf-8?B?cUgzSWFWZUk0K2doYWkremNMMnZvUDMwM0xJOTBnUjR2V245MVc0T1ZZYlpm?=
 =?utf-8?B?clp4RXNnd2RyTkVrTnVoWU11ZEhhdHYwcXg2UGlDdm9GZ3NXWllQcnBaakFr?=
 =?utf-8?B?V1NkbXh6cDRSRzBCeDJiZi9vREd5K0djTGczeUhYbUhtL1JwVnVKUzN1VXV6?=
 =?utf-8?B?VlZTQkxkcDRyMWh6Z2tBWUs4S25yc1lYc01vYUxHMHp6MHJCVmw3K2t2V0do?=
 =?utf-8?B?ZFR6eGJHVEFJRnZ1emlXK0xET0xrVkRqTVdpSnRrMmRsM2JHQzBxZVRROEZ1?=
 =?utf-8?B?OWtrSzVVRUhYKzVoWURyamNHeWZIS3EvVU9XaXFlcXNIRDFBdmtNaWQ5Q2hF?=
 =?utf-8?Q?ElUSRacRmMTRLgdWihbKcGMEitVM1q3iYZ8B+dvxUKOf?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9514fe2f-430a-4bbe-4a47-08dcc7b7af55
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 23:18:11.5787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5NhCf+aZEO99cWpoTL6TQ3vs3UvrqYT0PBx/9Xpte+0FbgZvV05+fedMzW5lam0tlrzAgTuoUcX9ow/7uLMYurphiiZOcJO6VocxyBy9TQ3VD5nOZL6qix7vhh1/vwH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7895

Extract map_pgoff parameter from the dictionary, and adjust start/end
range passed to objdump based on the value.

The start_addr/stop_addr address checks are changed to print a warning
only if verbose == True. This script repeatedly sees a zero value passed
in for
      start_addr = cpu_data[str(cpu) + 'addr']

These zero values are not a new problem. The start_addr/stop_addr warning
clutters the instruction trace output, hence this change.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..e8cf5d80d850 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -187,6 +187,7 @@ def process_event(param_dict):
 	dso_start = get_optional(param_dict, "dso_map_start")
 	dso_end = get_optional(param_dict, "dso_map_end")
 	symbol = get_optional(param_dict, "symbol")
+	map_pgoff = get_optional(param_dict, "map_pgoff")
 
 	cpu = sample["cpu"]
 	ip = sample["ip"]
@@ -249,11 +250,13 @@ def process_event(param_dict):
 		return
 
 	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
-		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
 		return
 
 	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
-		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
 		return
 
 	if (options.objdump_name != None):
@@ -267,7 +270,7 @@ def process_event(param_dict):
 
 		dso_fname = get_dso_file_path(dso, dso_bid)
 		if path.exists(dso_fname):
-			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
+			print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
 		else:
 			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
 
-- 
2.25.1

