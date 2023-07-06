Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FA9EB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jul 2023 04:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGFEjT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Jul 2023 00:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFEjS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jul 2023 00:39:18 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4357172B
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Jul 2023 21:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPrpDGz+BU4RaSCqQ9azLjYDcP2garP+Pz1fYbE1QZjE6z1PjRy1nfWeOjmUhoOYwAlVVWDeXuVYiqONYljgAXPWDfKmqmIRwrV//wBUPG+3UnZvY7y61qsi9AaHYFVs7Zl49wKj4+PkX+P7v94Xzx7wfpMi1IH3HAi9MNX8H8FA9HSgsR3cKjuJ3IS4A2JQsuxVlw5tqFwQjGnjK1cWlSQSLiVzB3DKr8S7MctFNSRZLa6h08ZnuADtKUdXEwZQBvtAfAq4HfGMGeDFcd5OYbCHtv0nQO8rpVCr4xmH5mf9NG93HI8hviREsaBU7w4cVA3QG3EWyQgQkNAXREGrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPPMiBDPjLbFVBC4823L2jLgKPK2sqdgfsZBBf/mdc8=;
 b=SgdJBExBjWdBDjCOS01c8aDFR00/L7ypwVMY7WYI3d6d4JvbZ9y7CPwel+LODmnT/cyjd5AwT3Dy6HSzIn4Ppvq9GYfGQZcFozT3EDD1jqjlS85qWIO0dl/dVzSML42xgY6QNgRIghq9GwBOVEJs9M83uT5CR6WnFVhitpg0DIeO42n3leWy1xodhZZgkvQAxfc5RpXlBKWixt+YLfwBf0oxnBSpp1yqexFBjoS9FRO1vGF5CWh/Ofv2swy1htVopi8pv4e2LWuv2oxSH5and11BXv45nMzYL/ZXYLIlMQsad7mRdFqg31zZWkv7FRmarZhBcCLJvczUO9miSzmkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPPMiBDPjLbFVBC4823L2jLgKPK2sqdgfsZBBf/mdc8=;
 b=XV5je+Uz9E7FN13sMvLM1LWxCSs6uzArTNnq80Qyg33p/Tw+B78rssPitKvMvgs8pL7pUXJ1TgGIbLDrNz43PVRfzWM5pHp3PyigE3iP2XTBesVDMXutNiBT4Mzr/ZziTLn9ePUac/RS5SgHoArM56J+jFajQf82l4cJaVUpTFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 04:39:15 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 04:39:15 +0000
