Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C973DC4320A
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 11:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AD861037
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Aug 2021 11:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhHDL34 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:29:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12452 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237655AbhHDL3v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Aug 2021 07:29:51 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174BRLER023757;
        Wed, 4 Aug 2021 11:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=UOnqw1Uc7i4j4/WKuvB6NziTKDnUKA+RrAVHRw7HujI=;
 b=mQID0C7bCPHbSIJSelELLonrsZma+Yx58Yo8jqGTMdQCgqbIZxapSPMfQPz8V69mQWtW
 ouEbo55AeYdlXAq39GsYz8nnr4a6TL1PPnb/VH9aHRact6kPHyuP1J9AUX1IzqMjd7xf
 IyQBWat6mMLCfMAwIpPGJZtUgUBaX5tY8AgDGAupzSM6wChQDLhNw5qe+7WuGX7kpHBe
 fzjQKklk/72m6YWHOsDVak8j3rhsqzVR0bClkLq1JsjhMsmUjHw+nf0AYFKruEUATBMO
 YCgeR4nWUobFFKmV2K5OXmwjIAauI4742VRiYoxUppRfXx4GDiaYlX/oihcIO+I5ioBy Bg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=UOnqw1Uc7i4j4/WKuvB6NziTKDnUKA+RrAVHRw7HujI=;
 b=CTDXlMr79tLghdg8yCW5782CniFAZA5OxnueKr3p+5rdXxo6OtodDIi9tbsdhMh6eoDZ
 mxPJgcaZ/wmWTX3rP0RE3ytzu/7w0dMaldRSpGE6Qz1tihbMwfWHo9QF7cAu5/JJdmUH
 roCcM0ZFULQ6OWTJI7gYFCLIG61U/imf6S0Bx3GIfUDhTws2+Yo483Nv/nt0kQPuA1uY
 SCEP1XBLt3M/XV4wMuv8aJczyAkWdxjZZB2k4oZLP0Ejb7RuKKpXJyDGVBylBTNjvNBZ
 VOKAmE0VfVikm2mFjqDbx4oV1+5EyU+OqAi3FjdtQG9WvP0ikCXFVaHgAS6SoXjc3caj 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6fxhdp05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 11:29:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174B9vel041547;
        Wed, 4 Aug 2021 11:29:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 3a7r47ngg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 11:29:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI8+7V4Wh8v3M3k+muMXm5UxDsxS5cPYSgKGqoFnmFuRsEOw142wQSElEUZTb5UQkGrlIcEhqkobgZLTMxnoLQe/TaAKNcOJE8Co7NWHhi7iSWVWR6n0+c93AkFCRUnLVdmvrH44yXXZnAUwKTMOPM9V/W3O0Dl1s32GQEbgwK0qNalzTdjAWLunCi9Xr/Z3V6SwL1QpqyA9u1TVhBjIdNXBaZKsEW/uzmWqki0qrNSkNp3799kgCBYmhD0VjEte1XCCrYSRbZhH+23I49qob4DZIBGnrRxWQXBonziuU5LfqAPp3EdE2NsXomYR6lCLZiajanKK6ZlGtL/+qK/f3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOnqw1Uc7i4j4/WKuvB6NziTKDnUKA+RrAVHRw7HujI=;
 b=B7+4YO50WNdBqKCRmd8kX2rAF/U97OjLv2yXEQZNYCnbTUIE0gQy/riRWKMitDd8oCg5caKVIws5/xMGA5l5SFKlR4iDBsFQQCWDX3DkTBaNo1YRnF30nnrgzh5WNdYyMvttlZHPC/kEHWP/5qtuhefvEvTwouLgBcnkoPELPzRieZX0zuHbmuqwx7RZCuqa0lBLDJT6iHwknU+7jbq5D0DNmRj74OzrNmPQH97Unez/DvWgaLe9+8ewwK8X/fzxJ/RVB3MXeXiJn66l5ygLlYMapfbV3eRfb09mVG6chjMI681VdHB23fLn2VBX2mODcUlU6Ti2mOxGs/wkmtQFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOnqw1Uc7i4j4/WKuvB6NziTKDnUKA+RrAVHRw7HujI=;
 b=Vgl+XX5M7jPGrObs2EFVGObyvzcyMFm/O2/EC28vvABXwhzFgB5Nq0eQihj05Js1eedzjQeM9+y8FTam28TNWBJirCYD4iBKNOpKWQ4Ohu6XsuGwp6R0nLIxIUeXLI4lmEabJkg/DCiQdILD067SN11t5bTYAmsR/be7C2dL+W8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 4 Aug
 2021 11:29:08 +0000
