Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939C61BC58;
	Thu, 30 May 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100844; cv=fail; b=NYZEyHw0RO6/lBSv8NiJNYe9VcWx6O7DIthuLJxeqAHf7WeFsFC9xG1j+P71+jNhPPgg0w4tgymwFiSWuWjGYB8LBHCVm24eb+71afldZnWfBJkrEYpsZQpF0rBDeYdS9JltYn6vdeLmmTWMpVGTsZbnlM/Kf/aLIF+P7vOAF3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100844; c=relaxed/simple;
	bh=MRKz05E2x83HOykb0eiSzIoDTeQSXOnFrPkm6AoQMQY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ghi41keWb3zOEAeNjgu2z9OwzZscK6Q4XZWceKWpaLrCQ1HeLVqfEdEaOxxV6Ssi0dSky1qpnaezedsB6eB4p7b74yJRxCsqHYaHs7HDYjJOK4gJKgM8aDEXUJ5V1xKXaYEe7/K/d0rnNd4140zcfsMSPAfstZbtW/CFWcDy6r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UF5Uhd006377;
	Thu, 30 May 2024 20:26:51 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DZlMTT+9HjSzONIX8Npo4w+NzJef/Yxjcv20DiU3eTrE=3D;_b?=
 =?UTF-8?Q?=3DIbBBf7Np72LVh0E3z1Esr1zNfDNdGTe3S8NF4VceVU5k8PwbBsCWfH4lyMYx?=
 =?UTF-8?Q?g731WL9y_LayyQhBJQIJpfUGoLVIjZDjEp3KqmUg+MTYp78Q0HXB18Jb8I/GfDr?=
 =?UTF-8?Q?+12aln2jQGqMmJ_d7lAdi6roOGpfRVyve3fA7+1djh8mzuQ+LiU4rRGamkjzOxu?=
 =?UTF-8?Q?PVzH3izJYJVtRb6pa0sQ_BXNRvBIkawVArzEhgYHQ5HlyErODCo9wbATrapEshJ?=
 =?UTF-8?Q?5vQnLEVifDjoBCN9ENagSUPTQM_DRTGGrjPO/AfGsoLFKUjSX7Tez56I44Ypryt?=
 =?UTF-8?Q?RwFsybBl/HrB6R/0qot0b/IBQDfbsgre_UQ=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7ssuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 20:26:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UJfw6c006205;
	Thu, 30 May 2024 20:26:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c7fymr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 20:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBtTNAXVDrdArW6nSsoeAtkexTQns9z46BfGU7hAGSpV8rk2JFfNcs3poPbu6G3Vp1r5k3PSOVaiggI7nhozcT8GB6xBdJI/N19ll3pv0VpAifoBygE7bizy4bhZL2AuOjoaBvFtVvd8NFNfZxOIBPgCUGW5WkQNJ8qacuyUIx1KaiwqEXbSP69z0sBefz3jVC/YOOon5P4Z06srtxguqPvAx4TUp/HCVeJ60qKXLJ9MD32uHRfAlFylVI1GN5fis/13Q0HblJkvr54TmCJloI+eij5RRuk3eAQ1WXkzQw6iIPAXLzlyo7rQRBfNPahj1ktG8SP8JFEdq5QJgBflfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlMTT+9HjSzONIX8Npo4w+NzJef/Yxjcv20DiU3eTrE=;
 b=FXPxy7U8HYKPZ84Wj900kUt0rKY81AEXMy9RhXgPbzfvsHlkgo8xr1ExlnV62QGBKbEAjsYIHH7f11P0gfeScohrPe0jGgsDdhu2AHT/yL7ObCzI/DxRlvZZDL+XI1uSqPtSRxuE01zezjnl2JZYJAh4nnhO0nE4k+IGVgsiVMZzvC08bA/5vOtVjstvqiG2TSCU0ObMj7DG+HS/B/B9H19h7nep5w5BsPdfEJpFHBEFdWECspMw127lisxQpvyj9csPX75QeDNLsN4ox//zxEpoeVBvqdhzXsPTHBUc8GWmFTDHn4Cc2xhiV8isQio6sx1o83PgqyJ0sew9uztmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlMTT+9HjSzONIX8Npo4w+NzJef/Yxjcv20DiU3eTrE=;
 b=qgKXcpM3UCk2N72LJoT3ZK1CScDRmJymTPu8wgJ4MCMHNSB6Sam4Hs0I3nZKXpggJeXUE5nHSlo19y2U9IE1Z+syJdKMombiyh37PMNPp1G5BgTJnHSzG5kHL7vek8dBaFHSnHF0yN1DM6tOKzIbDr1KwNM6utqqBU5t36shXQo=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by DM4PR10MB7427.namprd10.prod.outlook.com (2603:10b6:8:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 20:26:47 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83%5]) with mapi id 15.20.7611.034; Thu, 30 May 2024
 20:26:46 +0000
