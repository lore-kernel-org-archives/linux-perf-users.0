Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7891FCD0C;
	Mon, 27 Jan 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968388; cv=fail; b=jOoHQwuRCJyRoJ+Ouxq8nSDwIaojdsrRRrXn1So9/UfDHNqqQjJyUP1Vp7TFsTbO8sNDzDCNqfD79kQaatdPYnijEbmGPM376eJIA220jTQG4yaxg4l5ndi37V7uLX4gRy6f67DDpcW2KVNeWuokMMKbIwTxs2IGZWFoZSpHQP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968388; c=relaxed/simple;
	bh=JHI3hBFwkyMnBmWSwYw1ZAkbRdfo4wJ35q/cdse0kGU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ez2YBCTTgfkwuOrq8VT05Tzwbel1zPDRKapmHkjvq5E5nDwACaHSUIXju1/ZKikknwg/QOAQz3qPpcZiD8g/ka59+0hDq5gN+ZnEdw3r0nIePVIGwal3rdAnpoUi5il7QJ+qoPEjGA/99yY/4CVb47oqGbZ02PDijzzctMl8Zl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R1YUIMUl; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R1YUIMUl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur1JjgCcjj8C8lzu3SZkt/xUyVF5GEiR2FpkwcruaJfNMWd9knbMHyWwICUvH3ezy9pMqO07eUiETyicy1iH0uDuJi1kItgfKHxfULbjhgIJE9VEBQjbvM7hArztNXqa8FJ9ANskQa5GJE/55Xoepksi+cA4c2TWybXeVSvKjKA6UJlEtBvBj8hZcwJmQTr4lIVzQLmM1OEronZxtWBkRXqKfBRvpheCZaOUy1krkJ63QyJRLTADlFiQ2RdzaiijnawdUtQ8l2OAbHNyf8R/vJ8fq8j3/EL8PBKw7nqMtM+eDy19lW/NL6jHt0N6AcUg60TCybL/CBRJXrwrOu8rbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pqHm1jPG8EU3bBQV7HecYszB/ssI1aWlaAnQNHdWqU=;
 b=FwUQuKj/JlRehRYQDVUQxK0+uHssefMTd5H0cHdtR+rVIaNxH/bHvQ0KDYCBryhKhF2gmUvgvWQfU5+jBCWjFME7WfK7fS5HYgFa2RErGSlebNFLej0iKcQYKGlTzX1yP6UjURGFZIvC89doIT2HLvfOlgeI1p7kdBBKFsrncjw/BLUuUXn2kJaYSQg1dDcHxWIsIKoOseXBKQef9xFj1+x7b7uidiFHjhioZAV3xFsmmnC4PFlss0kyFkDpoLbZbP1G/7i+EIsk4Zof/GLfcJqanGH56HTH8CTvbMcgBVQLfzh9H5gl7CEnk2Zpcby1a8VdTuLQtdC37VpT8Q0fRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pqHm1jPG8EU3bBQV7HecYszB/ssI1aWlaAnQNHdWqU=;
 b=R1YUIMUldkQgo7kg/GXjnopfXdnDK7QxYshvoht0p1gEnQ7N4fLsS2FhxUdp842L9Bfk5Uo65nJshUuMN2gf4IixJShtTbm18hIYShwnWO+LqUp02nq+SdCIcGebuFBbhzSVd97PPmL9hHcfgb6nfGe5y1wV6xxx88R8IEY0E1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 08:59:42 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 08:59:42 +0000
Message-ID: <c8a2d737-1c27-461e-8609-99a448004ca4@amd.com>
Date: Mon, 27 Jan 2025 14:29:31 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC] perf script AMD/IBS: Add scripts to show
 function/instruction level granular profile
To: Ian Rogers <irogers@google.com>
Cc: "acme@kernel.org" <acme@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "eranian@google.com" <eranian@google.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "Shukla, Santosh" <Santosh.Shukla@amd.com>,
 "Narayan, Ananth" <Ananth.Narayan@amd.com>,
 "Das1, Sandipan" <Sandipan.Das@amd.com>,
 "Bangoria, Ravikumar" <ravi.bangoria@amd.com>
