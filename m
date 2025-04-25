Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E0322F15E;
	Fri, 25 Apr 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575973; cv=fail; b=G007YBdlrkYed5s+9ztzlVoYyIzuswqtpRYgJqJqetVgO2aw8U2VEgzEUW5TKb70nRdBqIMAp3GQ+X5Hmk7Pk9s1Mqab0s1tCux6eMRXuvFZ97HEQqFz/fqB2kOq69F/Q7ufVwb4TLhmpaYqjJ473qQgxJU/XmJ+24khwj+rVz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575973; c=relaxed/simple;
	bh=P98RgXVeiO9PcvuBoy/mmlSe5SnjAVhjAt/+7DT9yRc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YAHlfLs9Kb2Dg3mghgwTm8AHeq86hT1c2OV4aseIlM1X62ClSCzKGtrZE2Xafkdf4svtA6HA6niQ8YCBecZMlUMZi6g4Crny9okDO9C4+PbOyDBG3tVqShWPJATH1nKLjFm8ilgJrriiIdZ44LatkoBvdYSyUQhgFbGZq08a03g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hyKurFkm; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hyKurFkm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPkdtTqoWg2dt7fT/CVGN5iR9QzcP5ylo6WzLm6UYXspscM7K69YUDQSGCFbUH2o/EVMBciaWD+q1zWRb4R+7eklasRwCVaNwWhRxtgvfHpUT5twQnWJuDH1jEFJSg6WiMjQVeU/fuVjX9O+JStTQmYhrcCUcdlWS+S/QbyCzXDYhBhbx/LjchKN4fsgf050MB9zRNnASiOADhH0N8cl9YXmLv6tu+Py6DmT8hjXkWwTZ0tUHkJtI5uJEppuR8oO8xKTEyUWU3qNj1Bxd0TVzEf9JZYB4DxGWNk32twP33rFKuME95joOfSCvQAkKy3TcEehGnUgvRnsLvhLx4zrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGQd8Oqr5YLBEJYAQAcYnwVZ+AnehazK0PyV3mELkeg=;
 b=oHYqvdrnZtzdx+57IcJamQiLJ2YT0guOf3PFBmg1khAGlC3V8ZK4FplrWOR5eTg64E3aphlekZZ7CEcnOP3TOHa3MMf+UYapeXaIuCcTJXA0SxTfWvzaYO1ArJAiKPyhoQaSmaI0rHJN0KinBvwH7ddFmQGamHPNa2Ocz61LupErMe4pJojsXJwwKldVk6fNnQmOV8VQLEowBXyS3p4QbL8BlGOlV8DlcqM6r1KQ1MhE8YNZFRf+BxhCrTWku+QtNM6Su6hxcBXqqqfvhkvVXxtsDj4VMQ/6zCAG+qMG69ZSCP3tVTe+z9/LNoLDOSenn8vm+0JxsoP7BuzdEDGZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGQd8Oqr5YLBEJYAQAcYnwVZ+AnehazK0PyV3mELkeg=;
 b=hyKurFkmcLDru+bkwj+D2xL8AHNIbkSweZvbghUm5g2awS9Pgo/yIIq1A68KZznWlIY5FojsLtHcvYR3BcVW1GEd/icVTXbvYb9QZpzZBKgPShb+juM3Z8uRyl3ZmfKl0ygixPCUTIK29mUVN4x6yT320qHBHR6svvLsdgb93a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:12:49 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:12:49 +0000
Message-ID: <a04c37c6-8f83-45e9-a39f-1e1ba613f7f4@amd.com>
Date: Fri, 25 Apr 2025 15:42:39 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf/x86: Fix open counting event error
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "irogers@google.com" <irogers@google.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
 <f8c349c8-b074-4b27-b799-e484631b9b3e@amd.com>
 <1d1cb14f-5729-4200-af20-d66b4feebe94@linux.intel.com>
