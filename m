Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2127.outbound.protection.outlook.com [40.107.236.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD51A4E6B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725572951; cv=fail; b=TpDwQjYWOTAz+8HnvjN38XfmLyOjf8zcO+2H9SWcmWFp/mAPlGJj93iEM82rAsHSkKd1bGdzonjJWPTDDE8DxdS6yfzvDFKTR4ZlfrBk0Waj8hJ52JVzkr1JZjeUZceLucqr5Lo7Gc48HtS3GF9hMQLDid9rA9DEMHue6iJb658=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725572951; c=relaxed/simple;
	bh=Ttrnb5aAJBtJfdPY7n2CrGFBLmIOs5WLKlA9ERh6rvw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EmlSfeIQdMM1Nu8B5swnZqkhQP9j2hrTjTnh019DVFqEr7OkGo6Kf92UMa/sPPf8CKQra4kwhqvmpPn0XyfFBW46Jd06khM6uAXmRXFmt+Xe8gkAidLk91qApkFOKH2zd3nQPr8fYhjl0eJf/rrzGAFx/CUZSIvpRItgIC/+Ssk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iMgQ4pfT; arc=fail smtp.client-ip=40.107.236.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iMgQ4pfT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUtZWJaNtzKAR/wrhRupfHFZ5hZzQYP1lEV11QeJOcA+ssp5lX3EDsqAbDYCOi6sbC49uESwzC2Kr3g+ORd+28jJlhvr0y/6n8gAKu4y53UWkWO0jXt760AFW7feySeana8S1T5V0uFUwqFI6PbCyl9Nz3hONVsxOjnf+P33PeZBdX4HYsqvN2om6O0nheDdXfk2Fy4Bb57stC2Z3fGxIQuO3arEDu2Q3VzLW8wd0qTFC6yxHdaoDhj2vIE1ep46L9MbjjYLHeq1esXVT0vZOFSrKYaydrqGSJzrlqUw9rfeLatmH8//WWasGWGt3fCsvzNt+ps6PlVA/yEmjnMdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcB5X8xVvIaAPfvMnTAkVMLdt0hNtXyCnnxl0Q9WOt8=;
 b=o0FVwu45rwt8L0zNEZ08ChINONWRwGeUpCOnAWWtgtkFSxO+4KXPFN5Nka18grFqrGw04NCKWUqSh0aaN0awHMhpvxVgUzlC6k/I9Gr1nrrdzRV3AGnz7tMcOShTvj4n6bTT9IGpTaGzDB9WT9gmSS8HsgulUxx1Ovhuom/YuBJwMYhD66RVlb7ZyqabygeV0xmb5nXE7sU371xQwOhPLeNaFqdJIEhmpDzYCLdd5s86JakT1yYKtRUtKFUO3M1hIMOh9slMp/6wcg7Ls1zx5t1qZucXJ/8EAJDyf5x4UL/VLx788CgUHDMjR9QeqO4dkfhAaWT9hdPuATalaGNPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcB5X8xVvIaAPfvMnTAkVMLdt0hNtXyCnnxl0Q9WOt8=;
 b=iMgQ4pfTcYwcixKSsoynhTrxRa4bzUznfWvwxRi0XhlCzZk/BnV2exwvBiuXnhKhaUB6ORWVN04u1zMefHky7QZyYRW8xtaR/HuV8Z8R/IS3TN0LZsxnRtDg09q6XbR9nM0w4+DyLH4OmAVCQw3QBGNmoyBHLc1uOEC86J+CYLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SJ0PR01MB7315.prod.exchangelabs.com (2603:10b6:a03:3f6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Thu, 5 Sep 2024 21:49:05 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 21:49:05 +0000
Message-ID: <5f403fb7-5c5d-4207-8fde-9b38412914b9@os.amperecomputing.com>
Date: Thu, 5 Sep 2024 14:49:03 -0700
User-Agent: Mozilla Thunderbird
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Subject: Re: [PATCH V6 4/4] Adjust objdump start/end range per map pgoff
 parameter
Reply-To: scclevenger@os.amperecomputing.com
To: James Clark <james.clark@linaro.org>, leo.yan@arm.com,
 mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
 <110501d82b12ea7909eb7d02899ef60ea42c7e19.1725493961.git.scclevenger@os.amperecomputing.com>
 <21d05d38-a41b-44ac-a9ab-da7f749ea3f1@linaro.org>
Content-Language: en-US
Organization: Ampere Computing
In-Reply-To: <21d05d38-a41b-44ac-a9ab-da7f749ea3f1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SJ0PR01MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 33c6d6f8-8a19-4467-8aaf-08dccdf49032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0xXWmRsRUZTRTlXRVhrZnlScE1ZcXZRWWM2NU1ycmowK0h3QlJ5OFFndjJt?=
 =?utf-8?B?R04rNUtQNXFtUjNRcXlwVkNublczdTJ2TmRDQlBuSVFCSyt2NWhKbEhSUFV1?=
 =?utf-8?B?WElGTFdOUXpEWThVMzlEdXBSczJQdVF6cU4wdmdKTjdTNDF6YkVUdUdtRFBw?=
 =?utf-8?B?RUExYnpuRFVWYWU3MW1kR3NMMUxYdHlwSHRuRE1DQitZdnNUdjB4cFBUT2wr?=
 =?utf-8?B?TEdsK2wwT05zS0VPYUdVU1E2RmlVUExYNjFlQVdOdm9GZUFXbWlaeXZqdmF4?=
 =?utf-8?B?QWhqN2M3QkxDdHdJWVVDS0F5c213NmRCdHZRZ2IxdWlzd0M4T2M2eksveExm?=
 =?utf-8?B?RDZDcmZZSDJUMFpUYnB1UTJZdHh2d3dIMmpZdWt6RDVkbmtMaUFRYWl2SzlO?=
 =?utf-8?B?cE1VaVMxYUVGdFZsemk4SWhJSjNRN3ZGQkZmbkgwYm5KQ2JyQWV5OFlMV2I4?=
 =?utf-8?B?d29ENDZYWTNuSU9LRUZLOURtY3ZwaFlsQlRvNkQvR2V5b0dOQWRla1BiTDdJ?=
 =?utf-8?B?Y2lERG1KVjkzLzJzekZjM1FmeXZCcFhKUWRTdGlyb21YRkplUXczVXcwbDgw?=
 =?utf-8?B?UzB1bzVybjVHbGFFMzRaVGJsYVVTRjJDd2Ryb0lIcURzeTdmUnhRem14aU9D?=
 =?utf-8?B?RHZSYTJERjNhZURreWxWcGlkcmM0WjkxaWcvYzgwRDh1VjdxYTR0RUNqQXV5?=
 =?utf-8?B?MzlYaE9sR2NYY2pXWUx1aGVXbGJjM2phbDRnOW5jY1dqWHR1WmRFdjJYTWZp?=
 =?utf-8?B?TDZDR2ZBeVJORTFhYVh4ZjJOMld3NGRLeW1VbzdacDBFSTdmK1kvanlhLy9Z?=
 =?utf-8?B?OXlaR0lwejZSSG1XK21HdFF0eUNVdGE5RGFFMXRXU2p0N3EwUS8waGY0R1JE?=
 =?utf-8?B?N1VIamNyQjJRYXRkVXVRaDV1TTcxMTVNbWNGcVdDUWdnMjJkMERqWWVyYUZo?=
 =?utf-8?B?SExkU3IrUkh1QzNhb29kQTkvSUhYSjU2bFMwVDEzNXJ3eWV4RlJIUnFWbEVS?=
 =?utf-8?B?SFhybXFPMk13MXdSR2NGMmhXL3ljQ3kxZmxyWElEdE1uV2FtUzFMbkhwa0pi?=
 =?utf-8?B?a0k4am9BcXkwcVRrNTNjeTRNRzZaYXRjSUVBYkNla1NqYkRUUGlMbklkcUJx?=
 =?utf-8?B?akM2dTBsVWxISE9sK3JHRnpTME14SUhYZk8zMG1xUkNneUFkZFMvUC9nYjRt?=
 =?utf-8?B?RmF3TlNZeDQ2M1pmdHh4MHlmUkFXeXp6aEpSb1RBNE5iM0lQcEZUVVRWM0ZP?=
 =?utf-8?B?OWNMdncxUWVvLzhuQXdQOUlpbXhxK1AvaXdRL3drc014cjFkZC9HMDMrV0ww?=
 =?utf-8?B?MnlFVGdKKzluVFNoTW9JT1hPM3huNk9pb25HaTlQdUVWZDdxKzBSWGgxZlU4?=
 =?utf-8?B?ekE4NW9qOWZyNkhvNlFMemh2dzMreFJtbGRTWERXZGF4N0dOaHViV1lhclR3?=
 =?utf-8?B?WnJNc1FZOFNvc2hWbE1BQnFvaDBNVHl6TFppbithT2tvaHVhUzhLanB2emxu?=
 =?utf-8?B?b3BXMGl6dFYrd3RLUGpUWlRQVUdKdzJRa3RSQUFKUTg5QXJNSUo5alZ1NW1l?=
 =?utf-8?B?cit2Rmg2Y0RpMy9wbnVEbE1oTVpwTlA2SmJmRTZURUVYS0hFSkt0UXh1U0w5?=
 =?utf-8?B?N1YrVkh4MUNtWFRlL3lYRW5aRmdDQTN2aFMvQUZyM2ZQUmptSURXbWJ6bmti?=
 =?utf-8?B?Y2FTZHdVSmQxdDlJL2RkS3B1czJMdG9sYzRoVHp0QVJIMzB1VkJ5Y0pjYXkr?=
 =?utf-8?B?d2p1dGRKd1U4cTc3OG9CWExWUHoxbHVtRkJKcTZqUDNBcFdvRTlGbkVYWkJp?=
 =?utf-8?B?SmtnTFQrL0VuT0JiL0czQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlhRam9Dbk9LcFZQUlVaR3J6MDV3YklNbGFhSTJIek9jVXc0bjFhcEY2SXNk?=
 =?utf-8?B?UnRyamdrUWZZeERaVkpSSkl6aGZxWXpVellxZXRNU0VndTBiUHVoUGlZcUg4?=
 =?utf-8?B?czNsc0tRNXJIWmIxRlFNK2c3R3k5VmFKamE0dE5YOEI1WkNSaUFWaG41T1JG?=
 =?utf-8?B?eHlMRGJxek9sa2hBUUFVZzhkN2FlQVFrZTgzM1Q5R1Z0NW1hb2Y5R3p6VXJX?=
 =?utf-8?B?WHdjdFp6ZkZXSDRPRkxDVzhPTXRNOUwwT2M0VERodWFpSkgzQWVraWpaRUtZ?=
 =?utf-8?B?UjNGRks1Ty9Ha1Z1YXFyeUkyYWNuMWhGUmFqUjZKc0FKWHJSVkVoTkNiN2pU?=
 =?utf-8?B?cVFZTXN6VFFvYkcwT3hJS204QXlLMFBmcEUyZ3UwdXdtMzF4eHZYT0tJakM3?=
 =?utf-8?B?QVJzM21zOXBWQ1pvSjRnaGY3MHg4THNSREFjOWN0YWZWbkdSL1lyR2NZNkZj?=
 =?utf-8?B?MUR2ZkFvdlpEUFZjeGRWQ2NEVVZFc3NUSm5jUHpVblRHVk5WNEZ3N2NweWNI?=
 =?utf-8?B?UjRLcTdPQk0ydVc0L0lzZndvSUUvTHBraTFSdmhLS2FKbElNK1c5QzZWTE9B?=
 =?utf-8?B?UUdpZkROWnQ0SU9Jd1lwL0ZUNzNITlZid2ZzOFV1dTc2QXFDa1praEt0c1hq?=
 =?utf-8?B?VlNZTHhlTXpVVzJoUC9HdmtoYmVDWlhqSWpOcytIRm5NRVJFR3Z0VWZZMXht?=
 =?utf-8?B?cEd2ZGFjamlSS0RRNUVqaXBkRDJ3bHdycXVqL0tHcEtjNGM5TDhnZ1h6cXlF?=
 =?utf-8?B?YVgxbWVqZDRwNUt5OUxZUC9JTUtMWGZWY1Z4ODB0RnB5OWJWdlkyYnI3UlpL?=
 =?utf-8?B?MUJJVTAydVhsNHRabDBmZmtNeVpNT29IcXAwcksyU2NFeUNDdGYxM0Z3Z24v?=
 =?utf-8?B?VXZpdkhRUXVBbVhqODhpRktiVTdORnJvT2h0VEpwMHd1d3lxVG8xN2l5a2hz?=
 =?utf-8?B?TXFXWExla0NlVUErU0dJZGY3ZFFSYkhkbXRsQnJUK01zQW1oa1REM1ZPNnVo?=
 =?utf-8?B?RXpiaGpxM1MyMXc4bWhET29Vd2ltVDN0MjZLZFVzbjAvdjkwSFRaRDRaVDVD?=
 =?utf-8?B?YnpScjFGNmpIZDd5K0wzZFBMd0NtVXBJUHZZRzBxRi9jRjJoVi9aclp2V3Ew?=
 =?utf-8?B?WmFKNWdHYlkyZmRFbDZXY2tpRFhkV01HdXZpYW16OERjRDJ0VVUxWlNScEpL?=
 =?utf-8?B?MklpTVFjOVRobW1FNFQ1dktmV2RFUTQ4d1puc1JLUDVEV012citlZVpRbG9t?=
 =?utf-8?B?amJzZGxtbkUyUURtWjJkT2hGR3dhK3lLcXpUVnhDWTVyMWNFMzVwTHFmZ0J4?=
 =?utf-8?B?dFFrTWNQNmJ2WmlXOEM1SzcrTllBck0xenIyd0tLdHlJKzd4N2dLQ0NpL3hN?=
 =?utf-8?B?SWV4ZW5NY0JUbWpSa3RCV3BxYVhidFF4bE5CVjFMLzN3WVlMR0ZmeUdVOUZz?=
 =?utf-8?B?QkUrWXA3Y1pEZDJPQWVnMlN3Y3pvUm95UkpFU3oydGQ0MFQ0a1N0ekVzcUEx?=
 =?utf-8?B?QlhxQWtOLythRGN2cDdEcG1PZGJyMzVzWFExWFVIRFhyQ1hIR0cwSlB0aVcy?=
 =?utf-8?B?YUYzbGJlaEorQThkaTRsazRrby81U2ZhVlVxYzdOVm8xMG1lZGYvYTNncml4?=
 =?utf-8?B?VTRVaXFicWdyQ3FzVlpsUkpnZ25LT2gzd3ErTUJBOHJFSjFOS3pWekw4a2lW?=
 =?utf-8?B?OU04dVVmWkdaMlNqWWt6VnBvd2ltZHMwRlN5YzNhdlI0UDNGNVNKYXFBalZy?=
 =?utf-8?B?VUZRTFhjN1h5VnNZbFFCd2lTMU1reWJSMEtPQ1hxQ3hCNjI5VjdiWThmODkw?=
 =?utf-8?B?a2oyNkQ1ZmZZazM1R0x1OHFyUTJ5aytLV3VSYytVQ3k1d1pXZmZPN3lkOEg4?=
 =?utf-8?B?YmNpKzdKYXRUd2pVRmd0ZTlZS1F4TUNpaFdyTS9SZC9tSC84ZGtENUdJNThF?=
 =?utf-8?B?c0FlbUtoSWVDbXF6QzB4dVdVNWxZQ2J5WTRiWmpFUFJpUUJKOVVtb0IwOFhC?=
 =?utf-8?B?b2ZLSE9uWEsxdGM4T0tPS29iZTFLditnTGhSV3BmTHRPZ1pNRGx4czVHRlVy?=
 =?utf-8?B?amNtb2U3OVRLUVRGcFNyUEpLT29YWUw1RVgwZU5nKy9mWlpLVnZraWkrTWli?=
 =?utf-8?B?c0hQOW1vd3FGdXdQaXorKzdvODBhaWFvZjRqODEvWVJ1ZGsybGZsYUJ4WmNG?=
 =?utf-8?Q?APmmysdoQKhRPY5PtgxyqEU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c6d6f8-8a19-4467-8aaf-08dccdf49032
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 21:49:05.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k50rqRP/1FEH/ZxwHWLUKGBWIXTlgWaSIk7uvHrORzj9XXmkHSIbUZ3wcq69MAdYQuRmJC0xhMhfgsSPjk6H76XA9HD/w6eMEqOMoaFh5HPuEMqFgF7HOYwgVRrmJiTg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7315



On 9/5/2024 6:45 AM, James Clark wrote:
> 
> 
> On 05/09/2024 1:11 am, Steve Clevenger wrote:
>> Extract map_pgoff parameter from the dictionary, and adjust start/end
>> range passed to objdump based on the value.
>>
>> The start_addr/stop_addr address checks are changed to print a warning
>> only if verbose == True. This script repeatedly sees a zero value passed
>> in for
>>       start_addr = cpu_data[str(cpu) + 'addr']
>>
>> These zero values are not a new problem. The start_addr/stop_addr warning
>> clutters the instruction trace output, hence this change.
>>
>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>> ---
>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/
>> perf/scripts/python/arm-cs-trace-disasm.py
>> index 7aff02d84ffb..35a2ab60ca12 100755
>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -187,6 +187,7 @@ def process_event(param_dict):
>>       dso_start = get_optional(param_dict, "dso_map_start")
>>       dso_end = get_optional(param_dict, "dso_map_end")
>>       symbol = get_optional(param_dict, "symbol")
>> +    map_pgoff = get_optional(param_dict, "map_pgoff")
>>         cpu = sample["cpu"]
>>       ip = sample["ip"]
>> @@ -249,11 +250,13 @@ def process_event(param_dict):
>>           return
>>         if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>> -        print("Start address 0x%x is out of range [ 0x%x .. 0x%x ]
>> for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>> +        if (options.verbose == True):
>> +            print("Start address 0x%x is out of range [ 0x%x ..
>> 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>>           return
>>         if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
>> -        print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for
>> dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
>> +        if (options.verbose == True):
>> +            print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ]
>> for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
> 
> What about skipping printing if the address is 0 rather than if it's not
> verbose? Seems like a zero is expected because that's for
> discontinuities, but other non zero addresses that don't match are a
> genuine issue.
> 
> And there is already an early exit for zero addresses above, maybe that
> just needs to be fixed to make it more general. But this one probably
> does need the verbosity change:
> 
>   # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>   if (start_addr == 0 and stop_addr == 4):
>     print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>     return
> 
> Also minor nit, but I think this change in verbosity is a separate
> change to the change to add the map offset.

In my experience, non-zero start addresses outside the dso address range
are exceedingly rare. I don't recall the last time I saw one. To avoid
having to pick through thousands of generated messages with zero start
addresses, I'll filter these out.

I also don't recall ever seeing the CS_ETM_TRACE_ON notification message
embedded in the instruction trace output. And a typical trace capture
has many thousands of TRACE_ON packets. I only have Ampere HW to use for
CoreSight trace, but how valid is the test with start_addr=0 and
stop_addr=4? I'll change the script to optionally print the message in
verbose mode for these conditions.

> 
>>           return
>>         if (options.objdump_name != None):
>> @@ -262,13 +265,14 @@ def process_event(param_dict):
>>           # vm_start to zero.
>>           if (dso == "[kernel.kallsyms]" or dso_start == 0x400000):
>>               dso_vm_start = 0
>> +            map_pgoff = 0
>>           else:
>>               dso_vm_start = int(dso_start)
>>             dso_fname = get_dso_file_path(dso, dso_bid)
>>           if path.exists(dso_fname):
>> -            print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
>> +            print_disam(dso_fname, dso_vm_start, start_addr +
>> map_pgoff, stop_addr + map_pgoff)
>>           else:
>> -            print("Failed to find dso %s for address range [ 0x%x ..
>> 0x%x ]" % (dso, start_addr, stop_addr))
>> +            print("Failed to find dso %s for address range [ 0x%x ..
>> 0x%x ]" % (dso, start_addr + map_pgoff, stop_addr + map_pgoff))
> 
> I get this error here for this line:
> 
>   $ perf script -k vmlinux -s python:tools/perf/scripts/python/arm-cs\
>      -trace-disasm.py -- -d -k vmlinux
> 
>   Traceback (most recent call last):
>   File "tools/perf/scripts/python/arm-cs-trace-disasm.py", line 331, in
>      process_event
>   print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr
>     + map_pgoff)
>   TypeError: unsupported operand type(s) for +: 'int' and 'str'
>   Fatal Python error: handler_call_die: problem in Python trace event
>     handler
>   Python runtime state: initialized
> 
>   Current thread 0x000075db4c249400 (most recent call first):
>     <no Python frame>
> 
>   Extension modules: perf_trace_context, apt_pkg (total: 2)
>   Aborted (core dumped)

My mistake. I intermixed the types, and didn't catch it during test. I
Look for Version 7 to address your comments.

Steve C.

