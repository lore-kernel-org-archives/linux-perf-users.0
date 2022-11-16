Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77686C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 06:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKPGCd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPGCc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 01:02:32 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FD822B09
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Nov 2022 22:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/yqfIGa1IGLNjZqC0bDbFUVlDVAhp8+Zy2CdI35hqsXBIT6Xg9ZRGw8bCoUKz6zjmzjVE7UfviQG4VNcJH6eP4x3GehgvloFPK2GLLZZkygL5S/isE99n5hwAWoLACfDfhjs1nxcSrdJHs7DbdfSuTtCnsDKGruIob8z3+UtF766YK5Ywnu9EJ3X5hoxHEJoY7md4OSO9D2019zjadsa/jR+J/Qda1ZrCkH2Cg9S2xDTi637yOsJnUBipuRKmNQeLNEA1E9SmQhGoPEBXd0f2ORhF7IT8gXLSAhG3fGOoYOiR/ZysvsG4mKjE5fXqXCrqI1FpLJMTqmK+utf8Mggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mBfIquZoog9VAgzqjwWbguDYODI6FjwhjAYNRi8zTQ=;
 b=Rt4dIM6E7RRCx6Vu86kA3xjIKQ+rkHZ1litIeeZwzu3Is9kK7yo3nUkPiDObwZJ0rHnjmhspi6D3AUyvDmMBDqKsUo/cvs8OGWK6HchfbkuH2U2HDIAUw1ssJmaKl63Q157JuwSP9jATiNL7G9mvNriCmNIOiZVxyl1pATKU3lKcWItJxCu0ciQjuEJleoSZgUXOsNkBlRy2mb5OWZtQdaKOGcQiIH6b2heTQV9uW7i7AhWvTBgTSOrMA05Jj2Y3UFJ/NslNbXcYPRLhiVztZ85V4WrVXRi29in7IFULgbtix31O+BpSjl3L+UThEN57hw1qSDCISyzwfBO+5IqEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mBfIquZoog9VAgzqjwWbguDYODI6FjwhjAYNRi8zTQ=;
 b=jdql0Pbf5KOF8HW4NJyjoa3Z2QLbcGmAmJiXUaS4eYzvWoAAgG31GfEdUvQKzYx1Y93mUqG9bTb2CFwHgaelqF7nLe1VtPJET2keiodRP7ER3Jj082zHNw5/kK+XFgDqYuVgWRvbjgdSf2Ju8gtZ+VUNlB4Kj0SuuM2iu1aWY6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 06:02:29 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%9]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 06:02:29 +0000
Message-ID: <3f4cf4a9-55c7-2d47-19ca-cc2edadf95bb@amd.com>
Date:   Wed, 16 Nov 2022 11:32:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [bug report] perf: Rewrite core context handling
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>
Cc:     peterz@infradead.org, linux-perf-users@vger.kernel.org,
        cuigaosheng1@huawei.com, Ian Rogers <irogers@google.com>
