Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC4EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 15:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjFWPUe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjFWPUP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 11:20:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9505E48
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:20:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDPe0o003408;
        Fri, 23 Jun 2023 15:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=bdPvFyCYUR3jAmnTUQVn1OgZOnlP9P/WiDU2sxbLNUQ=;
 b=RIJtgr6y6xLqqpONZBqOswJmjBTFB6+jKA8PpfEC8uZ2hcBDiB7RWhYSFIaKlVhGcfiV
 8ZCSUYadPlB4uGRHykPzrvgqB6la9DSjq5Ks8KJ1g5KtGCsVLREs+D8C7VdEodTJEAny
 KhLWhIjVKKYjmp98x0tVrHy1SG0ie6pZDPRVrKvMEqDnCtr/F+Mt6x7sCbLdNe5wSzr3
 LJgOCr/mTotdv4/QnCvKoyGCqIQSSc5/ha8p/pOCa8kPW3f7555qbbKvDZOOgC/hXmrt
 cXb3VNJCgD/mfsHCJEaybEnuTJ6L1bFV28jKuGRkp7B62yNkdwN5Hdpc7aa2S4NaNdUt sQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qac121-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 15:20:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35NEjsj9007741;
        Fri, 23 Jun 2023 15:20:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9w19kb4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 15:20:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh6qQfaefZaRdexJyn++SJX5mJEX7jkeZ4dwGw7Cc1aH4pz19XGVZpbdlfeWDdTNgx/maIqpPRo1XPPigkk1/QPbUCYDk2ZuaB76cL7Jw37dys4BaS7Ojmpn5dDXo3lmpN5rn/A4ANPHY4BhdmkhK2+6Y1oJabdzUGtQQtca8QEtlantbyW1BV0CAyhgd7nlXTbmW4Zv/gOFxptH/l1FGkx8YNqxkd080Fjj74qwAjRu9JCjEFLNSMcmJRpUUguZ6J2OoDUzifu1YFkpHbpr47ZiI4fGc5OnuOze64rXb+HHzwdVguah9gVN2fD5jit0K3h5TNg43P+vtL/RVPrn3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdPvFyCYUR3jAmnTUQVn1OgZOnlP9P/WiDU2sxbLNUQ=;
 b=jCDS5MvSSlzj/BZOZMtJYiyqwnuAoA+GxIp6Gck48WWKFwT5Rr3MCIqcuysmAaT6JKJI7OUg91Zo/vFucdjhsF4B88mIw3Oj+NCawinSgcCL6xfdidFpSKlBGeKFMB34e4DmV83BlBr144epNpxCPCSfTmDusVamXTQPyJHbrsrH+Yw0knVb9sn1ag44OaWBVA+oW+NvlX+WgoU8Qb7yECm4aY6y+am0C2wHNgSbHMxaBf/14esQAsq5Cym0KO713pYKfLcrnxmsRpbki+y2u0lKcNy2TTW3YZzFDU1PX6GgBgdjSa3eSdspsYcte+RWYMVyQMenI8EPuNfZ0V8Clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdPvFyCYUR3jAmnTUQVn1OgZOnlP9P/WiDU2sxbLNUQ=;
 b=E/pzJRCIueBiukZ8mwv6Jxu+N2JxhhzmRoJLKY5uRKzyDL6J4p79G33HFDE92R7+Pkf/jk6LZGv+AabdsJjh+3GoyusYIk2yhU+XGBTzlkhIbLOjHDfSA5/D8nBAnmRDEHuRInrwWWDTnuXbBMxvth5O5LZMQerJNTzPMG3Sc0s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ1PR10MB5905.namprd10.prod.outlook.com (2603:10b6:a03:48c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 15:20:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 15:20:00 +0000
Message-ID: <151a8677-3259-0586-03f3-fb751782daa9@oracle.com>
Date:   Fri, 23 Jun 2023 16:19:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     irogers@google.com, acme@kernel.org
Cc:     linux-perf-users@vger.kernel.org
From:   John Garry <john.g.garry@oracle.com>
Subject: perf test pmu-events question
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0246.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ1PR10MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 7feb5467-c6a4-48b7-5815-08db73fd4f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: To0h0yho6qSq5CjiY+Hk8DcY9WYJnA0J9DlUIJKFMFKHZWS6tw3oYKZuJBPzLlT2k0tPPYPa7CACb/+MR5Mwtq910KzLZ7Vgt1j9MdCtEIO8KnS6KR2nw8temOB6Li9g7mIXE/utAY0pYSxCGe7T8fNeuVz1fRFo1zqID6stwdPKAulpriMbHhMG68VZ/8DYa3f3iH5eZj6/F+0hsu6wy1p7WNN4qAivXUPv6rFABWjNXjixB3E4VgMgCQ9wOzfwfWc5m5K1tQGgF4Kk/4Yn3CNrgsS25utrHIJ1KPCihpxsiOVAyY58MCW90R9O7mx5GmJppUIZYVeQFkwomztJ5FcamI05NPy/cLEtTOPW2014G2rWxfZX9HuQmmhIHegMTkjyOR6OWC1l0dVZwiFDCXqBMs+LZFxqxrq3buIilGP2P/D/Msod7M9mW6nmH1okx03V73YWPnOfzfr3S2RVhUx65mDSJZiVM/JYQSUnu0LGQoGopmpUJIYW4CaMykpLIUy0khrFgiBc4DztKAhOWiazXV1WV44MVdzGg1MfuqhGAmRQ9aWnwdUFnK2F/Ldcb8OUkl2yRw57bSKnAoW+RbTdvJBcq+dsx+EmYs4uKUQwUHD4ftNm6zfUoc0dlfygaloVWyj6VLW33nRpcFnN+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(4744005)(2906002)(6486002)(36916002)(6666004)(38100700002)(83380400001)(2616005)(6512007)(186003)(26005)(3480700007)(41300700001)(86362001)(31696002)(6506007)(478600001)(36756003)(316002)(66946007)(4326008)(8936002)(8676002)(66556008)(66476007)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9RQXAwN2dTTHBuTmRjRGVoaS9yRmNyY0MyVHpQaVZDemcwTmlHYWxjMCtL?=
 =?utf-8?B?MkpsSUpDamNMS1pRNnlhanB3aGg2QzJnQm9ZOFJQN205bVhkT0Z6cnZoL2xo?=
 =?utf-8?B?RkhPUis0VEZjUnN2ZkhIVkVyWVJ2bVozOTFsOHNjcVlHajZhdkRuM3pMdTJz?=
 =?utf-8?B?Wk9kYXdlSWl1R2RKUUVVSWZZUVVtTG13SXBMbGF4RWJvaUxLeUNWcTR6TUtw?=
 =?utf-8?B?dk53OGExSDhYaVpJTmJaTlArUk1ydXh3QXVvVTg0eUt2Y1A5RXhxejJmVDdi?=
 =?utf-8?B?VG5jNTV1WjJVMDN2aVR4YnlKdFl5QWI2V2JGbXpKdHVTVE5ybHI5Slk5WElY?=
 =?utf-8?B?RUIyOHkzUGoxcXl2K1RGLzcvbU5leWNieE9ocFVJWlRiVlQrNHRXK2t1a1ZY?=
 =?utf-8?B?Z1pLVU1iOERjVUZCY0tTeSt3ZGZLemtkTHNLZjlrRWRmalA4c1Z6Y0RhRVJY?=
 =?utf-8?B?ZU9NTk1tMlcvcGUzQmFCYUh0dXA3R0hxc0hqdWY5ZWRyUTdGaklFMzdwb1NI?=
 =?utf-8?B?TWlJR1VXb3d1aGQrcnhkYS9sQUp0MTVVV2tDRmNCZVZWdTdqMWNjVFA1eDY3?=
 =?utf-8?B?OGFEanFQa2dEcHY0QXhkNHVSYmhnalN1SnZrOEpWQUJ0VjhYWkFkamRqYU9E?=
 =?utf-8?B?K2NQZWMwVzhvQTgrcGFJOW5lZzZRbkRHdmNQL3Jwbk9lbFc3cmdaTmp6a1hq?=
 =?utf-8?B?L2MwOWFibDNkaG5QMzJlM0gxSVlTb0ZZczFGWGQ0WGI4bzhUR2FJeVE3eGRE?=
 =?utf-8?B?Q3pJdWhORmJxTnNNdk5NOW1idTFnUWpkK1JVK29tMUptOGJhOUgxNVo3SDh3?=
 =?utf-8?B?bjZVc0ZFNkl4SmcwWDZMTzN3N3JoanhaTzNmanE3d20xbU5iTXpsckk4VWdr?=
 =?utf-8?B?ejljMm1ZWldTcU5iRkcyNTNDdTZwMHc3ZEVaM0tDZHNnbTZjRWlZL29RS01B?=
 =?utf-8?B?cWhERmxtVm5kNEthOFB5T2F4UEVROVcrNzRmTTUvaTFEZmoranVqdXhDcWxz?=
 =?utf-8?B?dFpFdEhnN2RIdGJQZ3d2ZERvSzkrNDdPUDVvMWlMRlAyTUZRNktnVVZPVFg2?=
 =?utf-8?B?RHp0VDFYYUxzdSt5V2F4R1RHbldWaHF1ZXlIVldSa0UydEtQNWtvd0xZa0Y4?=
 =?utf-8?B?aEFiZWNnQnNWMWo5Y283d2c0SHBqbWxRZDN1SnRWdVNSTVk2NzNIMExmcm8w?=
 =?utf-8?B?cTBQWjRGaHdZOE0wV2MvUjFWRFdQcWd1dGpoaXhhSFJiRTdQMWg0anplMUZG?=
 =?utf-8?B?MmVLL0VTVmNiZGpHcWdWcUU2bEFaV3lleDNUT3ZwVEFWa09vWDdOWVNtYjgv?=
 =?utf-8?B?MWk5Wnc3RktxUzN2OXlYTEE4UVpVemx2OTR3MmdCOFJmOWwrU0ZhanM0ZlpN?=
 =?utf-8?B?bVc3MFhWcFNUTjJzTUt0NGJqM3d5SXBtRUlBc2FGc012SDZsaCs0bHNwZmY0?=
 =?utf-8?B?YUZ6WEpReDZYUWwxT2t4U0taRTh5NkpqeklxdmJpclV6ejhCNUJnOWdzNDIx?=
 =?utf-8?B?MWVhclNuejcrZzZvUm0vYVM2ZVJ2SExSeStXK045djBEeXU2QW1naThUM3R2?=
 =?utf-8?B?NzN3ODB5aHFOZlE4K1VtMDBPUUZMV3ZUTzQ2THNGYm1GSFEzOUo4VmU3WVdG?=
 =?utf-8?B?Z1drbG96cmtINGV3UURDTlM4SlR2ajlYaURGYUJaNVJwNUZjZ3l0aUdzUkl5?=
 =?utf-8?B?aTdpTlRHaitmTlRnU3dkRlNjcW1rS3pMTEhBZ3FsWjNHL2lVNm1IdmlLUnE0?=
 =?utf-8?B?YUhZVDZCNXYrTjJwclhEUVE5Q0MyV0ZKQjdjTXI0SUt5K0xmNGlnMWpmOVJN?=
 =?utf-8?B?NDBCM0RZeEJ4cmd2Q1ZlRHZodDRLc1EzU1NxMnpYa0JkSDlLTjJoeU1NcHN1?=
 =?utf-8?B?Uk1ZU1JkNFdVck5SSU9zakZoSFJsTTBWYzd3dDV3WlNCM204OTJFMGQxQ3pN?=
 =?utf-8?B?L1RQTWsySjIwUG83YnNLVDFDOGZIR1A3ZHJtN1BVMEdaUHFDOGdnR2FLdlc4?=
 =?utf-8?B?Zy8rWHp0ZWtjTkE2K05md095RDZPTEJxRXRzaHI4bzNHOFVCR3c4Z0tYT0F0?=
 =?utf-8?B?VE90T293MlFTUTMzbk12Uy9VdDF0MitldUhRVFo2QlBhLzByc1RIR0hiMjVo?=
 =?utf-8?Q?WdZuDWa7GzUFORBdA/ZTGYSzy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B7/bbraWRK6kPMSjU/2BJDqRVyO1rc19B0oqpRi8yhARkK+hZyuIcPSnmech/8RDfoPSN1NhOe7XMd/D/+khNuwWnYJPPMrfXa8Le0NEERr8tdAFMotNrgbREgxPf8+SvPRgyEiRgI1UmP4AMi3u3oMCvBAUUCcKf4C99lfYLPMlEakeJsksOACAEMlUOBvmyu9YcDd8KIpFyAOFyTPB+fKM3QlWdxsSS6ZDFRPy/aIKYdhEhDAcRYN9oTxpU1c1FFn9qXeSKSqKLTTSEsbSiUOl3ZU/fW1ATf9BXNyw4LuNrQVECt8TfiREHqlZnTV2AzWooidMMhg6pPrRzkiskJgOm5wxuwhUat95dXPQ1EQZ3jm3iKmstbUqJBvCps1ZRnp5T8MvlQe+wKm8akkSp4Waj39M5MKQw0caf61Gy2WTIsM817ejYXkqnV2CQyn+bk95Ay4x+MoQgaRXvH5At19aeG44tbcwAm0G6P1NxmkQ3JmTQ5EgQXNwCgzjgMolFmcVods66kI550CvxR23sM31FJN5PkEhwJLleQeko/gSjPTxiTUTPRGmYmqObxWpjioQlsWTuckmJ+sNCgTvl2fApn5K6VW0H1JruTk7ruhiWNSwmII96hqjyG6we3iawZPCrR6gt+NqhbTDT2Q5FJ33ojXYe6peTwdAT9C38zKETtydR193T6OrMhJsEk484Zd6oPe/e8NH1ILNlbjfVZNVuUHJscWulWGTNU5x1HLz/2Hh2NnBAcVEJHS/JCr0hbpappOOVcmSelzqcmp/6kbT71hzWfzcMEEXdFY0lrdj2sr/iK0xNddoYkUQxPgj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7feb5467-c6a4-48b7-5815-08db73fd4f83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 15:20:00.3531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YnpQrXdo3AKsfkw+p+Xp+340J8WEtS6BMPaKRp8cvhsPCwC2SI+sLxOZWP0VvgJzNXsk70GGaDjFB9mHCqCyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230136
X-Proofpoint-GUID: PzdwxEMuGNzN4Pjwnb22TYG5oD1Z7t6x
X-Proofpoint-ORIG-GUID: PzdwxEMuGNzN4Pjwnb22TYG5oD1Z7t6x
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

I was doing some re-write for pmu sys events metric support and I want 
to add more testcases - we don't really have any.

So I noticed that tests/pmu-events.c::test__parsing() can pick up on an 
invalid metric for the test CPU, like M3 as it references itself. 
However we can't detect whether event aliases referenced in the metric 
exist for the CPU. Is it worth testing for this? Would it be sane to 
scan the associated CPU event tables to see if we can find the event 
there? Or do we already have some per-non-test-CPU metric validator 
already in the testcases (I could not see it)?

Thanks,
John


