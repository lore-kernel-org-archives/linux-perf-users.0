Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1D2C7618D
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Mar 2023 11:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCUL5P (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Mar 2023 07:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjCUL5N (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Mar 2023 07:57:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B7338670
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Mar 2023 04:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB+lP4uheD3pR3/vtwJzwC1YOeubR+xwvB0ZaHp6ivUk3ZPMICu7V9UgjPqFJFuDcNx9CO7OE2T6A+jWoFUW89gvkSKdAMcpXt0HqzbN4TVMUH4CAkci9sGXPK1ALOhi3/V/XSf3F+ExLDT4HsMPUkVTaZTgq/WunmKP86/ZiHIcbwTMhxNh9rV2G6FcnzPtzTdXBN+ybHCrKXCumVcpWI2E/c5wSN22+lqSXZgeDRMs1munsESJIaNraYafhy2TTzsVyxmrLe4XpT6t8FMuIyIxFCoyVr5MI1NjC5btn86MXajdvTe8oa32kzvDiCXAcw+SIkNo1TzTmLhnazxo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrBrideWcmsZQZx+a7cL3nX2zDpyIEnWU+Wo3Hnw6Pw=;
 b=mc0IouuK6UWixahdzIPXsJuwb1/52niM8iPezydah5I60qpsO0t9ybJnMk97PKSeoa6Khd1i4NGato5+iAnQrhmM/w3FC+mHjQnX1FqErJ90P+F+tivrRPa/8HYd3Mte8YkTgv0B/xFBNN6OQMLd3PaEweyF+071nwyXyosw+BU4NQWhxCSWrER9uvV9hA+JPdK3qgvg9XsG7UgWWD4CKADwmeoCp5Q0jlPWRfZTCRzK4vrTcorFSiJqvhtTGAYrU/a+aIhSGJHShifcqExEECqwkUVLnAa82aEc/d8b1UMumxFGE28jZpJpOw9LD+1UUkH5xTIBJHjbLexePs0geQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrBrideWcmsZQZx+a7cL3nX2zDpyIEnWU+Wo3Hnw6Pw=;
 b=wuoqvzOvYInmm0irwiOGHHEffWO9AHeDwsUrd/+sHl7DO9evIhkUwaaQFty2yk6XZwAOfU2uA5L46Fy/GBV0YWDzLT2GvJi0gRfX1w9VglpVGSWho34x3RPsW7y9oLc5tTpcsZVVIER+qrunoi7zAPtgwddXHbP9M5ceJNl1qzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:56:53 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::68c:afbc:72ac:54af]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::68c:afbc:72ac:54af%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 11:56:53 +0000
Message-ID: <e1678aa0-abc1-a379-3e90-1894c77109e5@amd.com>
Date:   Tue, 21 Mar 2023 17:26:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/x86/amd/core: always clear status for idx
To:     Breno Leitao <leitao@debian.org>
Cc:     linux-perf-users@vger.kernel.org, x86@kernel.org, leit@fb.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, thomas.lendacky@amd.com
References: <20230321113338.1669660-1-leitao@debian.org>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20230321113338.1669660-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::19) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: d62912c5-3421-4247-28ec-08db2a035c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rm/H+/xVV2JJTCSrQp9mizHK980jOK0m2/e5m82/GqKJMNfsbZWj+mE4xAViIjqx95H+xcn1Mm8EOySLxLptWaFQcYuFboROondCC/l+He5lyoEPQpwQyib2D8i6FLrWW345Qn/jJUrsvLaX2Mt+FVyyMP1ZR6fqIc4eqAM/BPoD+ZNsAfz3NUldCLSj/BpFMiYnGaEUHIddF0m5yhqtXYXSl+rCS81m3HSkqA9pbYqZwYmb3wmGryVdvY4PXGLcOWDZj/W+uEMjLD6o3868i7ROMm8xOFW8OZVFnGfnBOJhZ/ITdXwm+lrp0C/sPPA//8FsoOlYGciV4/Rp7vR3TkH+moH65NTwguPPVusf6e8MRnlCHFUpxud/5o+L/YXL/2P38AeeiY1vhxBS4ufPCHZJFUtEjshpgz9oLK12wtCA8AK4AnJfr6atOajryFgHa5PRLcjhurzsb8mkZLqHizm8rm5DthaacAzHXimlPDqgwjmZ2VR7s17up2Wei2SVxdKA48nZR8O7xt0W/fz39pzAjRu1iAbdMoYSEfflBzw9d/LsKbIAbJm/wf//o3HmYPM9mmWGFRdV72MlRPJ1gwgoDYikqOB7bCbPv6ixu3AXL3oYdkkmvm7wIENYHYVTpPJITEKoL5bh89Tx74bK3/O3QZqWixQ1EiD1fhYy4L/nBi2Y0c9ZeKKWnr6R4kjxUf6GLqwkXMjfuricV22wrHNVXHTuTgbwe/2TH4BEJbo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(6666004)(186003)(478600001)(26005)(8676002)(6486002)(83380400001)(6506007)(6512007)(53546011)(31686004)(2616005)(316002)(66556008)(66476007)(6916009)(66946007)(8936002)(5660300002)(41300700001)(38100700002)(4326008)(2906002)(31696002)(36756003)(86362001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDd2R09vUnBHN29VTjNDMTVHRWNXM2gyNHVJMTZOd0dKODU4R3FIQngvWFJ1?=
 =?utf-8?B?b1dmRjRMTHJvREQ4bEV0c3YwdHliS01QaHpwN3kzd25JOEtoSnZyeG0ybitB?=
 =?utf-8?B?TmVKSnh0dlhMMjVHL3luV0drQ25uREk3aW5DTHkwZFR4OWFQSVFVUUpLM1NM?=
 =?utf-8?B?SXVUMm95YTdhWHMrMVNxUHo5c0JTZXk0TWNaSEtZbkM1YWVDazFOU21NMzRx?=
 =?utf-8?B?Qkk1STF3b0JEWlh0Yno3T2t1VnNBOE1qT1dNcjhLTlVEWGtzMWtubEI4enpF?=
 =?utf-8?B?cDZpaCtZUkpRNnNwYkYzSnlFRDNxOW9MNnExUTMvcm1LMEphWDg1SVNldGRU?=
 =?utf-8?B?Ui9NSXNpZ0s3bjY4bEFRYjQyRGoydnNDODdxeDBUckZCdE1LR3hyYTdqWjRV?=
 =?utf-8?B?WkltWlV4V0dhbUxvQktmUlhQeDUySGd2djlvYmpibyt2ZGFoYUI5eFFZeEV2?=
 =?utf-8?B?b1ZIRy9iVEk3T2U5cExvbFU1Qkx5TVNnUFZXcVQyMzRNSHFQV3ZyZURSOXR0?=
 =?utf-8?B?RVNocXZybWIvMUZqUzFQejhMWS9lTGI3ZmpGVmc3QUdFVXFtbzZmSXAzdjBW?=
 =?utf-8?B?UFpoYXFHVDJJTkxGZVpzOUtQdS9WZ01FNzAvWHoyTDcrenJiMnVjc01yUS9I?=
 =?utf-8?B?TWtvZnAzM283RzRXZGE0MjNqcmJCRFcrZXFpZ094T21jWW04bmdWUnQ1QU1o?=
 =?utf-8?B?a2hjYzd2dXp0NzhPcEdiVU40ZFpWUWp5ZFp0SWU2TU1aR3M1cVFvNFk3OCth?=
 =?utf-8?B?WVNWK0R2dHpacW40T1RsbWJUSDlpMnV4NjRCb1hqSUlXSHVuV3FDUk1ZdzRy?=
 =?utf-8?B?eU0wVmtKNk85RDBHdUZQUXNBUGo3WWkwelRtRVpoQjkrNlVUWVJEU29ZekpD?=
 =?utf-8?B?YkJjaG1JT1htK0VCbWxmYmFKZUhoNTVTekdtUVAxU25GeDl5SDk0TitJSkxH?=
 =?utf-8?B?MkhXcDRscklINlllQXBsZFlxQ1VRZ3U0aFY2T1I0bnd6blVSTTdWZFlqSytm?=
 =?utf-8?B?OEZLdGVjZy9hcWtWYSt5Zy9rQnNTVmNvaS9Nam4vV0VYYnIxemJ5cDJjdGJU?=
 =?utf-8?B?bzlacjhEZUxnZE1xMlE3TGpucERnSWYrd2o5QVpyclQvc0hkRnpKUXhPbXlY?=
 =?utf-8?B?dVZ0M0txZWpYL2F3dXp6cStKcEh6Z1FYOVVuRnA5T1duZlY2OCt4SmdlcUdX?=
 =?utf-8?B?Yk5FV2tGd1JGb0lKeWI3YzZkVDBHOGVGZzVnek1RZ0xZbW1DdEF3NU1JV2x0?=
 =?utf-8?B?dERqK2dxMGdaNEVpeTZuRWJKWXdCc1F6K0FORzRFVU03L1BwNnBLWEEzZ3RE?=
 =?utf-8?B?YVczSGZ1WGN1ZjVRUVRlMkJsVnYzbHVuLy9OS1ZwUkpuenkrbVgwY3Zlc21K?=
 =?utf-8?B?YmxiZjJoYkZUdnJjeUJWcWF2b2VHSk1GV0l0NnBpYzBhY2Nsc2VNa2l6VTdj?=
 =?utf-8?B?STZDbE8vV3FwU2RZVSs3T1h5U2x3SlpCdnRHaXJSUkZRUDJTTFVzMW5OTHFl?=
 =?utf-8?B?QVREUk5OUG1yTE1TTEdnUGRTalQ4Nlo3UHQydzZsa3lGVHBNdDczTkpPZUNW?=
 =?utf-8?B?aDNYcnpMeXZ6NGtZQkpGNTFFRU1VK3Zsck9vREQxMVpZbzJJNWgxSytHSm5L?=
 =?utf-8?B?WDZFOE9TV2ZjM0pZcWtkQ3FjS0ljMG1pcVBRQnFQdUFiWE14WGs5K2tTbStM?=
 =?utf-8?B?SXRDV1hTTDYzMHgzUE85ODlLS0NObWE4cHlVVXdpcnM2WEJyakJFQk1VVFMw?=
 =?utf-8?B?YUMvMWdVVWlRWlhhV3Z2Z3FFaUdIcmR3ak53bGdkZHlpYjhkUDRwUGtERkht?=
 =?utf-8?B?d21yU1JFUHh6Y3JoeDJzSUV2b3I4YVB3K0xvQlZ1clp6UkwxS2dCYk10aFBH?=
 =?utf-8?B?My9RZjZKUnpkWXVsTG9iYnhqTVpORW95YnhBTDFwWmZWWlhLKzhwM3BWOExR?=
 =?utf-8?B?Mkcvbm91Rk9wMWhuNysxVVFIaG04RE9hSkNldDFnTnFtRjBjSWo0QnlSZjVi?=
 =?utf-8?B?VFBmdzZPWjdTdEpmVUNzOGMrK0ovVmM0QkplS3VacDZnZ1BqaTBkZk9ObU5F?=
 =?utf-8?B?blFSS21FbCs4djBzdXFwV01QRG9pR1FFUG8yYzRGQzcxNmJvYjZHM3pQb0Jw?=
 =?utf-8?Q?J22JMpazG919yuqEvp4r6oH89?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62912c5-3421-4247-28ec-08db2a035c8e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 11:56:53.1489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0wUsWrqqnR7qrWa/wNba9H5xdtiXTq0XGGSHuoc5ihIGHaMUGbKbilfSZzYyqt1mJ7BVbAbw5fj79jBErZRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 3/21/2023 5:03 PM, Breno Leitao wrote:
> The variable 'status' (which contains the unhandled overflow bits) is
> not being properly masked in some cases, displaying the following
> warning:
> 
>   WARNING: CPU: 156 PID: 475601 at arch/x86/events/amd/core.c:972 amd_pmu_v2_handle_irq+0x216/0x270
> 
> This seems to be happening because the loop is being continued before
> the status bit being unset, in case x86_perf_event_set_period()
> returns 0. This is also causing an inconsistency because the "handled"
> counter is incremented, but the status bit is not cleaned.
> 
> Move the bit cleaning together above, together when the "handled"
> counter is incremented.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/x86/events/amd/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 8c45b198b62f..bccea57dee81 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -923,6 +923,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  
>  		/* Event overflow */
>  		handled++;
> +		status &= ~mask;
>  		perf_sample_data_init(&data, 0, hwc->last_period);
>  
>  		if (!x86_perf_event_set_period(event))
> @@ -933,8 +934,6 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> -
> -		status &= ~mask;
>  	}
>  
>  	/*

Thanks for fixing this.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

