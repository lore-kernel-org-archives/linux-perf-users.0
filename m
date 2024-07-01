Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA38C1D;
	Mon,  1 Jul 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843374; cv=fail; b=oAipNNeVCUfibY/x0Phgjj7xMsrdtC4c/j/ciTWZb6lq0HwTsx57lyNtJ3nThRPK0H7P0EOGcPcXhUuCHaSxKcqdM6ocKpoVv1CV61G+Wyjw/ROFWgi9SmvS7PpV3sTEkliOzSkiGzCj44kvHKI54KFipr4mwZeKad22/Kg2fTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843374; c=relaxed/simple;
	bh=q3mv7/kwAo5M2bTI03j82iKBYEIGfLAnMYSgj/W41K4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RSld+9wdy53zuoJVlHYmdu5HMu0mctTu2Fa28JzgNcxesPX8fPtb5kBW2pZexKVLkkXOlLThpgDs5ij9a7TqAg8vw2FyAGj5/OXPSWsXmveoyW375zFimNgR9QLKf2s1noP66Cp5Y+85r+u/XpQCoSEyWu5IksE3izPch8qco2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JzlzEqIH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nMOoQOD/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JzlzEqIH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nMOoQOD/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4617tUR7018770;
	Mon, 1 Jul 2024 14:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=uj+SYmk24YJ78COHmC3T03dGUnJ20AFjJWJjJHmC83E=; b=
	JzlzEqIHyawu+OvUPZwq5yOtegIIzTTlSFjXdGGhbwfzzmhosoog8nwchSu5FdXV
	xRPDpFk+M8GE/q856SYW6ybzI96LK512iBooxzUQaspkTDfj2KQs5IJ9x/KZwY5G
	gNYI7zoPildoWAwZVsvYhdp2ZqfhCctEYOcrhSLgUfPcUn/waQNwYMi5gPe+DAIo
	4C+gMAW1H7LOBprU6RXy2Txvz0wFXQwSnMUUjCvHx8/pQtmVnBTOR8w494r4xlSV
	yiQgUCahQJPpVSTSv8lwiwnwGZM41MW9GdyCAkKc96x0sBy7LnhNloHq+cuxj2nN
	UrgSCsEvO73QH8vUOaijYQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922tuy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 14:15:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 461DvTM6009931;
	Mon, 1 Jul 2024 14:15:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q6jdxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 14:15:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at/tYsXKPhZjUGLOzQxB6ArMbDOuX3Jlm+z976UrVkPOhhLa4IQm1gwfoyTiueJcMRFXot+k+cnBEdLN79D4v7ffvAX03SIE3/wBY6NCPMiQn83AhXLivkMevHS9Ruw268kA3esw2wgBU5/FumwDTJxmnIt4vOTW9FeHqaNB7CFteT9YIIkRegepMgyWCzXbV2zAykjxsa2rZ+suyDzVV4mOT+0x9K+jbvDui6HuaD/wxqE78g1E/PvcJix0xb19sruFD/oQfZIU6Z05kpCeYAtRRxdbwUkSUlyQ1epnOjZC+qjSz45oy3TASpmGEp6mf88qjdOBGe4HXuiOmjeUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj+SYmk24YJ78COHmC3T03dGUnJ20AFjJWJjJHmC83E=;
 b=fGso7LMld2KFRCmqsWaDgsCAZid2iGEWATpxdeayrc7+RS2C01a9pswZDe7wvK4TUFPE0SpSy2lPI4r1sUcAVUFlrG/xFErwX6K13fPbOyMVRVTQ6cIX8ygr57rTVvhUgVYmdnEftw6Xf8Q243AXxhPsTO4zyqnW0UmnnuafrDetZ+PAP76m9R/4c7TPaP1viBbg7C7kId6/kkBdeoYj1DHfGGTzgd+irPoHjuihGOIsjIQpY2h6PHwsdwpiQ53ssIEkySSv8g/yPfwPGr3H3jRVlMcZb+VKOK9la+B3iVpBsvZb4cgK+nxhfPV+VpzbUxhNyaKLGWeTQgGqeRhEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uj+SYmk24YJ78COHmC3T03dGUnJ20AFjJWJjJHmC83E=;
 b=nMOoQOD/woAXHlZdl3VgoRY33WO02o6ai1cI1VRiHjsmCfWES0HUuxE2r8VxjAwKvlhY8tWHyQW3qkRaJhs+RfLNsiSMJJuE6geRNrrNeQ42pYPCV2lVYJz/gHUZaLfzNhjLis/G2eQFqwqygkYRiUBIqcQpyjKxdqujfolkOO8=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by PH0PR10MB5754.namprd10.prod.outlook.com (2603:10b6:510:148::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 14:15:25 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83%5]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 14:15:25 +0000
