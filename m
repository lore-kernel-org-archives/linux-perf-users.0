Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4672E657;
	Thu, 30 May 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093855; cv=fail; b=qyXmfQZ5i/Swp5eFe4qjNqDCEiUrRFU7n9UwofgkbyaxgKltPF1OtuaJav/uDFo7G1MAxoSBdK79bkT/JO705gzW7FGlpXwM+ZOrRobyJJEKqoaro8jTxC5u4DIGvyIzVCUzpOGTBEK8xj6AlPbylbv6yXLjvz4hj4EhuxtY9/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093855; c=relaxed/simple;
	bh=vMiN6ISUrx5VegnQowRLy5Xs54yNYIGRyYg18345NKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eVNOt/p6OScd5g+zYrn3SE6FmZ5jc+EfmlIaldg4wkClxoGifCqmMbsN7HT9jskCunuPZ9HjW7uPUZTZtAjkhfLHqQ3ongAsE41lGsCBTH7uDMu5ODA2oWDJgNAxPA9J9z7o7PDD2PANW64E9LKU7kxjiSseO1CT1CtMwnUTrZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFVBJ2018561;
	Thu, 30 May 2024 18:30:14 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Dun257DPVLJQl1EWmbHxTr1jzkn8OdaNYn+Px2+DvV9M=3D;_b?=
 =?UTF-8?Q?=3DBLHRHHHwx79Pss72Y4nHAw1J4GBShBI6wtYhOIt5kC9l1mbGYzBx+z68wfjW?=
 =?UTF-8?Q?MPJI8PW7_HOcRJoWcYOHArq7dBgXsAmokzkzSyEKZFm4uhY4wo9jExhQvquJ3qg?=
 =?UTF-8?Q?JLTRvcYh+cJnu8_cN7ILrQCxPmSn2W3S+102DgpcQNZBy6JTiwYCAwVq/4Z1g6w?=
 =?UTF-8?Q?yEKis7XcPX6HG7BWx0NF_LMx77ebuZ8bUwjEOzjfx8+yL0DLPevFjSkrAH117dC?=
 =?UTF-8?Q?77TPWTaQ9OLr3qKj+JAonwr82z_EIeRgeAsW1iEUz36xRgocjN+m384Nvk7gZoG?=
 =?UTF-8?Q?XEWHGvL2WkZFiWF44IxQxZEVisaOozBw_cw=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j89jr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 18:30:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UH2SWp016238;
	Thu, 30 May 2024 18:30:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50swkrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 18:30:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU0F+YmHSID9p5hK9dJAm7vCt8uzhI4qUZQ/O6JHhNMAkqAcUMBNXjJo6LCFc8wkA6yAOeUCH4rnZV0sAXw+BLNiyAIywdRo4WAgtCfSjw4hY3oG7qRB3WAQtWhHx+tYAwByxY2LvCSvrd59aIC/aQgsg6xXG8yIazBvkytjSjixcpWqlUwbHMeLuKNcUIe2/njyOX93ZHYpinPv/0+JHwzf/uBAGXGZkq4IM4D+Ag1Levc6CMsPVAQb7sgdKwCa42mKbmjFQB3NNnIi1eY9haok9fkvU5vMMbPtSpX9c8FTNlsjhDnmdcF2k80NPbzLVX/iOdQOXb01Ob3EVt0+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=un257DPVLJQl1EWmbHxTr1jzkn8OdaNYn+Px2+DvV9M=;
 b=J+KEtKSQmnQf+ifcdLvSjbm9etnFaczcJo3xRo2t5sWCxGgOzdHJPbQepmbj0nx3GAhWTSC4Tf8ADo3GzNLIo4UAK1mpwkQSdwbT9cQ6d3blLQxJO/J0HJnaFV01YzRfFlfFPr9rYbn2tbxe0t7xO2UBr8q842D55IZ+qVEDDuWSGwhfo8ltAzr01U7tAEppfRikcshdAWcieHNJIn/lQw4jUIHGi22v4EF9WJ1EDmyVJ/r1LRF7WE5Uj1jy93aFN3JcUe96Jp99BzJmxcgLstSg25pYW8Zjk6VQuho7/azTWmR5Uukws5OtbanCSBRqRnZmh5KFohVwb5Pnv7/neg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un257DPVLJQl1EWmbHxTr1jzkn8OdaNYn+Px2+DvV9M=;
 b=QhiwlSUI9DzwGf2iqeTLeVCLVkLiCA3pvt2EmHGvC0sGo8MWK7zTtfOvM1bm2LCHIEowYfgP3au9UI2ICuHs3TxTAQQdGbpVsNGkG5lOFpP8HP4treZGtImkvDgN3cCflGKGVxUs/FRXNDhxTSYa8CcpG7y7XtRnIocEkKAn4no=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by BY5PR10MB4340.namprd10.prod.outlook.com (2603:10b6:a03:210::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 18:30:10 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83%5]) with mapi id 15.20.7611.034; Thu, 30 May 2024
 18:30:10 +0000