Message-ID: <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
Date: Thu, 30 May 2024 16:26:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
Content-Language: en-US
From: George Kennedy <george.kennedy@oracle.com>
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
Organization: Oracle Corporation
In-Reply-To: <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|DM4PR10MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 758e2657-e917-4e8e-2e94-08dc80e6d402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bGF5Z0VQVVE3dGR1ZnhvMW4wQkxQdk02ZmY0UlFoRVA4S2M0RElRYnlMVWZ4?=
 =?utf-8?B?OTRVeHdtM1gzVXp1bXJGRWJhU3h6MFlXeGFVTG9SY1hGQjROL2hFRDFMbXVh?=
 =?utf-8?B?SlJzd0lOR05zWGpweVdqYjZYeFh5RmhVSkFaWWtNemVkTWJSV1NidEkvVWsy?=
 =?utf-8?B?MnZXY0g1SXNpRUVmZm5Ub1l1aElKdDZXcHZueTV5K1EwWWhPQnpLTUtmeFQx?=
 =?utf-8?B?Vm1HZSsvOVhaS0R0NEpwMi9uSEZBendIYWRqSEw3MmFYWjMvZjRIOXJ1WUg0?=
 =?utf-8?B?dzh0VnFSWTJnOTlBN1N6eTNUNjVvakdqVVFySkhOdWZ3T3VlTW14UldEZU84?=
 =?utf-8?B?eHFHZlpJYmRLbUg0UFdXOVRSVHhmMmJ4cVVwZ1NHSEhzOHVEMXhBOHoxUHh6?=
 =?utf-8?B?QzNiN3RZQzMxaTZ2V1FmUndQeDhWSWFHTEtjeWZ1MzlzM3czUE00MjQrVUF0?=
 =?utf-8?B?UndXQzZYa202Z2hiZVBrczV2enJiTXVnOXFseTVzQmZ6TkllRUdQQ0hEdmNv?=
 =?utf-8?B?R1A0VmxFN0pUeDE3MjZacE80QlR6MTJhMklocGVmMEhGSTNXeVU0cGxiZXMz?=
 =?utf-8?B?bDZUOU9meHJ3NE54M0lJVkx6dkkyL0lBVDBoQkdPV05iYUc0dkZRV2orVDYw?=
 =?utf-8?B?bERVU0xwK3pxVklkODJ2Vm9QVXhFTjZPd1ZyWkhDUzNZTDJUYW9OWWFOY3RT?=
 =?utf-8?B?cUdoUElPUlM3azd3K0M1Q3Y3UzRvaWpRWnVWZHhGdEMrS3ZhWWVFSU5Gb3F2?=
 =?utf-8?B?Sy9xSWZtSktBd2pFN2ViZ0V1dit4SEZ6bnYydStZQmJXVW1TakFmRlNrY2pN?=
 =?utf-8?B?S0JrbUxOcnZPUFNQWlpESC9idlpLcXFzWkM0Y2kvTXlNMko4eTF6RVJwa2hl?=
 =?utf-8?B?MnJ1dHIvb1hnUG5NaXo2SlRmeEFEQU8yOGpYZGJ5N3hWN3lFSUtVZVR1dHp3?=
 =?utf-8?B?ejBnVmVhSzJCNmJYQ1lSWmFhVEc1RkIwL0NZQ2NyUVowVUxRZkYrUGZhVVpp?=
 =?utf-8?B?cXNtaWgyaXJtNUU0M3ExOTZ0VTlqejE1amhvM3pNSGsybFZyZTBQTWxtR0tE?=
 =?utf-8?B?dEhKK1RQQ0VkaERGUFliSGwvTnN3L0thUzhqdUc1dlJMdVpRYlhzQStRWlpu?=
 =?utf-8?B?TUQzaWJzcndwUjViQ2VBTHFGZUUwUSszQW5jUlFOMExGalpNaEdqR0Rya1lm?=
 =?utf-8?B?Ukt2RlpvUitmVXdKM1lxRFVSNzRBN2F1RnBvZHhUYjBJdGhWOUtVMFhXZnoy?=
 =?utf-8?B?enhUL3NvM3N3cS9uSHNKT1c0Vm5wQ09aM2s1aDFIaTJndGdEcHFBVkZDTFk5?=
 =?utf-8?B?aE5YZk5EYk1JZG5NSW45Q0Fpd1dzdjVwVGxjZms3RTdVS2RQbWp3ODNiTmFa?=
 =?utf-8?B?UGVnRXcvazZ1Q3Y1TXVoYUlpejdBMU1tNlFVTmdVVjEvMnJyUVJXby9jWTBz?=
 =?utf-8?B?QW1jWUZDa002SUxxMVNwRHVzbWFOaitDSDMrK1kyVTNaczNEWEZKZ2oyMzF1?=
 =?utf-8?B?Sm8wN0k3U1hvcTh0elFjYnRuM1llZjh3Zk9UYVp2Rk5VQkphbEZ4R1hRcW0z?=
 =?utf-8?B?THREWG1qb2l6U25qTE5PcG5pNiszdkVDU2RmK25DNCtuV3l2ODV1Tzk2Y1ox?=
 =?utf-8?Q?O3L9pqS07ErBaFmF9mbATqSEs8gb8E+eRutAE1QMDWyI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VEQrbStrNEpFNGRpdnRYSHRNM1llSjNua2JVTFoxVHdqdkhQcFJhT01qVXBv?=
 =?utf-8?B?eFJENnhwSk04S0dIdWJFazlyMHpSbHVnMXdOdHpNZ2l2UFVCVXluWUdwMnRK?=
 =?utf-8?B?VEFRcGFQc1MrcW1CMy96dHd6WVBsUCtVQndiWDl4d2plQkdqcXVjYkZzU2pt?=
 =?utf-8?B?MmdtOE9GYjJUM3hjRnAvdkI4dS9FcnBDNzNFQXppWWdia1hEOWhmNHVDMmsx?=
 =?utf-8?B?SWtsTXIrb0syMkJUaGRYT2FWTFNmRWZOYVE1VmVkdEx4QmNpVFJXM04rZzdV?=
 =?utf-8?B?eDd3VVJWN2JvUEFZblJTVDZZNTdLNit1amZUZ1hBekRHVmZWWlFTT3hSUys0?=
 =?utf-8?B?aFFNSGFsNFl3dXVaOVUwbnBKeXBrTU1JR25rWG16bWd3b3Q1c0ZLaXBZMG51?=
 =?utf-8?B?NVIxRTNHR1dWM1dCcnB3TVhERU1JS05HTjFMR2xKY3V0bTVkNWphNVFYbmta?=
 =?utf-8?B?bWhEWndWMWNaN0pkZ0Y2TWF5dCtrenhBL1VodXpNMjV0RjBQeFB4MDhiZ21r?=
 =?utf-8?B?Nm1NZlVUd2ZudGk5SDNoVTFGZ0NiZTQvR0JncHJxaWIrRXhkVHluMzFTZ1lK?=
 =?utf-8?B?NjdoRmJBdnNFOGZ3VnJmYnRXWndqTXU5emo4LzBOMDNYSWdTaGZ6Z0R3dVcv?=
 =?utf-8?B?VzBQUGI3cytTdDBwYXQzeFRmTVNVaUJ4eDdDMnFWUVdlTmNsQnBlVno1N3hp?=
 =?utf-8?B?MjlUY2c5Y0ZyNnA5SUhjS055Q3E2T01UUHB0ZDNmNVV5anlpbjZwcktZc1Vw?=
 =?utf-8?B?RmRSRkxRbXMyR1pMN0FtSlJXZmRJSmlXRUJGRFpXYXVtanVLR3NreVBZeE92?=
 =?utf-8?B?bllhRi90citoMFNEQ1owNElZYmIyUTBMdVVjNUsxTGo1NGI1TDNmL2cwT0RL?=
 =?utf-8?B?NVM4dFpYRS9kaGdoUVB0RWtIN09UUVYyRWQ1SzVwSzd0VnJZaTNuanIyeDRq?=
 =?utf-8?B?MUNQd0VMK29qZG1DMGVoZjdzRCtuM240bC9iSGNpa2hXR1Y0cnpSSm95dEZp?=
 =?utf-8?B?MnNZaUozR0VTZmlDU0xyZ2FqdmJmUXhqMlF3cXJsa1BCR2NNV1dOYW5IY0ls?=
 =?utf-8?B?U1RlUklyTVpLSHc1RmYyR3U2dk9rWGxnYjBjVnowelBoWEI1WFhyNXVzaUtL?=
 =?utf-8?B?MThHU1RkQ3V4VWlLSDVzaVgwTGFrdVhCMFIrYngwbWdxN0lIVG1VclpTR1o0?=
 =?utf-8?B?YjlZRXFqWkxvUHh0R0RSckpPYUpwV0NqdkxwUVdUZW5EQW8xNENQaWN0RTdK?=
 =?utf-8?B?YzRXNHc0TjhyUjlrQWpacUFDdEx6OHFZOXFDWFdDWE96Q2VRTS9TLzlzb1Vw?=
 =?utf-8?B?RTRJWUhHRHZlbTd0OXpuQmVXazhuY2xRcUFsMVZNaDJnUVl6dzBhM09DdDIx?=
 =?utf-8?B?SUxJeThHOWdGYjhwMjRnR2dqeTczejFyK1p2UnduaXpTT2lmcjNLOVN0WC9p?=
 =?utf-8?B?YkxodFdRaWViMjRMQjIxeGpKb2RDNlNMQlJXZHVDK2doTnQzUytZbCtLSmxG?=
 =?utf-8?B?a0VKRDMwVitSYVVxUzhoaFlRTGtwQ1lwMm4zTFZyaWNVTnE5dzFVZjlpcVJC?=
 =?utf-8?B?dEFzUTc1TTFwODlveUZJL3lyS2xLTlVjaUU5WGVsTzlGMzJ2T0trK1VreG1j?=
 =?utf-8?B?cWFJQ1BLNldWQm1pbWdjVjZ0WXVkRXBtajVCREJCMkRLVU9qeDcrSWtkbENM?=
 =?utf-8?B?M3NLanprM2NyUWdkd1lBUExFVHA2RkhTK2tiNmhxblZXdkF0R21GU2lWMGh4?=
 =?utf-8?B?VjhXbUhBOXJOK0YrdjZ0d3VKS1UzTmNLcUVBNmtLSXdoREJmcGw3anhrRDJj?=
 =?utf-8?B?dkRtSVJsdEtQTHhRN1hwWmtzY0VCanN5KzZPWDNCQVdhMW1nenRLUFM3TGM5?=
 =?utf-8?B?M0xOVXB4cExDNVdtdXNzaFhvS2ErdVczcVRkcFM1UlBZWWhBTUlHMnE0d1JT?=
 =?utf-8?B?bnd4eEF3eHloeHozU0tjdGdXcEp4cjFFeFg1cUNmM3RmVTJJMjBUUXgrRG51?=
 =?utf-8?B?a2xkOVlzL29VQTRHUGs4d1pJdWJkeHBFNS96Yk1PYjlFZXRKdDkzOUVJbHJh?=
 =?utf-8?B?cFVlakpHQXRBcGhCd085dzdBdm1wSkdjS0tBQ3BXL3N4a3Buc2hQVUF2am1s?=
 =?utf-8?B?QzQxcEk4QTdjdnNGT3NhQWRWbjRlZHpETWJLaEVCL1NUV05SZTZkUDVCNXVu?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YMUu2n1EjqOhOeRu8sBlvhCwip0ZEpZaF2Vx7FOG2mNqyKmZK876zUrEFEp9POeRZ4T1QFFra1LE5po/Vypls9HbGRzlFIcm20BhtkaEq2RzMNy43lb/2onJ0JS0UEQrUmpetW9tA7ZMIX3t03Pp7PNatexAdy+Y/CiQL2OjmfANm3Xs/+tUOzUHiC2BIyE1mwjbgTeDPTgZuisJV//5VlFie/ESdu/UhVTup3YYPlDkRQJSVDVBLQJvkMkrnSkFi0usQlFFyQnU8vHnmOTsOVBwulG3fzqz5S8t2loMjY7Xm8c4jKrq2Jnz9iHc9yOG1pEIAtNh9oVlZPspoTYL2yjquKOcJ08HrFidaxDYm98RYFLLhFD+GSh1BDPlrAqsphYimnqfE4WyWGN2pZfk/c6O2MJ8GiuabOQNCb5rA3gsvzi1FA6vauKo5467ZM6bc5zZ2HhXRKAMbI8/2Zl2MkZ3PVys0MVcbdx3Yzv1adhnjqqqgVC+wLnpll8cuPDm1XRPFPTPSpnUQB7kZGNkq/tnolqtxUNvH0rbrlNW2+X/ADJ01HOeKacKLGA74od+SBVv6u43NlwZ1fKZqYYmvggtQ2naUZ8NP5c+ujAuRZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758e2657-e917-4e8e-2e94-08dc80e6d402
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 20:26:46.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+HQy2kVhu5haOKgsp82gxTlh8WSv1buj9C95Mg0WrEo2ABwuRIrDADcw7WYb9TRPxlQl9F8QfhfsQ6Qnr7hSTFTGAZ0OPlxcaKL0V/nSMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300152
X-Proofpoint-ORIG-GUID: F2yVQv4tgvZKZL6apSsuTctbO5E6l6Ar
X-Proofpoint-GUID: F2yVQv4tgvZKZL6apSsuTctbO5E6l6Ar

