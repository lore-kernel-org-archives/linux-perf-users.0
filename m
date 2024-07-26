Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01B2B9DB;
	Fri, 26 Jul 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981870; cv=fail; b=Vw8h351VhYTaIQGXa9X7JPyU/FdDrMK1v366Jd98mUDHY1sukpbVYEHdeRlBBXc+Z97rcdxxHxAmTlnsAx+K/0t1vxN3Xh2wdDA5IBeHnPu79n46C5nswTgbOYh/SS419U3827drqd4e2zuBujz8zD+iGxr2UWbW+Y/aFokl2hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981870; c=relaxed/simple;
	bh=YWbiSaUKO4NNyZAoTsjL3VMeC+SPZOIg9Rh2dL+ZgOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KA7vBRbYGtP0Fz0dP3Kl25+RATrmgV8+6anzMKUgZ7GiJzfdMbm82uQEC7lqRW7nHLyTz67TYnjBY5qqILyUh7dfNkDm7CvkgU2+oqrwKz9pf5H3WbYOJj1RpwP+9SRRZikfGFFTBEMdiFTKd79lJHBRGDF2VZkn/EDwP0Yu6GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0SRA+KHI; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0SRA+KHI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6Mf4IvZ88Fbwz3SbLFj01v7Nh2XYVDg9Msy36X41XzDrhjFUs4IpWmYvmVdOuQX63FRcdpZd5b0B06cT3VoNknGOlaob6tZ1x6+wtBqcdoT77VHkW7Cof+NGNPrnoR3WEimrHgSgyMEf0g739ZyWpfvHyiOcZcLGSu4zHbkZ4KtqD3OLPdTsJsy4BGSZsZByN7VJ36mzQxukVJlvNP6dKzA+bDqtugdxNvBAy37qGAMOnfxwyfjnZUwvtDcuL975Dt4odnkxzuE/RpjtG7AKeCDbLnxRIkgS8rED6wPy3WR8QGWEi/jPHdG75B6eYS8YICxyS1jrj+DxHfp7lNSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS7Eq4Pa49TvtQZ7qE3V+Ui0c17cOL7DJOm0FwSuR+E=;
 b=JXI80eOfAqqyUYvLztPBtFKpUwuZpaQ1Y65/Frjn7LmwOlMgumZfmaqWzd7wxLDaLxtyOT86W7oGjBm/WYqExuvJLU85BQeYanVsnPG8xpZQCBUpLj8Xi79ZE8qkYCJR6NVTqLnBdm5h6ybLrdNDQJ0bGQ4bQXh19Xp+a6q7WfqL0VTIUThhedvPc4bhdhsVpuBTJau3xzFxqBe5nsMRsBtMUbyZn+G6qcHOPmM1rd0WYURb0Qq1ay1ZMTwrJg6AR0msAxMxVeuC4BaJb5/Yd+/oGzL35LuUTrHOZebgVJ7WLc3pqWygvS+0iJIHxzGr64KbM2PnN5iff8WZevjDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS7Eq4Pa49TvtQZ7qE3V+Ui0c17cOL7DJOm0FwSuR+E=;
 b=0SRA+KHI8daEAYky3R+muhq7PadhkptQtCxhkCyvO+qrY7b7qfj+7HPyNxhZ9PcQw3JkItf7VXN/y6UhWNM0YLe4jdlCopxXZgRCIDeXbyIAr6B4+vxqOhp9XV0OgV8ABo6A9mbRPnlJPr43Nk2MF+zvfKoa5191axFZ8QwM5fM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SA0PR12MB7479.namprd12.prod.outlook.com (2603:10b6:806:24b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 08:17:45 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 08:17:44 +0000
Message-ID: <a0bdb947-63cb-40b4-b410-92b4dc9e6801@amd.com>
Date: Fri, 26 Jul 2024 13:47:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in
 sysfs
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
 <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com>
 <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
 <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com>
 <CAP-5=fUjEYwdOdmfa5N7b8OOLWDitJKBdeOr8-+UOYWA5+ehkA@mail.gmail.com>
 <775d8f1d-437d-47a3-b4b2-da476e914cf5@linux.intel.com>
 <CAP-5=fUH+n+f_q1Tc-a3oV3vDV60VGOLANRFWUemDen197rYog@mail.gmail.com>
 <c4b499a5-7d2a-44db-bd0c-c123417337a5@amd.com>
 <3c3d1cd9-ccb1-495d-a670-9ee504fb0bbe@amd.com>
 <CAP-5=fXpacz331M71WR1HZHS0p7t9zqNUqBvMf2EjOxaB9Ayyw@mail.gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <CAP-5=fXpacz331M71WR1HZHS0p7t9zqNUqBvMf2EjOxaB9Ayyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SA0PR12MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: af7feb18-a3ab-41d0-5352-08dcad4b6d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlFUZmpCWnpOdDJMZi9QZlZORkNseS9IakpOelZrYjd5OTk2aWxPUUV0M1dD?=
 =?utf-8?B?Nzh2aDQrRlFMYkg0MWxMNFJ0Rzc1bWZ5WDdTTHV3dzg3WlhZV1N0T2JlRGNt?=
 =?utf-8?B?TUpLRCthM3hzL3VGU1UvN3NGRlBEZTloVC9LYTMwbVRRYVRFc3JZWHhWWmk3?=
 =?utf-8?B?RmcweW1ITGhUSzZlVVExb3prNDRHUHFaaHhmMlhNNm9uZjRTQXhmeTBnMmdp?=
 =?utf-8?B?OW0vMVJCRmNYU2pmUlZVZ3R4TjFTcWZxQkZEWS9KYnMvTmdNVnc1Ung0akJv?=
 =?utf-8?B?eExTZnN4bnhrNWlRZzc0SEtiSVFrdXVGdHVYdHdqVzdSSFBTdDEwK01OSGJL?=
 =?utf-8?B?M01MSDYvVnY3NXgvMDVQRjJRV1pmY3FmSk4wZzJOZUpjRmU5VG1iRHExNUdF?=
 =?utf-8?B?WWZZZjNReTM3VHYwc3dJZEJFNnBRbDM5YXhSUE5ySjdtMXRka0xWRHlucVhI?=
 =?utf-8?B?d1FIUzRlMkNDb1dyZVhGdmhXR0NDOXMzQ2MveXBpR2VkQXQwU2VoeWUybTFl?=
 =?utf-8?B?VU5tRUVqMVVoanhwMCt1Yit5OE5mTnAzU0JkQmhnM2I0Qmh5b1g5R2FNSFN3?=
 =?utf-8?B?bFBvc1hzNzdKZm1vOTlmVEkxazY0bWwyc1ZkbHdmUDAxczRxWUdLaE5RS2NM?=
 =?utf-8?B?ZS9XQ1JsNW9Ta1RScXpyait3Wkx4MEE5ZmVRbWRNekd6TGdHUVlpVXpkMHli?=
 =?utf-8?B?Y2lYd0dpQUhCOXZqTGZWbTR3RjE4NVRIZUQ5MzVNVE9MWG1laU1PTEdtTXRF?=
 =?utf-8?B?eHpqN29VTU9jZFBUVGVIVWd1eFI1WVhVNlIyZmRyQTZSbllCNmZobVlScys5?=
 =?utf-8?B?MURDY29iRnE2M2t1T1hYS0gxSktGbmpKRWZ5eVZ1WVZuSnh0azErOU1SWnEw?=
 =?utf-8?B?VEMyeStQQndsa2RjMmlZSXdMbVBLUFk3R1l6VXNIT2FWdE5ORzY0VlAzT2sr?=
 =?utf-8?B?TlVhV0wycklqYThwMGdQdFpNcE51SWp3ejFvelhOc01aZjQ1dTM5T04yekFu?=
 =?utf-8?B?Z05xZGZneEpid2U2NFJYUUlvdWN6RnBMbXE2Vk9NR3gzVllxK3E1cnF2dDhs?=
 =?utf-8?B?MEFtREVCa05OQTlBNTNmN3loTHlMeE81NDROUzR4Nk9saGdUc1Z4ZDlmc05z?=
 =?utf-8?B?NHRVaStWajdoT2tjcWpiN2Zsd3FvamJOS1U4MG1YMHI1cytaTURJRlB4Si85?=
 =?utf-8?B?bnBvOGdxN1F4RCtLelE3WUV3dll6VjFlcnZEV3NSL1h1aGNsRzlZWDZETkRH?=
 =?utf-8?B?ZnpQZDlHTFFSY1BxZXA2S1I5dXdOT25Ic2hIbnFtaVJvVzdCajJHSHpCT0Jj?=
 =?utf-8?B?b0hPWm9JZ1MvdXgxR2JsTTh2NGpHeUcvZGtRdHpCdEdicXdTVDdpWjBOSm1y?=
 =?utf-8?B?bzU2dzhnYXplMllRa2VHTURTTUZ0WXErRGttMVNnb2o0NWpoMmd1TW5KaU05?=
 =?utf-8?B?S1BsZGxCUzRNN3FvU1g1MG1VQngvRVZ3anFtQ1Jxc0NUb3djaXcyV0wvYXN4?=
 =?utf-8?B?YkYwU0J6ekRpWDF2RjZnenBZWGRtb3ZGQkdnVDQxcTg5SGcwLzVVek1pNGd2?=
 =?utf-8?B?QlA1aXl5bFR2UFNwTWw3emNDeTB4RjRKWXpVSVErcDkzTGUyUVdaZU1YNkxV?=
 =?utf-8?B?KzFJZWdYLzY0eUhwNXgzU1h0U0hBb2wvQVBTR1BsR3JudVU5YUdYaUhKTGta?=
 =?utf-8?B?NFRiOFFXZ1FkdzVoR0p4NC93dHpMekRPQ09ZQlZocGVsaU9oZlJmd2JPeGZ6?=
 =?utf-8?Q?z+vcpxz+ZXwzI09gYr2gVWWqrlPdUCvJAakMovz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0JuYVdrMFpKSUJpN3JIcUI5YVQ0VXk0K1A1WDNhZ0x3RzFVbnpuUzFjOWdP?=
 =?utf-8?B?SURsVGxuT1hKYlJXYjRSUEhXQ0Q0TnZ3TlE1Y3A4STdJUENUTTVkMm1OSXhR?=
 =?utf-8?B?WmduWEdqRlBMMlpRZkp2SlBTa1NZM0lYckpBRTFpdGx3UkpFR0V5eXgwTnk2?=
 =?utf-8?B?VmxGNytMNDBUblNaZjZsOXkyMkMxUkZjdE0vTTh5QlM3ZTJRRFB0eXRjZFJm?=
 =?utf-8?B?ZEpOSHFlRTZmSGdsZ21wMU1kY0VyYmNBYkN3dE1jSGF0cWRUR2JFRTlmdEFL?=
 =?utf-8?B?dWUwcXorK2NNVFdUNC96cHMrQk9WdnlBRnVkS2Zld1VOOE5ZYWY2TXRMM2Mx?=
 =?utf-8?B?VElCSjFVUkFpMytUaHNaK3VzSTF4U3lsUVVSOElnU3dreXNCTVNMYTFxS0xR?=
 =?utf-8?B?Ui9jQnM3SmlzRHFqUUE0dmJuaFhMUjVMb3puVTVFQzYxSGJuQmhFdEJGWlZ3?=
 =?utf-8?B?OVlDT21hN0trSyt4WVlWR1U5NS84UUkzU3lpUjJnTnQ4YzlrWHlqUUF4ME5r?=
 =?utf-8?B?Y1NhYm4wYnV1dGNubnp6Wm5FUDRGQXdTdGVFanRMYnZULytmYmVUUE16QkRK?=
 =?utf-8?B?TWJxbjhQc3BYR3A0MUhySjYrNmZOeURCd3d1ODdCK1pCVjVzM3pWNTRMenc3?=
 =?utf-8?B?cUZCYjZCZG1maUljMkp1OGM4UGtBT1dUMmxZWEl4dWZEZU9DeVBXV0lNZXpO?=
 =?utf-8?B?N1lUU2VLc0ZLT2lZdXNlSkhHU1UvVlJuV3BJQWZMcXdZcEg4N3d5RkI3d0ZY?=
 =?utf-8?B?TkRrTU44QnR3OUVMN2U0eVBZRFAxUGRGUnhrL3ZCbU9PQ1M4NC9HbzFiUmEv?=
 =?utf-8?B?dGpMV3Z1QlN2aHJSbnY5M2JzTW44bUluNTkzRGh0ODlTVlVFa3hsOGtDYkFt?=
 =?utf-8?B?YlMvKzFac2xZeUF4a1pnL2o0VTJPamxRVDg0cmJtU3hLLy9YUXVqdW4vYnVU?=
 =?utf-8?B?K3IrU2dpVGNPaVF6N2ZOVjlpSUw1aktORk02ZmRrczg2NnBTY3dNeUllbkt6?=
 =?utf-8?B?OHJtQXdPeUh5OXdKVDJlOGNSOHU2QzJZd3ZoOGh4NktaREcvb0g3VTBoVWMw?=
 =?utf-8?B?ZWNtN2NuaU5xRVBEOEhUcm0yZnp3TlNsNVFrcUVnZXRFUEpRS3d2K0tqSE0w?=
 =?utf-8?B?cmdTMUh6aTN3WmxnUmFERkd2a3JIR1FXcEtOb2hUNHZ1ZFdldzdGbUlzV3FD?=
 =?utf-8?B?bThKQlhHNnhvVlFlR1QxTFV3RlpuMzhZYnFsOVVtRVl4UWh5U1NFR01qT2dT?=
 =?utf-8?B?L3ZHbVdNcXZVWmswMm5sZ3lJck9JZTdaZVVMOWxGdjhRMHk3SUJiWVJ1YW1h?=
 =?utf-8?B?RjB1ZVpRM0d2bWhnU1R5elRoNDg5VjRxcEdOcHlkWU9ibUVPVFI5MEhlVnVl?=
 =?utf-8?B?R3FGclE1b1ZSYkN0eXQyQ0plMC9qbU1tV1dEd0ZMVW1UdTQ5Umx3aHRxSkdt?=
 =?utf-8?B?SFVYenFWWXRJTVNLN01UUGdwaDloYWJ4c2dkU3NiN1FuUEFycWtjMTcydFhH?=
 =?utf-8?B?RFB2a3Q0OGhsWXpMbFF3cHJmVG1rVjZPRllTK25waFFML3V6L1NJK3dWYmIv?=
 =?utf-8?B?cy9KTStNcnIrYmRaVHdFWUZ3S1dUWHpiQ1VCWDhSMWNYdzMwS2tDQS9WRFlN?=
 =?utf-8?B?K2doZ1JobFJSMGVhb1VRb0dGRStYSWhYT1dWemdCdDkvUWxKSjJVcWhYSVRj?=
 =?utf-8?B?cHJzZUlPZXoxS2dyaEZJc01sZ0V1U1NOQTdtSGc3SklLc2tEMEpSampSU3A2?=
 =?utf-8?B?V3hOOGcyU3NCeXJmWkE5ekhTYnRyVlhpZTYzWDRiZk93RE1McDZlUUJheXJv?=
 =?utf-8?B?T2FLeEZzTkJaM05Ga3NYdzl1dTZDeWtCbHRWeitIaEV1QzJWS1ZoY0JkM3N0?=
 =?utf-8?B?cUR6WUc0VTFDOS9GaThUeTgzd2hVRnBndk9oZUxFY0U0LzRPZ0tJK0dUb2Zj?=
 =?utf-8?B?dHF2dFFXcjAyUXMzL3R1UzNUSXVjeGpZb0RyWGVyZVFlSEpod1o5c0FBVGdu?=
 =?utf-8?B?Ui8yZU5HTHVXR0xjNUZwWDdjbXFFR3dZNFU1NDg2NlVRY20xMC8vNnJHNUM2?=
 =?utf-8?B?OWVvY0kvcGhLaEtub1ZHc0h5Wi9CNGlWeC9VSjYweU9aQ0F3cDIzbS9YWkFv?=
 =?utf-8?Q?6+1XgvsFZxsFiyDY5hxDxA6KE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7feb18-a3ab-41d0-5352-08dcad4b6d08
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 08:17:44.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnh9108TkgWj/48Ax2NEyqcdy6FsNSu+Pbxf+m7DYx3hazaDmNAFmui0/D03pp5AEVBwTB8gd93BpB3p7CpODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7479



On 7/26/2024 1:22 PM, Ian Rogers wrote:
> On Fri, Jul 26, 2024 at 12:10 AM Dhananjay Ugwekar
> <Dhananjay.Ugwekar@amd.com> wrote:
>>
>>
>>
>> On 7/26/2024 12:36 PM, Dhananjay Ugwekar wrote:
>>> Hello, Ian, Kan,
>>>
>>> On 7/20/2024 3:32 AM, Ian Rogers wrote:
>>>> On Fri, Jul 19, 2024 at 9:35 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>> On 2024-07-19 10:59 a.m., Ian Rogers wrote:
>>>>>> Thanks Kan. I'm not wondering about a case of 2 CPUs, say on CPU0 and
>>>>>> solely its perf event context, I want to know its core power and
>>>>>> package power as a group so I never record one without the other. That
>>>>>> grouping wouldn't be possible with 2 PMUs.
>>>>>
>>>>> For power, to be honest, I don't think it improves anything. It gives
>>>>> users a false image that perf can group these counters.
>>>>> But the truth is that perf cannot. The power counters are all
>>>>> free-running counters. It's impossible to co-schedule them (which
>>>>> requires a global mechanism to disable/enable all counters, e.g.,
>>>>> GLOBAL_CTRL for core PMU). The kernel still has to read the counters one
>>>>> by one while the counters keep running. There are no differences with or
>>>>> without a group for the power events.
>>>>
>>>> Ok, so power should copy cstate with _core, _pkg, etc. I agree the
>>>> difference is small and I like the idea of being consistent.
>>>
>>> So, it seems we want to follow the new PMU addition approach for RAPL
>>> being consistent with Intel cstate driver, should I revive my "power_per_core"
>>> PMU thread now?
>>
>> The power_per_core PMU thread link for reference,
>>
>> https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/
> 
> I think so. Would it be possible to follow the same naming convention
> as cstate, where there is cstate_pkg and cstate_core? (ie no "_per" in
> the name)

