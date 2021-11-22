Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4302CC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 16:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbhKVQ4H (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 11:56:07 -0500
Received: from mail-mw2nam08on2048.outbound.protection.outlook.com ([40.107.101.48]:29409
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239884AbhKVQ4H (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 11:56:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d78/MmfTbq8UFyk1a5G4RfD7tUAwQ9ulBbO4KBVrWE0XT4943S5aRxC1OlKOZmH2yghp7npEh8t4o9RvDPM5etiAthwEZDb7XaZXzjUL9cls+PnsPhyH6obcpcKmHnDH/VcXo1GWRRDAQpC7khtkwCAD02XOCBU5OOUMX7QN9IGTeQhadiRK8sjt/VZQC5bEFJZeDoSBY+S5v4FAe7CkZNwmWaTZEf+2jjg1jCy5/FwSp6V91B3+eDaVWufXQS7YScYbBy/Tut2LQSDMD/bSLxJ/42/EPsE2BFR+wX23BbqU/dIwztkxdnbPyVCX6VYW+Ba5u1hFtA4FKzLfEuZ6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX0+14YrWbWfqihLtk/aGkvHz2nOsS6sUnxxj1NbAcU=;
 b=Yh9hSilSRkZiS7l64U0MXbO/onE9YOSLnWp8s+MdxQ70UmZ1htziEL3TpsrEneCqGJgXzzkI7TF3CEaVVJ+o4yhs1ffWYQxYJWIDf6mpOQh5+ZsZ26b0aGxMOMAHxHQxSh9D2F4ZbMTqMmnaVVD2CacDdsiu364MYO71MFdHpkNWNJdUVLFIt8/O/Fn/URYz58eaMYCVPTntG6Bw4/wIgYD+HNMF5fKOy5s/D48g226MTKzvVgNpNVQwRKrulP9ARiuJkWT8rnTEEpZZmhYm3x92NbPdi9dglndHCwXBWJhmn4kO7bTZ9OqMggqXwJbUXws0vqecXDSwbtOnn6ee4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZX0+14YrWbWfqihLtk/aGkvHz2nOsS6sUnxxj1NbAcU=;
 b=PpBr+OYFcF9s53mwdEEplv6PDanwCgpzgEAenhn+XpPS2HMsZlKPpmev9/dEvHzKPlkq+cTjd1ifDcCHB2uAF31y8yPGQTTTDAjOU36EeBZDba0B894V4VOJg+puoJbhM0oH+6doPx7gdZPr2WHgrsiEq4QPQmoJ4njzJ81HW8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR1201MB2497.namprd12.prod.outlook.com (2603:10b6:404:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Mon, 22 Nov
 2021 16:52:59 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 16:52:59 +0000
Message-ID: <21eb16b3-ddbd-b249-e7b1-476cb17361be@amd.com>
Date:   Mon, 22 Nov 2021 10:52:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/2] perf/docs: Update link to AMD documentation
Content-Language: en-US
To:     Sandipan Das <sandipan.das@amd.com>, acme@kernel.org
Cc:     santosh.shukla@amd.com, ravi.bangoria@amd.com,
        ananth.narayan@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, jolsa@redhat.com,
        kjain@linux.ibm.com
References: <20211119111234.170726-1-sandipan.das@amd.com>
 <20211119111234.170726-2-sandipan.das@amd.com>
From:   Kim Phillips <kim.phillips@amd.com>
In-Reply-To: <20211119111234.170726-2-sandipan.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:207:3c::36) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend Transport; Mon, 22 Nov 2021 16:52:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0018c949-32be-40aa-657c-08d9add88a03
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2497:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2497FB365056DCE66E17BAA8879F9@BN6PR1201MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J66IZ6XiAiSt4XgNq8Sm0eU1bZJJ7B6EWEdTo0/gAiUQkeZRyAJDC/VU1mLA3rBPw0n7Ng6jP8EOE88WFrK98icQcrtiv+IIwvP29h4CSMOomJQLwIiBtzSkFQIHowbD7BDhi9vuBbTpFCB3cfV0xtefEsAYFTEdm6iAAo5rArlwx13mXILQSFA1giwFOMKGtj0rTWjHXNF4nU+yQ9Ve3qgOzjgBZqSTXyGSv4LS7HkzaGUqzfbycUXuJyJRD7hghBk0xi7/IQFAGdIWElrdaX2ST+M4F0W7S8y409Lg0zBzfKudFpDcAUAZc/GIR+GCuCi9ruE6Vj2m6jJlHe4zTrFdb/s3a5tfbq4TjSNqoCc47xbGgBZUqidpxDdA+xdyWIHWtH8Rl9t4phXcU10FyLRq8TZvj3DkySmKYGfu+jL5oAPWywBwxmKNe98Efj9fEKbCVI46Z+vQopoMDvTzw1EB9ct9bTEUxobnrLzZWYAU7tPRJ5vDvrLjmSG4V15sKkC9Yd8RVfhaYmVzR/g5cP2qsGUb02MnMsuFPmzxbItbbMFYLnN8C4YBcIiUW4emchs/Ahi9ZS1GycogSBuIS2msQPn2V8tImoDysSegf6UBEY+GzhWp3KuaSFZKg50TuIEzNL/JZLJfMM8TZJofU4XFZ40Oq1zbVMaVdNyB4KttV7PUhAiE0UF6rVgsEwgi+HAmIU+/dvzBpLQ2hjYGEuzVq4U0FfLbFj0frnqI9H1i1fve1zCAgu+SW+ZpLCJ8ZxqZx3fBfsX9/DFtieS68FAcp2LiCZ2pJ7UcYImnpQZVSRaJ5Rb5ekxN5ds5KWrW1ln3xBvIxFHX2sBvzGKBpCJ9MV/YtDO+AB1n5e+3DB4UEkr4CsL8xFfOYXO1fl1Ci35Kv96UT1u1LfsDnhIscg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6486002)(8676002)(36756003)(508600001)(66946007)(966005)(316002)(31686004)(83380400001)(4744005)(15650500001)(16576012)(86362001)(2616005)(26005)(956004)(2906002)(186003)(53546011)(4326008)(5660300002)(66476007)(31696002)(66556008)(44832011)(8936002)(43740500002)(43620500001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tLYktRWGZKWFVkZjMxVzRSVXFSd3ZQZ01HTWJoM0dobUUyNUFCNXVUckt4?=
 =?utf-8?B?WTdvK2tsZ20vT1B1T3FTVkFkMnptTis1eXpXNW9yWGdVbGVUcDNoby8wTEI3?=
 =?utf-8?B?UVVndE9aTmZvdWlhWHc1N1QwT093TTVJaVlDSXM0NXlIZW0vcVY3MXRVYU5k?=
 =?utf-8?B?bWt0R0twWjRrbTlLWWZHODFSd2gzQ2hETldnMjJ0RVBMcklIakdScTRyT1dL?=
 =?utf-8?B?N3UxT0xLWXFXWjVZNUtxb012aGI5RUZ2Qmx5M25zMCt0TDR0bVlMdFNwRDIr?=
 =?utf-8?B?U3lTQTFBdFl1UGJ5ZFJqdEdTTXgwZ1U0d2NHUzNGbnAyeVNQOHBrUXE1V0VN?=
 =?utf-8?B?VHZjK1p5NEprYUZJWGNBUG5OU3BsQmVTQUYxS3VKMWo4MVI4NmdiRmNlS0RX?=
 =?utf-8?B?bURVY2IrZzJnQ01jZTUzQ1RxZWZjcElEUlU4djBaSWV3S3JPNjFNVTNUT1BL?=
 =?utf-8?B?QWpHck41Q0xCVnpNUWd0TjhRVmIrSzdWUXZKK1B5cnN0Wk1xVEVpUVdQR29n?=
 =?utf-8?B?T0lZL1VGYjI0QnRZK2llZUNzR3Q0Qnh1T1RlQUdpUEFyb2hVcktkM3hoU3ZK?=
 =?utf-8?B?RXd4MUZIcU9xVDZaMUYyRElCNzlrZERTK01XT3ZiQ21tU2lrYXk2dzZFSkh0?=
 =?utf-8?B?RENBMWdscElUSEhZRmgrUnpNQTRRK0NMMldWbThOMFRrR2xBY0ltUDYyNlBW?=
 =?utf-8?B?ZlVSZEtXLzBkVy80VEgzZlE4a1IzR1JDQjA4aDVFV1dzOHQxVzBJamU3bXlO?=
 =?utf-8?B?QzFKVXBLVS9WRnZndVhUTHhpS001Zm4vaFJQZTExUTZvN3NpTFNwbVNGbkgy?=
 =?utf-8?B?Ni9QcmdSenRhU2ZnVTdoQWdoMEM5RnVTcEQ3bThrTUlpT1N4MWRFckpNWERE?=
 =?utf-8?B?WC95Tm16Z014bmVlalh6OElJd20yd25zczZ6R3hYeFlib3c0eWgxMTJOWmNK?=
 =?utf-8?B?K245Um5tVVVReHlPbk5MN0gvR2NqL2NiOGtlbHE1Y1N6QitqNyswT2t1RlFt?=
 =?utf-8?B?dVhwRFk0MURydlVCQ2pDenNsc1pVY3BJRzl6cnZXRnhNcy9wZ0RtcTFXUVZp?=
 =?utf-8?B?aTYwUzAvR3ozRDVWNjQrbUljR3FqOXNZR3JjVlczQk8zZm1ucmNFYzhUcC9h?=
 =?utf-8?B?eDhLT2s3NlI5UkhPMHpPUERDQ25mL21uNTI0M3FDOFhvSjVmMnk3YkNWN2k5?=
 =?utf-8?B?Z1ZZalZvYVhQZ3kvV0J4TzQ0NndSU2p2TDN3M2JVS1luNWZYZnIwMjBQSElh?=
 =?utf-8?B?WGRyK0Mrd1dCQ0ZxUk8zcW1HL2lkVkx0QUh1bVhVZ2tDLytoSnBDT3gvZWdj?=
 =?utf-8?B?eGU1VHBlVHNKSGRhd3NhTVQwb3lIckVKS2lERTM1UVZwQ3JndmtpMk1JV1Aw?=
 =?utf-8?B?bDR0WmFkQXBYZzNLNDZ5a1lXK25RYTA3WHR2MmtvVEFDb1l0Ui91WkVZaUZD?=
 =?utf-8?B?MG8rc0ZVOUxjd3dobyt0djlUWkUrUEQ3eDZ3VG1wem4yMTRwMUtLajBHajBp?=
 =?utf-8?B?SkxkUnoyaFBGTHVmL0x1RlZuSGFpTnI4YzJzRU9tcGRnVmNWMkJQUUJUcFd0?=
 =?utf-8?B?dzhxK1JXN2xMMEtIRXBvVnd5WlB5Y1lvSWpRZXpyZmpvNXlQNVB0UWhGbXFF?=
 =?utf-8?B?VTRvdEdZR3Z1UExTaFBtRzE2VVVnaGZBNTRvVlpUTnJzQW9RSTR4N2RoYTNp?=
 =?utf-8?B?SVZYWkpFSXJ2YVVERWY4bEQzc2RaeGRmZFdNZjNTNndtcVZjSlNmZzc4TEhu?=
 =?utf-8?B?UGM2d3YzdTZZOWhmWmxETHVZWXYxd0IxSzJVaUUyZzFoRmpzZkM2NThHMmpu?=
 =?utf-8?B?YUNMY3UzWDJEQ0xoQTU3SUIwZW5Wdk91N0ZSdkxnZktGMHUzeDJFNmxNclN2?=
 =?utf-8?B?K0lJek1xNzRtL09vNW85bTRQWVg2MDlOWlFxbEswTlZhbm1BR2p3NGhTUks2?=
 =?utf-8?B?ZHIrSDNnWDBub1BteGExampJaFFiUjFQUExFcjJ3Mk54ZkZPbGhLUzlWUjUw?=
 =?utf-8?B?U0tHdDNRclI0cjZacnFUNXpVQXRSRURJZS9GNXJCNlZBUGRaTjR2dHV5VFUz?=
 =?utf-8?B?STdKU2U4QWlRME5EYTNBcFY4RjcxM2V1SlZWSWZPV0VpcXpqdE1PWjljNzRS?=
 =?utf-8?B?NExOUG42WXpCL2FQOUF6SUNGdlF1Sy9YQ0xHMlhFOTdHNlZFL3R2Y2VjVTZL?=
 =?utf-8?Q?lcUtulrPI2VFdaVT9NqWvPY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0018c949-32be-40aa-657c-08d9add88a03
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 16:52:59.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adJ+4nzRc7EVqw+zdk2SzytEw0cRPtKbUjuRvtUBoKoSTkzb2mPaK9j6pCf1wtlhOEF4WsKN/4pFexeR6NTTYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2497
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/19/21 5:12 AM, Sandipan Das wrote:
> This updates the link to documentation on AMD processors.
> The new link points to a page where users can find the
> Processor Programming Reference (PPR) documents for the
> family and model codes corresponding to processors they
> are using.

<snip>

> -http://support.amd.com/us/Processor_TechDocs/24593_APM_v2.pdf[AMD64 Architecture Programmer’s Manual Volume 2: System Programming]
> +https://www.amd.com/en/support/tech-docs/[AMD Processor Programming Reference (PPR)]

That's one of many URLs where one can find some PPRs,
and others are elsewhere on amd.com, e.g. we have
seen PPRs sprinkled in all of the below base URLs:

https://developer.amd.com/wordpress/media

https://www.amd.com/system/files/TechDocs

https://developer.amd.com/wp-content/resources/

https://support.amd.com/TechDocs/

So maybe use the bugzilla link created just for this purpose?:

https://bugzilla.kernel.org/show_bug.cgi?id=206537

Thanks,

Kim