Message-ID: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com>
Date:   Thu, 6 Jul 2023 10:07:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [BUG] perf test: Regression because of d6e6286a12e7
To:     andrii@kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: b92664a0-9c37-44f5-5923-08db7ddaf3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3TPahJ9oFswRyV2qZOIT+vSXaGDRnfReWTRxoZCNSD0784YfQPnx5yp4N2s/qH+qh8EBAj8gO0BrVjo4x6jkNh05m8HDLweBontZ16ofi7jsRrBFlK2yt8s3c14bnLnXH0A6vfhE1L7CRlqMf633zIjZmZNdJKt32QSSTsIAp9or+vEakph5//kV/vgH4Dx5WwKGVtwj6Yae4B7r5OdjK93Ln5zS94HO7WcMwOq5FfKXZP2NbIkmezHZ+8JaZCngMvqEycno+yWbMxnA+/fYdiQ5z9juAuw/kdQaTa2XrYImt51Pne0XzD76CGuuj7cPZ8oFRY9Xzr4JMy6pG7pJx566t60kJLPpRIC810bBLeDphVDWPvSEgDXKQhDruDVuVvhJbQGCuPtWBGsCb5wpGFTM6c4tqOkqmXxow3z5iW8B+PPqQhsWFaWiXt19kAZlAqJGRqne4I3RaD67EyiyZE9snR8luImIrLEi7jwxvLDjg1xRT+qZhKJC4IGZYeNSN9jXi4jQRorGsbj+IxS2DJKauEzYXkEmJEDoHJtE1Tqej8pBYL0oaQWUzn8P5960wF1+258Cgiukhvyaln+/uK9O4wtHF+rZstu7rAC9SSrY23FXngbK8uKqIkU2sUyt4uU2So1zsiqobDw4z1hDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(6486002)(6666004)(478600001)(54906003)(6506007)(26005)(4744005)(186003)(6512007)(2906002)(4326008)(316002)(66556008)(6916009)(44832011)(8676002)(5660300002)(8936002)(66946007)(38100700002)(66476007)(41300700001)(36756003)(86362001)(31696002)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWlHMnB3b1g2U0cwZDNrUit3Uzdod2N5cklYY1FJMVZySVFOdGh1N0hKMi84?=
 =?utf-8?B?bUNzYko4MmVCRXdVVDFUWU8xV0M4UW84NmVqS1UvSE1JakUvL1pPOFZTdC80?=
 =?utf-8?B?RmNsK1YzQkI1M2lRcEhuTEdiVWZXWWtLVDloZFByRmF5d0QyKyt6a2xPZkhH?=
 =?utf-8?B?WDRiL3pLaDBtMWxBTGxGRTQrUXBxOUpoaDBvVVdDNnZySGY0L0pZTHVhOTM3?=
 =?utf-8?B?RmF0M1Zxa245T2ZjUEgxV3pnN01SMmhUY0drOVVDVDlDaVZ6TktJM0s2Z2g2?=
 =?utf-8?B?WEZ4NHpaa1N0VUwrOThTUFB3bzFQTTgxK0JQVnBuYlp1c09vSFJUUXJhS1dq?=
 =?utf-8?B?K0J4anVlYWQzNDhkYm1LeFlHUjBiUHBZRjF5Z29Ya0VVdnBHRmtpRXlacDR2?=
 =?utf-8?B?R0J1anE5NFV6Q29CTEl3cWQ2L2IxdndjM0pYRTZZRDhCeFBOQ2JoaEVZOUZk?=
 =?utf-8?B?b2ptSmlpR2pjZlhGVWptd0lSYWhGWHJmN1hYQkY5SnVBM1o4MmlDSkFCalFa?=
 =?utf-8?B?RDNXL01yYzVZK1V4VHBHclBsdlo2WVVxNGVFVnpWWVBQVk55a1NCT2RWbU11?=
 =?utf-8?B?NmpUbmZyTnRWbm4rMDg2SURuTWxwL05sUmFqTHpQWkJvY0JXUXc5Z3dqbVcy?=
 =?utf-8?B?L3Y4UHFmNzRpMDJSNndyeHhHcHFuSjJzU2h1MUY0eFphNkc2bUU3UmhrU1NQ?=
 =?utf-8?B?NXZ2TENjMEVrSjZ3QTdZd0hzNXZTSitGU0ZNOUR4Zk5CdDliS04yRnhSSGdS?=
 =?utf-8?B?R0ttQld2eXZHeml5VDdQSkZuamJScnZaNGR1QTcxc21qb0J3QkZjWjIyT1gy?=
 =?utf-8?B?MDNYZmJDZEdCNHRUS2JCM1I2Y3BWRUYwWXRNSFpYZjQxMGwxeGVoZDhjUWhw?=
 =?utf-8?B?TkVSOVZYOHhBazdOcllzaDE0Q25vTzF6c044TTRJempTYXhVV2FNTHZNMlhK?=
 =?utf-8?B?ekRYamtGNVN2dGhSZnZId05HNTNrUzJzVFdDbWV0cE1EYUh5dTFhNzhNUE4x?=
 =?utf-8?B?K0ZjM0huU296WlNTZDJGYnhsNXdrbjZTV0pMU2N6SDZVVEs3RDRHTUxSNzVS?=
 =?utf-8?B?eGJ0czVNVytlcmNYNGUzbTZNbUF4ZUREK2M2MzVNeXZ1QzdaUDQyU1ZRZVN2?=
 =?utf-8?B?UlJzNGpPNHVjWk4vUDZpMU9mTlY3em5ZYlZTV2lBOWdtU2NDY2FkVHRac3N5?=
 =?utf-8?B?N1NiNEN1Tk1JWW5IU2kxR1gvQThzYmF5cXd5blk5MEdnRnVQd2Z0RmFBc3Na?=
 =?utf-8?B?WTRxVGFMamUzZEZkV2FsaDJjMVRPbkF1YW82NVJUcno4M25GcDZsaVNGdGxo?=
 =?utf-8?B?MXlhb2dJU0dFM3h2bUxxVVpLQjRpMDB0ZEo2ZDFHTnZuNjg5UDd0U0d3Uzd3?=
 =?utf-8?B?enRZR2o1Ri90bmtkaXMxbFJBQ2pQQzloVWFKdWZ3YWhDQ2l4Z0NwZ2tOVEJi?=
 =?utf-8?B?L2R3UGx2ZUxUdVQxUGx4dXpucDgrWlQ1RjFHZ1BDd2NzcGo3U0pDVEp5dXd0?=
 =?utf-8?B?US9JUHBRWW5JOTZrWThnV3lPT0dld1ZsazFoeXREUFFsU1ExUEtRdGFsbVla?=
 =?utf-8?B?dHNxaitKR21GVmh1Z2xQVzlHYkNWUUFXL0F6RjhlS3A2MWRZNGk0UnJHeVRj?=
 =?utf-8?B?a1BxODVJQWo1a3NnK0VpaDhld040NE1uSHhBU1BiMFROWnNUSEx0ODBxSGlI?=
 =?utf-8?B?N2FPZlNnU2xPMnBCazlTT1QrYUtVZ3pXTDVPL1F3dURyVjVhWWl5bE1tS1po?=
 =?utf-8?B?ZjZUSExSRG9VSEF2MVNWNHBleHZzMUxqcWVLdGU4K1l4SkZWWlVhcU9VMnJB?=
 =?utf-8?B?UWQvc1NlSk0vUHVUaTBXSkNKZjdnOU5ybnU3ZVVyUTJtOUZPTjdES29VWmZk?=
 =?utf-8?B?SEJxOEorRno3ckJ3VWlHQ3VSRlp2NGw2eFgzUXpVMXlUT1BGRmtnaWtjeUhy?=
 =?utf-8?B?VlpuUzBsZmRsbnNPMjkwRU9hVmhVaXljRzhNOUpja1E5QitHNVBQSjUzVU1j?=
 =?utf-8?B?YlhZMGlaeGl6b3Fhajk4d05XSGk0UmhyUzB1dFJQaVk2L3Jhc21FQjR6MUFx?=
 =?utf-8?B?UEx3cU5RMEc4QTlDb1pweFcwMGYyQXh5cjNESEw5NnBiK1hwcS84cVYwSEMx?=
 =?utf-8?Q?LEyRhJj1JfDcMoQ8HxATsfKLH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92664a0-9c37-44f5-5923-08db7ddaf3ac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 04:39:15.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xivpeICzUwUrWLS6U7F29sE9Nt1fmVw2gHzsZ1x0yJtRmwN8f7Ssx4Gs7RSuGi6I9m5165HrgFKAAsfnjW/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Andrii,

I'm seeing perf test failure because of commit d6e6286a12e7 ("libbpf:
disassociate section handler on explicit bpf_program__set_type() call").

With 6.4 kernel and perf:

  $ ./tools/perf/perf version
  perf version 6.4.g6995e2de6891
  $ sudo ./tools/perf/perf test 42
   42: BPF filter                               :
   42.1: Basic BPF filtering                    : Ok
   42.2: BPF pinning                            : Ok
   42.3: BPF prologue generation                : FAILED!

After reverting d6e6286a12e7 commit:

  $ git revert d6e6286a12e7
  $ make -C tools/perf/
  $ sudo ./tools/perf/perf test 42
   42: BPF filter                               :
   42.1: Basic BPF filtering                    : Ok
   42.2: BPF pinning                            : Ok
   42.3: BPF prologue generation                : Ok

Is it a known issue?

Thanks,
Ravi
