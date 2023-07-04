Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD31EB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Jul 2023 12:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGDMeA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Jul 2023 08:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGDMd6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Jul 2023 08:33:58 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BA410F2
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jul 2023 05:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv4d82WoZlKzsFy1vWItzkR7NmoyBuXGC1/TYduS3YfyAv76qCvyFKKJgnQk+PZP+nWjFwUqUTgatN6plm9PjeDfNEBiM6xX9ButBvuGfox0fsEFAwLJdGi46wmZDpGsgP07fVew24jMBJ99LZsTb3PLZmhyYVsESDRpeIuwMIQL+AWntz8TgRykra8zPUCDWPmEie5fTsP81mZsFlumqGzVMtGKwxdSFE2CpcsgGJuajNz3ox2yWQ+6lhcsELyDPg3i9mpdLsk3yxzBHdnkuaOuFMzmxpfbKF6iRBblN/jnvE8ctS4rBgjDprb+m8uv6x1HJk0tVW8NSOmzDeJTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+N7mfTCF1rXR2SGDy4yRBSHA4KG8bl+UfzeJS2Skn8=;
 b=V8OwTby25kHeC3NiMJ0n9tdktXGutEHbNdYyIZ24DTn89RcEQFhi2Id2Ip7UFjiIMytYVNSaCmDldmibr+Qsg0tQtXytdIhmCl/4C9iEBFYfSQOpxT9QHVMXWqvV1JUEcjVKMntWlLM5cPRKgEzjZ0HzJfydbtt3anDIDxGtp+9whZI0nLwxjjvxQPhbzPN9V7/q0kTiY7VIlQC9zMtcg1chFw+ZJzPd2aMzpxpBPPN0IGDL0NOwgho8hAS1T8dud7cuaSX4QsLeAcRpeoGbVqXKybDXCIhB+ytWOjU8VmHdkEEUZOMECbBCYaIqoPIlqJBmq5nIRGICdFuE9g3j3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+N7mfTCF1rXR2SGDy4yRBSHA4KG8bl+UfzeJS2Skn8=;
 b=2wOke5Cg/Lz2h2Ei0Br6v0ycV9O2LD+Drv9zYZamDMujdRIpqzK9MpST+kvYXP3KNCmkxD97c0m952LLrsjZcqyc1uM1is9N+AVKyC5CbHWvtqeFWVksPE2OtB/w2RzJEsz5/UkTelcq14H1T5yiEqoRwfpyWCp3d2lsKk5KBOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:33:50 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:33:50 +0000
