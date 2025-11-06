Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3FF2C17A3;
	Thu,  6 Nov 2025 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461776; cv=fail; b=VSuIi3dVYWYeynrW6PJZvIs6E0iZc5I6uRi2lLc96QsqQ2uTUG9rmLvC5A/xplOO/WfH4+lYxaW9qNNnke11aUiMdexqrXsZnpIUPzOBPyyljRvf9EOi98DWJEsNcrC9AEbW5LMQP3MOyNBPixSLZvPiGvtDAqvLZcpr9jbVWBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461776; c=relaxed/simple;
	bh=E2SCe9HHnq6eAS2u4nxo4EHauhYKyLwF2AcFqg56Nug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sf+hItJCm9DvHsTLFVfFwfVHlD8GPpmZTeZomW0zwxd8inGE7Gm+yY33svmUVJXTEHKb7/9QQi0iLg+iLwFwDiy3jFDkt1XICWhufq7TlwAsaBZYGjqcu/hkO7l+n9zHUygltcD7Gzg0KK4mOYaeagakLfLo80q8bTUpASB8HAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D1HXiVEK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ae0oYDae; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D1HXiVEK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ae0oYDae"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6IgYGt009027;
	Thu, 6 Nov 2025 20:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tH41BBXm4Mvh9cA5jwBud/JRJFWleHunvbsMMisG844=; b=
	D1HXiVEK7PNBXLPs/vibXK4yQu3MBSy6jv156f98Yiv0a3Z18nJHO5m5oA1RRZzt
	xLvZjuOiSqQIIU00OfkHuYWAqZIn/VJnHM95pPXnKV9hjPuz5ESpxPdqt3HCLkYH
	6DcSy+athbpms7P66PkVT/eNFLCvjcbN30syp0bURVb5ZQeEiLD/3to2aGCvgvVN
	ip2fOZMzzXCn83SnCVNCElL20x3+dba75EznwLd1btwBQaPb9uo+DKOavsECVb2U
	xhtpAWU1iPMKt619k5pxj8Py4qIuz2QS+5puh+3vITgOYPpjVoA3g4TkKzkQlWsl
	tFSb74IPx9dWw8thwzTNHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8anjjxd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 20:42:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6J0uhm035979;
	Thu, 6 Nov 2025 20:42:47 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58npr6bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 20:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2Xw7094YbwDy0mRj1JlwQ72Xu35ikj0r7i3+1t5ZL3gWSjB9TX+QN6tyFIn2+QNxhDYct3Ww06f+Du44CoBg99csyUeLdSyrXaXuhF5m4In29qiHpQ1AV/wiu/Z70vOIFWAq7/GZFT5zchZZPi+3CGxFTuTRfm4i+sI+FA1LDh1rwo4IM/QwPYKh99ZgyG/h+MrZm656b9cCvtqr1DY8zz2+NC3m7z66pjtwGxsCOeD6c9FuDQmp8CdripoKkkd+7hBi0iYGrQwHEsyP/oGA47H9e2fxnMxtmH0IZ8aJfjl09P5mdVLdljlSwr5NzXiUi3BNFoNjjUyn9d7HajO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH41BBXm4Mvh9cA5jwBud/JRJFWleHunvbsMMisG844=;
 b=e71npVJrE0ssMv7yo7uSrEc0RW92iYzxugCt3sc5Rof4EWrTdV56V8MSJw3QhAJmVDPef0p6HzTbldcC0RlyZm4Kzc567SAcVAx4XXSpe5cZqEX7WmE3MGp/RzRas1AXB8f7vnu+0NyDb7TDgIbo7X/UtynAsLsesPy3Hislz+mIE0z5MPCJa7gD+U2+dP8IP0UMkRMoSuWRbqHq+fUziymkiKbs2NrVQDdjN18s5L74AsR+IaiCRSzhMglTylja0/wPj3JHlYTuyZXKwu8bzexFYiWdRYaqK6XFSMokahjuAbnncMOlTuBzCHRzD9PtMS3XeBG0BbHbPJkLlyyYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH41BBXm4Mvh9cA5jwBud/JRJFWleHunvbsMMisG844=;
 b=Ae0oYDaeKSWLIsuJGu0+bPzRpbpy/EByVeU8bVKGUwV0MeyKXpR7I1tPK54fFf8SDZO7Z5t6LMItMEFbzRQaPrMBn7OW5rgt/sj1V0y0E0J3Bbj9g4yzS/2racLvt3q6Acpxe51sMauCSK9xEfwcTtA3SKnQlsP+xIvqIAXddR8=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by SA1PR10MB997631.namprd10.prod.outlook.com (2603:10b6:806:4b5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 20:42:44 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%5]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 20:42:44 +0000
Message-ID: <18064090-3418-4005-b35e-1afaeb2b4c95@oracle.com>
Date: Thu, 6 Nov 2025 12:42:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Fangrui Song <maskray@sourceware.org>
Cc: linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <2d713719-709d-4b46-8234-2dfe948b836a@oracle.com>
 <CAN30aBGEpwA+ZROXufqBL6MHM70oWTtNpGSioCMhxT8yS2t-Pg@mail.gmail.com>
 <9c11b765-66df-46f3-b4ea-a0c7f52dac35@oracle.com>
 <CAN30aBGX+CuPmPGRjzpRT69pP0QJc_zBAr69RqnMUZ-OXF=t1A@mail.gmail.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <CAN30aBGX+CuPmPGRjzpRT69pP0QJc_zBAr69RqnMUZ-OXF=t1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0055.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::12) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|SA1PR10MB997631:EE_
