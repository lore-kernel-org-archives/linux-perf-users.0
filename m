Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15E184E;
	Mon, 27 May 2024 06:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791260; cv=fail; b=NL5+QnC5AIRlc2JynYKevfzKMy/ova/R3Y+RkwXZqzWsrmVgSTncQkbtszgbX02xmYcyzxbakAZ/l9eJB8LgEPrxzdtrBONU2VUjL2F5YXcqMEi4MvKYdn+9qWrs4Y0J2f55S+agqYKgibByqx5nZoINbDbRYB3gOyflyX6Ek54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791260; c=relaxed/simple;
	bh=hn2S0+R8A1PwaRWOd0woHFFCP9Xs9ORPGQ5FRYYKoyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ibc0itt+I7hbDybxWe2D5WYouGMMo5Js+rNOOGMod4SXxdwHfZtJSwt2Dlwwh+SqbDMejmIUSl8b4lbn5tPmWYKAIgiUEqcEzUO7MmdswEzqHSPrcVHNrgQkYxgvMCOgRixa0H1nOpJ4MoU6fqcR76b+2eXp6e494L7neLRMit0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0s3HEu5D; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0s3HEu5D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwwyBBIAsggh+m5LuNeSYNTA7nJaPJibTwYuR5R2UiVs3N89uvi+oC1nCoHf0A3Htx3/d4mur1kPamwyj00FIdNtl7OBISXnzXFkcfGpHewO6X0Ig747F0xsdLkA5M7kySxa7XCXvg6XX6ucSBSHZPSV93yTofhHdCQjndAOhrykunG1V7IqtLUdG5CB5xHj2q/Wx8sreK4UNoMR4bFgiZCl/l3jW3A7TrGHY9exE4dOR9eE+0XGMLrECbsWfDOlBKU84u0eGlzJ9p9vEUNJjmeKSFRT26WkR3MG/8Md705XB/zY82yVgSWJrs6cW6OXMMFSVwqNV83eiU7wdG+Arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4X//TGMVYeyopqgo+w9fq9nJmCVWsep1d1R7zExOiM=;
 b=GmloEFDHT+i7exMcCLRyH5ehP95mCByq+gQo+yF7mD2szCTBpBU3dVTENpB5E1Cv9hywlFlCKPl0p3wpXH6lBvvpRcS6yePAQ2Ue1Xw8e5Z9utMA/YqdNj86KRphlXBA5dFsv0Rfti8GFt+ZQrzJsy7tGjMQXkzfOB0a16SAVFq+zZnqUN2JZbfe/ASCL1Zhr2enXmGN5+QV/sqc/I/Qrupp2CBEaRBrcuDCs0jHKeW2h9TtSGVWUE3aSJ/iNXq5xRQxi3LUCOf4xVdY5k1uk8te952Nt727bQGAtakRH2LFiEWBW5MNADQk9Lq5BXz1GkU5W1R2EY7dUWVOxwvG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4X//TGMVYeyopqgo+w9fq9nJmCVWsep1d1R7zExOiM=;
 b=0s3HEu5DbzlQHR25YmjS+BVB0Yxr8rMpd6nL0fIZCxc+cnxTMgqk1PAtV1jbcYU6GbJNrFx5+a4UEnaj1Kw1KMc1agv4WDGJGQEYSp2DUjeVz/lHMwrZlSwShF87Mwqt5yzkRFAgUlQZqGua9rdvhpxF3K1Fn5t4elC/Zlq3+d8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 06:27:34 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 06:27:34 +0000
Message-ID: <a95b1963-5f54-46d2-a2b4-159730ff7fed@amd.com>
Date: Mon, 27 May 2024 11:57:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf/x86/rapl: Fix the energy-pkg event for AMD
 CPUs
To: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: peterz@infradead.org, ananth.narayan@amd.com, gautham.shenoy@amd.com,
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, sandipan.das@amd.com,
 alexander.shishkin@linux.intel.com, irogers@google.com,
 gustavoars@kernel.org, kprateek.nayak@amd.com, ravi.bangoria@amd.com
