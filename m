Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D7C11F64
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DF161369
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jul 2021 17:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhGARIg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:08:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59500 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229971AbhGARIf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 13:08:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161Gudmv008928;
        Thu, 1 Jul 2021 17:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=+L6vCzx7ds6nw5avTCerBIIv1A6GAu8cwzHkUYgbfIE=;
 b=Q+Ms2ac5oa0LiFsSmU6ITQy8ImmF8Lrk38RTDml0tNw29Z2tewS+o+FhL6P6Tpipfr96
 L4+842Ou5AUSlYevH4suyA9sbKgtQ8FfkEhxfVXuuFj6j1k077yMv78MZttT8IJIQlcQ
 Q4h7/u7QCygAgkU6aZVQ29Wq4qQGlg2wPl+0hRHuP2e6DP5DjyJPC48uB78X5xZTiUxE
 dddweXKKa/S5fHJ6nxizKLNw9LpYpuzKlXmZMVQrKmsefVKEirSWvuw/yCujDRldV5La
 GImPKddWc0eH0YJdmGRbIlSh14fSALnSBbwmLY9XiHy9A0FMHav3JbnGPVmd1OPMROrZ fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gb2t4bt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jul 2021 17:06:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 161H60mL139546;
        Thu, 1 Jul 2021 17:06:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 39dv2asybb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Jul 2021 17:06:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyiwQ56QVt4TaEjT97UrGz8ecSjaj4lPvCKPzSslOTTDMq+FZQe2G1RasSd5/tqrh/LNNCW0C7YudWRQmmwcYwRgFU9EoN3itcoX94lrc07qavy5kychmotQMFgOP6GWQavYK6cYuZoQT96G1eSSf9v7HhffUZqfDdQkJ7SH3g6tz2C5u3M8vDl5wnBBh+PIx3NzhbfJ1oK6zvsRaYjRpFcTQn8DiPtBF95MihjuGp1rcFEiaj4w0Ddn32xM3fNeGesQoZXvj/nE8scYFly8XE7a/1uqh75Vn1VwIxuyw98yn/C27nUKyi/IFABYlNWxDuWNi+v15eXbnQXkgw5wMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L6vCzx7ds6nw5avTCerBIIv1A6GAu8cwzHkUYgbfIE=;
 b=bH3wI+cnmRrO71/zt6tyTUf0GsYFGCah5IQLG6bfLgN2Y+jfnWH/YRSoZTJjWeIFUENAu+C9kJ0xYMZOzkFiVd5v2YTmdsiUjeJDX7ICBo2VHfq1Jam/alUha6u7YUF/eIdx5L+ldHEidrEViEInq2XmNPovSDdV4ca2HbMeGBuSvvSCd8LTdSYGLYuR0TAUXLLdQLHDocVhHf1bm92wt9qdOI0cOxapaFZw0nL8ZNZAI22fbda9i6xjMnmgvQhgoiKNDpgq7GYRbtjLFx1vy6SalvefpSx7xN0qztpzJzySSnv8MpwFh5zCO/F0X7ey5OCh4yLsEQDA7ioJJ/X7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L6vCzx7ds6nw5avTCerBIIv1A6GAu8cwzHkUYgbfIE=;
 b=WG9Z6gqQEQQWIdGptHqpYroltmwlgOklPMQhrHFXY9hqYxqOssc2ewbGdqvAUOO7TtD4KAkHPerfUqku2qfZt9o+NgusA3MaXsfH0uP0x+S8W3LjdYrscXtrve96xUv8qIJzlNOWfEbLfjbU5GD1tU2sRaq4DYxAV+fwlBRSiiE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2823.namprd10.prod.outlook.com (2603:10b6:a03:87::15)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 1 Jul
 2021 17:05:46 +0000
Received: from BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412]) by BYAPR10MB2823.namprd10.prod.outlook.com
 ([fe80::3574:8df7:f5c0:d412%4]) with mapi id 15.20.4287.022; Thu, 1 Jul 2021
 17:05:46 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: Perf loses events without reporting
