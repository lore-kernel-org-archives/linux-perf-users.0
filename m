Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89761C74A5B
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Mar 2023 12:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCUM4f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Mar 2023 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCUM4e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Mar 2023 08:56:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9623332
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Mar 2023 05:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cgmal2ryzw8ZcFeueClCmCIsHXT4IxEQdK7LnxVO9b/vNy6/VDcMHnDUs+nGIluNk8v9wEk4bB9o8IIl+i0IvrO/RZ2zHDQTEmnd/4JrEuw2GbxuZmZnYMSpLWHtsuR3EE4Cs3LZtv8/COb/ceFqd8ZUoDzT1WFWUm+/ULCsFqyignWseEDi6/rkEArcobJiBbZNDSQOMl5+8xiZSN0GVAC8UphkpYf0Vy9S0dCmaZ8gCnozS6n3jgXNJKCrSC2+DSgAySbliaocjgcR+IYqTm9hse3mKSaSTrnrU2qpyYAoG9+tUjV9BtjlbZXJtNnk2H1Rnt1kxvtVLpyrxPPVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1A7fAFpaFevO5wNTHmTeD8XRI4tjDgaIOaSAAaBqf8s=;
 b=TkBrEdUOwbaAZagkUTmqgSP5RUElHV5xMviZ3ibhNOgg0polrPeVt8NDvaIP9A6rREfo6fIZxMztPivyyDEvkvcXg7G1PuPwdpITlZ6V+qIaZ+fvG41BgHs6LNwWzbuz6GiNsEBww+PPMUEQP1ZY6bzGTuF8Wuf+msorCxOPYkxf6GoX+iMieTpHD8waaPudKPERHn4YtFpVixJMPT2VBksFzT+Y9FaT847lrbMvITv3milntlRWOx01f/lfe4vB73SBexYC9RHH5Ep/jZpQLmBh+7/uodvijSnMEyzxY/nwDW0wlbGTUJqaQ6zikbIs38U9+/7GruYeve6yUjb+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1A7fAFpaFevO5wNTHmTeD8XRI4tjDgaIOaSAAaBqf8s=;
 b=mDd57tLUawJmy2dgIHeeTN6zd4EEvLsYcysbsbMVjm8b9ZiHFCRUKnbdkZoGrNn5HbAZUOigGFtnjphq2ywo7jArUF0FyB7akx7RyEvDUJ4Ksv7QWBpt6rsw1ZKXf4n0BdL2ywDXkaYC9aPR72vrDs3Jue53yltHJh1cV4kIjQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:56:29 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::68c:afbc:72ac:54af]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::68c:afbc:72ac:54af%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:56:28 +0000
Message-ID: <ad31a4ea-8e91-dad0-7944-3893189b918b@amd.com>
Date:   Tue, 21 Mar 2023 18:26:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/x86/amd/core: always clear status for idx
To:     Peter Zijlstra <peterz@infradead.org>,
        Breno Leitao <leitao@debian.org>
Cc:     mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, thomas.lendacky@amd.com,
        linux-perf-users@vger.kernel.org, x86@kernel.org, leit@fb.com
