Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E09171C9;
	Tue,  4 Jun 2024 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511266; cv=fail; b=If68K3X6qXQ/DPK6Si2SSrGKivo51qGxcmOIMze7HHOUKlYj8sA9CdJY21EYJu73g4jy64/APwZ/OiDEWXFR60Rd9b2lv6J5BaKm2CnsedrgskDyrg1ocwmY32qFzESxUw1MGHSuLGUQx79jIr7uEG3lPEyfTp/426RW/TGTEWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511266; c=relaxed/simple;
	bh=BT+uuy/zMIKTBeV6xcH8uqroEIYfsHBGWeVajJf7SkY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A6/QDIMc89p9rxE/b1SuYxemRyrw2SJg7Wh0FTbkqwagxBipfLFnyZ7qxBEZ6BSUxOF7NxdMBvSx3fBW4/GPbh0LKWneWbiQZ2DuWYznUoUruO6ShmejMUFWosNxP5Vv9w/Um/+Gzw7JJnZ8mGq1hZXvZWZ1CE20iJEsFjkZosI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bnjmx007084;
	Tue, 4 Jun 2024 14:26:47 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DE+Mc/QxFm2ZRtjpzKLD7djdaQYQIkzPEaAOK7lDRs1E=3D;_b?=
 =?UTF-8?Q?=3DMNjCzM3rJNmD0QLstb91z5yl89QgO6eA5Orb+/0S3cIRFoGq0YiJKjco+1oW?=
 =?UTF-8?Q?io88mVkc_Aex9V63cGUy5qGOVGnX6SYZM/OSZkxobLl4BLq2gl06eFfxWieYwOd?=
 =?UTF-8?Q?PO/2sEXjVCBAZA_xrkrQK6t1syPNG2UFcyZstFXZpHL90sMHEBkNRXQOt9XkreN?=
 =?UTF-8?Q?xmKDt9QjqdphKZutlw5h_vGwATuMNoE3xZtSJZQg8UnibIAOwhBgXglgf96oa8q?=
 =?UTF-8?Q?Iz0FLJVnO9Ol+naLUjJwgS8XYr_uEz9BUwF+tTVZe5QWGAiwHItS7yHvJlM+6Hr?=
 =?UTF-8?Q?+lIolHQQm051FHJA7nW7vptFk1KXZiiV_OA=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuvvw2x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 14:26:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454E4l09016136;
	Tue, 4 Jun 2024 14:26:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsa6g5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 14:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNoCPjwWXnmGSY1pJtgEed0Fp5zipi7M5s5Ilus6ZhTpn5/PTR9ZZP1+SRM8UUsfhTF1BbUTN3rN/ZrDpOc8NCFhDrNxBig/DOxmKvGyt1dQiZDlbHkkYf3w/JMptq+EX9N8RAX0FI7EI3+4m4q0cCgEhQGpXYKUy+7X8ratc/vAYOEcgLXhyNi0Gz00prnaXafRxwQAq7YsGr4O0S83ZmfsS8CZASTZvgmczXm9DYCBmZXbdZVn4X1mWFTwq1S+YeXkMN/l+iNMvUty/gkU29zgqBuI+YmEuf8YJw6s9WzS76aRhQp1V9y6otKguMSYCLNDSmdtI5F0cZHqh6p0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+Mc/QxFm2ZRtjpzKLD7djdaQYQIkzPEaAOK7lDRs1E=;
 b=ChlmJUI4ZK4HHMWBFNEC5pwUSzEUwEGb0v4PEEH6wOOj5ufBv1sibBixc0r5IhWaU8CzR4mj6XvyxSkfNpYNHdeprI0iYapHl+1OsFC1x+RbMMvg4/MKwwOTDfbnQsOkfFVTIeUCeymVF0+4gGCirSxbNKMSSUYsmfOQUaA96/iTJ+Cs29/PiZHjyPr+uyYEPJIHY4E2L+/+piq/PpAsZ4FNi1WriyzXH3+27sij7dHlMtJ4pitFDfHVsKwWyeQF8ZvoO+AhBI67FTogvx33YmvX+le+M1HTgnpKEzO2/QDR+5bCKNe6NRAbxoCuO4cMDP31rwtf7TtXmyV8UHEthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+Mc/QxFm2ZRtjpzKLD7djdaQYQIkzPEaAOK7lDRs1E=;
 b=HxnN4XxvI7B0ykXkutqchGPMyQgpr8dGZcPH/husePTqXWmbQcEU4QqqqyzEjtGwUdVzlxEtpdx9hec/yLk6vOOG5UeDxnTcPxCuTxo18xc9PmGo6HJDXLVxoHS+I0IptSO+GmmAP4uE41vqcvXkhtqUhKrNffXhctEb1R7VJhs=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by DM4PR10MB7425.namprd10.prod.outlook.com (2603:10b6:8:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 14:26:38 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:26:38 +0000
Message-ID: <1f3418d9-ae95-4caf-9a53-d763473ec69c@oracle.com>
Date: Tue, 4 Jun 2024 10:26:34 -0400
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
Content-Language: en-US
From: George Kennedy <george.kennedy@oracle.com>
In-Reply-To: <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:208:19b::20) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|DM4PR10MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1190c1-8e0f-4dcf-882f-08dc84a25893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VWorcGJxODVFR2NvVFhodXYramJHNUZNYURUVnh4dTduTXFGQWxYNXVPRy8z?=
 =?utf-8?B?QW0wY3VIOHVGZ2J6algzNHh5OXR0dmhwMEN5aW5DSXhZbWdQbCsrTnc4Vkww?=
 =?utf-8?B?dXdEdmUydTFnS0RsZ2tRMk5ONE5DR1JsMWU1a2JEUXdpZ2ZFc09qOGJLQWZL?=
 =?utf-8?B?MmhlMzF5Tkw3U3UzS25EUGtuOHBZaWN1ekR0Vi9EZDg5Q2IybEhwOEJWN1RQ?=
 =?utf-8?B?WDl2YWpzaTZuS2o0Tkhla0kzSU1jZUlQVFcwTTgwYWVTVjY0d2RmNHFOd0FQ?=
 =?utf-8?B?S3JnNVlVTG1zK2orS1RXWENHcTBDRC9FSUN0OTlYRXpKa1k5ZXBQcjdXWmtw?=
 =?utf-8?B?MDhaQVQxamRkOXFvdHBLZXpobEV3Mml5NEFkaUs2TjZHUXIrZXc4ZUZwODM0?=
 =?utf-8?B?UlN0ZmwyOHQvWm95cUFiajVxWE5nZkkyTmw2Mkg2Y1k5QVpiaVNhbXk4Qm1Z?=
 =?utf-8?B?QzJCMVZjMzJYUzl3dERQd0QvNVI5a2pYVWZCSkZYdmh4VDRBRFFSbmhKbEZw?=
 =?utf-8?B?SmdzZVhaMFkrc1M2a1hDU0djc2hNZTV3RlZVQVZIT2Yydk1pOW95blE1NE1h?=
 =?utf-8?B?cjRCbytDbHNGN3B3Z0I1UUpPbnkvWHQ1anY0Z2RDL2MxZDV3RVVPOXkzdDJC?=
 =?utf-8?B?dWExVlk2Wkh4bjJOaHpvNGs3djMvbDFYeHBSaEtCdUc4NlkySk1saW04ZklE?=
 =?utf-8?B?VlVOeVpBZHVrSkVGQlRYeTB0WVFHQUgwbTVDVW9uWFoyWjBlNUhMOTVRbDRu?=
 =?utf-8?B?cDE4TVg3Z0R4dC9zcWY2c2xHYUppQ2h3MXJwOHg4a2VZWTZwTnpuVGo4bVRK?=
 =?utf-8?B?MUhtaEo3WVA4ZVdka1lWQUV4UWFwNENzQTVkTE0wdTJacTBFN0NjV3dVd3Zs?=
 =?utf-8?B?MzBnc0NTNHo1Y3RCdkdaeU5EalhGY09uUUpuQ2YzdXY3dmhUaGRNaHVlaHh4?=
 =?utf-8?B?cjlIMm9rMGpxWVBQV2FpckFML1R4QkJKcEoya0MxaXFFbnE3STBCWkorQTlG?=
 =?utf-8?B?SUFvU1lsMGdEOGFqWkozTVUvTXg3YlI0dU54bDBJK2lYWXplZkhmVkFUOWJ6?=
 =?utf-8?B?V04xTHMvSkhwOGJxdVpiWU43N21ZRENjdy9NZmlCNDhoaE0rakNGUkNFWVVJ?=
 =?utf-8?B?b2FWdjdkL1JvbThranEva1dXd3drVFRNMW5na2FyNFd3Wk8wZVFtMWZsdDRv?=
 =?utf-8?B?cVl1NjBPbG1yTnJkaFhLNTREdk4yT3hNVFdxOFplbDU0Tm02eTFib0Z6bHNx?=
 =?utf-8?B?OWp0UmhWOGxsRWdWMmNsTFNDaFBvTkpvMmY3c1FZaytVbHFSTzNMRFF5UkVs?=
 =?utf-8?B?V0tiSHlQTWlNdGMwSmNpYW1PRVdiZGpSSHdnai9EaDl6TjFreHFwK01vemtk?=
 =?utf-8?B?S2t0eVNiY2hDS0VjNEhqc1lzaDJSZXVRVUZoeEZFZld3Smp1WGhtWnRTVy9W?=
 =?utf-8?B?UjhRZ01MWnFMZE1CblIreHAwcFp5U3MyYWtpU2RVSGtlZmx6U1k0MWtWRXda?=
 =?utf-8?B?bGw0TTg0Si8xM1JqbTM2NmpzRENkZDRRMVVXZGlVRFZiOHZ5V2xtcStiWEIv?=
 =?utf-8?B?eHp0ZXNkRU5XbWUyOG14YkVqVWN5Mm9EMm56NFUvdVJzQnNycHJYVkZxbFhX?=
 =?utf-8?Q?LDZ3OXvH264B9ACHkxxIAL34640lUuAayZ0AUQu2fHSA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGViSVBKTHNVWmV0N2p2cDRtYk41TXZpbkdPdkdmMVZzN203Z00wa2JUNUJG?=
 =?utf-8?B?RzdCSm9FaUpZY0dsaG1uZlpWTXpSNWhkaEw2UnJZNnFJRFRXSU9rTzl0SWNK?=
 =?utf-8?B?dlNOY3FXRlE4TEpveXAvRVRTalBLTjFLWHpBaUVOaDEyRFJNZCtDWFRLTFNN?=
 =?utf-8?B?TTB2S1VZZDJNM0RRQXYrTVNkRDdrcW8vRzNwM0FXd3F0U1FXK21QdFkyeXc5?=
 =?utf-8?B?UHp0OUhFVG5rSnNiUzFEaHpwTUtPNHdwaWhzM2JBSkJQSEp1ZGxPT2dlNzcx?=
 =?utf-8?B?MFc0WUNRUklkQk9BODNWeThvWkdmRzVVbEUveDI4UVREUEUveFJIVjdJdFFR?=
 =?utf-8?B?Qno1TDJJYkpwUm9IbW9KNmFSd0lGdVpGNldJUXl0WjZpL3loUWk3cUhmMDJn?=
 =?utf-8?B?RU11czJRaXhtWWJsQ05NRnA1RTJwbmdOeDR5cnVhdE5ucGVobG83QWRLZlRV?=
 =?utf-8?B?NDRiS052dncrTHRxbys4aEFHSlNJSGJIMHM3V1Y4SG9EZGNUdG8yZnk3eHdr?=
 =?utf-8?B?UVZ2TXNNZnZHL3RFa2RDNTZmQzRjaUp3TGZkWDFpUmVoWHRpUEZ2OXI2ck52?=
 =?utf-8?B?azdjZ3k0UXpsQnFwNkU2STBaYXg3U3RtNThCWjUwbjlPd0lxMk03Qm9jQ2R5?=
 =?utf-8?B?cTE0MDhtRldpNmx0TTNTa3JwS3d2bDBZUTVZdE1vT3lYcUw3dWFnaTVNdDA4?=
 =?utf-8?B?VU5OMytLZWs5bzBLc1dnSndXWE9iWCtrNmE0SjZWZWFYTmtyWnF2M3NSZnVt?=
 =?utf-8?B?cTloTFlYZDZEcUxwSUVoOXYvNnZjekZBM0lNalQ5aEdRWlg0RnlReS9GVElE?=
 =?utf-8?B?V2VoRG9pUTdpNHF3K2pyZEZtZkVmY0NsSDJuOGpqTFlXcDdjanRkQWwxT3M3?=
 =?utf-8?B?YmMwT2hzazIxT2JuYkVCVnExVDRMZzlyZTlHWnMzbUprQWZPWjF1dXovQjBu?=
 =?utf-8?B?Y2VNa0tEUGlzR0pxQnpqK0xEMVlVNkEwZndRM1pxRnF0U1liUDZlTVp2THpi?=
 =?utf-8?B?TitFU2NuU2t5dDg1a3AyRkJhQjRXc0UrNGl0U2E0VloxY21MQ0hUaUJESnR6?=
 =?utf-8?B?dHhHUnJkekFiZjNIRHJNSWZkYVQvM3Z1Ukc4c3kvckZHRlNsVU8yNjNyT0pZ?=
 =?utf-8?B?MVB4MXBNdTRqekp0UUxlZVlFblRsWjUvMWdpWFd5L1MzMkZ2N293RUk5T0RJ?=
 =?utf-8?B?K3l6OVFVKzVlY1VhY0hVMkNSZGNHTEN5bmJhdURzejVOZUo4RG5vNDZjOUt1?=
 =?utf-8?B?a09IanVjYkNEWTBNV2dYTkhIRXZncFp0dE80cjU1MW44aWZRNkIrVS9FK09y?=
 =?utf-8?B?OXpQVjB4bVVvcWdkL1JVSUVOQ1pGcXlsekkxeThyNlVIK0k3YmZXUGEzbGtz?=
 =?utf-8?B?eVlkVkZrZURldkJMaCtDN3dyTXhLZWxqK0JHOVJ6V3p6dEhqRmNtbi9hb0ZH?=
 =?utf-8?B?Wlg2M2lNT1lnZVNhZG5SdVVFOVlGd0lqRVJtNTdobm1KLzlVclMwYUlDYWc2?=
 =?utf-8?B?aWNEMUVmcjhFMzU2M3o3NXN0Kyt0WHltZkFJYnR4YTlkT3Z6MWs3NlBFVkJp?=
 =?utf-8?B?MDN0VjY3S0dxTmxrTEE5amp2VXU1MFF0RENlZUJveGdSYjgxcWR0OEJnSTk2?=
 =?utf-8?B?TDRlYnNmNktMYnplRzhwZ1djWmI1UlBORm9DS3pKbE1GOWhCbG5nN3phdGp6?=
 =?utf-8?B?aG9hTUV0eHZhOGVwVXRtMkhkTzFpMFJxTWFXZHBuMkZGcXU0NTdFWVRSb2dG?=
 =?utf-8?B?QlVlL3UzdzRKd0ZMeUY3VjZhdUxBTFp1V3lMZGtRQmF5TVg0WjFOY2tSYWFv?=
 =?utf-8?B?dVh6TmNiU2puVlpMM2hFbzFyNkZGd0dCbjRQUmo2NWR3VGluTW53c0YwcktW?=
 =?utf-8?B?VC94KzR3Uk5vaURod0Q0RTZpbE9lSDIwNUZMQmdqSTBwVUQ3M2U2b0QxOXA5?=
 =?utf-8?B?YWRiSzZET3lIYTRNYU95dnVQM0lLajhXOWtCcmZvRTZUdjVSQ2NTQjBHQkdF?=
 =?utf-8?B?WUxaaSsyenJNQzBzcWtiUWR6a1BxRDJVOFk4bUpvRXpCZ0EyMVY1NTF3OVI5?=
 =?utf-8?B?dFp6aC9XMDk0clBEMFJBVmdKZDUxdGUzZTh0VnFuSTdvOE0rRmZwazFSZFJE?=
 =?utf-8?B?M2Y5MXY2TVY5MGQ3dWY1eEVKZ3IrbzFzNEF5aTk2TzJWVVcwSlZaOEl6UmQx?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ew+gTPMrAZvOE9yLQXDCveBlptT7EMRXDXusnN8c8pcie0rW/YduxE5XYc5hVPHaJnynxZivdfOQeeWFSxrw+VcPIjAO0WK4KMEIUb9qDqLTkbocjrN5HPsYj97L5ttvw0tf1pEJTbo4XFgsmXzCH54d7hfyl7zreVfRCJyl8GeHa/LgFt4T+t9/z3DglJiq0hTQ24O8nGh1aqgqHDY+qBbV6PNTfCUvFewEl/5SHbw9ofQtGdmw8Li+fxxVLw75jnKmBNw0rtoGY+lRuiujBmq6z21i39wWSpmkweCtRPzIeML94VSBWJ4V932ePx9o7uq8qUqzm1M/vkpzFNPKJobnyhErqCUfW1ks4YmR/VkoacJqqoXyqsuR6nAF3TIx3Rwa89D26C1kutrIXWS5purkMe8aTP/q3/1wdeBVAXr146IQKXQw/jO3hYrOTHXONwkJCQfaO6azaz5hAYWVJ1z+YxuG5g9RSmgqcs/q7a6E0cXz4Cqk1EdewjiDhsBhsvHizgg8ENvivxo48hqw5M0cWW5JS5DKh3M6YeCrJtZ/430Ee0FYDtJoby24VrlrzMQq/YsqR3071eG2eVedWyxBIlFK3AX/KJoQ/x0T0cw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1190c1-8e0f-4dcf-882f-08dc84a25893
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:26:38.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7crqyS1Z49KT1cGwd1+Wmg8NKmm9OD3anRvMhEC04oT+6rg9uKnqqWoXPTDWApKR0D3yxqiwBkLX4lo4Bn5hcI7SUSqYt6LFB5g2Ty0n5Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7425
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040115
X-Proofpoint-GUID: PO3nMTv3-wEZfmuDiwsiEdMyd3ftCjjs
X-Proofpoint-ORIG-GUID: PO3nMTv3-wEZfmuDiwsiEdMyd3ftCjjs