Content-Language: en-US
In-Reply-To: <1d1cb14f-5729-4200-af20-d66b4feebe94@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 813dc591-be30-4997-c8d7-08dd83e1bb30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2RMSkVUaHhRZ2o3RXloZExFdjlrRXZha0gvZ3BVMEdOa1VabzZiTFlCRjAy?=
 =?utf-8?B?SnRrbFV0cWtySm12b3ZGSjB6RnEzRHNQKzBkUUtYMCtvU3YxeCtCZDF1SG1J?=
 =?utf-8?B?TTlSU3RFUE5zUWRGOVJkbjRQUUY5Szg4a2JHS2VPbFQxaFgwK2pPaGpiZ2NZ?=
 =?utf-8?B?dGZyaUlOT0FHanFSU3dTTEw3ZEhwc3BpZTEwN3l5TmFuaDZoRFNMWEhVK3VO?=
 =?utf-8?B?QkdYdFVkNGJmVFZiNVVVK2gyU3p1VFVodlBJVk8rQVk4dFg5TXNHckJPZVYv?=
 =?utf-8?B?UElCNVJIMjVOcEU4eS9xK0U5UW56ZUx4U2pXSUhIV0NPY1ZtNm9IcnB1dWZE?=
 =?utf-8?B?bVhqRk1yRlNjWGs4dVF5ZVlZWkt5azQyc0NGRFYrNm1DRGZ0bEZSdlFRY2xt?=
 =?utf-8?B?SlJtQS9Rb2pma2pjQUdybTIwa2NsMUN0aU9vcGZlZTJzSitGVlMrVndhTzZ4?=
 =?utf-8?B?M1ZBWGNmVzk3QUlUR3J1cnNJZ1l6QXppVXowUlluVnR3NUxTZzJpT1VtUjRG?=
 =?utf-8?B?V3gxZEtUdVRTcnN5bnBFUkhORjcvYnZSRk9RYVhTd08vbEwvVGgxRklBSmxz?=
 =?utf-8?B?anh4YXRtQjNCL29OWjBlY2RuNXgyWnM2ekkvWnFwVHNuQjJiN1drMTE1T1RY?=
 =?utf-8?B?OUNtcStZNXdwVWdqSi9Ed1p0NlJGMXFlQ1hMYjJmUVBJYmZoaHlpdm5TUjBo?=
 =?utf-8?B?RlNKd09jdnFaemwvR3ozbzRadjEyTTFWSkJ0VzNDaVlsWUZqYWJZQ2NCTllw?=
 =?utf-8?B?U3h6UVhrMXJuSnV3TWdidG0vRlRHRU5mY2diQVlSU3k2cTBzV2ZRQ1VPQXhQ?=
 =?utf-8?B?VWR4R0JhVlhnYkV5cEY0ZmVWdEJyb2NZb29JS2dudWhHOVhSc1IzandWUWpz?=
 =?utf-8?B?Mlp3ZDdVVEMzd1pTWE9iY2V3RzVHbG5VRjU4aDRkZTVxVDkwTmJjZFdOWURB?=
 =?utf-8?B?Q0ZTUmNxc2RuSDB6RGI4cm5mLzNBNGdQOVZEUWc3Y0RvNFRsU0lwU05wNHFL?=
 =?utf-8?B?WkNhUlhadVc0OG4xYnZPL1VsaTVITlFXMjBZbXhtWm1QTjZRYlpZM21BQ2NZ?=
 =?utf-8?B?YXpPZHNmcXpKa3U5Zy9xN29Cc0hnWGVSUWFIYVM1S2VHOXFHTkd3TzFWNkRS?=
 =?utf-8?B?bmdEU2tQck9jN1VHREhRb3oyT0w5cmpydVIxMkU0NUNSN1ZJNkFEMzdEQS9x?=
 =?utf-8?B?TmZQejgveVZFU2luTmd1MVNqTEM2T29IcDB2OHlwQW1PTExRdjMyY1FEUHpW?=
 =?utf-8?B?VkMxeGVIdWE0c3luaGViWTAvTWN1c2pYT2lZQXFEUUx0V1ErQjkvVk9TOUNB?=
 =?utf-8?B?M3V2SVZiVHNpNlZNY3dETVFFa2doeWpHak9GSXNmMWF6YWtXdHFxb2dpOTlr?=
 =?utf-8?B?K1JjeCtzdmZ4M0NJSlRvWTN4VUQ3ellkNVNIKzFZZ2h6THhBSUExSHdOR3Fu?=
 =?utf-8?B?WHhwOHB0eVpURG1EYzNKZEFsajRUTW1yaVlJc0N0YVA5U29kVjk4OFp4REcy?=
 =?utf-8?B?akE5U3llV1BEZGRiWHlkT2ZLYXdxSmtYNkluVmg1czg4VkRFUStnRWI2NjlU?=
 =?utf-8?B?Rm5hdG8xam1aRjEyTXpxdHZSWXR2RjVPNStOZjRYbEhST0hSclVhNGpEWkNy?=
 =?utf-8?B?dlNmKzJrTjlSWndnRTVGR21Pc1FTbnJGNTEwRlhDSVRUYzlyY0lGbGNocm83?=
 =?utf-8?B?T2JqOCtYMTZUMW51bEVXQ3Yyek9sWlprVXdRcnQrSXJGejdQbGR1RWlvUkpj?=
 =?utf-8?B?ejVnamNDTm1pVjFBUENDLzVrK3NqUCtaMFRjYVBTOE5TQWRjd0txZVpBdWJ2?=
 =?utf-8?B?ZHVGNWV2USt3bTg3dzRoaUJIYVVka3ZxSEpXLy9DcktqaXRkSitza0ZqV0hH?=
 =?utf-8?B?QmlTTVlQS0dlY3QxN1JrRDhCSEtQVWVRMmN6VjVVNjVEUUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU9sb2pGSUE0Sk5zR2tYNGdGeXo3UzAzOEExdEFtNmVDTHVHL3pMdEk3MCt0?=
 =?utf-8?B?V0haV1FkT1RSZjJtVFlKQ3E2K00rTC8yMVZZS3Rhb1F2M0t4UEdUZmhSYW4r?=
 =?utf-8?B?ZkFnc0d2MWdSTDJGQ2ZpRnY2bHpVTlUxc3I1bHhVWnUwK2UwdzJsMXNwQkg3?=
 =?utf-8?B?OVpBV3Z6a1lDY2M2bElPQ21QL083MEpXN2QwRUF4UGx0MW5aYmU4NUh1Mk5K?=
 =?utf-8?B?OFNKOVVkN2JQWWVMa2NqYlVpUnBxaVR6MHA1dGFOUk1RU2FiZ0srdjF1QmF5?=
 =?utf-8?B?T0ZRa1Y5aVlTb1grbnc2YkJHVTh0MFJsSUxKQTB5a3NDc3V6MUlTRHZTQXBY?=
 =?utf-8?B?TitUZVdzNDZlTTRDc1hDSXc2b3NSZWFra09BdzJreFNFSUhzWWNrMEIvcDl5?=
 =?utf-8?B?aGFrejBjODd4djJXTWVVVUxYelRKVWRIZzRDYUZXNk1Ma2R1YVF4dlNhUm5W?=
 =?utf-8?B?a3lPdFdIS3pQT1h5SGNOYUhiMDZ6TGdoZ2trOEVJbXAxYWRQdDRZRGxvR3lS?=
 =?utf-8?B?U3ZKeWRtdkpXaWF4ZXZoQURONENUN3IxQU4venh5d2JlV3pkdkdwNjlUUlk0?=
 =?utf-8?B?T3hKMXVYU1JjcVVxRVpqcG84UEFIN2Y5aGJqL0xGOVNEc1dkMXNsMnUrVGNW?=
 =?utf-8?B?bWtRQjhsUEYvMXByWndOTFB2ZUZLK25qRVJ5VTlXQUNFM1c5WTZURjJ2N3p0?=
 =?utf-8?B?bDJ5WHpVUWMxd1ZzVFZET3cwRWhYNkNML0VRMFNVSFJjRDg2ajBVdG5uNHh6?=
 =?utf-8?B?UWJOcHo1L1IrUTgzS0tSY0wrVkRHd3BUYzVSYzNRTXhxdDdXWnJHa1RKbEJ2?=
 =?utf-8?B?QjlVUUNIekdzd2ZienJNb0IrWWhsRnpnOWF0TTNTbzU4Si9kTk5SVkg0dG05?=
 =?utf-8?B?Q3hzT1NpUE1vR2tnKzlZdFRFemh4L1lsRi85Q080cmZXSUxTdldDOXVVaFl6?=
 =?utf-8?B?eHhhc1FuWUQ5ek5reTN6YldUQUhzWmt2am8wUndCRkV0VG9LZ3RMQjdrVDJj?=
 =?utf-8?B?NnhWSi8vQVdwbGNKdlJqZTBHU2dkaDE1QVJJZlZpVWFLdHBhamt4eFY5aHoy?=
 =?utf-8?B?TlozN2Z3ekwvZVVoQnFFYldrWVc2bUxkUDRGT2xiZFJGVDRJanJWNzUrSStX?=
 =?utf-8?B?clJkclJFbDUvSlpsZ3FhNzl0S3JRUVpMaDFUQnJ2VWV3dVJ4eUp4REw3MG4x?=
 =?utf-8?B?WnlxMXBSd2JLT3pKY0EvY2FsTG9wN25HeWF2ZSt6RWkyYzB1YnppeHNIblhY?=
 =?utf-8?B?RkhJRmFHeTFramp6NjQvM2JDaTFjVTNJWVB4WnR3UkxpL1lKcmJVTldUQ0pT?=
 =?utf-8?B?VW5oZjhpc0hPUkZHQUdUUkVwWVpMZld3Y2M0N3AwQnNhbWVoWEZ1VDVlUHkz?=
 =?utf-8?B?T0F1MTBpOHFZUDQwUGhPMXk5VjVrSlpOSXo3ajNENXR6SVJyMEZTQWo3SXRk?=
 =?utf-8?B?Qkd3UkdtVFpuOFltc29NSG1wRGxsZlYrbjdZUUVXV2k4RUpXMkw0d0RRRGQ2?=
 =?utf-8?B?bHN2SzREQ2JZa01zOWxTcURCam1lNXh2RitLYklrTlV4eng0bm5xaFpZcWlP?=
 =?utf-8?B?RUJvbUVsaFAwdEhYV1pQSlhxZDJTUXVFcWFsem4vQjZocE9naXp2S3k1VWdY?=
 =?utf-8?B?Rm1nVFl2ZEtTSk1qL2tlT1pkTFVXSnlGc1FjQWFtamdoaFl3dW5uM0hkNGoz?=
 =?utf-8?B?dndGTEhuUVZvNFhCM1k2aWdSbUxqN1IyOHJHak10SGQxL0s4Ykd3KzkzV05k?=
 =?utf-8?B?K3V5ZmtnL083T1Y1UW5INS9qNWJNZmxLUE4xN1RaLytrV2xyU1AxTXJGeE5C?=
 =?utf-8?B?ZWZ0dTJTS0dTYlp6aVgzU1YwWGN6aWNSYXQ2aHpFemhqbkFaNURkc0hlVzhW?=
 =?utf-8?B?VXhVM21WdVlzNEtBaElnRVNDNWFNTFM5U2R4RUVjUjVqWiszbDlpVzBZb0hV?=
 =?utf-8?B?cWdSOEtuOEZUTDRYcUFrK0Y2ZFgxS0tmemFjMDVzbnRHc0c0SjJaSHBpMzBC?=
 =?utf-8?B?K2VoT2U2Skd3M3FReXFGdEZrdDRhS2h1ekVFQUtxK09MSW5ZbmxlWnk5amlp?=
 =?utf-8?B?UkhvYzdUbEhVclNXV3lCT1M0RC9GeUR0cFBqYVJSM1NEbVBuMnA5L0dXN3B4?=
 =?utf-8?Q?of8t5gHTyvtJust43Ll/u4HxM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813dc591-be30-4997-c8d7-08dd83e1bb30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:12:49.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IimcvzGr/gKzpI7QAP49ZSE/Ue2uBhw6Rz7DZpf2IretON6CqxTqT5mv+oJziE/ZKABhuzLcT0qkfY+iEmTCug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946

