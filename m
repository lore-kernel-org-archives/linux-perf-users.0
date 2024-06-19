Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1E15F402;
	Wed, 19 Jun 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812613; cv=fail; b=eVlsX6/6maKDvJJb9blY/7uGsUyzaf8/ea0Vf5/Ixjl+YXOCy2H0ZQkDfhtaTxBHpso1T06sa1sCqagizj2OpWmsi1LSTrtmpqy+PJZw0wSePh1/b5GorDr4ThPuNxS9nRi+6afh2hLJg1wQ7NwdKxlwDQBMjo8+FukXb/IWZeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812613; c=relaxed/simple;
	bh=dVxsCFDRSq0+yp8w60Br0ZWjdNDGgGamL1Aw6hIY924=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AYM00a9+/TXgqrLHzC+L+xXFJe0yw0pN6JSj4bF7PIzxoHCt40C2CrW28r7g7N8cy1uZ8pT6ZejQs4/rzOJDG5vIkZSoslYKUo5Wx5yN3CfTf7YUlJn+cO8RQYbYTkksslPrdxLc8BQAjBfCxeo85Um4BdtpsRttg0H23cNjlbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sN+eiN4q; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sN+eiN4q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO6iaGQ5vEHgpGVGziqTmM4zEoocOgYUH4+k3SZWaw/B+SH7RABWY7j6xJ02KbfLtUIRCPdtKQy/x1c17IslTMrg9gkR4ypgUpmnURnekjZY3FQ/FNzKlHehfCc0GSFpuyeJtfBo6OLnsRTjmeF0c8jGXkf7Pe+RTmK4LZgQZhI5NOp44i2a+u7eCjQ48Et5L22DThRCWpIhEzDEGl+ugVsviocVtYx15VH6WzK5JvdYUpp0Lj95SKH2tHneLSw+wTeSzWLN8hfqWXHwztKyo8S8CGZp2G5t87LKsDHXavoboIXYdc8W8XRRU5igx3kD9CFRSVhrvnV6Wm9NrBXv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ub+9ZRkye6RzYk7JaWVbpO2oVNWQid/XE2lFqdWWgg=;
 b=av6OKaqnPRl1duOIKrkmzwmbWckMveARJ4rkuvzMwfEep5aiVxrt33oP0vsXt5+lboaeGsNbmZvopID9z5YX/cknkF4CTWBVTqtHKLohXtUGkUMjCCqxULa5Hr3wr9xIzZH7IEQzj152Fduz1mI+znEDuvPW/qpmm8LTeMIku2858JHwiSgeaYzlMXX2kS1SzOqZBgkNnKpNUGqX6wIX1MeY0Uw9oqj3bE0jvBFGttMtXnwbCt1EjedYiIfCsCJkn5mZFWAURsqPWqJqFI8UNOIOrGcpCz0Em0UInBKWiSU6WjBeDhPwUoTTHmZ/2VtEfnxDh250EunBSXaYt/DGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ub+9ZRkye6RzYk7JaWVbpO2oVNWQid/XE2lFqdWWgg=;
 b=sN+eiN4qwszcC05sHSxMAR6yJ4EoaAN2UGO4rXVrLnJ8IgPHoqf5G/8w2GqjEFO54zgr73p5OqUDO+je540V5rnywupQzMRwado//W15yeqdzljRZY7nn+xg/ABFXjq6c0kwVZ0qW4NZmqa7gdqdANf0wT2/O5BMck2ZrsRhJsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 15:56:46 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 15:56:46 +0000