References: <Y3OKQ/Rwm6qVyG3I@kili>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y3OKQ/Rwm6qVyG3I@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dc529d-ad63-4ade-e0fd-08dac79823c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RN6OwbHXJ+yj8Mu1Jmqvv1rPgF+fdbGibtfmhkcaLJMN1camN1FvQyMvKENZnmJBAcAq9uyYLieiRnmDc77n72mTf/8ZZ4s3LJ1+lUqtvzGrXwLIryWhphEffwoqwpsCxGE4kAHdEzmgaFTEqlMHi3sfJr14MQzZyvHkWwzyqZUmf51Ze1xmI4rWe+hxxKc4byBX61dxo/zyMTX3EDoXjhqhKCTHNqardhlnEcvZaQFHmxcEsnHMwMSoqI7sau5/1f9LodKd+uiacSU4gp5OrblnSFOccZMTs/3hU9z3RCGitEHHK1+/hBt8OuLMfwBdYLUe5V4XxfUwIZ7iV0Q4FC8GVtgM/IulD6QczxAVifOgSYD6IqAIZQKj9aaLR7Wh1fQkKLR7nDMjPQxj5XIbLxJaKXAO4yRRAwG2xRRIQuz+ph2APRhK3C/4pJsV9ywe6wsodLbSd/SLUwmqq0jihIwNscMA9s5U2kdDOYLCDxZrScnrPzG5PvHoHWqJ0WBvlpoM3aRSBo9oMGlNb/6dhS8YkkGpGnqB0SCfmo7vFUZJDUn/aphtLtu+7qVbGNWlkC6zuWcGZ4LW5djkpyNEfVmbuzUcam+20R+jDGVOEZoTIVBIKepCn+wPZFD+cYvL1G/xzXX/0/KqcHIQX05jD5aVGdMlilEricOX3Yukz6u29MGE6PbY5YCuQODJmfqr0CbVzZSWzufXxTFpHYlqZ70YxR64igZqVzdbrzl4vwPtXgMOPK0sYswM+QnDKCE/VE1GK0FIR2FizIDkBpGOMsKt49PvmDgF91FeHub0hwEdciKUhHAumad9y1a1QyopP9gPpBkTdCdWROiVg4zPhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199015)(31696002)(86362001)(6512007)(316002)(66556008)(26005)(4326008)(44832011)(4744005)(2906002)(8676002)(41300700001)(2616005)(186003)(36756003)(66946007)(66476007)(38100700002)(8936002)(5660300002)(478600001)(6916009)(31686004)(6486002)(966005)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdCaG9YRTFScXpKMEJMSm4xQnF0YWtsMGdla0t4dDZWL0VuUTdZYXlBbU9a?=
 =?utf-8?B?blN5Wkp3N1o4M0dKZmpSRWNmMzUzRlRqa3BhV25pYkYwYkxEMXhtdHBLZkJk?=
 =?utf-8?B?Sm1WRENpUUhFYmFFYURLQS90QVNQTUFQdzRqdngxelQ2cmJQYnBpSXhSMURL?=
 =?utf-8?B?dk9yK1Q3ajV6ZGVxMHpZOFhwYzlOVFR6SmhWMjlMQmxQVzZyWS9jTHROYklD?=
 =?utf-8?B?cnlTcXpyWmtTdWl4blgyTExBc0xnWFVUQ2ZMZVV2aVhWUEc0aTlmeExab0to?=
 =?utf-8?B?NnkvbU41U1dhUUt5WHhlSlQ5S3R2UkdsWUxQRGRNVUFRSExQbXRmdXFLZ2Jm?=
 =?utf-8?B?MlVaMUc1dGVISzl0Um1JWnRFNS9jVUlmM1VNR0U3eWpWcjVKcW5nblpmY3M5?=
 =?utf-8?B?NWVWS1dJWGo1c3pndWFnUHlVbHgvTjRQR09Qcy8yNytBNUw3dTRjNTZHT0dv?=
 =?utf-8?B?YU1GTzZvc3RxTzZlNW1OejRUK3RZb1lYc2d2eWVXam9sMmhYTEFhT3Z1bUZ4?=
 =?utf-8?B?RWh6N0QzSDVJTm1TbEZPTVJFa2Z0ZldCTFcxdnFyalZta3d4bVhUVVBXM1dq?=
 =?utf-8?B?WUYySitRQW00Qm55bUdCTWx2bTFFWXVvd0h1dzF5aUxMMlErdmxsTTVNUWgz?=
 =?utf-8?B?YWJTVCtpYnE5S3M5TVpNMDRpbjBGc1dEb1JKOW55WXdkTDNaa1Q4cXdlaHI5?=
 =?utf-8?B?emdkM09DQzM0Y3VOdHhaNHM5ejNJTXltSS9qZ1YvZ3loaUExU1VjdjZjbGpa?=
 =?utf-8?B?NU5oK1I4ZHVjdG1zbCtXamlLZkd5UjdsZWFrSHp6QkpBTllkdEtOZGk1L3VH?=
 =?utf-8?B?NUFZVVd0bGY0eDh5bDcydlZiS0h3K3VsYXJwdHorSnIvRWhGSjgwampZS0Fw?=
 =?utf-8?B?cDBoMHNuOGxJYnVMeTlDUTQwWnhyR3RmajBEMEZwY1VZYlMrbmh5WFNSWnZ3?=
 =?utf-8?B?N2NMWm1OTXVwY1RpRm5seHFtWDJCdXZSTW9WSjc4RmJyVitDV2tqc3E1TTlB?=
 =?utf-8?B?Ylk5VWFJNHREZU93WUNHRExiL1QweDZHS3gwYmFHSjNLMEk4d0o4enpuVDhD?=
 =?utf-8?B?d0x3THNudnFwY1JJalRDVjBVUmxTaUo0UVJlUjJSdklDTkU3Z3IxSkh0M3lk?=
 =?utf-8?B?SjNBNWF6OVRCWXFoUEllWnIrWlZ5TjJSeWIvZ3BvNzAvYk9kY2MxSENlZXJy?=
 =?utf-8?B?dUVqN0p4YkNLOWZEQ2d2eExoY2kzMm52STVYeGVDa2Z5eXVnUUY4bTdPcEVW?=
 =?utf-8?B?OWJiSmtLVk9SVzF1NFpmS25BN2JpcmtEajEvY1VoMlhOczZGZ0ViWnBDOGcy?=
 =?utf-8?B?TW03eDJvcFVyek9WeTJyOHNaSlZtNUYvZWwxY1RFUlVjMWdodHRrZDVDOHZw?=
 =?utf-8?B?LzdyWkRVd3pyM2JZeGJHbTVEdHhtcTVBM1hSTmgzeS84VXBRdzZZS2UvT1hP?=
 =?utf-8?B?YTUxeXJESndRbzRxTmVwaHpCQ3hIM0VNcHh5NUo2WHIvSHhEUU5FL0xMODdr?=
 =?utf-8?B?RUdVeVpCdFNaUG5kWEVGZlUrYzlvM1dUU3RKWDkzRm1WQjRlR3Zuc29pWUFI?=
 =?utf-8?B?Z0k4ZTNrZzNjTkovQzFQc1BkNzdyQzh0bHY5My9oUGZhVFFjOWF4SE9zVk4w?=
 =?utf-8?B?OFZuM3U5NGRGZWpQOExNWHBROVQ3dHAveU1nd3ZKRUpWbWJKRFpWRVp2WEZt?=
 =?utf-8?B?WDVLazJkeS8vMVJuTTRRKzhZQjh0QlphYm9rTnhJYmQxL0tUQzI2bDQzS0Jo?=
 =?utf-8?B?amJXOU1OZVVxbzliQUFtMlhCa1gyWTdvNUoxWmlYT2ZvN1UrL3VGemJHdnBw?=
 =?utf-8?B?cENOWGU3bDNobWZaVmNLekVLZWFoTmxYK1RLTCtHYWZLd2FIbi9NOXJoc2Uy?=
 =?utf-8?B?dXJYVnovQ1Q2RTVjWCthRlVibHdEOVlEeDNiMU1MWU4rR2w3R3hRSHYyczVm?=
 =?utf-8?B?dnZjdFUrMyszMm9yV2dxZnQ4QktkNUFLeFpzdzc3WnlHektSMGU1dkhBQTFy?=
 =?utf-8?B?Wlh5YnBwRnFMWERWd3U1Ykxyakt3Y1lzc2ErK0k5clVCWVd3empEdVhuQ1V2?=
 =?utf-8?B?OE1hZVRYdmdpZWdPbkMzNTRZNlo5QWltR2QxYmdTbmVYTlpLNnZqWXVhSXBB?=
 =?utf-8?Q?yECNilG6ZVVEY1dqmmBTq1imG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dc529d-ad63-4ade-e0fd-08dac79823c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 06:02:29.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wjeqf/cwxSV8q3deoQDmK+a8N7evseDRC0PXujY2l8etG2CTMCn8tBipJweNJSKnKOPImX8xEIwpLk6Me/JWKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Dan,

>     13168         child_event = perf_event_alloc(&parent_event->attr,
>     13169                                            parent_event->cpu,
>     13170                                            child,
>     13171                                            group_leader, parent_event,
>     13172                                            NULL, NULL, -1);
>     13173         if (IS_ERR(child_event))
>     13174                 return child_event;
>                           ^^^^^^^^^^^^^^^^^^^
> inherit_event() has historically returned a mix of error pointers and
> NULL.  I am not clear on the rules.

This probably needs to be fixed.


>     13176         pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
> --> 13177         if (!pmu_ctx) {
> 
> The find_get_pmu_context() function only returns error pointers so this
> is straight forward, but I don't know if this path should return an
> error pointer or NULL or what.  Probably easiest to just report it to
> you.  :)

A fix for this one:
https://lore.kernel.org/r/20221114091833.1492575-1-cuigaosheng1@huawei.com

Thanks,
Ravi
