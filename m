Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E1EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 15:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbjGLPee (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjGLPe3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 11:34:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58481BEC
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 08:34:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CEivgw015238;
        Wed, 12 Jul 2023 15:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CTAUoHUSLAyXKX+2SOmCutCgddxI4gELakDd7eMgOTs=;
 b=S27USlmQkUbWEPn6WRtL28tLk5Q2Q6Vd1kcfzwOxfZ05zstB2+Tnm3FPlBZzeb+jo2kl
 jYyhQ/0haPZz5FYQhHaQvrSQaHpTyIVx5X795ZSgKmL8QkD1F+lF4GNsq7zV8gMnVAjs
 wlNi7+8SORbd+jQNctXX5KmU52GI0wuJpYVX+AbLcVOHf6nMdPpXaRiuct5MOG3mKjjK
 Sx1+warZFULKuRoCqUwY0nHWmlNatpo/Ab4+ZmkwRBrDhp9tgGzpSeZ1X2x9z2b7xn26
 iJeQsidvUnDibs8Cut+7RGruBxs628zSyHNtiRZHDa1H12k1doMkyU+jZ3VABxZ0RJV+ Fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj65g80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 15:34:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CEbtKg008367;
        Wed, 12 Jul 2023 15:34:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8d1kwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 15:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUbQYirScjJRZsL6HTjrkMReyh1H0KpHCR27rzx07sIEtRNVcvyxsNh4TQgk/PSHMZMhFot0w6xGN39y+TbOse+S9oD+TSXCgIIQ+wjhCMnPXf7VaFeHYCzu1Sti3USlmiwN80RMyP5zyARXvtMW8w5EB5lvPvgoUoVSrHYyfJN9Q/veib/aFkPvLm6Ce54dhrvLpCQ4/Zh91mIqiW2HYrdetJfjGO3+GEpE7QsR13IIl0b9BZ6yh5HCmJf0n6N8ISfXrBVRBZxjajW0v+cPg9UVDXc7USGhBUESAoQR1/uZbb0srMPc1gZ1lbrsRvcuC/sWEPn6opi7w/svoA2a2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTAUoHUSLAyXKX+2SOmCutCgddxI4gELakDd7eMgOTs=;
 b=hFByW1yquRXNEbRfL8bTkQaP0MvDjX6EWHXNmlgCIOT0xkB9Z8UAzFdjwr61Wk+mrZtOyVYhci3GgChzN0QbtoQ24CIeXxMne99sEoD3kmIA2WGwv/96IN6MMRXolSEfLLT5R6gpJ5c81OCrv/ggrh6r21qkvabnxDVQoQaoW9GDwWIjLatSU6yLG6x92NcpUKLcPh8xk8UK+Upp9VEb5AMyOxkzekd6esl8aIxSbmKtCQ0OdynUkwKMNtOzePUga25nUCBXtQuZ43uGCQbRC8T7jZw8h0kPW5Tgt5tg8NwujJ+v42TRw8FWSSVUon5Q0Pu5uz1wCEgeGlkoS1ia6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTAUoHUSLAyXKX+2SOmCutCgddxI4gELakDd7eMgOTs=;
 b=W0VYdhzb5f46SOdQEBj9ZoW3GlC1S8tH8aWFXbr7ayKeBo/4qFVLRhx+w4oAaVlJRMg03+pDmRQa/Fsg3g7JdFVtQc9nFZl3+lWFExuUtRVNjfUDw2tFaQIUnXzbDnBA4asrme16gC5ah4rokgrvOErTQ0GfneiZPesP2KeiuOw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6774.namprd10.prod.outlook.com (2603:10b6:8:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 15:34:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 15:34:03 +0000
Message-ID: <e2ae240a-4000-da4f-c8c4-794d2dee6c80@oracle.com>
Date:   Wed, 12 Jul 2023 16:33:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/5] perf jevents: Match on highest version of Arm json
 file available
To:     James Clark <james.clark@arm.com>, irogers@google.com
Cc:     namhyung@kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com
References: <20230710141903.1595312-1-james.clark@arm.com>
 <20230710141903.1595312-3-james.clark@arm.com>
 <a35179ad-bb62-113d-3a7e-da4d2ec3c0b0@oracle.com>
 <1eb50ae1-8c7c-7108-d9e7-0422752c4d9d@arm.com>
 <16699c8a-1b68-f34d-770c-d1a1283f9603@oracle.com>
 <d0317185-4880-5504-2ca6-bab3fe30faff@arm.com>
 <034c775e-c0f1-9bda-df6b-80c068dfd69a@oracle.com>
 <e9f088d0-e19a-fe1f-e7c5-bf2141b95868@arm.com>
 <dfca1655-39ca-b9f0-1212-cd468758cbb6@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <dfca1655-39ca-b9f0-1212-cd468758cbb6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9739d7e1-9ff6-4718-370a-08db82ed6bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMtn0DgAwhCXW2xAzJXY8vr9OZRX3EYxDxhAY+phBILo2iuDtk0hyITbMD0HPZs8X0KX9gS7tUn81RBuq8xiA0PTWxMHcN/IPEFk5+3Tg5uzcy0RHvKE1AYzqOeTKfj8N9p19T1CFMbkp5qDLN+teVUGK0j6CYXlPwyoWQz2kNLcEakj15sUDo7+PjR5JKkuNlHB7IIZypCuagNhOlIdE5BvR/pdj0a07kzujSseUc2yd5w1qlLqdZ1MSwZeHh71QaTRvXg2VHOjvni1awYrqZJJIjjMiRD3dTq5oKQn/tANAjsh/0Tn29aKVVhFTurRYW27pkE5gczZVBgpruj+lsvfBi1qFrACl+L040DV4hshH8Sj0rlT1j9xmsOBLrmQyTPLtgbm9KaHZG9zVThhIWn9mZRLzvWQa76/6ntFwM6GlkR+uwZlFHLfZWfJaRgjgZ2sMnybEiJ855ZjMq+rxCE2Td9/B49kzWe6BPSRKMmZZbv6xnC0YQVdMW3275u9/3rWIPGTs6vP6uJ/djBZG6MADopuPWKB16oNX46DjCoE2O/cymferm2FZsvVfTf1UGU7+wu4LtaTguyOOKFWvifzWfutNX9t7gf+6qF2uhKW0VrJFLQF/aD2LcgggiVK29CXjXJP1gR9psJrxOpBqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199021)(31696002)(41300700001)(26005)(6506007)(6512007)(31686004)(83380400001)(2616005)(186003)(478600001)(36916002)(6666004)(6486002)(4326008)(66476007)(66946007)(66556008)(38100700002)(316002)(86362001)(8936002)(5660300002)(8676002)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ZEQjBZemhMdVp5UnJjdmRtNlRYSXhNMjBpMnpPVGtKUHFJZVY5Z1gwK2Na?=
 =?utf-8?B?OFBIOVdXcVJaL0JGdGpDRjQ0VU1QSXljajVyeUxEelJWREw4anNNOEkxYks3?=
 =?utf-8?B?K09kTmR4UTVJdGo4NUd6VTl0Z1d0b2QxVnV5WUdidFFXODRIUzJPOWVoSEVN?=
 =?utf-8?B?d0Fqc25xNzA5anFybisvaElZQTJUVHJGN3RKUFNjeFpQL3VXcEFtU1pXWUdn?=
 =?utf-8?B?REloTTZBUytIRnNZS0xldVAyWVJHKzdUMFlkVUpsRDVZQkZ0dzVEWWdUbWdu?=
 =?utf-8?B?akdjcjc1TlJia0Fhak5JRjFyZ1lnZ0tpY3h6RUF4Zkd1aFFZYzk4dDBEcmF6?=
 =?utf-8?B?TlBGaG1QemNCeTgzSHIyVmJlRW54eTgwRW03RHA4TjhFNWpoWC9wcGV5WnBs?=
 =?utf-8?B?QUEzUFY2bGxJZk5PdEJjTENzZHNvV2VMTk8xUlNiWkdzYS9zQm9UZ2FTenZi?=
 =?utf-8?B?ZHkvdVMxUXZBOUlWOC9BYzU1TSthT3YzYjdkT0xDQUFQQVdRczBKNjZBeTU5?=
 =?utf-8?B?aklCdzdBNEVRZWZ1c0lVTkJkVGF5cUNieGdxb0dCcm1EUDEydkx2L1RDV0JQ?=
 =?utf-8?B?RDRKazVGNHZ1TVhTQmE1dyt4OWVXY3F2eWhtaWVMUU56N0xhS3ZpeDVwbmVv?=
 =?utf-8?B?c3IyVFFQYnA1V25KaWVxd0g4eDFIaUVjSjZ0M1V2T1VaaStNbmxwSnBVV29Y?=
 =?utf-8?B?Z3dYOGErYlkvQ0xaYWZtQlhQQXB5d0FzTnNnSnlsSUhWL1dmL1h3NVpRQWNq?=
 =?utf-8?B?MXF4Ymx5b0l0U0hncXJiSHFMeVdCRUV4S1BiR0RvaUlLbnBWbjBPM1Bzbmh5?=
 =?utf-8?B?ZFlTN01Cb0NUZWhUREptVHVobE1BaVBWdXhHMGorRzEwNDlyMEluQkFINGxi?=
 =?utf-8?B?TDRPNEFxVy9oMGY4QXVtTGszYnUyOExPRlBOWFVRdFJOQXRFTldYTXFsQ1V1?=
 =?utf-8?B?M2J6dzdTd2JLWGI4Y2djMVZ4NzBxekFYYTl0dGJzdCtBMGVlQTIwTy9Ra0RT?=
 =?utf-8?B?QTR1RWhtM3ZBVTJnS0NUSVVuNUVJVUxVK1IyNmUwR0lXMUU2VkxnYTNVOHk3?=
 =?utf-8?B?STEwQm9lMDJzaDJtWldnYmVIbkNRMDZJb3F1WXNSbG9xSHdYTUV0NFpjQUwv?=
 =?utf-8?B?RE5ad3RWbFZ1c2NSdlFNYU9Ca0hsdWt5OUFTVk82aDFnUmxLVFlXdXRZcE1q?=
 =?utf-8?B?cHJYTGxqVEtmRXJlUHJtVnJqNUZnTTNyNXhiUmZNVms5ajJSdmNSTGRCZ0Yv?=
 =?utf-8?B?cTdTQXBLSFMwV09yQXg2ZHY1aEh4K2NDTDFUZjh4VmloU0x5QTluNVYrUFNN?=
 =?utf-8?B?eTYvY09qbnoyQ0VzempzbUJKLzhPcVo3Z3VmdXo4dmhsSGM3OFU2YXh2eUtF?=
 =?utf-8?B?VE56WTQrVUJwdURaVCtUdWdoRDVHZDhZd2NCZXJEeEgzbnIvTEphUHF4V1Rn?=
 =?utf-8?B?Ri9ZUnF1Z2cwSEx4Rk5KbzhXMU5zbTNCK0cyTDlob3JpUXZpQXRSVUtkcG5q?=
 =?utf-8?B?NDc3MlJVdGRVM2lDQk9KNExqQmtLOVJTWFdnUFl6YkhFNkVOWEo4RHBRUStp?=
 =?utf-8?B?ZWFzRlZ6MVpTNmJIV2hKbFN3Vmd6QVhrZEVIa3kxMFVtazcvMGx4M2lRdUJq?=
 =?utf-8?B?WjBHS2xIYUI2N2hmdGtOaElsYlgzWE9EMUk3dXM5cVBaQ2J0YVNYdFBraFph?=
 =?utf-8?B?SVFvQmpFNmpxZXVXbkRxMWdXd0U2OFdTbG1jRUg4a0dYNEJZQmxNZXhmeXlZ?=
 =?utf-8?B?bXRwdmFMZFNxelJkeGRILzRNM3BWMzVJcEgwK3djSEdQcG91YSt3RmdWS2pn?=
 =?utf-8?B?bzEwUFRzalN3bXhRNGFwMSt2RXJrdWlIa1hiUU9lYVptSmRnNlhrZ0tPVGkv?=
 =?utf-8?B?bTdZZ1dYdXVQVkhjMVNQVVY4Rk9RWVBlREszbkNPcTJ5SkpZS0ZMT3ExaXFJ?=
 =?utf-8?B?ZlJxOGlpRHhITkhlRHk2VHVJdGJlQzFXNFlSUURPa3NuVStUUU0rbStvQmxD?=
 =?utf-8?B?MG5XeG9ObVROS0NxOVRyU1pPRTArZlN6SXZwT2hRUXVNK2tsL2dRVGNlTGFs?=
 =?utf-8?B?SHRIcnQzMDRacGhwVnZXaFhHT3NEZlVSY05QMXpKSlc3T3htT0hBUTVGeHFs?=
 =?utf-8?Q?u835onr+tzSQtwp4u0fn5wgdM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WkJEVTZyQTRLQWNMTVZkR3BPNEhEUTZUa3FBdUlFam9kd0hPeE9VYnBERnYw?=
 =?utf-8?B?UU9WWjlWVWc5VnFtSVNrK25KWW5SNitZcG1HRUtranRTODVzNUJ3S1d5MDFu?=
 =?utf-8?B?WVdtbFBEY1QyWWx6S0pzWG9OR3V1TWh3RzcrbDVYYi9lNEcvZUtPME5nSUNY?=
 =?utf-8?B?VU43blRGcVZlYXdGd2JmMGxBTkRab1p1Mjh3bEdjU3VGSjU5azduNjIvenBX?=
 =?utf-8?B?bi9QYkdBQ3RVRXN3MjlmZnVveURLcmNweVJMY0pwNUVyYzZDRFpKSmZSYmhX?=
 =?utf-8?B?UVBlejhua0I1OG1UazhYajQ3amI4R1Z6a0VvSVNmMTJGWXRmQk84dldwdVJi?=
 =?utf-8?B?NGpJNTRpcEpEa2JaaTFyOU5vWkRhNy9SQVhUdS9UTFY0ZWRZLzM0TnUza1RT?=
 =?utf-8?B?a0FuRkhoQU5zbUdVNXJIamQ4QVJzUGU5Y1Z2a3U2YXZsMWhoaERjMjl4aGU0?=
 =?utf-8?B?RGRoc2tDUE1KQnhFR1U5dW1vMlFlczVRMlpIU0crNitZMXJmZDc2N2FvZ2dO?=
 =?utf-8?B?aVJ6Q0RSUGF5RXZ1elFXTkZTQ0k3aEtYYkV2U3czcTNnNk4ydEpTSTRlb0tx?=
 =?utf-8?B?ZVJXL0VCM2k4dCtKaEJMLzk4a3l2U3M3VEdoaGRBTFdTN1M3MDZBNHlCY1lE?=
 =?utf-8?B?UmlqdTVvMldzQzRWT0VkT2tWUUNFbWtYL3RSMWtpYnBIcVlTOHIwdnQ1b3po?=
 =?utf-8?B?L25GenVvTU9yT1VzMkdrZHFOTlU5cDlXV0hlOWprQnByUEJvR0lvNnRIQ01h?=
 =?utf-8?B?Ly9Mc1JkUk1lMkNBd0lKenFwMEpMNUNPamtTV09jMEd4VzFRMXQ0ME1UT2RU?=
 =?utf-8?B?NjZOK3A4djdKcGhDUGhBbzArazJSaUlqRW5iQmErZlQvVlM2Mmxla1RrRmd3?=
 =?utf-8?B?eSt1cXI5a3p4WnV2eHh6TVBWdmlFbmZvWXJReGkxOW5XdDNyN3crTlBBNmF2?=
 =?utf-8?B?SzZMNkJIR2x0aHlPeTVHVkNmeEFvN3Z6UUF3UUtpdThXRFdFZTlKTCtZQUcw?=
 =?utf-8?B?NDlscmZOV005WVZldm8wVHFyUGZxNmtManFldHFTb1gyaFZ6SEc5T3JRcFNi?=
 =?utf-8?B?a1pOTWRCY1VITlBMUXdweUVEcWpQeTNkQ01sUHY5S2J2aDRDTU9iRkswNCtz?=
 =?utf-8?B?aEVsSGZCc1VLb3RiV0djTmJ1eko4bHBQOWZPVFkwQ0FpUjF1NlV1SVJTcEZl?=
 =?utf-8?B?YmxHemJHNlZGKzFBbmFzNHE0OFR0aG5zMjJLaTNsbWsvN0lFV1J2QnAyT3Aw?=
 =?utf-8?Q?jsAV5NeGbNx9suQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9739d7e1-9ff6-4718-370a-08db82ed6bde
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 15:34:03.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9RniqRunQghZ3epWwbe9ZYsF/t5nQsd1Kc22a7RLlVNrGbW62E1g0tStEN98zcq+pCgREED9PWbCfmjJEEECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120141
X-Proofpoint-GUID: -6Ruhb_rSewjQqYxMlQsgqorpF03if0j
X-Proofpoint-ORIG-GUID: -6Ruhb_rSewjQqYxMlQsgqorpF03if0j
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

