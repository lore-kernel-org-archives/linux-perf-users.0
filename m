Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020105.outbound.protection.outlook.com [52.101.196.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7612B73;
	Sun, 22 Jun 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750560525; cv=fail; b=hjriwwmzG83o8/fkHUUHYDfINAuUxSxdbiFC2/ksLPa7xW6aT897uLkcirKG7L7HNIXrCpApwTZblm1u1dQXkawBMCjjMrr1LB99Fh5W/5n4mKrPKzu8FUw8JfWBBBUKopErCaePataYmMWfX+fEiUsMhO/b/Qmh2VzRNFUTTJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750560525; c=relaxed/simple;
	bh=17E7GKteyjzK40xDt86rc67ui34z/V1XWa/wLBsz3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mbft9B9g2LgkuoqIjfUHaoCGOrssPj4eWlMwtefvKgRetox0DS1GDc1Za8sjGRbQ6HM6ruoMG2VV56ZWSJMrYM4NaLFo6mfipgIo2Msp7gTnhs6OYpPtaaOHYNCwDyNZiBCxd0M+nkOtGI2VhLfLJdV6cILF5nci2yTBVjrZShg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWA5lNUbkGqZiv6spH8DTBJovaRczR5ao9OEErVADbYD9TjCrbyi6rCTUVp6HX2LiM0eERezNW5VFnArKeTS5f7jDSDwoR1WB/qCeSQAByo7pXbrymFr3aktuTngwwAxvWGn86Cn7Q7vEqxfGYUCJFbR1RExL97bzQG8ai4W4KPUzZ+SQ9UxOAbs+oKRkwVGhqa151Ghto+2p31Magd7ELarAeuPVYWgtXVyOGB1YrEy4r7Z/WpAXQSCwJOt+yd2LBEICOFXhippKQcB2cDbN9WQuKSWGa6hdkC0y1gikvA78twH7EfdMUYuspcMQheup4nc3/P0Srp0DeH7oloq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAXwVkC/iji0ZiLviqVHsWKfLmhjbt99YB74Jgq2Ne4=;
 b=VfC2vk3MJ/NBtXO5AA23s8v7j8K4DTMvHNzPXCGaCVm6IOOM/fEtffhGZH5D1+x8IuL2cAhl/peQvThaJ+qGx/yKVqqXjVMmwV2o6l2Jj5tpsijKfz12C3bjhRY582s/mzyLK1cNt1dvvd0RGf4ksR0PSnM+A+YFAdzKq9c4U60kV7IXo5LrvZX4pX2l6R1ROIBy1D5KPfRwKSbGTZkYTv1SmE6EV6UTDO73wMCrhiwtvKssgq7xE7nT7KqKdlGwmOKxaI8Ielx/0TJUpNmf8367DwDRgwXLDVRbI/zlMPsdwfSgEY5U1wjwjoqTnuC1MO553fueYQGF7RXGQ3SHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB7014.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:343::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Sun, 22 Jun
 2025 02:48:39 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%6]) with mapi id 15.20.8857.026; Sun, 22 Jun 2025
 02:48:38 +0000
Date: Sat, 21 Jun 2025 22:48:34 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: arnaldo.melo@gmail.com, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] perf probe: Extend the quiet option
Message-ID: <eltfh7yi5ccwdcxewcqgu56plrpr2uvlq6r3elzsswmp67i2x2@j3absnlmj6r2>
References: <20250504104351.1549583-1-atomlin@atomlin.com>
 <aEe7ojjNf-3k_OzU@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEe7ojjNf-3k_OzU@google.com>