Received: from BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::7c04:4d23:44bc:fa0]) by BY5PR10MB4290.namprd10.prod.outlook.com
 ([fe80::7c04:4d23:44bc:fa0%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 11:29:08 +0000
Date:   Wed, 4 Aug 2021 12:28:54 +0100
From:   Liam Merwick <Liam.Merwick@oracle.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, liam.merwick@oracle.com,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY
 bit inside the guest
Message-ID: <20210804112854.lmizhfddz3qgli7t@oracle.com>
References: <20210802070850.35295-1-likexu@tencent.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802070850.35295-1-likexu@tencent.com>
X-ClientProxiedBy: LO4P123CA0311.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::10) To BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (2a02:6900:8208:1849::20) by LO4P123CA0311.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:197::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 11:29:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb8563bc-1c6c-48e5-b87d-08d9573b1296
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4510E84C7968738B3AE85B55E8F19@SJ0PR10MB4510.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lV2fRO419HBF0OXA3OuxYB7sa2H7wrPRr/KHdWy/T9Wwevp2h+rkRblQmb0xP96GxfEHlDmSulAhd1kD9TQvajDUQxVdWyYQS3FYdV1eSCuq+JzMMKZTs1DifwM9Lt9xl5Papn6OKoS3awpjT4RiI6yh8nqXBarRruiO2Afw7c2lSmC3SjweLE9/xBLzb9gcV6WvcwugWkJ1sUelALRsnH5dGH+ASZkHF46uEiXVQ1Us66LOu/TsxdDaKHustXFMqF01/LpGEpQhZXMF5MsGHPVYttup8tc/gId3Z6TtPC0rLfCalmNG1+kxnOPRJYIsj23RS0kuBRIaJaTDhGf4ds23bnGccv4nC7jM4hUdYYgVl1Y3x1joXoYAwpYqBi0CG8Tj2wze7quy73lMDreBJjd58AX0C6xHaE8qnT+mMt1L7USaskjj8K9dBPVxNL3fYlKzPdCq7PzkmhVfS3oi8CZAyyMAn/3zMQ8GLwfEmc060ZY65ATbuM1fgv79Ihf7mf3muYZf8MdVF9RDnPH7K3hBWhVJtuIhmBsUaIC5xOBt9hhFd9YKD9tP3YJHF7ZPA4hswA9iRGmAoHC5mfa57B5aHpJ2//G8Ov+4wmW0MCMilL8WxFSKNntxyOzw8/A6Vd+d39GECzTrCh8H6BPeTsGzlSJ26s+1M4XM0s6AwqnfjgC4zEW/m8VSjnEaEZChYS5+wlRwTSdGIT0bEBC5sRz2i25MWn00WpvXAsWObDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(136003)(366004)(8936002)(8886007)(8676002)(1076003)(478600001)(316002)(7416002)(54906003)(4326008)(966005)(5660300002)(83380400001)(66476007)(66946007)(6916009)(55016002)(38100700002)(7696005)(2906002)(6666004)(66556008)(186003)(52116002)(2616005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p/ktA5wQUUdn0LgJx+lA14gh4J9N1eYoZ6V/OH4jVLnhMr4f2AIw6V96L0Jz?=
 =?us-ascii?Q?GbOfwB8/cscwTx96VLRbJkFnAM4fcPbe586Mr8JUAGgIzp7LIKohxRm8S7pE?=
 =?us-ascii?Q?sj8Nz7g7fJqEpoKCHPzO6lJG1d5ENgbqpYjlqHPt3IW++q0ZOVj5U3ei9QSx?=
 =?us-ascii?Q?iy1i69/flFq46Ntatfhj68Lxr9QM9LQ9bztleydIZMtJ0zNbcmrmQ9x1Y7/P?=
 =?us-ascii?Q?uLd+MaWJCQRRS5Yl5ogqtmtcJDMS+ShI+q4mP2Z6qQQjkM6GkNWcpR2JtXnV?=
 =?us-ascii?Q?ZcZc+7BcPC+rAlStGCAa9QO1gW0Sg5V7bLkuRTiDF8tButsPGNMIWVp/+5Sv?=
 =?us-ascii?Q?cZYYxJ5mTUF9KRjJtPgOXE2FQqzG1GomHgx5GBPQpLaZtX1cWVEkop3pl7YF?=
 =?us-ascii?Q?Vb5t8d75Ityy9rS2Y4t6Uqg0N0Z21rTO1F7eR28TEUIEoheFn7CmNRGsSv75?=
 =?us-ascii?Q?nA4OqRxCYyWtTWhU7Jl9HHzG+miKqYZfMJ5HYtV4yt103zCoO5NlYckNzuRd?=
 =?us-ascii?Q?osdCWuyg4oqQRpQJGI5FZfuvSCbGvxCb8tcVueUih/qKI4YxBBcmByG+jZ9/?=
 =?us-ascii?Q?e0smAAP/K/4KQXuAHi/0wsUK7HOOYps3x84+lmPEDgIiwfUrEHEOgZenWSZv?=
 =?us-ascii?Q?aQOpAYTUkk0YI0neCf8qBlIq7sYcdhejIV8upVXuVWSOKeurbnt2jqeeaihP?=
 =?us-ascii?Q?rJrYNHLpM/DcaYwNpHMi4N8CbKobFE/jsuzdQtZ5pZ9el0sFJVqShMofDRau?=
 =?us-ascii?Q?/eaY7DyyaxTuZk6ZOT6ZJGzQ8LskWg/wip9MH7lwrs1/ldXclBZZkeEWOoyO?=
 =?us-ascii?Q?11bnjQh8v6DwEtIwHDhPw+2qgOhoHCfc8hnWcZT+AgVFjwJs6/B4I5n5FOK3?=
 =?us-ascii?Q?VTzGdCLkZK3FNPF/qFKlRRF+ss62PdRh3P9VGkk+de6MD422j8KiCKkASTpo?=
 =?us-ascii?Q?cuAlSexSdpfcrw81oRu0sYJOxYy6ib5hzkia7vFlH2G+4cnAeGEb1End7SsD?=
 =?us-ascii?Q?DCHyxwQUR31DNDr+V/jQC6+VkYPrvk9xaM1pqRES2l2BNL2BOJDtHOG3C5Sx?=
 =?us-ascii?Q?PSlyrjqVGFX7tQ1VN4/NyynZyTsWPGzJK9SI0k5OW3TvkXBugsU9oOe7HSFA?=
 =?us-ascii?Q?plr5eWQZKRpk9T83XJbh6ruRRW2ykCibg/6fNE2A81Lkf5EqHrxzkmrZqVdB?=
 =?us-ascii?Q?/Fb8/IEF23pjzRBYa5bwwje3R5VWJByCz58KKPNw3P6ROyfuwa69xG2wJlL+?=
 =?us-ascii?Q?Zxdef9TU1aC4hypOi57hYlbe5Xc/unwWPsZyQr8vyQUXXmcB34RWsiaIn7MG?=
 =?us-ascii?Q?Wtm/Rddwcofrra1UHONvx9/ZScWVL9S/u9Gt/B9MzZZ8Yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8563bc-1c6c-48e5-b87d-08d9573b1296
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 11:29:07.9764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MAOLPXNTT9i9wILNSNPZD0egyHuH8eC2jr+512HuUAJaaHAXPM7r38Z5vo4J+druDN1/RB7bQzY1UglZoVUfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040058
X-Proofpoint-GUID: fRnRcicmjOhukrpmxeB8RvkbHEZcMljF
X-Proofpoint-ORIG-GUID: fRnRcicmjOhukrpmxeB8RvkbHEZcMljF
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On (08/02/21 15:08), Like Xu wrote:
> Date:   Mon,  2 Aug 2021 15:08:50 +0800
> From: Like Xu <like.xu.linux@gmail.com>
> To: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel
>  <joerg.roedel@amd.com>
> Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
>  <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
>  <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
>  Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
>  Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin"
>  <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
>  linux-kernel@vger.kernel.org
> Subject: [PATCH v2] perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY
>  bit inside the guest
> X-Mailer: git-send-email 2.32.0
> 
> From: Like Xu <likexu@tencent.com>
> 
> If we use "perf record" in an AMD Milan guest, dmesg reports a #GP
> warning from an unchecked MSR access error on MSR_F15H_PERF_CTLx:
> 
> [] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write
> 0x0000020000110076) at rIP: 0xffffffff8106ddb4 (native_write_msr+0x4/0x20)
> [] Call Trace:
> []  amd_pmu_disable_event+0x22/0x90
> []  x86_pmu_stop+0x4c/0xa0
> []  x86_pmu_del+0x3a/0x140
> 
> The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host,
> while the guest perf driver should avoid such use.
> 
> Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
> Signed-off-by: Like Xu <likexu@tencent.com>
> Tested-by: Kim Phillips <kim.phillips@amd.com>

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>
[ Patch applied to a 5.4 branch ]

Should it also include

Cc: stable@vger.kernel.org

Regards,
Liam

> ---
> v2: Add Fixes tag and Tested-by from Kim.
> v1: https://lore.kernel.org/lkml/20210720112605.63286-1-likexu@tencent.com/
> 
>  arch/x86/events/perf_event.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index d6003e08b055..1c3ae954a230 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1116,8 +1116,9 @@ void x86_pmu_stop(struct perf_event *event, int flags);
>  static inline void x86_pmu_disable_event(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
> +	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
>  
> -	wrmsrl(hwc->config_base, hwc->config);
> +	wrmsrl(hwc->config_base, hwc->config & ~disable_mask);
>  
>  	if (is_counter_pair(hwc))
>  		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), 0);
> -- 
> 2.32.0
> 
