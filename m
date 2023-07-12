Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E2FEB64D9
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 11:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGLLeZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLLeY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 07:34:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D278F
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 04:34:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C6bhDN003215;
        Wed, 12 Jul 2023 11:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eOVlDKQH1Pcc5u+SIT4QNJAMde1SOGY+5P75OCQ7Abw=;
 b=ErfUSmRqHOSGRLPsvSB/p8uOuOXVtrd7tFA758XaIecXcF5SLIdm1x7pYRfV8WOjA7lA
 cmoved+dxR5tw2LyNLgyRHhdqczVLDy7L8cGFDveP/8zilC83jNuy3C/JWezZ9sDB+iq
 qCOlWW1U3bg7GJKV8rUFSHg/xMxhWEvtrWthoyuiNWY4Xg0JVlng8eFY4KQfsDY3lkDk
 1N2e/0Gw2eR3+WVDezVKAUqqOlUDrmT3BOTMfXfxbVPOFx8DV+B0lo/SgMixp7FzMsQa
 ErFgwAbIWcO/2xk1244hszfKkmoI6sZ/JLAiv2zbiNFY53aeVambxrWphWzbYczyCqZl yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud75ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 11:34:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C9xh30000797;
        Wed, 12 Jul 2023 11:34:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rqd2ap752-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 11:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZyvDhLV3xsexpbqkHfDsW4mivgSo2wbxAIv1laRMJOm2ffGfhjqaUZK024RHqK3kdh8lWLKDgSgVcHUuTq3bF4wnckap/rJ0twslhm8nCnHuJXo8Rs+R3fn2XeAx55sn0Rce3So9VYbvzSrjUua4j2vS0Ht5142Kmlqv1zbWAg4sm/qbpVYb3I21yYXtwFvlHoZoU0ET6InOeCJb02gZJ+r05CGw2iIREGFQVrXPTEU5CCrkZdu8ilZyO/J7sXrsAo/H26CWSxguuii4pfxySTc8p9r4ezC7QdKLh5ozCyJ4fmaynMR6ZiGLn1flUk1SDg/Kt98BklhMx2oO6duwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOVlDKQH1Pcc5u+SIT4QNJAMde1SOGY+5P75OCQ7Abw=;
 b=dcw5xrg1Zftuar63nZ+0nbCjIK1RdMSpTt2OAcYmtszJVYf+xH5ulWIPj75JEUpmBFr74kieHMr1X5ikinPONN/ipXxPXgmeF7IODgJ5mgBTLBEntFy9bgoekjSV+Zde7YuUG9OSzPdhJqWqIluR+8tbrSkHTdDPSO4yZpxh2V5rOJdkQwcl5gt+ErtFy9phj9EY2rhct6fNh20ZIw1owKraD3kvM+fCt5tMxWoGfguokoXBMd1DLPFptFJ/gfoDvQ4euFjdsXas2t7q9mQ9tN850lfZzXx9YfUq1pRFThKsdTZXm+dVtY2537EA84jRyqIHWDr4GkXJlbgvJmPV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOVlDKQH1Pcc5u+SIT4QNJAMde1SOGY+5P75OCQ7Abw=;
 b=qG1U+69k4zGoJi3uFQLA6BOf+dO8aVR2fYfnJS97cQCxCmkLD064Tq//l1ZlpUCrwX0Vy7s56nY3b8ASz6V/Tbkr0Y7+gosEufYRnp+/8yllm2C6D0yXKA5yIH/MZl2jjCwycRHZdCWmQudUaelXX2DQnorlwt6aKJry0j9Laeg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM8PR10MB5399.namprd10.prod.outlook.com (2603:10b6:8:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 11:34:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 11:34:03 +0000