References: <ZjS0Uio+nvZLLmyb@gmail.com>
 <20240504040935.123007-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240504040935.123007-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::28) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: d095b48a-321d-4e28-f4b2-08dc7e1617db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEdYTHNvT202ZkhOUTY1NUFPY29Ua2orcGFsM21WZkJocGRSa1VaeWhiTDg5?=
 =?utf-8?B?cFMwNWpWUEdiZjE2VTF3OHlqWm5VVzdDbk1BTVFKeTBRMnppcEdPUE9mc3VY?=
 =?utf-8?B?RW03dWhLT2hrSjAyNzhBaDFDOGZuWEpvblJQVVBEdWNSbjhqeXhEZ0llL0to?=
 =?utf-8?B?TURKOGJXSEdPOFhPRENVSE9YTW5wQlRTYjh3K0R0QjVyTlk4RmxsYml6SHQr?=
 =?utf-8?B?NlNuWmlObDc4akc1Q0tCQ2ZKaGRHZXRneGp2ZzMvY1o1bURpMUZRZmw3Qkhj?=
 =?utf-8?B?bmlJQm1vWjBtSFpDMHZuK2JKZFFuS013QWU2eHoxdmhEVGVBaTY3bG83UTBw?=
 =?utf-8?B?clNaeDFPc05JOGxsWi9aNlJSS2JmMXJHY2NWSzZ4M1FRaEowQ0xTaWd6N253?=
 =?utf-8?B?SU8zRGc5dWl5Wm1yT3FqWFZITWhkZlA3UVNBNnFWc0JBYW56TUUveGJGSmFz?=
 =?utf-8?B?Qm9FRlZmU0NZbHViZmQ4VkdLQnhYN0dmK0I0YVo4U0dLWFpKd3NBdmlHT2Rk?=
 =?utf-8?B?MHlveVRYV0dLNS9GcEhyMXJiMjRpZjNNYWZCc0lQaWdLb1VNcVlFL1RsREZs?=
 =?utf-8?B?Z0dEOWRNeXJnZnpWSXpXQ3ljYkpmQlFvZGpKUFNqdEtMd2ZFSlFGM3k2ZlZH?=
 =?utf-8?B?K1RpajVqZHN6QlFoaUpCVHNKZWwweUtIeXRTZVRrc2pXbDluWHVVbXprMTh3?=
 =?utf-8?B?bUpWYUJBT1JnV2pCMW9UQlJLWnJDNUcwSC9YWHJUazE0dmYyOG1Ed0hVQUtM?=
 =?utf-8?B?akZrdC9pbGtOSFFJdFhleEFYSklUNFJyd0NhTW05WjdabTVLWkxQUlp5ZnE5?=
 =?utf-8?B?NU9xUkRuOUF1SFMrZk5zVDlyNWZQbW9YMHZ6M091Q3VlaVg5OFhERlJ0UXh3?=
 =?utf-8?B?bGxoTTlRUXdwOUJ2WVo3KzRmaXN2ZWVpemFEcy9FZndYTFh5U25LVEhZRDZy?=
 =?utf-8?B?K0d1QyswaDhwS0JJR1dUT2p2QVczWGlCOXh4RWxPVXNicWdweTRuQlZTWktW?=
 =?utf-8?B?ZnBQNVhXcEt5bHd3a0l5STZCNmx0MkJ1c215V2ZKc25pYmc5VU1FUitGOEc5?=
 =?utf-8?B?RWZad1UzSlAvTnFpZEl6TVd0RXFXUWpodGVmN05IK1RIR3pVS2lQOGt2ZWgr?=
 =?utf-8?B?SEFicHBORndYcTIwZ1ZES0lqOW1WUEtpanJ2SkM3Z2RSeXQxaUp5a0Q0OGdG?=
 =?utf-8?B?TUtRT0krUmFQQnAxQ3ZCOG5DUlhjWWpLY0lmamlNUGlaS2l6elVObFpDQWJu?=
 =?utf-8?B?Rm5VWmFNZW1Nd3NoK2kybUhJbkFKUFpqTzNFZ044TThKVXNSOGVlMW94MDJD?=
 =?utf-8?B?UW9KbTRaTGovazBFNmREK0Q5TFVBalRibytiSmRRM3NDNkwzcGdmYVFIU2U0?=
 =?utf-8?B?ZzlCR3kxYlEwWktCZXpoSm02SVdhZWtmZ2ZROGVKNStJVlIxeUVvK0plWGNT?=
 =?utf-8?B?MUIvbG1nS1l0S0diTEdlMG10MG5md09tYnEyNEwyemRtZmJidTFCZW1PQm9L?=
 =?utf-8?B?ZGJlY2M0SWM0MUZjeXc2ZTRNTnZGbEtma05ad2d5Ym56Wk0ybGs4bFlXcDJH?=
 =?utf-8?B?OG95SlFoYk1tdkx2ZjRYYS9pN3FNcFJBOE1hQmJwZkpXWStxem9rMmFXQ25u?=
 =?utf-8?Q?tNm9h3LNEa0js9KTBy+B/CP4C42zfWThBl0UGWFrd604=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2Q1LzdhVXg2OVNYZlZKSysyTW16QUFENWVid1kxcDZWY1l2M3lONXhhZDJC?=
 =?utf-8?B?cGJ4dVUwYSs5K21IK3lPSlVYemt5YnB0bHphZTlycmhCUGVaYWtXc1NUb0hP?=
 =?utf-8?B?VTdaaG4yRzc2K2RUTHdydEFyTkhSK0p0WkxXVnF6aWJVN1NQbExuNnRVd0N3?=
 =?utf-8?B?VW5HUUxYS0YzL21NdEgvQlVPbVdYcDZ3MGNMV3ZzMWlEM213T2diS0hiTllM?=
 =?utf-8?B?S3NyaXU2Rm5iOGtwTTdQMThBb25mTzFpUE1aWDNieDF0QTd1OWNxU0dOaEFk?=
 =?utf-8?B?a1JBY2xVQTRCZmw3R2VHQlFJdFFMN3ZRaE5tWHRIRXdkZnBNQ0FBNU1VSG5X?=
 =?utf-8?B?MHhhLythMUxNM3AwN3dEbWcwei9GMERYK3RaL2daTDYyWEZyVXpTOWdqbUFw?=
 =?utf-8?B?UE54TzR1aXNpeGg3SUFza3hPMWR4WFovYVZWMGRjaE41V3E0UE05aVVEVm5K?=
 =?utf-8?B?RGUySitYczJaZkphYi9idlBIcVJES3VEdnorZlo1TmYyYUtMdDhOb3JHVzNG?=
 =?utf-8?B?QzJGS2Q2TFk0VnEwOU5TKzR5WjZ0VVdTbGFRcjlCa2FYWmxRdGxER1E3aDNH?=
 =?utf-8?B?OTZVdmhsTnR6YU5CbzZDQlNOaU5HWkVjTVE2eWZlZ3llSGd1U3Y3K2hiTGVJ?=
 =?utf-8?B?cWFLdjNSckJSWHdQQUFZY2hnYllwSlFpQXNHR09vWXJ6TGpZZ1M5UE9vZXAr?=
 =?utf-8?B?alpxdXNYY200YjAwUG8zVHRMSmdVZ1o3RmhiM2ZPTXQzTTBFeUVobHQ2OFpH?=
 =?utf-8?B?SjVWeXN2TVNSSjJiaTJtUUJWWTJuYlZ0MnRiNjhLL2JnVjVEbkRsdHZ3MlhY?=
 =?utf-8?B?VDFoK2xBNXcvZTVCcFFoOExVYStudTcra1czYUZIMkVEbHdYdzcyVlZiMzhR?=
 =?utf-8?B?Q25BT2pHVmJFWGRtbFhjSzZPN2p2SzROVGVqdTl3bzBFL3NOWkNEOXp6V3gw?=
 =?utf-8?B?em1BdDhZMVBVR1Y1MFEzdmk2TjJ3dG5vSWZUUEo4OXJ4TVpaQVdkWWd2dXBV?=
 =?utf-8?B?b3RCMWFjSGlmZ2VMcGxEL01lWExMbVZwbzFYUDF2WWFLOE5lMC96d0FISVc3?=
 =?utf-8?B?YzZoclJMZWJsZnM4Zk1oN0lOWkorVnZlWGlNM3BJWk9hUWJFU3crK1hET3o3?=
 =?utf-8?B?Zm5ua0laNVNCWnVqRUJCMUl6Nkd1Y3hGQjJYdW1OZk5jSXFMQlFBTnByWXpD?=
 =?utf-8?B?NTRmSVJiejZON0NLRS9KNXp2R041TXpDdGlzaEtRYUxJR3R3NkRUVlYvKzJH?=
 =?utf-8?B?Yit2bmxuL3dGblNGZVh6OHh3Qks3dUpvbTNKcHY2bWNtSEIvTFJYNVJaK3JI?=
 =?utf-8?B?V21MbGxiTTVDT1RaM2N0aU9hcWJZdkxQZDI5bDBNWWFQL1ljK1dmNm5zSDJR?=
 =?utf-8?B?R2p5U2tkUzR3R0ExcHNvVHVvTUltV3dsdlNvUW1hMHMzRGEwSm1PbGNyZXBN?=
 =?utf-8?B?Q0JJQng2d0hTOXBhRXNsVE5LRkJnYmdFcHF5NWFYR3RjVUY4OEhiMERZU3RN?=
 =?utf-8?B?WWMzeFMrc2ZGUStUUTBJREowSDdramxPYUNFeHR1N2cva2YweFE1N3MxeitV?=
 =?utf-8?B?Qlk2UjgzQ2RzZFc1S2FaOHZBaUIxRCtrd1AvNHFzRVIxa09MakFzd05YZVdy?=
 =?utf-8?B?djE2RTVQQUNaMFhvQ0RzRzlPeWtXd0pybktsekh3K2JhVjltcE9wV0ZGMjdJ?=
 =?utf-8?B?b3JkNWl6RnNJNXZEeFdNYzZ5MEtGUkFkS0hFdXlzdVBrYTZhTGhXK1J3QTUx?=
 =?utf-8?B?YTFweWtOOUtuZHJyV0Eyd2pzbGU1bFdvaldDZ3M0TEdrNFVRbFk5K0pJdkdB?=
 =?utf-8?B?Q0NHTkJGNlBTTlcwUmVyUWpaVkUxcVpmZ1BkVFRKdVNRaUN1bHp4V0xlSXNK?=
 =?utf-8?B?QjI4VUVLU0dhL0lEUTgzNHAxcmhGbUM4bjdqOHVlY0RkMlBFb2RYSXRmSkpD?=
 =?utf-8?B?NEpnMFNBYm1XY0g1by9PQzlpL0NzOXMwdmZ0d2c0Z1Y0UDdXUVQ1SGE0cmJa?=
 =?utf-8?B?NnErcjd1cXl4clJwZVRVRXlCYUNuWGNpemhYZlZDakovbU9RVWVDUU9nWmJ4?=
 =?utf-8?B?bVZpMWpJbGN0VFIzZDBUWmh3czE5ZlA0eVNMcUxPNVc0ai9SVWkrREZCR1cy?=
 =?utf-8?Q?XTQtFrVObQ6uEBItWJh+1S92Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d095b48a-321d-4e28-f4b2-08dc7e1617db
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 06:27:34.0273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcVkYbpV/wJS52kKXNunmUW+zz94BZ2QSwHOFi2S1z57KPWTDz97wTDRpNqUkaGYwxTulhhpb5lFy2iv3vC4PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048

