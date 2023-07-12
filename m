Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3937EB64D9
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 09:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjGLJX6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjGLJXi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 05:23:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23221FEE
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 02:23:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C6D10r015157;
        Wed, 12 Jul 2023 09:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1kjtLs8uZMnZUwDAIRorvwhl2nq/Lusge/ZZ24z1Wfs=;
 b=ar+k6CyGLme+NkkKcimXgyAIuS00x/DbUbCbafNTegRgClnT7Ey97AzzBzz5U8TJZYMe
 4GA++thMO+dzup25Xw+edkAbRaXZoajzM4LE9Tkkq9WyesobK1ckVwr6FDZQY4AzVyO0
 EElNVhb18LHIoBDFzHmmnsFf9vUacGuX5HYapIYp1XkIv7UJ1bu+VSlGu3QYgZrnkrLv
 e8RcQpRS7p36vpovW6H6I9tTsgWmWrXwP8EGEOUpCSfgk63SrlcQZPmfTP2W/+AD9zFz
 yoy2gUuOtkODCvsR1ab2awiISS5pqixIWYlOTV/x73pE+22GMHQPN+W534dj2TSEW/gL UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr5h15err-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 09:22:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C80JV1033278;
        Wed, 12 Jul 2023 09:22:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx86rfgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 09:22:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUxSlR4iR2TympQc0tI/NjqFBBdhAqlxUGCsanfz4VoKYohGTTw3BcJAOqCK9hPnyDAc4XFOktbCvuQZVR4FngygnbSkdA6cF5iPk/HkflNeXUdPz3RROcwdKo9qqropSPRpXwLjASbF9uEYu6h3irnzL5G91N5BjIgCkzt2hlRF7wkLfLlBlGQqwHlmWi54OAM+KVE2Se1pzqvvSNe4KHhXdFo59ZwshWpUQPsulO3MRWMRXFcDohUO3uzL0L/XhQN/pl2aP1dLiXG3n5B/gcYBC6xICc8X3OiWhlpUirUuo2rFVH4gElH14D6PG2oSiHmp3i61E9VxJg3QHA1CwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kjtLs8uZMnZUwDAIRorvwhl2nq/Lusge/ZZ24z1Wfs=;
 b=kIsSZEYvod63LVRwXUOOPOVz/94MFw4BsazWNQueHqEXhcgYh2+ml0VoNbJoxlE56BXei/xuiLscJRQ/qhnjNzTTiDoKL/2P+Qsp4xhSpL21Xq6WIs+3p8ZPAHZu4ZqZ6PDB9lAGe7tHBJHfu7C3IQhY1uFL+jO+VS8IseICuTx+ENvehopx3ti1dP7PuSxnJTCHGhG+bd3dpoD31GzW6tJDROqQGiAv3qLu4dNs9eJHB0L5E84/um0oIAYjvvybVND0CYwxSxoU6e7ufB2YIqronzHfzdzDDsg1DqTxbq3+A5wl0GrDWVF3s7RYO2OGK8x3KZWGzL9olpxzZXfg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kjtLs8uZMnZUwDAIRorvwhl2nq/Lusge/ZZ24z1Wfs=;
 b=DOviz23z5QlQHW3L7cAzUxu2sm9gswkcahA+POIcTLyrpmQixjrKuLZ90cJeXZGpD5qmqzKIjbl1832CCdG93YpZlIvA1TYIkIBxeRyWEBYSDmW9ov5bGzrQXjwIWjPrmo1EeV0dnKT3Oub64/S/t1Kpa3htBTGJegnZvI3g5tw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6173.namprd10.prod.outlook.com (2603:10b6:8:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 09:22:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:22:08 +0000
Message-ID: <16699c8a-1b68-f34d-770c-d1a1283f9603@oracle.com>
Date:   Wed, 12 Jul 2023 10:22:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/5] perf jevents: Match on highest version of Arm json
 file available
