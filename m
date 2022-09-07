Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D079C38145
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Sep 2022 07:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiIGHru (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Sep 2022 03:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiIGHrZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Sep 2022 03:47:25 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765DEA6C0A
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Sep 2022 00:47:16 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2876KYJK004865
        for <linux-perf-users@vger.kernel.org>; Wed, 7 Sep 2022 00:47:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfptdkimsnps;
 bh=DL5UQoJNO+nBhxJLFUawRYpl1Ab1ZKPlpDyxw6wVCjM=;
 b=VqLjm89cY2Di/qEE+rou6n1w4QHNbOgx0EC1mnIYpw8lwhDAXo67lXLu2mzVFJWLXuZK
 4Lrzt3D9mOiZ9A8ZJ6dZJUIwUdf/KvnttU0RLKv0ymtg5m4YkHBrZCLCnflEwrFbCjU9
 iFDDMzolyNxwRbjji66pzN47dYGPa7gDNKHsIE8PLLjhSF37GulZ+71wQgM+WP85U8/g
 CHAIZrmE+hAy29gGa1iCWso8HtGd5L6JyNo0hg2bA3SzISvx28/28aWVYCR8sbjhaGsD
 BBmn+R25I8WquN98N02ugDzknKiPwF/lx/JI9Zjx10ZfzjYdg7xQ8uMquB0zOig9+X7K Tg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3je8nhdknn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Sep 2022 00:47:05 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7D91F40095
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Sep 2022 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1662536825; bh=DL5UQoJNO+nBhxJLFUawRYpl1Ab1ZKPlpDyxw6wVCjM=;
        h=From:To:Subject:Date:From;
        b=F0Ya8/LhFq8kGCYyx31GqyXx9UzQ/dz9l3qLpl0Lw5T3yFMm3pEMNFBJgNKysmkrP
         2HT215P+x/mvu0SEq9g6EH/R61cEU+5Naxqxlpm2fzQUM/sC8Rimu1nRgtx9FUym/D
         XYqnyV7UoYY3z3cnBftef3KTzN85c0LzVEluE/4NIUwJOOmxhy8YK7Z9BXG2OEXZfU
         tHbE/yRYq6VVWGrvuTNJ0gTROsrveWZxPxgSJcN5X64xxMkuGlwqzsixc3S53xESv4
         /6qPzi1Lcz/oYoljhhw4kOgmUKk6O/IXfJXvt3RgEvl4ggpr6mWV/+cbCGp08TgD0C
         ogq4wposdcnYg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 656F1A006D
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Sep 2022 07:47:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EF23640087
        for <linux-perf-users@vger.kernel.org>; Wed,  7 Sep 2022 07:47:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=wiesner@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="hTV3Re+w";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLndWilKOPUIlWXdOlBytraqSDDhCXzTlPuFCb0MTMI2DbmNkMCZL70VtuguVBK/RbFHV4zzoh888i72kWptZAUQhgJoyIniBQVqxOVERVUTW0rdxdSErU5DtX16RYXPvVKLgFYh1M3vMKBerZq2oYA/dybn/40ARIeA4G9OmWUif7o+EE4hoVM4Pd2IDGhzkrGAaanm/8/qOreeZWc8g2JzQRzY52Q2sk3Tht84rvCyRd9xzdLQX+fxS9LeKfdVbW8avm1kH5D0e8uiUF/VZfG70FXrFlzsX59XCTCNUGQqntsSzr4cPgEp4r8jZYdMoV8zySbI328SLCxV7dejCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL5UQoJNO+nBhxJLFUawRYpl1Ab1ZKPlpDyxw6wVCjM=;
 b=Q7V8NQpIlkSVKUgM4NY+1YpkSBgUnTS/aO/XONKMBR2WcNtxWwJeY1nLf+snPU3IspHMcYOvrtor6DgM5aIypLRAHNT/nEHQWLZawTpmDAeW22t6RKLQkgM0jmcf0yDUAk7Qm3/MXPy7IIVekxOR9YrWmfk1yy4XPo6B6qOdLcUvCqDJeG8VAdFm/OpDRefIioPvrR36u/pghJMp+rHlNxnEpca98jCu+MGVfE0MdrUapMiA4y7t5qvJ7BFar4BPwhb5+jq8/wB/3tBkB7D4iojs0dPmh5ANLyq5jZCw74VeAuD+ctRxhN6gpINB5C8E9+544X1ZDz63ZjXVKEdcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL5UQoJNO+nBhxJLFUawRYpl1Ab1ZKPlpDyxw6wVCjM=;
 b=hTV3Re+wkyYYGc/YIpO7SgjgaOiCxwaCAR5eZnyI7V+rF9ukd5xweI9OC/9p8ayOMUQ2OPG2DI5Bx1Vl+H3/+SzrvjJF8ZfnAoyh5jEy01/1euTVBbbls/78ghjNWIwWZ4jxQMIs9rb5Xz4Mm/cmCovha49wiVYy6bNCVwPbej8=
Received: from MWHPR1201MB2511.namprd12.prod.outlook.com (2603:10b6:300:e0::9)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 07:47:01 +0000
Received: from MWHPR1201MB2511.namprd12.prod.outlook.com
 ([fe80::fd22:742b:75f6:f1fb]) by MWHPR1201MB2511.namprd12.prod.outlook.com
 ([fe80::fd22:742b:75f6:f1fb%12]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 07:47:01 +0000
X-SNPS-Relay: synopsys.com
From:   Jonathan Wiesner <Jonathan.Wiesner@synopsys.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Counting context switches based on host/guest distinction
Thread-Topic: Counting context switches based on host/guest distinction
Thread-Index: AdjCjevAKf7MyAMKRtGasynu52SJDA==
Date:   Wed, 7 Sep 2022 07:47:01 +0000
Message-ID: <MWHPR1201MB251139C78CDBF9D26BC17AE5C6419@MWHPR1201MB2511.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9990e2fe-f478-4591-0894-08da90a52696
x-ms-traffictypediagnostic: BY5PR12MB4065:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZnLTxnKHfD0EMcVJXlCXl76PNgGGlIwJTdoNMW4J9CbbyAxiY4ivQkqCJVDFiSBHYItmwKV8VOATnY8MzpZlfHrvAqx7jU/FCih4uQmOpu5N184gno43Qa1OzUzhEwTsYfhmsurtP6KwzjCtD7OS7EH0pswevmwmQlngQKKfmsyMmAtWiONT0zDjs2+yPxCJUCvQctaPHRwj8kxoEMTZW6QUWIhRRrlnCTLvHQCqeYdfCsin3X+YFfyYzwTGrDnjpxgeEGoA1NgRKq9JqGUBLZ067rSoJ9z7GeSFLyZzBfWeuuc2SjRJnUiaQlYiXmpBJMZ5HV2fJ7fI5FWmdAFeQklGOaYxyhT8MzRpf1DIElF2MYpMOLkghZMjHrNN86dfyYo1m1r86XWN/G5WYKmcp/oc+gtBAOYezo9nvK5KuuDea9+aP9yDjWjYWLCc1PzxWICwPgyVawmM2yiYAXFWuI1REdEPXqq82QTWAdQcStsNFaQGDZWEarkCUFf7uYcq7Ut+cEqYP6EGkBn98H+hEuFJ/j08jpMjDzuNa0fyvz/FFWUXlYw1ZtEYeagxJ5FFMm9JgKzmi6dmOLAmhJTIo/HgdQbGGWdwCpLMljz4IB3D7RSaMvFDldaWeiqWNQzWj6Sr/glrOg3IorO17lcZpR9o2rndqja6NFlzAyQRTZEQA+y3JCpYHe8khQAh4DFTjoG9qKm0Eh/m+k7pyBXcSIW85r5GbPKpuAsixFQq+hpD4CA5u7XhI6SbQT16snvf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(39850400004)(136003)(366004)(26005)(71200400001)(7696005)(9686003)(478600001)(41300700001)(83380400001)(186003)(6506007)(5660300002)(52536014)(8936002)(55016003)(6916009)(2906002)(122000001)(76116006)(66476007)(8676002)(64756008)(66946007)(66556008)(66446008)(316002)(38100700002)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cUVQzbgTMLybv2MZKXxdCKjXCbgJ9CHPZ3I8xg/4/9wU1wLA5IAmdQxb42?=
 =?iso-8859-1?Q?tWmgBM9sLNnC8u/YQZH6nQzvUU00tt30M6HgVkgQaqgliIzAOrwks2YqaW?=
 =?iso-8859-1?Q?iL2iixaXVejVZAZ5UTmjLhi+BFXjDGcye5SqLzLg7UN1L6LfXu08pX+hlC?=
 =?iso-8859-1?Q?TDv41uKL1lus2bNKdPZ7VTCLn4mOVpBVAYsOamlI6UQP2+SIvsHQiLGih2?=
 =?iso-8859-1?Q?KPcYPKVHSL9UuNwvsVLy+NMhSSewseefwBIpyM7HYb8gfUDfs03vwYqScx?=
 =?iso-8859-1?Q?XgjxC8bwoBW9Pp+ZxWqUoipzaumg74i+JPTJNRSIXDuP4jeiBtrGpDVyVE?=
 =?iso-8859-1?Q?qAOHNGGb5Lz+6UTFIRIroRzGmVf+LCyLAIIl7G4v53zZbX3cErmd6oO+qO?=
 =?iso-8859-1?Q?K2rX2wItxiDKK51bLkkDQq6AEic51yovsicHvYSu7ZLnHGkrFYzdniGMXD?=
 =?iso-8859-1?Q?i3hk5hvM4ptSnCo4kQl56Rs1P50/6ct2845rEfcwW1IrVgnr8JCdbKjAeq?=
 =?iso-8859-1?Q?F0yS/ZIgYTtd8IRBoKy+qj9n2gotjpC0mfYLnEbDyHCMcY64Tplljvy7eq?=
 =?iso-8859-1?Q?CluwwYsVXPLEs8DDCeRQRulHgZhcgX0pWxv4Udl3Os0cB//0hQDZYHaENY?=
 =?iso-8859-1?Q?Y3rWz7NgMYo1qD3+7J7wH/7MtEF6098siFIF43vxBk48LfoM1jgYVvsehH?=
 =?iso-8859-1?Q?d0vGETp91e1/AeWXpp15KLTRQENqIplfYRp6DdU+VQDiwTqcyL/qrNEYbz?=
 =?iso-8859-1?Q?fexqiRW+FZY9Yv9b+Nr7G075iogz1AlzqEFQm2764z8sqzK/GM2em451OV?=
 =?iso-8859-1?Q?ttGBHWql0dXv4hSYhh7lO2um7ngow9vprzYGwOjMboc5KqJsq4fMWq8dwr?=
 =?iso-8859-1?Q?20cOO0h5NlncoctiADw4X7k149rL2xoeDxRIHpTdp61sM6NWbsvzlLQH5q?=
 =?iso-8859-1?Q?02bJkipMr9dXn9X+YJ3kmnpMGMyMpfT6vqhUgDQxy78aFkxng07zTjnxfI?=
 =?iso-8859-1?Q?xoNLsi9foD+odJ3TmXZJ6UqKWzqFr1ef+4eFs6vjE43X6zXUSISFFhzvsU?=
 =?iso-8859-1?Q?X6FxFKKBkuE4yIWjw56/37ECdOHzPIRgMYIJRVlzMEDTpCyWCsW4Y0wUyt?=
 =?iso-8859-1?Q?Ab67RuJ60wAgaKgnVBVx4e1+w2aPvDUio/AjGod2NJefmcsjx5/O6AFJv2?=
 =?iso-8859-1?Q?bJ4qJm41ewVA49nloZKHJfBsnXz9RqbcWaa5lGnF4FR3cS/Pxpj0LGQemq?=
 =?iso-8859-1?Q?NTi+87ee97rcAwGZ8VD2wmM4Xpjeq0FH4FKhRd4VQgKvrQLI1eJ0FBCOdW?=
 =?iso-8859-1?Q?Q7cnYQjOgiKEUOYT751NlbD09jb0WPQ68O7G3OxEIEk3CXVPY4r/736y9o?=
 =?iso-8859-1?Q?yDnU/5FbByVH6Qqzgkt6Z6P+Ivb1ApltLQUx8NXtZtdmDByrs0gBVdSdwu?=
 =?iso-8859-1?Q?mnTgDw1nJ+6/asyDwtMhCnkL4LZdch+gxC8Rr2DPmNkZ3DXM9T2CqOkMbQ?=
 =?iso-8859-1?Q?DWbluCQD+xVA+H6cnHm7rFoNDI4ydCwyzumNHgs/sWUbezsp2Dny23NGfA?=
 =?iso-8859-1?Q?MBJASUCYpbXfI6cZ8Q4D+m2/1s58xouSC7E8sbBEyhGUY174JpXH5oLitN?=
 =?iso-8859-1?Q?d0BYPQz3CNF8GIr96Ex42nGXsCKhf3LumE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9990e2fe-f478-4591-0894-08da90a52696
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 07:47:01.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4ox9SNxtnt6mxm6m8a/TTzy5qps4id/5rMUgHO1J5i4sIfgzdOZiiiSr8VbhMcw8UrQYcFQJTjRnv18am8p/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
X-Proofpoint-GUID: lnIhRf0c19gVz2MrmBxV_ba1MQPxU6Yw
X-Proofpoint-ORIG-GUID: lnIhRf0c19gVz2MrmBxV_ba1MQPxU6Yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_04,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070032
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I am currently working on an implementation that is running a kvm guest whi=
le also making use of the perf_event_open API. The target platform is arm64=
.
A perf counter is set up to detect context switches (PERF_COUNT_SW_CONTEXT_=
SWITCHES) within the thread and to generate an interrupt on each context sw=
itch. When inspecting the generated perf samples, it is possible to see the=
 cpu mode at the moment of the context switch via the misc field of the per=
f_event_header struct. Some samples are reported with PERF_RECORD_MISC_KERN=
EL and some are reported with PERF_RECORD_MISC_GUEST_KERNEL. I am intereste=
d in only counting those context switches labeled as PERF_RECORD_MISC_GUEST=
_KERNEL events, which is why I additionally set exclude_host as configurati=
on for the perf counter. However, neither exclude_host nor exclude_guest se=
em to have any effect on the counted context switches as still both kinds o=
f samples are reported for all cases.
I cannot find any documentation on the non-compatibility of the exclude_hos=
t and exclude_guest parameters for the context switch perf event. Is this a=
n intended behaviour? Is there any way to only count the context switches t=
hat are reported as PERF_RECORD_MISC_GUEST_KERNEL?

Thanks,
Jonathan=A0

