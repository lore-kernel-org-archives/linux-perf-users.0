Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590B11A00D6
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608921; cv=fail; b=Zux4CnhQt5EHaQbIy2pVfZffrJ/nTitXkuCRp9WuhLy6H5x5NFCjS24RSDTwDmDsmcFyb8m3xM+/IV+uxCp5aKI51VhN71wpAeHMg8Q1oGRxiFszwWsB0hKTt74GO4J+XTjumjsXKjbrukjrUkEjcltyO/bIXSgQBhzrUaRijCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608921; c=relaxed/simple;
	bh=EWaDJTOG4cS9Cvj/SHmrnQ6OmGaTZKz/2fBrlchyNvc=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=mN2UXNCvBGx5sKD1h5e7c3KCbJvYZKaOOk6dR//M7VqGnBQqe40EGtkhbA8NsjamFdmwU1nKABO2hiPCPF1M8a6UfLUkwjjvj8ZVL72tay7tA4cLkfua0pONoqYIeXdgxHAlrMvNIrhaFi5kPdG7w/dBUQDhwUfCAzEOovaT5g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cWHg3mgV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RiKa9h6r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWHg3mgV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RiKa9h6r"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MEfdDH029445;
	Tue, 22 Oct 2024 14:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=m8ciE9PeOo5EWHHf
	nYYLnGtEcWK0xLBMnO1iNUk4xmI=; b=cWHg3mgVhCuacQxstgd+NUPAli7wlijN
	tES4ngL3xfB8MpnsrgyqyYn+JSMPe+ZJy7zGeFQDARdpBwF89dqpvVesI1+5aAX3
	C53oNCNtMrEuiEwdIXy3tSLt/zZg6BJUEE6Vlfvvj6MzeWJyZ268V16ZocM4SdoB
	3jSuN1C4mYym1FE5CTm68kYqYO25p+lWHDpH1RtzHBNS6kPtVx6cAJhtTZ3kM4VM
	34/vOgyusHG8nBu+fQL7ryLZjGDRuMZmxxop7lGCpg5GwXmP2zGW2g+Ouzrjn9Kl
	2jSZyg2hpGRwVsymWnXNjZPI5Q3KhtXowEE7OJgdHtm5cruFe7rQMg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asdu75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 14:55:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MDgvOp035267;
	Tue, 22 Oct 2024 14:55:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c378hnd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 14:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh3zTtWTiArQhQFrYXDnUj4IwJ2A5LGV74Ydr5OqgPsIWZewWt3x5SbXJKQNdVxpbCFkxdq5d2aAQJ8Z/8YBIauQSsXXi5un0hvgo0ctQjyqy5ZPBLbHyxDS3g6OmGwToJQOTVb96hkaVFgtFgMVVVH3AHO8Z8Mi8yTEx8t18pY2lT98hfsGtLyDOWx7myDMOWv0z1F2XzR92WN3iEJU7A3orNxXcbczGJxE0EQ6hGt9/gpt8R2ZPwpDoibQ1+I22All1MXX23I9gdvGWi3c4WJiTeMLlvu7p+0I2RQ4ygSbE6UYEDw/+3xFy6+p9gbW1uggXfxgObknC2v7dk5gIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8ciE9PeOo5EWHHfnYYLnGtEcWK0xLBMnO1iNUk4xmI=;
 b=ioLmI4+yUq+wl85wPgpx54rLnZVIrSRE/j+LKQmsFxsnDpgA3fjmfqKOTB+fr/0MUvPt3ZRA3czyTH4CnFB1oHZMQO4VwDzbiIFg05nbQer+A8EIJQ2puqQeDL85pSyo7oil9e2ZDlo/dg0zOuJCKFPnPelSz1l9CGlxMwmBC4EZXfS+bHzVeBMFNY87QHAMUqz0dZlBBYfwacKIxn4I2n5dZQFB7xeamaCzoErBXRbNOxx1992qpXr2ayDYm1Ii9LxAwff9DoAB6w47ahE1E66wegds7oTW+85BsY/iiiIC1467ibGenn1tRdMWjsLvck8LgWwqqiNx4iXyol7mLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8ciE9PeOo5EWHHfnYYLnGtEcWK0xLBMnO1iNUk4xmI=;
 b=RiKa9h6rsPFPHCuXNxS8Q0Wv2S8Qy5LgQSRgpUVjBsegzQ/pFNFCF/ky4Iyhzgua7egU5pXjHBir5DCUCJUiPgNeXFFYPmfRVRc+q19doQEhSANaKndL7Dxs9KiOl+qucu6AVdalLrC+Rhta5LqhtcQlhdiYHKZhD8lZ6tQ7WkE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7229.namprd10.prod.outlook.com (2603:10b6:208:400::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 14:55:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 14:55:08 +0000
Message-ID: <156a0ee3-18d5-4144-9f86-230a3946940e@oracle.com>
Date: Tue, 22 Oct 2024 15:55:05 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-perf-users@vger.kernel.org, x86@kernel.org
From: John Garry <john.g.garry@oracle.com>
Subject: [bug report] perf top generates kernel "unchecked MSR access error:
 WRMSR"
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0415.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3ee90f-d6f2-4018-e6ba-08dcf2a98548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0JueFR4Uk1FYnVDTnMxOWhzMFljWkZKNS92c1IzL2ZoNTc5aDlVMzBuREp4?=
 =?utf-8?B?R3UweVlUSEhPUTFLbWVaRGtvOW92cHM3R1BMSGltZUFwZjNPc0pIZm1DTWh6?=
 =?utf-8?B?eG56akptaFFSWnlaaGdsdkpqUlhNcmoyK2FVUngxS3IvZDZNekFsNkc2Ny9y?=
 =?utf-8?B?TkRLdXJ5U09TNkdXOENlZXduYzhNRTlqWW9rWTZZODhOUW5RakdpOE1oZlRq?=
 =?utf-8?B?ak9qYThPUVFEekt5Z1dYbjB0UzlXUlB2aTFrN1hua3ZxL05MYlJGZlJCMUEx?=
 =?utf-8?B?RUFDZmp5WXNkeEF2eFRpdHpKREpvVVlpU2FpVUVpK1JGQTBHM054bmVzeERt?=
 =?utf-8?B?blNqNkJaWTJXa21KZUxnaXJ3QmxOdVBkZ2RRNXhrVjBJck1HMVhpY01jckVC?=
 =?utf-8?B?b2FEUFlGK094ZU1YNW9RbmExdzJNRVBYYXNSVWMzYWQycFpkL01oRm9qeVRV?=
 =?utf-8?B?UlpBeEJBd2lBbXBsL0FoUWl0bHhHV201S0tsZlcyekc2LzE1cUZXVjBLVVZV?=
 =?utf-8?B?c24ySkRlMk5pUEVsYldOWGlTZS9DU0ZkbGl2YVhZbHJZa25ObVdhMTZvdnly?=
 =?utf-8?B?UTZreENocWk0RFRIMWhvMkx6MXRmRElqV29odW9nZHpkdXdqRE1zMUtZQkhh?=
 =?utf-8?B?eFVjbVQ4Qy9mQks2VzNtQ2ZDVktDQVI4eU9aQUhhY2ZJdWpzVEZHMXN5eGFu?=
 =?utf-8?B?TEphZE95WkZRZG53QUx1ck1TTXFtMG5yQW1DSytTYkVzVUQyMmlhYkxzOE81?=
 =?utf-8?B?SEtoUFMzeXlyNmpqbnFyS0tNT2dMd045Rmt1bTR5Q3oydG5WdEN1eW9PSkZq?=
 =?utf-8?B?UUl6eHNYYTYwaEs1VzI4R2owdjJ1aTdROTlXV2ZQNHlDQVhkZU1QeXU1dVRI?=
 =?utf-8?B?dzdhNXdlZHltYzJ4Mi9VT1NhT3BveUdoQm9nc2xyS0Q3RGorVmZiYTYxQWJK?=
 =?utf-8?B?UjljRDNDb0VaWVBIcldIcTQxVTY5d25wR1dvaFlZaUNMVStqN1BlSTBQY0dE?=
 =?utf-8?B?YTZJMEkvQkc5cTFCQjR0WGtKQWtmWloyTVBnZWNVSGx2dTNHamdqWFBwK0Uv?=
 =?utf-8?B?dFRwM1JBTFNjRmx0YWFkMUwwSnYyQ3hYR1NzUUJCMG9TTkcwMXVyMVd1K0xh?=
 =?utf-8?B?RVp4bndhV3lkQWJQRzN0NGpJRXhHcnFPaFFPM1pGM0JHOWNmTzdCRk1aNVZE?=
 =?utf-8?B?NmJwWGlra091RVBiTldHNjBaTXdJWGdnUGE5R0xqUXUwSGZCazBkOWZ6cXkx?=
 =?utf-8?B?enZlZ2NGem40Z04rb2lGWGh1Qmorb2NqVjUyN21Ja3VpdFhXT0ZaK29JTm9k?=
 =?utf-8?B?ZUxuaVZoNmJoZUJFakhoRnVXWGZ6TEFPSUY3MytGZ25NaFRDRFpTT3RQQS9l?=
 =?utf-8?B?VVI1YWVxdERuMFpoM0kwdGZBbGJDeXl3cUF6SUYrZ3QxNnRmZjQvdURoeXBq?=
 =?utf-8?B?RkNIcGZZbHgrMGF5NkV6ancxajFoRXlKZ1NrMlhFQ3RxTjZyMHF4SnNvNEFt?=
 =?utf-8?B?STdPWVlYMmdQdjZYbWQ4dnNqbG1FbGs4dmY3cnNIYW11YmI1WHQ3RXlvZWV1?=
 =?utf-8?B?d1gyTUFHdFFPRzBnTmZEa1FmdzJpcFFxVlVQSlo2eWhPT3h0UTRkeS9ITnhH?=
 =?utf-8?B?bGE5UXdXQ3h5U09yQjhaU1p3ZFpoZHh4ZnZEL0dPM3dKekpWd09QcXBaMXpI?=
 =?utf-8?B?clZiMU11NUoyYWZnYUdCcWMzcHYvcDBKczkzL05YUmNPbTJVdFpxa3IyUXVR?=
 =?utf-8?Q?WN/57e0HaM/Xa+oWX8Rzt9I09GsvEVcVztNpCY1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEdCTlN6c0pUU2pscVVPVVU5RWdEZEhFNHhVS3dCejcwbHBKbmQydDRKVWtk?=
 =?utf-8?B?SzVTSnV0eHdVNHdhVjRXMFRLYlhZYlRjRFErVi83OG95ZUg4Z3lkMU1DOENm?=
 =?utf-8?B?aXhBeGdlMEZFRTZGdCtiUFJ4eVZscE1LeHAyWjZ2N3FNM1AwTmlzM0h4SkI0?=
 =?utf-8?B?ZVlVV3FjS3pVMUZ1bTdTTkViMmhMNmNOVjR5VUJVUHppUzZLSFJmeGJzMTlC?=
 =?utf-8?B?azZXcXdPK2RsS1J2L2lkZEtGOW11TGV6OWpyRHAwR3l1MTA5UTVNSi8rY2ZH?=
 =?utf-8?B?VVdLWXZpNEJvbjBteHpIZ1ZhRUdjUDlIVHdkMm5XVHY1d2FwZFZTR3JZdHZm?=
 =?utf-8?B?SlpITVpBc0dPS2QyRmJQeEtsNEFhTklaMWo2WEZQT0I2dkhEQ3FVSzJhaWc3?=
 =?utf-8?B?SUhIa05XOWFWdlk1QVB4Q2NHN25yVm4yU2YrVk5lVll0a2FFL2MzZmhOUWZX?=
 =?utf-8?B?ZDlOUzMxR0NQYThNZkJOVWJMeGw3NzRQSEZwYkRIa1pDOTBPdHRNS01obFNR?=
 =?utf-8?B?S3hhd2JCUTA5KzJiZUw4NWw0bEc1SDQxRmZwTlQ3M2U0YXJlNDU0dHZtdWpZ?=
 =?utf-8?B?YzNTd3BWSnBick52U3AvY0dNTmNEMzJKcXUwTmdOdjI4OG1CL09NaUtvenNV?=
 =?utf-8?B?VTZ4aGtDYmJUZDJmc25UQkF3RHAzbmRURS90cTBsQWhOYmZhL2piS00ralBG?=
 =?utf-8?B?S3NReUR3MllRaHZMcnBVS012aXJxQnVONmFOYmRvekcvempOdXYrcHZPRXFH?=
 =?utf-8?B?bEdqNUM2R3NzU0ljb2JOZkFXbFkxRmxnc2FTa25nbDc1ZmM3WGF6OGFhMlJo?=
 =?utf-8?B?TkhLNmRBK0I0RXdHSDZja29SNW1mUVM2UUZPL3pXSklaZm1vQmhFa0E5RnRl?=
 =?utf-8?B?UjRBM1J0U1NKa0ZjaHVDWHVCWVRLTktyRnN5cW0zNlM0T2hoejJKMExGZUll?=
 =?utf-8?B?aUlFeDVZR010OFQ3N08vbGhNN1dSWTNoaktDSWZnWUNCQ0Y5UXZoMWVmOThE?=
 =?utf-8?B?c0tpODJxb0hSdFU0RDc5OGl2K2RKT08xZm1zbklrSW8wanpFVkxIRGVxN3Qv?=
 =?utf-8?B?S1JNT1IxTlFUUHYrZ2xDMXhyTTBqUWRoNytlVEhZU0xtSWJac0hzNENQYVFH?=
 =?utf-8?B?dldDNFNOeXBmdy9TKzAvakJwWWZiS3Z1aFlSd0p0WDZBcWFYY3JpTFcrcG1j?=
 =?utf-8?B?S2doeW1OeGhYdmRKZnVFSldZYUREOHhmZGNCQ2VnWnB3WnkrODFxb1ZDQ0c1?=
 =?utf-8?B?SjNzS2Rrblo0VCsrK2s0emNpR09RcEVNMlFwdVBWMWtCUEJyOUJBZ3E4K0tH?=
 =?utf-8?B?c2h2M2RxY2V4QndZZzMwWmcwSHRUS2NLRXpCQzUvWVV6R3dBcGtJS0RTWUc0?=
 =?utf-8?B?UHRIWHdDNXhzODRScERGNHpGcmtkeDBlNmpJY0RuaHUxZ2RuUlJNNk5OWGxP?=
 =?utf-8?B?UW96UXkwK0NLL2R0Tm1NMWJ4K040Z3lsZy8zY1VJSk95dDdkMFJUcGQrcStB?=
 =?utf-8?B?LzBqR1cxajFpMkxXTStrNDBzVk9rbDVRK0tGYVpMNFJmelBrK0JmaElhYmMr?=
 =?utf-8?B?czRwSkphQUd2L1ZTTW9kdG0zSTFRWFRJVk9XRzZvaXJyU0hlM1NnL0F2WTF4?=
 =?utf-8?B?MDdQb3Z6UFcrMjRNaVdKNWFreDF4Uk5penVWeFpjVzdLQWNndXFXaHpSdUpn?=
 =?utf-8?B?QlJCN1Z1QVBEMkFsT3BZZlJaV1YvQnRZYjhWL2tYOG5lWXMwc2orMVlaYXZn?=
 =?utf-8?B?aTEyRmFoNHVUdlJlbjFjbkx6NUdsQW1VT1dTRDFXenNPSjBMMzMrWFQ5NjVU?=
 =?utf-8?B?dXk0a0duNXJReWpvZzNCZjZlb1l0cWtjWWNINWtqd0V0Tjc4V2c2eWZxUlV4?=
 =?utf-8?B?RjJBNlc1Q1hkSnhub0JQSGpNakdtMFpLOTFtRTlTZTYycDdMUFRtQ2s3TVZy?=
 =?utf-8?B?TFNkR0xnVjlLOWpqcUtzZHpOQTZDNkZjdkhZOHBHU3NXeGc1cEphMnNQNUZQ?=
 =?utf-8?B?V0pBVGZVdFluNXM4ZnNxNS9zeDFQMURCd1RYOFhHNzQ1Ti9iTXUyVUdFbHVD?=
 =?utf-8?B?cFlVaGhGR2E2eWdScGRSNlMzQkl2U1VsbXU0eC8vUlVmczRRUzNmRWl6YVd4?=
 =?utf-8?Q?7GSldMshsKXQkGkgK9ONyD5OK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UcS3Q1jqxdsKQ0s7Kd/Z90p3QO7c1WlHUowzL+ML4OXtw3LrMUoIsI87F5nlQs61MSIPMh5plnt900gDQCbz7uDxdtBAkwYiZ1jJbKoXuT1Ip319JdqI6Nga0a6ExnEXlgU1/5X0i4FIb8jcNL0jRxeyFibvnm58hle7RglXBwJfZNOuzt0Aapl32R+yfM+urkp/qrzQOGNybDsA2Kyuy+7D253EobkZ21LeIbk1HO10E0f803vPd+RhB1GCEfowh1udMu4e4xgnbGtQ0n2l+Y7I9jwJ2TCkIGfcNkfiKutvhmZIXdE+f8nTK8Ivbgn5GI1SvbUksiecxAnrHmTHJo7BdoP6W8T+V0OKW8dShSiAZUq9zCdYZqIDndDVzGBktpKv0D7F2QRq8ECPeyyip2N1XPBZP469dFGMV5vtLe2Afzb5K4cMBvmP7fb4zDvls7PkHNRU4llPGbo6cLJ1TDVXZmq8LltzUU2dZ52cbnSUY2MTrOoawvL8aeVGzpTq2Obn/nASg7QGhAM5d5uWid8DjqAicld0zJXCvNDCPc9qkuTYHMP4XDofcYqXuFOvJGUdKbZfZr/DaTNmV66jQ6dfQ7wQJog1j4ZEXMCnWJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3ee90f-d6f2-4018-e6ba-08dcf2a98548
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:55:08.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0aKEzaNtUdDkHlLGUpOj2BftTFmT7nMEsQZMqcrokicAk2HSmnaDdPw2KgQdhDSa1KHjPWKRdN7rEmMllcxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_15,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220095
X-Proofpoint-GUID: Rt3iPQTjlymuVsNkG545GXcr9YBIpglS
X-Proofpoint-ORIG-GUID: Rt3iPQTjlymuVsNkG545GXcr9YBIpglS

Hi all,

On my VM, "perf top" gives this stackframe on v6.12-rc4:

[  930.527581] unchecked MSR access error: WRMSR to 0xc0010200 (tried to 
write 0x0000020000510076) at rIP: 0xffffffff94ead548 
(native_write_msr+0x8/0x30)
[  930.531135] Call Trace:
[  930.531456]  <IRQ>
[  930.531749]  ? ex_handler_msr+0x138/0x150
[  930.532285]  ? search_extable+0x26/0x30
[  930.532780]  ? fixup_exception+0x9c/0x310
[  930.533405]  ? exc_general_protection+0x10c/0x490
[  930.534081]  ? asm_exc_general_protection+0x26/0x30
[  930.534768]  ? native_write_msr+0x8/0x30
[  930.535357]  ? srso_alias_return_thunk+0x5/0xfbef5
[  930.535998]  x86_pmu_enable_event+0xa5/0xd0
[  930.536641]  amd_pmu_enable_all+0x4e/0x80
[  930.537211]  ctx_resched+0x13b/0x1d0
[  930.537735]  __perf_install_in_context+0x2a2/0x390
[  930.538439]  remote_function+0x49/0x60
[  930.538931]  __flush_smp_call_function_queue+0xdc/0x700
[  930.539694]  ? __pfx_remote_function+0x10/0x10
[  930.540480]  __sysvec_call_function_single+0x38/0x140
[  930.541134]  sysvec_call_function_single+0x6c/0x90
[  930.541970]  </IRQ>
[  930.542269]  <TASK>
[  930.542766]  asm_sysvec_call_function_single+0x1a/0x20
[  930.543493] RIP: 0010:pv_native_safe_halt+0xf/0x20
[  930.544195] Code: 22 d7 e9 ff b5 13 00 0f 1f 40 00 90 90 90 90 90 90 
90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d d3 e3 25 00 fb 
f4 <e9> d7 b5 13 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[  930.546841] RSP: 0018:ffffffff96a03e68 EFLAGS: 00000206
[  930.547563] RAX: 0000000000000006 RBX: ffffffff96a269c0 RCX: 
0000000000000000
[  930.548579] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffffffff94f53f31
[  930.549568] RBP: 0000000000000000 R08: 0000000000000001 R09: 
0000000000000000
[  930.550529] R10: 0000000000000001 R11: 0000000000000000 R12: 
ffffffff970608e0
[  930.551582] R13: ffffffff96a269c0 R14: 0000000000000000 R15: 
0000000000000000
[  930.552683]  ? do_idle+0x1d1/0x2a0
[  930.553182]  default_idle+0x9/0x20
[  930.553670]  default_idle_call+0x7d/0xc0
[  930.554226]  do_idle+0x1d1/0x2a0
[  930.554696]  cpu_startup_entry+0x29/0x30
[  930.555154]  rest_init+0x12e/0x1d0
[  930.555621]  start_kernel+0x60f/0x6d0
[  930.556064]  x86_64_start_reservations+0x21/0x40
[  930.556633]  x86_64_start_kernel+0x91/0xa0
[  930.557107]  common_startup_64+0x13e/0x141
[  930.558038]  </TASK>
[  930.738880] perf: interrupt took too long (2511 > 2500), lowering 
kernel.perf_event_max_sample_rate to 79000
[  930.772912] perf: interrupt took too long (3414 > 3138), lowering 
kernel.perf_event_max_sample_rate to 58000
[  930.797764] perf: interrupt took too long (4275 > 4267), lowering 
kernel.perf_event_max_sample_rate to 46000
[  931.117733] perf: interrupt took too long (5345 > 5343), lowering 
kernel.perf_event_max_sample_rate to 37000
[  933.862829] perf: interrupt took too long (6765 > 6681), lowering 
kernel.perf_event_max_sample_rate to 29000
[opc@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 ~]$ ^C

a known issue?

more /proc/cpuinfo gives:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 25
model           : 1
model name      : AMD EPYC 7J13 64-Core Processor
stepping        : 1
microcode       : 0x1000065
cpu MHz         : 2445.322
cache size      : 512 KB
physical id     : 0
siblings        : 16
core id         : 0
cpu cores       : 8
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 16
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext 
fxsr_opt pdpe1gb rdtscp lm rep_good nopl xtopology cpuid extd_apicid tsc_kn
own_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe 
popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm 
cmp_legacy svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw topo
ext perfctr_core ssbd ibrs ibpb stibp vmmcall fsgsbase tsc_adjust bmi1 
avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt clwb sha_ni 
xsaveopt xsavec xgetbv1 xsaves clzero xsaveerptr wbnoinvd arat npt nrip_sa
ve umip pku ospke vaes vpclmulqdq rdpid arch_capabilities
bugs            : sysret_ss_attrs null_seg spectre_v1 spectre_v2 
spec_store_bypass srso ibpb_no_ret
bogomips        : 4890.64
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management:

Thanks,
John