Hi Kan,

>>> Perf doesn't work at perf stat for hardware events:
>>>
>>>  $perf stat -- sleep 1
>>>  Performance counter stats for 'sleep 1':
>>>              16.44 msec task-clock                       #    0.016 CPUs utilized
>>>                  2      context-switches                 #  121.691 /sec
>>>                  0      cpu-migrations                   #    0.000 /sec
>>>                 54      page-faults                      #    3.286 K/sec
>>>    <not supported>	cycles
>>>    <not supported>	instructions
>>>    <not supported>	branches
>>>    <not supported>	branch-misses
>>
>> Wondering if it is worth to add this in perf test. Something like
>> below?
>>
>> --- a/tools/perf/tests/shell/stat.sh
>> +++ b/tools/perf/tests/shell/stat.sh
>> @@ -16,6 +16,24 @@ test_default_stat() {
>>    echo "Basic stat command test [Success]"
>>  }
>>  
>> +test_stat_count() {
>> +  echo "stat count test"
>> +
>> +  if ! perf list | grep -q "cpu-cycles OR cycles"
>> +  then
>> +    echo "stat count test [Skipped cpu-cycles event missing]"
>> +    return
>> +  fi
>> +
>> +  if perf stat -e cycles true 2>&1 | grep -E -q "<not supported>"
>> +  then
>> +    echo "stat count test [Failed]"
>> +    err=1
>> +    return
>> +  fi
>> +  echo "stat count test [Success]"
>> +}
>> +
>>  test_stat_record_report() {
>>    echo "stat record and report test"
>>    if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
>> @@ -201,6 +219,7 @@ test_hybrid() {
>>  }
>>  
>>  test_default_stat
>> +test_stat_count
> 
> I think the perf stat default should always be supported, not just cycles.
> Maybe we should add the check in test_default_stat?

Do you mean:

  if perf stat true 2>&1 | grep -E -q "<not supported>"
    err=1

Isn't this ambiguous? Also, this fails on machines where HW pmu
is not supported. For ex, on my qemu guest with `-cpu pmu=off`:

  $ ./perf list | grep "cpu-cycles OR cycles"
  <empty output>

  $ ./perf stat true
   Performance counter stats for 'true':
                0.42 msec task-clock:u                     #    0.470 CPUs utilized
                   0      context-switches:u               #    0.000 /sec
                   0      cpu-migrations:u                 #    0.000 /sec
                  48      page-faults:u                    #  113.874 K/sec
     <not supported>      cycles:u

Thanks,
Ravi
