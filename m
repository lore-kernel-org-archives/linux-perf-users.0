Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC3FC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Feb 2022 09:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiBXJWG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiBXJWF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Feb 2022 04:22:05 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0470C14001
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Feb 2022 01:21:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5ZWXFgJ5TnMNBTugVfic2rrVjvc/nnnj7n0ELqbpEIinNMYqk2Ew6xCbiBEPpN1PYqpnS3ZxghQTnlHsXsHPFzqApuzmZIEXKsXt2CZjAPv9j9AkNGdQqFUulBDevncUTa8Vyfn02AGMSIChyMNSrCp9MG/xuiGbj6nhTPpukXVR/z+DfEq2Ai1xpWUNlfiTYuY8WgUPDta+PmWUhqxUuTutRkfU5r/AKJrj1OKk0YR05nlu7ZPKXQrKf1gsmPMqtIVHMe45a6L7fhLZlaA2h0KGzFkDU1OqTG6VKCUsKlg4vc6fgDE24b5zSL3boX++V/FwH0sxIsPwWNriZkW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/itpujcN6ne7oImb3B67huq1EDuyJsiDx9BshsRPakQ=;
 b=MQTshwR/7ssPrQ6dDX80CO7QOPDxIFYMywzFRb4BbubSZ+tnl0auoHTqTpK3cOBGKvHaet+wL+2IKggKko1lsBAG+PkmfdlShPzDm8oPyTi01DUZPGIAhP0MTjYLxewIqD7YcrN9ty7LCs0KuCw5n9e91EN9NepuHKckySZ353rAXGg1xSRy4M8zSWkMqkNhGXm4h5obsSvrdXZZi/fN2T5jRthe0/9Bm2mNkgsB4PINT1swDvHtcKGl2POEbyJF5OAR77CMIY/wJmDSLPMUT6tUz8rOgbOu3EmiHXqGwOFc8b1Jh26/QTE876dGM4b+Cif08yEqrQhGpesJ2eKjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/itpujcN6ne7oImb3B67huq1EDuyJsiDx9BshsRPakQ=;
 b=Stbid8yTOrtyz3BA8kVIyideCP5pbV5LSz8GENUIRhx0Hyn9tkEWD8Q4ttIQ50lhe0umzsMAhlBnslbxGkgA4aA3ZkTtRVZvhtkZUuwsqIe5SHc6Cb+GbKNa/FkX3yrn80tP/XX0qH06wx+v5ZmJv8ky13hCLv9M7mmLTFQBFuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 by DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 09:21:32 +0000