References: <20230321113338.1669660-1-leitao@debian.org>
 <20230321124227.GL2234901@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20230321124227.GL2234901@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0194.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::21) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CO6PR12MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d01291-2fc9-49cf-afa1-08db2a0baf74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrthw4vA316DgwHJtB6kwq4inW06KhEotvpeUWY4Y9dsUAzvJh4a6kVdwcV/Gz6fGn9VPgwtW4PFvobD/MXr0OXX2HKiNtKd3/4fKYrNCc1BJ19FjUwO/dTVBdW0aYeGlYWvxgRpOl2FWReBhYaIwMzT2Rd1R6sWbYupUZyzC4M2fmifDpBsYUiOlz/mnfWdmCE3XUrg7JOkkrXaDn8gH6oKZD+aEWK0/L7Odyzsa2Chv7dWU486QmgKraWo6N4aX7pQYf4/DTtQbQe0mEaGwz9jSt0cDXObBKW7A65MrK/rD9DNpAGWquHPfmhJVZ+nODarfTi/tFptYhjGiL6iNx1pbcaa11/e559z0cY5V+KpaXyRPEoLObdPnv/6InFOtIwnW1TgQ7SrYF2i7ouTQ6KyrTyXX7c09AKtK1oVVdMdJnZ3AjNtBDYlFlB3cgq5hXaqsBepIknm3SLMZaBdGisZ+tHA8VhMeJXZd8a+GrU5/BuSDrO3n0BVFQBYatkbqFGY1LOW0jZ/h/NRljpIuN33SQRKuHqAM2ZKQC3xNV+FGXwbJzH4apJv379DA6KybyJWKFEVTrzalXD8PEsmnw65Hd4b9Oq+UyvVkeqVT/YRSyBI2Ns8yJoxMrd9RAczYzzIfo5PidsG7RlPwEpklJBnVgsc6BolTjvju/WhHG/C9NXfKF/abMww6SO59JioSs6D9kKwX6x5x7MdMYUttZAyLbTJiEZjb7QH+g/9k/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(4744005)(5660300002)(44832011)(41300700001)(86362001)(8936002)(31696002)(36756003)(38100700002)(2906002)(4326008)(6666004)(6486002)(83380400001)(478600001)(53546011)(2616005)(186003)(31686004)(26005)(6512007)(6506007)(8676002)(316002)(110136005)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVOYlNJT3NnalJUUDNaOHkrbzU5eHZqdDd4OXRYQkticVZSdlQveWFTYm5p?=
 =?utf-8?B?R1BuSUtYK0cwNUpFaW4xQytmdElJbWNLdUQwQUc1bW9VWHZYdFhiSWMyR0dG?=
 =?utf-8?B?REVyRWd2MHJZUEhVMStxMEdxd05vRXlqK2tFTU5QWmxlb1A1QnpRTEdFR0xm?=
 =?utf-8?B?eUx4ZmlpRXRCRXZ2QWd2RVd0S3hVRjRrbXBnNGxrTDMzM0t6ZmwwSUN6Qng2?=
 =?utf-8?B?MFRhcENWc01ISjBWMThVZVlHNDkzeStvRjN4WUIzd2lrLzYvZGxGUGFGTXBE?=
 =?utf-8?B?WjU0RklxdmRtZ2lnS0dmL05kMjVqcjJaWDExd25KZGVUR2hkN3M2cEVXdVRk?=
 =?utf-8?B?SWU2dVAwRWZFR2ViakljaGlEVmpZQTZJbzhOKy9VRnN1SDJobW1PUlRXVExq?=
 =?utf-8?B?bWpCZmxTQ0ZxMi82ZUExeTZqYlVFdGNKTUZGWE85dWFxMXNsejBPR2h6QnNj?=
 =?utf-8?B?Tk55Z0c2L2RkYkJ1aWZkT3BhRVBWMGlxZm8rbmRqeHR6b0ZPejBYZmI0TkhE?=
 =?utf-8?B?amZxL2NlRzYxZkFQcWlRYnQ1OURZeVh3S0x3c3pHTEZIZzFKb1UzT0hXaW5I?=
 =?utf-8?B?aXB1UGM2cnVtcmFNbFB3UXpLNm9nNzZxaU1jN1BBSk1iMUkvdXJZeS83RjVr?=
 =?utf-8?B?Tm91WS9OZjFDY091a01JL0U1YjdyclNROXhHaTN6c25QT2tPWU5odk90eEpK?=
 =?utf-8?B?d1BVMmNrcyt3RUVEVi8rWXp3UVdmbEJLVzBBam1pY2JVSnNPRWhVaEpISEdj?=
 =?utf-8?B?WlQ0eXhSbUpoTjQvYXUyRmc1YkRqMExqMWt2SzNRRGNSblorc0xPSUlLamRK?=
 =?utf-8?B?b1FWbGlQOUVyWVd5dXp1eXNSVzluVmk2TmJlM2wrQXlYNExoellybVFMTGc2?=
 =?utf-8?B?ZFJtdElXbnpPc21sTGozWXQrNkNYdkszdlBoa0RKTUl5SDdKNHAvZ0ZBelNT?=
 =?utf-8?B?bHpoc21FTUhVdXI1SkJ3bHJSb2prUXliUmV3YlpZbnRWTjJRTDB5TDh4T0xv?=
 =?utf-8?B?R3RKLzhFazN2QVJuTjNXbkttNjlJZGRLOUc3cHE5dkZVcjlaK2pFMGVLc25P?=
 =?utf-8?B?blVjNHpvS0lzb05zTURPTzlXeU5xdGxsS2xTOWovdExNQ28wTnBHMkFUNERl?=
 =?utf-8?B?R2V0bDR0d0RVRkRrWHJXNzdzbGY0QTZLcHRGSjRDa2haclgzNnhwOHZyaWlT?=
 =?utf-8?B?MnVXaE96TExNNTM1SGJBNHFoTVlyU1B0TUpkcUtDa0Q5NGpiWkt0MGJ6Rm1v?=
 =?utf-8?B?UWMya2xBbmRGaW5ZaDBOQ3BBSFdVazJLVzhGbWNCelJQanFKd0JiWk11OFhi?=
 =?utf-8?B?RW4rV1dZczRlcHFXQjVBZUhpNEthQ1BMbEtSZXZtdlNQd1F5dnRDUmczQXRZ?=
 =?utf-8?B?ZzM2OWl5TEpWbVBOeVlBYlJqRk9odGRlVlNBT0llek5ERC9WSWxsMWszOWs3?=
 =?utf-8?B?TWdUbTUyQXh0blhVNlRNREwweDYyV3VhN3lLSzBxWGlvYXZoUzFDZjNVZHkx?=
 =?utf-8?B?SmJnSWJrM3I5THJEcnNTR1F1OFA0SGVlWW16dTQ2V0E4NloveUx5TEFBR3Mw?=
 =?utf-8?B?KytuOTBqbVBzUWhqY0MxeHh1VEVJenJFMXlnbFhHdzdBYjRkUGNqTGsxVDY5?=
 =?utf-8?B?WDhWalc1U1prdVIreC9MOFZML1IxNnJFTGRORVBXdlZFalZPRVlkcllYTHNQ?=
 =?utf-8?B?NU1mWTdlNEpmQVNOcFdUVW96WEloSmR2dDVvdFp2a3IwRHp5RCtEMXVTVWll?=
 =?utf-8?B?dmpNeDMrNDJvcmxtUm5jS2xoNkhKSGxHbWRTRmlKdlh5U2pEVG12RHArUjZT?=
 =?utf-8?B?bENNUU5hSnE0T0dLNVhGOUpKa2NncTZqa3VzZVNjTWJNTk5VZ0owYWxuT3RI?=
 =?utf-8?B?aDdsK0F6TFR2cndDV0QrZVpjRzQ3QlF1T1MzemJONzRETkhKZTNoMWN0a3JT?=
 =?utf-8?B?dEhuSks3ajhUeS9EWEFhT0pUWWdWZWwrclVJUXpsSEdyWTJhU2ZOMkdEVmNP?=
 =?utf-8?B?SWswY2IxSExYS1didVZDLzNqdXdETDR6NEE3S1ZNRVpXK3ZJUDlYdmFSbzNy?=
 =?utf-8?B?c3Z2b1Q1T09DeFB2aVZqdUhjQ2ErMG5HeEhNRjZQN1ZtZTR4eVFHaVBVTy84?=
 =?utf-8?Q?z7cBUHK7fbFCUZMWOSX825yIT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d01291-2fc9-49cf-afa1-08db2a0baf74
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 12:56:28.3785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iQjezty26VTLc+Jjzeb0fv6Xl7YPlGxRWuN1WQGjWtgsGG6d8clDg+BZxcLSaaOFDVL3LCeD4vB9Ilm0kopxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 3/21/2023 6:12 PM, Peter Zijlstra wrote:
> On Tue, Mar 21, 2023 at 04:33:38AM -0700, Breno Leitao wrote:
>> The variable 'status' (which contains the unhandled overflow bits) is
>> not being properly masked in some cases, displaying the following
>> warning:
>>
>>   WARNING: CPU: 156 PID: 475601 at arch/x86/events/amd/core.c:972 amd_pmu_v2_handle_irq+0x216/0x270
>>
>> This seems to be happening because the loop is being continued before
>> the status bit being unset, in case x86_perf_event_set_period()
>> returns 0. This is also causing an inconsistency because the "handled"
>> counter is incremented, but the status bit is not cleaned.
>>
>> Move the bit cleaning together above, together when the "handled"
>> counter is incremented.
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Can I get a Fixes: tag so I can consider it for perf/urgent ?

That would be

Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")