>>>
>> What's the end goal of reducing duplication? Is it to reduce the binary
>> size or to reduce human input?

Not to reduce binary size. Well that was never the original intent.

Originally we were seeing many transcribed JSONs, with descriptions 
manually copied from TRMs/ARM ARM or some random implementator 
speadsheets. There was also lots of inconsistencies of event 
descriptions and classifications between implementators and 
implemenations when there are no differences in practice – it is not 
helpful in giving a consistent user experience on arm.

The motivation to reduce duplication was for the usual reasons, like:
- minimize mistakes
- ease of maintenance
- easier to update
- etc

There was no central repository of ARM events for all implementators, 
like intel had in (I think) 01org. So it was good to try to provide a 
method in perf tool to harmonize event support there.

Obviously when implementators have their own repo of events in 
proprietary formats - like arm does - some conversion needs to be done 
(to perf tool format). And using methods in perf tool there to reduce 
duplication becomes questionable - reducing duplication would be the job 
there of the original repo author.

So we could say that arm can have as much duplication as they want in 
their JSONs as we know that they are managing in their own repo, but 
having different rules for different implementators is going to be 
difficult to manage. But allowing duplication in arm JSONs does leave 
door open for inconsistent event descriptions between implementators.

>>
>> For the binary size if most of these strings are the same then they are
>> de-duplicated and the impact on the binary size is very small.
>>
>> If it's to save on human input, then not doing it this way has the
>> potential to be more work in the long run. At the moment we can just run
>> a script and generate the Arm JSONs using what Arm is publishing. We
>> might understand all these subtle de-duplication efforts, but anyone
>> coming in the future is going to have a hard time understanding.
>> Especially if they just want to re-run the script to update some text,
>> then there is a big risk of making a mistake when re-applying the manual
>> changes.
>>
>> I'm not completely opposed to the idea of re-working this expression
>> this time so that it works in both places, but I think we should be sure
>> that we do it for the right reasons.