References: <20250124060638.905-1-ravi.bangoria@amd.com>
 <CAP-5=fW4Vzhs7BOeAhom5csRUk+UkCFdc1H9HT4AhMdei8FRKQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP-5=fW4Vzhs7BOeAhom5csRUk+UkCFdc1H9HT4AhMdei8FRKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::54) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5ca47f-4ff4-4b07-3fd3-08dd3eb0f044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0huN1RINjFseGtEbDlSZXhVVjNWSXZoTW5nckJjOERPKzlhQjA1VHFhWmYx?=
 =?utf-8?B?SUpRL3F1VkNsTHhkLzFpdWd2TmdYQUpFUmh3b1VjVTdLSngzMEo2SXNvZGpK?=
 =?utf-8?B?VWNteEt6ZFh2dStya0tsZ2IwaUhwbjhIU05lUCs3NHNyc2puRjZyZXIyV1ZV?=
 =?utf-8?B?YUNkTHFvelRzbFpOV0hvTUFHZzViaWtSQ2NoSVNiSDdpcXVSOEtKM0d3SWlN?=
 =?utf-8?B?Kzc5M3dzejhuVFZqcGtLbUtmQkkrWEZRZ3dXbnZzZVllbXdtM0hBMTZOSUNs?=
 =?utf-8?B?SitkQXRIWFdYMTh4SlBJVmRFendoV0dWbE1iVmlCYS9BTWV0ZitzV1BCa2ta?=
 =?utf-8?B?YXVnbjd4cFFncTVST2t1VlNRNitiVG5VSktJMlhsYjIzWXBBS1RIbkFlTkNP?=
 =?utf-8?B?dTZZVVBnaWd3dmt2TmdwMCtwUytRSWRxZGZvRm5lbk1jMXlUajNJQThtUzlF?=
 =?utf-8?B?SkxKanlMZHBGSzh1dnA4a1pEYkQ4SlVic2dtaWlqWjBDMUhCQ001cjB0bm9s?=
 =?utf-8?B?aThyL3NYSTNpc3l3d24xMXJ1ekprWkZPT1hBa29YWXpPV1k3OSt2RWNiVzY1?=
 =?utf-8?B?c0grbktzQUM1a1NhK3Fkb0pDampvRGp1VUpxc3JiVWdRSHN5UFpoSHJqUjMx?=
 =?utf-8?B?QldJOEsyd09neGtleklCOWdpWll3L24wK0s3Tng3SFpSbGIwaXhCZFYxYW5i?=
 =?utf-8?B?U2Uyb2c5NEFPM2tYVkp1dXFvcmNCZTJlcWo3bHpOWGMrSnRWTGF3cnpieHR4?=
 =?utf-8?B?UGVoNkhwYUVKckI2R3pmZklHb2V2bmFRdmNHOXkvRDBjUnVsR1hmYlc4WGdZ?=
 =?utf-8?B?VlJ6QUxDaytNYVVrSDVaa2NkQml6emUvWUxVci9SRnk3UElVeW0vWS9pODlQ?=
 =?utf-8?B?d1l5U0pacit3cjUvU3pvSmNya1RVVXd5OTQzdmRhaUJweHZ6aGVVS0NTZWJS?=
 =?utf-8?B?ZmE1UzZmRmZXUVpvak1NbVErd1ZiQzEyS1A0ZnZSb1Vrckl6THlXdU5Ucm40?=
 =?utf-8?B?dThvWGpha21Kb1ZhWDlWTHQrTHpBZGxzdVR3cW8yeWZ6UEZaczVmcnFBK3NZ?=
 =?utf-8?B?Q0Nmdk96M05NNjBoSUhycmVNN3JPa2hzQTkxVXhOdk85enI1TjlaOXlIK1ZG?=
 =?utf-8?B?NzdDNlZKMkd6ZWFycVNwdEhJQW5jVytDbzZPUjUzb0VaT1VXeHN2Q0lGK1I3?=
 =?utf-8?B?d1R5aEVTczU4OGdQbzFZc0ttaGdrKzVZZW9waW9mVkpxU1RucDFKUld3T3VF?=
 =?utf-8?B?bWk4WWxJSFFBVlM1QnhmZ2lMSTJFVHNpNFpYVFRRRkVoRWtTdHVzSm50MGZs?=
 =?utf-8?B?NUJBS0lteXNJWXl6QzZpTG5rSGg5OU53dnY5V2h2TjkzMHhuMWFSY01IOHZ2?=
 =?utf-8?B?NG05WjdSK1ZYd0w2WWN5Rkcrb2dETFZxYWx3b3Q1a2VZQ0tzVUdnRjdTakV1?=
 =?utf-8?B?ZkhKZnZvSGVqZGpkcjZyUVdheTAwekVucnRZeTBpUkxJMUc5NHpzTW9iN0RQ?=
 =?utf-8?B?czhTZXhaNUJyRFVvL1NnVHdFa2FFRVplR3dVVVI0QVd5dFJtNVIyTG1sMVhV?=
 =?utf-8?B?WHFoYkZvTkdjQ0VOQ2FncWxRdTB3VnRsUjZqalQ5d2dmVURyQ1Bqa2JIMlJO?=
 =?utf-8?B?QVJCc0p0Z0dRYU9NTDdvRE5mL3ZFZ1dsa3pOL2Ntb3NqeEc4ZHkwT1dOdExQ?=
 =?utf-8?B?NjNHMzZOR2ZwVFYvSnVJWlFTOXc2WlJMN0xqRjF0YkVkaXpEYWxocjRTNW9q?=
 =?utf-8?B?SVBxV0VubHU1N0sxVmJpcHdNQmFrSjN0eG9TSzlScjErS1dLbU1xbVk2bzZV?=
 =?utf-8?B?WEpnVndIaUJUVlpyODYzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cktLRlBaQTE4U0tKeTkvSHV1UDZPNUxoYlNSbWZNQjVIYitPTkQzOGVQM0pm?=
 =?utf-8?B?SGZoN1VRNU9NZG03UjdHdFhlSi9rRU9HdFRpbWtYZXFJeDdQeFc5WVVOT2Qr?=
 =?utf-8?B?aXpEcmtQZEw5SDE5c3VaUFNYc0trWkpxZlFYRXZDM2FRSlM2eExVUHlYQTEz?=
 =?utf-8?B?bmhsenFkVTc3aUlBcTB0MW5xZlN1TE9iaWpldzQrbXczY1V3Y0poMHpYUllD?=
 =?utf-8?B?UjFGeWZINzVXcWRuSjFta0c3RUNLb2tHUUNucGNCS0ZIZWo2dDlvamRPdXM1?=
 =?utf-8?B?eXpFVkJ3RSszRlRWYVNBYndrNTc5YTRmcnJ1enhLZnNqYmltdUNNakhjY3lB?=
 =?utf-8?B?OGdRcFBuWGIwbXpjZXJGWU40M2RzRUg4SVhueHVGSDVBWE05WWdBakw1cjg4?=
 =?utf-8?B?Z0JhQUNoaHRtb0lLbVBaaDRlazBwZUxvdmtubXRtNTl3cXJCdDNDQ0dydUFR?=
 =?utf-8?B?ZEt5ekQwU3VINkwxK0N5dDNWRElmbk92aXVnMDluRVZCdkRYV2NwdXFYOTNM?=
 =?utf-8?B?aEswK0txWXYvREJwclNROHVSOVRlcUx5ZDhBeHpnUjdoY0JUc3Fmd2Zhemls?=
 =?utf-8?B?VU5tZDBZWTVIbjN4RGZmNEg1K1RVOG9yNHRQVXVyNFhDN1ppdGJVUXdrSytj?=
 =?utf-8?B?dUVrRmVEeVFKb2xHRTZ0eVdOdmE4cCs4citMMkM5cjBPR0dYTWpPRUxvS3Za?=
 =?utf-8?B?by9tTWZna0pURE5sUSthNWk3YzNVUGc4ODY5TGt4bDdES0pGR1UrNWE4eGUw?=
 =?utf-8?B?WURBclNiWlBPKzRFa3hzMFdFZlBNTWRrRnp5UFBPMlJOVCtlM3VnL1VSeEk5?=
 =?utf-8?B?TWgwaDVYR0haYmtFQ250QXJZVEhucGVTMGNRb0dDaUZJZ0g5YlJ5WFNZbml2?=
 =?utf-8?B?NVVvRjNpbGRrdndSMHVId3BpRmdsY09EVGNEUTFsSjlCTUhucGtPYmh5d1dt?=
 =?utf-8?B?eDlaSVRid29Tc3o0L1hLbUtwOHVmV1M0b0Y3Zm80b1BYTnp4T1NFOTJ2dDQ1?=
 =?utf-8?B?T09UT3cvWCtPYXdaL0tUVEdjV2lLUk5ZYkZCQThNYlEvN2dkVSsvc1kwSDlm?=
 =?utf-8?B?UWNrQkR2T0Z2c0gzejh1dzhTQUlhdElKa0p5K05HN25zQ2Nzc2JpdXd2TGJJ?=
 =?utf-8?B?aGt0bzE5SDJhM25MMitwV1VDZk94bDY5Z3ZrV1VwaFNIcE9pMEptQm8xeGNH?=
 =?utf-8?B?azlVNURjNW1TdE9mYTVxVzZlK1lSNWlpYzBZMGZta3hMbkUzVzNyNmxMVi9Y?=
 =?utf-8?B?TXBhdCtSM3JPY0FlNEhSVkIxMkwvQkFqSEZZNjgwN1diZDBKWCtsSWdTTEFx?=
 =?utf-8?B?UlBiZTA2ZTVXMUZCU3IyZDZKMGsyYm4rUE84ZWVzanBNYnlVV1RrMjE0M21t?=
 =?utf-8?B?S3IyK1M4TUhWUXVMM2EzZmFiNC9QRUs5Q3REUkUvSmdWWUtYOW91VXZZQ0Jz?=
 =?utf-8?B?Z3V2dWFWZ3ZxYVE0K2ZMZW9veWJocjZ1aWdsV28yTWtZZGRxS05PVWdZdDZm?=
 =?utf-8?B?MDdYWWwzOTloUWtpNDJBOVEvY3RDV1ExbU42RWxCMUtpd01pSFpBTzBGTFJL?=
 =?utf-8?B?SzhpbmZXeWdpbU5BdDloTE5vaUJLNmJCNlk3Qml2MnZ6RGRzdWlXNWJGbnBN?=
 =?utf-8?B?aElMRE5zdTdTZFJMQzlkTzVOMjltSEE0MXpxTWxlQTJwbDlVYlk3WCtWMFd1?=
 =?utf-8?B?UEVwWE1IZjBSUzlld0o3NVc3TW0ra1ZaNWNTMHo0TENLMzcyMVpxSWg2Y0hG?=
 =?utf-8?B?VGV1K1FDVG50MGNGQlEvZTkrdDdZS3VYSkc3RmE3cm9wbi9HYlAvS09BSzRC?=
 =?utf-8?B?aGhKSFVDUFpRcUt5dCtkK2dvVkNDZ09TTjkwajVSYml4WWRpZlhsd3kxd29Q?=
 =?utf-8?B?Mmo3cHNxOFpkSEVXRG5YdzV2V3BmcHlXNnhJWW9wd2dxQlN2bTF6cG9YRDg0?=
 =?utf-8?B?dkdPU3pzK2d5ZzhVMXl1UVJKVjlxczhRaEYrNU14Z0FrNk5Pb21mbnUxME4w?=
 =?utf-8?B?SXRQRllLTk9xVURZbC9XRjVLZ3d2SmdIRW5pcVc5bDRJNmRacjEyem11eVdw?=
 =?utf-8?B?MjVpWWF2WEdCMlZYUi96dFJsM043MXF5R1g2NVFHYjg5cHJrdlA2QnhONVZa?=
 =?utf-8?Q?ps5t/WKnlt42Bxt5Np3kRlyv4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5ca47f-4ff4-4b07-3fd3-08dd3eb0f044
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 08:59:42.5999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eb51tTH8opeOYUS+ubowWMyjvNEwfCTWUrj4patl8UvuyJz3LhgDtK24yeUtcsA+xS9b/f7ZW/EZeT7uezxTqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