Message-ID: <0b53607e-03f4-4f3e-9332-c9f4c43ac88b@amd.com>
Date: Wed, 19 Jun 2024 21:26:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf doc: Add AMD IBS usage document
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 yangjihong1@huawei.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, sandipan.das@amd.com,
 ananth.narayan@amd.com, santosh.shukla@amd.com,
 Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240619092234.1165-1-ravi.bangoria@amd.com>
 <CAM9d7chpM4k+BRNNf6V0OS1PRX7c9f+QXa0EwKWjPPzAZVYZBw@mail.gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7chpM4k+BRNNf6V0OS1PRX7c9f+QXa0EwKWjPPzAZVYZBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: d276291c-1351-48ae-fc3a-08dc90786bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUo1MTFBaThwTkVqMzhXZ0VXZld4SFBFckpIZmcrM0RuNWV2WUpIZi9QbkxP?=
 =?utf-8?B?RndqeDRHempyMnoycnV3Y3JyK2pjTG1ORWR5YndMYUR6L0VJbEgzUDZHRzYx?=
 =?utf-8?B?WVUrSENMNUg0ek9DQ0IvTFFmWDZjaTlxL0Z2c0hvUHBWNXQvUTFSVzFzWTNh?=
 =?utf-8?B?QVZpNVhVQy9iZFo0VDcyN09qY0JzRWxTbU5IMzdQMXBsaFVUOW41ZXZmNDE0?=
 =?utf-8?B?bWF4dDNCZzNjVGZleDVMRzl6c25KODh2S0ZCN2F5SmlNWFRGZDkwTjBrS0dR?=
 =?utf-8?B?a0Z3ZHl0UjY4ZHNDaXpMRitoS3dQTWlXWDdabmJOOFNYODg3SFlLK2NCUUJ4?=
 =?utf-8?B?eVRVSWY3TzRla0I0U0k1WFRpNjk2ZHduZ0xYamcwbXVmNHlYR2owUFlGcmJN?=
 =?utf-8?B?ZEs2OHRKL2t5dm04U25iTGxsVTJSZnNadVMwQXZKQ1B5eUF4V0xLdmROVHJU?=
 =?utf-8?B?WmIzWEt3QXluNjJDbVQ3Q3FlWk5HdThnQWp6QURKb3VRQXd4N1Fadm8wQVJN?=
 =?utf-8?B?aWxSYWZNdkFUVlUrenJxMGYvUVBoZW4wZ3loMW02eFpyaUY3dmZIc0hZWWVw?=
 =?utf-8?B?T1hIRzY4Mldpdy9NbHhQVVY3bUFTb3A0ZmU5alJYeGZLZTB5enkwL21SRkIy?=
 =?utf-8?B?OHBEaTVnQmNCYTJFaU4rSjRDcWNQK3FxbmlUY1BtVDJUc29rc1V3Vk5xQkJB?=
 =?utf-8?B?SDZCeDFxS0QvMmpRWlZ6T3k5VjNZYWFyMU5lek5ya3dQbnBWOFZxb1hHTFox?=
 =?utf-8?B?RmRidUlGWUdYMUpBeDI4SHNtT2MwWTZ3TUl4NXIxaWM0WjZRSTBpaXNuTUp1?=
 =?utf-8?B?L2tLZG9XQVBPaVR0cDJReE5GU0V3ZW03UFNxa2R0RlFWZ1lTRXM5SmZRVXQw?=
 =?utf-8?B?cmEyU0hEUzZXUlI2Z2NGRzZkd3hGUVZKQ0dXQUZqN2V3N01KbkZHQnUvaFo3?=
 =?utf-8?B?MGE1Zk9neEFqNDBkK2pOMnhBbTQyemNoS0hBVzJwKys0WnhJaE53dW4zaWFF?=
 =?utf-8?B?QW9ZSDV6T2diQklLSWM2NENGR0RTdEpnNkdOREgwbFZzcDhDNXRrZXI5bCtC?=
 =?utf-8?B?Qnh4SVpGbGFsWFBLZk93ZnZpdFBrOWJCZEdmUkFDYjh3TVdSb25PYndoa2FD?=
 =?utf-8?B?dWxyL1kvcnJQRDViRVRMdk1jVGZOWXJSdDJwREhGRlgwQ3lLUURmOWEycXhD?=
 =?utf-8?B?dmgzQml3a2N3STdEMmNOb2JaMHRVT1BMZCtlc1dkL1I0QitBL0NMV1A0d3VP?=
 =?utf-8?B?amtoTGxRcklJZjJoTmtta1ViTTNycDd4L1lJbHFXa2F5NlkwNjU5Vi90MUQv?=
 =?utf-8?B?TlVkODFOWDhaVnl4V3Y3NXI1L1ZBbUFDNjFCcytneDk0Z1dPUk5VVVh5Wk8w?=
 =?utf-8?B?OWwyOHU2b0UyNGVWQ1FHSjc3cmtIYTI1eXlYdUY4UUs3a29ZdkFNdkt4MmUz?=
 =?utf-8?B?RmJTRzIxaGQ4anBQUVJhR2ZoYVJqdHVyOU9GYVd0SjI2MXhZQTRqRTF0NzJ0?=
 =?utf-8?B?aS90YlVjMEkzRDNnZDloUGdMeUhGYmZWNEFIdHJ2ZURlemcwK0pyK1lRL1p5?=
 =?utf-8?B?aUI5OUlaczlHcEJ6UUlhcCsvTjkrUVc4d3RuYUlMakNLQTVUTTVtVUxGZnli?=
 =?utf-8?B?aXZVOUxlNm01NFpXWkpobXBlMm00Q0VHQzBTN2NlRWltWmc2UlVVYlg0OEJv?=
 =?utf-8?B?ZStPdENNRHhCcGE4SDVWWFVBOU14K1Q0TnJpVFN1QjhsMjcycE9CcFVJSktU?=
 =?utf-8?Q?8q0Dw4zVCpysmSsKmOF27UTLsAdYnviMjY7LmND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVpUQUthYUp3VUQwL3hOb0RiaUNucmJkV3RRUmw3UDd4amkvSVhKU3NQSnVM?=
 =?utf-8?B?VytuTUZqMzhJSDBnb0xqT1pzWXNNelVyUGhnRmdxbUhvcXZTLzhDYk8zQm03?=
 =?utf-8?B?LzhqeHRZTjlQVU54ZzlDNm54dkIxaXp0Rkhaekx6bGdaNFAxYmdlM2JNOStq?=
 =?utf-8?B?Z01HV2kvWm1YZXV0cFpkU05USkJXazl5YkoveXhKRDE1SVF1c2V4U1phL0tu?=
 =?utf-8?B?Tm5tbU9JWVBPVy85NTV2V3NmZnJCT1Btc2pSK2hzOG5kSHhyQTI3VTZPcW1H?=
 =?utf-8?B?N21Rdzc0TmpCN1FsSTBEWURwY3hlZVNUZXQyd2pTWEZqS2E5cUJLc0V6TXFU?=
 =?utf-8?B?UjBHS0R5dy80S0txcktFcFArbVZseTRXTmEzYWFuTFRMQi9YUTN5bzhXd29j?=
 =?utf-8?B?MFlxM29aNzdrek1pMERSTjNoK2h3TXZ0TWtxTWMyMU5KSm1vUGkvZjVnOERm?=
 =?utf-8?B?bFVOalhzOGxGVmxzUFdyWDNPOEFmcTRPOHdVakZjMlRkS051ZXI0dDhseEY0?=
 =?utf-8?B?MHZPOEY2VGVSWkxNNDlVNThQLzlvU2krU25UdWt1WUlwUGNRYm1ZUk1CeFNj?=
 =?utf-8?B?K2s3bndHT09uTVhtZFF1VkxMdEMvMisvTEdPWUdibUZNMmxRNmNNSHZrUDZG?=
 =?utf-8?B?WkExSGYvenJxVVErZ2R1dDBTVlpwczNuRlVMK0dTWEN0QWtLbzc0SjlFUmVo?=
 =?utf-8?B?czVsclhCckxoRzJJeHo4QklpSUVjYnF4UVFtTE1td052cXpMMXpFa2U1Q1l4?=
 =?utf-8?B?cEZZNy90NDNpcEpxYWJCQ21rOGtHYU5MSHJGYUV0MDNjdE1lTmczRmQzS2hN?=
 =?utf-8?B?TWpRS3Bnd3RkTi9MQW04NkI2bTIvaWVPbnVtTDErY2R0RFhrQXhpVjJTNXdt?=
 =?utf-8?B?azU1ZEFOQ3hJOE0rUGRscFYxSXlUbUt0eFhjNnEwamNyakNIWlBYWmpYRERo?=
 =?utf-8?B?bm53OENNamJWYVljc1FnUWlNVTJSWWVIazQycWdXeTZpakU0NVllUUtvQ0pQ?=
 =?utf-8?B?NDE2Nm1VWFo0aGxnS2E3SEhPVk1hWXN1dERNOVBSbExMMVpZQWRtNnByK2Zh?=
 =?utf-8?B?SmhzalpPUFo3NjE2OHB5NFU1dDE0WUNPNnEyUnV0L0c4bTUvdGtqOGN6dXpq?=
 =?utf-8?B?OTJudklJMmJhY0psekZzNTZYSXU5aGhCYyswTHJtOWNMeEtNOWZnVStRdStQ?=
 =?utf-8?B?YTd0cUFDcm9uWE51OGs5VGQxU2FrOERCd0E4NHg5SkorUVV3dWVhdDBNYjI3?=
 =?utf-8?B?TDVuSm9Qc2hwUlAzSk5QMFZOdndubHRzSlo3T29RVGFpMm9tbkRYa0VTWUNV?=
 =?utf-8?B?OURpbVRMNHQ5SC9nNDkxbmh2T3RleFQwK0NCRmF5OVBlcWdJa2JrdkhsaEV5?=
 =?utf-8?B?dW9lek52NXlsTXNuaGJ2eVhGSGltdHA2WVNlQzJXUCt2TndDSzg0QnprbHZ6?=
 =?utf-8?B?ckRNd2NPd1h2SkNRRGpFSnNnaUxFUHp2RVZHV1E2UGJ3ZEVJWHU1d0Vvb2Uw?=
 =?utf-8?B?TlVFYUZ4bVVCZ29XdjY0eTVPU2k1Nk5lRkREME11UDExTHVUeG9FeDhobDhj?=
 =?utf-8?B?bjhIeEU1Yjd0K0o0QkV0M1huWXMwN2xiS2xwWWFwYzFzZ0hLU2N2bVpmL3dG?=
 =?utf-8?B?REtWcFlyUVZKQ1hSSHplL3IzUHF5WmpGMWZ3eG1mNGc5N1BBVFlsNHRFVy9l?=
 =?utf-8?B?aGxuYjBsOGRHY2dwdlA3UW05d1NnQ3Z3M3MraEFlZVpwRXR4SUt0Z00vOTRV?=
 =?utf-8?B?RVhKWXpWcUgzTzIrdmp5dW92UEhDRE52UDBaZGpZVTBjUStmQ252UmpRTm1O?=
 =?utf-8?B?a1huVXdKZXdoM2RhTXNlMlVVczdlOEh4Y3g3ZUp2ajBTSW9qakQ5TTgyZ3J6?=
 =?utf-8?B?cXZoUnRDK2wxK096cFpScVVFZU11Sk9rNnMvUm51V1IzTzl0MktqR3FsbnFT?=
 =?utf-8?B?NW93bzlCd1pDcDVQNEVtckpXRlFLOFJYalpkZUdnZEpzZlBxUENxRHhjZER1?=
 =?utf-8?B?azJEdmFralRhWXpQa3hYZW5kcXY2dGpmcTRZaVM2N3dsVnlBVTNBdDBrTWdM?=
 =?utf-8?B?aWUwMTNzNmduNkpmVG5NblpHVDlYSHZSbGR3K1FSUlVBaXVoOTFDSmpPVDVO?=
 =?utf-8?Q?A8jAIfZjStMPpLGIfbogk4BoJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d276291c-1351-48ae-fc3a-08dc90786bcd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:56:46.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPk2s3tCQgPS51LZ02VcSAClyNmddDIuTJ7+WpM3XwOOgSM2ol8LT82ND/0t1tTJ2pamxHa/HqKllixZ9qFXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

>> +IBS Fetch PMU
>> +~~~~~~~~~~~~~
>> +
>> +Similar commands can be used with Fetch PMU as well.
>> +
>> +System-wide profile, fetch ops event, sampling period: 100000
>> +
>> +       $ sudo perf record -e ibs_fetch// -c 100000 -a
>> +
>> +System-wide profile, fetch ops event, sampling period: 100000, Random enable
> 
> Can you please add a brief description of what 'random enable' means?

Sure, here is the detail about RandEn bit:

Sample period value in IBS Fetch PMU must be multiple of 16. IBS hardware
internally sets pseudo-random value in [3:0] bits when RandEn bit is set.
This variability will help in cases like long running loops where IBS
Fetch PMU is tagging the same instruction over and over because of the
fixed sample period.

Thanks for the review,
Ravi
