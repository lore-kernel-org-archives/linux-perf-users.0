Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04AB156230;
	Wed, 15 May 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789412; cv=fail; b=rqUNklGU4AAkKFIQ8dPW0uCwiv5DrgsiOFMatemYywDfyopAwjIq3iqQQmhbDUUy5I4cdNSo9VYz15IC5QTXMk7FDou0t9WlQsfY/MrCvVu/MUmlF5dPVVoGhN5AIPVvsYDa4+KugOpNubZfKFw0e9031PcMpnneiwMkQa0to60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789412; c=relaxed/simple;
	bh=IedjJ4sTl+Bh3iwj//LOb2+4kSp/CEW+pa4Q2EARzAM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EZYIpx5l6QDEI4wOHBbCBdAV6NF61rO4k2WrDtW833Hb6+nCeXWVZbM5N+Mr97yfzeQl5F52s4WgXcdUoEhcmnLDxaQBp9kB0q4NG5B9yZFs1+IBI86V4+LGKt62CYSNT30+adgFEs5EYxjC0MFV5gAZAuLmr9RTLy86i2NaN90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Br1GWYGN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k4FOhBMF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Br1GWYGN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k4FOhBMF"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FFBosm001352;
	Wed, 15 May 2024 16:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tsuwZEEeSTH5PsAt3NSOnxyQ98+LIHHqke37/bQrj64=;
 b=Br1GWYGNPuJnfq0Fl7Uj6p0wdf9A8ujePhwim3igdTfWzCd/mA9Ki3vKnKiQjkmreWQm
 hCv4C2Bd0PCPbxIob743U4widhf6F0CamVjPnMMA+k//BUqXgl1+ald5UpL3TiQsP9sd
 B5iXESy9XssmXBxOCEuYoT24nahAs8EvV3yfI0Sw3f6db7H2U86/+Np/UETDVxsxsj4q
 N0rYSD2W9IxKtwyjPQz1kgAQJF+htvByj9ciS5KWKoqUizzGhot1faWew2EXYEqeWF46
 /XSJXaxP480gSqrPr6gZK5dzRoFofrgFRRq3234q9j8Zpsfx1D1aaS9JoGzGZkg/xLHd bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3t4ruhw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 16:09:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44FFjwHa019195;
	Wed, 15 May 2024 16:09:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r86j5pq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 16:09:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9e4pbV6/DGhkBv6iEJ4/WCgOiWBHaePoP+i9XI1oO7caeCztH+wqk5m6DKNUxQpjYQPKhAOMTo5jn8YrfnGdEinhvnuI27oV1Q2wVMBP/E0nHHKAr7E4wYqTJYmHq7EPrxuxRvz8HAJBb2xqT/A48mnx+zZYO4wLFptYIf40s27s2Td+hxFZ1Q4s79liv2hIE4VZQpRiHuXlqCB1f1e+oQethqteU5J23uXbQx56ADwT40stmiO5I+oFZ8y/XIYRvipl8jaDt3cgL9aWaRc5Sx/+3EgMkYcnrC4Sy6K1MG0DN6+M1o56otW1bU1zjbWyvN7a2k1h5fzyGYGPcWCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsuwZEEeSTH5PsAt3NSOnxyQ98+LIHHqke37/bQrj64=;
 b=c2mo2bma4+ULJhPbBubwHjpRkVBY5o0vlztspVnQv//h2/nylnuM4M9e+HEDLjiB8xyjTDJPdCgfaBaGiOcU4WvBlrhEJg97t3R8weWwczwxqyC48xDxzOLMYyZ48bVqTaCjsyso4Tpm9krVwGVUrEkAGIJGa9RxXl/Zb/uZI+Q0fYd/dy2lIBxe2E83xfHg6F0cmTKqVTSTs/N5at0SQMs5UX95Nee9mk3CcyHsK+KStEkQdXKc2l9U3X2sBwkViRuGc2VTEzrQ2NArO6fansahnrbl7aGo8W7EFT8Ks4yJ6J/eUzCBbot0IcY2PldbZUPwNYWZRb7Vl6E+J3h+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsuwZEEeSTH5PsAt3NSOnxyQ98+LIHHqke37/bQrj64=;
 b=k4FOhBMFFkLCQF6Z2+bPdTP/ln0WKQJO5vTFwEhNJCa5O9ahi1Xa6k+iTRkX8ZAKVUzB8PVqz+KQJAJZprKMgAhOZrnL+6JJ+AOtGrFjOMVVSE6UVAKFtl/WqB487ZCNCYsL4oHh5QXIQNillwiSkPA94E7ejPYl4b9pB/ufGXc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 15 May
 2024 16:09:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 16:09:48 +0000