X-ClientProxiedBy: BLAPR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:208:32a::19) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 2460d0d8-d883-4f0b-b476-08ddb1374a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am03aHBSMFYvbzdMQ0lweStMazI1Vk9yMmpYOUdERGdvcmN3Nk41SEFCbFpS?=
 =?utf-8?B?YlJicDhVaWswaUk5RVRwS0tLNEd4MmtxYmpMTlpueDBhS2p0dDR5dkN4MElY?=
 =?utf-8?B?WEVhNXFndzhxNjJZNHV2SGlNdWUwenpoeE1CK2pYcXhCdkFNTE1VYlpUb2RN?=
 =?utf-8?B?cTJsT2dyOEJVek9JYi9La3lsSHZodDZPSHM0amxuK2orVlNLRE1qakZxaloz?=
 =?utf-8?B?YnY5TnFQL1N1cFZKMmNEa3BnbEs1Yzc2T3BkOTZkRkozY1VyMWloblJGTDk5?=
 =?utf-8?B?MUpkZU5nN0R1eVorWk1QYkFjR1ptL0hHNnhHK1lJb1hmVlpPeFYzMDlNWHdv?=
 =?utf-8?B?eW1qVWVSRXZ3UmNMeEh4MUJsYlZNZ2xSUU05RDZOQjJjdU9nZkxUN2t0bUxP?=
 =?utf-8?B?ZDNCMUFxTGdUYjZiQytnRHFZYTVZeFRiSDhvbmZ5ajlKeUJxVXg2YjQ1aWVU?=
 =?utf-8?B?elBSS1FHYXQ2U1daSUgzZmxBM2ZnRE9lYmNva1hxTDFlRUZTd2Q5M2R6Zkd6?=
 =?utf-8?B?b3I0Zlk4NjBDdWcwbmhiMFBzNFd4bW9aVmRCYU5wZ2hZekxFTkMyTmpwOHVW?=
 =?utf-8?B?cng3cFpad0pOL2t0bHVlUDMvSFJrclZZdzQ4VE01bHJpWFJWOGpySzZSajdK?=
 =?utf-8?B?TXdlMzZpeWJrbnJYM0t3Z2x3Zk5Tc05pTCtweWFHUi9NTExrR3FsSE8yaDhM?=
 =?utf-8?B?ZlZWcXMvcEpveTNGN28vSmpFT2FGVEM1dVEza25Kb0liajhFdFcra3VWTEYr?=
 =?utf-8?B?QXNyT0FydHArSllHNHpCa3hCMytyQXB0SllRcXFBdlhJcTY1RXFhcThkbXJF?=
 =?utf-8?B?ZmFNUlBIMzF4cEtPWEtzNjVqZStCeXYwMTdVY2VubG8zQitHUlFwUlRvVW5t?=
 =?utf-8?B?OENNeHZaQXp0NnpTdkp0cE5ZdkdRYSsvS3QxWE5GSTQ3ZTRUNXJ2ekYxM1ow?=
 =?utf-8?B?Z1VKTmV6dkxKZElXbzZ2OEU3R2NyYWFTTkZ1eEp2UVdpN2M3VERxd0Z3WGps?=
 =?utf-8?B?V1BtQkRNc3BRNm1MZGYxZm9TVmpVT0NTak5BR1ZNenJ5Y1haS2ZtS2p1ZHlh?=
 =?utf-8?B?c1VjQTNhRDllUVNtY01NckM2QzJkYjZuVU9Na05GOThzeTFtMitlSmVYTzJ0?=
 =?utf-8?B?ekQ1YVpGaUhZeEc3YTFLTWdhczVtWU5RMy9LMThxQnRhb0ZsZk1kb3pDZ3NG?=
 =?utf-8?B?cTlxWld5b3d1enlUdnNNdHg0Mm12aDFaOFR3YkZRamllbDlvK0F5VEkvaTlQ?=
 =?utf-8?B?ZXJFREp3RVJjMmZvc1JOdWh1SkU0T3lWekxGenkrRytmVmFoRUhra3RneWlr?=
 =?utf-8?B?SUwzZjhHNkhqSjRxY1NHcVlJdEtWNGllZW52SzdoMXBZT3J6QU5mdUNQYnRy?=
 =?utf-8?B?ZThwZDNXcTJwdXgzTEtxbU16ME9FbC94eDhXQmxlUVhGV2p1ekNPWmk0R09n?=
 =?utf-8?B?c0d0bjBRMzVPdyszcnM3QUh6VVZOVlhWektNUFBaRllrZnBraHlQTlFNNFpT?=
 =?utf-8?B?WjFDQ3lOZ1pHbWtLeXFzY045bEt1R1JHamgxcUp1Qi9KUkVHT3AwUkRQTVpX?=
 =?utf-8?B?aXF0TWMvdDA2dS9Vc05SZnpUak1ha0kyblRsOURPUUhBcFpEaWVQelJtUnRN?=
 =?utf-8?B?djUvMFlXVXRHWFhKMlI5K2UrbU9MclJqT0o1M2JEZVRON3dPVmpiTHdZLzVh?=
 =?utf-8?B?RFdhQUNqV3ZiQVViZkV4Z2wrajZiY1pFZVpVUjI4ZERuckthamt1Z2dUUHVx?=
 =?utf-8?B?K29IQ2FyTHRiazg0L1NJVjd2bXp6dmdKNHF4aXhEbjU0Rmt5OVY3WVYrbEsr?=
 =?utf-8?B?bGtsdjdvR1VCWGN4UGZETTBOZmtXaWlodUZqR29adzBiWmJXR1FuZWNCY2k3?=
 =?utf-8?B?MU90R0FnL0FmeS9hUkRJdHgwd1B6LzNOZWhOSm53RGRFdEJpZU9kVE85RHdq?=
 =?utf-8?Q?fHCDiJQOYio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmQ2d2t6SFg5K0FzdHBoRVppaUlvaFhicFIyQXZiSEpidld3N0svZFBYZkR1?=
 =?utf-8?B?cDlVVFVCYWlWa21SR1RGcWY3bm4ydTJqUm15TVZMN2JkbGJJTDY0SUc4Yy9n?=
 =?utf-8?B?RFpqT3JVTmoxQ1NtUzJNRFFqaXNGU3hiUmZieFlTMW0zK2FlcW5uZjlpanpt?=
 =?utf-8?B?OWt6Q0M3b05CMEY1dEp2bjMvZ2JXdUdSZmQwMjd3OUR4TC83K0VSZ3l2SE93?=
 =?utf-8?B?QTE2MFlEcEc3Szh1WWoyaUdHTnVIbm5pZXdOMGl3cFV1TFRyWHN0dERmSHhu?=
 =?utf-8?B?Tjg2Y2FDQ3Iyc1BzUzhvZmFqYVlVVDdMT05aYWR3N2F4emVnT1NGVW1LeWgw?=
 =?utf-8?B?RXVJdVVlcDBxYVYrSCtYRFRWdnZ0QlZhcXZIUGtHSStRVXgzMW0rRk1CUzJJ?=
 =?utf-8?B?WEtndmhmYnlDWjd0emxUKzFERWxQOEY1TXpENXJTaW9WQzlIZ3VLSlg0MVJL?=
 =?utf-8?B?QkZIbEk5dEZhVjQ0V042c29jUkpaMFh5QlEvRS9iZVZCd3lZZDhSUXpsdWR2?=
 =?utf-8?B?Z1ZOQ2lQMXI3RC9vdWdMUHRkUG1LQTJBSm9tLzJGQ0VHaFhISXJZRm1ZZmRF?=
 =?utf-8?B?YndHVGVYWElkMDJrdEY5OXdwdmRSV29XWUxSaGJCQ2NpWWRZVUNVTTZtZjZ2?=
 =?utf-8?B?dkRFWXV5bUVRTFdoNktIcEpOdHBGRkhFcWN0SW1NS0d0ZWpLRHJLaDZrWFo5?=
 =?utf-8?B?VXNoZEg0aFVsR2FLRjNmTXNsOTkzd2ZvRXhQcnp3VENIZjdqQk1TUmRqL1lQ?=
 =?utf-8?B?UDJMRTBwWVFiQm4xdk11QWpFME5NNFJRUU5Cd0NqNnpsSzRoSXBSK0lyc1Yz?=
 =?utf-8?B?NS9VRG82S2Q4bUwyeGtSN2NWaHdMNlRKMk4wNzQ1L2JOR2IwYWJwOFY3c2ZM?=
 =?utf-8?B?WHFld2w1eFg3ejFtbHNUblplcS85U1NOeW1meis1cjRMaHdzWjFvdlZlZ203?=
 =?utf-8?B?aVd0YmdCa0tZQjhlQnE0Nzh1ZUJuemVWcmdrV1Q4MmRJdW9TMzdsb3lpVk1L?=
 =?utf-8?B?OWlrYllPalIvTnZoWXM0Yk5XaC93VVFCenZoY2NvNXIwNkxQWUJneEtuLzN1?=
 =?utf-8?B?UUs0UGQyYThtcjhCYTRCQ0FhVWR2MjZacjZLSnlvRnVUeWd4MEVadUhTUURN?=
 =?utf-8?B?U1BrSXhVY0VvMXNpUjZaZEgvK1VXZHdCQ0lXTUhaT0NVV1JTYlA0UElCeHFY?=
 =?utf-8?B?bXJzTXZ4VW9pTStDMXlzMC9uc2FndWp2cXJUaE1tSFUzY3lobDk4d0t6WUVG?=
 =?utf-8?B?Q0I2ck5McHhMeCs4NURPZHlESDJQc2hIb05PSVZiLysrcWtSNlJvVXE2RkxB?=
 =?utf-8?B?SzJ2V292aW5PeTVjNEF4RWVyd0Q2VlN4RGxBbk5RYk1Wd1JBMUVkSiszL2I2?=
 =?utf-8?B?ZTRPbE5KY2YzQUpZMS9RYmkxNG8xRml5UGcvMjBtVVkrL1NzMWhNMFRRU3U2?=
 =?utf-8?B?Y2pZYjdCR0JBWE9lZHBxNW11QktNZ0hMQ3orL01mSXpKeXNtSzhBSmRaUlFv?=
 =?utf-8?B?Sk9zV1BMSEVaSHpBMFBOMERUZUJZRkhGbHMwaGxJNytXNnIvNnJTbThxTEg4?=
 =?utf-8?B?ZnF6VXBpZFFReXlSN2FUTlVHQS9jT0lMZDhHNEs2Q1dGYlI3SDNnZHNxYVJ1?=
 =?utf-8?B?VmY2N0ZVSlRydVd1R2VzZWxkQ25xbTZmYXgreW9DNVN0d1FEV1RHcHRMVkcr?=
 =?utf-8?B?cXhRMW1ETVZzWUI5SmUvNEVLZFNBL1VocG9Wd1RxbXNDSzJpT1NWbnJ0dkZF?=
 =?utf-8?B?eGJ6TjN6VCthZnhCQVloMEJwRjQ0RzVWYVZ5YjIxZDA3elJMRHFQSER3OFlU?=
 =?utf-8?B?c244cTI5SjNuN2Z1cXVNRUxyY25OcG16ZnFvbDdJSldHK3haeWtlUms2NE0x?=
 =?utf-8?B?M3I4VmVBZ0hzdVh0VjNwTmFib2FhQWhuYVNaMFczRWNyVVhZalVDeno0YnJu?=
 =?utf-8?B?VzhjVTR3ZktiZFZvUVNVQnlyaDY2VnJORkUvMndqNXZQRUZ3YUtCc0pyVVRR?=
 =?utf-8?B?SXZoVzZ2TVAxOGtqNi9IUFViaGFjRHZPSUd1cjRjTUVITGltL3VRZ2FoWFBV?=
 =?utf-8?B?UHZiTlpBRmI3ZWFpVEk5TktQRXVVNFJlVnR0OFBaTktHS01GRmw2dzVZU0Jx?=
 =?utf-8?Q?xQxgZcVH49Bj9BHQNKJHHtXC7?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2460d0d8-d883-4f0b-b476-08ddb1374a05
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 02:48:38.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wuw+A5J2FHE8r4H/2aAzJ9uSPVS6EX3uSV0W8f7AgCHUBZgkJ5TM3ro31PruQY7Xn7EZfNEPGPa8pGBrK10wzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7014

On Mon, Jun 09, 2025 at 09:59:14PM -0700, Namhyung Kim wrote:
> Hello,

Hi Namhyung,

> Sorry for the long delay.

No problem.

> On Sun, May 04, 2025 at 11:43:51AM +0100, Aaron Tomlin wrote:
> > To provide a consistent and complete quiet mode, this patch expands the
> > scope of the [-q|--quiet] option to suppress all informational messages,
> > including those indicating successful event creation, in addition to the
> > currently suppressed warnings and messages. For example:
> > 
> >     ❯ sudo ./perf probe --quiet --add proc_sys_open
> >     ❯ echo $?
> >     0
> 
> I don't think this change is needed.  I also see no messages before this
> change.

Fair enough.

> Indeed, using -q/--quiet option makes verbose to be -1 which disables
> any pr_info() messages.

Understood.


Regards,

-- 
Aaron Tomlin
