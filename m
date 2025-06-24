Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5C2E2EF3;
	Tue, 24 Jun 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750786325; cv=fail; b=gSCuIr7GxhlL58I/sJQUtvXfMcjsFWHxjopTmclFmb2At03DxAjGWXtf9uV3k58BUBwzxo6YYT+10cRN4ObXme60H87YxZHh8+N2fcOIoBP7+xRWExOQWMs+zMm/8t4rxT1gF5bkbccGKvuqh3mF2GoeSNjdE5wWh60KjT2tGmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750786325; c=relaxed/simple;
	bh=4H2xtIWwbEN+IEnt8d6IwPdRirceHyAc6vn2XnXfpKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uoy80A/xQisfCgwAx1llxXvwhApEPOUqCsnrF72QjtqqXmyGOWtOWuaBZ/eWD2na95+XcQlHIg2uTpAwj5K1nGalYdEFcBIC9SE9VohGQqkWst7YPJtT2fjUAIB0Fffdj03eRcvrMfNMK1ug9fG432kfahqsx28LT8ZzqWhTqw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cVVjClcR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yZI8+30R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cVVjClcR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yZI8+30R"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHBhVi028549;
	Tue, 24 Jun 2025 17:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hxbronCbhxb4BbfC3zpVY4YM/Rg8yQ/pGseNd7H4I10=; b=
	cVVjClcRLDOBsa+S+ceVx5EkqjmpStH+ymqKBv/NfL4zbqpnCnSE853MXJVZpl0h
	uR+ShLen1+Rf6XSwuAoIQFiJL5luV2qwiOn2thuZs9eLSpRNqXewQXTb+3mo1Pwk
	gK86YHSfKtwAynxEBhMkFWhDrEvBiH6bCRLuIvzOmIz3ytekHIAdulUyLTWq/7xc
	UtkyAChv1Bx/JzHlD3k5YR2h7d5Pv46ei0A9MXgGCsfDcb9LvXaaaOPU7UFc8oiX
	ln+j6nI/FE42adQftkcS0MOPIi0Mda9pzjDL9LxL/76jBDdA9vnHLnSzQeyYkczB
	WsGStUu+7aQkByRdGRqODQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87wqbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 17:31:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OH10WM038912;
	Tue, 24 Jun 2025 17:31:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehr4x9vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 17:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYND7Ll4y0vwDthNUULFBQwh52t6NUC0xIvwEMCVNbpQEQwyVMnlB89fBrc0z5Wb/49dFcn4NpJyelTn/tXCWEFttFgVs/iuvHzzW0JJecnF8QJRDVItaAPvB0q9eHfi5Fb1TXUw7SWjc+1ME83UZiVX+4TA7X9Gospg/oBc+7GcEDl6Ye2RA6Q3i7GPs66vByquojOu44DW5PvyGSWIhu0ZftZ0YALns8Jp9lqpV7boH25wgDu5Vk/w1GS4jyIrlqX0rmRDIRwTPJIUcapCy3cJFx6lUbcR9guCf1G+M7EmZic3RmtEE484wFUFWXSF17Mj5jDCA4HC1ReNZ+ztxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxbronCbhxb4BbfC3zpVY4YM/Rg8yQ/pGseNd7H4I10=;
 b=nk9I7PaH7ljJR6zVtKZmc87DUD7nDvRJRZqLl3xG9HQxmSoUpSXfk0xPszeTSuKRK8mO21tixIuNgJkyAzZHRlUBPmg1Gt2nHL04HThh+iZxVymC9JR13OEItdNFuOKR5KW/ERyFmbfs8swtszvPdskNuUV3p+zONBMOGv6VUg68iadVcQ54VZuG52U3cUje9l/6kLwx2hnSGa10jytCg5w2wE5HEDFcz5WAhS+nF/x27T0bfPESz4jEEsxTvKnBesOX6eUPez6GhxtEc+EzJEuOTWMM/BtEKhixFw6fW9N404wAJ1+YN3H+DYn/kXolO/Tpzzv9ym7vvmUhrIByXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxbronCbhxb4BbfC3zpVY4YM/Rg8yQ/pGseNd7H4I10=;
 b=yZI8+30R7ILx5yVHbO60NcNrtmxBGmVopTCjR6NGTrbacYk3RjcVHSDxApdVVaxlgRJij3W/aLMaGLsHNNumiaF9DY7Mo9RsYArEDro3WaSp7nFxvt0xLNGCODxm7HiPFznJhEg6c0do270GJ5ktSgtJecr9GCI0Fvni/fM6TFY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM3PPF8E7C782BE.namprd10.prod.outlook.com (2603:10b6:f:fc00::c35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Tue, 24 Jun
 2025 17:31:44 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 17:31:44 +0000
Message-ID: <b26e684c-1790-44dc-8191-7326fcb2c25a@oracle.com>
Date: Tue, 24 Jun 2025 23:01:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/cxlpmu: Fix allocation argument order and minor
 formatting issues
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: will@kernel.org, mark.rutland@arm.com, linux-cxl@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20250623184415.42751-1-alok.a.tiwari@oracle.com>
 <20250624153644.0000084f@huawei.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250624153644.0000084f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0047.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::10) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM3PPF8E7C782BE:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fae59ec-6ecf-41a5-1238-08ddb344fccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2NMK3J4WTU1UWp4QUJWMUhQTU5IdHYrcjEwdnl0YUlJUXN6TUdWNWd2RTRI?=
 =?utf-8?B?MERBT2FTUkRCeTVCY29vSnhOelhBM3l4NGhmMXpXemNBNEw5Qk1GekV1WVcy?=
 =?utf-8?B?QS8rOHpLeXhMeGhoS0M1c3NSa082aDFEWFhLTkc0K0RjNG41ZXNPMERqanVR?=
 =?utf-8?B?ZFp4UEVaR21DcERWdW5BcVUxT2FNYklvb1BLNkJTY2RIUUE5Nm5MdW5zSFIz?=
 =?utf-8?B?akloNTFPNkxHaDZDc3dDb2ZjMTMwSGNDclJseGpxdkYvRnRmSytpUE9zd0ZI?=
 =?utf-8?B?ME5uOW4ySStqOXFyYzlQalB1c0FvbGloT3hOdGsxNFpXbFVYWG4yVVJnZzNV?=
 =?utf-8?B?cnNPTWQ5RmFwdEpjMjFwMmZtMXdCdjdLY2ZjMDZxRGl2bFR0aHBtZTZsaUtM?=
 =?utf-8?B?QXlTalorcFJoMXVNZjBuOUR0elMwMVUyWXp5YzdFaEhzb0pKN2FkanRoOFZW?=
 =?utf-8?B?eVl2R1YrRjNrWDRmS2ZjdVB4RlptTUZFdHBjWjNqc0ZnU2hFTVhsTE50ZzM5?=
 =?utf-8?B?TkJHcUZLVXdremk4bTFzVXFYZlgwZERrWHg0VitNdldtRmYxVm5wY3NoTDIr?=
 =?utf-8?B?bHRWZXN0b3kwWjRRRUlGR0hjMy83dVZvQVhBcEhCYlI4OGI0MEI4bGFsS0FP?=
 =?utf-8?B?YWxGREtkNEtqaDBGWXdrRERISi9TdmNtWU1yRTNHTGFFbGVCNE92elBBNzJy?=
 =?utf-8?B?NkVmV0hyZzRhdUZxR3RGZDZ0QVBLK1l6ZFNDbmdiSHR2R3hIRWZHM3IzSjUr?=
 =?utf-8?B?bUM0d3BTZ2VXZVlKL3ZscmhQaHQ3U2pXRHU0SCtpblRPUVZSSkhyMHN5UnVH?=
 =?utf-8?B?T1gwU3c0V0ZLc2kyTGZZUWpnYU1CS0NRaEJ2TFFDbXU4a0F3eENRMHRCMnlJ?=
 =?utf-8?B?WGxCUStGV0VML2lzWWxLalpXTHZBU0p1TGtxK3pQa0ZtZUUxS0w5OG1UY0dJ?=
 =?utf-8?B?TXRlSHBHOGk1N3ZWR01uV2l4Z2k3dVZLbEJlNEtEQ2d3SzNob1NTMmFCMG5M?=
 =?utf-8?B?RFg4Z3RwVmhCTmFPWUZqcm4yMlNaejNweklSZ0hzQnNweHJXeWdua2tyaEV2?=
 =?utf-8?B?dEhRRWs4OFpNVXNLKy9UK0VydXQ5aDMvdHdoVEdiR05BSzJxRXg4SVRBYWxN?=
 =?utf-8?B?MTdLWjdhaWxXcTRhejk0Vlh2Rk04WXB6ZWtoNk55Y0NjWGlEV2FtL0xDK2Q2?=
 =?utf-8?B?VCtLTGtyYS90MXIrdzlyenlyTlpRa053Vlo0WkdpV3FsL2xhZ2JpcFg4UmFX?=
 =?utf-8?B?b3RVZFFXUnpieEJrY1NkRFR0d1dtR3c4V2FPTlN3UE0zMVNNS1ZkZ0NKUFk5?=
 =?utf-8?B?ajBkclZ3MGl5WXN6d2lGOURMN1VvRlNkRFJTMnQ5cFREZS9PUUM1MFpoSDdT?=
 =?utf-8?B?ckI3QmV4VEtiUGVHbnFSRnVGTWdkcmZ4ZGp2ZG9SZ2ZrMlNIcVpVeVd5VGls?=
 =?utf-8?B?UWNQKzRqbU5DRXJlSXREWFNyYTdnOXM3Y2lQdC9Mc2Z4U0lPclVGS1dKVHla?=
 =?utf-8?B?NjlQRExsNWhwTWR3ZVBkWGdmRWltdmhwa0xHMkJnaFhTUjZlUmZXcldDa2Jw?=
 =?utf-8?B?R3dRUzd0RTljd1UzVzA5UmgwdEV5YW5aSVAwcU5hY1lKdnFDMzFsLytkeFZP?=
 =?utf-8?B?Ty9McTJSeXVMV05ncnBJVGZkY1JGR0FBdXJVdks4SkJLdEUyQStjSTFwYzh5?=
 =?utf-8?B?Nkt6ZlU3UTlhcnhMOXFPbVVVdm9SbjRQamhlYkIvYTBNRjBpbEdSaEI3YmpR?=
 =?utf-8?B?MDlBYkhRMGJLcTFPS2Q0L2lFLzJyM3ByK1RUTzZHcTJaUzA4bXRLbXpyVzZl?=
 =?utf-8?B?TVJiSXo0cWtFbjd4ejBHeEFWK0JxL25qR2FmenI3bkkxWC9Qd1Y3V3k3UjJh?=
 =?utf-8?B?b1ZvSE12ajh5eXVMZ2dYZkUzS21JeHlkWUtad2hrMlNDbU1GUExPcVRXYXRy?=
 =?utf-8?Q?RStRXgkzBLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXVRNUtyUnBqZlNjTGNIY3B3NkJiakFCNlYyMVhLQTRMYXRIZWFDVXJaYkVR?=
 =?utf-8?B?TFYvb05DaFNRVzVpeGxmZUMrWDNKeWVZVVhOVFFKenFQQU9yUFN2VnJJTG5k?=
 =?utf-8?B?K2J6bEtMT2E0SEtFRFowNXYxZ2w0RTBjSVFLVjkvMlowVTNpK1M1dFlXdFhx?=
 =?utf-8?B?SzA1cTNzT08zNkNML2plc0MvWXQ4YTk3WW03MStaYnNreWJiRzI5QXZZQkRT?=
 =?utf-8?B?VmVoNWlmZG0yMmVOd09STFRHMUV4ZWd1SWNVbWpuVzFHc0t4ZEhHSEdqeDlN?=
 =?utf-8?B?S1NhM3c0YldHL0pKc25nS1lCdXpvM2graVQxMXpsd1ptYnJVSmJyNWxzWUp2?=
 =?utf-8?B?WFZkemN4U2Z6a0x1a3ZsZTJwU0l3bXhHNElJZVFzZ1RrdmV0Y2hzMW83Nldk?=
 =?utf-8?B?dFBRRDh3Z253NkFBVXlrdWRYbmgxN2d4VnhSMHRNL0NNVm5VQkJsTUNOaEl1?=
 =?utf-8?B?ZlRoeXRkeHlYZmk0T3hzaC9ybHVGRWRveEo2aEVnWUdzdUNjTUZDVzNldHlT?=
 =?utf-8?B?ZnJvRjRMS3BEQXppay8zSUk3RXl6RFZUQUh4cUt6TTl5SFIvTlR0cThvdCt2?=
 =?utf-8?B?U3h5NE01eHB3Z3h3dk5lcUQxbWNvTHlyeFkzV0JxUnVqSHcwUnpjVGNBd3Ri?=
 =?utf-8?B?Y0VtTGN3Mk5Va1ZCUXRTN1ArY3dNNVhIaFJtTCsxZHhoL3YrSERRdVY0L2Ry?=
 =?utf-8?B?WEpqaXRmalFmbnFVQzZYL0Zodm5FK3VMQUxrZ1BRd3QyVEVXc3djb0paWktP?=
 =?utf-8?B?dHZVaXM2SzlGQm1uV2hOSDM1djR0ZTd3SW41R0ptTmx2YkpEdzFYNDIxMFdN?=
 =?utf-8?B?czdnVHhCQXpWRGVqN2g1VHduSVZKOHhaRktZczAwdGVkaWZIQXB6SFpibHJu?=
 =?utf-8?B?cXRsZ1ZWMWpxM2hqMXlHTVM5WGZpazJEMzlzdkNTNzNMd21WUHMydHVjT1Uw?=
 =?utf-8?B?aVQwYmMyM1U4MUN0VkVzbThXR0FkYVpqakgzaHg1dWJDczhXM2JLRTRkUE1m?=
 =?utf-8?B?OExobzl2WFdCODZiNlMzUHlVRi9iek9lUm1OT01LaUZ4WEdEZlcvSEN2YkYy?=
 =?utf-8?B?RXNsN3YydGVnbjBYaXZPZktiajYzNUh1ckVuV05LZSswVFhGWmdEV0ZraWhY?=
 =?utf-8?B?Um91T0RlMUlHM1QxSVNWV0gwOWZTdUhBcXZMY2l1MHRwdXZRTld3cDd5NnlG?=
 =?utf-8?B?Q1R1QzZBYkJmVHZ0SzUweHhRRy93Z3FlcGVZd0NBeXN5QklTcDgrTWhqajZv?=
 =?utf-8?B?cHRNYThHM2FERGJIRjB2Zy8yWlZkNmxNRFhqZncrTFd3Q016U2ZDdHNuSG1m?=
 =?utf-8?B?aVFCSzNuQVdSTXFraFViQUFKMGQyaXIyditndUd0NjBOeHc3SXBkM0U5TFJD?=
 =?utf-8?B?ZFdsWDFZMi96MFZPT3Bma1U3WUtmWjFEckVOYk16UVFXQ3E0YlFBRXlQOHNr?=
 =?utf-8?B?Zm1HRDNPc2ZlS3pqSjVwWnVHeHVzQVprai9BSjY3aXVtZEcyMG5GZXF4RE9l?=
 =?utf-8?B?ckpJcW9SN1Fjb05IbmIzM2gyUFpSem1icW9DUWtGdHJTWDF0RzhxUlVRK2R2?=
 =?utf-8?B?ZjhCVkI1R2UvcW51ZktiUE5oN051Z0dhM053QVVhSVVqT0o3b1p1MWVoWlhs?=
 =?utf-8?B?MFJ1Z3pkaktlZ3c1MlFhQXRPYk4welBrdUpkOUNJaXovbXFFaGl3cEpEeHZJ?=
 =?utf-8?B?cTFROXBjMUJBeGdVWjl2MVo3M0tZVkZ2U1Q5bGhTeEZTWS9ZdmhDR0IxNU9U?=
 =?utf-8?B?b0psTnd0c3hzTkdtNDNXYUJqWWhGZmRVcHFsMnhCTFp3Yk0xM3hzRWcyZXll?=
 =?utf-8?B?VENIcHFBbzlZdExZNkZjd3c5M2pkSmllMUw5VTZiUW5FUll0R1VXMSt1N0ZM?=
 =?utf-8?B?dCtsZUlYelB4cFR1RS9wTFNNWW1YUFcxaFBxQ3FXYzlBbkszL0JSOCttcjN3?=
 =?utf-8?B?QkRrOE5LR1FJVWY1UlB6VGtnbVc1UVZJSC9XZkF0MHdjYlhyeGdacmdIem16?=
 =?utf-8?B?cWxtMUJ1RVl1OXVLUzArTVk0S05wNkhrMjdNZFVvTEo3aDVQK2hHQ0Zsd3FX?=
 =?utf-8?B?UHpyODhMa3BCOWY1ZzJhcFl5eXlVbkRobW1IdnhWUFhsZUloZWJURTJmYnF3?=
 =?utf-8?B?dWtLeUg5THJUcldrOG1zVkc2NXExdURLREdSdy9GdE9wT0hwQ3V0WFVJQ01n?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sW860URFThjWIsLk2EPzAF7WzSB9IRHlt7itYi1hnWMJdUZuUFDpzh7jvxz1ub2m2p5Klb0aOfvrGX7iHe/nuUzxI4wOM3hzPo4v0w47YDItDWQpoRy/kgmzooaAd1f9dnHTGATziIyWN8wE+sGLqTtZh6XVGO0g236fMB1pbGElFrRorinouFrlI/TWGJ1yDBO0mA5jtPgr7B/PagncyRuilpP4JEAiQppQBPZPS1hKx1RAMhE5/aq1ugBbDdkPK6ZV9kbagclq40dCrloRG5TvG7ZHGLSvQxQW4D/K/jCnbCBXIUpjj9125WGYRsx2vz4XoxU5hNj5h9mBRrJ4EEZoKe+BOdjNWOduZRVJ0UMLMwfS8PVhuW4EJvrN6L2Wn7PSZX84jQLTKmLOInbzTtX69WlOdaQKPLBtcq0vfJy39RrXNEQom/R7l1Akdb+ozo7FOL5Q+DRUazhCCSgR3uIWTX2HFhTi+DUTsTUNrWVFI5tpaccpyks5eTB3skxfSm0BJOdf8XnBllU5wAKfW6x+HxksDmhxkMk0ciKtEjjKhcFGzf9we/Clfblyi/EQdKsZ1PcmqQDnhbgje7+vfu7Q7sTWnHTej0hYAd7y5TU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fae59ec-6ecf-41a5-1238-08ddb344fccd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 17:31:44.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6m0Dcep59G6Dw4EAGV/avR3twTF+PWW3yKYGzvrHSsVQqrtH/XYOq/5t/ZnzTaHDNkAbHfcOTzfDqULZHumZSh0uVfGlP5dvfZlZS2MYD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF8E7C782BE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240144
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=685ae104 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VhgT06YKVvx_5pnklIQA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13206
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE0NCBTYWx0ZWRfX/Ee6q7MWPBcN +wW8RevPUuzjbZeak3AUuL2Ov5s7/8igYinDb9/KRhPwrkTMXrBDdsPyIquPFaaXfxz3qGpwe1n fUui50zKK+raVW8JMk1Vj6K9NNv2fZ4CTc6bNEgAX4o8g/H8/OehRExuC9/+Y2HyrcGS9JxgnGE
 iYZQi5jsTVmNJ44aC5QsWkHZS8LtfRcbVh5aY1P4DfDaJGydEnrmNnjyf2tcqLqdw1aFMG+jUot +T1Mnmj56xhWRUsXxCHWwrya0K9yIikXr8B2wKBUbN15fMBmDaX1ItDmA/iT2sbI+lAP1lb/rOk iQkRDk8jAtsEw7g8OPxYbkXdESNL81/WbvMaRz3XH6kzUQQnDzswE9sdURLasqVFKA+P7kWMnH6
 lfmJoQqIFeHQd4qrzSTLHzcngGs6k1gmQkRAYOtMT2yOKcZb8qEiRvM8FWvmPqTsyoo8JtYU
X-Proofpoint-GUID: 8w3RzyituSmydBuHpbYaPFQpwP8gK3IL
X-Proofpoint-ORIG-GUID: 8w3RzyituSmydBuHpbYaPFQpwP8gK3IL



On 6/24/2025 8:06 PM, Jonathan Cameron wrote:
>> Correct the argument order in devm_kcalloc() to follow the conventional
>> count, size form to avoid any confusion or bugs.
>> Also fix a formatting issue in the devm_kasprintf() call by removing a
>> stray newline and fix a duplicated word in a comment.
>>
>> Signed-off-by: Alok Tiwari<alok.a.tiwari@oracle.com>
> Hi Alok,
> 
> This is a bit of an 'and' patch which usually means it should
> be split up.  The devm_kcalloc() is a fix (sort of anyway)
> which the others changes aren't.
> 
> All the actual changes are good, I'd just prefer this as a little series
> of patches that do one thing each.  The first being the devm_kcalloc()
> parameter ordering.
> 
> Thanks,
> 
> Jonathan


Thanks a lot Jonathan. I will send patch series


Thanks
Alok
