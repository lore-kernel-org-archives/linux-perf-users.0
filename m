Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D313DDC6;
	Mon, 24 Jun 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245935; cv=fail; b=tGdQOTSk2wN6z6VqKs6Y4BuMOQW3zeAaVW/22QcEztmffFRuKAYUFLAA9aEJ2U2qlV9/AYLk7VXwoazL3IFp4MC9Io+mmmpGJaO9zQpvosFOYnhk8dsRJS2iklszUUQMYTHLK+oT5bE8jV9DibrWUuwuDXibYh6+uG/tNdZejf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245935; c=relaxed/simple;
	bh=Jjf71Zbz2TdW2H0CzPdWZQEqhFQtbMLejK3WDUIG8yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nq5pmtEhgv/Ni7TsgLdo8AJuCXfHYd9CH4cPxw17n/SkKOWovxabHmvIMJD46ks/cLfEfFeRW34HM5aXUd+oMiKNeQp1YlpYw/snujL8gYL+t9ZKNeTp6woy9vO7iYTwBerIo1GN29msh3i4UpH/Dy2Jx8H4POq2aJoEwrbGUrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MKuWaPyq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aQuwo8eM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MKuWaPyq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aQuwo8eM"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEtNZc021730;
	Mon, 24 Jun 2024 16:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=CsJdE/AA2hNxb1CDPgohAEyFhnuSAeWMf8C1fA9xh1E=; b=
	MKuWaPyqUIUGcYeZHnP7wsj5dSpQfSLGwojlCTXqlaLo03O4Bo4h1EytllIDXN7X
	HyjsN01oeZfqji+rC5mK84rwOyw47406F+pkh4ggGsFnD/0bB3F72qrcDu3pRCrW
	W/osJHfVdX87R1uens0/kuQDIGacKvklH+Lvxw90j+zU0mp0rVOQMvEvECJZJ91X
	Mf0IyYJkQls0LCnyOSaQaPnC4sdJ9DByuksY6UdvHc2FHKn7XKV19gHoIYdGCt+1
	m7mKyD1EyPE0OLKWeJfyk5Vxs58GD+M7/VaZSCXXKdjEca/PFeuZeuHlZqk6BwmN
	yWEbAvJux3Pd+zaNgaT93Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpnc34m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 16:18:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OF2g7l021591;
	Mon, 24 Jun 2024 16:18:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys32y9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 16:18:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhv6KOX818z0M+lwn19E2o9tG5HxxkowtO1E2McGuXvBnqiaJXktkkBxeTr8MjFp9lZjNdhzSwIZsSvrASMKI2+40qO88o1vY+my2ZWjqkQb9aLeFQwFzG9uTONY/pOMlB9eqBkLNoiHMHIOMy+U9IPj2pOH0jUzG6Z7ihc2z/8o0jA/ekJg2OES9LFN6OEPxodAyGf+1lv0wpF4roCdjFFEeUQZ99SFP8pAJfRABnHK6M2tt/MSzG9ZkimVSFenoNF9Tl8F/5OuW6vKgwMiNyTNd/ypdlw63jaVLdwMRvHvZbcRUDkB/7ljHCZu0T1Uq8K90T8/1tqUW+P649MVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsJdE/AA2hNxb1CDPgohAEyFhnuSAeWMf8C1fA9xh1E=;
 b=hgWAtyfwrtJPvi1HvC+ZPI1kXAM4D5G1UdUtrBLZL2TPqZbGuTlHaZM5i4mv2CZ3pCoz0lLlV5Zb/ude+CSAiCDYEfYkYawxBRuRFWbtMmcARYecXlU3WGQp4lZejRstS8NbYUreX7BlEA91p7M5/xHauEqUnONkCpz5G7sUjC7fK5apUhYmL65tF+R/66sFBUs4noMnFaGdjTsdNz9iOv7RxFdq0nAbXpBYiWpGAxMUrRQQbtvJSpDrLV1G1Bgy1rwkSFz9/lg0Ss1lVxvEVzI/pIfYAY8LGepyA/fjcicekYRvYtOAdEJgQbAzd+T3C319XN16iDrqhq5rPLumZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsJdE/AA2hNxb1CDPgohAEyFhnuSAeWMf8C1fA9xh1E=;
 b=aQuwo8eMKhmpEQMBcA29qy2bEfT9N3QD9HUTWo1cmVuG/etLgEuGeSowUZ6QAuNOqt93r3FAiZwfEwt/mbxiaEuuzxm+IzXYhAbYnu4tagQwwECZENX78vomCP+AvdV3dL1GdBykSEkY9TZK4c+xRlQukiWHyO2xv47enETFJ58=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by DS0PR10MB7221.namprd10.prod.outlook.com (2603:10b6:8:f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 16:18:04 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83%5]) with mapi id 15.20.7698.017; Mon, 24 Jun 2024
 16:18:04 +0000