Hello Ingo,

Gentle ping, since the commit 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
went in 6.10-rc1 as a part of https://lore.kernel.org/lkml/ZkHBjIwLlEkVD2Vu@gmail.com/, can this fix be 
considered for 6.10-rc material.

This still cleanly applies on top of 6.10-rc1.

Thanks,
Dhananjay

On 5/4/2024 9:39 AM, Dhananjay Ugwekar wrote:
> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
> on AMD processors that support extended CPUID leaf 0x80000026, the
> topology_die_cpumask() and topology_logical_die_id() macros, no longer 
> return the package cpumask and package id, instead they return the CCD 
> (Core Complex Die) mask and id respectively. This leads to the energy-pkg 
> event scope to be modified to CCD instead of package.
> 
> Replacing these macros with their package counterparts fixes the
> energy-pkg event for AMD CPUs.
> 
> However due to the difference between the scope of energy-pkg event for 
> Intel and AMD CPUs, we have to replace these macros conditionally only for
> AMD CPUs.
> 
> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
> 
> Before:
> $ cat /sys/devices/power/cpumask
> 0,8,16,24,32,40,48,56,64,72,80,88.
> 
> The expected cpumask here is supposed to be just "0", as it is a package 
> scope event, only one CPU will be collecting the event for all the CPUs in 
> the package.
> 
> After:
> $ cat /sys/devices/power/cpumask
> 0
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
> ---
> v1->v2:
> * Fix the const qualifier discarded error (kernel test bot)
> * Change the cpumask variable name from cpumask to rapl_pmu_cpumask
> ---
>  arch/x86/events/rapl.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 46e673585560..d77bf7959a43 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -102,6 +102,10 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
>  	.event_str	= str,							\
>  };
>  
> +#define rapl_pmu_is_pkg_scope()				\
> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +
>  struct rapl_pmu {
>  	raw_spinlock_t		lock;
>  	int			n_active;
> @@ -139,9 +143,21 @@ static unsigned int rapl_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
>  
> +static inline unsigned int get_rapl_pmu_idx(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> +					 topology_logical_die_id(cpu);
> +}
> +
> +static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
> +					 topology_die_cpumask(cpu);
> +}
> +
>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>  {
> -	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
> +	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>  
>  	/*
>  	 * The unsigned check also catches the '-1' return value for non
> @@ -542,6 +558,7 @@ static struct perf_msr amd_rapl_msrs[] = {
>  
>  static int rapl_cpu_offline(unsigned int cpu)
>  {
> +	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
>  	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>  	int target;
>  
> @@ -551,7 +568,7 @@ static int rapl_cpu_offline(unsigned int cpu)
>  
>  	pmu->cpu = -1;
>  	/* Find a new cpu to collect rapl events */
> -	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
> +	target = cpumask_any_but(rapl_pmu_cpumask, cpu);
>  
>  	/* Migrate rapl events to the new target */
>  	if (target < nr_cpu_ids) {
> @@ -564,6 +581,8 @@ static int rapl_cpu_offline(unsigned int cpu)
>  
>  static int rapl_cpu_online(unsigned int cpu)
>  {
> +	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
> +	const struct cpumask *rapl_pmu_cpumask = get_rapl_pmu_cpumask(cpu);
>  	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
>  	int target;
>  
> @@ -578,14 +597,14 @@ static int rapl_cpu_online(unsigned int cpu)
>  		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>  		rapl_hrtimer_init(pmu);
>  
> -		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
> +		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
>  	}
>  
>  	/*
>  	 * Check if there is an online cpu in the package which collects rapl
>  	 * events already.
>  	 */
> -	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
> +	target = cpumask_any_and(&rapl_cpu_mask, rapl_pmu_cpumask);
>  	if (target < nr_cpu_ids)
>  		return 0;
>  
> @@ -676,6 +695,9 @@ static int __init init_rapl_pmus(void)
>  {
>  	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
>  
> +	if (rapl_pmu_is_pkg_scope())
> +		nr_rapl_pmu = topology_max_packages();
> +
>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
>  	if (!rapl_pmus)
>  		return -ENOMEM;

