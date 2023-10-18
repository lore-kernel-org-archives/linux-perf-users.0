Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422931A86
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Oct 2023 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rrgNx5oB"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0FD111
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Oct 2023 08:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDgmaaXWs1UnOA3NZnPEOXB7gVJ35tdg7eTyseemxzeoLaxHIXgUIcNvPZdhJ6sIzwbAqCeaSJZAnGpm1cTxn99JjcAS3FG+D9mtydJ7x6fSWtPma9r3QpI5NdI2U83jOyDSs/M09RLP6W18UQXBjjsxmMT+l/ImzhrKLS+7Y6KFg7kyAKKg02JOheIb/sp0cZZfwW2zuJkfvDnNKQMtZr2ZI7SxOe5EFXCnaM48hBwtyKypMaTEkWxwBJtD2M08mEF0LWvmImlpoB9aTkXSzS9p7kLBMbmKFrsX9/JMS1QEDsiAl74+f2Yx4ifBEdSPVeU6roryvOAt2vCAawxWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3l0r0vT1iomRRsZHJuUhULSSUbxIHcQtVnw34twJaQ=;
 b=haAJiuCenZU5Ca5Xg/P/Sj8sRogiDzdM+UkppDCWb92bl/3MC4dbtyXdSzFXQA8xYjOxH1Asj1X60U8to+hfgsGzBwE/Gl8qqAtINkhoCpygFZkl2f1SyrDkxsAl9GssfLVitNT2ydWdtZjomibcqB9Gqyfk6g2Pnqu2CjFOg4AYDMT5lGdGLwf/zUeNXobIawgEB3McUQBt1xME2OQ0/aRqaR4UY7GR3//N34Js/8VKE7ZPgV1TIYxiDq1VCMqkZNw4qkypHmM6XKPtAqanvF7H0lwztNEaxvp2X9CELPUbd3JOPtbUBmIIIRP/C29TJ5gJ+x8d56y5eXlzFYDxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3l0r0vT1iomRRsZHJuUhULSSUbxIHcQtVnw34twJaQ=;
 b=rrgNx5oBqUzYtd7vNdwmBuDktxhwezZhPHrqdGX6la0O3/3AXkyZueD2J/Z0dAzyQ2hjuQ55fkq2n95zvVHioMuellpWvUhTKepNlmqmWFmd6NEUwdvIA7K6G6lj+5du+Ei46Rk+fAkoU6tydktcxTZetIFlV+jmRqkoBgSARuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH0PR12MB5449.namprd12.prod.outlook.com (2603:10b6:510:e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 15:52:30 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5272:f678:1d97:c94d]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5272:f678:1d97:c94d%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 15:52:30 +0000
Message-ID: <1da634d1-9b2d-c982-a0bd-1b0d5677644a@amd.com>
Date: Wed, 18 Oct 2023 21:22:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: NMI received for unknown reason when running perf with IBS on AMD
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Guilherme Amadio <amadio@gentoo.org>, linux-perf-users@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, robert.richter@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <ZS0l-k1MASK3547Q@gentoo.org> <ZS2vu8bSBS1/zseZ@kernel.org>
 <9d885140-f952-0018-304d-fbc1e15c33a7@amd.com> <ZS6Ds+rB2IwWmXML@kernel.org>
 <f48256a1-d165-de5b-06e8-29646218955a@amd.com> <ZS/k3CSP1g3T27NG@kernel.org>
