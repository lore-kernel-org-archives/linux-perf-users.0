Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6804501B;
	Mon, 10 Jun 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016715; cv=fail; b=Xg5RZP4j3ciQ+btbJvEon5j+MHnHalw8/QO6NWDUZEFPus9F9NDOJUFeG1FytGGVX0Dt6SjpCL+Oyo/5cHiXtqq9NdK6/mDKkrWJx3pwPiAWE0A7Xhg13HBLE6FVc7a8vU9WUgaw9MMZOQ9GJbnBXtU1AQR7hvO8prD2niZxWaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016715; c=relaxed/simple;
	bh=rKfmh5iDVfAbQdyfM4P2vpuYZwlgXLhmLb66zcve++Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KUnH33/VXZmOms+654lcu9cVrK4lT0jOhG6I/ktKsiKA2R8/XQKcZVkwWY1lU0+DocmuoT3m08Xg6D1+QOFvX2sIxIlurNIoD++i6yXRUQZ6BcDqa+dLJSv4DZ95QXQVZ5AFzqBEwLVdpHL8+8bqGtphbh+i1QNU5DbIH4xpLLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H08xYbAy; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H08xYbAy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nureSG0zvcOGG2MEnnsqA5phFJQXlVhIuUjKoTazEJ1FI9G8Xz2k0TeGPaQTI/eHkbxfYRbwrsttZJVzWZEvgwnkWAhC0GmQkmMeU37xL2cSfo6zBatQrQtmjaqPgViIZgmqhWo9etn30/CS1nlhVEa//tXBWLluUmzCSqWNmq2x8jl8sowxZoWyG77sLf+lgoWc/+lw9sLBOCCo+4J86arDY8RtIRKTnm6Jqdt5M/vtJlNKn9Uqlrfw6bH29E9VRMXlXz8Rt5bsTm0TR5ObNJxokFrO8nSMkWEVJVZuPZbDOyIyGhb8csH+ASvh13RTYjgwHpvKxxKMj173vJMyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxB95qXdmh0fjLAibQVCLpnsYkte9rF0Y05K3ip4WyM=;
 b=kSUCky1U3I0L4DnDzbLT1IHJVtwffzEVDdrDTWC3YMh1rwGoZ+TriYR1ulWBNeKaoQedGnj4o6giUYhxKRE/jiQnMviRGExPxRL6+d0iJj076V6cxOuMjzrdJRyKfbz6vfDOwe1dIsXRdS3sKoasm4vqBC7slfRrNx/RWRYaAJmOzoiYq7IWbX8m5i4HA8h615w0bXL+Fy2OLtWzB42JDQcCsYptAaS1jMZfTSqX4pcndo3tsU8g6HyaLv6S52l0bb/gkgpYRfqeuOGqlGRFNVJSWFv1fVHCuR7CxkZT3dQjEf55khWy0VUdC7TEJFUMF7SNSt5KLoUzZsuR3fq8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxB95qXdmh0fjLAibQVCLpnsYkte9rF0Y05K3ip4WyM=;
 b=H08xYbAyw7lOuocADZbOfY+ZcyS7ztJ2zB4cq23Bqv/A2s7dQuNodTKvItNZtq+7jbdO2g+mQ3xsNkEVSOoNCYsR8GQqYrOt1MW6ubGb+95LP0P/SOc6wlXl+W2Z5XuZy5vBBF6fFwE7tHOWJpfdJ28hu8o3X7StnAKpzGrbMjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 10:51:50 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 10:51:50 +0000