Message-ID: <cc134bea-dbe3-cf41-4769-440b8c69e9b4@amd.com>
Date:   Tue, 4 Jul 2023 18:03:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: perf-tools-next: Request for testing hybrid changes
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAM9d7cgmHuhv1U6yAB-2qUr8SuFjUd-Lqw0kew9MaBVeD8xxGw@mail.gmail.com>
 <CAP-5=fXFBpaN+ajF+u6GAL-3bb9LPR=dwevB_-7N7uUh-c3SPw@mail.gmail.com>
 <a3958a0c-092f-b609-e2ea-0d35fddd4375@arm.com>
 <CAP-5=fX8Nwtra=EgRNh3Ybp+N0BKp4Cw=0uRS9ZCdPyGF4R_bA@mail.gmail.com>
 <f1cfdc5d-19df-5d71-15c4-59af06dd3d28@arm.com>
 <CAP-5=fXwdc4VK=6dEoD4V0Jp+unYghWYTfbN4ER2aYd9R52W1g@mail.gmail.com>
 <01bc8040-92ef-cf8b-967a-6782989ecf33@arm.com>
 <CAP-5=fVkRc9=ySJ=fG-SQ8oAKmE_1mhHHzSASmGHUsda5Qy92A@mail.gmail.com>
 <6310725b-cc30-49e4-d405-ed2d5f31b404@arm.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <6310725b-cc30-49e4-d405-ed2d5f31b404@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 27913322-53a1-4c10-d245-08db7c8aeb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Snpuc3pIARA4U4Y6hnpFkBk9LODkR5HraJNOQIgSVRpasg6Kz3ySlwMYDNcbiAZRgQ7F1qfOiZvfsNibkE/k15OIDZv6Sp0szP/no4/I7Nmx9i+u+OlKsp5mCAvj2pO3tG3/zjBmbvgYZEL8CRk90CSpby2bp08iYVXL6GWycsLBnottR8x6Xfk8MCOaSD8qUuUalHk2JGwRRgkphh5vuvomVz2kuN0IOFz0hMjrGDeHcNHmKdoysZYKbwopeHNGMxM+iRYCkrOFJVrYl1zA7J8MzFhAnBMwzBzlv/OKk+ljykjvQt7a29GJ8Ntox7jfDTXHBe92UgccPG5Nu5L8Vqffsz+EZTjTY/nuh3zVmIGL9TV2TBObaOHwuoQBm9URC+z/50LklXfqTv46AhQ7qCQ++BOkvgKA58osyGvRSSBZRXRikURtRbXEsikprWqokUVd1xon7gO9sw8QeMe/eOG9UawilueqqFSiIwpghmxvOcHTNHf7dXAynHkmE87PgecmD9JiBuD/PAoW5LbVSXyDk/H6jXejO5qllxhxoiE3FkoL7gRRyAm4en5aiAEUMqKdk+VR9EpFf5usrxTifnx9NmZhr12UVWYyTzUGEDM5WUbCmkg6u9eaMDEBEligbNSPtY4SXs6wCaktmX7LzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(54906003)(110136005)(6512007)(26005)(966005)(44832011)(186003)(8936002)(86362001)(36756003)(31696002)(8676002)(6666004)(2906002)(7416002)(5660300002)(31686004)(6486002)(41300700001)(478600001)(38100700002)(6506007)(66556008)(66476007)(4326008)(66946007)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anBkNXQ0SnBsOHNubUE0WnNEMjJoZEx3aVlNbkpzV1RkNVh2c3NJbXNFTHpT?=
 =?utf-8?B?OWV0U2l0QjJzTmNIK2VJYUF2cDhEcjBLMTFPZEZIQXNjeFYzdnp3TE5QRnFT?=
 =?utf-8?B?OU5kUGczQ1IzRVpFSUo0bTM1NVZHcjhuWlA2cXAyWFl3a01rMWtMS2NhRlV3?=
 =?utf-8?B?YnkzTmRNSDFDY25EaSs0VkJtbSt6MzNkTUpRQ3VnUlltM25acUZyNUUrZlpO?=
 =?utf-8?B?c1FOeEFFdVFNSHVhZzhVRld3RE1ERHVrTi9ZVTRGL0tJUHoyemEwN0grcTFK?=
 =?utf-8?B?V2c5WGxCcWFSQW8zcnVYMCtKeExMeC9SVkpNcXlpUDBObEphOEVKSUt3ZFlI?=
 =?utf-8?B?VEtQd3YyOXJiR3dlVzBydGE0aW5PZlJvOUdnZnd0WlA5S1ZFTUpPb29aTlJ0?=
 =?utf-8?B?cHRaMWtKMDBhWUZIK1ZMVlRXTHorUlhoblNQcTZtTVpjNzloTTliWkVoT1lP?=
 =?utf-8?B?alFZdjVmM2FDMFJ1dnVoU3NlTE1SQ0N2YWhIVEZsQng2OWIrcXZOYS9NQ3A4?=
 =?utf-8?B?bmIzSlhYMUhqR3VsUHBjbVFERGlFMi81QVNBMUxiblhvV2JvMkNLbmxJWGFO?=
 =?utf-8?B?cUcrQnIyZEhSNE9mYVRkTVZaZTNrL0tOQ1ZQYWVRNjhrVzU2SlM3VHlYMVRB?=
 =?utf-8?B?Y004SmFYNmpuejhubE9DMUhweFA0dkRTMDUzb0JmZExqdE1SZTFkQm81a01Q?=
 =?utf-8?B?aFFJbTlwYmluZEM3YVYycEdEcGVieVVBTjVtbmpGcjhGZDl1MldTRlYvKzBz?=
 =?utf-8?B?SUVvRVQ4cWRJK1NuNGRRYUpFL0lyMjRxSXF4bGNBRHBaSlJFTHVJSWNjcXNj?=
 =?utf-8?B?Q1FXbW1kbVlsVHZWMkV4V2pseHQ2TlF3NUVRUVcycFYxS0t5UFFWRDRrbXNn?=
 =?utf-8?B?cU9tN1FlY3pJMHMrLzlXTnBmWFZnaDRNWGk5Qm5Ba0c2QkF0Mm1YVnZyUnVy?=
 =?utf-8?B?cnQxSmdodFo5ZU5EaXZ0WExyckl5dTJvVnA4d3pTQTlXcmg2dVlQeXk0Y0d4?=
 =?utf-8?B?SDFJMnMydGIvSmVYWTdMMWpVck9aUkpzaVNaWm5ad3ZpRVFnRi8wQyt0bm55?=
 =?utf-8?B?ZWkwaXcvQ0RaTXh1V2xSQlIyNFlxcmh5R3dKM2FubURKUVJKb21HTU9EZDg5?=
 =?utf-8?B?RHhjcFhHN0lJQWJRM3Zac2xqWHIyL01YT2lZNlBBRHFIWm1xZ3VnclpSbVBI?=
 =?utf-8?B?dGpCRGxkZjZPODg2UUNKcHZaRnpHRUJMdUF3RHIray9iMkkrTElnS3g2Ti9m?=
 =?utf-8?B?Yk9CWVFXeFVWYnJIYXREd2s0ZjRFNnZCcWFOM01meGsrY2l1bFA3WTdXZXZT?=
 =?utf-8?B?TlJMcjZlV2lDbFVpMThiQ3BKcjZQaktJbURBSkQ0YnhUTDhFQ2Q1L1d4SDhL?=
 =?utf-8?B?WTZEdTRFVzgxVytub3pDK1pFZFk2K3NkU2VPZnpTZk1DbEJESEd0b0hoVksx?=
 =?utf-8?B?VHFZR2VER2dKdmJBNk1UVEdNQklvb3M1bWRFY2xieWcvd1JTM0JIS0Nhb2V4?=
 =?utf-8?B?Q284bDl4M0NKSHloaHhPbWRJK01CVUNLdmx6bWd2U3BPbGNhZitUQk5RWW1j?=
 =?utf-8?B?N3E4dEdnaE5ndTRzWko1SmVLZUJ0Sk5vNTJaZE1MNEtiVGRQNmRrR3dkcHF4?=
 =?utf-8?B?eXUxSWF5VWdiVWJXVW5sNnEyRTQ5NEtKMUxQL1VxdDdDUVF2N2lTaEJrRGZR?=
 =?utf-8?B?akJ6LzhkdW9hdjlyMlR1RnFucU1GOGZsSklxZ0hybEFQWUZsZXhGMmI5Ujhs?=
 =?utf-8?B?TDMwSjJwOGo5dWUveUpJc2QzUXFmbEJONXNFZnVQQWJlcDNha3kra2dNS1c1?=
 =?utf-8?B?bkU3OStiMTFMb3VnZVB2b0lxYmF4L1NZNE5wSUJpdHlSYkliYTZrT1Jmcy8x?=
 =?utf-8?B?Wm5jZkNaU0ViRnM3eFBmdnhJc1FlTVdaZERlTmdFeFpKcFV1dmNzTG5DVWNp?=
 =?utf-8?B?bVVLbHBWTUY3TE90SzhOdy93N1RFVnJGN29naGF6TS8vUUpjSGhrVmJvbGxP?=
 =?utf-8?B?MW05TWhkbnF4bzlLKzYyM1BzVUQrRTVIdEdoVnNWaG5vNEc2eDNoRlFwYklV?=
 =?utf-8?B?d3JPQXJLM3ZhVU9qSFNFZzVVYWRaekQzSG9rSTc5a1VDa2RhWE5TZ3RabHFi?=
 =?utf-8?Q?YAktfNgDZ5DX94si5dFgxGRt7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27913322-53a1-4c10-d245-08db7c8aeb5c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:33:50.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE54fhqp6eYotWoT+WjmMj79AZR2xR2ec+/afBd1YrREUFDtbjmb0TcELcpY+Id+9xbRsrCBLskuFYHua3iMJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

