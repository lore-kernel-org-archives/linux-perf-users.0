Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9670EB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jun 2023 13:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFZNdx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jun 2023 09:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFZNdv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jun 2023 09:33:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F59510C0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 06:33:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QBZVUP018138;
        Mon, 26 Jun 2023 13:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bcRG8nTihSSLYUkjr/t7VLO2Fdf/Sv+TjVy9ONFe6dU=;
 b=IJ/HNmZiGGnfsPi5cp8aKdVp1Pt6rQSiWs5sh8q+4YKlx3pKwPHjVNKr0Wo/c9f6G0xy
 ckwvq4FyCKoZIhfifoVGbOUIeGiS87Qi7JNXy14j/XDQKMC5DIEpZsK+ZX28MEs4C3fh
 fXsIKu60IhkYVdIkuD0SxF7lRpKe/62esB6RIppZ3T8wCepF+ynpo5Z8Fu+5+kTRh/ox
 V29RAmxTdFbKZyN9sT9XWotwYIBN9byTczGDi7j2d93WfgFtQRHu1BlH9AjyOuld5Q5I
 0alLghm7rhVnCfGSfeZuQC0gKRyP0tJaVibvl9lxwKUmZi2mfIREy/IwtAx66M6mRYTb hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhcjqjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 13:33:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35QBvYEO026348;
        Mon, 26 Jun 2023 13:33:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx9k9dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 13:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzaVKb3F+7jV9EZmHBoSjoNPhr/Z5ZjzCJYecfIgdIP967ZfIhya9wtdF5A+RNQR8ZJhLQTRsXbMzzoufWdQ0iGGuYHA3pvGI/rGP65M+x+O88oA4rWVU+5F4DOc317bBfvcSLnO+Ge1q9qcQV+X5aCAXLii7u66rrdhf4rqVNnln+GB3iEVGM2s65pPYWpGqT9QkX7PEiJ7NjUoULgLyWO7gMIg/XWUiE0vy2rUfz7IJWTf+e6G8/RSKhUPdYuulA1+vBMhAEWwno1rO1hSMXj7xDAR7KXZmH7LOxWVEG1/lWU8PZW+vMEcN4eyX5J3AlYOEJba02SrjQ+FH6lXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcRG8nTihSSLYUkjr/t7VLO2Fdf/Sv+TjVy9ONFe6dU=;
 b=IyRUaY5TgveNYku8bL6pGAsKD0nFeii2AMxlCrRSYGhvu2nL0W1QTwaKWbGX1DoyeuicXbmfbmbdks2Dg6DQ1crt/MbEy80+f0uPZQ0t8bozcoCu4wUwEaYv//H4OQrIlBdN03khy8GsepdVN942OBaqehaHWRk2w9PXTpGqFhEueNKsxOR8GMzrrvSz4EAbg1lpWawvFgwBxODJ8nKa2nAyYsqJ2wFaXf2hjR1uu4OcOqqlIPaIgqrNRNYjcmjIAZ7oEkmMnw1HZ7yZlZdjRimkxsMKhVPauWqHPsAZ9F8iFyHzLbWQrfkfMxPQgvk7dWqGFSVqblMImRwxMdHcdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcRG8nTihSSLYUkjr/t7VLO2Fdf/Sv+TjVy9ONFe6dU=;
 b=WK9bJbNbOwuiroNb9mglpKiHwSRADMguZPBl9fXVP2G/cfLOjsuayLvbxAKj+GJzjuu16D0K2OvZxZZTT69nPZ7EnfG2pzi3QJ7H57u/yw4G4W4QenwMbSGC9tb+ue/gSMhd1AVl45/UIFEwkE1B8sTH9WW5FI/XD5ba77cyYLM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 13:33:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6521.023; Mon, 26 Jun 2023
 13:33:35 +0000