For sure. For this issue, it's ironically a bit annoying to have such a 
small set of differences - otherwise we could just let it in as is. But 
have a small set of subtle differences in a handful or metrics makes me 
think that we can solve this with literal / formula.

Again, if this turns out to be a continuous issue popping up, then it 
may become an unmanageable rule.

>>
>> As an example for comparison, I tried a build with a single set of
>> events and both sets (from this change) and the difference in size is
>> 1760 bytes. Is it really worth starting to edit formulas just to save
>> that much space?
>>
> I re-ran the test with a clean build and the difference is actually 4888
> bytes. Still quite small but not as suspiciously small as 1760.

But it's still not huge in terms of size.

FWIW, we could prob reduce size more by doing the archstdevent fixup 
during runtime and not in generating pmu-events.c, which would be saving 
more space.

> 
>>>> It's possible in the future that there are also small changes to the
>>>> description text or availability of the events between versions. It
>>>> hasn't happened yet, but it gives us the flexibility to do that too.
>>> Here the (handful of) metrics are subtly different between these
>>> rev/variant, but all the events are the same. It's hard to justify
>>> duplicating almost everything just for that.
>>>
>> If it saves time and reduces the chance of making mistakes then
>> personally I don't see an issue with the duplication.
>>
>>> I am not sure on how to handle this, since we might be bombarded with
>>> support for more CPUs with the same MIDR issue and having quirks for all
>>> becomes unworkable.
>>>
>> I really don't see this being used very often. And it will always be
>> used much less often than the task of adding entirely new CPUs, so it
>> won't cause the number of JSONs to grow faster than that already
>> existing work. To be honest there is a non-zero chance that it never
>> gets used again.
>>
>> Although even if we never use it again we still might want to
>> re-generate the JSONS because of a typo fix or something so that task is
>> just a script run rather than script run, and then re-applying the
>> expression fixes.
>>
>>> Can you just give the idea above on literals/functions in the metricexpr
>>> a go, to see how it looks? Maybe Ian has a good idea on similar solutions.
>>>
>>> Thanks,
>>> John
>> Yes I can give it a go. Also interested to see what Ian thinks as well.

Cheers for that.

John