Message-ID: <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
Date: Thu, 30 May 2024 14:30:04 -0400
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
Content-Language: en-US
From: George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::15) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|BY5PR10MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc2e276-a868-4696-bb55-08dc80d68979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q1VBSTZ6M1dCUDd1a3JnNFpHUFlFMUw0UFZHQjVvR29yR25sKy9zN2pFdU5M?=
 =?utf-8?B?a2R4aDN4YjRTbXdTajl6YUg2OTBRR2U5d3lKL0xERWFiWlNmWHRTaEN4UjA2?=
 =?utf-8?B?MURRNXQ3MWxYNXE4S2JhY0diakhHdzh5N2VhOVkvRVQwU2pKTTVYVmN4cFJu?=
 =?utf-8?B?Q1ZCY2ZxdGhJenJJcFNFRC9qZ3BNYjVNL0kxcVVodm1jQk1vNkUrcWNwQmJz?=
 =?utf-8?B?NktDMVZiTnQwMEpPUmNicjJZSWhJRTZJa3RxaDRzanFDbVdhZUlBSjYvalE4?=
 =?utf-8?B?dlU4eTByNjkzTE5taGt2eHkwM3k1UFR3TkkzK1M0bVNNZmd4RTBIQy80Uzd3?=
 =?utf-8?B?Ylp2SUQyajB3dnNIWGxpQnlIWXFtaEF3OHV0VVdTcDg2OW9abzYrZTZqc1ll?=
 =?utf-8?B?cnVrNGFQditycmt3aGRzRndVQkhwN3p5UVVwNnRDNS9uQzBMclBzNXdaMXZ0?=
 =?utf-8?B?bFIzelVQdlBJNVZmeFJicklNMDh5NDRkWXRKTUtaN3pZTE9YV1Z0RHpnUDA1?=
 =?utf-8?B?aE1rajlKcW1tRTAvUFZlMFltamd3V3AzaG53Q0ZpZWFNM2gyakxZdjcrRC9K?=
 =?utf-8?B?LzI3VlNmVzlWWEV0bVdzSWZKOUFOMjBiYlk4blV0R1h0cTRkVFZpL2pvL1RX?=
 =?utf-8?B?c010RldQRTUwWGxTckg2QnlLUHhKaVc5TWdUWVo0L0s4WDdQZXJaRFYzQ3lR?=
 =?utf-8?B?Q2syZUVaV0VMV0pxNDJzS3VQNlpZaGRwQmdmaXArQTduaE1WYTJ5cTd5S2JQ?=
 =?utf-8?B?UWxSSDJISnNHU205STFkQ09DQTVLRDlpWktEaWxLQ24zSmt1S3l2dUozR1h1?=
 =?utf-8?B?NGtGQ1pEYlVMOHg1eGlvVWRnVHlvMG1Zcmk3M01jYW9DYjU2bjZ0b0ludGo4?=
 =?utf-8?B?Y21STmFpcm5JTk13MkQ0Sy90cndzVHhiWHdjaGlVNTVrakFJNHcrU2o5MnJO?=
 =?utf-8?B?MklvdGNoM2YyTjJsa0JOejEyZDBadzlkQ0hoSFdzYjZ1ZTBuMHlTK0NESnFO?=
 =?utf-8?B?S0FhbVJlYTBZUGVmUi9hRk9XbGxNOGowWlQvdDNNRkVzSkFUWHhBUFpkeFhI?=
 =?utf-8?B?c25Cem4rSExkM2JJZmlmbGl4MzJCTmp5cXd2WnRtSmhjZS8wcGdZVCtKNGNl?=
 =?utf-8?B?SUtLR2V1d2poZ3RiWnQvM3ZVNGE2RjdaNU04VjQrTW1haytsdEZ5dlIxSStO?=
 =?utf-8?B?ZTlNYjBLbEJlbXc1cEVWU051dUtxVitrZEVXNU05Zmt3L3JMSnFjYjFOMDBW?=
 =?utf-8?B?TnNlUlFQbGZyUWhKdnRoLzVIWm5zenhKYzcweS9PTnhxMFE3RzdMbDhxNjBx?=
 =?utf-8?B?TEpJSUM3OE5kMXd2SVpIK3VOQ29KWlFsYW1teXFXckQ5TFdZYnB5L1Z5N2J5?=
 =?utf-8?B?VVVjRmNNV1J6SDVxYld0ZEV5SjRPNDdRL1dHYmE0WFcvNnZrV2IyYWprSkRK?=
 =?utf-8?B?eStRUWFKNThEQWIxaStHSnRCb1BhVTdYT3RIc0ZjdkVnMDJSTFErMmJWYTll?=
 =?utf-8?B?NHE5ejdiUE5UYzRQQWVna1lMQ3NsWi9OWC9JM3ZnUkFweDI3ejJac1ZiY2RP?=
 =?utf-8?B?RHpXczMwU3NTN0tsU3dhY1pMVVNuZ3ZaeGpzc3Rhd0tEc2hMeTIrWkNYdm5J?=
 =?utf-8?Q?GA/IUDGq+Xv7ZrlZRmpiUboJ0Mlx9kfA2R4r79R/F+BQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d0FPZ24zMGVVd29oSFRMcHRMdFdxMmlwclR6aHZPb1ExUWswSzdBRExMY2RK?=
 =?utf-8?B?U2gwa3ZHelNLR1dkVUREaFZkdlhWc2dpSmVpT1B2YnB1Z3NWclBBV2x2RUUr?=
 =?utf-8?B?MURxbUJFQTV1Y1l0MWVtbUdKaVFhYlJJR1VMY3A3eTBKY2Z6RTdFZldTOHZM?=
 =?utf-8?B?ekhhR1dxc25jRGZ2RDgwWTVWUzIvL3I3OC93SzhZYWlBWmFmOVZqT3pnZjJh?=
 =?utf-8?B?QnUzN3pLMWFWM24wSGhzTDRkYkl0d1VseUNHeWRNZHhMZkZTQlZGVDZSMXFC?=
 =?utf-8?B?RUJ5bjRYdmFuSlZHY1V3NEJlTXkvRVErUFFYVGlZOXlrbjd0WEVRTmpIT3hT?=
 =?utf-8?B?SWxldGV2Q3NQYloxOXhFU2U2MWZMSy9VSjl3Qmt2QVVyeU44SHlwZGVlblBG?=
 =?utf-8?B?UFlHYytMSCtCTmxUL0YrRWwyL0YzWjVQcmdjU3ZwZzZ4K0dxM2V0emZqT0JO?=
 =?utf-8?B?SnNOeGRlM0s3SmVPbUNRSUlHNUZ5RzMyN1hacUtVdm1qRnZwLzUrczEzNVB5?=
 =?utf-8?B?a1BleHJ0NzJ3UkcyVjFuWTJBMVNWUGNiR29INEtSU3dPVFc3YkI4NEVGVXpR?=
 =?utf-8?B?TE1GWmp3Q0ZJV21CS2NlZWlQMTdEaHpwNXk0NEltdEtwT1d2SERTV01HV2J1?=
 =?utf-8?B?WGFTZHR2K2JZRXhCaGd4QmNZNVUxNVhFbjh3allLVDg1d0dlSXdQaWNqelRl?=
 =?utf-8?B?eWhKbEpreHFLR1JoM05qSnJIOGZCRDVzdm13OEVzeTAvR0QxeE5vWDdyMktZ?=
 =?utf-8?B?WUxqT0dwaXpveFh3SnhzbkxiMnZFWHhTeFVMdldSSVJKWU0xd0k1YkkvbnRz?=
 =?utf-8?B?akhwMm1xTWczY1ZzUTU4Q3BQdFJwUnhTLzN5R3lsaGdRN3dkMWMrTVV3Q0lx?=
 =?utf-8?B?amgyT3VLS3hMcEFpVW1zTVcxWVhtTkJDQjJlcGJ5Ri9yOUVxM3JrSTZHZHNh?=
 =?utf-8?B?RXN4RkZOU01tcnBRTDBpeHkxUFNtMjExVUdocFRqejRzc2cyRUJjYjRPWVIv?=
 =?utf-8?B?MVhVcmtpaVVxSTdmcFFXcVV5eDVjaW9hMlpZUUkxNTNHN3Z3dUtNL0NXNllw?=
 =?utf-8?B?aGw3bndKdTRLSzJEMDJMdEVzUnA3VWczU3F1eWVyb3FnTFNUd0xjTUtNdWU4?=
 =?utf-8?B?Ulp0K3hYWFEwcUNBVDlzQlRUK1BKdjRlTGJtbUdOM0JjQ1lMWFJERUlwU0Vi?=
 =?utf-8?B?V0l2TllFZHgraU5XRTRqOGEzNk1IcDY2d2FXdjNwUk0vaGRhWGh4bGZOVlVr?=
 =?utf-8?B?VVZNSEYxbmRRZ2REcmlPOTJNVWZpOG5LOTRyMUV3OVlMR0dtM3RQMEhXZ3Np?=
 =?utf-8?B?dXE1RSt3MG91eXRPMTdwRVpWLytHbTdjNTcwM0hId0tHMjlKTnFSenF3Z0Q2?=
 =?utf-8?B?Nmk3ay9iVW1Ua1RIc3duVFFNaTVoQjlDWTdqeSs5dktOeVloOHlkamFXWFlS?=
 =?utf-8?B?ZGRyaTdxQ1FXWXczNXhDamx0bkhGZURsSDIwb1dUMitqYm54bFMyeFErUGdx?=
 =?utf-8?B?ZkRVMzEvVllIb3dGUjgzcFZpNitjVEtMN3lWdGRVNEhaV2g5bzR2WlF5TUVZ?=
 =?utf-8?B?dUg1aEJLOHBtQTU2QVhVb1JkajNiNG5hNTVRSXhsOWhETjBzdnhuYS9pVFVy?=
 =?utf-8?B?dmRhamUvUy9TVWowWng4cml1T0tIc0hCNmhueDVlTXJaZFFCeXdiRjVSN0No?=
 =?utf-8?B?czR6YVZJNGxTVHNFNHgrbmk1cGVZdFZ2THFZTDRMajkrYnA3RVNhK2JaUkh4?=
 =?utf-8?B?aVd6aytFZ2laRnpDZWJWS0FaU0M4dlVEMVN5NjdpRFN1aHJoTUd5VHZLUVJn?=
 =?utf-8?B?bUIwOEtSTnhxMXlpOFJQM2FpdjZHdDgwcXNKeFF1Mi8vUEROeXI4SFgvRG5h?=
 =?utf-8?B?ZnNHVklsZVI5dm9SZU4zSkRhNTZBRW9sanZPL2xISElvSzZKOVFWVzg0TTZx?=
 =?utf-8?B?YVRnV1RGVll3ZTZ0SXIxK3hGKzR3Uit6NU1oMk44MkZXYm85emdWV09VVS80?=
 =?utf-8?B?VzJibUZjKzcwR2dmdmdxemZOcnNoa2FvUGdDV09LbDUwYnNBNjZrYTBLOFBr?=
 =?utf-8?B?RXBSMDBNVyswUXhXS3dBMklXb0dzeWtDa3V1TUdKZWwvaDhZWnhUUUpqZ2hT?=
 =?utf-8?B?MjNBQytIQitvOUQyZVlmajRtYytnRWNoakVlcEVKNlQrQXpJYWdHaUs5Ritk?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	I4mio2J/KC+A9a/vbqOcommzTqM8Qe3+bkUoNWTHWpyL/4XuNyxof3+B8SHaHXvvMBT2ajcRAVRZvqa4++L17POyJZzPXbqNsVUzCTO6h7GQhjobk+a0QgyTFads2WepPMb/Ob0Q2U7gU6hnuoXLhw7do6oM84lnYVf7XlPzXDPGn4E7hIz8jeTmJf94NiBmDUSJV9P42bgQh9CZGEredphoaj2cd1IFhyfD0AH3R05UfpMd/YyXSemCO2VLPScT2kVNjLP7TLHItAj8afLjULDkZIWn5MF3ehHQUtMZwfIFwyyyLBLqap9q2C02rTRWv6wJ9aplg7W1iXsn4pV2e56GAuoOFshv4g6C72G5N+tQ72xpfwsEmyLzuqMlm3CBo+BBjFY8cg5WzgqZB7pr5uuJU115fKaQkpcopjjTTJuactAO7gIGZKVynPQH0An6T+BJ5RMqDzN5OjgscG/8XFyEN34oorV03CpQerxoFdC8M0VcR/CZXJegIN3/ExzXxHijosk5cSynNkDJTny3cThBJADAHwZzfyIw3QjJNQxKUtL360k+nYtpkCPlvp0lP9eBa65EoMZbzi0fL1Ubyai5gXQI7sIoVz3X5LRRC70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc2e276-a868-4696-bb55-08dc80d68979
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:30:09.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fB8EkGwvey0yMzENeznsc1BuO4E1+4IX5Nth7GBldhJXK/iCXI9J+RSVRfEuvJMLfSc2FWpExQFdWm/PRR8JsNvdeZ/mbNdbN3gpXLK0TMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300136
X-Proofpoint-ORIG-GUID: AwOSiyslXyNEhCp8Rf6sHVzjLokOYMxP
X-Proofpoint-GUID: AwOSiyslXyNEhCp8Rf6sHVzjLokOYMxP

Hi Ravi,

On 5/29/2024 11:37 PM, Ravi Bangoria wrote:
> Hi George,
>
>> Events can be deleted and the entry can be NULL.
> Can you please also explain "how".
It looks like x86_pmu_stop() is clearing the bit in active_mask and 
setting the events entry to NULL (and doing it in the correct order) for 
the same events index that amd_pmu_enable_all() is trying to enable.
>
>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>> This appears to be an AMD only issue.
>>
>> Syzkaller reported a GPF in amd_pmu_enable_all.
> Can you please provide a bug report link? Also, any reproducer?
The Syzkaller reproducer can be found in this link:
https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>
>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>   		if (!test_bit(idx, cpuc->active_mask))
>>   			continue;
>>   
>> -		amd_pmu_enable_event(cpuc->events[idx]);
>> +		if (cpuc->events[idx])
>> +			amd_pmu_enable_event(cpuc->events[idx]);
> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
> before amd_pmu_enable_event(cpuc->events[idx])?
Good question, but the crash has not reproduced with the proposed fix in 
hours of testing. It usually reproduces within minutes without the fix.

Thank you,
George
>
> Thanks,
> Ravi