Message-ID: <b205e882-a9dc-44fd-bbc3-53089433eae5@oracle.com>
Date: Wed, 15 May 2024 10:09:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf pmu: Count sys and cpuid json events separately
To: Ian Rogers <irogers@google.com>, Jia He <justin.he@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240511003601.2666907-1-irogers@google.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240511003601.2666907-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR17CA0047.namprd17.prod.outlook.com
 (2603:10b6:930:12::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 271e038a-7764-49e5-8357-08dc74f97193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b1NDbUgwMUwzQ2U1Q21URXRUeVA3eXQvWmFxTUp2N3h6N1V4dnFoYVZ4N05V?=
 =?utf-8?B?Uk4wWHlBTXVnakNyWDhqQ3JUT3BiakdjU2k4akpWTCtCNGU5eGUyRmRNRktP?=
 =?utf-8?B?Uytja3BZNTlXTmdZSVFPbXI1YjQrUnRWK3BHbXBlYXNuNmJkMlpzeFFiU1k2?=
 =?utf-8?B?N2JGVjlGVmhTWk1pdUo4K3RJQjh5MmNqWW1mR3c4ZU91UVBVMnNYcjlKMzhK?=
 =?utf-8?B?dXpvc0E4TEJSQnpCRjZmNzNYNU5LQ3lqVTUzVkFOZ090cFJrL3MzcmJuTDNn?=
 =?utf-8?B?UmxzZlZDQkYwZmhBMHI2V1hsK1F2eE9nOSswWXJqaE5KUkJrRzRVMk5tRmZl?=
 =?utf-8?B?UjF2MTJnbEx4VEw4b01hWHJkQUdpT1ZqMlRQdVFycEVsWTQ4U1RkdEExWFVC?=
 =?utf-8?B?WU1FWUZ3OStzN2xkTlZFeGVEZFVJQjRlWHJJdjVpNGlZU2lZQ0UrRXFoSXFQ?=
 =?utf-8?B?dkpaVUcwUXA3SWRySERFeXlaYWFqKzBXSUt5MVJYdEsyTmtxaFYyK0V4aThX?=
 =?utf-8?B?VXRRQ0RWL09KK1FFVk8vTHFzMXlZY2ptaXgzY3NGTitpOWxrdk5NUnArMDRH?=
 =?utf-8?B?STdHSlI0THI0aGl0bEJydzN6aGRnQ2ZHU2VScWZ1OUxvN2hRY1FCVlFGVE5w?=
 =?utf-8?B?LzNEUkxJM1E1ejk3VXh6bzdvcllpbm5kVDRHK05TcE5XM2JQTUdOSFRGOVgx?=
 =?utf-8?B?MzhiMEdZa0JVYjdWdzNmUVRnbVlHNmVibkREd0pHQ2FsdXhYUzg2cGtZRk1J?=
 =?utf-8?B?UTdqWWZzUFdoQmVueUlaa1JUUlVCbm5HU2FuZ2h1OW15Y0VDREdzcmZyN2l0?=
 =?utf-8?B?OC9ETUNSN0l6ck50aFI1MERZWGplS0hUWFh4dkJjYWNDVWpwTnlScVBqbW5P?=
 =?utf-8?B?R3dWcDI0b09CYStxRnpvcmxySk1hVVJrZzJWOUN6WXhEU3F0c0F6OVhyODVN?=
 =?utf-8?B?RUJEcjZVVlZEMCtvN3NLQjEyMFdISFgrYi9EeCsrU1N0Y0lJWlZXZWNoY0pT?=
 =?utf-8?B?RC94L2dwMlJnY0hqME93bElJdjZvSFlNM0xzUFFqaXJHdGd5QWZLd081dmRB?=
 =?utf-8?B?emZFY0dpSFlSeWVkTmMxVnNqMndlZFNDdUN6YURUSGo0Y0krNVBvVWFHSHho?=
 =?utf-8?B?ZUVVbXp0WXdlQlRGazg2bTFFbWNhdVhTV1FQM254dTkvMGU4eTF6Nlg4WTJk?=
 =?utf-8?B?TXRDZlJBYWoxaHVWZmM0UkNFSWtWUCtOUldIRjVlSHd4TmNFckxYM2V0ajRv?=
 =?utf-8?B?NWVPS1ZGR1ZBVjgrM2RCMWpPSTVhMFlEUGl1UlNTNVBkUDdDeVZGY3E0SlZ1?=
 =?utf-8?B?NFNQWk5jalUwb244Q3IzRmhETnFKNnpycW9zSWVadnp2Z3g5Ylp5K0hxaWtR?=
 =?utf-8?B?YURjL0lONUNoZWg5Qjl3MTFvTGRGMkhldmRpSmh5cVk5ZFVKNDVQWWp5Vi83?=
 =?utf-8?B?b01wVUlhR2tsQm5pYjdWQ3pOL0dqaDZKNGxJVjduVTFSTlFCekRQQ2pHVmt6?=
 =?utf-8?B?bXEwNWVQU2RZdlYrdGFFd0hUZ2ZTOEpyM3RwZ21VT3o3YXpTL0V3N0dTQWpy?=
 =?utf-8?B?Rk0xL08yMlVaUlExN1lkOGMyRmdsL3Noay9tbjNmaVJ2bXEyVW5pL1MyNTVk?=
 =?utf-8?B?RVB0ZzViRkZmZ3NGM1NkMmdNL2FoUVJTK0dIRkw0T3QrVFlXUHdCNE55V0Z6?=
 =?utf-8?B?Mzl1dXloQ1ZOL3FUSXg3cDNRazY0R2NEdFVjakgrU1VTYVVIVkoxSm53PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cFFNSEU2Y3pya05meWZNdEdCaDFaZjdYcy9nMFYrZ3RydXVsOTZFMUFYYnRn?=
 =?utf-8?B?aVF4dWRaMjh6eGM1b2JtL0xRZ0pkNDdjQlVyWk5KUkg5RGxjVHFaWHMrbWp6?=
 =?utf-8?B?ODhQbWVkZWpka3VYaXJuT3AvNHZPc21aT1RkckxrRW5MbTNvc2dLZ1Z2SWtp?=
 =?utf-8?B?aUlSa2VFdnFaVXNYY0FYL0ZCMmF1aWhPZmtUbDZMazZjTjc4dGx4T3Fvcm5n?=
 =?utf-8?B?amN1M3RlSG9EL0VyVC9DOVlpOEJKMzRoMEEyb1JJWkRQYzZWNldTOFpGQWlK?=
 =?utf-8?B?SytkODEvdktRbkNnWnJ5TktpTjc4Q0J4c201VzlrbmpxU1lVeGIvQkdoQWIy?=
 =?utf-8?B?bXNhK0hMbEF2bXgxWFA1aWp4YmNJM3dzTXZWUmhTR2dzWG9McGkzWG5ocVVO?=
 =?utf-8?B?eURLY2FVbWg4T0RlNXJNcTVuZTYxYkdncnlRTnZsc01vYkFlMnh2VGxYR2t4?=
 =?utf-8?B?S2JPMUllYkRwT1FkM1ljNEphWUFyTmplNUcycHk3cDcyeXRrZ2phTHVCTW9n?=
 =?utf-8?B?WUExWmMwWU5sMkhtYnlzSXJySGRCbG8rZ3Z0MFFVbkJ1UUM0eURPeG51allC?=
 =?utf-8?B?QXAzWGJkSGJpbmxtelpyM1BsYlY5K0Yvdm1WaGw2Nzc3MENmcFVIZFUzS2JY?=
 =?utf-8?B?ZHhGUUJ3ejYrblZhakpEU0NvenN4dUdpRk9VdWc0emhUdDJYNFFSSUVYUko0?=
 =?utf-8?B?VDhnY2cvNHltSEJHemxzOGVmb0NKbjQ3NU9GNXNDSTJBUGNObXd4ZXBHMm5Q?=
 =?utf-8?B?V3QwNDg1c2hnNHlhejViZW9SK0M3Ynl1cTNhZVMxRWRDZk5VNy9ENGZpbzEw?=
 =?utf-8?B?UTR0R0p4ZENGbGlpRC9uMmJUdTFuZVZnTk9hSU5kUXBhZlV6SHNHN3JUN05h?=
 =?utf-8?B?ZGt4THVXNWlxazV1R0RsSG84aThCQzd1T1IxL3BwOW82Nzl2U0RsbUlOTTZk?=
 =?utf-8?B?OWVNOFdOMmJkSjdoeG5zUHp0Y09HMkpSSW5pRnlENTBKVWQ3MXgwVjUvYUlk?=
 =?utf-8?B?QVZGWWZmMS80VFlWbUcrSVVLazJ0NnJ0Rmpta0xubXlidzFrM25ZQzl5T3Jo?=
 =?utf-8?B?aUttd1RmeTFEQzFiR2FkYmUvaW1wdmJvc0Y2czQxQWU4aXZYKzRiZ0pqdE5o?=
 =?utf-8?B?L2hNUEFUTzlxMmUxc1dWY1U4Y1NOZ1l1ZTVKZEp5UjVOZXRxK2U1RUxVamJm?=
 =?utf-8?B?WHhsK3NlSGFjQlpVQUN0Q0E1Z2todGkxS1pwTTdhL3NzbHJMbFh0cEdZT016?=
 =?utf-8?B?Y3VGRkNESWYxYVdFT2NKNGMxYktvaDVBN1Y2WTVoYXJsZjR4TExHVjVBOE04?=
 =?utf-8?B?RHVnNVRFWGh6VHlmeE05NlY0TDhzUnJpU0ZIUXF6MkQzRnlzOTAvc0x0eUtX?=
 =?utf-8?B?MXFyRWova295dnJLdW1kaGVMV3NreDlVR1dvemxldUZsWUcxWVhHQVA4dVJB?=
 =?utf-8?B?L05vTkkvWEJkTktwNHFvcXh3ZzV0U1Q0MEVRS2RrWUZSaTM5c3dRbU5TdmhX?=
 =?utf-8?B?NGFxeFluUTVDRWwrNEorVFFQcGFId1F0YW5Yd2lUT2ZvRDlGTGZsN3g1K1lJ?=
 =?utf-8?B?b05kT3kycUVDbGR3dCtFcVV4SUExOVU2Z1B1TzU4R1FtRHVlWHUvTGZEaXlz?=
 =?utf-8?B?V2Q1bDBES1pBTGkzVkJTZ1ptNWhSRzV5OXcyNW1zaDAvVC9vaVFoYkQ3MXlO?=
 =?utf-8?B?M0VIT3FGbVZuQjhodFl3TFlGMkFLY0QyY05QdUJyc1B3dkw4WFJ2OEdzZFhw?=
 =?utf-8?B?VnB6ZmFVSDhQQ1N0ZkR4VW9iYy9jbSs0YzFlaDhvNG1vSW5KY3lkQkRtUmNV?=
 =?utf-8?B?RlVtTUpaTDAvRnpnUkVEQm1aTTV3SWhubldIMXozeEorVG5BbC90TG1mRHpS?=
 =?utf-8?B?bE1ySVhLL0Q3Y1BMR2RrcU8zdm1PSnpIMmtBWVNrYW4vckFQTUg3bUIyZFpJ?=
 =?utf-8?B?azFLdDdhbHhQSHY0Umh0dFBMT0gxS09PN2JYYTVML2lFeVp1eWRpSU9lREt2?=
 =?utf-8?B?YkFxcHI0NjU1clRVUTFlaTY5U0JSMVlJNnVsVlZ3ZFlEanRmSWxPQTM3L3pF?=
 =?utf-8?B?YkRlMUUrQTNleUpRS1Y2NCtBRzEvaDVtbnNhRGZEc3NicDRnd0VOMm1jOVVQ?=
 =?utf-8?B?dS9ralhLVTdXNVk5V1FwdTFrdUVjSjN3QlNCWEJHQnZIOGJkRGE4M0NBcnlz?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	axUY2MLq1FSvF303RDC5EdueXiH1kILfTNQPUlNEpclHsRTT2HmBqbAzibiTelQs76L5xG1iKZA/Ocx/ac1VkMnZprF3zJfzeMgTxcn2E3CsL8+0FV9JEhGiyrR0L7/Fben5NR+VK7f1+koLl2Nr+KJgXrrI9vXh3FUpPdyC96QNq3Zfk8PQT3J9vajbLhpi5WyYpgufx7KgDTXFt0yWVcbaYyLSnlheISmLaV5HnxUXR7q4d9oc9nC1MVt81twk5xhsbMHm7Ntkb5iahGrdOOeCpHncCcQhY+rO60JjFcbp/5atsCHKYFsEimXinADD4uUrYZtQCB+Z9MRkgfGWBNJpc6WJSeGv18VNyDC3J2oaFw088gZiSDy8WNaun274mANkqTOH72pYrrixdLZWSy+9xdwxLftcjTDRuD3LZT/hetYUC+hdBEU2O2Dl+LYdlvWN2chQ5JZ0antvmR+EiqtZZiwmAGdmI3xbK2WrhKyjrYrc0hWsnL5myHlWyDbmXiyepmObYH8uIBMsrFC0rPSmI6PZ1jBLOJauOHnXzMavof4TNZWuV5y9iG7YyGnpPRMDJJWJqIiRsYp7EBJbYSrMfAc4/VboxD6Cu/wrlww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271e038a-7764-49e5-8357-08dc74f97193
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 16:09:48.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq3w0qKmxcQ3gyQJcIW8SaXkFx8NA33p4xNcSkcPAnU4UirhXf3xSUrBC9HjjVLEgG2dnjr+TdFCF1JrblI7ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150114
X-Proofpoint-GUID: CteOgCWnGx-UEskEUcjS0du_llLtX-IN
X-Proofpoint-ORIG-GUID: CteOgCWnGx-UEskEUcjS0du_llLtX-IN

On 10/05/2024 18:36, Ian Rogers wrote:
> Sys events are eagerly loaded as each event has a compat option that
> may mean the event is or isn't associated with the PMU. These
> shouldn't be counted as loaded_json_events as that is used for json
> events matching the CPUID that may or may not have been loaded. The
> mismatch causes issues on ARM64 that uses sys events.
> 
> Reported-by: Jia He <justin.he@arm.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/lkml/20240510024729.1075732-1-justin.he@arm.com/__;!!ACWV5N9M2RV99hQ!KVhaRPLqS7T1s6p506Gv0zFNdlTR1exCUrXM3UIDr0EdrRFwrzM3W9ntkxw42jNeG01P7H78r0c-nz8FVQQ$
> Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/pmu.c | 70 ++++++++++++++++++++++++++++++-------------
>   tools/perf/util/pmu.h |  6 ++--
>   2 files changed, 53 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index b3b072feef02..888ce9912275 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -36,6 +36,18 @@ struct perf_pmu perf_pmu__fake = {
>   
>   #define UNIT_MAX_LEN	31 /* max length for event unit name */
>   
> +enum event_source {
> +	/* An event loaded from /sys/devices/<pmu>/events. */
> +	EVENT_SRC_SYSFS,
> +	/* An event loaded from a CPUID matched json file. */
> +	EVENT_SRC_CPU_JSON,
> +	/*
> +	 * An event loaded from a /sys/devices/<pmu>/identifier matched json
> +	 * file.
> +	 */
> +	EVENT_SRC_SYS_JSON,

If a json sys event aliases to a EVENT_SRC_SYSFS event, this is 
considered a EVENT_SRC_SYS_JSON event source, right?

> +};
> +
>   /**
>    * struct perf_pmu_alias - An event either read from sysfs or builtin in
>    * pmu-events.c, created by parsing the pmu-events json files.
> @@ -521,7 +533,7 @@ static int update_alias(const struct pmu_event *pe,
>   
>   static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
>   				const char *desc, const char *val, FILE *val_fd,
> -				const struct pmu_event *pe)
> +			        const struct pmu_event *pe, enum event_source src)
>   {
>   	struct perf_pmu_alias *alias;
>   	int ret;
> @@ -574,25 +586,30 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
>   		}
>   		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
>   	}
> -	if (!pe) {
> -		/* Update an event from sysfs with json data. */
> -		struct update_alias_data data = {
> -			.pmu = pmu,
> -			.alias = alias,
> -		};
> -
> +	switch (src) {
> +	default:
> +	case EVENT_SRC_SYSFS:
>   		alias->from_sysfs = true;
>   		if (pmu->events_table) {
> +			/* Update an event from sysfs with json data. */
> +			struct update_alias_data data = {
> +				.pmu = pmu,
> +				.alias = alias,
> +			};
>   			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
>   							 update_alias, &data) == 0)
> -				pmu->loaded_json_aliases++;
> +				pmu->cpu_json_aliases++;

seems strange that matching for EVENT_SRC_SYSFS increases 
pmu->cpu_json_aliases

>   		}
> -	}
> -
> -	if (!pe)
>   		pmu->sysfs_aliases++;
> -	else
> -		pmu->loaded_json_aliases++;
> +		break;
> +	case  EVENT_SRC_CPU_JSON:
> +		pmu->cpu_json_aliases++;
> +		break;
> +	case  EVENT_SRC_SYS_JSON:
> +		pmu->sys_json_aliases++;
> +		break;
> +
> +	}
>   	list_add_tail(&alias->list, &pmu->aliases);
>   	return 0;
>   }
> @@ -653,7 +670,8 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
>   		}
>   
>   		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
> -					/*val=*/ NULL, file, /*pe=*/ NULL) < 0)
> +					/*val=*/ NULL, file, /*pe=*/ NULL,
> +					EVENT_SRC_SYSFS) < 0)
>   			pr_debug("Cannot set up %s\n", name);
>   		fclose(file);
>   	}
> @@ -946,7 +964,8 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
>   {
>   	struct perf_pmu *pmu = vdata;
>   
> -	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL, pe);
> +	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
> +			    pe, EVENT_SRC_CPU_JSON);
>   	return 0;
>   }
>   
> @@ -981,13 +1000,14 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
>   		return 0;
>   
>   	if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> -			pmu_uncore_identifier_match(pe->compat, pmu->id)) {
> +	    pmu_uncore_identifier_match(pe->compat, pmu->id)) {
>   		perf_pmu__new_alias(pmu,
>   				pe->name,
>   				pe->desc,
>   				pe->event,
>   				/*val_fd=*/ NULL,
> -				pe);
> +				pe,
> +				EVENT_SRC_SYS_JSON);
>   	}
>   
>   	return 0;
> @@ -1082,6 +1102,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
>   	pmu->max_precise = pmu_max_precise(dirfd, pmu);
>   	pmu->alias_name = pmu_find_alias_name(pmu, dirfd);
>   	pmu->events_table = perf_pmu__find_events_table(pmu);
> +	/*
> +	 * Load the sys json events/aliases when loading the PMU as each event
> +	 * may have a different compat regular expression. We therefore can't
> +	 * know the number of sys json events/aliases without computing the
> +	 * regular expressions for them all.
> +	 */
>   	pmu_add_sys_aliases(pmu);
>   	list_add_tail(&pmu->list, pmus);
>   
> @@ -1739,12 +1765,14 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>   	size_t nr;
>   
>   	pmu_aliases_parse(pmu);
> -	nr = pmu->sysfs_aliases;
> +	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
>   
>   	if (pmu->cpu_aliases_added)
> -		 nr += pmu->loaded_json_aliases;
> +		 nr += pmu->cpu_json_aliases;
>   	else if (pmu->events_table)
> -		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->loaded_json_aliases;
> +		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->cpu_json_aliases;
> +	else
> +		assert(pmu->cpu_json_aliases == 0);
>   
>   	return pmu->selectable ? nr + 1 : nr;
>   }
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 561716aa2b25..b2d3fd291f02 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -123,8 +123,10 @@ struct perf_pmu {
>   	const struct pmu_events_table *events_table;
>   	/** @sysfs_aliases: Number of sysfs aliases loaded. */
>   	uint32_t sysfs_aliases;
> -	/** @sysfs_aliases: Number of json event aliases loaded. */
> -	uint32_t loaded_json_aliases;
> +	/** @cpu_json_aliases: Number of json event aliases loaded specific to the CPUID. */
> +	uint32_t cpu_json_aliases;

it seems strange that we allow a pmu to have both cpu_json_aliases and 
sys_json_aliases count. A union could be used, but that would complicate 
things.

> +	/** @sys_json_aliases: Number of json event aliases loaded matching the PMU's identifier. */
> +	uint32_t sys_json_aliases;
>   	/** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
>   	bool sysfs_aliases_loaded;
>   	/**

