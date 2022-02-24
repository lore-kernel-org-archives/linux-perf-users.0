Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B6BC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Feb 2022 20:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiBXU6l (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiBXU6l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Feb 2022 15:58:41 -0500
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA241B0BE0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Feb 2022 12:58:10 -0800 (PST)
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
        by mx0b-00007101.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21OKRlqA022741;
        Thu, 24 Feb 2022 20:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=campusrelays;
 bh=SlJv0XFxIzmo0awXU2M8y6bm5vXA1CfXIIKqNvXGwVc=;
 b=DbZDLd4wGKSTE2jdTcUgv6gRxxU1R5V+vc2TYRQoCsdHjfmYVpurKtF+j0122HNjNHJU
 AQCi2bxmKm4VLm4MfbFz3JzqIfRCEK+YH+EO5xi4Mw5YZbXEEp3yHuLGiOMnY5NWWu7z
 LxvWDPju1Uyd1yrL5JTOy7PSPVkjjcsVCkHogZ8XunfwJfnHSBno0dSLd0klv2NEvod/
 qGja0HNxhwnQtzGkangIoMcyysNIqyVrhq/4JinzHukJ8PF5QxB4sMSNYUMLnsrobSr9
 +cs4TxXFYNCb0MTWi/0BH8TRpDfYJaxQwAZnsQ2zMwJv7AFZjXNsJsDmi9J6n6K90YJz iA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3edvn5968q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Feb 2022 20:58:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLv7QMPWaZXdryCQeDtViTu+dH1HArKYd/PfHFwc+/J1lqkG1g3Us+3XRsdUlywQhlcDnSe8D9sE6ydAfq/3cuXT0VSzfyV5c8MmmTFGlsuOMtjkgcLAR/oHJwtEjGgnTE6WG50itblJTfCBO6sAs8ONrUb5kFy04uJyWrfEpvd/L5GRWLQQV/bMJegMhr886zVTKyKLFULf1oSh8bg/I9pRK1KgmWYgjQSKxxhQtoWn/oaHiCxEXzs/dx23SemvhwPQkOpujlmp+MYt3Se2r3mIfDlpKBSGIrM5WI93aexagVfDk2FU4Fjq37wcUm7iWxDoavVuiuyYQYLSIPobxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlJv0XFxIzmo0awXU2M8y6bm5vXA1CfXIIKqNvXGwVc=;
 b=XBH2Rkp8s3b/ksEIZEfM8rbLqxtxqWMaP5XD+lwQKrlO6H44RsJOOpUxWXsmxJ0QoS0d/ekzdpGelL7EJupN81gTfHEv/U3ybD9gKqvZO6p9weS9mVtLn+xVf+NelMP5RptuG787ItsqZewCWOFxC5iv42vKvdieEMx9PdCX33H+HMOTeYEos0P6oWUDfqerA0iL+husX/gQARBxFGHTFX3B8n/C8h3AbUbnovDPym+i7AwXH41oPZl1w1JLXCicKx6dJa7EAPm20BbG8+AHrb5HiJLtXc+NcNZa9ZYSgip2Zk9qNBV3OCIpmpGmqfVotKEoP7XICybmAf8MGLOpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DM5PR11MB1962.namprd11.prod.outlook.com (2603:10b6:3:10c::15)
 by CY4PR11MB1831.namprd11.prod.outlook.com (2603:10b6:903:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 20:58:05 +0000
Received: from DM5PR11MB1962.namprd11.prod.outlook.com
 ([fe80::c1a5:fb83:ae12:935c]) by DM5PR11MB1962.namprd11.prod.outlook.com
 ([fe80::c1a5:fb83:ae12:935c%3]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 20:58:05 +0000
From:   "Mor, Omri" <omrimor2@illinois.edu>
To:     Ananth Narayan <ananth.narayan@amd.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: AMD Zen2 l3_misses event
Thread-Topic: AMD Zen2 l3_misses event
Thread-Index: AQHYJ3ysJZ7GLYeS4UGk6219E+7xxqyicMoAgADCrIA=
Date:   Thu, 24 Feb 2022 20:58:05 +0000
Message-ID: <27A01005-B5A6-43ED-A5C8-7F42AA2DD9C0@illinois.edu>
References: <CDD3A5B9-9B64-44DD-8705-6382913C8A10@illinois.edu>
 <08584f75-b829-1833-deb2-ed202bf1874e@amd.com>
In-Reply-To: <08584f75-b829-1833-deb2-ed202bf1874e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9819cfe9-95dc-4848-8b35-08d9f7d85aba
x-ms-traffictypediagnostic: CY4PR11MB1831:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1831E11F7D02594862B32090E03D9@CY4PR11MB1831.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0MmmZVwVguHGulZNj2hpUxHGEiH6Rhm9wB93oOEXuR2kNKyWrsfBhTSZkjVzwIonUAeUWxwpIdoThx0g9VwE0El12UdqxyuqZKquNhfPZjjuO0XcX02Jm20LpJTUAJ57QSSxmlBy5wuM/I54D78FQWq1GydxMgV/gWww3O1P7F3Do2n+VTEXi/RelwqXWgsbgpIfIW1nP0dytpnt6Z0IzePfEYkpmr/e/VhsZBpwx2iYMiNlTzf+0N6g25b0/7FF7Yz9qaNPW+mP05B4DHv8YaMw3CklemghyQDIHxdd+b/mm6sNv+AWYNFWPZ7XoVTpoEldZe8uBWWgd7870qEZyfSNJ0eB+IwYG9q+4Rqok9pw0CiafJ1yj/YODydAtKVEd48FxALdM3qyPhBg/CnxxJH/F4iFj+WCSt6xNFkhbaTTlceu4bY01QNAqo1OBW5sfrjEZrQrLxf8X2UScSxamxyBQfiaQJght9oQGMZOnAr17zDdGrKwXoMP+4/lek35HRRoa5RKUwm1zpO4ZYrC6dqdkdYlszAEOttibj57TLwWlEVB3mG1k3athlXGbB/sQrfPh4fNgSFnx+FvAHqmBlC5Uaqtg5Jxg0nzZ7O4wH9qWz2GpfoBa2vq5fJeSFAoOhPwhs0CShaBPmfvakdifEXVu3UHNEuqPcaGnkauVxTz3bDts8GiDOUMbZ8H0g9HjkmaeR1B7LmPKGdnLYADtf/VT/KQ6cdBNDPwqyqn2luOnyqw3WMd5LDSqge1D+8ZYAO+tdnACGtn9e1GkWUN98ax17R60Cy1rVCF5sf9Obaqy4Wg1CoDw3BOxj+FKJWX20a+KU4WhT6If5/KhVqqdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1962.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(6916009)(786003)(316002)(71200400001)(38100700002)(33656002)(2616005)(186003)(122000001)(2906002)(86362001)(91956017)(66946007)(53546011)(66556008)(66476007)(66446008)(64756008)(6512007)(4326008)(508600001)(966005)(5660300002)(36756003)(75432002)(6486002)(83380400001)(6506007)(8676002)(76116006)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjZ5VlhnZmdYYTd2L0JlT1JMVUhQUVFydG5hZzFTQkkyRlhSOHVjVW53Q1RO?=
 =?utf-8?B?REVJdGdQdXduR1FBYUwzYTZKTkloczZTQ292LzJ3SFNWOEpJZHAyR2NveDZz?=
 =?utf-8?B?OW0yaWhxbUFrUVBHRlNKQTZxb1F0L2I2MkdBL0ZRRXNqVDRYSjZ2OEFDbkxU?=
 =?utf-8?B?KzV0YVpaeXZNcFJwNTlYL1d1QW1VUHdZaFFvc0FDK3paRkVqV3B0Vzl6V1Rj?=
 =?utf-8?B?S1ZRUmpCcTIyeDVWS1FlOHM3U3dIOVp0TjFHTXk2aHg1cGVpZk0zTmFvRFVN?=
 =?utf-8?B?MUM1cnZmWU5QL3RFTSt1YTVDbDk1QTBhMVFRR1o2RTh4MzJtS0pEMjFyV1Fi?=
 =?utf-8?B?UjVyMWpaMllMZk5aSU9Wb1FTa1JIZkZ2akVTbE9ObkM3RDdzc3ozUU9zS2ty?=
 =?utf-8?B?eE5McnRjVWtkU1FYU2hvZmZnclQ3YUFVZ1pUOUxzQlY1SERUQU1qblRocjlK?=
 =?utf-8?B?Q2UwWGgvQWNVMTA2T1d3SE1NNHVSVWJoQllWV0Qrcng3MFFOMVFQSGFZM2tG?=
 =?utf-8?B?Q1NPSXN6ZDUwOHJaOTd0dmlxdk5Sc082MnVwcU9UUkRTdXFzV1MyK01BeU5z?=
 =?utf-8?B?YzhQT25xa1JnQWxDejVaZGNHNlZFSXA4VzhjOVRLUXF0bzZzWXQ1VGliTUgr?=
 =?utf-8?B?Tm1IZXhldVNPMzQ3SDR6OHdWS1pGVzBQZExmZXhvNlBnS3BWWm4vbFRtNGc5?=
 =?utf-8?B?RDBZek5qb1d4cXJCMEFHajAvMDA1YnpSa3NkM3hJQU96L3BIQWVCTCt6OTlW?=
 =?utf-8?B?VHBaMkJvRmRRZHNxbStQQ3M1NmNHQjlUazg3ZW1uWndmSjd1dkdBcHY2RW5K?=
 =?utf-8?B?dUlMOXc2eENtencwYkZGSEp6dURFT1FabkQwK25zL1VMTHVWd0xKK2VjNHF6?=
 =?utf-8?B?YjNQUkRONU4rZlJYN2lGWEwvdzc4NFBrbHdmVGw0eS9zSW1uV2w4YjlCb2JP?=
 =?utf-8?B?MVIwSE9OQXJWRFJ0SnkvTUhhYnZoS1JuVE1MalBRcXlINFJ1a2ErUnl0ZHlo?=
 =?utf-8?B?ZThxd2F3b09pMktybFVEQXFseEduTEpEelRndDhFREplMnVET0Vmdy9mVXNU?=
 =?utf-8?B?QlZSMmIreW1iZUM5YkxWd05WM2RpNm5nNWFBb1VHZjNndWNhcDZ2VXdCSE1B?=
 =?utf-8?B?UzdxTktNR1pQbTRtQk50NUlyeW91cTVBVFdQSHp4T0RvYjdtS1JXVUozQWlp?=
 =?utf-8?B?Y0ErRUhOdWJ4eGl2N2hnZ2p3MFBhdVhScjZwaEhTVitod0ZtRFJkUXdVNWxU?=
 =?utf-8?B?MWdGaVdGbHV6Mlp1YmxnSmlVVUVJMzd1MEJ6U3RMdit6ckttS2YvL1dGTUhO?=
 =?utf-8?B?OVU0NGllQ05XeE1EcUk2ek1mRCtORU5zS21wNSt5WDljbExYNzN6QkV2OGM1?=
 =?utf-8?B?RjN1Q0krNFpKZEVrQ096TXpkNTNhU1Q3YW96SXhkS21UeitQb2JvekpYdWZK?=
 =?utf-8?B?S2NVckVlb3kvdmxXUHB3cVFMdWYrNmM0cnQ3SEEzRlhUcWFHYkdvNGhVUi95?=
 =?utf-8?B?V2pyN01YMFhZRldjTWFpZ2xQeWJ1SkZWM0NVeVFJaTJCUVFZODV5Vlh2cmdL?=
 =?utf-8?B?djFRSElVbHd4QnU3YXNUZzZuTFFrNW9WZWxhMkt3bVhsVjhiSDVOUStYVzFv?=
 =?utf-8?B?Y3hhUDlIK1QvRVh1NnhVZFl3bDNYVTlheHlOYkdHeGl4VnNNYVZNUTB2L2Zz?=
 =?utf-8?B?RkZLUkpOQUg0eUdrWGFoMFdINFkwNHZVaTRyNkxMWWVKQVYxY0xROEdmckFV?=
 =?utf-8?B?dXV0Mng5Z0dPUnUyZmZGOEc5WTd1dkRJMGxVbS83MzhXSEpud2FPMFNiRXp3?=
 =?utf-8?B?RCtxbE45eUwzaVJNSjRHSFlVMzU3YnY1bDdOUk9EL09sMGhCM28vWUZVWFl4?=
 =?utf-8?B?VzIyY1NsdzlmWkRtdGRUMk5IYU9YdzNvc0tZYWFsWFlRa0c2RlFobnF6cnZa?=
 =?utf-8?B?WXhHWDJFbUJOcUdHMTdzZmtVS0kzVEhsSm1UWWFvc1l2ZmdXeEZqbldNNGxD?=
 =?utf-8?B?OVl3YmFncVgyNy9nVU5oVm1WVzlZL29VUzRXQzhDQ0hDR3Q4eTNReWpiTVFX?=
 =?utf-8?B?UTBjSVNyeWg1RWV2Uk9RZTNFRVZVV3RLVFlqS09qclpmSm9oZ29aZTRhbkg2?=
 =?utf-8?B?aDNGdEhzN2VxVFNzT3EyWWpOZEttLzA3V0RudWptMi9wWDAyRW9RMURaaGlY?=
 =?utf-8?B?T0ZDUGdhaWFjZTBndUxPVENnTnNKdDg4b1Vpdk1GMnhpNmV5MFhOdEtWRHpo?=
 =?utf-8?Q?TQm+eA0jz8rKviaQBJC1ZcIcpkiiJRhiljofj64leA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2B54E605112CE43B5B8606F2B15CD02@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1962.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9819cfe9-95dc-4848-8b35-08d9f7d85aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 20:58:05.6182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82lyUQ2eyfWXJc2QzER4M21ktFuWlDR3h9mRO7td+qF+3yATmxwZSFmh1A/fv0/xMV8GcRcHwRmumA7tNflk+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1831
X-Proofpoint-GUID: LL64Yk7NfXRvXg3MIofwF2UAcDyRi2fO
X-Proofpoint-ORIG-GUID: LL64Yk7NfXRvXg3MIofwF2UAcDyRi2fO
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

SGkgQW5hbnRoLA0KDQpJIGhhZCBhbHJlYWR5IGJlZW4gcmVmZXJyaW5nIHRvIHRoYXQgZmlsZSwg
YnV0IGhhZCBiZWVuIGxvb2tpbmcgYXQgZGlzY3JlcGFuY2llcyBiZXR3ZWVuIGl0IGFuZCB0b29s
cy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvYW1kemVuMi9jYWNoZS5qc29uLg0KdG9vbHMvcGVy
Zi9wbXUtZXZlbnRzL2FyY2gveDg2L2FtZHplbjIvcmVjb21tZW5kZWQuanNvbjoNCglsM19hY2Nl
c3Nlcwk9IDB4ZmYwNA0KCWwzX21pc3Nlcwk9IDB4MDEwNA0KdG9vbHMvcGVyZi9wbXUtZXZlbnRz
L2FyY2gveDg2L2FtZHplbjIvY2FjaGUuanNvbjoNCglsM19yZXF1ZXN0X2cxLmNhY2hpbmdfbDNf
Y2FjaGVfYWNjZXNzZXMJPSAweDgwMDENCglsM19sb29rdXBfc3RhdGUuYWxsX2wzX3JlcV90eXBz
CQk9IDB4ZmYwNA0KCWwzX2NvbWJfY2xzdHJfc3RhdGUub3RoZXJfbDNfbWlzc190eXBzCT0gMHhm
ZTA2DQoJbDNfY29tYl9jbHN0cl9zdGF0ZS5yZXF1ZXN0X21pc3MJPSAweDAxMDYNCkFNRCBQUFIg
cmVjb21tZW5kcyBtZWFzdXJpbmcgIkwzIENhY2hlIEFjY2Vzc2VzIiB3aXRoIDB4ZmYwNCBhbmQg
IkwzIENhY2hlIE1pc3MiIHdpdGggMHgwMTA2LCB0aG91Z2ggdGhpcyBkZXBlbmRzIG9uIHdoaWNo
IHJldmlzaW9uIG9mIHRoZSBQUFI7IGEgZGlmZmVyZW50IHZlcnNpb24gcmVjb21tZW5kcyBtZWFz
dXJpbmcg4oCcTDMgTWlzcyAoaW5jbHVkZXMgQ2hnMlgp4oCdIHdpdGggMHgwMTA0LiBUaGUgZGlm
ZmVyZW5jZSBiZXR3ZWVuIFBQUnMgcHJvYmFibHkgYWNjb3VudHMgZm9yIHRoZSBkaWZmZXJlbmNl
cyBiZXR3ZWVuIHRoZSB2YWx1ZXMgaW4gcmVjb21tZW5kZWQuanNvbiBhbmQgY2FjaGUuanNvbi4g
SSBzdXBwb3NlIEnigJltIHRyeWluZyB0byBkZXRlcm1pbmUgdGhlIGRpZmZlcmVuY2UgYmV0d2Vl
biB3aGF0IHRoZXNlIFBNQ3MgbWVhc3VyZS4NCg0KTWFueSB0aGFua3MsDQpPbXJpDQoNCj4gT24g
RmViIDI0LCAyMDIyLCBhdCAwMzoyMSwgQW5hbnRoIE5hcmF5YW4gPGFuYW50aC5uYXJheWFuQGFt
ZC5jb20+IHdyb3RlOg0KPiANCj4gT24gMjItMDItMjAyMiAwNToxMiBhbSwgTW9yLCBPbXJpIHdy
b3RlOg0KPj4gSGVsbG8sDQo+PiANCj4+IEkgYW0gcHJvZmlsaW5nIHNvbWUgY29kZSBvbiBBTUQg
Um9tZSAoZmFtaWx5IDE3aCwgbW9kZWwgMzFoKSB3aXRoIGFuIG9sZGVyIExpbnV4IGtlcm5lbC9w
ZXJmIHZlcnNpb24sIHByaW9yIHRvIHRoZSBhZGRpdGlvbiBvZiBaZW4vWmVuMiBldmVudHMsIGFu
ZCBzbyBoYXZlIGJlZW4gbG9va2luZyBhdCB0aGUgZXZlbnQgY29kZXMgYW5kIHVtYXNrcyBpbiB1
cGRhdGVkIHBlcmYgY29kZSBhcyB3ZWxsIGFzIEFNRCBQUFIuIENvbXBhcmluZyB0aGUgTDMtcmVs
YXRlZCBldmVudHMgaW4gY2FjaGUuanNvbiBhbmQgdGhvc2UgaW4gcmVjb21tZW5kZWQuanNvbiwg
SeKAmXZlIG5vdGljZWQgc29tZSBpbmNvbmdydWl0aWVzIGFuZCB3YW50IHRvIGNvbmZpcm0gd2hh
dCBhcmUgdGhlIGNvcnJlY3QgdmFsdWVzLg0KPj4gVGhlIFBQUiBhbmQgY2FjaGUuanNvbiBpbmRp
Y2F0ZSB0aGF0IEwzIGFjY2Vzc2VzIHVzZSBldmVudD0weDAxLHVtYXNrPTB4ODAsIHdoaWxlIEwz
IG1pc3NlcyB1c2UgZXZlbnQ9MHgwNix1bWFzaz0weDAxOyBtZWFud2hpbGUsIHJlY29tbWVuZGVk
Lmpzb24gdXNlcyBldmVudD0weDA0LHVtYXNrPTB4ZmYgZm9yIEwzIGFjY2Vzc2VzIGFuZCBldmVu
dD0weDA0LHVtYXNrPTB4MDEgZm9yIEwzIG1pc3Nlcy4gVGhlIFBQUiBpbmRpY2F0ZXMgdGhhdCAw
eDA0IGlzICJBbGwgTDMgQ2FjaGUgUmVxdWVzdHPigJ0gYW5kIHJlcXVpcmVzIDB4ZmYgZm9yICJB
bGwgTDMgUmVxdWVzdCBUeXBlc+KAnSwgbm90IGNsYXJpZnlpbmcgdGhlIG1lYW5pbmdzIG9mIGlu
ZGl2aWR1YWwgYml0c+KAlG9yIHdoZXRoZXIgc3VjaCB1c2UgY2FzZSBpcyB2YWxpZCBvciBoYXMg
YW55IG1lYW5pbmcgYXQgYWxsLiBBZGRpdGlvbmFsbHksIGNhY2hlLmpzb24gY29udGFpbnMgdGhl
IGwzX2NvbWJfY2xzdHJfc3RhdGUub3RoZXJfbDNfbWlzc190eXBzIGV2ZW50LCB3aXRoIGV2ZW50
PTB4MDYsdW1hc2s9MHhmZTsgdGhlIFBQUiBzdGF0ZXMgdGhhdCB0aGUgYml0cyBmb3IgdGhhdCBl
dmVudCBhcmUgcmVzZXJ2ZWQuDQo+PiBEdWUgdG8gYWxsIHRoaXMsIEnigJltIHN0cnVnZ2xpbmcg
dG8gZGV0ZXJtaW5lIHdoaWNoIGV2ZW50IGFuZCB1bWFzayBpcyBjb3JyZWN0IGZvciBjb3VudGlu
ZyBMMyBjYWNoZSBhY2Nlc3Nlcy9oaXRzL21pc3NlcyBvbiBaZW4yLCBhbmQgd291bGQgYXBwcmVj
aWF0ZSBhbnkgaGVscCBpbiB0aGUgbWF0dGVyLg0KPiANCj4gUGxlYXNlIHNlZSBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2NvbW1p
dC8wOGVkNzdlNDE0YWIyMzQyNTgxNjZmNTYyOGQ5MWE3YTBlNjgxZmY0X187ISFEWjNmamchcFEt
Z2Nmc1VJZk5vRlhNTnBnenVJZzRKelVoVjFwSS1tWEFHOHB5aF8tTnI2Q3gxUnpuZVBacm1jRzda
cDJtdTFoWSQgLg0KPiANCj4gU3BlY2lmaWNhbGx5LCBwbGVhc2Ugc2VlIHRvb2xzL3BlcmYvcG11
X2V2ZW50cy9hcmNoL3g4Ni9hbWR6ZW4yL3JlY29tbWVuZGVkLmpzb24NCj4gDQo+IEhvcGUgdGhp
cyBoZWxwcyENCj4gDQo+IFJlZ2FyZHMsDQo+IEFuYW50aA0KPiANCg0K