On 6/4/2024 9:40 AM, Ravi Bangoria wrote:
>> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>>> Events can be deleted and the entry can be NULL.
>>>>>> Can you please also explain "how".
>>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>>>> This appears to be an AMD only issue.
>>>>>>>
>>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>>> The Syzkaller reproducer can be found in this link:
>>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>>             if (!test_bit(idx, cpuc->active_mask))
>>>>>>>                 continue;
>>>>>>>     -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>> +        if (cpuc->events[idx])
>>>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>>>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>>>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>>> There are subtle differences between Intel and AMD pmu implementation.
>>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>>> amd_pmu_enable_all() loops over each PMC and enables it individually.
>>>
>>> The WARN_ON_ONCE() is important because it will warn about potential
>>> sw bug somewhere else.
>> We could add a similar WARN_ON_ONCE() to the proposed patch.
> Sure, that would help in future. But for current splat, can you please
> try to rootcause the underlying race condition?

Sure, I can keep trying to root cause, but will need help from the AMD 
perf experts.

In the meantime, the proposed patch with the WARN_ON_ONCE() added like 
the Intel version would avoid a GPF and would potentially hint at root 
cause. BTW, reproduced on Ubuntu 22.04.4 LTS on AMD Baremetal. processor 
: 0 vendor_id : AuthenticAMD cpu family : 23 model : 1 model name : AMD 
EPYC 7551 32-Core Processor stepping : 2 microcode : 0x800126e cpu MHz : 
1200.000 cache size : 512 KB physical id : 0 siblings : 64 core id : 0 
cpu cores : 32 apicid : 0 initial apicid : 0 fpu : yes fpu_exception : 
yes cpuid level : 13 wp : yes flags : fpu vme de pse tsc msr pae mce cx8 
apic sep mtrr pge mca cmov pat pse36 clf lush mmx fxsr sse sse2 ht 
syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl 
nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf rapl pni pclmulqdq 
monitor ssse3 fma cx 16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c 
rdrand lahf_lm cmp_legacy svm extapic cr8_le gacy abm sse4a misalignsse 
3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext 
perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 
smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 
clzero irperf xsaveerptr arat npt lbrv svm _lock nrip_save tsc_scale 
vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v 
_vmsave_vmload vgif overflow_recov succor smca bugs : sysret_ss_attrs 
null_seg spectre_v1 spectre_v2 spec_store_bypass retbleed s mt_rsb srso 
div0 bogomips : 3992.42 TLB size : 2560 4K pages clflush size : 64 
cache_alignment : 64 address sizes : 48 bits physical, 48 bits virtual 
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14] # nproc 
128 [ 165.692858] perf: interrupt took too long (36007 > 35837), 
lowering kernel.perf_event_max_sample_rate to 5000 [ 188.226736] Oops: 
general protection fault, probably for non-canonical address 
0xdffffc0000000034: 0000 [#1] PREEMPT SMP KASAN NOPTI [ 188.228803] 
KASAN: null-ptr-deref in range [0x00000000000001a0-0x00000000000001a7] [ 
188.230029] CPU: 0 PID: 20434 Comm: repro_x86_pmu_e Not tainted 
6.10.0-rc1-21-ge0cce98fe279-syzk #1 [ 188.231472] Hardware name: QEMU 
Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014 [ 
188.232791] RIP: 0010:x86_pmu_enable_event+0x63/0x280 [ 188.233642] 
Code: 41 5c 41 5d 41 5e 41 5f e9 3a 84 99 00 e8 35 84 99 00 48 8d bb a0 
01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 
02 65 4c 8b 25 a9 1e 01 7f 84 c0 74 08 3c 03 0f 8e ac 01 [ 188.236554] 
RSP: 0000:ffff888118209a38 EFLAGS: 00010012 [ 188.237406] RAX: 
dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000 [ 
188.238546] RDX: 0000000000000034 RSI: 0000000000000000 RDI: 
00000000000001a0 [ 188.239691] RBP: 0000000000000001 R08: 
0000000000000000 R09: 0000000000000000 [ 188.240830] R10: 
0000000000000000 R11: 0000000000000000 R12: ffff88811822a230 [ 
188.241959] R13: ffff88811822a420 R14: 0000000000000001 R15: 
fffffbfff32748b7 [ 188.243097] FS: 00007fa0554fb700(0000) 
GS:ffff888118200000(0000) knlGS:0000000000000000 [ 188.244374] CS: 0010 
DS: 0000 ES: 0000 CR0: 0000000080050033 [ 188.245291] CR2: 
00000000200001c0 CR3: 000000001c646000 CR4: 00000000000006f0 [ 
188.246418] Call Trace: [ 188.246848] <IRQ> [ 188.247199] ? 
show_regs+0x91/0xa0 [ 188.247765] ? die_addr+0x54/0xd0 [ 188.248334] ? 
exc_general_protection+0x15c/0x240 [ 188.249123] ? 
asm_exc_general_protection+0x26/0x30 [ 188.249922] ? 
x86_pmu_enable_event+0x63/0x280 [ 188.250669] ? 
x86_pmu_enable_event+0x4b/0x280 [ 188.251421] 
amd_pmu_enable_all+0x109/0x180 [ 188.252108] x86_pmu_enable+0x773/0xca0 
[ 188.252739] ? amd_pmu_del_event+0x42/0x70 [ 188.253415] ? 
perf_event_update_time+0x294/0x3a0 [ 188.254190] 
event_sched_out+0x7a1/0xd50 [ 188.254862] 
__perf_remove_from_context+0xfa/0xe70 [ 188.255650] 
event_function+0x275/0x450 [ 188.256293] ? 
__pfx___perf_remove_from_context+0x10/0x10 [ 188.257174] ? 
__pfx_event_function+0x10/0x10 [ 188.257891] remote_function+0x12e/0x1c0 
[ 188.258552] __flush_smp_call_function_queue+0x1c6/0xcb0 [ 188.259433] 
? __pfx_remote_function+0x10/0x10 [ 188.260175] 
__sysvec_call_function_single+0x2a/0x210 [ 188.261000] 
sysvec_call_function_single+0x36/0x90 [ 188.261789] 
asm_sysvec_call_function_single+0x1a/0x20 qemu-system-x86_64 -m 4096 
-smp 4 -net nic,model=virtio -net 
user,host=10.0.2.10,hostfwd=tcp::1569-:22 -display none -serial 
mon:stdio -no-reboot -enable-kvm -initrd 
/var/opt/do_syzkaller_setup-1.0/fuzzer/images/initramfs.img -hda 
images/syzk_8.img -initrd images/initramfs.img -kernel 
images/bzImage.UPSTREAM.v6.10-rc1-21-ge0cce98fe279 -snapshot -append 
'console=ttyS0 earlyprintk=serial oops=panic nmi_watchdog=panic 
panic_on_warn=0 loglevel=8 panic=86400 ftrace_dump_on_oops=orig_cpu 
rodata=n vsyscall=native biosdevname=0 root=/dev/sda console=ttyS0 
root=/dev/mapper/ol-root' In your attempts at crash reproduction, you 
have all modules built-in with KASAN config'd, correct? Thanks, George
>
> Thanks,
> Ravi

