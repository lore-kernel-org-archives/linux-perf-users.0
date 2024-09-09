Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B11136320;
	Mon,  9 Sep 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896806; cv=fail; b=dtGTFxn6bMP49QgNTFDSqXPuHFzqmsvhgn4ALmljn3YurpzEAGQmjD6uWmSm6BfCYKvTl3DNgOoV1n2VaK0AFvIxMueQhxRhy2ZjcxP3MjYyMaYI6/g1MNTwQiZWszHKXV8nzbqDHuQACmvCrc8uchu5xbvX3XzKmCVeIqnGHaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896806; c=relaxed/simple;
	bh=6DJmaLVkP4ydhGGi+l390wNVlj2p073KZmZXb6o8lxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PjZ3ydX1ecDn17pXAGv4bY9BCNuPdK/bPqRXqikhhM/pMeWAAIrK4s16q1hCxM1Fki2s1NOO+oMQwcJa95FSsRLlaIJtSDQwxBgvpl2J5k428LqrpxNbdcgBDbQbe/ZsGUz7EpuUx0K50BYWeRlCogkovCw6Wnxd5amV4oauy7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d3qX2Zy+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jc7DsqNQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d3qX2Zy+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jc7DsqNQ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489DfUbY008047;
	Mon, 9 Sep 2024 15:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=1Oo5zILm9twBF1rwKMkbPMCTqMuzk36cZm5uPajLc5Y=; b=
	d3qX2Zy+9KrcqxKp9pI3QCnmiTP4pBcGWtJ1Bmys6B9i6Vgw9t3d663TY5RxImHE
	AOvB8nWsO7KrTwPxKWPvUzGwvjPmD2lMigHvHRtcJv8NcE8rVnUMPeU9P9S0gg8L
	4cirflLYSwQQWctSNRog7wFRYNRFbnyjDB+jf6hXwhhmd6o6csDOeFZCQa1Fs5hc
	SLJatIJn3Sd3KU2SCpXZixc75sShwiejHkbv2LYdS0Q7L3I8Ike3tKuV+ebSZcRV
	fEp+fcBLCKbEWUn7kd8KDNiGZXw685xoD7y9rIsqsHdxnXcxdpa94KC0mB3d3woP
	/UZhaOeomsWThbJbS2kRag==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2kbtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 15:46:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 489FJ3et033005;
	Mon, 9 Sep 2024 15:46:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9dmn9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Sep 2024 15:46:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNmoR1STifdoRWBzn+6KQHb8KB6Ris9ZicpIBjzmJ21WnGaj/DubhEMaNtuPdMcIiA8cMd8PzmKZTZVRzNoKzvcvyECG1X2Z0o3eyL2FjMDYjX8kpqPPsoVSAoaWjuEaZK8bwTLyFU0o3BEp1tq8kbhnHRanekZW5mHUjwHTEo1/IZGzCQW1LwdKbPPM8PR8nxk0sAu5zadtrdub+wYWDmcOpqBtVRz7pF9tzE6j5l8r2YMVmIE9QS9o5QVV89LEoXHVEq2nZtcq9Hkg+g5GLTuOjpARHg32N4D6ay31wrIhUSzJW90+wCM0Lp6aK5trmSf7j2vwRP9ufIdJ21+npw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Oo5zILm9twBF1rwKMkbPMCTqMuzk36cZm5uPajLc5Y=;
 b=KSjFeGvrBwICRTSvWlyH+GZMpPOjori1aZE8xzcDpH0nVvTkvvZDFlmNpHfa99vtFyQ74ZdnM32lTDQx0NDDD3Y8TmfDyqVT7fFyVq2O7ft8vfHnWJyK1ucorQdLya3whN93RgRBS0yngwnEffaxbwRmBW32mbeyeghxvHjvcRvbXeRW5/yIyucDkcuVcS+AVB6X+mPWVbT4RsiquYzPkajCoIJoF+uuOSWfDdOgNLkvjijDMGWKkl/WfU5PsVsQk54n8mWw5cqnyY2xPkv3sfRI/XKnrRiqJn4p5xUoEiyOxTiF9H+sGDSUsWWcwtDfXJaCmt4TFNCd4feWO3IZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Oo5zILm9twBF1rwKMkbPMCTqMuzk36cZm5uPajLc5Y=;
 b=Jc7DsqNQapB4TfwwQAED9Y9WHLi1Mv8T1uZcVQJGXTCiZEL0Q7Jl6ILOwsMbVrrfEvoG1AkhucnqjKPea7OlK/JwXXDlBOv74Q6xPTnjJBFKmVNHYyHY6Wf9qhflJXhEgNuAhHywuDX1MojdsIIgBo1IOgWXUyYMoNGbt1seOy4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6266.namprd10.prod.outlook.com (2603:10b6:208:3a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Mon, 9 Sep
 2024 15:46:21 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 15:46:21 +0000
Message-ID: <b3fa69b9-4acf-4a86-9ef6-be89036c2fa9@oracle.com>
Date: Mon, 9 Sep 2024 16:46:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Prep perf trace for a generic BPF+BTF pretty
 printer
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Howard Chu <howardchu95@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20240906195020.481841-1-acme@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240906195020.481841-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::23) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2c2818-d5bf-481b-ea4a-08dcd0e68d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzhndlZ5dEVIUml1a2pGMk5reEptYXdZKzJ0b0lhUmE0b0s2SDZtRVZCb3Nq?=
 =?utf-8?B?L2tFU2xTSTAzNERvbFNPRkVPZkFJSHVwZlVudzZGbnJRbXZEdGdzTVkzdnM5?=
 =?utf-8?B?UmhXOW1tUTlNUUFXayszZ0VTc2IyMTFMYWt3dXhlQktJcjEvakU0aHpaYWJO?=
 =?utf-8?B?VUJXK29sT0QzUDhJTkx3SEFuNVEzRTlReHpCcVZVbGNzaUlyak5zTDg4Q1Vk?=
 =?utf-8?B?Zk80M3lDa3ZjbVlVdFQ3Y2VSWDZlSE52ZGM1YmV2UkMyQ01RZGYxL0RCODlB?=
 =?utf-8?B?UmlmWDFXQVlkN1FtK0JueXZ2N3hmYkZqKzN0UG9SOHpMdHJzWFZzSGs5c0Jn?=
 =?utf-8?B?QmRyUXIvTklCSmF6OU9YT21NRW9jQlhoUEx1RGxLcFQvc3I4eXdjK0RXYndR?=
 =?utf-8?B?cCtZZytFU0ZvQWtpMmtFbWFLaStrTEk4dmV4b2F3d280S2RlbURPZnhNamx6?=
 =?utf-8?B?NlRvWUlXRU9YeFdsQ2UrL3dLaExYYTRNRHNTNnNIUGd1V3BreG9WbmtuN1oy?=
 =?utf-8?B?di9Bc2M1MWNCQVRqSnVuaUlHOWpURDY3N3lkQXMvd24xN2NMOSs1aVRsQVhG?=
 =?utf-8?B?S2pvOFAzTlpQTkRXWS9GU0Jrckl5M1Z2V2wxR2s1T2hydi9wVnRuUlhEeVNB?=
 =?utf-8?B?VWpEMmRwRjVDWFZkaUd0MUNrd1dCMmNVT25PQkRzQ3IvRkJIWHA2a2FRKzFw?=
 =?utf-8?B?OXpFd0NRTlJCQmJTSmNtVkMwSlBJRFBHazlsWU4xSDQxL2h1enhJMGZDa1BU?=
 =?utf-8?B?d2Q5OWhpVytLeXBYVGl6NE54UnVYZ0ZhQVFwd25MbnJaY2ZQaFM1LzRoOXpZ?=
 =?utf-8?B?RGRsNkNRcVA3UzIzakJsWUg3MHV3Y2ZOSFY4SGlGaFRXcm9mbnZNTFlDYjFp?=
 =?utf-8?B?Wnl0NVVsN2hZcmY0dkdBQmxvUVk2VC9aSWY2RjdlTS95Qi9ZYUNObHB0Q1ZZ?=
 =?utf-8?B?K244Nm5STTVQNGZSQVVJcEd5RXM4eXJMaURsMXBJeDFvSTM4d2ltUGpPZk1u?=
 =?utf-8?B?YTdwOWMyK1JDQ2hCaVJ3VjNxZHpwNE82aXpmOWtzRmZqcmxmcFQ3M28vT1Zr?=
 =?utf-8?B?amhpc1E0YUpmWGFzaEN0MG96S3Y5M0lWNXcyTURZdUFOdlBNbVdGSTFpaGNm?=
 =?utf-8?B?TFRWYVBpWEN2MUpuNGVHcFFJVGJKcyt0NTg3Z3FkelpJeGEva1pMSUR5NEpy?=
 =?utf-8?B?OHg0MCtndDN0OHBoUzhxNDRzZ1NCUktyL2pVbjNsMDZxZFRNaTdXU0tmUS9O?=
 =?utf-8?B?NEtWSlFXR0IwTmVramh1MEk4dk1ZVW56OGhhYTl1NGQzWEVJWVgxcWYwb2Fq?=
 =?utf-8?B?cG1VVWJiMUxXVHVIQlQxb0s3T2kvWWZsWjhZNGRtS05BK2N6aExjUHo2OWdB?=
 =?utf-8?B?TklaVjRtWkRISXc2d1dqV2VLMklCSHpwdGZVTXBoREV6QVBCbFlUNFF0am9s?=
 =?utf-8?B?bXRRelpYTHRZWFYwS1FEQ3d1cFJNOVV2ekRtdzRib3NsTm8rNndDaGNRTkVt?=
 =?utf-8?B?K2JhOTNsdXQ0NWh0Q3h0RTM5Zm1uZWVWS2pSb3VhTldENXM2MHRZbEplYWc0?=
 =?utf-8?B?OWIvOGxPdEQzK0lUbWxnK1dUQ0dvaldtdm5NRTNER3hpd25IWVp5TDc2SnlW?=
 =?utf-8?B?bDlkREpsRy8xditCMXZQS0p4VjdBMUo1Ymcwd0laWko5ZUlRSmo1TklYM2xy?=
 =?utf-8?B?UTlFaWdKTUIrYUVvbEh4QkFtWnJreHNVbGo0WXE5TEJBNWRTZ1hFL3dCMnND?=
 =?utf-8?B?Mlk4RmtlZlBaVFFJbVBwRk55emJjZGhyVUNWYWRrbk81NjM0bkM2QzNNNTIx?=
 =?utf-8?B?alNUamZNOXVMWVFRUnZ5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak11UjU5bzI2N2g0NTBxVVNTb2xzUkZ6SU44T1o4L2VVaFdWZW9sY1NYT0JS?=
 =?utf-8?B?akVPdHV2YVJyeStNZXJSdy9iVTRESy80emY1OTYvVlA0SWFPT3NWSXhCd0p2?=
 =?utf-8?B?SEdNZDdGNHhQK3pqWHhlMU85VnBDK1V3SGR0eEtFcEJpWEQ1dDZmSGtUNEZO?=
 =?utf-8?B?TkY0SjRheEVzY0cwRFlxSEh5c2RZTDJZSFk5c1c0QU5FaEtleGMvWE9LU1Ay?=
 =?utf-8?B?N1BWbm5FaXdnekUxUWtjcEZRTjFCamxibm9TbWlIdC9TVitSYnZLdzdUeFEv?=
 =?utf-8?B?TmVaSHkwd3V4QVpGcXkxS2MzYlR1VmRZVE80WlNoUmIvVVpuUGs5TGljTXky?=
 =?utf-8?B?TVpNWk8vM1gzOFdualovSkRSV3FaZXlBVm1jWkJsSWdHSk5yb1Nhb2hGb245?=
 =?utf-8?B?VktTMkRVQmNtLzdjZVNSVmQzcGJ0V1o2NTcyQzRqamx0NDJOUnlnZnpPQndB?=
 =?utf-8?B?WVlSYjdEa0JiOVF6Vm0vdTg4RGpTQ2p6OGR2cG9Sb2RaeExDdVRzaVVwbWda?=
 =?utf-8?B?U2lEV2phbVFoUUJjVUV1aDFlcXVoaDdwWUVZOUFMcTJQY0ptVzdaNVZ1L2pZ?=
 =?utf-8?B?cDlTTWhIczM3Wmk5eEZDdlcrenhoeWVURE85WGVyL0ZWZDZtV3VMRmN0SkZD?=
 =?utf-8?B?d0lTZDRBSnRZbUxONUlzTUpFbENscG1zMmcwdzZSMWRvczQxc05xQ01jWUwr?=
 =?utf-8?B?b2I0MW5jZGlSMEFVVTFBTEh6QnRVOVRGd0NGb1JwWC9ZOVBBTldEOTZCbjdH?=
 =?utf-8?B?TkRjcXN2alBsdFNvSzB3eDFVdW1QRHZDQ3k2UWhNT3hFL05WYndJUWRGVFBW?=
 =?utf-8?B?aFI4NjNjU2FLMXFlT21VOXVCcWxrZTFCYUJnaGFURkVjVCtVazVKNHBWcWpZ?=
 =?utf-8?B?T1Fmd2xTODR3VjRxREJnc2I1QXJaMFpBVCt0WjNEVGdXMFl1dVkyQ2lTaVA0?=
 =?utf-8?B?cUpMbFBjTEFxR011Nm02Z25wd2VGdDYzNE5wQUFteXFpMXJVcEt0N203eGpS?=
 =?utf-8?B?Mzl5K3JMRUZQSTFNVmVMcGFvTXNHTjVOT1ZzUzVlU0xJdnI3ZVBmTGFXeWpD?=
 =?utf-8?B?OEF2RnZoQUJzSnppL1NnRVMybGE4ME5zc0N5Rnk5RVE4dHZGbHI0b0Z1Y3VY?=
 =?utf-8?B?eGRabHVPdi9DUktaV0MwVVNleDNpMUxTb0NnNUZ0OW92S3ZSN0F5c3cvdDdX?=
 =?utf-8?B?anlwWURVQnNGV2MrNUpka25qOXZwOFpncGV0LzYycVJIUUdLeWR5RkxaNnIv?=
 =?utf-8?B?ZGh4bkE0c2tVTE80MDRzc3J4ZEdQNkZxcnB3RGRQendnbHg4T3FNSysyY3Qr?=
 =?utf-8?B?TVJpWkEwaUc0cUZsTEVxaTRDK0FZa2tSUG9EdDRndlQ1ZW9ob0tsQzRra1Fu?=
 =?utf-8?B?SDJqbFEzZjV5ZlBxWHVrZzRKZzh2U2VNWC9tVVE5V1lUazFjOEZDaWlLbWpn?=
 =?utf-8?B?dE1ud09obGhHU01WVlNEWE1BRGp1d21oejZxVVhPNnlYWUF4MjRLNEx6SXV2?=
 =?utf-8?B?TUxENzd2NmJjblAxMm5zY0Jzb2xTNStOdHphdHFrMHpleWFRN05kWitTWWFL?=
 =?utf-8?B?bWl5V1lsdmpzdWNYQkpJYzRpU1ZxS01pN2wveDJPVCt3Y3hWMklxSGdySTFj?=
 =?utf-8?B?R0VocnFpb1k1bC9WOG1rWFFXMk81VDhvbHFvZGEyN1gxTFNScFFNUUo1NVM5?=
 =?utf-8?B?Um5Yd3NHSnBvdEhoUmhGZUZJZlZmMjVBK3EzUlNBRCtGOURNcXM0ZGFGRXlC?=
 =?utf-8?B?NFBvc2lHWTFsU2VocGUvVGhiRjRMamhrYkhVT1dPQmh5bjE1YTF2bVBTVGpT?=
 =?utf-8?B?TS90SWpDUEorQzR3SXozV1FiMnBCRHBuWHJaek9CNENKQ3F4MmVyOHBOK1E1?=
 =?utf-8?B?eThzTlJrSlp2TXYzZXZWRlZRSCtYYW1qMnYrMUtiTmtnS1NHZWVKVUphalc0?=
 =?utf-8?B?V202dDFrcWdTWkdxT0NIMklSVmppUmpDeEFkTjRML2p2Zng3aVJBUUE3YzVj?=
 =?utf-8?B?SlBlVU4rK20zbkNieXRYc3ZRbjlaekk5Mzl0MUY0SXR0UUtwYXlYdEdOQ1hk?=
 =?utf-8?B?SUhla2RJZFA3dGFURkVRdkxWSWJLdThtSWhlTE54alNBZ2tSV1kzSkRiWU9q?=
 =?utf-8?B?SHBEMytvTENJb3QzL25kdzNuSlVTZERmZ2k2bnJaQklqOUVqNEZkV3owK044?=
 =?utf-8?Q?1Xy9Unu6XCPqJU1q2oeYiuc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZDG9zU3GU4Xbg4GyFo9a9SunqpLuSzW1dE05ayfk5oLrFhfEofl0QZeUf1BZ2oeCDQj+4+KxEiC4uqlMzppFfn3vjCBciIcddzuFWaM58heHWahm0Rff1doffIIRvdaeLj0dT6yZQZ+80YWnTNT5AYTTV/izMyoCv7IPw0PZDZeH/1UHTyiTQ2Xroo0Ftlh9InNc1zOZzd8WNsljyICI8I8IxKfWoPhi3hgXlEcekJrwy7PUagqaTTqdHtM1GTAalaWKTFyqe16bk6kuuf6m8AGzSJhke47p/n3Lk9c9FwQ1BuFW6J/yzGxg8CUdedplIvEPTZLJXm4cq4ZfJ6AJB7qFKEGtBX6cWNBOh82dH4q2saYxuRCnoIYrQR4WrojF34aNrOrLenxm53tmbUE7zAe94e02rbWDCmeK8EPiVbJjKO04mGmGCEDLye33eTR8Op7DLwvwJR/ySaKhq4QRlCa6AoODc0Bb+0nbCY3kHRQ4iGA3TxmyOIS95+wUpZc9z5yLksS8eWV9nb6fH1RHCh7paEoQ8zqv4M/85ruHaGnFF+iJJIroIVA6vjnrHwrEFKsdZTlemQmr0Vt4QbQxmEedUIHpQ1GrAtCgLa/cTnM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2c2818-d5bf-481b-ea4a-08dcd0e68d9b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 15:46:21.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tONW36sB3swa/xMbrG7jOE0i0/t5+sEKBbzNIff83unH6befxefrkGGDAKSuok3b3nM6BC8f4Sapr58AsJ/pKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_08,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409090125
