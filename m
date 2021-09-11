Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7118C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 04:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6D5611BF
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 04:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhIKEoG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 00:44:06 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:21600
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229559AbhIKEoF (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Sep 2021 00:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwWXtg5EYeLlyIYls5ZKFNyYgg8cB6Nm01/wssgma/s9tqpUsUgQPTazmHdCwHpWe2Mt++PpzU0SWXBgw4jwbXue/TTjmhYYJlX64RY9oSc2Hjo68G9vpQbVD1/wI8luahR1sb25KH8cWwClp13RPVYgoRKPe2uRwsazbqwE8oW6/wikrZ9L06AJIo1kl38GY7MTd8vPVFtgCTHwVFlxjzzkCJJHSMg7C0kDpczVEflxbuoytVK6fHl4d59ATNjTgwu4oIzK/ruHpib9y8J5jP2p9mFontdtAtBpeR6dlRsTPyJNB+2ikGBnSxSS+9h+VLYRb6S0Yb6tTuYJLi7B0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dHkxzMEv8ly1TDIeyfqESLcznNYfgcWq2+h2VwaZzzg=;
 b=nfp54jgLOeDKseqfFBCNFsYBGya/pLCe44HRhFUjVkcsix/UdvKPNXEkjxZRVjDwSS/aOusuCmP4MwkSmYYmB3/sUwb0Hrf1635vPar/uzL7+YQ5LRYPqduLvrqFviYg3QzH8sC5RToAFIXcJ7CxMEBl6dBIAyBOVvcuCgx4ywhWGVvdtN17QNCT+SSM0Y6aC0IZ6nhpKutK2OL+2BDtV13udJK0k543AHjtRtCcRqWd3iwgzYqJhDD+wTHV+hmY8/frLjh/XoAqc7X7lhtFzS5HUgRAqE/Pmw31o0JTx4BDoadN81PgSxDszZDGZ85a0IZqwX5iJZ+rzdrCwR5Wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHkxzMEv8ly1TDIeyfqESLcznNYfgcWq2+h2VwaZzzg=;
 b=CgEHm8yujuEM/sQpBM7glNgEHwbVbul2J5i/XQ+cfmhvu7mn0yIrJi/os4tySkgPcsmd40xPQ0enpkQ+QH2/fhiCKt8LrXO7Rxppw3DgI+Q8EWAtYjWO5GRx0oqz/jVhB5zWE3Qg5BplaMzuIayQoT/A+9bvniWtzxUuwuh/xTg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2643.namprd12.prod.outlook.com (2603:10b6:408:29::21)
 by BN6PR12MB1780.namprd12.prod.outlook.com (2603:10b6:404:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Sat, 11 Sep
 2021 04:42:49 +0000
Received: from BN7PR12MB2643.namprd12.prod.outlook.com
 ([fe80::f565:ee0f:eac1:de2a]) by BN7PR12MB2643.namprd12.prod.outlook.com
 ([fe80::f565:ee0f:eac1:de2a%7]) with mapi id 15.20.4500.018; Sat, 11 Sep 2021
 04:42:49 +0000
Subject: Re: [PATCH 2/2] perf annotate: Add fusion logic for AMD microarchs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, yao.jin@linux.intel.com, namhyung@kernel.org,
        kim.phillips@amd.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20210906105640.1040-1-ravi.bangoria@amd.com>
 <20210906105640.1040-2-ravi.bangoria@amd.com> <YTpveO0qqKFTaxTk@kernel.org>
 <6a987cad-6c46-280e-f791-6c59b6628a45@amd.com> <YTtpVpo3d/h5YkVc@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Message-ID: <e9525e3c-f0e6-e9ed-6ce5-fc207742c9d4@amd.com>
Date:   Sat, 11 Sep 2021 10:12:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YTtpVpo3d/h5YkVc@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::16) To BN7PR12MB2643.namprd12.prod.outlook.com
 (2603:10b6:408:29::21)
MIME-Version: 1.0
Received: from [172.31.158.202] (165.204.158.249) by BMXPR01CA0030.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Sat, 11 Sep 2021 04:42:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589e1ef3-60bd-44b8-9157-08d974de9b4e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB17809136EEF82F01F0FFE875E0D79@BN6PR12MB1780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBGMeYP7b1LKZiu5d/72CnRh7Ba/QBvgTfv3J4Gj4nOhZTbsjUEGGNCBaI/hbXA3jLAJp/RR7lFQQEZ4uUdH0xr6towmsykHUyDgzpxstIVZQAgU3GcMKAcgIu5EZFxFi5y+Kj2qvDHZbapmhFIyjzT3/uLPiwYu6iECYeTIn2tTTowmORGdBbnq1zL1GN2u/ZDqEyJnR7P7L+y3XINsVVIp6RQrzzo9uxIYL/rhFR5Fa7ZJiirJhDeFSdIMqGuYcOt07tvTOJj+SxmI+0PgcHlweRqysdF5g+aVzeAQwr+7ThsVjZO+3+vsuVMcMt9G3TuZJ18kCKuKs4Ecch8mpZxSIygynaRuIUBqdyZBjylwC7jN9aYNBm4p+Tj5B78U7GamP0Y3ZhPWSzsXctpKkTDj1ZxU4ufarsKPBac16KR+AoXZnN24t2QSq8UaKYOC0w/FNXRfNGYNko1opuq9VJCd3a6qqp2b4WC89qGJc2uxxrsXroMyCzZHL3pxlaRe6p8ZG/j1AlJ0S18ibPaqc7/KLZew2DHGm3398UMUc20DICdG3EDHN0Ei0xlZOeDblYoJZjRQVAp1QtbvxoG/eFoon82l/AkqJ2Maoqik02naG8hW4tKh+Ozc0AIL5nGfIfjLmW7ibWo1/F3Q+iE2OgaTULtkCVyjMT2EWqtZI5w6zcws6fVZxyTqofb1mZxPPZXKaveh8WyFvy6k7bwAbSOc8C2HO3ozd1pP+Y1ZdAv+fx496fpkxY245qLnZtqPZ6t3vCnriuukDfEp2ufRmXsDk2D21hQ5bAe6T43+kG1mQiXVOXXD/wE+028/+eos
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2643.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(66946007)(6486002)(4326008)(38100700002)(44832011)(186003)(31696002)(31686004)(66556008)(16576012)(316002)(66476007)(966005)(8936002)(8676002)(36756003)(2906002)(6666004)(5660300002)(6916009)(2616005)(956004)(53546011)(86362001)(26005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?FHwxpKDok7dlrM9xmG38hDE3lwRoEWyOOM/KO59eZ/kGYT0i4Bb+q5BH?=
 =?Windows-1252?Q?22YWubF7oJ+Pa25NxAWZH4P96jTglJdP4kAQUGyeXoCVCWaHSI0s3v7j?=
 =?Windows-1252?Q?LFI1ZsQnwhaagyofPlaFRtsGpSgyCrmtjhhL4hDYqln5k7KTS5u481qx?=
 =?Windows-1252?Q?uvcNE07KJd1ZYk9pXw5Es17+gGSVdx0rfq0l47Gtbnj67RXdh0hal1ve?=
 =?Windows-1252?Q?dIOY35Vg1pP+OIac0Yo9obxq4UFDNqIkdilgzT95qTXka6k4jaNp1vVX?=
 =?Windows-1252?Q?VqwRKtBko2SPJ0FckEdB6uuJs3ziL0YpeE3kAb4hPRgLb5euLo04xGmi?=
 =?Windows-1252?Q?QabtFzR0sv5HOMeAcrvzMijAOQkZim3+QQx8DuxuUazWBmKfD8ke2mJv?=
 =?Windows-1252?Q?2DYb7qCs063OWN6xmDHFXzXBpQgAylX2OtmaoOIzv8LlK0/iStm2LvCm?=
 =?Windows-1252?Q?zhllGh8zjnVYmBZojspoHpeFc7czHLwvnGpdi8W+ZdLbLCvNl89jk2Ey?=
 =?Windows-1252?Q?N1rrSEWp/Tjf8cnPgz9gXsh38+ExX229t/oOjvZtKubDEe/YUjJV0imu?=
 =?Windows-1252?Q?HZMl0+e5u2nhpxBqFIlZNLIEFV2N+T9Ru/Ix19lS6rzzgagk6Zeq4AKH?=
 =?Windows-1252?Q?QcLJOKq1I9O7CUEYTVi1fm4ECzgMOu7OEny1IdLSy9tA3d+pFjhE3JZf?=
 =?Windows-1252?Q?r9+oA9IXEWmPXT+/o7565fxyKqUTV+MRRRTJxm6IodSvz2sHw3WQbAXs?=
 =?Windows-1252?Q?tZI4PyyzCCj8LgmE+d1HgE7fuQZwVCNK9pjQ+Uigr4Gwbt1yg4vlp9J5?=
 =?Windows-1252?Q?D2gi5lZFM81hP0YxK0sd/sy7R49DVv/TPVE9Yl7f/Kzy6ZrR0j8WLWDM?=
 =?Windows-1252?Q?wWS5F9YurMGnHpalfcFIgPFQcVlAbjnRxsVmzpkqz71YOFb0FelRFAFu?=
 =?Windows-1252?Q?kl1d6b7cFr+9nheYoZXrmvJWwUxvG7u4gtFvLiNwuzz6t3I7jY2+ehlU?=
 =?Windows-1252?Q?TsAGezstSg1zF6HXkrkd3SGzt0LttHeck77U271F/5i18Ry1bzOK5EkA?=
 =?Windows-1252?Q?fU7vzkrg0rupCPruVxgq7moeqBlmkFOyseLeV/0PLpxMnvh8FngRSco9?=
 =?Windows-1252?Q?P8NRC2PJZzkkHE9e5QAz+uw7fxd/5Mw9uybSZQGQGQd/JAGO3JT+Kkkr?=
 =?Windows-1252?Q?cXgvEnpgJU2KvQGoS4o8/fSNNagvNTaYZ+2IdClyneYlvEzA55YEqvfR?=
 =?Windows-1252?Q?2Cy+AOrr0QMf/UpMLfgD00vFNMlxgSLj9ofY2G6gjsdyTXXoJ4jnXy+w?=
 =?Windows-1252?Q?P/GKPNBnO8OZo+ZAORzjCqIQdFXMqhxhvinjwvduOXC7DeJb69hlw/an?=
 =?Windows-1252?Q?1IVkzUH5uYNiRpQ4UHVCSeP/FyAy3MZ3x452CTvD4395IVv6JyYuFG9w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589e1ef3-60bd-44b8-9157-08d974de9b4e
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2643.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2021 04:42:48.9003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBC4//dWVL+RE83tW+dB5E6ZtM1Ki7aFdn6/TzROealOH9HLxYy7llTUGfExTBYjy0EyrRqePQwM9Q0952alPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1780
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10-Sep-21 7:49 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 10, 2021 at 04:47:31PM +0530, Ravi Bangoria escreveu:
>>
>>>> +static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
>>>> +			      const char *ins2)
>>>> +{
>>>> +	if (strstarts(arch->vendor, "AuthenticAMD"))
>>>> +		return amd__ins_is_fused(arch, ins1, ins2);
>>>> +
>>>> +	return intel__ins_is_fused(arch, ins1, ins2);
>>>> +}
>>>> +
>>>
>>> Can we instead make x86__ins_is_fused be a pointer and instead of
>>> storing arch->vendor we set it to one of amd__ins_is_fused() or
>>> intel__ins_is_fused()?
>>>
>>> I.e. here:
>>>
>>>>  static int x86__cpuid_parse(struct arch *arch, char *cpuid)
>>>>  {
>>>>  	unsigned int family, model, stepping;
>>>> @@ -184,6 +216,9 @@ static int x86__cpuid_parse(struct arch *arch, char *cpuid)
>>>>  	if (ret == 3) {
>>>>  		arch->family = family;
>>>>  		arch->model = model;
>>>> +		arch->vendor = strndup(cpuid, 12);
>>>
>>> 		x86__ins_is_fused = strstarts(cpuid, "AuthenticAMD") ?
>>> 					amd__ins_is_fused :
>>> 					intel__ins_is_fused;
>>
>> Sure. Will post v2.
> 
> Thanks, if you're quick we may get this into this merge window :-)

v2 Posted: https://lore.kernel.org/lkml/20210911043854.8373-1-ravi.bangoria@amd.com

Thanks,
Ravi