X-MS-Office365-Filtering-Correlation-Id: e94f1789-f947-445d-208b-08de1d7509ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUlHakxPdk05VWR1UjZGRU5ZUG1ydHJmZ0U2ZVEzenZyRGVZRnRZeStGeXZu?=
 =?utf-8?B?UzBuR3EyVWlISDFXT0t0aDNrdjFCR3hUOGZVT3dxcys0UVdPaWxXbVBjZlFB?=
 =?utf-8?B?TVV6SmJWTm4wVGt4LzFPS3RUZ3N0L3RrSktVbXVONk9BUUtCR1ZlbkRaT2V6?=
 =?utf-8?B?NUI0Q1RUblJ4WHRYempUQXdJSjEzUDRlWFo3Q1dKT3dhU3BCbndEdVBwZmox?=
 =?utf-8?B?d2JDdjJVYUFXbDhGMjZ5Y2kweG51RHdueUJqaGRSa1dOcDdqRVpMbGVFZG96?=
 =?utf-8?B?TkZzckpMOTBpblo0cWF3aFNLQmdmOHJsWko1ZUVaNk5nbUU5S1MvcW9DYmpy?=
 =?utf-8?B?OXVNdmlIa01jNHgvVTdsRDBQL3FPbGVkNDVTNUd3Y21tbTU5S3k0THJMQWpV?=
 =?utf-8?B?eG5PbWJvNnY0bE84MWtwN25HTERFbmptczRVV3NRbXVwVEdnK1FhY1QyNHRi?=
 =?utf-8?B?aEZnR0U1dEgxUEpLVFlDaXRjSlVPMGs1eXpLU0toOW5lb0RwemR4QVpjbEcx?=
 =?utf-8?B?S3VzT2lTZld0Q0F2MGFZOGd4NnArY2tQTnlnSUpDc1pNdjlHM0diSzVGQk14?=
 =?utf-8?B?bGlhTFlKNkRlejE3UG9FaWlEL280Ulk4SnV1REZ3RVpiSk5QWlZyMGtFdGI1?=
 =?utf-8?B?Z2l0SDRZVzJUTFMybzZ0QmpseEZIdEY5VzIwaTBlekdRYUNLWnM4QkJURUNJ?=
 =?utf-8?B?ci9PRUk3S0ZNOXVQMUIvMnJzK1lyQVVTb01idk5Uci9aNXU3dk9aam5ob0hP?=
 =?utf-8?B?QUl6bGIrYWFsbVJ6bVVGMU9LT004bENuc0lvMWkycmhKYTl6VFJoMlpoSTZL?=
 =?utf-8?B?UVArdjMyMkcrRHRpazA4ZG9oVDFWL3pRMkh2cHU1UFh1ckhGN1U3bVZnOW13?=
 =?utf-8?B?aExHamI5NzlGU0YralkzRStlVURBYjNmV2lacUJtKzgvMm5tU1AzRUt6b1hW?=
 =?utf-8?B?MHVTZnJBcW42UGtWK1VNUXcwRmhRVTIvanRnSENMaDh4Sm5GVlcrdTZTMWg1?=
 =?utf-8?B?NFJUSlgrMmdRR001SjRPRFhNT0lpaGdNcHNucGNUZDVDSjRrWkVVdGVNVFE4?=
 =?utf-8?B?dHoyL05Lc0Nra2hKenR5dzBOWVd6RHQrU2ZDZk1HVm1mWkdQMlZWa3FVRGhE?=
 =?utf-8?B?TWI0OHFVKzhBMUtwZDU4TEVSQkErSlhwOG5zMTNoVlRiU3dVZkg1Y2pGRXN2?=
 =?utf-8?B?TzBib2h6bDRnWEppemtnMHVLWjZacTlGZ2xkVWRiNFBLelV6QVExR0RaeW1i?=
 =?utf-8?B?bnM4SVNmbVI2TU5mTnVmN1N1TGgydFg3b2g0YmYzaVY3MkcrMnNNZnJkZ3Na?=
 =?utf-8?B?NlB4QUJjWC9hOHFnZVRCenN0UTFXOUtlVE5GNU9GMFpKZTN0dGJkVjNDeTBF?=
 =?utf-8?B?VjhJMHBhUEt2S1hacmd0bjAxMkxXdWFFZFZKbGN0WGU5RjdWTFVrYlMvT2JO?=
 =?utf-8?B?eXhwOTdVR1piUityVjVqaU5tYzA1SXp2K2Z6Z3c0NnZGTVdRK2RvNElyQ2Vs?=
 =?utf-8?B?U2cxdFpSeWJCOXpNRG8zWURKcktsekVCeGhSMFJXYVJ5dXkrTHR0OUdqcHdm?=
 =?utf-8?B?QnFIbEF1b0hOb3U2L0k1R1dVaG1KajNFR0RyTEMvOGdWMnpidnJrWUtvTHFJ?=
 =?utf-8?B?TTMrUlRWZ3Erd0dKMGNwZUNleC84SENLb011aVVFa05LbjEzdVhFd3F4blRQ?=
 =?utf-8?B?RjBvU3F6c3R5a3NDY3NFakozQ2tobFN1S2ExL0JjYVdkSWNmMUt4RXVaSWxt?=
 =?utf-8?B?RWVqSG4wM2ZVZkhsQjZ6anJsc3BRZ0pOSDhZTkhoNGgySFQxUlRwTGFuZmpY?=
 =?utf-8?B?VE9QRVFaZE5QQnNyem1TbXdaMnZvN2tWKytYeXVGS2ZGWVVCSXV0RTFDdHZa?=
 =?utf-8?B?K091Szdmak9SS1V1OXhvOUlHV0dVR3NlWjE5SnoxM2JoUHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODdBWkZqUk5CVVFLMzlMYytEbVNHNExhL2hEZ1U2cDZyQWRESVdqampJL25C?=
 =?utf-8?B?aWxnODJSbDgzOEZiK29RdUdGMzRFZWdtUWxBQXlQWXVNR1hPMEZkYzBOK01m?=
 =?utf-8?B?am95UXdZcWNIWGxhVTF2NDVmSWxXb2xodUNUdlUwNGlMNWI5Ryt0OVVOcDBM?=
 =?utf-8?B?Q3IrWkJzSjV6ejBGcytuSzNubmRaMmwzaGNLMTZWdHh2dHFHMXRwZE9jN0hM?=
 =?utf-8?B?ZHhlMFp5SkFkYmpCUXhUSkIxcGpLTDJWaThWSE4rZkRmRWZkTHU5Zlptcmhz?=
 =?utf-8?B?SnREbGJkVVo3b0RzS0hSa3lMd2NXa3NoRnBEbnZEMUw3SWhQS0VsQXpWZzgr?=
 =?utf-8?B?Y3o4UUdwKy9zcEd5WEMrNURrcGZhWE5sYlRIVllwdkdzWGg0TVVhY3VwRnFL?=
 =?utf-8?B?bnBOcXROcTdFMHVOOG1Tb2lsekt4dklqZElHcDkralVRRjZIbjROei9jeG1B?=
 =?utf-8?B?TVdFWlJnYkF2RVB6RGtqR0hITXZpelRlTUp4VE9PT3VJN3JLYy9HZmwvREhR?=
 =?utf-8?B?dVR4M0hxcjluekNnUnZCSlZYUHUwQW1KS3ZNbFoyTHp1ZzZWbDdNVXdreEhv?=
 =?utf-8?B?eURiWDI5T0x4b1pCRkdBMkdIb0FJejJZdkx1MjJHaFNDanJnemJOR2I3UlFn?=
 =?utf-8?B?NlhQTWFjWnlIS3AzNHhQa09BUnc1RW5JbGtkdXZWMzdjVG1oQ3lMeDgvT1pP?=
 =?utf-8?B?aVR3UHpOejhsdldsYkI5RlFralZUTDIzeHVFTDJxbmw4QmJCbXZ2WVFVZTRV?=
 =?utf-8?B?YjltOTJIdXRZUFVkZFhoaGMrcEJER3Z1ZUsvcXZKRWttVzc0Uy9UZHVqZnVK?=
 =?utf-8?B?eXVmTVMyV3RiSDF3d3VjVkxJQzhDWEhDRG45TUQwSkQ4V253MWVxR2pCdUl2?=
 =?utf-8?B?S1hwdE5HWTB4Q1JDbDNPQm0vWGVmd29ZTUJoWThnVFZpY2tGNjVxT29LQk41?=
 =?utf-8?B?ZmZKZU1oU3ZKbC94WURBUU9HazFkeFFvNW9ZQ0Z3RWVUMVJVbm01VFJUcVJN?=
 =?utf-8?B?Y2lmWm5FM0RYWE94R3pnYXh6K0RtUGZMeEY5WElqK3pyUFN2dW51Z0MxQlgx?=
 =?utf-8?B?ekUwcVZoQUQxMGZKTlFSZVg3dG1KMnFoTzdIWnhaSlhSemRzVjdDUHRDaTNx?=
 =?utf-8?B?RVN2R3l4dXZvTzUwQWN2SWxhUnQ0R2hzbStYY0NNVi82aUtyL3VrNkVHYkxD?=
 =?utf-8?B?RDJUeldsUkF2ekR4bmFXQVBPVk9xOEpTRmFnSUVza3lVem5UeEpJKzBwaHVS?=
 =?utf-8?B?NEMzNGZiWGlwUGJmSUZ5Ylo0VXREK3RDNGJhc1RXaERVSmd3N01teGJXVHZW?=
 =?utf-8?B?VFNaVEUyY3NDaHlSbmNMUHd4MktobjZCK0pPUzZHbVovam5xVGtmSzRqOUE4?=
 =?utf-8?B?TlZKUzZhTS9vZWZVdFdXVjJ3Mk1RQWRmWTNkSnJoNEZieHZTdzdjbWRXMVpI?=
 =?utf-8?B?WDdPTnFjcWJIM281Y0JwZ0x2ZlNJNmsxN2RrYXBPd05PMGV6KzBjUE84S3VX?=
 =?utf-8?B?NXZKMWVpT2RBaVVjdDlLenIwUjNqQnJHR1BnQjlBUzZpSUNBV2YwbHE2TFFz?=
 =?utf-8?B?WkR6Y3E2OGNQNDJEU21SajlTK0JpQzlGZG1tb2NUREVjTnNHZE0va0xEZytu?=
 =?utf-8?B?VUxrbmtQd2FFa2FqMEZXZ3BaUFVBMURMYVd0TGNPblRuaVdsbEc3NmlNdzVm?=
 =?utf-8?B?dXRyODhqSkRsUVd4WmFFaC9kZGgzWm1kZ2xmK3NBTmppdUhWUWxWVXN0U1FE?=
 =?utf-8?B?a2FFK3BRTDVQZXZXZk8rZmhjQW5rR1pwWFAwKzJHdTFiaEU2R2t6dURSWVVW?=
 =?utf-8?B?Rkh6dVRsR3pjeTFydSsrdkcrUTcydlozbURwRjRMTEh1M082TExXeGJsOVJv?=
 =?utf-8?B?cDNWcGVWbzYvc1hUYjNhQnRCVWp5cit4aGg1eEJiZE1CeDM3dDE0SVc2KzJN?=
 =?utf-8?B?QzNQZUQ5WEZqM3lOZmJieW5tZXFMWVNjYWFCcktmOWxYdGJzeWphcVlJdEx6?=
 =?utf-8?B?eEJ0QXY5YjZ5ZWUvMVc0STZBM3MycndTb1RlVXhpVE85Z3RpcmxTVjBEK0tO?=
 =?utf-8?B?TWtnVzlPeDFDeXpGSUNiODNhMW9hdGJmUzVLcUZNeHdsK014MGErQkxpRy8x?=
 =?utf-8?B?N0pUYjFmVnFYUklHamEvSFdMV1BaZVpGMWViYlBjemhxM2hpK1pQbWlyZTU2?=
 =?utf-8?Q?wsGGxvjU3ZK5+PLSZgUnHR0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CvgjnBzRWdaj/seoK0EVb0kOyyJYTo5Nakcyo8O963tY3FOMPKOpnPIv5grqu57tZZHewvBVZSTMXZ8vvLd3AY6TBoeXwy07pIYTYtecNNbMd/2Y+c9GqkX5ZZeaNTsSjzAg4cweD8B5xXKwfm1MRIRqMA+9RuTTaLrPnadMuO52NGyLosfb3ZIgEqadenwRbXybWZaTDHg6pCsxBGlkQk1ImA1pmxkAREIi2u4uZvmRt/alb+oEyxzxqm6Aty3OtGzcoL/oqcEBUn1qEXBLw8kCMyOmpGRPt9r/0nFrBDFSqWR2hoKNV72l86H2sL/hMhOqCKTSdRAbmpz7LtF8klomvDVWy9UMWe8GHU4Gd/Wp6SFTre4uVl8o1K9/7xgMOPp2jUUu3HEE67F/FDSWX7wsHcCjhOtj9FQDOtGDy848cF3S0gnC7nOp+E50Bl3vrZyzpGHXdEUENptUEoHUTkEqK4iXRBRPFL103n6ApLROHl++XeJXOokqLg2A7X/Vtb7wmgfL5QeNPY/clgj0oEG+ddniy/ZFjKuVBmYb9G9La96zMFg/A4Da6sJFn4LvtujzjEwXVHRxoZkPZytoJr/aicB/Gxx1/11Anp3P/Kk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94f1789-f947-445d-208b-08de1d7509ac
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:42:44.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+9kFynDHdySKx37V16af9gbWtymf8jGYEDRetFRIiZzLb982/EkVKFFFPUuYK9j6Xu5BQUGSD7kgpYDJYX6gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMyBTYWx0ZWRfX+xs4npL7r3+K
 ZnvkZoNIyR0BXyO8/G7ts+/0Bo5rwvOLRNA9lRvMxBVDnFMWE08xNWXQM9UcNCGoq/R2VjdafYJ
 7KcGgGFRyL5cNn/Nw0nY+c8WH25QOmhp/Z2nRJ+wcHOj/7FRyUJYm8ixmcacoe1ny3qDAZPH5tY
 4GxVBzfl3PwJJW6JSdkf6ep3YYQkyo3NH0fU12yRFVtugy8QbRZtuUs/BTz1yCgqxA+a4UIz/PA
 v9qJOK812rmJCnXhnOYs4fOgkAGaoMhWh6w+dK3F/lwFHDRlYKYPMy5RwPNyNwHoCSWbeVb6d71
 NyQQQLGNrOfqCAV0UqMHGjb49HxpwNk28Qyt7tiOeSMUDb98XErdBttu9TuPBQQ+3UdisAXzqlO
 QZWp2YXYcvOUq5xCFJMNlJjD6831a3L9XdZY2GUhJeK1X5jveRc=