Hi Ravi,

On 5/30/2024 2:30 PM, George Kennedy wrote:
> Hi Ravi,
>
> On 5/29/2024 11:37 PM, Ravi Bangoria wrote:
>> Hi George,
>>
>>> Events can be deleted and the entry can be NULL.
>> Can you please also explain "how".
> It looks like x86_pmu_stop() is clearing the bit in active_mask and 
> setting the events entry to NULL (and doing it in the correct order) 
> for the same events index that amd_pmu_enable_all() is trying to enable.
>>
>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid 
>>> a GPF.
>>> This appears to be an AMD only issue.
>>>
>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>> Can you please provide a bug report link? Also, any reproducer?
> The Syzkaller reproducer can be found in this link:
> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u 
>
>>
>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>           if (!test_bit(idx, cpuc->active_mask))
>>>               continue;
>>>   -        amd_pmu_enable_event(cpuc->events[idx]);
>>> +        if (cpuc->events[idx])
>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>> before amd_pmu_enable_event(cpuc->events[idx])?
> Good question, but the crash has not reproduced with the proposed fix 
> in hours of testing. It usually reproduces within minutes without the 
> fix.

Also, a similar fix is done in __intel_pmu_enable_all() in 
arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
See: 
https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256

>
> Thank you,
> George
>>
>> Thanks,
>> Ravi
>