Message-ID: <f793f3a7-c5cc-4630-b042-ee90e9658332@oracle.com>
Date: Mon, 1 Jul 2024 10:15:20 -0400
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
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
 <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
 <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
 <36e86320-1a43-45d4-b25e-a5d60857f4b2@oracle.com>
 <78db946d-db24-408e-92fc-b7ff79c80728@amd.com>
 <e193949b-d969-42e7-a0f3-fbea6e4dfe12@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e193949b-d969-42e7-a0f3-fbea6e4dfe12@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|PH0PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 230bad89-f829-4308-590b-08dc99d84038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TlR0OU5Jd0ZYZzdRMy9TaklUZE1oOUtoY2R3SjhBZFFTM3JQRWZvd2xqZHdq?=
 =?utf-8?B?TkYzbTdISUcwNWVSSXZnUTZ5eURaUEMzbEdNaUNrdW9xSERkNC9adG5kRXI2?=
 =?utf-8?B?SGpHY08vUkRIS0QzMlNPbi9oa3lVQjR0Sk5xOUx1VjFvZTBCdUZnQy9YMDM3?=
 =?utf-8?B?aXBmOGU2REQvZ1hOYW14MlZuT2M1OU1OK3RSd1JCOTJXMFhDMTMzRmZPNjJQ?=
 =?utf-8?B?T01yVWxweHMwVUhEZlRydWhGOVRWZVJMcVNtVlF3eDZ2RndocXRwVnBuaXJi?=
 =?utf-8?B?N3Q3ZnV0TU1kSEZpY2lhems4Vk0vbXF1bnFCNlk5SUxBb040U3Q5bFFBZXdT?=
 =?utf-8?B?SVBkeW1WUEtlZ3MweWFBblRMSW5GT3ZLdTA3RkF2cTI4Y1UzOVNJb0xKbHpa?=
 =?utf-8?B?NUpzT0JCSEhZNXlqMkpkZ3k3SUJhTU5GQVlGUlJpeGF2R25jKzZsUThVSTBO?=
 =?utf-8?B?T1ViN3NMRlVqbk1BZDJQTTIrZ2tMNlozTDlqbzk1dENSaHFsenpZWUxwWUVj?=
 =?utf-8?B?Tjg0RTZVZnRCQTNmeG53aE92VGxNODUyRTl3ZkdpelhLd1VYdDlUbWhHaWk4?=
 =?utf-8?B?TWNrSDR6b1pKTDdBblJYSzJlTVhaS010dkN0ajlNZzJSYVdsZU9Sc3lXajVL?=
 =?utf-8?B?cExMRGovVlNKV29XVGkyc1Vmak1VRDZNaHkxSk54SEZPM0taZDJDQUZyYWhY?=
 =?utf-8?B?cTA5ek1kWXZwMERQYkN6N2xOMDR2Yllwd2lmam1ZcjhSM3BlVHJibGxJcExU?=
 =?utf-8?B?UjZYcGhTWWw0eDkvaS9pVkxiZnNxSUswcUtzRmw2UE1JazJRUnJSYXNqRHU2?=
 =?utf-8?B?UlI4Y2N0UTVENDQ1OGJrQWpGOFBYQjNwajFpS25vLzFubU5PNWpxZTYreW9h?=
 =?utf-8?B?SWd2Z0QzTlZvNlB4a3VkeFM0WHdFRVlCSGFkUXJ1ejY5WEJOajBrdlQzbmM2?=
 =?utf-8?B?SlpmYURpOElMRGRNNzhPcHRFbml1WHNVMzJxem9wNjA1YlovaHM0UFFSSHJG?=
 =?utf-8?B?YXJnZ2gzbWpyYll4N29oRzB6V0xsOFQrem1OK2ZMUE84YUlLWmlTY2dZNlZv?=
 =?utf-8?B?U0RWcGlPdGVOQXZNL2QzeWZkaEV5bGZ6SWNKMDJHREk2dnBmYkcyTFNhaDZL?=
 =?utf-8?B?aWsxVWYwTUEvZW42UXkwVkhrRldya05rdzM2UWdIYldnWVZRR1E0U0E5TlNi?=
 =?utf-8?B?Y0NYRWdzdytReCtzdTNrN29EV1RLclBjNkIrUWRnR243a0JyeUF5aU4zcW1j?=
 =?utf-8?B?STVERmpRbkpUZk8yZFE5U2hjNTdWMzU3azRsanVDMjMvck1rWFNmTkR3SEF4?=
 =?utf-8?B?bHNvZ1hnTzltOEM0V1A3czRlZDcxTE1Xa2xzVlZLOWRMTVZBOU15ZDErNnVP?=
 =?utf-8?B?cnFRbzh0dGlFdFJya0lTbG5adFNIZzZ3dmxGc0RZTmRLeGlFbE9BNDY1czI2?=
 =?utf-8?B?ZXR5b1crRGlPdytlZjNWNVdrNEMzdFdMYlpXbTJHL2tYbTIvcmQrWnpXQkkv?=
 =?utf-8?B?SG1jNnV1OS80blZ6ZTFEK1BVWlBsdDZYWUJkL21sS09PUW9YcjBmNDVPWGZS?=
 =?utf-8?B?eEhmd0xFMzBIWTIyOWVCQVRDMmZOSUhQdElpU3A1VmRDS1owc2o1UmxRVFNV?=
 =?utf-8?B?Q01rcVpzOHdmTEtBc1FjaEFReVlJb3pkdjI5cWxKeWg1anV5dCtCR2Y5ekZk?=
 =?utf-8?B?cTdtMW92K241Sm1RVGJlalBBYnBMeWEvQVd3a2xzK1RnNFFvVmFxa0loQmJq?=
 =?utf-8?Q?h1Fm96maW/e7RXNwwU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjdnVWdWalFTdlJlYjZkUEdxQlI0UGMvSm1TQUhNdEJVbGEwb2g3cVEyc0VB?=
 =?utf-8?B?TkozZmYySVdXZDhYSC9DdUFJak1HUUZ6U0hpcDZQSStJM2VsMHc5Z09KeXFG?=
 =?utf-8?B?My9UWHY3NmVOLzNDbGVPNFNqb2RmRmtoNHE3ZzNtQWZ4d29hRGNHREJtelVl?=
 =?utf-8?B?SDhudFBDZ1BOZ3ZmOU9TWC9uZDlZNFFwQXVCWFErNzJsdkFkQzhURTJ4dS9l?=
 =?utf-8?B?aG9nUTIvTmJTaUxGelJlbGh3QXNiamJuaWo5bTFQWXlWNHNrdTFvbzZzRXhw?=
 =?utf-8?B?UldVaDJ3Mkp5aHo0UXBvTUpWcENGNVlDUFN1eC90ZldOaUFtVUlybmNZSWtD?=
 =?utf-8?B?eHNsU0ZmMEUwQ2E0SHExZG5MZmp6VXB0VXFBZzdEa3B0dmhRV0xSbWdJMkx4?=
 =?utf-8?B?NkFSMTNqRVFreHFHek1JdmpLRktWZDZRTU1BN3FFWkoySjFUV0ZFWjhlK1Q3?=
 =?utf-8?B?WFdHZFFyOXdxcHE4UllhRkg3SWlhMkZtYy81bFF1cFA2djVOWWNXNDZSbmdM?=
 =?utf-8?B?OTl5KzQ1WElmYjk2WFh1QVVrRFhrSThBcGROMHFBL3VGdjZmVGhEYitOdmxn?=
 =?utf-8?B?RUdjUlpGc2dPMDFEb1A1RUlGaWVwUTZlR05MTFYwd3VkcVR0MWZzTy9WZUR1?=
 =?utf-8?B?c3ZOZE4rbzEzRUEweklSR3N3dWozWk1QUXFtQ2VQU1M5TTFvYi9ieXZzZjg1?=
 =?utf-8?B?aXF1UU1HMEJlejNmeVVyZ2JXaldUeWxHWTg0MlBVbzR1SEpBQ01PWFBVc3RR?=
 =?utf-8?B?NjRVM2k0Vk05d2pBY3lPa0hnSFozUVhuUHJsT2VKcXI1WC9Pb29PQ01ORnJX?=
 =?utf-8?B?UlI3YVJmQU1aaGcxNGpiY2ZQTU5KYWt3S1A0c0JZUEEyQUo5bVRwV1dienVV?=
 =?utf-8?B?Q0Q3bUFSdjI0Zkd4eDRmQ0hZdGhOcTllRlE0cUVvVEJnQU5VemU2QWFhMzdh?=
 =?utf-8?B?QmF3VG1PQlg4VU5PNnM4eTBHR3JWVWtIaGpOTWdDUVF4eG1KY0RRZU9aREJP?=
 =?utf-8?B?aDcxSm5IdEswSTdtbURObXJlWmRRVzcxd0Z0by83ai9ieW9OZTJCa0I4MjNy?=
 =?utf-8?B?anF2UXJTSklKNnBzSWxjNDBnQitaamFhRFo3OGlkZ2ZVdGxRTTBCU1V5dGdq?=
 =?utf-8?B?ckdDQ09IZFhra3R2elA0SlNqbUIxTzB6UFVNaDZMQXIwam1peGdmMHUrMVlo?=
 =?utf-8?B?QWVvbDg5VFlsL3J1MFJtclc2c3QvbysxVE04TzFuQWdGa0lGRC9xYUVkcENE?=
 =?utf-8?B?RzVrbFdNTFNvVTJPa0RpTVd3blVVRUVnVG92SmlNMHZKczZPdmRsVjlNY2p6?=
 =?utf-8?B?V0lRMk0zTVN0TGMvaldiZnhDUUI5WGF3ZlRnU0UwSXgxUS9qYXE5R2UyeEFX?=
 =?utf-8?B?NFIrd24yeFNCVU5OVk9MSThjNmNzK1NvY1dCdVBOMGVQSmh1OTg2Z0VQcEQ0?=
 =?utf-8?B?Z1VKa2JFdEh2cHF3Y0Z3Y1NLdGczOW5VOEsvRWQrTGpPcEZZcUFxcGJhbnZP?=
 =?utf-8?B?UXhBc1BMaWJBMGQ4dW5sQnpkZWMyMVdSZytQbnR6aHpPYm9iNE1BUm9qR2Nz?=
 =?utf-8?B?VkpvT1pwb201Sk5ieXE3Vk9hVitjd0FlMjlDL0RENmhleEVQQmpRbTNaU1Rz?=
 =?utf-8?B?WW9rZ1pzczFINlM1b1pWbHZZM29KR1FvaGFzbmYrSkF5RDZqOEh4L2s5eG45?=
 =?utf-8?B?Z2ZoR1p3VUZwNGpQUXBtNFpreFNKQU5zZ05qTWNmZ25WUXhmNEY3UlJibW44?=
 =?utf-8?B?WlRYSjd4VXM3YlpPRGk4b0x0TjRpSXUvWlpZTHpPMG56U0FFcGdqdXFqQU5s?=
 =?utf-8?B?UWRiSGFFR2dqTnZjTzlidzVDaSt6b2JTQ0FnalFTeEswMzlrOTFsRWRwd2Nh?=
 =?utf-8?B?M3ZIN21CWmFuaWF3T2VHdk00akFGU29RZlF3MHFVMG5kN3h6cC9DRlFaMkdq?=
 =?utf-8?B?MVFTNm5oSkhNM0VkRFF0TGpVd0lpako0QnMrZndRTjJBb3J1ODRmWVBEQW5y?=
 =?utf-8?B?cmNOeHN1U2ptNlZQUlNGRVNZQUNGVkQrc3krRjdIK3dKclh6cHlXbzhySS9k?=
 =?utf-8?B?MU0zTWU4RStJV3piSjljZ2VINmN4KzVxcDNwYUlTRE9ZTndQT2hIdjhyNVdM?=
 =?utf-8?B?RTJpQlV5VFR2Q1BHQ2lEcmxTV2RGa3MrVkVUb1hkR21LV1dzV09ZK3RXR2lC?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FguioE/n7bTBqsA31wajDbmgArh3wOlmhloBaIJVHp40WsLSAFE1459PJxXlHkECW8R5WFGzDY21qHfs0DarqjRtTifaiA60ujxv+YibVtK0HZkJd19Vg1gMBpyubcQ7x4GDLh/+JMhuCEDgYC9uDHnWZ6E0/cmUu8vLe5xInRcuHhN4BInlm+IT/l+i+poLbfCdvbPtJmlqrcZpoZk8gUGFJ81xUBAnNTfdo8COOYEZzCbuJU4fKgt6EPPr+Fpc6WRLcoBdshC8T+/U9RIYTsaksgSWWA53d1vyvmOvGos7MErIkhDM0zB0TaZdJaZ38W4gI/GRMFOr7AOC7J8j3T/2Vl0Tr5h1bX5PEtsdHLmMWrMg9gR0EaZTNq2RbBrLFmipAaunG6X8ziob3m9H4rr/aHN6zV7Mu/WJLncTkxy4lY+0UkZQFOCowCLKHArNINfu3U4jtNSfoIIQ4run0rfBV4HoCsJb6QaQLiCHAAlBxbmxmuXlTqkDbrlPgvC8jWbb8M4FKZo9xqm/jlBulQGBuTI9/X6mqhoMYjV2Q7NkKQsatPaD3xBLnNppZyDIhfE4MbWDIsSJjT6HRykNu6LJBLZ9U8UtCRqoFc6GhWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230bad89-f829-4308-590b-08dc99d84038
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 14:15:25.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBhMm6SZc1+QADAg6EG8i8NhfaVdp7CW6pjECOyPn/w8UTXINPdmpH951G1cgyAjUGWeRkZy/eHC9ohVzRX2Bj2q832pfbZrFruG9Uwt3MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010110
X-Proofpoint-GUID: BGVhN4WKniOnCBoXsB__PBGfCSa0bTBP
X-Proofpoint-ORIG-GUID: BGVhN4WKniOnCBoXsB__PBGfCSa0bTBP