Message-ID: <034c775e-c0f1-9bda-df6b-80c068dfd69a@oracle.com>
Date:   Wed, 12 Jul 2023 12:33:57 +0100
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
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <d0317185-4880-5504-2ca6-bab3fe30faff@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM8PR10MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ef2fec-44c2-47e0-2f6f-08db82cbe491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZSY3Uqsxtuj56/+EsOn76NBkPoh44cuubEuYld/eevhodRkkuIbi0mNGHrEo4wH8BPb1CLq1C/xpVpuEU7peAupUZnJdBFzWbqY4ptXcC/I/YQED0iqHGhBfNQALVCcBUJwDv8Rbb6r3d+r36NCMMU9I4+clGnFDMJsFSDQ1ND3HL1FYqTSu3UI6iB15aquHG9n1ChK4ChIi16O64HIWummKAgunszXX4rt1fJjpIM5pZbovJvpbK+J36kcKn9A1IlBLQiIW4WZwlV3s8S+nm7E6B7J4kT6kRfHXMenTNxEbf/0LhET3oUyDefjnpBYfa/RKWmOXuZA6QTM25/LlJ2+3MRP7QHBMKflLLnhq/ezFu0TMEp1XdHWMS5tniv3KBAHwpKmu8aUaFit7qotQtagcGaBL+NXyW7byeiHCBz1ssIUpL7i1vt3p7iDUSZxNdglkY5MxLQZ8R7Qr6iUF6dAAkQZBvfycvf0mPIgA4Uz52w1OBRzFzGdkA0oNQIJJHfIu3VubRlMCSWIr7BJA+yCEqS6hXjDfkf0PgvuX1q8srDOHmRfuhLQ5jYu4313xulHl87i8QtxYMAl8DHFh3PJJqggpxchLsRLtxfkwd4tATeOLNXdu6O8qU4hFdzkIJavQgHcefLVVE5X2jPbcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(31686004)(4326008)(36916002)(6486002)(6666004)(478600001)(66476007)(36756003)(66556008)(41300700001)(316002)(66946007)(86362001)(6506007)(31696002)(26005)(83380400001)(2616005)(53546011)(186003)(6512007)(38100700002)(8936002)(2906002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTlMaFVJb2xORFNsUDJFV1ZtTVV5UUFhNExucFQrY0ZVNGJRZUFld2VoWktD?=
 =?utf-8?B?dDk5ZGh2UklqYkMzVDZVeldZNi9wVVoxbDRFR3ozVVNKaGswSnZvSnFyUnMv?=
 =?utf-8?B?V2FqK3YySnMzYlZaQU1qVnI2dFZIQloxNkZYQXZha2ZzTHVtZzJGaWFjckVN?=
 =?utf-8?B?Ry9NTDliY3BzcFN2cmYwdjkyL29id0pOL01WRWYvNndLSWFoK1IzQlVMaU11?=
 =?utf-8?B?d0U1UGhzL1I4SUp3TmdnRTZJNTFUZDVEZXRYd1JxaXVWMCszRW0vWmVkVURB?=
 =?utf-8?B?MEZxUTN6UTBldUVuV3dKTkR2ZG5sTTlhbysrbStPRHp6MU9oK2taQ29TUXU4?=
 =?utf-8?B?Vk1wTFRPSTZRUDlia0dZRysvMzl4N25LZjk0eFp5cUVmanUzN3NwZXpwQ0tw?=
 =?utf-8?B?WlpPeFg5MVpRTU9ybjB5MU9FQTUya1REOGQvUjd4Ykg0N0wyNzU2TlJ4MzhV?=
 =?utf-8?B?WUdPN1NQeHg4dVg1Sk5UcHU5OVgzeXo3ZVlGMEZzZ3Z3bS9HaGxWU0ZCODd4?=
 =?utf-8?B?NFpSaEtFLytkb0p2Q0pobi9tVGFweS9MQmVGa1BBY1ZXcUQvSWk5Q2NZRm5P?=
 =?utf-8?B?U2o2bXZxME4xSFdXanFoL05YWnZUN1VscWVZaXk3K2Q0VTJPRi8veWFQajhu?=
 =?utf-8?B?SHUwRjZOSnE0cVJVRlBwU1dIYytIaFJYRC85QjhNc01PbjdSYW9tSkZ6M2Er?=
 =?utf-8?B?TkwyZmpEOHdJVmd0OWtJNUllSnBSclZWcGlKUzRmSDRpalRVTWdTRktndVZW?=
 =?utf-8?B?UTVtaTJkODY5Mis3Uk9adk93bTZlSnV4eXd5cmxDNkZ5TGZZaGllL2syNmVY?=
 =?utf-8?B?MllOdGM1dCtDOTIvQVpxdVk0b3luOXh1OU5KYk5hT0VUOU5ROXFQWXpnMHVv?=
 =?utf-8?B?MlNFWXBwcnBvWU5zTStGcjhrNVdsNTNhMi9NRVRxQjJxY09WbEJ5VEpqRGxR?=
 =?utf-8?B?R29oNFhtenM0QlM5TGlPcmpWZ29PVndxN2J3czR4ZE95K0QvVmQySDBabkFy?=
 =?utf-8?B?NVJkcWtqSUdQUkVLTmJIeFhIdWJ2L2FLamZCNmFZUnFYUkVPc1JNZlV5SEkz?=
 =?utf-8?B?QjJQSTJNMWsyZ0tIZzczZkluWGhUYndEWlVjdWFQUXd3dUdwY1NybFUrR1NZ?=
 =?utf-8?B?UC9nS0xyUXVRN1E1WEgwVmhSc3ErWTV4UnFnK2M0U2RwV3ZsN1BJWHI3V2pN?=
 =?utf-8?B?MEp5cFZyNU01WnQ1eTRqZUJlS0NuZHBqa0VDT01RV3A2UU5UU09jSVNUY3RX?=
 =?utf-8?B?dnlwa0lHMXNuUW9zbEtoL2w4RjRQSjdoQ0x0UDE4d3RDKzdYUG9CQnRlQ3Jv?=
 =?utf-8?B?YVlIOVBoTnhZMTVaL1JOTlNVbGFtMGtMcVd0ZUFBNlNiRWRwKzZkYjRNYW1p?=
 =?utf-8?B?czBiTVl3UWROUmc2Skk0UVR4dWpOZHNyV29FVG5vRDBKd1Y3SEpEU29EZFUr?=
 =?utf-8?B?Um9sVlppQjB1dC9oS1BpSmVJVENKVXNjbmp4RytmdXZIellyeU5hSzZEWXdj?=
 =?utf-8?B?bzA5Vm5hb1BRZ2N5TkdscTZGK3JJQ2o5Mmd6cFE3THN6SlVVeE5iNVB5ZXha?=
 =?utf-8?B?ZlpyMUQzRFRhdjRML2VnZ1pBUkw0SWZuWHhsWGR0NUxwbTZ0SG9MUlB3SThR?=
 =?utf-8?B?bXE5OEhaQ3BXdlhIdjBXTk1WQWtza0trNXpEZWdMVkRlY3hVd3BibUl2cXEr?=
 =?utf-8?B?dEFXTVVML2Nvc0t6VG1yV1dZcy9JcGhtYmN1Nmo3YUpYdU9WSW8yczZDUU5V?=
 =?utf-8?B?VjNNekEwU0lvU05BR21wZ0RWZXFQcGdtbGFkcFNvS1RNVEovelVpZWpXaEZx?=
 =?utf-8?B?dmF4eDBNaHVFOU9DVFI2b2tjS2VyMENCMURaZW1ObnU0UDZXTVhCL3E5a3ht?=
 =?utf-8?B?ZXVxVm9vSFJ3N0Z6Y2xDeEFCV3Vya1ZqYTNZRjB5aDk1Qm12RW10SGpwMGk3?=
 =?utf-8?B?NnpQQzVVR01sbHNyLzhqd1BjSkwvejMzK1V1WUhSMTZzcHpBSE1MZG1vU1Iz?=
 =?utf-8?B?ZEVvcXBORDRlaEJ3ajhQMmpTMm5JWEl5VUNWbi95OExrZUZmRGIrZnhrckZw?=
 =?utf-8?B?RHFaUG0rTGpoeFUrVkVjcTdBdkxNQ3kybGhhYmJ2eHpWNldzUTFhSE9YOWhp?=
 =?utf-8?B?dW1xUG8rZmxZbVlRVHF6eVVvOWc3ZnlIUXZCRSs0R3FkMG1tUFZWUVY1bEdj?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Tmh1QUg4ZjdmMWRTdFhLR2cyS1hlbHF1aWk1K2FnaGdOdHZZYU16eTNRUHNN?=
 =?utf-8?B?MUp2aHRRdGIzQjZFUDVkRXEwRXFhaW1kSS84c3NDa1pLbndUMnVTS1lybTNU?=
 =?utf-8?B?YzR3b3YrRXY5UXN6SXNCRjRCNm9FK0I4K3JxVlc3bnhDQ20reE5sRWVJbVVS?=
 =?utf-8?B?OU9zdGZRbEozNHdBMmZacnRBM0FlcmxkazdVRFBYU1U4MDUvZ0hmTTN6a2V3?=
 =?utf-8?B?LzZOUU01cytVV3hJQjVjYTR1VGRqRWdHNkEwS01ZVGsxOHZ0U0FQRTl5bmNC?=
 =?utf-8?B?RzBuZC9wYkdBWVhhckdGaVBUZStWZVpNMDU2dzg2TDR6V25ld3VZY0hBYzZj?=
 =?utf-8?B?d2ZPUU9nRy9PS0FsWDVrUVhwRzBJcWxmdGZqcDZpVTM5MmY2Ylp3S1VwTldi?=
 =?utf-8?B?V1ExQlNKei9MaVpNOWdmS1JJT1RxejU1cmxGMlpXazJucHQza3hRa1FFaWg5?=
 =?utf-8?B?YlJQa00zMEhXbnkwTWFzaDhDTUMrNWpVTGFJQlhrTEZRa241cG9DYXVtaUl2?=
 =?utf-8?B?Nnhmc2dOYVFIQ2lRRjN6Y1g5RHIxdTNFWGIwVkoxZ0t6SGQ5bUxMV3BFNE9j?=
 =?utf-8?B?anFDU0FBY0QvSTRMbVlXaFJmQ3E3cFk0RnYyWkpScC9PNE1RV3Z2R0czVzI3?=
 =?utf-8?B?Vit0em1EckxteDJPbVN6aktWejlmWlFiZ0UvR2kwN0lMTjhMRk4yaHY3cEJp?=
 =?utf-8?B?N2F5WHI0RlRHaUFPL0lFWVV5THhPV25HaXdqV2U3alFWaU1mOVZLS3pqOG9l?=
 =?utf-8?B?V2JKNjVidlhpZ2VQSUlRazBETktXVVQzcllBTkFmZU1CcjhLOGpEWE5RTk0x?=
 =?utf-8?B?Y3NUb2phdUNLbmo0bVBIYjJYd0FWcUsxRDBtV21PUG1abmN0clRFcFN0Qmw0?=
 =?utf-8?B?aHViMXdvSDVTWVpad1puMVZsUk83czZTYlFidEsvUkxFejFVTXVOUFdHZVNV?=
 =?utf-8?B?UVhjSHFSdWdUU01WY2MwMG9QZ1ZUQnlwTVltNU9kTTlIT29UZE1Md2ViQWZD?=
 =?utf-8?B?cEZ5czA5NkJSNWltZU9JQTVaM0EydHhDOVUrc01aZGtvNWQvUHQwbU1BZ0pW?=
 =?utf-8?B?YlY2eVRTSGNNdXJwR2hRZTlIeXZLSlA1bFVZWm12dVBGNmhzMWpUYUx4UTg1?=
 =?utf-8?B?eG51SXVaa1BYdUhhczZ2WDlpZnJXT2hCKzVKdC9KdkFBalZNRC90ZUluRUNE?=
 =?utf-8?B?UFk2MGlzWEswazFpZGJqUGFXVU02dElpczYyVFRRMllVZkZBQ1JaVzhUUi9y?=
 =?utf-8?Q?YNY8B2zIaxKreSf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ef2fec-44c2-47e0-2f6f-08db82cbe491
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:34:02.9851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64d3qq1FVx6waPrzIQF29W1hKspS9Npr2f6lAbah1Oyutw1BzX8zuzrE1ReNrlOB1Mwy4w4+32prnaHlXKswTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120103
X-Proofpoint-ORIG-GUID: vWXZmbm563PlnHOuodRXwsJYM08jxQL3
X-Proofpoint-GUID: vWXZmbm563PlnHOuodRXwsJYM08jxQL3
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 12/07/2023 12:00, James Clark wrote:
> 
> 
> On 12/07/2023 10:22, John Garry wrote:
>> On 11/07/2023 11:18, James Clark wrote:
>>>>> The highest valid version of json files should be used,
>>>> What exactly does that mean?
>>>>
>>>> So it seems that you have CPUs with matching MIDR except variant and
>>>> revision, but have different events, right?
>>> Yes. In this case we changed how a metric is calculated in N2-r0p3
>>> because the workaround that was needed for r0p0 is no longer needed
>>> (CPU_CYCLES should not subtracted from stalls for topdown metrics
>>> anymore).
>>
>> If there are only very subtle differences, then could we solve with
>> metric expression function? We already do something else like this for
>> literal #slots for arm64
> 
> Possibly, but I'd have to add a new mechanism to expose the version
> numbers to the metrics so it can be used in an expression. And I think
> it could get very messy quite quickly and make the expression hard to
> read. In fact in this specific case I'm not even sure how it would look.
> Something like this (where #p is the p in r0p3)?
> 
>   {
>   "ArchStdEvent": "bad_speculation",
>   "MetricExpr": "(100 * (((1 - (OP_RETIRED / OP_SPEC)) * (1 -
> ((STALL_SLOT - (CPU_CYCLES if (#p >= 3) else 0) / (CPU_CYCLES *
> #slots)))) + ((BR_MIS_PRED * 4) / CPU_CYCLES)))"

Could this formula for "CPU_CYCLES if (#p >= 3) else 0" be generalised 
with a literal (like what we do for #slots)?

>   },
> 
> In this case it's not so bad because we don't need to compare r as well,
> but I think it could get worse if r was non 0 or there were more
> significant differences to the metric.
> 
> It also doesn't scale in the same way when we're using auto generated
> metrics with the data that Arm is publishing. We're going to treat CPU
> versions as a completely new set of JSONs if there are any
> differences/fixes in the PMU stuff and just publish a whole new set.
> That way any tool that's consuming these can just check the MIDR and use
> whichever JSONS are most appropriate.

So far we have got away with ignoring revision and variant - why change 
this now just for these arm parts is a good question..

> In theory this shouldn't require
> any manual intervention or re-writing of expressions. And it saves every
> tool having to solve the same problem.

Sure, but we have tried to reduce duplication as much as possible, and 
example would be ArchStdEvents

> 
> It's possible in the future that there are also small changes to the
> description text or availability of the events between versions. It
> hasn't happened yet, but it gives us the flexibility to do that too.

Here the (handful of) metrics are subtly different between these 
rev/variant, but all the events are the same. It's hard to justify 
duplicating almost everything just for that.

> 

I am not sure on how to handle this, since we might be bombarded with 
support for more CPUs with the same MIDR issue and having quirks for all 
becomes unworkable.

Can you just give the idea above on literals/functions in the metricexpr 
a go, to see how it looks? Maybe Ian has a good idea on similar solutions.

Thanks,
John
