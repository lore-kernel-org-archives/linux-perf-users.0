Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3338FA6
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M3dCDSrG"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15843AB
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Oct 2023 01:01:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJjJWnSJLbpbE5o3ffjhg0tHn2tfmcHNmee03raknFuPblk6/oawaRqml62hqDgr0VGJW+xJD9pHeutmLwgXSekYqFLLOtV2WjMnKV5CYjPBjMFJzjsePqXXAtEbubdpnV+sQ6GnxAQCpArHE0uweRL6nigtiZ84UIIuFb8dMp4r63ZA2FjVGrIZ8WhYw9I5Y1TvcuExnJsDQ1qv2oNwoZC9gOg+f7kdu6YTWf/qgi5AVlnRM+FGEkxKnhB1Zgg6jlbnlnCrtcsn3s9xuGiErGwzQ5Q0fKXCtTfK1OMQyaQcPymCN3FQfHPy7rO8HJagt4ySzX3fbCM0E49vdAue1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXlAUXbjeRCyXphcp0SknJ0kgnvIzi0qw1QepW+n3Kk=;
 b=Sh8xEGjBcZomjTeAhYXMvYx8J8+GEBTXJwVtxIjjG9U8V98cEKO4rFIpXPBSX4UJF6S7N05d96N0euh0bJCVVrGq3sF8hlCDkpunZVc/Bg1vN2mAzelLnESHbJdBCEPrYSGvwilV8ISDQhKGvNSUlo7UY+oYHZhpNTY3YoLhHXUwsinnmzHFOMS8ZiSXl0dzh3nfn3avC+K5u4HjRIpqrSJd0UATGEV6Fom7+PwFkb8si89zcibSkxN7wFzUo5+1FB2J5bMzZtymJ6BpQm0JmTyujrvR4KmfIELmRNpqIItMhpUrmRNq+FHbAqePw0VvSov+C87ldl5iFLQe9RtlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXlAUXbjeRCyXphcp0SknJ0kgnvIzi0qw1QepW+n3Kk=;
 b=M3dCDSrGqRpW9Vq9/lL0v24KF/1AJ8c6T3dqrkbKvsCEDR79nh+2O0TEEGONfaIWIVvgcvr6z2MJlg+1yPM5M9zLl0I4S/sHsmSjXNHp9PvyoZIJXpVp66N+1dPTvDVr64O3mObV7/eZdLV1CniWGbbKRyi/QXpMPkE2Py87poo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 08:01:36 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5272:f678:1d97:c94d]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5272:f678:1d97:c94d%3]) with mapi id 15.20.6863.047; Tue, 17 Oct 2023
 08:01:36 +0000