Hi Ravi and/or maintainers,

Is there any new status on this proposed patch? It has been out for over 
a month.

Thank you,
George

On 6/24/2024 12:18 PM, George Kennedy wrote:
>
>
> On 6/10/2024 6:51 AM, Ravi Bangoria wrote:
>> On 6/8/2024 12:43 AM, George Kennedy wrote:
>>> Hi Ravi,
>>>
>>> On 6/4/2024 9:40 AM, Ravi Bangoria wrote:
>>>>> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>>>>>> Events can be deleted and the entry can be NULL.
>>>>>>>>> Can you please also explain "how".
>>>>>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask 
>>>>>>>> and setting the events entry to NULL (and doing it in the 
>>>>>>>> correct order) for the same events index that 
>>>>>>>> amd_pmu_enable_all() is trying to enable.
>>>>>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to 
>>>>>>>>>> avoid a GPF.
>>>>>>>>>> This appears to be an AMD only issue.
>>>>>>>>>>
>>>>>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>>>>>> The Syzkaller reproducer can be found in this link:
>>>>>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u 
>>>>>>>>
>>>>>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>>>>>              if (!test_bit(idx, cpuc->active_mask))
>>>>>>>>>>                  continue;
>>>>>>>>>>      - amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>>> +        if (cpuc->events[idx])
>>>>>>>>>> + amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>> What if cpuc->events[idx] becomes NULL after if 
>>>>>>>>> (cpuc->events[idx]) but
>>>>>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>>>>>> Good question, but the crash has not reproduced with the 
>>>>>>>> proposed fix in hours of testing. It usually reproduces within 
>>>>>>>> minutes without the fix.
>>>>>>> Also, a similar fix is done in __intel_pmu_enable_all() in 
>>>>>>> arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done 
>>>>>>> as well.
>>>>>>> See: 
>>>>>>> https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>>>>>> There are subtle differences between Intel and AMD pmu 
>>>>>> implementation.
>>>>>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>>>>>> amd_pmu_enable_all() loops over each PMC and enables it 
>>>>>> individually.
>>>>>>
>>>>>> The WARN_ON_ONCE() is important because it will warn about potential
>>>>>> sw bug somewhere else.
>>>>> We could add a similar WARN_ON_ONCE() to the proposed patch.
>>>> Sure, that would help in future. But for current splat, can you please
>>>> try to rootcause the underlying race condition?
>>> Were you able to reproduce the crash on the AMD machine?
>> I'm able to reproduce within the KVM guest. Will try to investigate 
>> further.
>
> Hi Ravi,
>
> Any new status?
>
> Thank you,
> George
>>
>> Thanks,
>> Ravi
>