Message-ID: <e193949b-d969-42e7-a0f3-fbea6e4dfe12@oracle.com>
Date: Mon, 24 Jun 2024 12:18:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
 <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
 <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
 <36e86320-1a43-45d4-b25e-a5d60857f4b2@oracle.com>
 <78db946d-db24-408e-92fc-b7ff79c80728@amd.com>
Content-Language: en-US
From: George Kennedy <george.kennedy@oracle.com>
In-Reply-To: <78db946d-db24-408e-92fc-b7ff79c80728@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:23a::15) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|DS0PR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 233eb084-ad5f-4278-7a74-08dc946939f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VzV4cDdBY0svajEway9xNDAyQ2RadTFMOGRxVUJqZFlqNVJoM0RFRVV6V1k1?=
 =?utf-8?B?OEhzYnVNUUQyTDZaTXUvbWZPYUF1REl4L045UkZIQUNnd3AvSk5FKy82R3NB?=
 =?utf-8?B?elNUOVkyMVAveDFDSkhTT1M5cjJNSFhEN242Nnl5YWdnRjl1bjI2NGZqVlJV?=
 =?utf-8?B?aVcrSEZ0RTYrWEVLYVpVeTd5UzlOZTlKdkJldEc1Y3pDVVB0Nkg2Wm5BNUpH?=
 =?utf-8?B?TnRreVVsUnJPZHNuUFFmT2w4VFQxdGZsWDkvZ21VeXVRc1hEVzNPaUN3QTRO?=
 =?utf-8?B?Q2pOWUR4VGpaOXlCdjFaZXJGbW9qVVZMOUtnQUlIUytKcFhEZ254NUR1SWVV?=
 =?utf-8?B?ODArWWNvajM0YnJ6WDVncS9XWEhKaXFaSUhVa2o5NnVHUzFRN09PV0syR3pS?=
 =?utf-8?B?aEY2cmVrN09id0d0Yi94dWxsTGNzdW9TWFhCSnBNR2NvY0NZV1BsRGxWZHY0?=
 =?utf-8?B?UEpFaGlPeDVjQWxoblo5V1RWdHY2bUt6YkV3RG1VZURmRm5OOGtKZWZ4SzFQ?=
 =?utf-8?B?NTdZN0xxamYwcmZ6SDZ1bEJKUmp6UXJXNXFvNEtmZEppM2x3ZzU2WFErKzF0?=
 =?utf-8?B?NXFOYlN3eUdYVkJsejlZWG1oUVJCQ2FxSDQxL1gxN0hGTTJ6MzF5RDhab1Ez?=
 =?utf-8?B?ak5FeXN1ZWxZbHNsSlU5SzFIc0Iydld3d1VWUDNBZnBKL2JMQ2dMMnJrc0RQ?=
 =?utf-8?B?QmNxRjRtY0tGcTlTYzJ2SzlGbE1YZ1E3ZklxVWpwb3Y3Z3Rma21iQlVTN1Mr?=
 =?utf-8?B?WGhpRWxTZ3NyalpLdkdzMUovdk5uWjdPZmR4MGxxUXpFQ2tLTlBtTFBFYTNi?=
 =?utf-8?B?KytxOG5ieXFYa092RkJvbGVVdkVNY24zWC9xYkpvRDJsaGNXckxlZ1l4Yk0x?=
 =?utf-8?B?c1prbU1YajQ1VjJEY2Q1cGNvdU0vR0hsWjZKWHpNM0NGOWUrdWtRS2Iwd3Fv?=
 =?utf-8?B?N0I0NlRzQXZjNnY5bDRtWGdteEZzbTNIRElOZzhZQjFRVEVoNkljZTh1QlBo?=
 =?utf-8?B?MElVcG90ZmgzY3o3UHBCT2RyMFZjWjBaNlJGaGJEb3dlVTNoYVNOVXMxY0lu?=
 =?utf-8?B?RXN4UkdETytVVnRMNDM4OEczeVlxT2ZRQlFrMFM2Zi9rMGlKSU54M2E1bnJw?=
 =?utf-8?B?Q2tkU0pRWXdmSC9MNGliSHE0YnkvMkVVQVhjYnBVQngyWmVvaEpCSm12aE84?=
 =?utf-8?B?Mm90RkQ5NGRRRXJjcmRwajZrNEtNYk9kaDIwTTF3N0k4bWFRS3FrdlhLejdz?=
 =?utf-8?B?OWptY0JzNUhnYmlheHlkcHdhNUI2ZzVEL1E5VERjNFZCNTY2TWJTZzBIYUla?=
 =?utf-8?B?QmY0b3BpWDkyTENzN1pqcUlOODBvVTBGM1Z1ZFBZYmc0aVB1V3l5dXJQcDg1?=
 =?utf-8?B?bEpkMVlidW9ENVBTSTJ4UExUOHpaamdZVkJSRVZFclBsRGR2anNvVCtMT1Np?=
 =?utf-8?B?S3FHTW5TL1NXQ0lnVVkzQTJyWG9rdTg1bWxyVm5Ed1FobjUzMlFmd2Q0WUho?=
 =?utf-8?B?dXduUlRlZVVDK3BZMm5GTjBvSUl4cHJTbjRHQ3hSaDZ5Vmh6aWx1OVAzaHha?=
 =?utf-8?B?ZGRIdWpmRXByeFoyRFlZVlhRS1BYVTZpRlorZElWY1dkcEhFcldKRm8vQmI1?=
 =?utf-8?B?U3VRY0N0UzdYMDFrY1JvcWt6TDJtOTJaMEFWaml3VFNaOWRLVXVFcmhuY3VF?=
 =?utf-8?Q?3MEQ0KhPj2pv8CCojP4/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NHE5MVhRUVV3RFJ5TEt2T1VPeEI3S2ZpMG5nTEpmNytxTGF5TnZoWkYxUmIx?=
 =?utf-8?B?RW1VUVU2M2lSRXJKUGNNeG52V1NwNnVjbVVVK0FXZEdsa2Q3d3R5cDBGNVQw?=
 =?utf-8?B?dlNPOXNrM2lzM2F4azJubmVlUTFaY2pQK1kwWGkrV1huOEc3SndCS2xEZTNz?=
 =?utf-8?B?d29nUnJvb2t0SW54TnJmaVg5aUpUNFJKUkZSOGYwbVpMRUtCUFc4MXcxSUg3?=
 =?utf-8?B?a21BamhwcVBnRTRtcjZOVHBaZGkyYWZRNlI3cy9Ea1ZBcmk0RWlUZjBFK0Rl?=
 =?utf-8?B?anFuZzJrQ3c5TSsxOUtrOURkcVhYdktFME0wNVE3SGdPY2lRTWVvcmlxcVZa?=
 =?utf-8?B?WVR6cmNJZ2tTaFE2N05jNk56K2xFNEI1SUwzUDZ2OWNmYnNQdzhha3czYy9M?=
 =?utf-8?B?N0E1VExja3p1SFFaTmFEclRFUkdoVUcxay8wKzBZTE5ReWNIblNjbHRNTU9R?=
 =?utf-8?B?a1NKb1FpZjJWNGVHemhTUEo4cytybGNqNmx6c2hzUURzQTcxSzI5aEJIenNX?=
 =?utf-8?B?cnZVSTR6RWg0dHc2Z3VNa1JsdFJZcm9sZ1d5RWVaMDVZeTZ0ZXVUT0xlS3Rl?=
 =?utf-8?B?ZUUyS1hDVmVNYlgvNm1SM1p4VXRZNzcvYmpQdS9rT1I5cHBBTlovYm1nMEhw?=
 =?utf-8?B?TVh1cUZ1VUZKTm5vK0Zydk83MXJOd2syT3J3RFc1MXdnTlp2azdSWWg2N2dC?=
 =?utf-8?B?UzdjdGsrZTlVdHJqZnpidUZUbW45NktvTHlHbFNCaEZ1WmpwNE01Ui9qcGVR?=
 =?utf-8?B?bG5maVVGalJyQnBjMGlzTTlxS1dSWWNIMFhrdkwyZG5KTVVnOW5DalpZTzI0?=
 =?utf-8?B?TW1MRlRjVEZQTk9ibkpMZEpaWU9PdVBrTHIzRFo5aWEwazREV1ArTXlqTS9x?=
 =?utf-8?B?N0hTK09ud0xzbHZsekZuUDhteFBWb05EeWI0SXlvVVJyNW1ITEpRSjlsaTBO?=
 =?utf-8?B?dVhQM3U5M3htRElOSjBxWHAxd0hkN1Avb2F1TGgzbmxWVjlaL3c5QVQ1UXNW?=
 =?utf-8?B?aWNUYzlDWEcyU25mWUF6UUsxZCtwL291aHQ2a2RSK2xpM0RjOHhxTkw1OW1h?=
 =?utf-8?B?YTQvaEdPTndESEhMTHlZQTgwaXhXZ3pDekhrN3NwUHJTTU1OMlQzWmhSd0pl?=
 =?utf-8?B?NUNVMkZ2Nmk0MzJPYVhFRVNVcUtLYXNYV2c4TjJYR00wcmpIek9zOVMvWWpm?=
 =?utf-8?B?dVB1SitKSHA0OVNOYTFYK0ZXZUFBN01IK1JaNDJIQ1AvT0luR0RXMHNTR1J3?=
 =?utf-8?B?d0tvb3lLVTBja09Ua2lLNkI5eW9EVUVvcHBDdytXRUJMYUlpYmZlcFZHVk1a?=
 =?utf-8?B?NzFuRFlSY1RMTlRjYnBaQ0xmZ3RuN1pnT3BjT24vaEpVNWt6SWJxRjU5Q1p6?=
 =?utf-8?B?SEtwcTg1VHNobmtKRExuTVpDV0ZjQS9hTHg3Ti9xcTVsQUlqMHpTN3lkblo5?=
 =?utf-8?B?ZFRleGxBaGN0K3ljR0dkT2tienhXSm9WU3ducmdaUWlxUW9GVXdrL20ybE9r?=
 =?utf-8?B?VEdLTzB0QjQ5ZkVIZHdtNUdiSVlPUnE2Qzc3bFd1UUhGeitKWWk4V1YyTHQx?=
 =?utf-8?B?U3ppOXRRSmNLQ3N5eE0reHVCSTFBYm5LRDJuSnNiVDhCQXNtVm1YWjJyUlBT?=
 =?utf-8?B?WXdubW5IWWVqSTR1RnplclA4aTJtK3g4b2RKMFpodEIwRDdIalNyeGRFZXlE?=
 =?utf-8?B?cFFJblVnVkxaQnBITTVtSlc2T3FzRFZwWjRlY3JwY0ZCMUVwUFM5M1NPTDNn?=
 =?utf-8?B?ejhleDYzdmpidmhHYkhzQUZ5ZEdXQ3g0WDErTjExbWpZSzhYMjJwT3BWWTJs?=
 =?utf-8?B?N3dlQ1VKenZsY1VKbENKMUZTKyt2SlB6RURLendYOGtLQW8yRWVuNVYyOEVL?=
 =?utf-8?B?dm5DamZqNlBzZnRsdU5IYlNaczM2OWkzaXJWdUtMbmZydHREczQwZUNydXJ5?=
 =?utf-8?B?aVFPdlU2MDBJMGdxWmRnQzlPNnkvRlEydXo5dTc1WlQ3aFJwMWp4NU9ZR2pk?=
 =?utf-8?B?eHd5aC9qZURpRHBObTFsSFM4aW9kK0t6SkVpZ2xCek5JdDFPNUI1RE8zbEt3?=
 =?utf-8?B?dVdwcnIwZVNER3Q3WjQvL0I3TVd1S1BDMktwdXF5eWJOS1JNajgvSmVwWjhH?=
 =?utf-8?B?S1YzZWFBRnA3ajh4NEhPeWpxZ29lWDNNT0ozTmhVSEhnUFlaUWxFMVlQRXJG?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	d4nhGUiWUFnwnWHipPWLlaRbVoE/VZQZM7cyTK0cWIyA7loTOW39Z4XmygtFUWN64p0YGVsBmwyKzhS09OoMQmhSVq3UDKJ4MTsPvg2ickG7mtVXSyvZ7qfDhAA0Zyx7Fgacx+TG28TMaVkr8fIUvo71PuE79pvkh+uZkgVk+Z8FfalF2yuNJwJv8ePtCZL4tzsijmuSlNEGsJBJD6Xr21LhZAsgeyGpfWyn6zHGuXD/Oo/MOsa3bL4GtvgtiP7HEqrZQZvbpdYXtj29ME/1PcnFNChH4qghzIYw9E0VmutFTldUx4gGFPJw0Jg0W+KQly1KN4CKZwGNurc9ntnQes8hc/YMK/WJNSLc8wwCHGVNRDlrJgxgj1BSPi0ayrCpH7WAkDGs+qIMjMGpa3OFe4he+tVIqz+rJiY6D+IgEtiU2o0yf6NF6QrB596fFDPKNt2pXA2EHVuPjjUoGRXAdGIt9xqfXPprQhfWdZiK01nKO09tNYnrOfPzQdwdfGKJh9mvXJU3DM7Djy8C24iIKhTmovLKxchtErnPZ+tBU4a5bpmK8Kk03Dp5S8eFxX0deczFxQ9dq3qOcIzB/sstr6FcpgjPx5951xrhcZYP5/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233eb084-ad5f-4278-7a74-08dc946939f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 16:18:04.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUpLrT3omgzcRPhUoVTGRawpu//uq608e0m52Kw1XAj6QmA1ZXyd9jy01YcfFi9phTI/7HgV7eyb7/NG8MLm4AeAQEp9qiJKfSrgOt2kxDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_13,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240130