Content-Language: en-US
In-Reply-To: <ZS/k3CSP1g3T27NG@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH0PR12MB5449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3cd371-8aec-4370-73ab-08dbcff23c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WGLC6/cj8hQBaBZz4fkxVIZWSkRplsowJYQlKjern9XgunXivcbn3cG+w58R1XvWHYRqINK9Tqh3ipaaw918qzAr/G159OslcULrAemHqJW4mSLSjuzlKHv6P2v1baK0HIgryB7AG0Y319I7tY5iR4BQ2+jpnDde2IB95Uqov5wubVK6SSwfrVaYrbxhDkCESAXMJOET3cXw4vA7fiP00MlPQIZnKscN8/VFOGxo+VtcB7ZIaYlYpyP+znas0Q1xbQXOFXU9CzdUGYOJiD4G2GUb1imtZ/ow6MQhhx4VC8Fo/Tooigz1uIqCwsFqP6p7imP1gbJbnIm9PHRqxL+POnIKe/yzrkWbdK0583IZ+Nv5x8oTwNUL6p9z2bM8M8vQTm5N8h2yD1J5bhQTgCnpFO34/VbhWMC9xUBhfK4s4hjS0urFtJ0J6xmRGKnv20CsszM7/FO87aVM6kmQptTJp0TshQa/WZDA9NoGrBy+NkfeAgZH/9HLR+dt43VejzeZoBs+b0cK4PabvGC87yIM9OtsKV/3pIkqDHo/lWt+3YkN6VlqPG+J5koNXvy1IGFqhFcPjElRNh1gzgogFvimXpG98VnqKcUIZ0uQ7M1pg9UvIV6axdUKVMI/fKzSP6bcnaufwS/wyANttOpcIVzhbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(6486002)(36756003)(6666004)(38100700002)(83380400001)(6506007)(66476007)(2906002)(54906003)(66556008)(66946007)(31696002)(316002)(2616005)(478600001)(6916009)(44832011)(4744005)(26005)(86362001)(8936002)(41300700001)(6512007)(8676002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVZZTmI5a0pueUx0WGxHQ1BJdlhNZE1rUjR2THVHMWkrdlFtSFJHUklzZ2Ur?=
 =?utf-8?B?dVZrRURIcXBhcTlwMTZBeVBRQTVxVTdQM0Z3SDlmdytJeWtPYlJxNFNZNXlh?=
 =?utf-8?B?dFpRVXd5MWVndUN2V1JrUmJRdGdNcTQ2cUVIbk1xQVJmSlRBbldDYVFDbHlN?=
 =?utf-8?B?M0FOdUtHd2xKbG0xOURpZkwySW5vZERMUThOcU9QalVrTGhUblJRTVFUb3o5?=
 =?utf-8?B?MTBIYnpjYjVMbklIZmhQb09BSWN2eUJCb1Q1dDJTYnIycnRYYSs0VzRVNGJh?=
 =?utf-8?B?MGZ0OWNpK21DQkxKSENGaUhkMS9ja0lFWFBsY0RnMmdaejVoclF0SDY1L1J6?=
 =?utf-8?B?T2hrYlBQLzNITEM4SjJObVorQWZZT09DQVM5OUJoNUJOSXZlMzZRSzhUdWp1?=
 =?utf-8?B?LzFDcVJwS2Y0eG9vd2l3ejloQzJxZTBQV0E3S203VVdMV1BhQXFaQ004QVha?=
 =?utf-8?B?cWRpeXRGMUoxY2t3NlluYm5oRXczOGJKbWUyUERqdWk4azR5L0F6S3VBSU9v?=
 =?utf-8?B?VDZJNXZWa2tCbTBDMmV4Q3VRTlptSU5KdzdSOWdDbWNjaUtuS3RFbjlsUUNZ?=
 =?utf-8?B?NlNab0lta09JOElwcmhFN3JLSlYwaTc4bHNUdzNtMkxvOU9BSUVmcXZHWTh3?=
 =?utf-8?B?eVRiaHk0S1FxZGgzdmMxM0JtR09Qbmx2RmtpMEFvRWlSR0JSZHdDZWo4cmFM?=
 =?utf-8?B?Q2oralhLYUxmU0V4SitFbDdBWUVLR2V6V1J6cERnekR1eEtRQk4zcEhMcVZm?=
 =?utf-8?B?RUtGZzlyeTk5MDNSUHFKdnJyZnc5TlR2Wi9QRnBDV0JqWkkyL3VQa3VwZXAv?=
 =?utf-8?B?Y0d5VVZXZC85SDRFczRVVndiUnl6ckJzRVpXWDYzSHdDMTk2UFRiMXMrb0Z2?=
 =?utf-8?B?cWdqK1hYd0x0eDFVblZQZ2gzdXFtemxEK1pubVBOVXlCZ2hNOEtIeXZSRFln?=
 =?utf-8?B?Nng1UHFQNmY4R3N4TUFFS0Q4NjUwcHZYS0lwKzJmM21pYmVURk5lQzNET3ZY?=
 =?utf-8?B?RVpVbWVaK1YxOHFRQmxHbG9DNVBLZHA1Snl5bGtpZXN2MDJuZ1dJNlN5R3V0?=
 =?utf-8?B?Yy95cWNhNk9BanFrbkZvNVVaT1FUaldna0hWdndnVTZuSi9YR2JTYldTZE1r?=
 =?utf-8?B?bDZQWDc1SmpScmJNVXYrckJPTEhjcHRSbW5oNFZoZjAxOWt4MjBXR3AyckJv?=
 =?utf-8?B?eGI0TmpUU2UyaU5HRTBNQ1Q0akF1MlBEbExmaEdQeEhhSVZrS29uREV1RCt2?=
 =?utf-8?B?QnRHUXFvdFdmWno1aHBvZ0M1UXNES2t2L1VXTUo0QmxCMy9ma0FzU3FnMzZY?=
 =?utf-8?B?SVg3UFFBaGhnUEFLQUROa0QweWRCUkF2cE05YldacEZIQVFyQWtTZkpHNGds?=
 =?utf-8?B?cThrWTRNUVhOcFdRQzI2cmxRdFp4SzQvK29RcjBPT2xiTXJiRlFUMlZrMS9F?=
 =?utf-8?B?SjhhR3NDK2MzRGFlb2syTWtqQmFMUTNlU01TK3FUcUJmQ1hXTGJqT2d2blhv?=
 =?utf-8?B?bDVOWGRQRjRHZ1NTT1RUazI0R0Q0WE8rTmFudXNyVm5tWm12elBVWDB6cUxS?=
 =?utf-8?B?bDZQYzNhSXA5dFEzZEY0WWJ2b0RoZGNvSXllVFFmRGJJMkw3WWc1ditWeWhq?=
 =?utf-8?B?YUlwczAzNml1L2dFczhGdUNjYzVnWDh0UXhEWHlzUzFNWGpCU2YzMk1CM3Nu?=
 =?utf-8?B?b0R3UUliMWt5MU1PanE4RGliY2Rhd3BNa3hKdE9oU0N1NFBNdnlFTWhQRTJ4?=
 =?utf-8?B?L01UeHhRNDR4bHRJdTg4aGxKT2R2OEV4VEFTUkN5YW1ZbDl1SjR0TnUzeUU5?=
 =?utf-8?B?eEdtZTUxU3FHL1QxRVRTck5hdDhkVUJHQ3VSZHBOYlc4TFYwU0dvS3dobzlm?=
 =?utf-8?B?WHJpZnRQVEF4VC9QQUwrYzludk5LanphWGUyWGRXUDcvUWRsM0t4OUFRWUtj?=
 =?utf-8?B?VFVXSm1hWWpWWEdIaGZwall5NkpVSFJqeSs2M2ZpcEpXOWIrd0RQUTVNeFcy?=
 =?utf-8?B?QzFHRkpiNmtPL1U2bWE0bWNrY08zeG9ObU1mTzZhdEFGUm5IcXJNQW9TR0Zk?=
 =?utf-8?B?RkNnRU5ybXlObU0vejIzMENOblFxVlhpR01SOC93MzUrOUxyaS9wQWwxcmxo?=
 =?utf-8?Q?uFXdXBC26lDmmGjNzzNosdHIx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3cd371-8aec-4370-73ab-08dbcff23c25
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:52:30.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvbO+tmeOnkO4LsJdLz7f28iKTRMUduXgGDgSnTw4eqpi+pcpVYwil7vofBBewrnzspnqMCbTbRvdauCrjXCKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5449
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>>>>> [root@five ~]# perf report --header-only | grep "cpu pmu capabilities"
>>>>> # cpu pmu capabilities: max_precise=0
>>> ...
>>> If we can programatically detect that IBS is present we can add a note
>>> right after that 'perf report --header-only' line with this information.
>>
>> This should be easy to implement.
> 
> Yeah, I took at stab at it, see the patch below:

Looks good. Thanks!

Ravi