X-Authority-Analysis: v=2.4 cv=dfqNHHXe c=1 sm=1 tr=0 ts=690d0848 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8EG8Du73AAAA:8 a=Twlkf-z8AAAA:8 a=NEAV23lmAAAA:8 a=QegZ8fZzAAAA:8
 a=8ToAWqAZAAAA:8 a=yPCof4ZbAAAA:8 a=UbXctYVqdDeh1Zm4bpoA:9
 a=h2nVpHqBUTa786Tn:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=eIFONfotB6AA:10
 a=m3iHK6Qi1fOmGZKaujnh:22 a=-74SuR6ZdpOK_LpdRCUo:22 a=_Z14B2EILkUCX44yj2ln:22
 a=G1HVL-rv9vdetxEvgG_p:22 cc=ntf awl=host:12101
X-Proofpoint-GUID: dNN-97y8JxmCoGFDLQtLdbj_AhUr2QxN
X-Proofpoint-ORIG-GUID: dNN-97y8JxmCoGFDLQtLdbj_AhUr2QxN

On 11/6/25 1:20 AM, Fangrui Song wrote:
> On Wed, Nov 5, 2025 at 4:45 PM Indu Bhagat <indu.bhagat@oracle.com> wrote:
>>
>> On 11/5/25 12:21 AM, Fangrui Song wrote:
>>>> On Tue, Nov 4, 2025 at 1:21 AM Indu <indu.bhagat@oracle.com> wrote:
>>>> On 2025-10-29 11:53 p.m., Fangrui Song wrote:
>>>>> I've been following the SFrame discussion and wanted to share some
>>>>> concerns about its viability for userspace adoption, based on concrete
>>>>> measurements and comparison with existing compact unwind implementations
>>>>> in LLVM.
>>>>>
>>>>> **Size overhead concerns**
>>>>>
>>>>> Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is
>>>>> approximately 10% larger than the combined size of .eh_frame
>>>>> and .eh_frame_hdr (8.06 MiB total).
>>>>> This is problematic because .eh_frame cannot be eliminated - it contains
>>>>> essential information for restoring callee-saved registers, LSDA, and
>>>>> personality information needed for debugging (e.g. reading local
>>>>> variables in a coredump) and C++ exception handling.
>>>>>
>>>>> This means adopting SFrame would result in carrying both formats, with a
>>>>> large net size increase.
>>>>>
>>>>> **Learning from existing compact unwind implementations**
>>>>>
>>>>> It's worth noting that LLVM has had a battle-tested compact unwind
>>>>> format in production use since 2009 with OS X 10.6, which transitioned
>>>>> to using CFI directives in 2013 [1]. The efficiency gains are dramatic:
>>>>>
>>>>>      __text section: 0x4a55470 bytes
>>>>>      __unwind_info section: 0x79060 bytes (0.6% of __text)
>>>>>      __eh_frame section: 0x58 bytes
>>>>>
>>>>
>>>> I believe this is only synchronous? If yes, do you think this is a fair
>>>> measurement to compare against ?
>>>>
>>>> Does the compact unwind info scheme work well for cases of
>>>> shrink-wrapping ? How about the case of AArch64, where the ABI does not
>>>> mandate if and where frame record is created ?
>>>>
>>>> For the numbers above, does it ensure precise stack traces ?
>>>>
>>>>    From the The Apple Compact Unwinding Format document
>>>> (https://faultlore.com/blah/compact-unwinding/),
>>>> "One consequence of only having one opcode for a whole function is that
>>>> functions will generally have incorrect instructions for the function’s
>>>> prologue (where callee-saved registers are individually PUSHed onto the
>>>> stack before the rest of the stack space is allocated)."
>>>>
>>>> "Presumably this isn’t a very big deal, since there’s very few
>>>> situations where unwinding would involve a function still executing its
>>>> prologue/epilogue."
>>>>
>>>> Well, getting precise stack traces is a big deal and the users want them.
>>>
>>> **Shrink-wrapping and precise stack traces**: Yes, compact unwind
>>> handles these through an extension proposed by OpenVMS (not yet
>>> upstreamed to LLVM):
>>> https://lists.llvm.org/pipermail/llvm-dev/2018-January/120741.html
>>>
>>
>> Thanks for the link.
>>
>> The above questions were strictly in the context of the battle-tested
>> "The Apple Compact Unwinding Format" in production in the lld/MachO
>> implementation, not for the proposed OpenVMS extensions.
>>
>> Is it possible to get answers to those questions with that context in place?
>>
>> If shrink-wrapping and precise stack traces isnt supported without the
>> OpenVMS extension (that is not yet implemented), arent we comparing
>> apples vs pears here ?
> 
> You're right to ask for clarification.
> The extended compact unwind information works with shrink wrapping.
> 

Sorry, again, not asking about the "extended".

If I may: So, this is a convoluted way of saying the current 
implementation of the Apple Compact Unwind Info (lld/MachO, which was 
used to get the data) does not support shrink wrapping.  The 
documentation of the format I am refering to 
(https://faultlore.com/blah/compact-unwinding/).

That said, the point I have been driving to:

The Apple Compact Unwind format 
(https://faultlore.com/blah/compact-unwinding/) does not support shrink 
wrapping and neither is for asynchronous stack walking.  Comparing that 
data to what SFrame gives is comparing apples to pears.  Misleading.

(The reason I asked the question to begin with is because I wasn't sure 
if the documentation is out of date).

> For context, a FDE in .eh_frame costs at least 20 bytes (often 30+),
> plus its associated .eh_frame_hdr entry costs 8 bytes.
> Even a larger compact unwind descriptor at 8 bytes yields significant
> savings compared to .eh_frame. Tripling that to 24 bytes is still a
> substantial win.
> 
> Additionally, very few functions benefit from shrink wrapping
> optimization. When needed, we require multiple unwind description
> records (typically 3).
> 
>>> Technical details of the extension:
>>>
>>> - A single unwind group describes a (prologue_part1, prologue_part2,
>>> body, epilogue) tuple.
>>> - The prologue is conceptually split into two parts: the first part
>>> extends up to and including the instruction that decreases RSP; the
>>> second part extends to a point after the last preserved register is
>>> saved but before any preserved register is modified (this location is
>>> not unique, providing flexibility).
>>>     + When unwinding in the prologue, the RSP register value can be
>>> inferred from the PC and the set of saved registers.
>>> - Since register restoration is idempotent (restoring preserved
>>> registers multiple times during unwinding causes no harm), there is no
>>> need to describe `pop $reg` sequences. The unwind group needs just one
>>> bit to describe whether the 1-byte `ret` instruction is present.
>>
>> Is this true for the case of asynchronous stack tracing too ?
> 
> Yes. I believe it means the epilogue mirrors the prologue. Since we
> know which registers were saved in the prologue, we can infer the pop
> instructions in the epilogue and compute the SP offset when unwinding
> in the middle of an epilogue.
> 

This is not asynchronous then.
This meddles with the core business of an optimizing compiler which may 
want to organize epilogue/prologue differently.

>>> - The `length` field in the compact unwind group descriptor is
>>> repurposed to describe the prologue's two parts.
>>> - By composing multiple unwind groups, potentially with zero-sized
>>> prologues or omitting `ret` instructions in epilogues, it can describe
>>> functions with shrink wrapping or tail duplication optimization.
>>> - Null frame groups (with no prologue or epilogue) are the default and
>>> can describe trampolines and PLT stubs.
>>
>> PLT stubs may use stack (push to stack). As per the document "A null
>> frame (MODE = 8) is the simplest possible frame, with no allocated stack
>> of either kind (hence no saved registers)".  So null frame can be used
>> for PLT only if the functions invoking the PLT stub were using an
>> RBP-based frame.  Isnt it ?
>> BTW, but both EH Frame and SFrame have specific, condensed
>> representation for metadata for PLT entries.
> 
> A profiler can trivially retrieve the return address using the default
> rule: if a code region is not covered by metadata, assume the return
> address is available at *rsp (x86-64) or in the link register (most
> other architectures).
> 
> This ld-generated unwind info feature is largely obsolete nowadays due
> to the prevailing use of -Wl,-z,relro,-z,now (BIND_NOW). PLT entries
> behave as functions without a prologue, so a profiler can trivially
> retrieve the return address using the default unwinding rule.
> 
>>>
>>
>> Anyway, thanks for the summary.
>>
>> I see that OpenVMS extension for asynchronous compact unwind descriptors
>> is an RFC state ATM.  But few important observations and questions:
>>
>>    - As noted in the recently revived discussion,
>> https://discourse.llvm.org/t/rfc-improving-compact-x86-64-compact-unwind-descriptors/47471,
>> there is going to be a *non-negligible* size overhead as soon as you
>> move towards a specification for asynchronous (vs the current
>> specification that caters to synchronous only).  Now add to it, the
>> quirks of each architecture/ABI :). Any comments ?
> 
> As mentioned, even a larger compact unwind descriptor at 8 bytes
> yields significant savings compared to .eh_frame, and is also
> substantially smaller than SFrame.
> 
>>    - From the document: "Use of any preserved register must be delayed
>> until all of the preserved registers have been saved."
>>      Q: Does this work well with optimizing compilers ? Is this an ABI
>> change being asked for multiple architectures ?
> 
> I think this is about support for callee-saved registers, a feature
> SFrame doesn't have.
> 

SFrame doesn't have it, because it doesnt need to carry this information 
for stack tracing. OpenVMS RFC effort, OTOH, is about subsuming 
.eh_frame and be _the_ stack tracing/stack unwinding format.  The latter 
*has to* work this out.

> I need to think about the details, but this thread is probably not the
> best place to discuss them.
> 

Absolutely, I agree, not the best place or time to pin down the details 
of an RFC at all.  But cannot let an unfair argument just fly by.

The point I am driving to with these questions around the OpenVMS 
asynchronous info RFC:
- 'OpenVMS extensions for asynchronous stack unwinding' in an RFC which 
still needs work.
- It remains to be seen how this proposal manages the fine line of 
space-efficiency while trying to be the goto format for asynchronous 
stack unwinding together with fast, precise and low-overhead stack tracing.
- SFrame is for stack tracing only.  Subsuming .eh_frame is not in the 
plans.

>>    - From the document: "It appears technically feasible for a null frame
>> function to have a personality routine. However, the utility of such a
>> capability seems too meager to justify allowing this. We propose to not
>> support this." and "If the first attempt to lookup an unwind group for
>> an exception address fails, then it is (tentatively) assumed to have
>> occurred within a null frame function or in a part of a function
>> that is adequately described by a null frame. The presumed return
>> address is (virtually or actually) popped from the top of stack and
>> looked up. This second attempted lookup must succeed, in which case
>> processing continues normally. A failure is a fatal error."
>>     Q: Is this a problem, especially because the goal is to evolve the
>> OpenVMS RFC proposal is subsume .eh_frame ?
> 
> I think this just hard-encodes the default rule, similar to what
> SFrame does: "AMD64 ABI mandates that the RA be saved at a fixed
> offset from the CFA when entering a new function."
> 
> While I haven't given this much thought yet, I don't think this
> introduces problems that SFrame doesn't have.
> 

Correction: Not true. This is configurable in SFrame. s390x needs RA 
tracking (not fixed offset) and is supported in SFrame.

>> Are there people actively working towards bringing this to fruition?
>>
>>> Now, to compare this against SFrame's space efficiency for synchronous
>>> unwinding, I've built llvm-mc, opt, and clang with
>>> -fno-asynchronous-unwind-tables -funwind-tables across multiple build
>>> configurations (clang vs gcc, frame pointer vs sframe).
>>> [snip]>>>
>>> .sframe for sync is not noticeably smaller than that for async. This
>>> is probably because
>>> there are still many DW_CFA_advance_loc ops even in
>>> -fno-asynchronous-unwind-tables -funwind-tables builds.
>>>
>>
>> Possible that its because in the Apple Compact Unwind Format, the linker
>> optimizes compact unwind descriptors into the three-level paged
>> structure, effectively de-duplicating some content.
> 
> Yes, the linker does perform deduplication and builds the paged index
> structure. However, the fundamental compactness comes from the
> encoding itself: each regular function is described with just 4 bytes
> in the common encoding, compared to .sframe's much larger per-FDE
> overhead.
> The two-level lookup table optimization amplifies this advantage.
> 
>>>>>      (On macOS you can check the section size with objdump --arch x86_64 -
>>>>> h clang and dump the unwind info with  objdump --arch x86_64 --unwind-
>>>>> info clang)
>>>>>
>>>>> OpenVMS's x86-64 port, which is ELF-based, also adopted this format as
>>>>> documented in their "VSI OpenVMS Calling Standard" and their 2018 post:
>>>>> https://discourse.llvm.org/t/rfc-asynchronous-unwind-tables-attribute/59282
>>>>>
>>>>> The compact unwind format achieves this efficiency through a two-level
>>>>> page table structure. It describes common frame layouts compactly and
>>>>> falls back to DWARF only when necessary, allowing most DWARF CFI entries
>>>>> to be eliminated while maintaining full functionality. For more details,
>>>>> see: https://faultlore.com/blah/compact-unwinding/ and the lld/MachO
>>>>> implemention https://github.com/llvm/llvm-project/blob/main/lld/MachO/
>>>>> UnwindInfoSection.cpp
>>>>>
>>>>
>>>> How does your vision of "linker-friendly" stack tracing/stack unwinding
>>>> format reconcile with these suggested approaches ? As far as I can tell,
>>>> these formats also require linker created indexes and are
>>>> non-concatenable (custom handling in every linker).  Something you've
>>>> had "significant concerns" about.
>>>>
>>
>> This question is unanswered: What do you think about
>> "linker-friendliness" of the current implementation of the lld/MachO
>> implementation of the compact unwind format in LLVM ?
> 
> The linker input and output use different section names, so a dumb
> linker would work as long as the runtime accepts the concatenated
> sections.
> 
> My vision for an ELF compact unwind format uses separate section names
> for link-time vs. runtime representations. The compiler output format
> should be concatenable, with linker index-building as an optional
> optimization that improves performance but isn't mandatory for
> correctness.
> 
> I'll going to add more details
> https://maskray.me/blog/2025-09-28-remarks-on-sframe
> 
> 
>>>
>>> We can distinguish between linking-time and execution-time
>>> representations by using different section names.
>>> The OpenVMS specification says:
>>>
>>>       It is useful to note that the run-time representation of unwind
>>> information can vary from little more than a simple concatenation of
>>> the compile-time information to a substantial rewriting of unwind
>>> information by the linker. The proposal favors simple concatenation
>>> while maintaining the same ordering of groups as their associated
>>> code.
>>>
>>> The runtime library can build this index at runtime and cache it to disk.
>>>
>>
>> This will include the dynamic linker and the stack tracer in the Linux
>> kernel (the latter when stack tracing user space stacks).  Do you think
>> this is feasible ?
>>
>>> Once the design becomes sufficiently stable, we can introduce an
>>> opt-in linker option --xxxxframe-index that builds an index from
>>> recognized format versions while reporting warnings for unrecognized
>>> ones.> We need to carefully design this mechanism to be stable and robust,
>>> avoiding frequent format updates.
>>>>>    From
>>>> https://docs.vmssoftware.com/vsi-openvms-calling-standard/#STACK_UNWIND_EXCEPTION_X86_64:
>>>> "The unwind dispatch table (see Section B.3.1, ''Unwind Dispatch
>>>> Table'') is created by the linker using information in the unwind
>>>> descriptors (see Section B.3.2, ''DWARF Unwind Descriptors'' and Section
>>>> B.3.3, ''Compact Unwind Description'') provided by compilers. The linker
>>>> may use the provided unwind descriptors directly or replace them with
>>>> equivalent optimized forms based on its optimization strategies."
>>>>
>>>> Above all, do users want a solution which requires falling back on
>>>> DWARF-based processing for precise stack tracing ?
>>>
>>> The key distinction is that compact unwind handles the vast majority
>>> of functions without DWARF—the macOS measurements show __unwind_info
>>> at 0.6% of __text size with __eh_frame reduced to negligible size
>>> (0x58 bytes). While SFrame also cannot handle all frames, compact
>>> unwind achieves dramatic size reductions by making DWARF the exception
>>> rather than requiring it alongside a supplementary format.
>>>
>>
>> As we have tried to reason, this is a misleading comparison. The compact
>> unwind tables format:
>>     - needs to be extended for asynchronous stack unwinding
>>     - needs to be extended for other ABI/architectures
>>     - Making it concatenable / linker-friendly will also likely impose
>> some negative effects on size.
> 
> The format supports i386, x86-64, aarch32, and aarch64. The OpenVMS
> proposal demonstrates that supporting asynchronous unwinding is
> straightforward.
> 
> Making it linker-friendly does not impose negative effects on the
> output section size.
> 

OK, well, I agree to disagree :)