X-Proofpoint-GUID: DRU0Xl957F24kosuE2tfVmLUdkBuL9_L
X-Proofpoint-ORIG-GUID: DRU0Xl957F24kosuE2tfVmLUdkBuL9_L

On 06/09/2024 20:50, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
> 	This is an attempt at paving the way for the remaining parts of
> Howard's work on this years GSoC to be merged, as we want to keep the
> existing pretty printers for the few structs we have, that have special
> characteristics (see the commit logs) while having the generic BPF + BTF
> collector/pretty printer, using the libbpf BPF dumper (see more ideas on
> the commit log on how to improve it, maybe even getting
> tools/perf/trace/beauty/ into tools/lib/beauty/ to get reused by
> libbpf).
>

hey Arnaldo

Absolutely, finding the common ground here would be great! I took a
quick look at some of the beautify scripts, and it struck me that some
of what's missing today - and what makes this hard - is that we don't
have easy access to numeric macro name -> value mappings for things like
arch-specific errno values (at least not without DWARF).

In another context, we've seen pain for BPF program writers who have to
cut+paste macro values into their BPF code.  We've sort of solved this
in a few specific cases by converting some values to enumerations. They
then get BTF representations, and can benefit from Compile Once - Run
Everywhere when the macro value is used in the BPF context.

