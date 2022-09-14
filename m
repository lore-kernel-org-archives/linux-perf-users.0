Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E29ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 06:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiINGcF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 02:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiINGcE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 02:32:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716D5FAFE
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Sep 2022 23:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVaBMIb6lw24K528x6g2V8nYof67NDXu9ol0lu0YyZ/DO0KO2VpGUPIUCLVPXZQ3PAYgaG6KVT52qGMNIYrvVjIa4BQji+mkazUJV2jGFb3EfxzXYj80P8NFN4hLxwYlYBOIiUX9d/DReQ9JomRtCcEEi/um3mdfNzlIV5Ti63b3zsnmg5ljUwghTefpCoNwyo1B5uVKrpvjdp3rHt4oQF6wEtyhTLQCtWoqVMDnplo4uTvrb8l9KC7ejD0pyr4SnVQZSIl8wZiQZzEsY4o9iEfu7HDjwT1z1F6QZrR1payvrsXFCBEbfCUTgsSPbeU4v6FR7UVNc+Vda+4Z9ZMCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uip5lFxt3C7oa2849CsgjmjIbLhwp8yA96gNstkn+Y8=;
 b=SCucKEYt9ahwVNtaY93y+uSVrjtKRiEVTkeBrQyqXC8SAnAWZU3wVKCG/ucUYloMdga9pV7a/ks6dgxVSW+EyqoMzMG4YdI+CclHxKpfvXn7SpEEGqwrP2mahoG7OdskXVt6RtvyKlfOD5nhRarjtAjKhbDdV9Bz2O/STAugfmWwPYoKFiiM5gUxtzpvpUNf6Bu9IUw9/S81cHzQj9+z2EUJJOUblZUktLANUvQvneiFO5DavVX41BkE4JITI8Pmj8c8m2WQ3kMCAASSEZMdJ3U/vS+YgfMJZTzynAgCJha5NTCotWqKuPSs9uxn+YzssVYlgfH8w2wzozc5cgu5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uip5lFxt3C7oa2849CsgjmjIbLhwp8yA96gNstkn+Y8=;
 b=Uw/GXcHYa8aOO+kAht/3YWX4XqzKDt1t3LpoQngkPlNrTPRtRLHV3q2Qyyp9aweCuMvwFfOT0dycLnHXU5k3M7qswzY1EDvN8eIy9GSupcjfn1jvtagUGdW2TpY+WNnF5uzKHsCV7iPK22bJT7PGqs4DwQZiJ5rnn3KfU+mYCCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 06:32:00 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a83c:ef62:7ec8:447]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::a83c:ef62:7ec8:447%3]) with mapi id 15.20.5612.019; Wed, 14 Sep 2022
 06:32:00 +0000