Looking forward to some movement on the OpenVMS asynchronous unwind RFC 
to see resolution to some of the issues, and some data to back that claim.

>>> The DWARF fallback provides flexibility for additional coverage when
>>> needed, but nothing is lost (at least for the clang binary on macOS)
>>> if DWARF fallback were disabled in a hypothetical future linux-perf
>>> implementation.
>>>
>>
>> Fair enough, thats something for linux-perf/kernel to decide.  Once the
>> OpenVMS RFC is sufficiently shaped to become a viable replacement for
>> .eh_frame, this question will be for the stakeholders to decide.
> 
> Agreed. My concern is that .sframe is being deployed before we've
> fully explored whether a more compact and efficient alternative is
> achievable.
> 
> 
>>>>> **The AArch64 case: size matters even more**
>>>>>
>>>>> The size consideration becomes even more critical for AArch64, which is
>>>>> heavily deployed on mobile phones.
>>>>> There's an active feature request for compact unwind support in the
>>>>> AArch64 ABI: https://github.com/ARM-software/abi-aa/issues/344
>>>>> This underscores the broader industry need for efficient unwind
>>>>> information that doesn't duplicate data or significantly increase binary
>>>>> size.
>>>>>
>>>>
>>>> Our measurements with a dataset of about 1400 userspace artifacts
>>>> (binaries and shared libraries) show that the SFrame/(EH Frame + EH
>>>> Frame HDR) ratio is:
>>>>      - Average of 0.70 on AArch64.
>>>>      - Average of 1.00 on x86_64.
>>>>
>>>> Projecting the size of what you observe for clang binary on x86_64 to
>>>> conclude the size ratio on AArch64 is not very wise to do.
>>>>
>>>> Whether the size impact is worth the benefit: its a choice for users to
>>>> make.  SFrame offers the users fast, precise stack traces with simple
>>>> stack tracers.
>>>
>>> Thank you for providing the AArch64 measurements. Even with a 0.70x ratio on
>>> AArch64, this represents substantial memory overhead when considering:
>>>
>>> .eh_frame is already large and being complained about.
>>> Being unable to eliminate it (needed for debugging and C++ exceptions)
>>> and adding 0.70x more means significant additional overhead for users.
>>>
>>>>> There are at least two formats the ELF one can learn from: LLVM's
>>>>> compact unwind format (aarch64) and Windows ARM64 Frame Unwind Code.
>>>>>
>>>>
>>>> Please, if you have any concrete suggestions (keeping the above goals in
>>>> mind), you already know how/where to engage.
>>>
>>> I've provided concrete suggestions throughout this discussion.
>>>
>>
>> Apologies, I should have been more precise.  And I ask because you know
>> the details about both SFrame and the variants of Compact Unwind
>> Descriptor formats at this point :). If you have concrete suggestions to
>> improve the SFrame format for size, please let us know.
> 
> At this point, I'm not certain about specific modifications to .sframe
> itself. I think we should start from scratch, drawing ideas from
> compact unwind information and Windows ARM64.
> 
> The existing compact unwind information uses the following 4-byte descriptor:
> 
>    uint32_t mode_specific_encoding : 24; // vary with different modes
> 
>    uint32_t mode : 4; // UNWIND_X86_64_MODE_MASK == UNWIND_ARM64_MODE_MASK
> 
>    uint32_t has_lsda : 1;
>    uint32_t personality_index : 2;
>    uint32_t is_not_function_start : 1;
> 

