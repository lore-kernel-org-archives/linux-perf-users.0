Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF10C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6072360EE9
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 21:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbhHFV2s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:28:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47842 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240338AbhHFV2s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 17:28:48 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176LHVbI014529;
        Fri, 6 Aug 2021 21:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=WcrclyaYUGbBmL+rmhTnG9gArAibYpyUf71juWdAeXw=;
 b=TdN4uFapv/HfLY0N04kvfVUWQ1Lu9j23ZIqq0HXrQM3+H7dEMp2MeosJB7ebXdTgWRwg
 SLH4pQqnwFFg1D8EMbBBVeJoPfgzI5iOhj5VytLal8GNGEiro57x30PFaoJRhNrV6rxq
 +i8oubjQrXG9TVtWVIqmFUzZ/nxJ9i1M+3toib4rGQK+Q6Y5ODOHS5g+x9rDvoL5PXrX
 cgTnrTfHDkG8Z3+se43uDXnq+BmLJxmnuW5sig+JyDXn1kd9UeF+rOk/OfApFHtN6tz+
 FOkw7wzGgIYwFca47eUJsWN0SpdVJTiiGneS3zz73NFMgsZcpF9lmY6+oumLWWRLRaqj mA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=WcrclyaYUGbBmL+rmhTnG9gArAibYpyUf71juWdAeXw=;
 b=zAvFaqEesAmuazc+Hzk0MXlbnMY7rS52wCfTzSqnjOxvDyeNvxcXU+Cp9w5HPpt81Scm
 pyzuJaST/bNJlnNkpConxQNuus1AI/BxApHcjf2wwX6C3jcN/H4x9ZdJxmmG50mNGSa8
 2R0i8e3aUcRvQCVtJn5YpguPoj29wFDtZrN7S2f/958fcVpgdOLbMJXNkNMQ7vUgznN9
 8kF2yK/FtzrF7qVCsuP2t1y+5bjf0sslwYqTWghVbcGTDNW0rwebZaX+doQVqi18jFmz
 4HzQquQXPPoT16D0Z9eKCkwhFe4kJvHgrPtWYuco7KT/WwgxkdcZOVh651j5OGwX6Rek Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9645ry9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 21:28:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 176LFhch082115;
        Fri, 6 Aug 2021 21:28:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3030.oracle.com with ESMTP id 3a962pdvu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 21:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmsfyOpYHxbI/cpCZuYnpECBDNy8FkbxQW0xEb99savoKk06ZXEHjYlN9/snAKdysUqkFwFOaU+su45Ah48x+Ged0GkRboWxlWqmDpJe4/OG2nTjEKj3CM22oqUo0/C5xIciCzzylb0+j8mABqQ/nEfiwQtBUQ5eZOmvEr+JZca1ALydll70OfiFw0OIsTT+Pt8og3y7AWI+kiaI5b2FhMfxvg6M7l7ToNyrdnhr6cQyHi3igeIfBbaXfLdc7eg3YZJoFb/03vS6q66tIu3hox53seH/g7crOlYDpTZvFyurjdItPMk+OxVVtqsnRxRRToOC3Q22qfkCEPgUzF3J3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcrclyaYUGbBmL+rmhTnG9gArAibYpyUf71juWdAeXw=;
 b=aIS/sVhUbsfpSIyW9BXLDmIsMk5mQjmgo2Njn0CQNDB+1uKmaW3w+UeHdRisKr3w+zl6Biz9SayAWVUbhNYy5VFyf0dWjqcHZSQjJIMxifkXbgZRl4EtEZHTM7a5SGLnbO+1bgGHdHODOAyPHZictpjT+L3Q46OAHRMDVtnBM7WNXGd1ijRpREmimwECjwSGuM0/MWkVas3NbN1cerJfynPNfUh0dJQbDpSvCNR0coLxsV2BmGO2L/3aVwMc6vqufV3BA+1DcC6zJuAcQau7fnknQNRA8KyZ2pCC6aVz0qYVoMteFGvP48IxnwZRywaADahSqu3NPSiRQLhrGVVUIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcrclyaYUGbBmL+rmhTnG9gArAibYpyUf71juWdAeXw=;
 b=AXiiljo34RCApKeqo4gjpDP7BvuXtg2s9hFxLxZW3CwofoNf0pOqgMMbEyRqSt0c3XTsPYYkgl9mh22RH0RWB7APZI5Sc427R0agLefG4WzN/pEKaIA59ge/8rEuece5IbsaENfCSAeVcUrQJaYgvEliVOQg0tw/ubDSK9yMO7Q=
Authentication-Results: us.ibm.com; dkim=none (message not signed)
 header.d=none;us.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5499.namprd10.prod.outlook.com (2603:10b6:610:110::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Fri, 6 Aug
 2021 21:28:13 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::7dfc:5c8a:aac:a65f]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::7dfc:5c8a:aac:a65f%4]) with mapi id 15.20.4394.018; Fri, 6 Aug 2021
 21:28:13 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script python: fix unintended underline