Received: from MN2PR12MB4045.namprd12.prod.outlook.com
 ([fe80::ac0c:73cd:fd90:9cf7]) by MN2PR12MB4045.namprd12.prod.outlook.com
 ([fe80::ac0c:73cd:fd90:9cf7%8]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 09:21:31 +0000
Message-ID: <08584f75-b829-1833-deb2-ed202bf1874e@amd.com>
Date:   Thu, 24 Feb 2022 14:51:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: AMD Zen2 l3_misses event
Content-Language: en-US
To:     "Mor, Omri" <omrimor2@illinois.edu>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <CDD3A5B9-9B64-44DD-8705-6382913C8A10@illinois.edu>
From:   Ananth Narayan <ananth.narayan@amd.com>
In-Reply-To: <CDD3A5B9-9B64-44DD-8705-6382913C8A10@illinois.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::24) To MN2PR12MB4045.namprd12.prod.outlook.com
 (2603:10b6:208:1d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dddfb76-6c3a-4aac-0dfc-08d9f7770b7a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4547:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45476639DE8EBE3A7815C375853D9@DM6PR12MB4547.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OgIJk8gtPV9LZmElqpFflyh4nwZdX0TnewceVGZrEH6BQABqEvJToujZycPbURoVLeT9aPamm8qN9j8VhJKpDxUBj3Ouz2ej+sP/hbn6X3TftMaH6PkyKoiIO4U+2o8mGjPdrq4pG0U4yVjfDibDVCn+UMbdq23BAR/u0/V0+OFtX3fcnOZm1LXczUwH3zUtFnnsdZuwtVZB/5a4G6AIEJBroBalMD5Pfc0ZxtRM72FZTd4wFAoKZDmmdtLvS0E30HntC6QwY48ZIngv8ycXWjvGU/nysPCK+qTVHzUnsYAjMchClgCn1SWxnJqyKvnPQJx/o6xzlC8D6qB040tJ+tZF79ZLmGv37NlYjUA+VujHSpcLcmMu2nUnRSO5JVv0G3f5JvH7IURo1S7zwmiWA50KzrmMo6QmUnUlH4+crsZHbzkmaXxIl5GfiAv/7VJNA3J9bwxNLVNf9/A++pHKCrBTWVbOVGZbpQE9s0NudlvieaYw+AERN3qfV72/YWnUNwlBl2HbLM7pZxfjERgyNjPBLaXn96rMxCWHPPpET4paDndpWpAfOW1YEXhvM67BhWIzDFfE7eDuA1Jegrh69JXznqMG3noAyzAW6vXX61p2D4/fRKTvrF+ys74aiGmFE5Yp6tT18dhADu1/+uLobWlLdQAfB9fDYU9iVhmAoMOMLksWKw8qyXI9X1y21lXhruTAHk6v+TA3WroZFjtYNIz7Eh/H6UVll3RfGsG+uNSRGScVToVFaPDgLCioJHgqXrn5wqLSZqC6mMIjoQoF7mTddy9VKoC71oFjMEwHqY3Vq0H1xGYNEBxy2cr5OP8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4045.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(966005)(66946007)(6486002)(2906002)(31686004)(8676002)(66556008)(5660300002)(36756003)(8936002)(38100700002)(44832011)(31696002)(6506007)(26005)(6666004)(6512007)(316002)(110136005)(86362001)(508600001)(53546011)(83380400001)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFNGWlQ0RFJtUUM5Tlh6b3NEVm5kRlRBRWZIMzVEcDlvTmgrdS9YelpQUGdy?=
 =?utf-8?B?NUpLWUNYZGtrcnlJaXNFcm1LV2NrNWpGN2xiVEE4U2J6VjJMMmJ6YkZxeFpT?=
 =?utf-8?B?Uy9sdkpaUXJqb0xkVXZlSU1wYXZQYk1tamdPMXdVTzJsTU42RmhIc3ZpWk1r?=
 =?utf-8?B?UitzL0xyaU5yMnJScDZUVW1kb2YrZy82aDhkNTdidVBvUEtGT0FSeTdYNFp4?=
 =?utf-8?B?d3RHYnNTd2dTaHNCbTBIdTF0T0N2S2Q1Q3hZdTFIMDVrMk1OUUJtenkvQUhR?=
 =?utf-8?B?QzlBMGthdFF4ek9NNXdRZzRwbHpQcXg0MDJRcDRUOXh6SURDMDlPUDlFamQ1?=
 =?utf-8?B?WHBlcGlhT00raWp4MWtuc1Nma2VTK2FNNFVhUnl0Y2FxcEJ3aVE3VFdvdlpj?=
 =?utf-8?B?VXNaNkh5cWNiTUN5RjN1NlpSdnNmdk5OWUJpZW8xSHpLcjgrd0pWRHZvOXlI?=
 =?utf-8?B?M1ZlRW1HNzJLNEtKT1ZMdU41OGlVWFlwUmM4L09mTjNFRyt2ODVLclI4NlZL?=
 =?utf-8?B?TnV3ekgxeFk1Q0RzT1d5ODlyS1FkemwrTDdxVEx5cVJ3dDZwWHFKY1U0em1y?=
 =?utf-8?B?V1dZbGdzQ1JvQ1J4NFZrNGpTTkJNQU5oMEVSN0ZvYy90eFhxUENLL2YwSmp5?=
 =?utf-8?B?Q3RoWkRDNG44ZnJWWk55RE9PRXlDc3FTN2Rpb01IYURpQ1FmTmlHUFg2WWV5?=
 =?utf-8?B?bXc1Nm5Fck81RWwzZ1NmSXJwYlkwSEdDVEl2YzJxOUNiaU5hMDJIOUQwRkph?=
 =?utf-8?B?WTdyN0I4WTl1NmdsSGEwc3RuUVRKbXZZbHF4aFg0M0FXMGJINTJRNkxyOGta?=
 =?utf-8?B?VzBsTGVzeVhwVVZwTzRJdFdPK0RVb08xWlg5OHJ1L2oyc2N5Tkl0VzF6MXh4?=
 =?utf-8?B?ckoyT3hmQW9jWWZWeFh6Z0dhSElwam91T29MQWY5bEdhYmJZc3ZaRDMvNFJ6?=
 =?utf-8?B?V0ZwY0pxb244WDE1Ukc1TGd4QTZta2RJeWpnNWZBU2UxNmlFRnNKS3RSNTdn?=
 =?utf-8?B?T1JmZ2xnV0xuM0VkWkgwS2JqWHBGbS9uNE94ZFV3eTZ5WE1BK0Y3czEvS3By?=
 =?utf-8?B?MzRUQmFzZ3Y0NDdSWDBrZ2Q1ZStsdEtmM2htd0VpL1FheG1UcWhIMmpYZDdT?=
 =?utf-8?B?Mk9pUTFGUGlQWmJhRjdDa2Znb3pyMkROU3BuMldzcGFscW5mOTV5enZmU3Zq?=
 =?utf-8?B?YldZbldGc0hBcng3dDcxdDU2U3VxN005dmM0aUFYMHVPUlN6SElQQm5rZ2tI?=
 =?utf-8?B?MWNnYys4OEF6KzIwU0lxTEQ4M1U3VVIvSmRMNU9zRnFyc2lPY1NuY0Y4c3M5?=
 =?utf-8?B?Z0piK21LaHNZakttRGdFWXFaZW9BeS9xSDg0OG1SWVhhSUlnbTJxeTJteDVJ?=
 =?utf-8?B?RGs4cU5iLzhGNWFaM2ltM1pBaFFaSmRVbENmMWdoMEVMWHg1U0FnQzlyZ0N5?=
 =?utf-8?B?WExZSlg4clM2elpZRHFtcTJvemFrSHpUb1FwTEpUdzg3UE1Tc1g5K25pRnMv?=
 =?utf-8?B?amhyUWVwSU01dnQ2OTlkOXJTb3FYaE9mVEoyd2F0bngwdUw3cm5YaHZSTnM1?=
 =?utf-8?B?U1VIMXgzTEZGN2ExanNxWDRtSDNHa3JlN1dvL3JaTm03WFZLQVNJUGhmY2NQ?=
 =?utf-8?B?Y2JuRFAwRlhwclNoM1h2ZEdYOG9iYTBueUFSdUxTZlprUDA2REpIRTVKdnND?=
 =?utf-8?B?UnJNeWFtOWN4WHN0aU9EWC9rYTRZYVlDaFZhNlkyRzJDdDV2VmJtMThyYjNs?=
 =?utf-8?B?alJFUG9za1BjbVdnTXZQSXpsbSswckMrQ1hQcEtqOEkzK3hLYnp6YjFUdW5C?=
 =?utf-8?B?bkVveWt2d1MvQ1pIUUFoNUxTUzFOL2FjKzFFME5XejJBdlRXZkx0UzhRVGlN?=
 =?utf-8?B?WG1zbDhsdmZSWGRJWk5KcmZaelJPN0RzOUgvNXFHNFdpdUZkRWZKVkVQUWk1?=
 =?utf-8?B?a1FqbEhQbHQzMkd1NGNxam56K3FHMnZobXRWOWNoRnVDV09JRklVRXlmbzFr?=
 =?utf-8?B?R1dQUWVIZWJac3V1YU9qemhvVlpJakFQYlNZd1orY1Fpb21Pc2dpdUQ2NEh5?=
 =?utf-8?B?VTNCeDRaV3VXaUtnR2EwUDV2emNKeGNYbEtkdVBvUktkRUNsNHBkczNvOEdM?=
 =?utf-8?B?RzUzQmE5VnM1MS9MTDg3RG0wR1BHT3lOL3dpaGlSYlYvQWUxdmRCWDFnbXN0?=
 =?utf-8?Q?TySOpFNmys3EtCCkfPVxDWI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dddfb76-6c3a-4aac-0dfc-08d9f7770b7a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4045.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 09:21:31.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ+TKPIUcZpxNzqA+QOi0OM+nnru+KPbPdbaTStU3+MIQgYjs5nSlLYfAJoKDVC1PJnINBrT8OYKKOsu6dmuVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 22-02-2022 05:12 am, Mor, Omri wrote:
> Hello,
> 
> I am profiling some code on AMD Rome (family 17h, model 31h) with an older Linux kernel/perf version, prior to the addition of Zen/Zen2 events, and so have been looking at the event codes and umasks in updated perf code as well as AMD PPR. Comparing the L3-related events in cache.json and those in recommended.json, I’ve noticed some incongruities and want to confirm what are the correct values.
> The PPR and cache.json indicate that L3 accesses use event=0x01,umask=0x80, while L3 misses use event=0x06,umask=0x01; meanwhile, recommended.json uses event=0x04,umask=0xff for L3 accesses and event=0x04,umask=0x01 for L3 misses. The PPR indicates that 0x04 is "All L3 Cache Requests” and requires 0xff for "All L3 Request Types”, not clarifying the meanings of individual bits—or whether such use case is valid or has any meaning at all. Additionally, cache.json contains the l3_comb_clstr_state.other_l3_miss_typs event, with event=0x06,umask=0xfe; the PPR states that the bits for that event are reserved.
> Due to all this, I’m struggling to determine which event and umask is correct for counting L3 cache accesses/hits/misses on Zen2, and would appreciate any help in the matter.

Please see https://github.com/torvalds/linux/commit/08ed77e414ab234258166f5628d91a7a0e681ff4.

Specifically, please see tools/perf/pmu_events/arch/x86/amdzen2/recommended.json

Hope this helps!

Regards,
Ananth