To:     James Clark <james.clark@arm.com>
Cc:     namhyung@kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
References: <20230710141903.1595312-1-james.clark@arm.com>
 <20230710141903.1595312-3-james.clark@arm.com>
 <a35179ad-bb62-113d-3a7e-da4d2ec3c0b0@oracle.com>
 <1eb50ae1-8c7c-7108-d9e7-0422752c4d9d@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1eb50ae1-8c7c-7108-d9e7-0422752c4d9d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0302.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::26) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4cbc78-6fb1-4116-2c35-08db82b97736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOjN5ZlhvXynDHqYJD+91uNu+jslYhQkHh9q5QpIpHH+ByYTOplMKc2p75zAWbUc2KONHhNNCVBERhGal6Bv0kEBs1/U2IhTJMM8Ats4pJd74aMbpyvjAQdEIetOr49k/YhcHUOjtSZiKnBo0e4NP7/Be+zcXXvyvOD+6zZBuOG1d4gmv7crtfVlmAPwx15jdK1XyUvMduVIY91fjraIFC0TOadNbA83JEBtCamgMe8JwID55qJeaPyuvwTnMr5J+NyQVzhqQ4orX0vskzJ3nsMiXscxL7VUEe4IezNDfmwJ5eR7Yk5PuVt7zunU/BE6YcV7rYlCcuBvTmV5ElSyv+/KN/0bhoIEJTKsHf2c3Qnn+t2qpE/+kOrUFyenMZoPZlinnl1sPsHrHKbHTR7UDPcW37YA1DpRCjt/shka+jw+V+FYdS4NjLYiEBilkGo3jqUHLYE+PpPSETC8/P4EIo8aQxazr7+xxWdaSVi66Iy+1875+VADbuu+EnLNLAz4NohctiCsJHyL4DMoSRRoWKdROrVjJaBgtV1EJDl0yfZzLG0xekMxfYW1Y4mAOvmL029pEDrHQAGbtSsK9Rx962YrIuKLLKmP9CbmYIwDiBuJsPh1auMCff0W+x82dY9tEN/oqCdlivQ32fIz5sH1Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(41300700001)(2906002)(316002)(31686004)(8936002)(8676002)(5660300002)(66556008)(66476007)(66946007)(4326008)(6916009)(53546011)(26005)(31696002)(86362001)(6506007)(38100700002)(83380400001)(6666004)(36916002)(6486002)(6512007)(2616005)(478600001)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUZESlhiSHhKbmZRcHJuTC9hQ0N0TnlXZStCa3JaUVdoa21JZUFWMFdsUStB?=
 =?utf-8?B?OGxyNStja0xSUE1KNFRPQy8ySVdNcC90MjBGZDVTT2tBT2d0ckxDQ0ZKaUlZ?=
 =?utf-8?B?ZmpUL1FCMnU4eFlBbFhMZXJJOFVOMWpQOEdDU08xQVBjWUVOQlV2ZGhpM3Fk?=
 =?utf-8?B?cE9ibkFYRWFUdXZxN0RRbE5adlo5OTY4cHFoSk1CR0RNdUNQcjUxMzQzck9k?=
 =?utf-8?B?K3R0OW5GbTNCLzZ4VkpFdm0rb09wUmo3VVJZTElQRklsTlptQWQ2VEZLNmRs?=
 =?utf-8?B?MTFnQjZyZ3Y5OW1lcnUvWjZMTEt2K1VJV214NDBIRGtpSDVJZW9vOGRyWE9D?=
 =?utf-8?B?N2QvSWdrR1ZJZE5kMHdneTV0OHFwQ2pIZmZFK3Z6OVg1ZEZYSnN0NGg2KzdF?=
 =?utf-8?B?eWo4Y0ZEbTFRNSs2NGhrNjdVcStQSjhwSnZoLzVLSXBVY3FhUkpFbFgxQ3d3?=
 =?utf-8?B?d3Q0aEx1Wi9JSEZrRDExSWVyaEVmZm9waUdVK0RXaE9kRzBhNldiZXVkRUhj?=
 =?utf-8?B?emhCTm9nNUMyS2xJRVd2QnlmbCs5Rm5sbFBGdEVxMFVleTZ6YittRVNzcTlM?=
 =?utf-8?B?MTV6UTIrK1pwVDdCRlF1Nk53S0tURldZUXBKWUdJbjdRVGFGY3gzRXE2K1Bp?=
 =?utf-8?B?OEMwYWtyb0VYekk0aEJXS1hmUTIySjQvSmpxRHA4UXBuUFJlRXlTYSttOVhz?=
 =?utf-8?B?UXNHTW5rTlZZN09EOHhiMUdWZmNCVDZqWlFhK2VDNHhGYkZiVThFbXRnSkZR?=
 =?utf-8?B?ZmtLOHdpMEo3cWx4WmwvazJOZEVucHo0TGlOeXNQbVpGdlJ6V0J1L0l1RUl4?=
 =?utf-8?B?dWdYLzFvTjNrTGFkSGlUbkJOVUVyQUd5VFVZdldhazVveEZKL0VscnIvSTFC?=
 =?utf-8?B?T1U1aHoydkc1cGtXQmVScUV1a1N1dE0wSHFKS0NrbkNMbGxHb2ZCbUVHSkpZ?=
 =?utf-8?B?UWZqdElwWWIrWXVLa0NCajJ3VGlzUVNvM1hQSWhzSVQreExtamNEZWV1Q2Vn?=
 =?utf-8?B?c2hGajRQYVpjaTJqT3pvMkVZL25SckQyaXhnSDZmeHloakJLdzZ4SnIxalBI?=
 =?utf-8?B?RkRKVEZEb2lZbXBwa0VCQ0g3aVhQRncva3ZCU1IrZDgyclA2VGZ5b3U5YW1r?=
 =?utf-8?B?bTdEUEJQRVZZTnUyUnBMdjFFNmpVTEpRWXYwMmJaaklhaXYyQkNkVTVDQ0ho?=
 =?utf-8?B?NXgrMlNSQkROZ0d1SmFKT1RHK29NcFJ1RjdSS25qYjI1U0QwdTNHa3ptM20w?=
 =?utf-8?B?Q1BoMTJSZkplMWxOcDUvZGhEOE5JZ2NPN2FEYno5Qjh6bDkwOHNNVnB1ek80?=
 =?utf-8?B?N21FTnRvUjZHbVhPWDFZOVFnZ3pTQ3pFeG1WdUlhMk1qQUM5MXJrd0JRS1RT?=
 =?utf-8?B?ZllvWkhkb3NVcVhMMHBjQjZCYy9jTWUyb0pFVjM1ajZkbUxwWStmUEthdHAx?=
 =?utf-8?B?ZnVEaFBoVDVGWDBPRUdmVGxpSCttVkRRVVZHS3krZU1NRVUvalJjR1JkUFlY?=
 =?utf-8?B?ZU9MSi9pVVROd2tkUkZtQzFLekhLMisvZDlZRU56K0llenZtOVpQN1NVUnBo?=
 =?utf-8?B?Y2RQeDhqY3BtdEFxczArS2FQN1VUUHBQVnNvVlkyYXJqRlNKa09OTCs2dExT?=
 =?utf-8?B?TFF1ZmdiTXlQZTBBRUF1czNoWEJaVkhqMDlkNGpZZzB4U2Y4ZStTUjlVODQ2?=
 =?utf-8?B?RS9aaWxGUmVSN3czMjVQMnJORTFJSmxqL2hBdjBOQ0UxZ0tQalNaRjdBaFF4?=
 =?utf-8?B?VmUzQmtMckNpSUhPb3Evc3lzZFJ4dC9ESnl1Nmo5Vld4SmJiakc1RmlrbnBa?=
 =?utf-8?B?NmpiMmRBSU1FaG5DWGQxaWZxWHUrWjFXRWN2VUlsQ2ROYkp3alBNQzVqeVQ4?=
 =?utf-8?B?TGh3cXVTTjBnVnNIdnFSSkw1Z29qcEtYT0E4M1c5aEpFalNlbFZmbXZ5Unh4?=
 =?utf-8?B?ZktFeGxzU2l1YnhIekhqdWVJSkcxcEptQzlzZkhOTEJLa3NaV2tJeUEydmZt?=
 =?utf-8?B?T2NqUFNIanl4TWNFNzRlbk82TjB2VWErYTl2aHhsWHpIU0FKYjNwelpIK2xs?=
 =?utf-8?B?cGRoYkdjekJiZmlTdGtXa1VibXVNdTFKSk9oQjdCVUhONFF2OE90V2VTTURj?=
 =?utf-8?Q?fWQ1jmY1G9TP6wBAPhIQWefRQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Mk0zUlBNVHpwRFZMTHZHckdPWW03QnVER1pPSXJmN1hTdnNJYzZ3SThpdGcw?=
 =?utf-8?B?VFhDQldBakswRFArQ3JBZHVXMnc0SXVmQ3pWYmtERUJEcXVSUm84bEZxd21p?=
 =?utf-8?B?dGQ0b3YxdXNWcHo5NFg4Y0Y0aFVJRXdKdEdxYWpqSXYxRHhHbllpMTVwWCtE?=
 =?utf-8?B?bEFjYVkybnpkWDRJdjFnY2JObUNBa3ROVkFuTXpWT0ZVVDZGa0V6ZjJPQXNK?=
 =?utf-8?B?MjEzWVNTeDltK084YnFIN0dTWHNHSm9oUng4VThFQmlzUVpYOWc3bVVHY3NJ?=
 =?utf-8?B?UHQ0eW0rY3B0ZStmSWxSY2l0Vys2akxjNmlIV2dmVVloaE1jS2xWeUgrSVVI?=
 =?utf-8?B?dDM1blFqbzAwb1podldkNFpGQTRoVHgraWpPaVVWd3BtUllxd21wZC92UWR2?=
 =?utf-8?B?SFdPNHVZRzRjaXAxTmNwckJ5d09YQ2hQbnhxRUcrcHQ5N3JLVnVtdlFINkN5?=
 =?utf-8?B?eW10NnVsUkxueFF6TCtvMmtLbWROamNtS2dTR0w3M096VUYxTlFvQzBLTE81?=
 =?utf-8?B?OVl0K05vZCs5cmgrL0x6TC9UQ3FPOG41Q0didGY2QmdVYk1IT2Y4UFNmaXJu?=
 =?utf-8?B?MUhzZFJFOUVQQWZpZjNJNENROGJYakE4WEh1a3ZOcUlFdG9ucmVlM2xsaUk5?=
 =?utf-8?B?OXYvVkpaeFg4NENCNlNVb0N0bWREOGppNXBtYyt5WjlybFhESWRoU2pVS3BZ?=
 =?utf-8?B?ZGU2bXpCRVExQUE5NkVHZktRNGZUYzY3V2twZXJMS3Q0Ung0RmYxamZGS202?=
 =?utf-8?B?eXkrRGxORHVDMXhQSWxTU0U2ZnR6VzlyK3QvdWdqMDhndEw4NzIxSmljUGpY?=
 =?utf-8?B?Q0tkRm5rK3BuQlEvcEJDZTNYck42eGxvZ3A3d0c2dklTL3g5RzNkVWZYWHNz?=
 =?utf-8?B?cnZ1R3VGYk5ManhPbDNkQ055UHhQL0tSTWw0ODcrbjl2ME1jN0djMXJpTWdn?=
 =?utf-8?B?T2VjTVIzeUxab3FWaCtVSUNOV0hBRHJid0dmMHNzSGNnb1J0aC83ZUZHbmwx?=
 =?utf-8?B?Z25Zby9yMmVuR2ZTNy90TUZhbWhWYVVycDgvUllnaXE5WUk4RTNkWTFqRkdv?=
 =?utf-8?B?MnA0U1duYlp5Yi9JaVVFMmZHeWJmNEFldThaM1EwNTVrc1d3VzMvOXg1MlZL?=
 =?utf-8?B?ZEY1MVMraE5Mc3UyYUJXS0x3dGhYTHVad0h3ZGpyeTJjVXJaOE5mcy9tbUgr?=
 =?utf-8?B?b2E1SDJDNzRMc2lPdUFpeTZGcWYzODJ4Ny94NDA3MFpZRkZpKzFqQ0Qyc3Zm?=
 =?utf-8?Q?l4w5QdIyyQxMn2R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4cbc78-6fb1-4116-2c35-08db82b97736
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:22:08.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6E0SqjRJxApnpG6tLLSAtPG1otBya65LNNjQeDkCVrm4hbNTXnF31VNUFTV2dRPrt7LKNl8iX+Emo9+uHxqe/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120082
X-Proofpoint-ORIG-GUID: EZUhPtMvJ_MGNp19ORrUYtVS3F90uNGi
X-Proofpoint-GUID: EZUhPtMvJ_MGNp19ORrUYtVS3F90uNGi
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 11/07/2023 11:18, James Clark wrote:
>>> The highest valid version of json files should be used,
>> What exactly does that mean?
>>
>> So it seems that you have CPUs with matching MIDR except variant and
>> revision, but have different events, right?
> Yes. In this case we changed how a metric is calculated in N2-r0p3
> because the workaround that was needed for r0p0 is no longer needed
> (CPU_CYCLES should not subtracted from stalls for topdown metrics
> anymore).

If there are only very subtle differences, then could we solve with 
metric expression function? We already do something else like this for 
literal #slots for arm64

> But it would also support the case where the event list was
> slightly different between versions.

I am diff'ing folders ../arm64/arm/neoverse-n2r0p3-v2 and 
../arm64/arm/neoverse-n2r0p0, and all the events are the same - am I 
correct? It only seems like metric json is different.

> 
>> Then to solve that are you saying that the highest version of the JSONs
>> should used, upto and including the same CPU version (???) - correct?
> Yeah pretty much. It's highest version of JSONs starting from
> (including) the same CPU version, up to and not including the next
> version of JSON files provided. If only r0p0 is provided then all CPU
> versions match.
> 
> So if these JSONs were provided:
> 
>   r0p0  -  r0p4  -  r1p1
> 
> Would match these CPUs:
> 
>   CPU   |  JSON matched
>   ------|---------------
>   r0p0  |  r0p0
>   r0p3  |  r0p0
>   r0p4  |  r0p4
>   r1p0  |  r0p4
>   r1p1+ |  r1p1
> 
>> The cover letter doesn't mention anything relevant 🙁
>>
> Hopefully I expanded more in the v3 cover letter.

Thanks,
John