Message-ID: <5bebf78f-15ce-7aaa-eaed-41cd49f53d68@oracle.com>
Date:   Mon, 26 Jun 2023 14:33:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: perf test pmu-events question
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org
References: <151a8677-3259-0586-03f3-fb751782daa9@oracle.com>
 <CAP-5=fXDVUToBbS6z8YY9K0vh5Z=PHh83RZXX3=NugTEqFeXzQ@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fXDVUToBbS6z8YY9K0vh5Z=PHh83RZXX3=NugTEqFeXzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0088.eurprd02.prod.outlook.com
 (2603:10a6:208:154::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 41bff620-8a23-4a8c-926a-08db7649f0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqgPE/L6kJh32um7/HIfoLlAq2V8T8baJXvMIQwnG/NA/iL/rjhFO+1+hHa9PUjXRsAEYin/TFeOX6GI8WNdau4jRv/YJP2EZ01G0ltdksQxtmWXEuPywsov23dKLTckOOkL2N0iaYdKDLe4Mzhsm+qPA7Y/5MXQtNjHfKUPTRWT803LRXZEldcvTTTPc+XCEH3MbvlUCTZEMSVj/WZQHmiaDZ6bZHmr4v0zh8JcIAwHq2HVOXuEnxrsknqoZRF3w2WNPOao4Y29EAy/qRz12JQwLxV1W41S0KqnhBNt8rE27cyi7rl5zfhuoZGmeN9huce1A7oD1rJzJmD2Kvzd6H9knUtuykN9hGk+/wHF7Slq4+KZb123iye5wxJChDXwDYpp40nV9HIEqeEY9Whh5G/8i2VeLa88BqOMKK+KbH6sfSOuVnGeq4fPl7niTOZRlmOlKGZ3m2QQFcDNNndrQMgq9w2CABX6ZOKrmfEM2qSR/uLsnPNGyG3mhdcu04QH3HfqZA+jxTPszg3iHc8oSNrGT6lmRPv9pgJTNHaGM4MAJeV7UX+TYH66AKZVtuugRI93MkJlHH/ir88Fu8Qkt9913LEDqBs1nzySCtVjQOk1G3JKfRNCr9ADChvk/eMyHm+ygjDXpmeItO1teYlyJAoLJYEkcdpHsgXgUY1FjafANJDLa+nXPbF4nMY6e96l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(2906002)(186003)(26005)(38100700002)(2616005)(53546011)(6512007)(3480700007)(6506007)(41300700001)(83380400001)(66476007)(66556008)(66946007)(8936002)(8676002)(36756003)(36916002)(31696002)(6666004)(6486002)(86362001)(478600001)(4326008)(966005)(6916009)(316002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGg2ZHNKeXFkVEVXTkdzamVaclFoTThtRW05NmpDWURQWDd6anZmd1JZZmlV?=
 =?utf-8?B?MU5LWmVWeFBKZnRBaGJzWW5OMHIyMnQ5NmpqUFhVMWlrWWpYd2JqQlZjWlJh?=
 =?utf-8?B?U3dTYzdZN3hrM2g5OGp2SEEwTWlsYlRZRTU0T0crOUNiQjN0cVJ0NlJ0QVYw?=
 =?utf-8?B?VlJzZWxsYUNUdEFYSUVqUnBjSmd5Q05GUkF5MlZySTMwU2ttV01DTVRVTGM1?=
 =?utf-8?B?OFNsaFJ2cTVkRi8yM1d3cHk0bkFVUzRRV1BqMHRIM2VkVm9mNllsMVJ3Vmh4?=
 =?utf-8?B?ZU0ya0N0bU1tZlNRU3k4MktZSmdjamxrZGgwRzlzUjVQM1dQUU1HN1I2SHlV?=
 =?utf-8?B?aWRUNTNjTlN6b2h6aWpLUUtNWVZlZDNUaFRpcVFSbWxnSE5raHZnWldDeGgv?=
 =?utf-8?B?cHJ1eTBTWG1ySHAzUlo4cnlYakpOUG1LczF5Y3Z6U1dNYkxiMWgvcXlzWll5?=
 =?utf-8?B?eGdPMzRyNlVxbldkc1JPK3J3NC83WU9kaHlJT0FDMW4xZ041TTlaeUtSbzcx?=
 =?utf-8?B?Y29BbmRHRUhJRXhPWWVVeE9SaGszeERnR0gxb0hYNWFDRlQwZlV5UDNpUTli?=
 =?utf-8?B?cEdpWlhRL1hLdVBkU1I1dDl2UkxDa0F4MndrODNnVDA1U0REeld3UVVJSjVN?=
 =?utf-8?B?eTBHdGwxcHI4UjRtQWZSL2JkMHRCT0JSN0JVeCt0cWRScjZiSWpPajloaWVC?=
 =?utf-8?B?OENScU55NGQydHlvcXNEaGNIQ0N4UEM5VkxWcHMzWlp0N2ZXQ091U0IySE1W?=
 =?utf-8?B?Um4rTGl4NHVZeTlSbDh2eUJUb1ZLNk1jWmVDaTcybjRaVGtkVjczKytIUW8r?=
 =?utf-8?B?TENFb25MR0J1MTByY0ZOTnM1Rmp3eEM1dng3b3NyYmVFQTJWbElsdUk5bXlJ?=
 =?utf-8?B?OUZUbDdMSmZCYVQzS3F4MTUyVnJUZGtkU0tYSzUrR05iSW9NaVUvRzJ6bXQ0?=
 =?utf-8?B?WjlObDlGaGZrL1hGc0VCeEtmZENSbFBMQTJFN0pzVGkyNU5lRGZyOUlLQUNJ?=
 =?utf-8?B?Y29ZUVZDRll6bVk3RkNaTGlVZWhmMzJqNkhUQ2tXU2Zoa2dJaFlOc2E4RTVD?=
 =?utf-8?B?Tk1tQndJYmhYV1JXMG1tZTFoNkNkTVd1OTE5bWM3a3NpaEF0UCtGclpiSjg1?=
 =?utf-8?B?MmNPQUxxSU5VSlYyVkxTTmlwOEVmKzVURlJ0UUQ5WWcwa09qRFV6ZTlWOVlO?=
 =?utf-8?B?N0RkZU1hZlN4cUVDWDNBSXBRT3ZyYlBVemkrV0NSY1ZUSkZhTy9KUEVsS0w3?=
 =?utf-8?B?Ly9HY3BCdjJnTzJQNG5OSW1LZ2dOdGJIZzlBZ1lVWU5CQURTQ05PSGtCcFBH?=
 =?utf-8?B?S2RUOGJsTWw3bUJqNERIM2h2ejBmRHJYUlNpU2dOeDhlckpTUHNIejlLUis3?=
 =?utf-8?B?RXNiOTh5Nm82Q3lqblZ5Nkt1T2MraGFKZUowcm5ULzFGdDltZHArT3lCUHY2?=
 =?utf-8?B?ejNNbXRJZXJWQm9BUUlBSmsreldsN0F6b1VQRFo0R3F2ZURtQkF6Uy84MHc3?=
 =?utf-8?B?OHN3ZjhHZVY3NHVoaDRPUUFpc2FZYU9aQS9veCtVWVorL0VkMzZDUXRrY0Y5?=
 =?utf-8?B?bVplQXFHazdReUJocXRSWG9oVUhUWlQ1RWFJTFBNV1hFYjVZYVJJOUx5ajNG?=
 =?utf-8?B?UkVCQ1VVd0h5eisyMXo1aHRnb3k3V3dnOFh0d1JPNDgvSklZbVY3NTZVaXpV?=
 =?utf-8?B?T25aYkFvVS9ZakQwTXRRYUhteW9sdWF5NzFhK3MrbTF5dFRSajR5d1ErSWRH?=
 =?utf-8?B?M28rMnFudXdvMlh6dHowcStKNG5KV3pCR1hxbHVUK05saXpOWmJDOXVwODZu?=
 =?utf-8?B?VTRmZGpFRmxwSmN2RmRaRHJEMzBRdnZrM0hMNERNODU4RzVUcC96a1FmN2J2?=
 =?utf-8?B?SkVDV0RJeXljSTdWUzlRVmlLZEZLUzJab3NDd2J0UCtETDRXYlVVTmprS3h5?=
 =?utf-8?B?VkYxMjRTWUMzb05IYUtxdnIxekxCWUFGQ3UxTTFNV3M5M2d2OThVRWVpQkZX?=
 =?utf-8?B?WFJHRExWSDdJU3ZsZktwTENQQ3VLWEhjOUo0UUNJdVR2TDF1czBBYmdNMTRy?=
 =?utf-8?B?TnpkalU3V1I5WHhBMUR1d2xGbW03bEpWVldyZVR4ajVKeG1kb3dmRkpmMWYw?=
 =?utf-8?Q?cBYddxQw+1/sredZsHFrUpxUx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PINewHJq36pLpNmJiGYiPLJysD8UgYqDNq3sE3NUuUAyyJ/xmWQYTK9t/tkdGe7Ara6PDfJdjW6F9SJWTFHq5qnE77e6iF+fWfuCk56oXr/ptwyE60tmd2V2JF9vczx1z+vFYAJWrdqJFaHKOsUgDv4ZREmVuERi5PrMyT05Y0vC2/HjhuDnMWQNGYRgd+LfZ6phalBYW2RTGhOFfnOoO/x4FxzBWgGiVwTMxW9IUFbkV4hdkX1sCJpUkxD0+QeyH+QCDYP8EZpKgqoVeWUEVXsTuZ87Z6XjUhZMUyuSkmuM/odRfz8Fk8mgjDscmnNZj/JVycbtY2E0rbmFXNX58ma57mQ7nevCIveaS/rdbE+ZLYDkQVLPWGXwiwp7bnRZzU3Or7d4nowOjZ60GdJlh9rjNFXr21Rt54ZsPQ7PXCVBjrembk0bm0Ipu7OT/ExDPQnDh4aqr8zjoMqhIQvv6G7Fv2qVXJrqtCKa+ZLpRVtbKo0A/Qgr/1gKtj6pYx6jByC5WFN0NnKm4ps0BPLkoSFQUraGjblkgxMVGvNInvxC3ERnjjTv0lgfaj94i060mje9QNUVvpErhtaJ1YBFnqPU7+ci4Grj7K/EW/6g1m/iFtlgsbY7U4+mUXSYkJz5DImk3exWpQQEbCZyAHX7wmQNLJ0AaVplFjX7pIKl1WwYS1twaEPdH4fzPqRC8tP8MLmf4kRZO5Mkr1v7fWtifMEvMsCMjEL2GIeXUw1/xv5HK8qepYz7pwrSeRS8JJ6inUZWpsnK4IIHqRPKTqR5X6JneuK/3eIFbccWeXioVi3W0ljqoJODhKH5mzLuqEun
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bff620-8a23-4a8c-926a-08db7649f0f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:33:35.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FslFQV9++i5u/EX1bDQuL+sTb2qzG5Z4GVFvEPBoPrnh0rqb2dpy8AmT6KgntPrcUF5VHrKXe7jseuHJlWK4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_10,2023-06-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260121
X-Proofpoint-GUID: E7vPFH52rHScuOU3J3U9O_2TIG8EJLFw
X-Proofpoint-ORIG-GUID: E7vPFH52rHScuOU3J3U9O_2TIG8EJLFw
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 23/06/2023 16:48, Ian Rogers wrote:
> On Fri, Jun 23, 2023 at 8:20 AM John Garry <john.g.garry@oracle.com> wrote:
>>
>> Hi Ian,
>>
>> I was doing some re-write for pmu sys events metric support and I want
>> to add more testcases - we don't really have any.
>>
>> So I noticed that tests/pmu-events.c::test__parsing() can pick up on an
>> invalid metric for the test CPU, like M3 as it references itself.
>> However we can't detect whether event aliases referenced in the metric
>> exist for the CPU. Is it worth testing for this? Would it be sane to
>> scan the associated CPU event tables to see if we can find the event
>> there? Or do we already have some per-non-test-CPU metric validator
>> already in the testcases (I could not see it)?
> 

Hi Ian,

Thanks for getting back to me.

> 
> Hi John,
> 
> we always need more tests :-)

Sure

> For Intel there has historically been a
> problem that the names in metrics and the event data will get out of
> alignment. There is a best effort test during the metric generation
> that this doesn't happen any more here:
> https://urldefense.com/v3/__https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py*L1171-L1188__;Iw!!ACWV5N9M2RV99hQ!OKyD56aIReczgaPkGD3MZ0yZ-WFe7qXps1aFyF6pibEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd88_AjTGW8$

Does that validate alias event support for the CPU? It seems that the 
specific lines mentioned are just checking for keywords.

> But still things get messed up, such as PMU names being mismatched -
> when this happens the JSON events just don't appear at runtime. We
> could try to replicate the event matching logic at creation time in
> jevents.py and that should do what you mention and be
> multi-architecture.

OK, that could work. It is limited to testing just aliases, which I 
suppose has some value.

However I am not sure how well this would suit testing sys event metric 
support, where I want to ensure that a specific event alias is chosen 
for a metric in the same pmu_sys_events struct.

> The metric test tests every metric produces an
> output, and this fails when event parsing fails, so this has
> traditionally been the way to find bad metrics. 
>We do have build time
> tests like:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next*n30__;Iw!!ACWV5N9M2RV99hQ!OKyD56aIReczgaPkGD3MZ0yZ-WFe7qXps1aFyF6pibEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd882X6fEUE$

This just tests invalid metric format, right?

> 
> Intel don't have JSON encodings for the TSX events and so they use
> sysfs events and this is what motivated the has_event test:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/20230623151016.4193660-1-irogers@google.com/__;!!ACWV5N9M2RV99hQ!OKyD56aIReczgaPkGD3MZ0yZ-WFe7qXps1aFyF6pibEN8nk0r4N5Y87MgV0twed_V8E8l7kjJd88rRd1z5c$
> 
> Some other thoughts in this area:
> 1) I'd like to get sysfs snapshots so that we can get things like
> parse-events coverage of heterogeneous PMUs without needing such a
> system.