Hi Ian,

>> diff --git a/tools/perf/scripts/python/amd-ibs-fetch-metrics.py b/tools/perf/scripts/python/amd-ibs-fetch-metrics.py
>> new file mode 100644
>> index 000000000000..63a91843585f
>> --- /dev/null
>> +++ b/tools/perf/scripts/python/amd-ibs-fetch-metrics.py
>> @@ -0,0 +1,219 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Copyright (C) 2025 Advanced Micro Devices, Inc.
>> +#
>> +# Print various metric events at function granularity using AMD IBS Fetch PMU.
>> +
>> +from __future__ import print_function
> 
> I think at some future point we should go through the perf python code
> and strip out python2-isms like this. There's no need to add more as
> python2 doesn't exist any more.

Ack.

>> +allowed_sort_keys = ("nr_samples", "oc_miss", "ic_miss", "l2_miss", "l3_miss", "abort", "l1_itlb_miss", "l2_itlb_miss")
>> +default_sort_order = ("nr_samples",) # Trailing comman is needed for single member tuple
> 
> Given these are lists of strings, I'm not sure why you're trying to use tuples?

I'm not a python expert, but AFAIU, tuple is the data-structure for
immutable list. No?

>> +data = {};
>> +
>> +def init_data_element(symbol, cpumode, dso):
> 
> Consider types and using mypy? Fwiw, I sent this (reviewed but not merged):
> https://lore.kernel.org/lkml/20241025172303.77538-1-irogers@google.com/
> which adds build support for mypy and pylint, although not enabled by
> default given the number of errors.