Makes sense, we should probably rename the original "power" PMU to "power_pkg" 
as well.

Thanks,
Dhananjay

> 
> Thanks,
> Ian
> 
>>>
>>> Thanks,
>>> Dhananjay
>>>
>>>  Do we
>>>> want to add "event.cpus" support to the tool anyway for potential
>>>> future uses? This would at least avoid problems with newer kernels and
>>>> older perf tools were we to find a good use for it.
>>>>
>>>>>> My understanding had been that for core PMUs a "perf stat -C" option
>>>>>> would choose the particular CPU to count the event on, for an uncore
>>>>>> PMU the -C option would override the cpumask's "default" value. We
>>>>>> have code to validate this:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evlist.c?h=perf-tools-next#n2522
>>>>>> But it seems now that overriding an uncore PMU's default CPU is
>>>>>> ignored.
>>>>>
>>>>> For the uncore driver, no matter what -C set, it writes the default CPU
>>>>> back.
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/intel/uncore.c#n760
>>>>>
>>>>>> If you did:
>>>>>> $ perf stat -C 1 -e data_read -a sleep 0.1
>>>>>> Then the tool thinks data_read is on CPU1 and will set its thread
>>>>>> affinity to CPU1 to avoid IPIs. It seems to fix this we need to just
>>>>>> throw away the -C option.
>>>>> The perf tool can still read the the counter from CPU1 and no IPIs
>>>>> because of the PMU_EV_CAP_READ_ACTIVE_PKG().
>>>>>
>>>>> Not quite sure, but it seems only the open and close may be impacted and
>>>>> silently changed to CPU0.
>>>>
>>>> There's also enable/disable. Andi did the work and there were some
>>>> notable gains but likely more on core events. Ultimately it'd be nice
>>>> to be opening, closing.. everything in parallel given the calls are
>>>> slow and the work is embarrassingly parallel.
>>>> It feels like the cpumasks for uncore could still do with some cleanup
>>>> wrt -C I'm just unsure at the moment what this should be. Tbh, I'm
>>>> tempted to rewrite evlist propagate maps as someone may look at it and
>>>> think I believe in what it is doing. The parallel stuff we should grab
>>>> Riccardo's past work.
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>>
>>>>> Thanks,
>>>>> Kan
>>>>>>
>>>>>>>> 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snapshot)
>>>>>>>> files parse correctly and have a corresponding event.
>>>>>>>> 3) keep adding opening events on the PMU to a group to make sure that
>>>>>>>> when counters are exhausted the perf_event_open fails (I've seen this
>>>>>>>> bug on AMD)
>>>>>>>> 4) are the values in the type file unique
>>>>>>>>
>>>>>>>
>>>>>>> The rest sounds good to me.
>>>>>>
>>>>>> Cool. Let me know if you can think of more.
>>>>>>
>>>>>> Thanks,
>>>>>> Ian
>>>>>>
>>>>>>> Thanks,
>>>>>>> Kan
>>>>>>
>>
