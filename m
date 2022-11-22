Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC701C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Nov 2022 04:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiKVEs4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Nov 2022 23:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKVEsx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Nov 2022 23:48:53 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD4C27B12
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Nov 2022 20:48:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImWMKEo8VX0AjJSqgskcZ0n0j7+lmXeGSJYfmfGoMLKCcQlvzYS4Kpqckvzpjox4Bn8xPPvUsFg15+zneXCY6TFrGIFJzF6FmIfs/yep9wJMxhlmggCOPTvulwOl0RoBYdZeIdHkkFRFu7g5cctii5OpA7mgkUB+yf85XCwHABNLCOSJWhuRoEreYzqwAvlMMJRa4BNqwKdF/bEILuFFDLbQjURfD1uHf+DQQzXZrwLuUcdSjq/GIFn9uA4fW7ThMvHeEThzjAyFu6COyrkwz6jYYo73oJ0bVdI8bWgReMuFAk8bs0QecXkfkUPH1nRQGnGilbEtXf4RMC5i0rUDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHLBReUG/BNlv1D7p4a+dAv5ntd2GYNi1j+jEBr49S0=;
 b=aaJkv85IcsoO3imFAeVP5IN0ozh1SjtVNCnqvPCPfiW6gTA8iW8IlHYfRGxxD9WC9eVeyEvpFSswKYq8Hk7lqByodALnfH0nhEvYNlxMsh/EB00O+GIn/oyJvB3wXUkGxG/zcqNN1GtlzJBnpu7PriWjfgCSAkWtWDJFw4YP68pkJ2EK9gaAn8B6MkH2VrzHxvysW/6r0hHGVgmfpDQUntfDTJyP8fpxZ1j9xexNE9nYqlJcLiSjoOvbRn1i/7rACzS7LVKUTfJ/03lHky/EQ/Z7QBDPhpQN6BOV5UM8abeheGHNZiA2Tt9U0TAMO336j12T9INypLsBPRlubAU53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHLBReUG/BNlv1D7p4a+dAv5ntd2GYNi1j+jEBr49S0=;
 b=e8Ci1QIZlEQbel/+O0H5XVav8vcidOv0wTOgOty0/1D24bhD53WLmb0mTyeFiQe6PJeM80OIJIRzmYu4NqhgBw3t2adLMTHSffIeb6zdj29bqxThAB97FCCwKlggmH6b2ux+gkwM8Xj/PY1/JUObSTWJeqdEXQCB0ZEoVPxbStg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 04:48:49 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b%7]) with mapi id 15.20.5834.009; Tue, 22 Nov 2022
 04:48:49 +0000
Message-ID: <0ecb09b3-5a72-6bac-0236-8807bbacf702@amd.com>
Date:   Tue, 22 Nov 2022 10:18:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: AMD -missing perf stat metricgroup "pipeline"
Content-Language: en-US
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, ravi.bangoria@amd.com,
        ananth.narayan@amd.com
