Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132342AA6;
	Tue,  4 Nov 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248087; cv=fail; b=UFRYmjIW3GiY0AP4vbob3veEl0firlOVUgoNMXib2VpColoG9zWN4y9X+J+pqXNsbTP2sw7cE/qIyx7iUAMQ/ZQA77/m0o26fAtsZGLUvSjJcyKND4WdoIqpe8pn5MhVd/TUKQAo1SI1646Q9fAFYNmP6pDNMB/Dj8Dmf63ijnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248087; c=relaxed/simple;
	bh=C7HqWVohZtIG4Vt9tV0MyPeYDw3tqJ4xrD+FNlWcqVo=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DhGQEdUTuSYmbSRKKJzKCFqbuI2aD3QJhl9sAWBUsd2Wa4dHYoFIOTjY7yiLjLwqUCrgpd3SeP7468HxXH+qHD8IllwDN7Ui0Q23wmNwS9mz8z/3XKMsz/dKaVnfF8/jhjDbWfiWhub3X1GnCH3op2LZ5XhBYMyoc2Fq0LQZPhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TP2cifXk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qDZAV14m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TP2cifXk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qDZAV14m"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A494Zgu002113;
	Tue, 4 Nov 2025 09:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TuAPi21IP21Gi9kpOrJu9wWHGFJrMsWfH/1VDElltZc=; b=
	TP2cifXkQrlmPGOOGLemN6g9/KtliSKzTumAoEXo6eR1n8gwZo38/fFL0hbsjt8B
	URdPL2t03o122ZcdOYVOWH/cbUVwKpLM+YjsRJtyubv7BCPgwDRqvik6SGeel5os
	U2bqDcB0lXdGZqnkrZJpUqaX7iwBBCo1S9ESF4kNe4zefhfFuDgYrOlLI8fBWXmi
	rVwX2P5uBucU7+jy9FYqKrlbN0Uo6/t+HCi5navVdbAo3WJTxnPBWly7PGCFiTMv
	gF/sCSh05AbjvsRkQGG6QMfna1nP2PFM52ICKiqAt3Mgk2+wRvdgWcvByO984/KW
	gzDCZeLcja2JlSygwag36A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7ehjr1f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 09:21:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A47qVwW014974;
	Tue, 4 Nov 2025 09:21:17 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n93aav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 09:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1yCj56lcSKhyr6tqdrYxGh6AhLc6VJK1TReA7cczr+FzFdxAXoz2KKjVUPLgEF2ZpYDttbKqr1B30IxaAThgohO99KIX14QlMRn+w8njQZh5yFqotfilymAFhAnI0iiZxtH6dLU437CPAJYKwT+Ahxab65zZGWpZSNBWEQOrLSyS+8VSDlbqXpwQRapobfM9zrUCrgsvbM16CgEFDgRmLJEiVh65whuFJ+db7HGAcoQ5sIQbx03uGN7s+wyUAJG1OzmpmSnckQFT3zhzHmUhmubhq0stvLOtXfu5nqFu5Y8m/bIgkdoiyLei9ccyBI+YAXa1HZXbzQoD3wiZSif6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuAPi21IP21Gi9kpOrJu9wWHGFJrMsWfH/1VDElltZc=;
 b=jfBx7s6qAipoThqaYG4xWERVecamrwrbJFmdLOKCMH+PuC1rC5FvMna5DBXYLS/dmc+eMJ60IGwzb2XrvGw9KhLnR0j0EC4+X1E4UqB0YCoxY8Xi+yHkNcdbG6aO8uDGN8Yy10ebdfZagnCUuViBZUeV/WDT2Gzo0nXmm/f/deS4H6qxt8L3MXwjqCRgKHZGN1fJnHZ2XCmOZMy14pnN0hl6CwqSu/RhO7JdbS+L4q3qnReKFFY53LjwQ2uXebe+O34aHqY2W3Dv6KLGvrlgWDCYUhZWXPqFdWpxXMc9BaFL9sOwuOAcxDrx6y7vyAaGHjjHXA2b6HQUaZz8scepVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuAPi21IP21Gi9kpOrJu9wWHGFJrMsWfH/1VDElltZc=;
 b=qDZAV14m8iBN0BpPR5CkqTluWCthl2tskiKqVolohZnlG9WcLJ4tMWxatEMqmySNy8UXoRpqab/4BvhukwbLXof4SvpjRPKgt3MLYUIEVRM5Y8rTDTqq9Ba4t0Y5RZRyBn5cI4oF2Q5PFvf/BJU2/Fmy32gGQkBANI0bqupCxgo=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by DM4PR10MB6136.namprd10.prod.outlook.com (2603:10b6:8:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:21:14 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 09:21:14 +0000
Message-ID: <2d713719-709d-4b46-8234-2dfe948b836a@oracle.com>
Date: Tue, 4 Nov 2025 01:21:12 -0800
User-Agent: Mozilla Thunderbird
From: Indu <indu.bhagat@oracle.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
Content-Language: en-US
In-Reply-To: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|DM4PR10MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e297eff-c257-45bd-4ae1-08de1b838090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGFYWkw2bkVlY0FiMFlnRGJWd2lvNUJwTnpJMWNRSktPZXhMRW8xck13LzNx?=
 =?utf-8?B?L0k5ODMxNFNFU1NkNStYV29kbERoMmxLNU5udnZ3M0Vsejdmai9kbkFXWVEx?=
 =?utf-8?B?Mk0rdWFxU1lMOUZ4Y2hhTjU3S0FyY0NnR0hGUVloNVlQeXdZcEVPWWVwWDhr?=
 =?utf-8?B?N283bklTTlE4NXBhcmVRelIxNCtJTmQrMlMrWmxDajJpYk1UVDd4ZUd5RmJn?=
 =?utf-8?B?R0xBN1NrZlBwWkk0aHZhOTVJTFFBbmpIdzZPdkZBSW9MWXV6MURCYy9IZ2Yx?=
 =?utf-8?B?Q1E0TGFGRHVVZFRJVGZjRnYxc2dXTnZXcVpyT2lQb2ROMzVzN0tFakRYelM0?=
 =?utf-8?B?alQ4dEFDRWFiVFFlTDNycVVOVW1hZ3RhUDlKdFJiQWRCSHhKVDJITVpjbVFT?=
 =?utf-8?B?cGxjVUNZRGliNXR5d3Evb3lzTGRTcVJTUkc5MjUxM0hpODVmcGNoT3loMUpq?=
 =?utf-8?B?T1NhdmlMVWp1VzkvcjI1TS90YkhQREttSjl5QmQxSWd2WXUybWdLT1RiU1ZR?=
 =?utf-8?B?ZXh5MXlxcHFGUjZWdFFFYm1oMHErVUJ1WThISWZvUjluc3dEcUIrL1QyeDhC?=
 =?utf-8?B?RFFvNFh2MlJ6c2FOc0lreHNuSHZBcElPQjZzeEdhNzBnRDYyZEVIczVjOGs4?=
 =?utf-8?B?eHlCRVpMSklWdGwza08wM2xXOVU0bHl1N29MNGtDNk1EQmE1ZDkvYjcyY1Y2?=
 =?utf-8?B?UjZhK1J0MWZjek5KOU9lbHBraDdsMGZFcGpWY1JRbStzWHB1VEZJNzkzc2RK?=
 =?utf-8?B?MDk0Tmh4VmR5aEdwVjd4SFJzNk14dWxWTkxsYThpV0pscVQrWkY2VndLalZ3?=
 =?utf-8?B?Y0dwaS9ueTVRNC9lQnlXNURQNXEzeGFTTTZRdmtkcXZ4TGZodkdOMzQ5bm5I?=
 =?utf-8?B?ZVlhNitGRmREb2JwcFJvMzNpRjVHQkcwVThndmg3Y2ZidkFVSzdlbU1tcHlv?=
 =?utf-8?B?Wko1RzdiNXl4bGF0UGs4NmlvTkNFblEyVXFtdkp5b29lWkRBbFFvTnRqYTVs?=
 =?utf-8?B?ZXI4MXBwbFV6UGxPd3hzclhCUTdNZTlRQnIvdW44Z2svdFNYbzZsS0UwL2ZJ?=
 =?utf-8?B?WCtYNHBsbnpPZ1Q5SFpxQnlTSlZKdUpHNXdsOTFHOExZbG9hbmg1cFBrQWJ5?=
 =?utf-8?B?YmRzbnhTcWNyVUFBNnFLb25uZ0RnbU9zditzRzZDalhoYWFzdlMvQURZd0Iy?=
 =?utf-8?B?QjY0SU9wR1FoMGdLUnNkZkFwOE1PcWVsMHFmTzZrc1d6YmwzdmkrSjNKYndp?=
 =?utf-8?B?aWMwdllkOVNEQ1IzVW9rcWtwbGNDUUNySlhBeHVidkRJcVFqMWRkbmdzcWlF?=
 =?utf-8?B?dXdkWldiY05JZUEyazBobDlIUFJlUTdCcWJDS3MyQ3J1OE1iTXpBeTcrUGZu?=
 =?utf-8?B?TjBVODJBNlJ3MktNUE8xcHBzSGFPbU5IM0s2bzE3bk1yWXB4OFo1QnJ4SjlI?=
 =?utf-8?B?VEppKy9ROHRURzVHYnFjSjRYU0hqbkRsMTZNV2xwZmVyN2ZobkZpeWRNc2s1?=
 =?utf-8?B?U2VnRXNxU25pdCtuMnNCZDM1RlZRQlFpcVJTM2ZqUGFLUXVrcXJObWRqOSt1?=
 =?utf-8?B?ZEc3bUlzL2IvSlJ5SzFXSHpOMkxid0J5aDRPMC9ueEtsSnQrcEJPMklLR3pP?=
 =?utf-8?B?M1RNeWtSQ0lSUEl5Q3EwS1RBWXNyb05ERzZtcWl3QlljTjVkdzVCc3lLdUJn?=
 =?utf-8?B?ZUl6cFgwVUFkREZCbHF0YmxSb2l0NWY0MzRmMUd2Uk1JVkd6dVFzQnhBeSto?=
 =?utf-8?B?ck91MVdsVGhycmswbzJXUURlYWM5ZkJURWRXd3FiL3AwT01NbU8zVVlrYnRk?=
 =?utf-8?B?enpjTkFWeEVGSFRBdWJmMDdISEZvSFJnSzRVMEJHbGxWUzMvQVEyY0pjMldI?=
 =?utf-8?B?TGhQTStGejB0SnYxN2NMVnV2WEtSU0s0TllwNE1JYnBkRlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ui9UKzAyVWc0MVc2cm81TnMwUVVvaVYwMHQvT05Gd0x3ZU5DU0Z6UnFJQXVF?=
 =?utf-8?B?RW5MejVwbzNVM0ZSMnU4RWdrVDBlSGVtVk9mczRIWHJsYXlsY3VzaEZydzds?=
 =?utf-8?B?QXVBRXVUZ0lUeFJSNzVaMXlVcTZHUmdEK2xLOHIzNGFTaWRoVnlOM2p2Vytz?=
 =?utf-8?B?KzdVT3lpZGRVdTdjc0YxWFdIaHl3RzVwUWVaSis0UW5LTUFqR2RkZ0FzUERZ?=
 =?utf-8?B?ODNtUkNBWWI3RDUxRTM1R09BMWpuU2hVSjYxZHhEWFJJQ3hvcW1Fem5Yd3B3?=
 =?utf-8?B?Q0p0bTBKOXdyekNjYmpZT1BvcjNyMWZoaktWcEZMQStvL1N3M3ZWUlk3ZlRn?=
 =?utf-8?B?YUJXdUhWS2JBalhadWR3V0VPQy9maWNzVnB3bDJOSGtKUkJMUVR4V2NDK29M?=
 =?utf-8?B?UGpHbjhVdDJxUVFUaHdrVG1sbkNxZHlNd09IZWRGUnVoZVZkOERkc2NQdlZw?=
 =?utf-8?B?MVYrUmxIOGUyU1BYT2MxK0I5WDFJY29QM09sRzNDeE1MeVRCclpvL3JrRDBY?=
 =?utf-8?B?MWsvSDgwdTN0ZUtGZ3VtYW1sMUUzTGRERDVPNXo1MTdGU0M3ZnA3RnBoTDVw?=
 =?utf-8?B?akR1VCtKcGdEbTVtOU04RElJcXgzNVMrQ08ycDZsTUJwaDF6OVRyQnVnNEZU?=
 =?utf-8?B?dGdjT2UzT0Q4VlBZZ3FLbXNGY25oR2ZWSHJSZWdqOXBjOG10M0NydXUxNVM5?=
 =?utf-8?B?TElMMyt4eEVOY0ptTjNrWTVGeXZocUFGYkZmdENGMGNPbHg5Q3pEVnBvZXhC?=
 =?utf-8?B?Y0NFVHlPY3VKOXpSdHFCUXBYQm82M1dSeW1tZHZBRitCVGZSeEx0emlVTDJq?=
 =?utf-8?B?Nm9oNm81SXNhMTBublZaS1FRanphTGxKM2MrK1NZR3BxSFFmSjJEaHg5UWdF?=
 =?utf-8?B?Qy9xdWtBMXg1SmZDYlNpdHY1emhTZFFsYUd2Vjg1blFsTWVjc2R6eGZqcm14?=
 =?utf-8?B?cjVsM2FUNUV1SVdwVFFGcXdvaEN6Z2VuRUg3RXdSVzJ5TmRGN25vNFJEQ0h6?=
 =?utf-8?B?VGlERlB3UzZIUUpuY3pyMGNlUmVVS0poTlBYRGM2YUs3Si9JV1FMTHpkMjFQ?=
 =?utf-8?B?R0JoeG1oWGcwUVY1SVN4dVVNMWJhQUMxUXZMTGFiMlZObnVTM1Y3WnlrdnB4?=
 =?utf-8?B?cGFzZVBmemdVaEFwZkpCQnRzNGNyd2VCYVZSZ3RTN1E3OUV5NTArM09pSEZT?=
 =?utf-8?B?MmhKZUJESkFEd2lxNTBpV3grbXBiWlZaTVlDN2xpMXNwbDNKNGJxQTNXVHVi?=
 =?utf-8?B?NGJUOTU4U1JSWkxyaDJGUHpmL0FWZkJpaTFTOERhN2gzYjZ3OWtmSkZaVUhr?=
 =?utf-8?B?N3J4WElnNlN6UDF6U3Y3RFdDOVpodGxFYUZQRGlrS005enpqSFlwM01JUEtQ?=
 =?utf-8?B?bjhmT2N4STlJNFBaMkZNOW1VUEN0TG1LVUluZGR4cTRKa3ZicTYxaks4NGcr?=
 =?utf-8?B?N291SVZ4WGlZU0JscUtUTkdRSWpjR2JQNTNYaHkrV2g1SGtLZU41UmdiNmVI?=
 =?utf-8?B?TXdWSVZZSE10SWtpdTl6K3Z1WW03TUlQVG1idEU3SFE0VGZzdmNhZlhqNWRX?=
 =?utf-8?B?OXRIU0pLUEtxK213UGYyRFplOFR5dytKSDJ0QlZhZ1ZBMDFlbzlpbitSOTk0?=
 =?utf-8?B?RlBuRXorTTI3Q0hvZ0U0bnZ5L0lYSzM2cDd3UzJJT3dvRW5TWjd4YVRFU3RP?=
 =?utf-8?B?Zkw5T1NWcWlaN3RKRDhXRkJadEpvaDJhRzhCa0lUOEVIUElNckl2YVM2YUJq?=
 =?utf-8?B?MGlzN2VRVWo4VHRyYndLaU9xOUNJREp2TG5oRWNFZU4xWnd3Z2RwaHE5MWR4?=
 =?utf-8?B?VFhuWUp1VkFISUNZOUlmSE5Ea3Nzc25sTVpSUitTaEdVOTI3SDZ1M09wcXVn?=
 =?utf-8?B?MnkxUzFpalJhMzhmRTV2Nmxucm90amRqSnZWbzJQZjdTQmNGQ24xQUlRcURQ?=
 =?utf-8?B?NzdsU2VVZGYxNjZ3WTZEcFl4cG1zUjNGSkZYNmUreDJLYzkySFRhckwwa2JZ?=
 =?utf-8?B?NWJqVW9zc0paYW14aklLb29saDV5ekthNnZjT2JWNDNWTUhzcTlOTndWWmc4?=
 =?utf-8?B?K2RLUitramorQTFQRFF0aEwzWjBucU1hMWh3TVJRS2dxekJyZnhTQjUwUUZi?=
 =?utf-8?B?bndRdTdmYisvbGlWUWxocFlDZUlDY0FZaHNBRSt4L3hUMFg1SytSMkhiTzE3?=
 =?utf-8?Q?BS7iZ7F3Z3eMlmmuxoJ40QQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	elLg52ILbL+PnjQHMvohAZz0lAjWDFUy0sB2camsAHCzMV87LApb2o39+bdqSipDFJIGV1cXIeN1KVQFg6FysWcqgWN61EQ/7kI5gydkRALWgNS+Eo0t9hai9SPr2BvhT1mEiPD1CRcJ7GkxcBDlXnM+ZT3D4870UoGaUGPsnme/cdR9p3xWW0uWhNh0k5ql7Z0OnJdHimwZBiFz88vxI3cFxwEUpB4En40IWvJzL0QSnqThaEXJkhdKphOiqVgM6atFsFXZwSPcDZkqSia9xpnmC0hlVH6PdpV9skcf5banBkxtOdrlPGlvL49GM7afBex6NiBIa6xfbySImvKd0sOczoJOkmLbMPduSNDv4qah0oCGRLG37hYXGAc9yZvCnNXaPpSZ93uGaprBzHkbNvYEWgEm5PVxOtHcne63a2NPMEjFUuW4psu+CiUOcJz+liwJveSG9ClBoP+K263FctOCbXDjbWkIW9QLXEHEnW11Jpt1WwpN6M7BkD+eKcud+lBaDc3E8TVPkUHuVs80aFPPv6sMGmkSAdpGfcUQnZQbfzI3oVvtSiCPyULXri7Dw7pN2f16xRnpQXjj7SC2HXGZAyt6TuvzvLpt2DVe6Ic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e297eff-c257-45bd-4ae1-08de1b838090
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 09:21:14.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4sfK7YluKEWz9I1EfeenJVW2aHCXC97l6js1JlXb+eS1i5i0d0Ck0Mr6RgsIFdU3UlxnwNqz5iTzpwIVa4AcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040076
X-Proofpoint-ORIG-GUID: tErArKCBwJkBR1YQi6UvIG07bQ8fKYtU
X-Authority-Analysis: v=2.4 cv=EsbfbCcA c=1 sm=1 tr=0 ts=6909c58e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8EG8Du73AAAA:8 a=Twlkf-z8AAAA:8 a=NEAV23lmAAAA:8 a=8ToAWqAZAAAA:8
 a=QegZ8fZzAAAA:8 a=p8DkzdXpen5-4FNJy48A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=m3iHK6Qi1fOmGZKaujnh:22 a=-74SuR6ZdpOK_LpdRCUo:22 a=G1HVL-rv9vdetxEvgG_p:22
 a=_Z14B2EILkUCX44yj2ln:22
X-Proofpoint-GUID: tErArKCBwJkBR1YQi6UvIG07bQ8fKYtU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3MyBTYWx0ZWRfX8sJuuxCPZroO
 L2liiSQOXEVC8zpvA0UlV/ne5FzZK2gRaPbka2Tl9/gf2w/bRKCLlzp4DZixvNYDh+Agp5JyOPI
 BhlAnCF/4/DWfWg7fptaaEcSx9t4EywaLvrj2Qkn5alk3OBmMbMIxpg9P4Ay6PCIRpjf1l+KbKQ
 EOHCwsp88eN07+/RKuizy40fLxh8u5vTcw6LyQ1q7WblLvfptFBJr1cL5P0MBlsxO0oj/SdfSta
 qrbATrhiE5vaDnsQmkJWuy/5rxBs3GT0dLAnXvQAiMykDssMt7gEQS8zkEbsq2KyhWXgNgTa4Ap
 gL7Jo4IANLpXAfis9swEr54NygmT5A8jWZC9GRsi+iYRkytgqqwhhizJkVyzTwQsOd1PhYAGtTL
 fUebdVNm0ODF1Q/u9m5u9Ngei5vLmg==

On 2025-10-29 11:53 p.m., Fangrui Song wrote:
> I've been following the SFrame discussion and wanted to share some 
> concerns about its viability for userspace adoption, based on concrete 
> measurements and comparison with existing compact unwind implementations 
> in LLVM.
> 
> **Size overhead concerns**
> 
> Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is 
> approximately 10% larger than the combined size of .eh_frame 
> and .eh_frame_hdr (8.06 MiB total).
> This is problematic because .eh_frame cannot be eliminated - it contains 
> essential information for restoring callee-saved registers, LSDA, and 
> personality information needed for debugging (e.g. reading local 
> variables in a coredump) and C++ exception handling.
> 
> This means adopting SFrame would result in carrying both formats, with a 
> large net size increase.
> 
> **Learning from existing compact unwind implementations**
> 
> It's worth noting that LLVM has had a battle-tested compact unwind 
> format in production use since 2009 with OS X 10.6, which transitioned 
> to using CFI directives in 2013 [1]. The efficiency gains are dramatic:
> 
>    __text section: 0x4a55470 bytes
>    __unwind_info section: 0x79060 bytes (0.6% of __text)
>    __eh_frame section: 0x58 bytes
> 

I believe this is only synchronous? If yes, do you think this is a fair 
measurement to compare against ?

Does the compact unwind info scheme work well for cases of 
shrink-wrapping ? How about the case of AArch64, where the ABI does not 
mandate if and where frame record is created ?

For the numbers above, does it ensure precise stack traces ?

 From the The Apple Compact Unwinding Format document 
(https://faultlore.com/blah/compact-unwinding/),
"One consequence of only having one opcode for a whole function is that 
functions will generally have incorrect instructions for the function’s 
prologue (where callee-saved registers are individually PUSHed onto the 
stack before the rest of the stack space is allocated)."

"Presumably this isn’t a very big deal, since there’s very few 
situations where unwinding would involve a function still executing its 
prologue/epilogue."

Well, getting precise stack traces is a big deal and the users want them.

>    (On macOS you can check the section size with objdump --arch x86_64 - 
> h clang and dump the unwind info with  objdump --arch x86_64 --unwind- 
> info clang)
> 
> OpenVMS's x86-64 port, which is ELF-based, also adopted this format as 
> documented in their "VSI OpenVMS Calling Standard" and their 2018 post: 
> https://discourse.llvm.org/t/rfc-asynchronous-unwind-tables-attribute/59282
> 
> The compact unwind format achieves this efficiency through a two-level 
> page table structure. It describes common frame layouts compactly and 
> falls back to DWARF only when necessary, allowing most DWARF CFI entries 
> to be eliminated while maintaining full functionality. For more details, 
> see: https://faultlore.com/blah/compact-unwinding/ and the lld/MachO 
> implemention https://github.com/llvm/llvm-project/blob/main/lld/MachO/ 
> UnwindInfoSection.cpp
> 

How does your vision of "linker-friendly" stack tracing/stack unwinding 
format reconcile with these suggested approaches ? As far as I can tell, 
these formats also require linker created indexes and are 
non-concatenable (custom handling in every linker).  Something you've 
had "significant concerns" about.

 From 
https://docs.vmssoftware.com/vsi-openvms-calling-standard/#STACK_UNWIND_EXCEPTION_X86_64:
"The unwind dispatch table (see Section B.3.1, ''Unwind Dispatch 
Table'') is created by the linker using information in the unwind 
descriptors (see Section B.3.2, ''DWARF Unwind Descriptors'' and Section 
B.3.3, ''Compact Unwind Description'') provided by compilers. The linker 
may use the provided unwind descriptors directly or replace them with 
equivalent optimized forms based on its optimization strategies."

Above all, do users want a solution which requires falling back on 
DWARF-based processing for precise stack tracing ?

> **The AArch64 case: size matters even more**
> 
> The size consideration becomes even more critical for AArch64, which is 
> heavily deployed on mobile phones.
> There's an active feature request for compact unwind support in the 
> AArch64 ABI: https://github.com/ARM-software/abi-aa/issues/344
> This underscores the broader industry need for efficient unwind 
> information that doesn't duplicate data or significantly increase binary 
> size.
> 

Our measurements with a dataset of about 1400 userspace artifacts 
(binaries and shared libraries) show that the SFrame/(EH Frame + EH 
Frame HDR) ratio is:
   - Average of 0.70 on AArch64.
   - Average of 1.00 on x86_64.

Projecting the size of what you observe for clang binary on x86_64 to 
conclude the size ratio on AArch64 is not very wise to do.

Whether the size impact is worth the benefit: its a choice for users to 
make.  SFrame offers the users fast, precise stack traces with simple 
stack tracers.

> There are at least two formats the ELF one can learn from: LLVM's 
> compact unwind format (aarch64) and Windows ARM64 Frame Unwind Code.
> 

Please, if you have any concrete suggestions (keeping the above goals in 
mind), you already know how/where to engage.

> **Path forward**
> 
> Unless SFrame can actually replace .eh_frame (rather than supplementing 
> it as an accelerator for linux-perf) and demonstrate sizes smaller 
> than .eh_frame - matching the efficiency of existing compact unwind 
> approaches — I question its practical viability for userspace.
> The current design appears to add overhead rather than reduce it.
> This isn't to suggest we should simply adopt the existing compact unwind 
> format wholesale.
> The x86-64 design dates back to 2009 or earlier, and there are likely 
> improvements we can make. However, we should aim for similar or better 
> efficiency gains.
> 
> For additional context, I've documented my detailed analysis at:
> 
> - https://maskray.me/blog/2025-09-28-remarks-on-sframe (covering 
> mandatory index building problems, section group compliance and garbage 
> collection issues, and version compatibility challenges)

GC issue is a bug currently tracked and with a target milestone of 2.46.

> - https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-trade- 
> offs (size analysis)
> 