In-Reply-To: <87im1uc79i.fsf@stepbren-lnx.us.oracle.com>
References: <87lf6rclcm.fsf@stepbren-lnx.us.oracle.com>
 <YN2a3pSvealjK6uR@krava> <87im1uc79i.fsf@stepbren-lnx.us.oracle.com>
Date:   Thu, 01 Jul 2021 10:05:40 -0700
Message-ID: <87fswyc6cb.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-Originating-IP: [2606:b400:8004:44::26]
X-ClientProxiedBy: SN7PR04CA0114.namprd04.prod.outlook.com
 (2603:10b6:806:122::29) To BYAPR10MB2823.namprd10.prod.outlook.com
 (2603:10b6:a03:87::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8004:44::26) by SN7PR04CA0114.namprd04.prod.outlook.com (2603:10b6:806:122::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 17:05:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c05b5f2-24ab-431f-3be0-08d93cb277e2
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4573:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4573863ED2BDBFDCBEF78EBFDB009@SJ0PR10MB4573.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEzLpuKRl5rFFQln1qvgzxOAqiyFzKow8cv1/KfXX5Nghfcc5IJ/Rls0xcDj5thi8WCJHYE9sgE9dTcCfTlpDHqS417dYQDcVMVsc8ee3+ZrhTsKCNKp9SEiKnw5KpVatfoJMZMDxRZKEHyZgVQ7kzMICxYIFbSaiPuHfAYIUvXJyaIvVlLYtNT2VTSjX7ajcyfpEz79wuoj6pO3j+GZwax5Im1cmzSePWUEnvqH91eyoMFwCDikj+2Kox509LGTSN+m8wULfHZGPNihmv+NK7Jumjl2h3y9QmAUGQzg9OLnS4IanxmkrOBW/eeo8b3zqZg+E7vjtUdxzaRDaW35/czotTViRMSZz4lyWn6BMv1QoW79cdpu4Y6TDXzU3zIlTOc9JQpnunft5VwVmkFTHa1nRua26WOsolIzH7WGSzyMVBjFR9OvGWEdW200KRSx9LHrcqNDhPgnlrYZdK/x6/8NdSufwEXBC8gaxRnxW1K93IQBveP0Tq4bNEJQ2mRlQdmYaafSKTvt1wXFdC0lu1nCXjQ+I1R8d3YqSH5dcMVkhEdmrhO+Se5VAm9V7Wl7qKaO0bJ2UPtnh6fZmGNNoQ7aP+IUC3gZ5NfKXwXgH1rdYUTh3DBeDVj4rCd0AYf7VDrCxRPjDchUvAj5mIfF+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2823.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(346002)(376002)(396003)(86362001)(5660300002)(16526019)(186003)(66476007)(8676002)(6916009)(66556008)(83380400001)(4744005)(66946007)(38100700002)(478600001)(6666004)(6486002)(52116002)(8936002)(2906002)(4326008)(6496006)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8a+fVOg9BS12DtjJ5hEkFs2DgTONH0mZjQFX4FdyZR7x++lf55OjQTiSFaOX?=
 =?us-ascii?Q?St+9CnkbEilXo5Z8wUKWy+t5KAjphheIYhDu1wbq46ENDipAoICukO6rVgtW?=
 =?us-ascii?Q?WKvErMmRKxhIK+mgi3NHIB823/Rh60XWIp7rJN2PblOykCsfabVoabWjmvSA?=
 =?us-ascii?Q?S+jKDPsfgwjRGFzAGZX8ah9EuZez1gXhMRhtYnX0R0lgWuL/OuvsblDWSFax?=
 =?us-ascii?Q?tcqrGuq/0JBAXGvhDlucKjye35PsV4GNo/9a3erEMbjuxqrZ0c13J2IfyzZn?=
 =?us-ascii?Q?l+gpGbzgOqtKlv2elawGdgVgy8q2z0kwpTJt+ir8FQXqIvNvBMQrnEeQ2raY?=
 =?us-ascii?Q?g5L/GEEYRdCx9HsrCo0Qs6qk5azq2fj01pogSTkA6yHcJJ7h6B9uib2KyzwS?=
 =?us-ascii?Q?Wnnh7h2R//jDXjJC5+eGzGKl1XCR0iSepEH3fKpZ8LS1s/7MfJuWoQ18Wdgd?=
 =?us-ascii?Q?i8gH89IBROjtA43ArP8UWMKkSQHdOi4+iEKbQOsl0PnqTDVD0qGJAZIlJ4ya?=
 =?us-ascii?Q?ntQuqtfdAr4lhGioYIV7HLKw0m3KmzKHuQe1Q08q/D5zFqPnrG2W9dYWeX+c?=
 =?us-ascii?Q?03N+EMc4Yk9OdIGufVAxlLYiPRWePxQmDnFgJi72HxvckPODOoX5ivqhhDtd?=
 =?us-ascii?Q?PEq4xW5ON92WXXzk0GVU9CwqujjzAdVJX+5AU13jLVF7GsilMRbQoQ7WOOUr?=
 =?us-ascii?Q?XdvSOYGo/mUoeS6QsZUtsX4dib2267r4+lNVQSYJQEUtSfiMhW525qeKjoNg?=
 =?us-ascii?Q?rNOQaGi51XeYEj/H9h8btXa292FqB9XonpgHaEG3J7BJA9n5b0qFShAPT9N0?=
 =?us-ascii?Q?8LISqWKaNuQWMrcPmt6kMi8iRVq/BuBSphy0SulywR7FOS9sxfrDRk/dR8+Y?=
 =?us-ascii?Q?PJB/s+pFf0zbc3mFveE3wdweU+xMFGJl4JSN4WapxppEAcBU3YgmDgmvLWlQ?=
 =?us-ascii?Q?UeNRJ3H858henu7U+/W+0oWsnc97ZSbkjauRBDwOFxKzjK5OJwH7uHrsNsKO?=
 =?us-ascii?Q?27JjkjIkGjeJHYgABLFpnih0DDvqnvWrjjy9nnjxt7AhNyTR9Nagaho381zY?=
 =?us-ascii?Q?VG4wQryRrqwyiBdrts3Wn2kF02OlaB4we3mgV4Q3QfgDeo1MUnOPspYzqR8E?=
 =?us-ascii?Q?vt+Ce7VrJCfxbSIeTHsXcme8ATx14eCPhuWbYtQcRbyUp9ppc7M5i0TODWwp?=
 =?us-ascii?Q?aO0E99qjzbT8KlZlmdhxMXfTIlqIZ+o8BdUit3fneS0r7l8mPM1/540bNfGw?=
 =?us-ascii?Q?EYcoGiv3C1ZV4DxLEN5NJhmDt2qsuFuj8ojOBbPCn6gjYfeq1fUmJKgTStyp?=
 =?us-ascii?Q?YkNaTyVHJChlV+fXKE3c1XKSdWVOtK4RX98x81mx+pWz1A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c05b5f2-24ab-431f-3be0-08d93cb277e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2823.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 17:05:46.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUUrBAAlPibDoiXjEYv+xUKNzs4CHszXkaT6SJTw+v0F5axB0rQPrCX2mhWLibtGgK6MY5m7CWZE0b4lg9H4SMZ+rZ7NqrZS1ek2iIij8M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10032 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107010101
X-Proofpoint-GUID: H7_31UN7RdHPHt9k7CIWMIpZxNFURYr_
X-Proofpoint-ORIG-GUID: H7_31UN7RdHPHt9k7CIWMIpZxNFURYr_
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> So hopefully this information helps narrow down the exploration. It
> seems to be Intel PMU specific!

Or more accurately, we only observe it on the Intel systems I've
checked. The AMD systems record fewer cycle events in mdelay() and thus
may not have a chance to skip events. I'll try updating my kernel module
to busy wait by looping until jiffies is above a particular value. This
would hopefully avoid any CPU-specific idling which would reduce the
cycle count on AMD. I'll update this thread with my findings after
testing.

Thanks again,
Stephen