That idea would seem good to testing other sort of uncore PMUs - for 
example, since I don't have access to a system which supports sys 
events, I need to bodge the kernel to support some fake PMU kernel 
driver for things like smmu pmcg.

> 2) The largest part of the perf binary is the json data.

oh

> I'd like to
> convert the json data to a sysfs style, then compress it in a way
> where we benefit from duplication between files (zip can't do this,
> but tgz or 7zip can). libarchive can load these formats from memory.
> The current json data on x86 converts to about 7MB of read-only data,
> but the same json files compress down to about 1.5MB. The perf binary
> is about 3MB of code, so doing the compression should hopefully make
> the file size about half what it currently is and do something to stem
> the problem of the binary slowly growing over time with new
> architecture releases.

ok, sounds reasonable if slow binary loading is really a problem.

> 3) I'm hoping we can do something like a unionfs with the in memory
> sysfs, on disk sysfs tar balls and the like, and the machine's actual
> sysfs so that we can just have one consistent view in the tool.
> 4) I want to make PMUs lazier so that we don't need to eagerly load
> all the events. The cycles event doesn't need json or sysfs data, but
> it is all still loaded due to wanting the PMU. This faults in a lot of
> JSON data on x86 that is then never used.
> 
That should be pretty easy to do by only needing to setup event aliases 
et al when we have events which are not from known config terms, right?

Thanks,
John
