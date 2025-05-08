Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532F179A7;
	Thu,  8 May 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701816; cv=fail; b=bZZ7H0KPrJ6xtDhP0dRVoCEPDq94Vz8ZWfuevwnhpedvuEbg2GonJknKr1xD4HGbJdFr69t0jYws1rp/b0K7+NW926J29Ay2Y6PBgRpSwsyAfrF/t0xveDuFPm2gtSsRVrQ+B6F0Khbi7WQmlKkYzqZcVmtUk5W5tpHZ/W62lXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701816; c=relaxed/simple;
	bh=dbWDJ6cbMwlCs7d24AZjXm5e2Lgqvzs7f4iO3KLGQho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LcaBF+VQzsEAEc+3BXLVfgDA8CYxYNQZanW6go5ueTqOAYQ8GqOfSJTGQzX04mwLVH/XuTjFB61ZVOsyiIU2QYjqKxC67HmXXDvsT7OYwJS5ivx5A1jamX1Koa1Mr+fio9eZ3WH6m0YbHUvpPC79mIvcf+kI5RqbzswKVpevk60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r2pgwagr; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r2pgwagr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/K14nol7wl7f+9nF+Eu4mUfuOvzTbqwntqjYEBuQ/BkWrukOrHGlv4BEL10MGKE/zysxkjE+q2HIHYwXYY+J1XIkPaokOaPcG00ky9kbK4vzEtG4rYgOXslsBN5Jq7WmsFDnxvLQ1n4IWFpXZ6zA0tC9s3YH9TcNthuwEqOAgIA6hVpJXlZ11sTs7zyOCENN/EzT4uqIPn1ggZzA/Pnp9IWqXjM2hnT5h2nWQHCT+thT3a67uIUTC1Kpm2YG4grQSPwHhO59xZYm2RpCuUyxKs1tydvixnMXHm7i4QLvWKcKscqkyMpmnq9mfKADbH8fXPjnzLppNzPtzXjZo+C3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zChIUPA4x5DwW2UQp1Ww8gBhD1j5yn6lwaxvP2mN3JY=;
 b=oxanSMG1wCsNZHRimd6fxupNQdLyFI06UAI9gYdRjGnqTJ/VYlp+NSSo+P0tRUAV+ItyK9RFBBjudpdOx6Mm84etHG7hpD/KvhGmGPX+uK1vt0uRXZi29QpMRICzCKV/1hCSodzPM+17gfSM9hI4wMNOoHDs0tE1z8RjN6/Q9S+1/7s9WRuowe/Qccl0Cv8sBtR/ITsTEVebEq81jDo4HQvE7smqrYuuahTLnECZ9/aHmK7wpNVkC0hOwOvGy0RBdZmljiDVYz2Ncf5Pg/m1qL96C3azz7L1r0MEflAZcbt31SjR7WH7tr2K8diu1KIRSSS72W8OCKHHhjnyzLRyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zChIUPA4x5DwW2UQp1Ww8gBhD1j5yn6lwaxvP2mN3JY=;
 b=r2pgwagr8AgzQ6OnlMFRG/afy+y4r49oAOnQSBJ3I7Yfasykgtu6KAy/qyhymhdN0V5x7nd6Go8N0JNoml2WlDLjbMNUNFBCwCNT158qbfYo7LM71hxVN+bCgpHcDmDWM3sKm4IjBFG7xiplku8qpTKKzxm2kIcuZUZzqnNX5Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 10:56:47 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%6]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 10:56:46 +0000