Sure. I'll explore this.

>> +def get_cpumode(cpumode):
>> +    if (cpumode == 1):
>> +        return 'K'
>> +    if (cpumode == 2):
>> +        return 'U'
>> +    if (cpumode == 3):
>> +        return 'H'
>> +    if (cpumode == 4):
>> +        return 'GK'
>> +    if (cpumode == 5):
>> +        return 'GU'
>> +    return '?'
> 
> Perhaps use a dictionary? Something like:
> ```
> def get_cpumode(cpumode: int)- > str:
>     modes = {
>          1: 'K',
>          2: 'U',
>          3: 'H',
>          4: 'GK',
>          5: 'GU',
>      }
>      return modes[cpumode] if cpumode in modes else '?'
> ```

+1

>> +        print("%-45s| %7d | %7d (%6.2f%%) %7d (%6.2f%%) %7d (%6.2f%%) %7d (%6.2f%%)"
>> +              " %7d %7d | %7d (%6.2f%%) | %7d (%6.2f%%) %7d (%6.2f%%) | %s" %
>> +              (symbol_cpumode, d[1]['nr_samples'], d[1]['oc_miss'], oc_miss_perc,
>> +               d[1]['ic_miss'], ic_miss_perc, d[1]['l2_miss'], l2_miss_perc,
>> +               d[1]['l3_miss'], l3_miss_perc, pct_lat, avg_lat, d[1]['abort'],
>> +               abort_perc, d[1]['l1_itlb_miss'], l1_itlb_miss_perc,
>> +               d[1]['l2_itlb_miss'], l2_itlb_miss_perc, d[1]['dso']))
> 
> Fwiw, I'm letting gemini convert these to f-strings. If I trust AI this becomes:
> ```
> print(f"{symbol_cpumode:<45s}| {d[1]['nr_samples']:7d} |
> {d[1]['oc_miss']:7d} ({oc_miss_perc:6.2f}%) {d[1]['ic_miss']:7d}
> ({ic_miss_perc:6.2f}%) {d[1]['l2_miss']:7d} ({l2_miss_perc:6.2f}%)
> {d[1]['l3_miss']:7d} ({l3_miss_perc:6.2f}%) {pct_lat:7d} {avg_lat:7d}
> | {d[1]['abort']:7d} ({abort_perc:6.2f}%) | {d[1]['l1_itlb_miss']:7d}
> ({l1_itlb_miss_perc:6.2f}%) {d[1]['l2_itlb_miss']:7d}
> ({l2_itlb_miss_perc:6.2f}%) | {d[1]['dso']:s}")
> ```
> But given that keeping all these prints in sync is error prone, I
> think a helper function is the way to go.

Sure. will convert it into a helper function.

>> +annotate_symbol = None
>> +annodate_dso = None
> 
> annotate_dso?

Ack.

>> +def disassemble_symbol(symbol, dso):
>> +    global data
>> +
>> +    readelf = subprocess.Popen(["readelf", "-WsC", "--sym-base=16", dso],
>> +                               stdout=subprocess.PIPE, text=True)
>> +    grep = subprocess.Popen(["grep", "-w", symbol], stdin=readelf.stdout,
>> +                            stdout=subprocess.PIPE, text=True)
>> +    output, error = grep.communicate()
> 
> Perhaps the pyelftools would be better here?
> https://eli.thegreenplace.net/2012/01/06/pyelftools-python-library-for-parsing-elf-and-dwarf

Right, using library instead of hardcoded shell command would be
better.

Thanks for the feedback,
Ravi