Message-ID: <78db946d-db24-408e-92fc-b7ff79c80728@amd.com>
Date: Mon, 10 Jun 2024 16:21:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: George Kennedy <george.kennedy@oracle.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
 <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
 <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
 <36e86320-1a43-45d4-b25e-a5d60857f4b2@oracle.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <36e86320-1a43-45d4-b25e-a5d60857f4b2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 20178254-df81-46cd-f655-08dc893b5507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFhsWTN6dmNqUWN6cFlQNUtJVTF1eG84TjlOZnlVb3VxRDJyVzdiVG13OGlh?=
 =?utf-8?B?VUNBdFlUdytEbTVZbjZhQ1ZjYUVWektkeFdSMU5FQ1VVOG1LZlRUYkI4VHk5?=
 =?utf-8?B?SzM0c3hlQnFKcEhvQm5Yd0Urc3FocU1yczQrditNcU5oQXp5Z1dEb3o2WEtk?=
 =?utf-8?B?M1F1TmdKVVMwQ24wSmVNMlUyVFFVSStHNDBpYk5jWWVhbkZaaU1xcW92OXZN?=
 =?utf-8?B?Vy9nYlBVQWNBdzFRQUJNNjV2TGw4NnNsZjFuSGQ2QVBBZ3Z4QitQOFUzL2tk?=
 =?utf-8?B?c2hnekJXYkN4NXk5L3RxNGo5S0FYVU9PaTk1b282TGFBQlY1bWlFTGNva2Qw?=
 =?utf-8?B?ZmhIRjRSa2NVeWNvenJudVkva2I3Z3hpME5Ba21yUkYyRlBacDdOSFVpVzRi?=
 =?utf-8?B?ZkNlOEsvZWRvZDd2c2dsZEwxL3M2ZE1OWVQ3ZGhqSVpKTmlxOVdWT2x5N0dQ?=
 =?utf-8?B?cGlpUmZwaDA0eWQyZDZNYXZnMkFLaktoNUpqb05YQW8xR0o1T1M5NTMxY0Zt?=
 =?utf-8?B?M3Z0cmNPd0dHZG9rVUUvQjlTRU5oWGV3eFQrUk11TGlFQWtqQ0VaRzFYaXJ6?=
 =?utf-8?B?ckErWEFydkhWUWx3VG5tZmVzTk45ZmRuSmFpWEEya2JIM3RWWkM1elF0OHFR?=
 =?utf-8?B?ZElNWXc0WkJobVBSK1VoUlcycGdpZnJ0UU9aS0N6eis2TWFsVVFhVG1La1F2?=
 =?utf-8?B?a21JVXZrY3lxV3JsSk1KR1ZvS2VEMVE1YVB4TytMYzdKZTlmcUtuT2xkTnRY?=
 =?utf-8?B?dm1YNWwvUndiRSthK3RsL2NQOHd5MGE4Mm0rUTVoZXZyY3E2YlJ4U2JsQ3B1?=
 =?utf-8?B?R1lLd3oxd3dmSXpYMFFOUkxvT29MNGZNRkczMTgzM3dWSmN6QnlVd2liNTNl?=
 =?utf-8?B?MSsxYzE3NGtFSmlOU2cvN3BscXRndmY0blZhamd6ZFROMUo0VXVBV1dJOGV6?=
 =?utf-8?B?NW5CQlRiaXBTcmRBUS9rVzhseFFvZEFxZ2djc1hWRk5jeU9hQld3eFRLRnAz?=
 =?utf-8?B?Z28vZS9TYjhDK3lHandkSHZSUVlYaDhhc0oxeTE1L3VzVy9nMC9vMlFzN0pI?=
 =?utf-8?B?TGE5bm5CV3hiWFlvWGNob2xoNHRBYUFBQytEMTEydmRqNW5vR2Y0M1JMVzVX?=
 =?utf-8?B?b3lPU2dMWVl3dUpqSkV6TjhTcEMvZ2E2OWlHaW1CbERCYm5MLzdCTERwWGd4?=
 =?utf-8?B?YUxJZFBpSXVma0p1YTlaMHVnTnMydHRwQW1vVklkbVBIc3NPRld3ZFZQbS84?=
 =?utf-8?B?Q1pqYzBiaWxBWkUxWXkvcjFjMmFqY0IwWmFtRGg0SWZvSTRTOCsvUHlsY2ly?=
 =?utf-8?B?aFBJWEVscitXRS85VHRNa2NrMHJtME5PRFdYM28wd2VLc2lmbHZ1aDdzZnUw?=
 =?utf-8?B?TTdpS1BKQkZsYmdXWEtoaUJTODEzTi82NDZXVFh1UG53NFRPRmsrYUtDOFl5?=
 =?utf-8?B?TEVQbHdkRlNLVTFITUpNVkRaMVdleTV5Tk9CQjNpQkw1RHUzdXBla016aUZP?=
 =?utf-8?B?bFFueVFwTExjbGlIc1RaemJEZDNQbDB5RHVxUjk1SDhEdGtEVFpSTGtWRVVx?=
 =?utf-8?B?T2paUjJtNlNaY0FjcE5VWm5CclFNZ29lQ0dyZVhRcG9BVUpkcFZyUWFVaHNx?=
 =?utf-8?B?SngxTWh4LzF0UFVQc0FhTjBibGJsa2txVGVKSmd3YjBPOFNGeDJLVlRUb0tN?=
 =?utf-8?Q?azVX9ONwR7FY3HfB0nqT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG9yZlhPRXQwbUQ5ajRsRSt0QVM2UGZhYWZSMjAvcjFiRVBWM2RyZ3M3RTFO?=
 =?utf-8?B?djMxMFo1bUFnRDRGcGVZOHZ5WTY4clAwZFRCd2pJcWQzaHc0Q1BnZEFVdkVX?=
 =?utf-8?B?TnFBRmdDU2liRlBLOXl3Y08wWFFzbGxmbUE1YmtaTWhQOXRYNmJGQ3BDMGlG?=
 =?utf-8?B?TTB6UVdQalJRd0ljTDRFZjhnczdZYVJkakF3RjQ1SWFtcThmNXFDWjZHV3JU?=
 =?utf-8?B?OWk3OGUwTFZEM0lLcEp6K2REY1ZhTENGTVg1bDJGUjlKMjFkTUtoUnB6MjNN?=
 =?utf-8?B?a3krVHRFK0xmemVxL243WkRPVTdJdld0enMxSUN1N1RjU2ZjUm9GUXlXc0l2?=
 =?utf-8?B?dlJFd3VZWm9PcUdzNlFXcE1MV3dKMXJXWm5Cd0daRks1VTJlWUVlY0dXSUJ3?=
 =?utf-8?B?NWFFRzI3Q2dpU1NVUWlITE1RekxOazFGZFQ4aXZmWXYxL20vaHJVSVYrM1Vi?=
 =?utf-8?B?OEZFd0ZHZUNqL2NxWkdKUGd5cXE5R0FNbURzZnlqL2VGK2kvUXNOU2NBQklY?=
 =?utf-8?B?ZXFsN1luN0xIdUNHMUltTmFRbFI5MnFoazRBNVF2Ym5wSG10ZnhWYVllQ3BQ?=
 =?utf-8?B?QzV3RTV6bUtOZndSOXE5czU5S0EyNFZuU2d3VEdEUGNKSmVMTXVhU0ZPRzZx?=
 =?utf-8?B?TzhDc3FBL3Jvank0WDNxVzB1R2htRldEdlAzOWk5SVZpT2Fpemp2Q3puRWJq?=
 =?utf-8?B?VHdhalk5ZnZpdm83MHFGbFJabDVHQlRaMzE1TnVhVEFkMThpTGRqaGhOWEI4?=
 =?utf-8?B?OENXNk1vWkt3d0J2R2U5ZnJQSkJzMzZnWGZvQnRwSHkyc3JJdkNYODhvZXdE?=
 =?utf-8?B?ellPTHI5RW55bnZMcE1oL2pnU01qYXdxc2x0bWZtbDNoVW82aStpZnByQVVE?=
 =?utf-8?B?d0hsRkxzN1RDYlNhMFV4bkpDdXRBUjNmUE9kWUh4ajFKM2ROQWlRanZUZ3NO?=
 =?utf-8?B?QTVkd3lmNkxIbDNpaE4rb3pHeXNQVXFRZXdmRmpEc2JZSHFNbVZXMzRtSXg2?=
 =?utf-8?B?ckFKRmhGUE9yUEdSQ0VQWlArSXUxTnBBcDJKWjRpYk9VTVlOVHdIUHB1aERx?=
 =?utf-8?B?VkxIaXBDRTg3Q00zT2Zsc0k1MXkvR1A0SXdqdWVBUUpHZ3dqV040Z2xuc0c3?=
 =?utf-8?B?NmZSUktiNzJPZmFBSSt6bjRtbjE0eURpblByM0xpaDRUb1p5ZWRKOGVsK1RL?=
 =?utf-8?B?L1UwNmpkUnFXSWhHdHlFbnV3cHhCOUVyWjZmais0VU1RYzdmZVErczVCaFIw?=
 =?utf-8?B?RWZTRi9aTmU3YUlBaDZsYUx2clZWeUZBdXo1RUhXNDlVRnhYUnNNZUNjcklR?=
 =?utf-8?B?eE5hcThobXJTSFBkbm84VktvSzg3NHk3Zk00Zmd0N2JWMnlzMGtUOHdJSFNN?=
 =?utf-8?B?SmRqcytTdW5sN1B4QzVEcXA1VGlPbVVQUS8relJiUmh5ZlljQ1BhNnh6eGcy?=
 =?utf-8?B?RlhHamdwamQ4TGFGNmV4ellxUVppSDJGby9PRW4rY3FQOUpNMXozS2U4NWpq?=
 =?utf-8?B?alVBZVZnRE84ZEtXQnB3Z0p5MTYyWE12SkxLNXJSY3BFQ1N0dy9NWjErdExT?=
 =?utf-8?B?TDRCZFBNYXM4RGY0N2tLTHRkTmdZNWVpay9ERXkvSWY4YUt6OHdjSWgyaTBC?=
 =?utf-8?B?UURYYlY2R05rbDc2SEsyK2hDMVYvaUx4a0U0enRHdG1CRm5ybElJTXhxZnZS?=
 =?utf-8?B?SGxUQW5EelBZNEhaVExXRjJ4RlI3NXdTTDZReFNBQWR2M0t6cWxMMGtPb3Yz?=
 =?utf-8?B?cVVSVysySjhpTG1Ga3RVNFRmRTgyS3IyTjBNUGlKdGdRd2lQYk9DOTN2cXRi?=
 =?utf-8?B?VHhmU1hxbVJyZ1Bublo0alNFSjVITXg4V05HSmdQVG1mOTl2T3lNWGNRNUty?=
 =?utf-8?B?emJ4cWRNZHlyWkRtZkhqRDEyOWlIWHVTdzB3OSs2R2sweWVTRXRjYzZnOXdR?=
 =?utf-8?B?eFV3SVBCUEhHSXVUcUVjRlB1alIwbkN4U29kUWRPUmZMOW5nMUw3ZFdaUGhZ?=
 =?utf-8?B?cG83TnNjMXFoUksxWkdmZ2VPVTVRTEE4Nkl4YjRWcllMclkxZGNvMGxWYXhF?=
 =?utf-8?B?cjE5a3VIVnJLaTB1elZPdWF2RUdUZDh4K3Q1MlRxNDMxZTBiM3NjM2lwcVdv?=
 =?utf-8?Q?yyIlw0d0tTPbIZPRtPAllLikg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20178254-df81-46cd-f655-08dc893b5507
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 10:51:50.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUu0WYsvT4PoCNDiPoJxA/GjHHCcFLrbsvLasBTBxnc3KzU7eHx3Z/4V30T3vK9XFFYjCKZ2+ZHaA88SxI3XmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281

On 6/8/2024 12:43 AM, George Kennedy wrote:
> Hi Ravi,
> 
> On 6/4/2024 9:40 AM, Ravi Bangoria wrote:
>>> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>>>> Events can be deleted and the entry can be NULL.
>>>>>>> Can you please also explain "how".
>>>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>>>>> This appears to be an AMD only issue.
>>>>>>>>
>>>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>>>> The Syzkaller reproducer can be found in this link:
>>>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>>>             if (!test_bit(idx, cpuc->active_mask))
>>>>>>>>                 continue;
>>>>>>>>     -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>> +        if (cpuc->events[idx])
>>>>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>>>>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>>>>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>>>> There are subtle differences between Intel and AMD pmu implementation.
>>>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>>>> amd_pmu_enable_all() loops over each PMC and enables it individually.
>>>>
>>>> The WARN_ON_ONCE() is important because it will warn about potential
>>>> sw bug somewhere else.
>>> We could add a similar WARN_ON_ONCE() to the proposed patch.
>> Sure, that would help in future. But for current splat, can you please
>> try to rootcause the underlying race condition?
> 
> Were you able to reproduce the crash on the AMD machine?

I'm able to reproduce within the KVM guest. Will try to investigate further.

Thanks,
Ravi