But it seems to me that what both these problems suggest is that it
would be nice to more systematically represent numeric macro values such
that they would be more easily available. I talked a bit about this a
few years back at Plumbers for macros as a whole, but I wonder if a
tweak to pahole that does something like

1. check if a macro has a valid numeric representation;
2. if so, convert it to a singleton anonymous BTF enumerated type that
will not clash with the real macro name (so is safe to use when headers
containing that macro are also included)

This would allow BPF program writers to reference macro-defined flag
values and get the CO-RE benefits they get from enums and presence in a
generated vmlinux.h. It might also help here for beautify where you
could establish name-value mappings for things like arch-specific errnos.

We've been talking about having a loadable module of vmlinux BTF extras,
so it seems like numeric macro representations would be helpful there
too. What do you think? Thanks!

Alan


> 	I plan to work on the weekend to plugging his latest series on
> top of these patches so that we can get it merged in the next merge
> window.
> 
> 	Any comment/test is more than welcome,
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (2):
>   perf trace augmented_syscalls.bpf: Move the renameat augmenter to
>     renameat2, temporarily
>   perf trace: Use a common encoding for augmented arguments, with size +
>     error + payload
> 
>  tools/perf/trace/beauty/perf_event_open.c     |   2 +-
>  tools/perf/trace/beauty/sockaddr.c            |   2 +-
>  tools/perf/trace/beauty/timespec.c            |   2 +-
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 108 +++++++++++-------
>  4 files changed, 68 insertions(+), 46 deletions(-)
> 