Message-ID: <9a76fcc7-a8e0-4b88-b93c-7dbf65bc695e@amd.com>
Date: Thu, 8 May 2025 16:26:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf vendor events amd: Address event errata
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Stephane Eranian
 <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <cover.1746627307.git.sandipan.das@amd.com>
 <CAP-5=fUEeFb3jh-MtxEEH0Z+HFAD0oxSc4uE66Rfg+BRzYRB5Q@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fUEeFb3jh-MtxEEH0Z+HFAD0oxSc4uE66Rfg+BRzYRB5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::8) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 214751f1-4297-4c82-fa5a-08dd8e1f0693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkthTHQ5c1l4elpYOU9NVnZ4TWZybWlJSDFlQU1mZ0U1Y3hIdXB6UDhscjdZ?=
 =?utf-8?B?Y3g0blJxS2dDQzNwOEhwWjdYR3hvaVdHK3VnekdmZEdaRm1zdUx3WkZaTVFY?=
 =?utf-8?B?V1FrdWNvY2d3aktoVWI5c0tnUzVBd2hZL1ZCcmpnWTE3U3dyTzdxbWxXc0VX?=
 =?utf-8?B?NUo3UG5iZXZKbkRjbGtGbVVWR1IwRWN4emFoMGE4cHpmVWlJY2Y5a2t2S3V2?=
 =?utf-8?B?NzhURnVnWENQa0o4bmV3Q1VlSDBXVjF3eE42NkpMSk1WUjRoZCtOYnVGak1a?=
 =?utf-8?B?MUFOOE5KZmNwTG82UkZDa0ZCVnl1RWtNVEtOTUtNc1hVemhDeWc4aUVwajQ5?=
 =?utf-8?B?RklOUGh1UVRhRU1OQmozY0dDNW9BeG1QSmlFc2MrTEJjMW4xSUxHRTQ4VVZJ?=
 =?utf-8?B?czNYSVR6NWJzNG5OR0UwczRtcjFEcXYrL3RPd1RHalMvMDZLVzNyNjFzWmpi?=
 =?utf-8?B?Q09OSVVKSmtoZDVKM1k4d095Rk9waVBIME9paXN4czdueFREellobEpCUUJT?=
 =?utf-8?B?WUNoRVdnZHI1NXo0MTNvVXlOUm5kQ0xSYzc3Y2oyR0RIM0hUTG1MTDYrdHY1?=
 =?utf-8?B?UVBzM2wvN1ZrcWVwQXZWdnNTQ0JMZlVMLzNEN3pETnRzRW04V1NBN1Njcytn?=
 =?utf-8?B?SDFtL3lqeHJDdzd2OE1wTElyanh2ZWxONFoxUXZDMk5qZlNZRE8rUnYrOFNN?=
 =?utf-8?B?c1RZbFhFUTB1QlF4WmJIVnpUaElBQk92NnlJSDFzakgzU0M0SzFIdDUwdVFx?=
 =?utf-8?B?RVorZ3crUkhYOTYyaVh5N0VBMlZBTFFKVDVLNlpYSVpqRDVBT0h3bjIxUjVo?=
 =?utf-8?B?WWNWQlg4ZTNUK2FUN1I5a291aitJaXJNMzdzNjZKd1BteE1YNEVjWW00RlM1?=
 =?utf-8?B?U1VtN0ZEb0x4bXpmR1lCOUZsdnorU25pa3phVFh2TVo0cEV6UXV5cFUzNDNl?=
 =?utf-8?B?eGVVS1ZrNjNzTWtPOTdVUjF4SjRZVTJpQ0swakx5alFpTmxHelZMd2d4VnBa?=
 =?utf-8?B?eGVTUHFSTGJsNzJNU1FlMGREYWcxeG1jUnZaTHJjczIvZEJNc09LenlKMlRI?=
 =?utf-8?B?Z3M0N0hpbUUrSEtLaE50akI0aXh1ZnZ4TWoraXFPb1cyL3VGTGZHOG9wSllj?=
 =?utf-8?B?ZU03V3VOeER6VFFKSXVpOTdZWFJ4RDNYL3pyUzJkR1hDOU0wWGFqTjRFeVdW?=
 =?utf-8?B?MTJuT0k3VFNkcExGUU8rRlhiOVJhVTA3a3dBL1NzL1FEekpmRXE4Mms4UlhM?=
 =?utf-8?B?Q1dwNFAydjA2R0N5M2xvaHNpbTVyRk5WZ0Z1d2ZzS1ZmWVpWTjB0SUswcFBU?=
 =?utf-8?B?aUlnSmJmUDIzcmNnU1BUVEdYK29PellIV1hLdGR1cmhIRWY3L0theitoSWFn?=
 =?utf-8?B?aUZNMEMyYXRtM2pJcWo1ZUsyM3NzblR2akc1QTBzeHlyei9TQkNIZ09WS1Fk?=
 =?utf-8?B?enFDdnZMK3dTLy9RNGVZcjVoMWpMSTdvcXlIVnJvYmNRWEFjSHVWaUx4V3Ju?=
 =?utf-8?B?Ry9WeWhwU0o0d1dZa1JWdHNxamhIZUptWVc5NWhTalFTWVdSaCtmVE1taWZ2?=
 =?utf-8?B?a2RHMGlKWkJJKzJUd094UkJ4dGNLbzhnVXBBSWFpWU9weDZuTUxZZUtQaWFm?=
 =?utf-8?B?SUpKYkhBNUN5NVVWU1BaOG5NeTJkaUk1cFFIb0haWTJuTmV6cDJqMXpRb1lw?=
 =?utf-8?B?TGozdWFsV05NZFhiR1c4VXMrWXQwb0g3UGs1aG9yeXYwT1JCbGdmOEQvRUlt?=
 =?utf-8?B?UWhkT1JRZzcxampVRHA3cGorQ1JQTlZ3OVZOWlZOcHhzVmZvUXNqY0Q5c2c3?=
 =?utf-8?B?Q1V6cStQOStSRngwOVBoZEtjOTBiTkhnSlhtVjN2RlJUWituU09qVWZTUGg3?=
 =?utf-8?B?dG5UcXZUZU1zWFk5RnN6T21WT3drQll4ZG81VitlTFV3SVhoUHZ5TVNYMkdJ?=
 =?utf-8?Q?SHs7de35HlE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2JNZEU2S1k0TmN2QzFHaHNDMjBIQUxORE5hUHhWM0pmWUVxM1BBekFUaVhx?=
 =?utf-8?B?Y1VQL25USVk2a3VaSUdoMmlDeW40bzREL0VVNjd6MG9pK05Dd1JFOVFZKzBJ?=
 =?utf-8?B?cGVZZFZWSkoraXdUeGFMbmE1clhJK0pxcVZyMTlaNC80ZW1EbE5NODE0OVg1?=
 =?utf-8?B?Q2orRmpMMnBFV1J6bTFyTndPY3dTYVRjQzNFaHR3SDJJMjN2OEdEU3dZcHZs?=
 =?utf-8?B?WTc0R2JuVUxGd0lzak4wWWVKNWY4blF6ZnI1Lzl3SE9MMEpGb1B2YURIWlhU?=
 =?utf-8?B?aFNuemJrblVGOWVLaHZEVFNJTDRFUjBSR29DSXFlV0Y0YnhKcEF1SEdpNkdi?=
 =?utf-8?B?WEMzeVI2YUhJeVIzbEs5eURtV2xFUHdINmdUYXRHZCtxbEQyeE1LZkdjOWMz?=
 =?utf-8?B?V3JqNXJjYUFEcG1rSUw1a3VQVk81OUtMNFFpUzNUSGtWUzlFV1VlLzFSeHcz?=
 =?utf-8?B?eTJpa253dEIwZjM1aG9DQ0tXYTNNcC8zamNzL3FxcGNqTUY1TFZHZFpHMmJz?=
 =?utf-8?B?VDVQbzcrVVBmTmZ4RTAwUDVpcytMK0NENXRrQlo0U1V0WXgvNkpRK1UrTmNG?=
 =?utf-8?B?RGtyRlN2c0lqd1Q5YWNMNG4xVDhKRklHM0FMS2RFaXVKOG9nVDFpUVZOVTBP?=
 =?utf-8?B?SDZCREQ5SlhLRENwa2pramxSNEpzRWNjRWxWT1ZrN1dWQWc1a25mZW9iZkpV?=
 =?utf-8?B?SmNyUithYXE2bVBzUHY3anpBMzFrcWNteTkwb1l0cFVySDBNMFV1RzQrMjJI?=
 =?utf-8?B?VElIdEJNd2lBZkdHUXZKUVpSSUwweFdUK1QrS29zRUEwMnpkbWZwMnU2S2pR?=
 =?utf-8?B?VE8yOERycGJwVnlkelI1N1VJMzJTRDFIdXhjMUxUMVlyQjBXaVRnM2FhZDVh?=
 =?utf-8?B?OFRFQzZtRm9pcWZ5anNIeDcxODNVOHJpbDc0NStFREFZdDcrYWsraUlldEQ2?=
 =?utf-8?B?ZlZuNnNZNXBlZmxsUDBERUcvMDlLMmxQZXd6OGlvaWxaQWJjY3pHTnJrZXNN?=
 =?utf-8?B?OW1uQ2UydHZWalZkRlp0aFRTaWhKak9DdnQxRlRyaHlEL1VvaFpCdTdmUGxw?=
 =?utf-8?B?VTBpZFVHRHdkbVg3emw1MmpiMWo2bk1uTHFSa25vM0dsZVY4ckcyTkZQQ2xR?=
 =?utf-8?B?WTNia04wZjJrSmxnMFF3M1pkWVkxa2Z5TU15VXlnRmZXeTAvc011UzhLUjJ4?=
 =?utf-8?B?KzUrZGQvMXNVVWd3cjlDalcxMGRLQ2djYWdmWTlPSXFpSWdwNWo1WkdrL0Vz?=
 =?utf-8?B?SGY1Q21uZUNPWGt3SUpCT1B5eWt2RHBFTEJubkRSVGtjUXBOKzgrWUFkclhU?=
 =?utf-8?B?UUVPK0hYRXhhRTk3Ky8wenIzcmg1cGpvaWVmcE1xK1BiWHJEaklGSTcyRkZJ?=
 =?utf-8?B?V0k3NEY3emZUUjFFRWw0OEFPWnd4dGtmNXpWbWdzbHpPNlcyN1hIRldwTWY3?=
 =?utf-8?B?RHBlMksxSWdPbnJoTFk0dzhlS3VBT0M5Y3hKSHV3d1hSam1rQUhOSWttUWlM?=
 =?utf-8?B?UVB6b1FGb3RqaVVzdmZOSzRNczJpUHJFK1ZjTE1uQ0NzUlVwM00vYjNvbDVH?=
 =?utf-8?B?UXNiQ2I0eFVTY2lWVnlndHFaREpLSmIzbk1HQ1AvVHdtbTNjejJjcEpOcTFC?=
 =?utf-8?B?WWkySXVXVlpIUHRnbFh1UCs1THJPM0Q5UnVBcWZ2YjlCOUJGTERWMkFVSnk2?=
 =?utf-8?B?ZzluWFh4dFdaSzVLWmhKZG44RjlrVUo0UkdqYWN1Y2R0c1NWVXBldndGZk03?=
 =?utf-8?B?T2tKYVUzRlowSW13QlBjZVlUblg0TmxuSmJEUkh3UXlSVy9JVy84YmhTbkdI?=
 =?utf-8?B?aTg1QVA1eWxuRG95U2Fpb1hseWh6Y21aTDNwSm5sYlJKT013dU1FaVRPeHVN?=
 =?utf-8?B?OXZJUFY1MjMxRkROMmhRVWg0YmppUmxvVnUvVWJOajNiSUZaRDZZUHFrVUhO?=
 =?utf-8?B?NmFTSzJ3dUdkelZLa0JMMHJYakJ1a3RQb1FsTmhyQTY3am1OTngwdzUvaHBu?=
 =?utf-8?B?YVNXVmp0ZTNXVWppRlpZcTIvajd5d1I1NjdmSXVNbXd1L0cyb1RuTVF2cGkx?=
 =?utf-8?B?RFMwRk9ZMW04ekdkcE5uYnEwdkc1VytEdzBRNnNxcDF0MHdZbVptbDYxK1ZE?=
 =?utf-8?Q?fJUQlMlNCrtl2JXrPCK0JluNM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214751f1-4297-4c82-fa5a-08dd8e1f0693
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:56:46.7190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilym+MoYKd2AR4H0viTq+ldM6rUWi7TwVFZ7ZTB1QrRxRmU2B/wJsudALtU58EGssPnQ4CCzfV6IIlNNGPrdmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