>> For heterogeneous ARM PMUs I believe this is exactly the path taken to
>> cause the perf_event_open to fail. The resolution is to add the bit to
>> the PMU's capabilities. I believe doing it here will suffice:
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/drivers/perf/arm_pmu.c?h=perf/core#n877
>> So:
>> ```
>> .capabilities = PERF_PMU_CAP_HETEROGENEOUS_CPUS | PERF_PMU_CAP_EXTENDED_REGS,
>> ```
>> becomes:
>> ```
>> .capabilities = PERF_PMU_CAP_HETEROGENEOUS_CPUS |
>> PERF_PMU_CAP_EXTENDED_REGS | PERF_PMU_CAP_EXTENDED_HW_TYPE,
>> ```
>> Now strictly speaking you only need this in the case of heterogeneous
>> PMUs, but that's the case for other bits here and I don't see special
>> case logic...
>>
> 
> Hi Ian,
> 
> I tested the above and it seems to work fine on Arm so I will send it
> shortly. Some of the legacy perf stat use cases are working better with
> it so it makes sense to me. I also don't see a reason to not always do
> it even for homogeneous PMUs. To be honest I don't see a reason not to
> remove it as a capability and have it as the default behaviour
> everywhere? It all happens in the core code so I'm not sure adding it
> per PMU device is necessary, but maybe there is a reason?

EventSelect on AMD is 12 bits where upper nibble is passed via config[35:32].
i.e. it conflicts with the semantics of PERF_PMU_CAP_EXTENDED_HW_TYPE. So,
please don't make it default :)

Thanks,
Ravi