Message-ID: <02ecc849-06de-d558-3750-a8bf878869e9@amd.com>
Date:   Wed, 14 Sep 2022 12:01:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [bug report] kmemleak observed after system boots up with amd cpu
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, x86@kernel.org,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <CAHj4cs9gC9RSvG_F++6=v3wn9QThgh5g=TT+wET6MDW2eWMoUA@mail.gmail.com>
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAHj4cs9gC9RSvG_F++6=v3wn9QThgh5g=TT+wET6MDW2eWMoUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c61eae3-bda3-4101-b964-08da961ad485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtOuKISCGqrXxum5+KTpbB4aRBumKoagFul/FSCDOcHzo4fvXr4y7bsog9y7nlESCN66chW2+dIdKRi2LvD7jcqeRm53DycyxYjFgNtGq/42RGo0YvuBESGfJPpwxAPbkH/pVAwu8vGkeG34tnddyOFt9aOB5391Ymjp4IFsypAGrnD/vEpIqXsgQvUt1yUAuv8CXw960bPsE5W9e2btoQtwrJjKtUex5X/V4TBO5pcSuso5CR0MDYt4d5s8A5T/ZTdWH0fDWb3AW+vphXEMMsoqmrKWqSvSxEco8uJ8sSqcXH/gBa1kcAS4aa0zYr8z7WB0fvuuWmBsAf7+Mhx+mGI/j9eWhmv8bDtxLYrkUTO5L28bv/6eWIuaHW6OmjpnRAkHzqSbSjTYtv2NnqCsSrJy7cGqRxlKsQUMfu8v9r/cClFqBGNbOWtbPBrelE0pBDpSYfQXD7hT65qyYKygoTRsbyCnN/j/G7NhVoTm9qo7LpD0wdkCiJEdjiJAe+nD1s0O1GC3Ss6zEIGh6xl98xqEa37fSz1z8M5R53PM4x1ffA9uiCZmPUVDZ1yWl9mUhy13W3oIKBUVb0hSqiTl9VCHUUPokwAAFqT0D+BfeOHCfXY+BRSp6cdaeL0dnndbQyq6dKKrmEOJHYGmn57hXgH9I5Wr7arnXvVfNZARYkbF7Br8N3U0lxvA01PaDRrO1dBPfsb8GLR7CVfb8XosgzzrTJDdWojNOkaXNNxbchX7a2olSqRsDuSo/v2LTd1wWzkFRqTr2OwlBedl5c+GMbM6Bub81v4m94b6mTjBGeH9nXfphU6q38QlycUiTq5L6s9DlZpKwb17vcIHOoU4KoGSgMqtcTBqJR0gFxiPOOsTS0POurOmYxR+hXMfqhvD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(66556008)(6916009)(316002)(66476007)(66946007)(6506007)(6512007)(53546011)(6666004)(36756003)(44832011)(26005)(6486002)(5660300002)(8936002)(86362001)(31696002)(478600001)(2616005)(966005)(2906002)(4326008)(31686004)(8676002)(83380400001)(41300700001)(38100700002)(186003)(45980500001)(43740500002)(505234007)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZLT3huYU9IdnF2UW5HN1A1RkpQbDgyVjF0YzJrTjJqbnJRT2ZKZ0lzR3Bx?=
 =?utf-8?B?OW5ITEZHZVBrdVdyOTFLLzllUS81akxSRkw2d09MdGJrdUVDRFExRUxidW1o?=
 =?utf-8?B?TnBaM2x1OHNHM2VSSlNoZ0ZJb2Z1QjFxUCtvL2ZNdTMyNUdQOVp5L0t1TzBO?=
 =?utf-8?B?QU1CdVQxUGdmYjhvU3A2ZnE4a1VzYWtJSWFUR3RxenhnN1pCYnJlTVFOQm5D?=
 =?utf-8?B?MDZ5RUdBWTJxb3YzcnZPT3FGV2pOMDBydGZSenVLcERGRzNKcFBkMzcreDl5?=
 =?utf-8?B?T3FWL1RnTlJldmJuemlpazBNalBiT2dxVVk1NDkxb0I2N203S1JsMjdVTEpT?=
 =?utf-8?B?ZFgvMWpabjYwMG4vMndIbmpNN1pPMDR1TVVrL2hHclNZc3orVzBtRHRId01s?=
 =?utf-8?B?SVVQYWdUcUlTSFVUN2c0SlBMZmFhV2NRckJCdk5tajYzNm1zZVlLczZCUm14?=
 =?utf-8?B?SzFHZTNoR2p2S0hwUUZJeTJtbnBMdngyTnBTc3BOZkJKdDM1YVkwK2dJQjNT?=
 =?utf-8?B?TG82enUyNUJVeDYrcS9hSU9meVVjQ1ZqOThnQnBQd1hJNVgyT1dBR21FSHEz?=
 =?utf-8?B?Um5yMDRJcWFqZDRBdlpkQzdKcFhEZU5yemdRSUlmaUg5VksxQlcwQ3FZbkM1?=
 =?utf-8?B?SUpWY1NOTDFyaVBkL1kveHFEUzZDandlZmlPcE1vNlBRZUNxNFllZ2xnd2FK?=
 =?utf-8?B?b0ExZjlQNFJoZ2tmQkZpMlBZQnNKYzRLRGhpVWpVWVQ5RlJscGxPWUFwZGU0?=
 =?utf-8?B?Vmo2QjczUTRCR2JyWEVGWDdTcHl4eUxDeHRKejRORlFhdHJUVjM3UFAvYkRC?=
 =?utf-8?B?aFBGdS9OKzNUYlpDZW95UjNXdXl4UjBRRFpkL0N1eGU2K09xMmxVcHljOG9S?=
 =?utf-8?B?V2NNRVpZa1FUWjdpeWFNZkJPWFV5b3VkNkJ4UWI4OEg0OStJbVE3SkpPQ3NG?=
 =?utf-8?B?WG82ZmYyUlAyZVV6K0dYWHFaSnZ5Um9qaHlnN2RqanFHOFNMYWJEK1dyNVhn?=
 =?utf-8?B?bW03bkJHNkxoOURueGZmNWg3cHJIK3d0Q3pnaVlzVkp3cmlRb0pEUHVkWFBL?=
 =?utf-8?B?cWNuNC9HV0YrcEJwS216VWpRdmJyRGJwL093T0F1aVVrNWpEcjRDalc3RVBl?=
 =?utf-8?B?bUsyQlFyRlFLN05mbjJMUjM0Nmt2eUlRL29GRlp2a3VVQzRaTnVicmxta3Nu?=
 =?utf-8?B?VXVFR0NoSlVMNnVkc0JWb2JVNVE3eHkwRWhNQVUzTVlBTVBubjl6MTFPdDZ5?=
 =?utf-8?B?ZnBQM2VGT29pbDA3cCtQc3hDck94Y3NPbUpZb0lrWmtjaUx2c013VEZuT3cy?=
 =?utf-8?B?NzRLNnRtODhYeTdTTlhyUW96SS9EOGZvTitQMWErRnRaMVpaellMYnkzV25j?=
 =?utf-8?B?dDV5RytQb3JTNHJPNXJyNzM0cmZ4MDE2blJySWJuY29DWlFhck95cUM5d2p6?=
 =?utf-8?B?dkJYMG11RnQ2TmorL1N0VXkvcW5EWnhBSGZPQlQrSWNjbVlzenhoQWQzdStl?=
 =?utf-8?B?TTVJUEpXM1dOcXkzMFhLa21pckFlVU1aTnJrVEdndE1hWVZWRU5IUDA3Q3Bu?=
 =?utf-8?B?Z1BoQkpWbnk2NllIK3Y2NDNZYnA1WklLSGtqRGJxbk11d1grV3NRS3hkcDkv?=
 =?utf-8?B?UlVKcUp6SGliT0h4SGduQlBMWjJJREtycjRKczJkbEhPZHhKaGRibkh4Ymc1?=
 =?utf-8?B?MmhqVTBCODNRSG1lZmpwRExuSzhTbXNKVDRpdDZaMHZMaXNZRGxRa2EydzRC?=
 =?utf-8?B?WkFObGpMZGQ1clhadklUZ1JBd2w3MTVWazVoMWRoRUNhRDBmb0ZPTTFFTCtw?=
 =?utf-8?B?MXc1SVBSWEluM2F4ZlRuUm16Ui8vK1N3UWVtd25pY0xoSHMwZk9iWFIvYVhT?=
 =?utf-8?B?YnM1aTZHaVhES1hETms2cGhkR0x2U0t6RGxtT1JXc3hoSUVGVEJ3d0d0eGpr?=
 =?utf-8?B?U21pNHB3M0lMRWViVDVPVjV4YWQ3U3JtOEd5bVlxbUtJUU8yKzd5MUF6S29U?=
 =?utf-8?B?bHpteFJZT2EraVdwOE80TDBscWZIc0RGZ1JtbEZSdTBrcnpkM0l3RjA3a3dq?=
 =?utf-8?B?NzlLbU9pRUlRTzA4UFRTQ05KRHdocDRCanpYZ0Z5NWpraW5QcXRTdUZOaThW?=
 =?utf-8?Q?jQkCnqz98JOytVZGt2Am0GMxC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c61eae3-bda3-4101-b964-08da961ad485
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 06:32:00.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5AJjyNjlkbs3t/2nRkDkz3+YrfqIolg7/c1/UW1HqrkbCB3JLCGRRWsLJ4RB5QMQRDY7E+xNXLsRfLbdRDg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On 9/14/2022 11:55 AM, Yi Zhang wrote:
> Hello
> Below kmemleak observed after the system boots up on 6.0.0-rc5, here
> is the cpu and kmemleak info, feel free to let me know if you need
> more info/test for it, thanks.
> 
> # lscpu
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              16
> On-line CPU(s) list: 0-15
> Thread(s) per core:  2
> Core(s) per socket:  8
> Socket(s):           1
> NUMA node(s):        1
> Vendor ID:           AuthenticAMD
> BIOS Vendor ID:      AMD
> CPU family:          23
> Model:               49
> Model name:          AMD EPYC 7232P 8-Core Processor
> BIOS Model name:     AMD EPYC 7232P 8-Core Processor
> Stepping:            0
> CPU MHz:             3100.000
> CPU max MHz:         3100.0000
> CPU min MHz:         1500.0000
> BogoMIPS:            6188.28
> Virtualization:      AMD-V
> L1d cache:           32K
> L1i cache:           32K
> L2 cache:            512K
> L3 cache:            8192K
> NUMA node0 CPU(s):   0-15
> Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
> fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
> cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16
> sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
> cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
> osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext
> perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibrs ibpb
> stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap
> clflushopt clwb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc
> cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf xsaveerptr
> rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale
> vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic
> v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov succor smca
> sev sev_es
> 
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff888140be6540 (size 32):
>   comm "swapper/0", pid 1, jiffies 4294683141 (age 2488.140s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000009569963d>] __kmalloc_node+0x10e/0x270
>     [<000000005ec49251>] amd_uncore_cpu_up_prepare+0x1c3/0x780
>     [<00000000b48a1e7c>] cpuhp_invoke_callback+0x40e/0x1760
>     [<00000000555aab25>] cpuhp_issue_call+0x18f/0x6b0
>     [<00000000b4dd3935>] __cpuhp_setup_state_cpuslocked+0x2c0/0x8f0
>     [<0000000066ebf481>] __cpuhp_setup_state+0xbb/0x210
>     [<000000000949b7a4>] amd_uncore_init+0x385/0x46f
>     [<000000008505629b>] do_one_initcall+0xfc/0x580
>     [<00000000192522a5>] kernel_init_freeable+0x67d/0x710
>     [<00000000613746f8>] kernel_init+0x18/0x160
>     [<00000000813ba43a>] ret_from_fork+0x22/0x30
> unreferenced object 0xffff888140bdd800 (size 64):
>   comm "swapper/0", pid 1, jiffies 4294683141 (age 2488.140s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000009569963d>] __kmalloc_node+0x10e/0x270
>     [<0000000037b0b577>] amd_uncore_cpu_up_prepare+0x41f/0x780
>     [<00000000b48a1e7c>] cpuhp_invoke_callback+0x40e/0x1760
>     [<00000000555aab25>] cpuhp_issue_call+0x18f/0x6b0
>     [<00000000b4dd3935>] __cpuhp_setup_state_cpuslocked+0x2c0/0x8f0
>     [<0000000066ebf481>] __cpuhp_setup_state+0xbb/0x210
>     [<000000000949b7a4>] amd_uncore_init+0x385/0x46f
>     [<000000008505629b>] do_one_initcall+0xfc/0x580
>     [<00000000192522a5>] kernel_init_freeable+0x67d/0x710
>     [<00000000613746f8>] kernel_init+0x18/0x160
>     [<00000000813ba43a>] ret_from_fork+0x22/0x30
> 

Thanks for reporting this. A fix has already been sent and it can be found here:
https://lore.kernel.org/all/4fa9e5ac6d6e41fa889101e7af7e6ba372cfea52.1662613255.git.sandipan.das@amd.com/

It would be great if you can test it and report your findings.

- Sandipan