On 5/7/2025 9:26 PM, Ian Rogers wrote:
> On Wed, May 7, 2025 at 7:28 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Remove unreliable Zen 5 events and metrics. The following errata from
>> the Revision Guide for AMD Family 1Ah Models 00h-0Fh Processors have
>> been addressed.
>> #1569 PMCx078 Counts Incorrectly in Unpredictable Ways
>> #1583 PMCx18E May Overcount Instruction Cache Accesses
>> #1587 PMCx188 May Undercount IBS (Instruction Based Sampling) Fetch Events
>>
>> The document can be downloaded from
>> https://bugzilla.kernel.org/attachment.cgi?id=308095
> 
> Hi Sandipan,
> 
> the document is somewhat brief, for example:
> ```
> 1583 PMCx18E May Overcount Instruction Cache Accesses
> 
> Description
> If PMCx18E[IcAccessTypes] is programmed to 18x (Instruction Cache
> Miss) or 1Fx (All Instruction Cache Accesses) then the performance
> counter may overcount.
> 
> Potential Effect on System
> Inaccuracies in performance monitoring software may be experienced.
> 
> Suggested Workaround
> None
> 
> Fix Planned
> No fix planned
> ```
> Given being able to count instruction cache accesses (for example) is
> a useful feature, would it be possible to change:
> ```
> -  {
> -    "EventName": "ic_tag_hit_miss.instruction_cache_hit",
> -    "EventCode": "0x18e",
> -    "BriefDescription": "Instruction cache hits.",
> -    "UMask": "0x07"
> -  },
> ...
> ```
> to be say:
> ```
>   {
>     "EventName": "ic_tag_hit_miss.instruction_cache_hit",
>     "EventCode": "0x18e",
>     "BriefDescription": "Instruction cache hits. Note, this counter is
> affected by errata 1583.",
>     "UMask": "0x07",
>     "Experimental": "1"
>   },
> ```
> That is rather than remove the event, the event is tagged as
> experimental (taken to mean accuracy isn't guaranteed) and the errata
> is explicitly noted in the description. Currently the Experimental tag
> has no impact on what happens in the perf tool, for example, the
> "Deprecated" tag hides events in the `perf list` command and is
> commonly used when an event is renamed.
> 

I agree that events like IC hits and misses are generally useful and am
fine with the idea of keeping them but my concern is that unless users
read the event description, there is no way for them to know if the
perf output that they are seeing may be unreliable. There is also no
guarantee that such events will be fixed in a future uarch. From a
quick glance, I couldn't find a mechanism that makes perf stat/report
show a warning for named events with known issues.