In-Reply-To: <20210806211348.GA66379@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20210806204502.110305-1-stephen.s.brennan@oracle.com>
 <20210806211348.GA66379@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Date:   Fri, 06 Aug 2021 14:28:13 -0700
Message-ID: <87bl6a1cwi.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:806:127::28) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.11) by SN7PR04CA0233.namprd04.prod.outlook.com (2603:10b6:806:127::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Fri, 6 Aug 2021 21:28:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f7c323-942e-4e6c-9c18-08d959211899
X-MS-TrafficTypeDiagnostic: CH0PR10MB5499:
X-Microsoft-Antispam-PRVS: <CH0PR10MB54996F6E37D4E0882FBC5030DBF39@CH0PR10MB5499.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYQ9xrYDxV8Cm3uex7DHq5Az8xyksdfIuk+bK4kUWJZSmUTD5ys4DcUnn6fteuVD2zw9knez/Sn/0kT7jHd6bxc/qAPKsnl0TNkK6AAy1dn2HgKYiZRT/vY6LGyxCpKJCB8uOWyeZqfFqPVVvx1aiyAHHpBN6b6cn71jyZe5mbGFBEM0phDGLXnxZvOYJA/1pzS0W3RDGQFMBONl6KLKs9WY1ZLH9LmP2ew5gnJMM0FIjGF9wgOaQBCaJHrTHO3NdiCvMRW7qGj8Lv9oDtVHoKj1s9+dM7E0zB8AZe+DvL7s6R/0Zh/ZjJXSg1/YRhYA47SmEUWDCLLTMpp4tMOBW7QK4ggeCDJzi5jrLuHxKvi+108REtjyGhEKYMUt9r5teR/e1B6TQoyIQyxZBT/2+Q4FhxPrGo0VYSiFyFrIsjHxLFzWdutZXqPFDBfP/0a9THH8u2CfhEyb/B4Ljcbh09zK66TMP1AitRLtzmqMeXcRWIFNJfurRTLdqCXpZvZ1IIZjFczExIsBM+c+rlwD9xSjHMT85uRGIaT3mWO55Qod/g1LBNaJFRGGC8U1ztNZBwdTe4tQBW4C+fWS0Axi5EjpbzbLopFYaRhj12OKDIhrTCYDWDTl1TcgvANEbVtpV9F9Fs4cHo81tx0sD4fwf/94yzzWs3MQRpHEZ7Laxpnr7fYKIeeJDYuNIHXSgm0c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(39860400002)(376002)(52116002)(26005)(6486002)(8936002)(186003)(4326008)(8676002)(2906002)(316002)(66946007)(54906003)(86362001)(7416002)(66556008)(66476007)(956004)(38350700002)(6496006)(6916009)(38100700002)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fp9sIL78LtztYdCSqHcBuYjeb65QEOjGZJugoyIiMmCQPV7IgseI6Oqy7PT5?=
 =?us-ascii?Q?1tTtj4KR8V4v3358ef1xFk0FEi13mJH+ACImk474nfpLRvBini2BCOEWeMPd?=
 =?us-ascii?Q?bPsIeuZWPt7OjfnQkRtKMjng5hVqBvYuhuk9x66uL5lWgiZLPPQqH0pAJcoE?=
 =?us-ascii?Q?/Yjo9nvB5N2q/siiitR73KPctAwlp81byJpji7isU1CUxXPJF7Uw8yzwcMmL?=
 =?us-ascii?Q?jmMH3HddnsByqn6ImxYpJSavfLgOY9hvZxlWVbZNCFza7J5y/AAYqDPFqnl9?=
 =?us-ascii?Q?gqsiq2GO0AyWHe0I7duhOSiCphmIcW4bLr7Rc46v1HEzR5PzeU3M5NuA/G/O?=
 =?us-ascii?Q?ZbMceOGgPJdiZR0w56t1vc4DQkKe6MNwjr+xHNj8jJ9y7vxNs83e79WWmNA8?=
 =?us-ascii?Q?NDM7O292JcrLCQNwMiHlK1XP6ZeE4y5so0+mWvo62VLtLMG/XjrO3JBuetQM?=
 =?us-ascii?Q?qakwhJ9Junwq4t8A0ZjhsgrYLIIL5O0YScaaKBpYuxMgN1mlZVOeXBfi4uzl?=
 =?us-ascii?Q?/lHTCUy8VOZ24Z+wNNCCdKqmV90EK+O9YavpjOxrazRsoy8t0TI+zSr6UwnQ?=
 =?us-ascii?Q?wevmQ6A5ZKKafvAsSxu7Lf9cLbJfRE5qaU0NjdDGcny2nCtLXDNu9sNc4wJm?=
 =?us-ascii?Q?/b0Hw9yfKEol2MLughenDT0NcInyM901l64p0AMjAT6v01yQomU48CIL2bz6?=
 =?us-ascii?Q?UvWGD+SKq21mPNCAPsHpZgUSkZe0Sb+yVRZSuVo55QCLbAXzzIuKKKe+QMak?=
 =?us-ascii?Q?faaVzWPgxBIKYyKrCeaKBDLjjXIvLwjnY+MaRl0rWf6pnfuCDRD63prIocca?=
 =?us-ascii?Q?yVTu/mnPcv/JBKUn0PQiaijXYwG4zyjinVEZf3Wz3oIe1Ryk4pDto5lJUMT3?=
 =?us-ascii?Q?wJQcizVJmN4sYUiuct9lpDJLoFN/cQtkMu0Eek+wCCs08Jh0eMryob5ckIGt?=
 =?us-ascii?Q?G47iMkRraceHt7zid5Wa3QZhK6PkeShcNkkKitqkCddgLk42bL357egSio4a?=
 =?us-ascii?Q?/8R0Cg2UudOkdUOyLKWb6OVjZw+GbUgyhmZ2FTYTzAYKLxcyUpxeGIbd2n80?=
 =?us-ascii?Q?eQsSiKL7HvK8uA469guxZ3A9OQrKzUcyHdl757wasi/P4uv2Ajb5Axn3T9Ow?=
 =?us-ascii?Q?g4ySWungwunAr5K1gS22ZrA1hzKMZp7qi9WHHLn8bA0KQqa7FT+FBoWGC0rQ?=
 =?us-ascii?Q?NOvh0HZuMdqfnQqOPd85R9IliVF1w2TOJHIVWUEvvXTG95vDA4cHH/q7DA9z?=
 =?us-ascii?Q?burGIskqW2KPG3Ob1tTbQqpctnjaGKa7l8W567ulSvVNCKv71MLhVkMUcfn6?=
 =?us-ascii?Q?WwIvGquLmiYMZzW3KueqIq2b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f7c323-942e-4e6c-9c18-08d959211899
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 21:28:13.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEJjGAaRhV2wez+AGYhaLBmODiwuv3fP30sU+8yA+VZTK7O7vEn/3q8ImWqeAH9zVIrfOqIVSWfsy1y0EkyFVeiLwCrBmFHp8ODhStAytWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5499
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10068 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060139
X-Proofpoint-ORIG-GUID: Cc4S5-yBdgNbcnflWxxeq3q0R8qpv_jk
X-Proofpoint-GUID: Cc4S5-yBdgNbcnflWxxeq3q0R8qpv_jk
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

"Paul A. Clarke" <pc@us.ibm.com> writes:

> On Fri, Aug 06, 2021 at 01:45:01PM -0700, Stephen Brennan wrote:
>> The text ranging from "subsystem__event_name" to
>> "raw_syscalls__sys_enter()" is interpreted by asciidoc as a pair of
>> unconstrained text formatting markers. The result is that the manual
>> page displayed this text as underlined, and the HTML pages displayed
>> this text as italicized. Escape the first double-underscore to prevent
>> this.
>
> I think it would be better to escape the second double-underscore as well,
> to prevent the same problem recurring with future changes.
>
>> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
>> index 5e43cfa5ea1e..0250dc61cf98 100644
>> --- a/tools/perf/Documentation/perf-script-python.txt
>> +++ b/tools/perf/Documentation/perf-script-python.txt
>> @@ -167,7 +167,7 @@ below).
>> 
>>  Following those are the 'event handler' functions generated one for
>>  every event in the 'perf record' output.  The handler functions take
>> -the form subsystem__event_name, and contain named parameters, one for
>> +the form subsystem\__event_name, and contain named parameters, one for
>>  each field in the event; in this case, there's only one event,
>>  raw_syscalls__sys_enter().  (see the EVENT HANDLERS section below for
>
> escape this    ^ , too.

I've tried escaping a few combinations of these four underscores.

  \__ __    - escaping the first but not the second (as this patch)
              produces correct output
  \_\_ \_\_ - escaping all underscores results in no underlines, but the
              manual page shows "raw_syscalls\_\_sys_enter()" in its
              output.
  \_\_ __   - escaping the first two results in no underlines, but the
              manual page shows "subsystem\_\_event_name"
  \__ \__   - escaping the first of each double-underscore results in no
              underlines, but the manual page shows
              "raw_syscalls\__sys_enter()"

It seems that asciidoc only allows the first in a potential pair to be
escaped? I'll be the first to admit, I know nothing about asciidoc, so I
may have missed something here.

Stephen

>
>>  more info on event handlers).
>> -- 
>
> PC