X-Proofpoint-GUID: NkOzUjYFsWTLlDXMEdUaAkhDBgFfIxpC
X-Proofpoint-ORIG-GUID: NkOzUjYFsWTLlDXMEdUaAkhDBgFfIxpC



On 6/10/2024 6:51 AM, Ravi Bangoria wrote:
> On 6/8/2024 12:43 AM, George Kennedy wrote:
>> Hi Ravi,
>>
>> On 6/4/2024 9:40 AM, Ravi Bangoria wrote:
>>>> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>>>>> Events can be deleted and the entry can be NULL.
>>>>>>>> Can you please also explain "how".
>>>>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>>>>>> This appears to be an AMD only issue.
>>>>>>>>>
>>>>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>>>>> The Syzkaller reproducer can be found in this link:
>>>>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>>>>              if (!test_bit(idx, cpuc->active_mask))
>>>>>>>>>                  continue;
>>>>>>>>>      -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>> +        if (cpuc->events[idx])
>>>>>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>>>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>>>>>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>>>>>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>>>>> There are subtle differences between Intel and AMD pmu implementation.
>>>>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>>>>> amd_pmu_enable_all() loops over each PMC and enables it individually.
>>>>>
>>>>> The WARN_ON_ONCE() is important because it will warn about potential
>>>>> sw bug somewhere else.
>>>> We could add a similar WARN_ON_ONCE() to the proposed patch.
>>> Sure, that would help in future. But for current splat, can you please
>>> try to rootcause the underlying race condition?
>> Were you able to reproduce the crash on the AMD machine?
> I'm able to reproduce within the KVM guest. Will try to investigate further.

Hi Ravi,

Any new status?

Thank you,
George
>
> Thanks,
> Ravi

