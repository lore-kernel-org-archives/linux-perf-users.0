Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6477C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D0861100
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 11:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhIJLTF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:19:05 -0400
Received: from mail-dm6nam11on2046.outbound.protection.outlook.com ([40.107.223.46]:56193
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232613AbhIJLTE (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 07:19:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7SpzQEBM858a6ARAyO8zg+FzcLBgtavJoZA3ArMeng+RkIxsANzlhbikrdzCnNhrftGQFKoVtfJU/MGDQUAWanyQX9bUQNbhFnMOp3YHnZBFfqy4IYDL+ZnOgxfX76ZQvDZpp0d4HdQR3HapdODqjXE67vf2P652wPp5kZEj9WXIKcK2i1c11WFZbEfIlCTzOMNMMdiNoF9NoTOn6vez46RrUiVCfz5AzScDpnPJeRy55Ud2T1OVSx/QxHrAho/9yj0jQzQH0PKZqwhBjHkM6tYwtfTac5xpSUVW3sUACDyIQuBK4WmrioC705aQrIyne1XXxPK8cRQxf94+iWe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZrckAIluAAdkvqLWIuqZ6GrXJrC+EOj4iTAeWXj6770=;
 b=KDt0gBgst/dJsD2bgSmkyVp+EZ56XHPPKxMUXZOy6mhyZsihSGwgkR/QEfzaOwKyk49a1Fh3aUPII4NwRa/CDth5XB4XJAknIbp3BxW+VAbSqVT65GlTL7u4uhAjxewoY/sOEsBt6L2fuYaVIfnE9eoTqWoGfJNMtQdM5AzBGpm9+/ipSkudQmmgwY3kASBxwBH8Hrd6SNf3FEpkXZDtlte85HbZNCgBCxYV6bjp3oYnj19ShckPIiVeGzvyytR577B1BhVnjYZkngc/zsr+PA7/Ym/g9DJAqbel6ZaxoOfI9+F5fub++M58sqKPPWlASf+IsdoJKA4dkEvXv2OvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrckAIluAAdkvqLWIuqZ6GrXJrC+EOj4iTAeWXj6770=;
 b=0ED8wdpG9OboZ3H+zGA/p+3WpcqbRgg66Yn9xpv9uKYriieHc2kZNrCSzYimQ6kVHGjyEzAKRfwVjXbgH+q0UIavRloXq7z3HgOpHwNgANdRUDsiEd01qr2ZTLRbTbE/1rgRZtPuvDzhSKHNjXZzIdnQdbAGd2mnNb6SjoXYWHA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2654.namprd12.prod.outlook.com (2603:10b6:805:73::28)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 11:17:51 +0000
Received: from SN6PR12MB2654.namprd12.prod.outlook.com
 ([fe80::2d6a:be90:d87d:2ef8]) by SN6PR12MB2654.namprd12.prod.outlook.com
 ([fe80::2d6a:be90:d87d:2ef8%6]) with mapi id 15.20.4478.026; Fri, 10 Sep 2021
 11:17:51 +0000
Subject: Re: [PATCH 2/2] perf annotate: Add fusion logic for AMD microarchs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, yao.jin@linux.intel.com, namhyung@kernel.org,
        kim.phillips@amd.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ravi.bangoria@amd.com
References: <20210906105640.1040-1-ravi.bangoria@amd.com>
 <20210906105640.1040-2-ravi.bangoria@amd.com> <YTpveO0qqKFTaxTk@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Message-ID: <6a987cad-6c46-280e-f791-6c59b6628a45@amd.com>
Date:   Fri, 10 Sep 2021 16:47:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YTpveO0qqKFTaxTk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::18)
 To SN6PR12MB2654.namprd12.prod.outlook.com (2603:10b6:805:73::28)
MIME-Version: 1.0
Received: from [10.252.93.92] (165.204.159.242) by BM1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 11:17:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a20508e8-c664-4979-c2d2-08d9744ca0e1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4400BADC90C5E00F41774AB6E0D69@SA0PR12MB4400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6wh/Te8iOkleSvjgsCgEVCnK8BMwvaW9VJfR8V8WZlAcO0H/ChGnxM3pS/K9zrcU2R6pBvGbF8z3K9nmj8eMgvtaNdFYHe2V1BEQHUrO+LGWzAKO5LTaQUkWKABRedKu/pXDZ8osnQ27H6jDu8QRJVkq0BQXuuoWUEWqG+rsO/J7DbNDtE+Foo6t4B0mHRjBhjLzWv8T+cOXFwpZQOdYjeT7UsgzwrQtQrVlEbKSt5E8YIktClllww3JKh9MvNwWcgmtQaMF9ZhJh2RHRwqCTTrrj5k0vbtce4/xkL3Inh5EuvSZga0CQ6vnv3MRzcsd2KZuwQ/skxF3rVyhuYVxalpus8+/NzjF05Qiuo5DEsyjDEwmS7OYGUQAOu1MLG7/imKYFGiKH9T303YQUL0V/CZVYkZuOZUsgfmM2VeNI+nHY3HBVRLnLsCmZMK6qf8wqD+LBNcOK47JISHijZiaBjm898sNocsW5mhxa45+0H+Cm5VYCQ7+6/1KL3PjQeu5pg2EvPi8c+Q9K/zXAS83C+FgQOJXKkYXW6yXZhELXbIXtoIyPvWqpfdYgJFL5ogjyQwQIjaUOkdfitxT22RLHbyd4MjBgO2QtDrzWYNVGzBgpB9TbjnxrcecfYlrCa/oNYRZyzpu9wJ5QDQPxnVIko9fLXTAjNZUNOJ4PWcXOkIluBo+xbYvdB+2Lyzod/R5DWsozn7v+7PTooMrljniRRkVgOOd5/rcNtQWI4UUeE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2654.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39850400004)(31686004)(5660300002)(6666004)(66556008)(66476007)(2906002)(4326008)(2616005)(66946007)(8936002)(36756003)(38100700002)(478600001)(16576012)(316002)(26005)(31696002)(6486002)(6916009)(186003)(8676002)(44832011)(956004)(4744005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzk4R2ljdHRDTEJDSGNoNEJ5ME5iR2pvQjZhOGltYTBMckJRaU5KdjJLNkQ0?=
 =?utf-8?B?cXUyU056cjFMT1A2OXMwOEJBVTY1ckVZNWd2Q2wvUkpjSFpDbDRZZWNkeEhL?=
 =?utf-8?B?anlUUnRmc1hFb01ocXhsdE1pRTBMZ1dqZ0ZaVGRTeCtqMStMaVoxeWUyRTBz?=
 =?utf-8?B?b0lvSjlKcXFZT0UzWm91VWFGY3hNelU4NGZ5NXp3V1FyZlcrTGhhS0dHV3Rs?=
 =?utf-8?B?dFpLUjFOd3RvOGI3cFJlaml2TEU2TlNQUEdsNVpnTXZpdWQ3QlhtOCtLQkE2?=
 =?utf-8?B?blVNSHVRMDdXYjlSTThjYlkyVVBNKzRnZk52c2NNU0VhZVNCVWFHRmxpUURB?=
 =?utf-8?B?N3ZrczBmUllGWkR5b3JsTVV6ZTlKcmpHdXkvcVpNS0xKZWFNZkNKZnlUY1pa?=
 =?utf-8?B?VzN4emZxU0l3UEdmZU9HT0Y2bFhybHVROS9zMFZrcDR0SGVOU3piNEpCNVB5?=
 =?utf-8?B?WjlyRjJrSWF3ampialRraTRIckxuaUVnekxMY0srVCsrd2dHOHM1ek5hdlg3?=
 =?utf-8?B?WFozQlFDS2VMY2prNmhVYlBwa1ByQmRGcTBDNVNoQWxUU2I3NkxUMm5RaHp1?=
 =?utf-8?B?b0VNMDhUM2QwcFRMYmlPQ0krWDhlclhVQkdOSjdNUms1VVl1S3k4aXk3Uk03?=
 =?utf-8?B?bkhRYWE2WUNUbVZLV2JleEYwak95M216S3g2QTdVK0U4OFlJTjNnVWVHbU11?=
 =?utf-8?B?dnplMDN0MHV6MU10b3FqMi8xU2FnemRpUTdoZ2NzY2xqcW9HeEtyYkVrbmFv?=
 =?utf-8?B?NDQ1aENZUG9vVmM3dUMwQnN3UjFkTlVZRHNFZHdrdGwvQ2RNL0NMaU1BcG1T?=
 =?utf-8?B?QW5HNWlPVWdsNzJKYVhXTHRQUDZGVXBBNkFreVpOWVhrYTNEZXl6TGZlZzlJ?=
 =?utf-8?B?ejlHbmhlamp0UVFScjhKc0RhVTA2T1hqSUEvTkhVYmcydG96NVQ2czJLY0dH?=
 =?utf-8?B?eFpzTmExYmJmdW9tWTN1VWsvZnBCV1lhRHdRakN3NFZMN0k3VGhHekExQldK?=
 =?utf-8?B?STVqakNNUENjZkZIUkJ5NXg3QklQMG9TdHIwd0g2dGF1cmg0R241U2xsZjRs?=
 =?utf-8?B?dE12bVJydWd3ay9QdFoxbFEvdUZzSmh4TFlUcGxQK1AwRVdIeGovdkgvdDRp?=
 =?utf-8?B?MDJvYjE5TktBRklVOFN2RkEwU2ROY2QzdzBEdnM3cEFOdjZUUm9SQytSeURU?=
 =?utf-8?B?VUhVeG9tcHJYNCszb0l1K2tmcUVJQWR2UmtOVlFxc2tCYzJMZnZTQ3dRdENt?=
 =?utf-8?B?cUMzV0t4QVJJZ0FPVkdtZHlCbmlpQ0tyOFUzckdZSE5oQ3k2Zlk0ak43KzFk?=
 =?utf-8?B?azdXVDJLb0FjdmFxN2EzYXpJTGhQeDltTVpDaUpTQnB1NVRpOHNCNXpPR1VO?=
 =?utf-8?B?dkhaSWo5cFBrTFJaTEhwS1EyN0FiSFkxNGgvVVVRbkZvbTZsZ2tRVlRCVC9R?=
 =?utf-8?B?dlY4anV0NWIzczBiQkN1eWpDcHBiVVV1QW5WSFZQbnR5bE02NkZtY1RNT1U0?=
 =?utf-8?B?bkVobnpQRlhBWllNS05tY0pYcW1FRldTQWp4aDFoNzNsMjVTTHR5RU1SdENl?=
 =?utf-8?B?OVl6alJmTWNJa09SVkJadGRJNzBkdFB5RkxIbjRCcW5FeGI1aHJDVWw2MGRD?=
 =?utf-8?B?VGtuekdob3pTS0t0WXdZb2M0U1A1ZEJ6YzY2L1FNWUp5Wlo5UEhqdzcrRUdo?=
 =?utf-8?B?UnMrajVoVTJCRjZkbEpta21Qa1ZTUVZlYjdaVCs5Q1Zpb0tSSWxiR0Foenky?=
 =?utf-8?Q?1VRW06t1Nq38/tmzrXlT3xLGcKbe4Pza/OWXAQ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20508e8-c664-4979-c2d2-08d9744ca0e1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2654.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 11:17:51.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0wgg3zsYD/55dMqwyCobabXbSFfGBev89J67r5DmD4exmTaX8v56sT6/4TWJW1gaLYLrJPa2hUEX2t34mL0jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


>> +static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
>> +			      const char *ins2)
>> +{
>> +	if (strstarts(arch->vendor, "AuthenticAMD"))
>> +		return amd__ins_is_fused(arch, ins1, ins2);
>> +
>> +	return intel__ins_is_fused(arch, ins1, ins2);
>> +}
>> +
> 
> Can we instead make x86__ins_is_fused be a pointer and instead of
> storing arch->vendor we set it to one of amd__ins_is_fused() or
> intel__ins_is_fused()?
> 
> I.e. here:
> 
>>  static int x86__cpuid_parse(struct arch *arch, char *cpuid)
>>  {
>>  	unsigned int family, model, stepping;
>> @@ -184,6 +216,9 @@ static int x86__cpuid_parse(struct arch *arch, char *cpuid)
>>  	if (ret == 3) {
>>  		arch->family = family;
>>  		arch->model = model;
>> +		arch->vendor = strndup(cpuid, 12);
> 
> 		x86__ins_is_fused = strstarts(cpuid, "AuthenticAMD") ?
> 					amd__ins_is_fused :
> 					intel__ins_is_fused;

Sure. Will post v2.

Thanks for the review Arnaldo,
Ravi