References: <CAE4VaGDR+p-KDK6WNnzp5go4r_3Q-OtjR_J2_NpgFcwL8O8KiA@mail.gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAE4VaGDR+p-KDK6WNnzp5go4r_3Q-OtjR_J2_NpgFcwL8O8KiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::28) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbece3d-8eaf-4c2c-8990-08dacc44d892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dmgjGo629+GKe/NnBRxJrQh4cO1TVBQEa0IzbmYb+vmNLKClTEeS0kD3ohI1A0jNQwPu7QpVJ74ZhbsK/XIxmOZvGAO4A1T9ViykEj6KC/Ul1DrHFCWPiXqFEMUMN5nosOQJay/IPcI5+v18LH1fV0rB+ZzHflgyCzSxygnMkm9tYv9qms1MwAysnQoo6yM+et2toUX7VJbYh6eOzbttwXJTnnZ5h/km4PYL/ySycQI0cOR+JA6xWkzL1UjzfE03vXs3giLIjYJWcknNZYr2rLLUty3Lj0Hh3LrxHz8KLkL1CqH+peU9osRiCOabH2MHuvTHh5zLscomgcXLWeaKxFLPI0+210sHNwofia7TpLl8d8teGAjlECdLwNNH15JrPFGKr/TfLFST2JyAD1LVD1MLp2KRyixAVoGuL0LexXsY1A+rWSvOo1tFSVicfgse5GKQaV0i3SaxLgMU++hbkS8cZkEbIDzpTBgDMp+XTZ+L/q54fh5QR5hnHl93GyAfeLBNmlyf/Vd1b25NBcdFeH1SsOgXHZiaeooStT9nRWhjytKK1ii2abIkNk1HYPByaKVzhW1cOPreCdbx1ozfbB8CJ3AIqM1ywlc0KqEOi6hcEaBqm2UCdrxl1zybEMQ/1tQhi3z9T6XHjxL9rg5qQVynEgJNaSpYMqF2ZnOzSKqftL0g0UZ22XkRDCLRuMFeXazpkm73SAFScAY+SWlJobtFffuo22LPcKMIaqQ14nh7AXfgkAJwj65w4g9oBtp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(41300700001)(8936002)(4326008)(316002)(6916009)(5660300002)(66556008)(66476007)(66946007)(31686004)(8676002)(44832011)(2906002)(478600001)(2616005)(36756003)(53546011)(966005)(6666004)(6512007)(6486002)(6506007)(186003)(26005)(38100700002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUJNU056b1FIMklaTCs4TmdhYWpKL0lIZ3VXR1c4M0dTOURKSHRsNTJZRHJz?=
 =?utf-8?B?Nmt1dnNxNWxkY2pzRFpqTW5wNWNyTUxSYlNZUTBMemgzV2FUMk1TQ1orZ3Rt?=
 =?utf-8?B?cWdKVXAvaFlLSGdQa3R3bGVPd0V3ditvdUNUWWwxNFFtMG9IR05EV2FOa1VP?=
 =?utf-8?B?TXBuOWVtMHRvOVdPN0MrRzcyMWVLc05TTnhEUWd1MnRNaUpBT1F3L2NFYmF5?=
 =?utf-8?B?UjdrRDc0WG5MZkQwTVJuai82OVhHQndtMzVvY3pqUVN0VEVaWVZCck1Zdmpy?=
 =?utf-8?B?VW5nN2JSWDNmbXBzbHBuMktMRS9OQlJsSDZ2UFpQTExwVkFwZUxtTnl4Z3lT?=
 =?utf-8?B?WFFGVFphZExWaGkwNlRWRGYzMFNGL1pONGdNbjRiU2pZcm9VWlNnQWduTGIy?=
 =?utf-8?B?ZkZTYks3L05hVENmM2pYOWkweGJNd2ZhR3YyMHd6Mkdyb0dKSVJ5US9EZTlG?=
 =?utf-8?B?RUh6WGFiR0JvZDA2WU1TUWtQKzNCNm5uM0FyaWlpclkzejJZWWZobHlDa2Ni?=
 =?utf-8?B?dWtMeVoxNUZlSUdCbzI3d0hzK3dNN2E4L09aVHI5ZzhvU3NSSlF4dTFwM3l4?=
 =?utf-8?B?bUx2NkloUmppdXo1QjQ0aThVMThVdWZCbzhURGR5VlY5dGl2eklxT0o1blpZ?=
 =?utf-8?B?My9IYVJVNGtRTHQ0QndJZkZSYVhHQ3ErYzZUSklFTVMvcXpvZFhZbFZlbnJx?=
 =?utf-8?B?eEsrcmpVOWRVOVlsMWRncEVqSjNPVzJ5YVNDTWQyUFpIRU5EeUM1T3FYNGFi?=
 =?utf-8?B?alFUb1JleDBJVnQydkQxRG1VK1pMOW91U2R1dERuZS92bUd1bzR5aGJqNGlX?=
 =?utf-8?B?SWd3UE5QUTB2dXMvYkU2M3h0RU5heGdndFFreWlIdlBoU3Fzc1lGcTZLYWg0?=
 =?utf-8?B?NWtDVGVWOGszc0lzcE9KZ1BMd0RlT1lnMHJsZlhCbldZRWpZbk5jdWt0cXBS?=
 =?utf-8?B?MHFPQ0F3LzdrV0tVRXNITVVqZmNCL2F5Nm5HdnFzd0czdFJ1RjVzUC9uaU52?=
 =?utf-8?B?dnd1YmtGUXBUKzJZbzBmYTAyNXNWckdMVkpXaThkcnYzYm9Ba1hNRjBRT3JQ?=
 =?utf-8?B?VVpUalJGVVpPMzdQUjZ0TStJRzcvNlJISW95d2xCdHoxcjZWaiswc0ZqYXNy?=
 =?utf-8?B?bnFRSFdjYWx1RDVlWEt5L2pFSCtiQ0pMSlgwWGVKUnZCSGRLY3NMei9xL25X?=
 =?utf-8?B?OUxpOGNzelEyazNMQ0JKYUhKTzFCSnFhWWlWaTJKMWtFSlQ5WXlXSm1HNmZE?=
 =?utf-8?B?SldsbjZvL2NLWnN6RGM0aGhZZ2c1c3Q1ZXhtcGZIMHhVZXZKZitOM0RzWEF0?=
 =?utf-8?B?TTAxdW1IZEJhcEdyQXdONlNheXp3ckEwd2FSNDdFN2lUcjdJRmVHSXBhc2k1?=
 =?utf-8?B?N0k2bmhpWWk2K0hZakZYUUdkNEtnWWZMRHJUOEFLdjRyNitQdFlCc29USVkx?=
 =?utf-8?B?QTJWeG9wTENLaUlqNXpmRFJONSswb1JqYzlBU0poSXZnd1owYmZxSmZpQnN5?=
 =?utf-8?B?cXZqaHBXRWc3OWxEc1ZLNmRnT1BSTDAzSjU2c1czYmhmUDVZd0l5UWpVQ1NF?=
 =?utf-8?B?UE4zcms0VEFRdVZSVDZZUkRXbmR4K1AxQ0xIUXEyVm5iUTRwa1lLenVIMlRr?=
 =?utf-8?B?THd6Z0VzVHlDOTAxTFJNMTZrNU1iUGZwNmk3cEdRYWdkc3BWSWRqYlErYmpm?=
 =?utf-8?B?aGFwbkxnZWVOWGZZTkN4Syt4b3o4aEpCSm5jTnIxTjA1aEV1ZGoxWkJrb2Z4?=
 =?utf-8?B?S3QvYWFvOXRYcElVRHVZRFdlaTVQY0EwbGVJUWx5MFRYc0VRVVdhRXpVUGZ4?=
 =?utf-8?B?WkdoeTFvZ2JPa1NiejJLWGFaYm1QRko3U2dUSTNLQkk2WXBxS0dyOU42Tjg4?=
 =?utf-8?B?Z0lJUklZNkEyZHM4RlNGM05XQzZZZnNRNXMrNDNrVnF1UERLQlVxSnpEZ3BI?=
 =?utf-8?B?aGFDRnU5YUQvTVRKVDZzblpiT3lHL0lnaW43bVVWeXNaYVkzcjExZjBYUFVD?=
 =?utf-8?B?T1Y5YXQ0YlZxUmJIeEdhWkZHWTdEWENQYTBIN0U1MkVEU0FlTzJBYy81ZGQv?=
 =?utf-8?B?MlZPSjdiTzNJSFQ4QTV2VDR1U0UyeGZWWEhDeFNhdEN1ejlrVWZyUkFBcW9X?=
 =?utf-8?Q?oO+GxkCKC+yCsO/bT866IAstG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbece3d-8eaf-4c2c-8990-08dacc44d892
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 04:48:49.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljn3HZiuWerfEai5tDPDTXDTmNrY9mf4/uCZeV4AAhpwc0NSrt+A2/EuhIyhn/kINXn6mNt6YOGJ84BJUZjEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On 11/21/2022 7:33 PM, Jirka Hladky wrote:
> 
> I'm testing AVX-512 packed double performance on the AMD Zen4
> platform, and I need help identifying the backend-bound workloads. On
> Intel systems, I use the metricgroup pipeline:
> 
> perf stat -M pipeline binary
> 
> which gives me exactly what I need.
> 
> What plans are to add a similar metric group for the AMD systems?
> 

For determining if a workload is backend-bound, the recommended
method on Zen 4 is to use the pipeline utilization metrics. We are
the process of providing similar metrics and metric groups through
the perf JSON event files for Zen 4 and they will be out very soon.

The Processor Programming Reference (PPR) for Zen 4 based parts
has a table titled "Guidance for Pipeline Utilization Statistics"
which has the formulae for different Level 1 and 2 pipeline
utilization metrics.

The PPR for Genoa processors is available here:
https://www.amd.com/system/files/TechDocs/55901_0.25.zip

In this specific document, the table is in page 235 under section
2.1.15 titled "Performance Monitor Counters".

It may not be convenient to find out if a workload is backend-bound
without the use of a metric but one can still do it by programming
the raw events that make up that metric.

E.g. the formula for determining backend boundedness is:
Event[100431EA0] / 6 * Event[430076]

Running perf with the raw events give the counts which can then be
used to calculate the metric.

E.g.

$ perf stat -e r100431EA0,r430076 ./test

 Performance counter stats for './test':

           750,372      r100431EA0:u
     7,500,728,022      r430076:u

       2.894204814 seconds time elapsed

       2.894060000 seconds user
       0.000000000 seconds sys

The backend boundedness is then 750372 / (6 * 7500728022)
which is roughly 0.001667%.

- Sandipan