Message-ID: <9d885140-f952-0018-304d-fbc1e15c33a7@amd.com>
Date: Tue, 17 Oct 2023 13:31:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: NMI received for unknown reason when running perf with IBS on AMD
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Guilherme Amadio <amadio@gentoo.org>
Cc: linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 robert.richter@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <ZS0l-k1MASK3547Q@gentoo.org> <ZS2vu8bSBS1/zseZ@kernel.org>
Content-Language: en-US
In-Reply-To: <ZS2vu8bSBS1/zseZ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 29bc7c65-752a-46a4-f2f6-08dbcee748fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TQYyMmDOI9xTNMI8qW/w7n+J/MgsB9h1DHQVZ7SId3Rv3dD7Q9dvbDKXc6BJJSr/vKo3yPvHCfuWQwTXM0xL0NXFPpgns/Gx7w6kLE20o8uaVZrkbcHhS2gFDTKM7bkAIxLnJqIBIcSV9QrbbItRCA8sMhqLpAfApRO/nSxqB4l5SDYmLT6mzzTQ5SmEIevoCuTVh41MwQoHbBAHz6SzNYBDj1J50trkipIS5tJ+mA2XM600PllbW/FJmea+dgmleugGFp5dIIIha7AaRkh0nwmrqxH22BOPcVm93QqCVKOZYlTTfbW+ycCDBR2VQXry9OUggbOgr6KrjsnKl1W2vVQgassDAUEVBqmO1j3SYgrepiff9+RALZ4purHZdDKm8AT+optpnvL/FQ1wCrrwKUZ/cAO1bUqprv5beGV2Muj82oREnMn+OW0ImCeWh28GbXvw/XDUutZC3dhXKHSVc5tEOdUXW6TuEOWt6YEFQCHngIB+p+eHCJzUeo3zuLIZGMC+CN9HrbV1EV8RWPX0+ooYVf+UBtBcLCyf+7S3rjTHT1yrzMbPYvOfAnHKFseG6Sr2DhjULJ/fYHtRu2J/A+NunpHUPkbbv7ZJVIkgE8SQOC4MzNVnYzHPIFnYuaMxcb8RfSG9xglC8jOVi2tR3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(31686004)(66556008)(66946007)(110136005)(316002)(66476007)(54906003)(31696002)(86362001)(38100700002)(6512007)(26005)(2616005)(8936002)(966005)(6666004)(6506007)(2906002)(6486002)(478600001)(41300700001)(5660300002)(8676002)(44832011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGlsRkNoN3hLMWgvTG1QRlZWcFpGbDRIRFNDY3Jrd3J4UldyNVFxTnFPZWsx?=
 =?utf-8?B?QmFXdzZtZ0dmYnlIRjlOR2g4MngzTmhoWHNxREVCK3lyUFc3QitQK3I3QWUx?=
 =?utf-8?B?RGkzQlV3NlJ5L2V0clFXL3ZJT25JbUgyYWcwTW9TM1dYdnZQTEZ6Vnd4YXln?=
 =?utf-8?B?ems0ZmNXUElBSDZhQy9MQjJ5VEFQbVplWGJyKy96elZOWmV2aTYzOXVsY3FI?=
 =?utf-8?B?WE0xQXBrNFJqSEc4ckRld2RzVVJDQm5HSSsvck5RZjNJSXRFbFBORFBDVGVs?=
 =?utf-8?B?aGlkYXdBUFQwNEtHWDgzY0twdFpwdG5seVJLMmozMWE0cmlGb1lJcVFUVkxT?=
 =?utf-8?B?VFFNWVVRZElQbC9jeDhUYjRwYVBNOWVaMDVWaUlGSW4yeWdjUEVObnVuQ3JG?=
 =?utf-8?B?QnlCQmlqZ01tdzhNOHJ6Tm9ST1hTdCtpSUk2UWk3WVJJREY2M2FkNzVja1F4?=
 =?utf-8?B?MjVhTjY1d2g5UEdLQWZUa3ZiQWJ1SjVjdHJKbnIxY0pGV2VISU9UeVJIZVpI?=
 =?utf-8?B?RGlGcjBNL0tVZEJxa3lyekFnQnI3U2RZbERmK3NUUm96M3BCV0Mxb1FZRUFt?=
 =?utf-8?B?eTNGMmFmT1N0SGpwZG5aaXdNV2hzUTRjRDM1QmVtVXVxSXY3R3F3R2ZwYVVV?=
 =?utf-8?B?eWFkNVNTd0ZyS3hlQjVhY05rSDNVWmkrRmR4NEhzTnNYUEVOS0Y4WWhiMzNm?=
 =?utf-8?B?ZlFZUzFZcXJVbE1uejFMMWx3Z2txTUlUVnlyV1hLUjJCMmtSMWp3VEVRVTNu?=
 =?utf-8?B?dk50dnh1c2FuZC9WUGE4a3IvZVAyN3YrT0d3b3l3cWNQMnpWS0d4RG5IQXZP?=
 =?utf-8?B?ckl2U3E4RXRuZTkzeUlxclhObHpnSWlSdXUvZW5XQkxEWnF1eEJKWkE3UW44?=
 =?utf-8?B?ZTVwYnNXb0NLUDNJanNYNForRlFwUllpek9LbmpVNEFZRkZSM3Q2OWhDSG1i?=
 =?utf-8?B?YmpzdlVQdUc3aFNyVVJ1M3dLMzFuS1oyTExUYWRPbmZ6cVlEcVRObkVxNW1t?=
 =?utf-8?B?czRPaG45MGRyVnlDSm1nKzU5SnhSS3I4cGxKN0R4Q2xqeVZ1THJwQXQzVWlX?=
 =?utf-8?B?RE5TZm5pTnN4cjd1R1NiQWNhWlhCY2RWdWUzYWt3eTlpWW1uK0tudklGMG9R?=
 =?utf-8?B?T3pQKzVxUWZ4OEVENHNpZ3dKbnFiMzdFUmVmUzNidTRFbjZnQ2tXMmdYb08x?=
 =?utf-8?B?L0pKdGRJRmRPNTgzVy90YnZFdmpabytCano2V1U5c1N1dDYwVGswdjRhU25W?=
 =?utf-8?B?bG93Nlc1RnIvUmtaZElucHFPZ0NnT3hiQ2NvdHdaaDIvYTZqd0M2YjJoY1A5?=
 =?utf-8?B?dVFMUm9ISXpFVHkvZHE3cjBmbEtnSXZYOFI0OEtkUWtrenhSc1hwalcrcHI5?=
 =?utf-8?B?TlZOS3NrdHNuUGJldFlxN0dBVVNrSDN5enV0VUxEcmRvbGJGc1N0enY0YnJo?=
 =?utf-8?B?VmZDL1JuYTI5RFZ1dGdNaW1DRUtmUHhjWUozTnJDaVBiTHYzaFAyc2J2ZnRy?=
 =?utf-8?B?Q1F6WTJYRUZmRnlWM3M5MmV2RGEwMExONzZSVjdMemhHc2d2eGptRDQ0WGRn?=
 =?utf-8?B?RlowbGNiWTVGMWgyOVVFdVZCem9YbGhYNU1nVWU1TDdRS3pFVXgyR1hwQUdw?=
 =?utf-8?B?RjNDczhnbnorbWNzcTdSWjFpK1FYZVlOMXlBZ1JWSDRXQmdBQmZFRHY3Y09q?=
 =?utf-8?B?Y2V6SkhPdjduUnFBY0NkU0dHNWtjTjNRTEMyWXhrL2hUbUNRTURhWDNBTzBG?=
 =?utf-8?B?NGhMVVJDUVBOeTNDNTNEWisvZTkyZzFkTVd3UFJ1aHRIK21BcksvWHVYeXk1?=
 =?utf-8?B?YWhRbVVPdHp4cGhZK3ZZQnRoQnNKOGxLYkNBVGJJd2VCajRrT3F3NkJzS2Fn?=
 =?utf-8?B?UXJ3cEl3UFhVMWsvMWdlSEZKOUtNQWFDR01TZ0UyUHpvUGJJdXVHSWowNnRx?=
 =?utf-8?B?Z1o0cVVDcWo1RHZ4TG5UdkZuSTRybEFzaG15N1phZkhBSFh6SFZQZnlLMENC?=
 =?utf-8?B?cVpPbnFhdDliM250endlSUtiTTZZQ0ErU0JnU3ZkSmUvc21rVWRxR3l5TUNp?=
 =?utf-8?B?R1FGbUE3WmlPVzRrWFNXTDljS0JzY2VXR2JkOVJYdkRaQm1BN1ZlODQ1Qk10?=
 =?utf-8?Q?nyTKeilltxbZ9j//7EgYmbLqj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bc7c65-752a-46a4-f2f6-08dbcee748fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 08:01:36.3843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlPhheQJkC9IRXuWnbAq7vuJvmStjBMks60IuKy7rmeNTrCey5luWvgC5BZuAM9E2X1U6MVE4+a0FKz5iIy8HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Arnaldo, Guilherme,

>> [443324.404938] Uhhuh. NMI received for unknown reason 2c on CPU 9.
>> [443324.404940] Dazed and confused, but trying to continue

This is a known hw bug in Zen2:
https://lore.kernel.org/lkml/e08e33d5-4f6d-91aa-f335-9404d16a983c@amd.com

You won't see it on later Zen processors, or at least the possibility of
hitting it is very less.

> (gdb) print perf_evlist__first(evlist)->attr.precise_ip
> $4 = 2
> (gdb)
> 
> So it seems to be using IBS:

Correct. More details below.

> Humm:
> 
>> # cpu pmu capabilities: max_precise=0
> 
> For me:
> 
> [root@five ~]# perf report --header-only | grep "cpu pmu capabilities"
> # cpu pmu capabilities: max_precise=0

Although confusing, this is technically correct because AMD core pmu
does not support precise mode.

However, as a special case, 3 core pmu events: cpu-cycles, r076 (same as
cpu-cycles) and r0C1 (micro-ops) are supported with attr.precise_ip > 0,
and they are forwarded to IBS OP pmu. All other core pmu events with
attr.precise_ip > 0 fails with -EINVAL.

> [root@five ~]# cat /sys/devices/cpu/caps/max_precise
> 0
> [root@five ~]#
> 
> Ravi, this probably is the max_precise for the "core" PMU, but the "ibs"
> one, that gets used when :pp and :p (but not :ppp) is used, i.e. that:
> 
> +++ b/arch/x86/events/amd/core.c
> @@ -374,7 +374,7 @@ static int amd_pmu_hw_config(struct perf_event *event)
> 
>         /* pass precise event sampling to ibs: */
>         if (event->attr.precise_ip && get_ibs_caps())
> -               return -ENOENT;
> +               return forward_event_to_ibs(event);
> 
> Thing..
> 
> Shouldn't we have some sort of max_precise cap for IBS so that we could
> use it and not have this confusing "max_precise=0" for the core PMU but
> accept attr.precise_ip = 1 and 2?

Unlike Intel PEBS which provides levels of precision, AMD core pmu is
inherently non-precise and IBS is inherently precise. So max_precise value
is irrelevant for IBS. I mean ibs_op//, ibs_op//p, ibs_op//pp and
ibs_op//ppp are all same.

Thanks,
Ravi

PS: I don't know the history behind not supporting attr.precise_ip = 3 when
event is forwarded from core pmu to IBS. This check was added long back in
2012. Robert might know.