Thanks.

SFrame is not for stack unwinding.  Subsuming .eh_frame is topic for 
another day.  SFrame does not intend to go that route.

> We probably need a less-restricted version and account for different
> architecture needs. The result would still be significantly smaller
> than SFrame v2 and the future v3 (unless it's completely rewritten).
> 
> We should probably design an optional two-level lookup table mechanism
> for additional savings (at the cost of linker friendliness).
> 
>>>>> **Path forward**
>>>>>
>>>>> Unless SFrame can actually replace .eh_frame (rather than supplementing
>>>>> it as an accelerator for linux-perf) and demonstrate sizes smaller
>>>>> than .eh_frame - matching the efficiency of existing compact unwind
>>>>> approaches — I question its practical viability for userspace.
>>>>> The current design appears to add overhead rather than reduce it.
>>>>> This isn't to suggest we should simply adopt the existing compact unwind
>>>>> format wholesale.
>>>>> The x86-64 design dates back to 2009 or earlier, and there are likely
>>>>> improvements we can make. However, we should aim for similar or better
>>>>> efficiency gains.
>>>>>
>>>>> For additional context, I've documented my detailed analysis at:
>>>>>
>>>>> - https://maskray.me/blog/2025-09-28-remarks-on-sframe (covering
>>>>> mandatory index building problems, section group compliance and garbage
>>>>> collection issues, and version compatibility challenges)
>>>>
>>>> GC issue is a bug currently tracked and with a target milestone of 2.46.
>>>>> - https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-trade-
>>>>> offs (size analysis)
>>>>>
> 
> The GC issue would not have happened at all if we had used multiple
> sections and thought about ELF and linker convention :)

Thanks for engaging.
