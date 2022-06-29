Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C7C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 05:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiF2Fbq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 01:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2Fbq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 01:31:46 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10042.outbound.protection.outlook.com [40.107.1.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEEF27B2D
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jun 2022 22:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1t6ACeKZvg0AKMXZfFRv0XtvAbTCJ3DbpirKFHMTbYvrf0I+QMYIrvh4bU9/A4qh7yQQX8tMOoRnfu/CA1OuTw5FvH2JDLQrAFAryyMlLhwl0iFvtz9QHv7zyW9jVn49MhHTG/ZmoM9Ntb5KcRHzZZ5txeCO59V7F1fyiV1arPW78PB+GwQZDyPzwnvKegmiwc9zRpwt8GuX6CIXbR0q4H1qdjjmpoNxvg6KNcU7PzdVeGerdHX81spZL4zhwnZYgoCWlrpdKDX9flSGZ/9CXIwjiDGAD3zYb4Fp4hxyUem/sWR7fq9ZTk4GuantzTZB6OgPXt12ASnOrsOuGfQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LT0aHEdyS2gXrb5X8q2kCJhpvG/58xfWSslcLWJnak=;
 b=P11Egl0W7LSgTfSRjpQPkVJ8LLwxOE1fH5HBHnRqGH1ySW3KOPiqRv0NfP7uiKx9oLmYxuoy1tP+7ANYEqNhZx4w2vsAeq+xT+usodMCXEBvnoZEBqFmWnmA6Mu+yhnYwwKmj4x7doSBQ5tSoV2c86UEVXPHg9QnVUsLjm62AajPeZGBURTjMGAcbxXoph9aLQlKY4VwvtjRmIwCj8kNyxJN1YVkkTVzR+6zvaKKH/Fj45zGCHzMmvfYsA8IbsAQ92TgT+Kpz4G/hNMEGmF1sBUZcJ85y5j65UZ8W48CKa4ACLgNivKj4muyT4Hfq0l0fbWh75KLVoCl6pjuHzeU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LT0aHEdyS2gXrb5X8q2kCJhpvG/58xfWSslcLWJnak=;
 b=XDUlEbpB3+xsFI6X3cJnQ24CiFiyJIzCmr6/gWdcUpyhoNFK9rOZtUYh68lltWzmNbIGmIpYg3a9bL8vOCnU0rGTgKwXUv0E/ALC/uX6BKcxNE16/UTiC2REWHjIuHKbWDHTUEo2FmyawY+GGvO17ShrCVX9u2aqLmZ8psio61c=
Received: from AM8PR07MB7666.eurprd07.prod.outlook.com (2603:10a6:20b:240::23)
 by DU2PR07MB8176.eurprd07.prod.outlook.com (2603:10a6:10:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.11; Wed, 29 Jun
 2022 05:31:42 +0000
Received: from AM8PR07MB7666.eurprd07.prod.outlook.com
 ([fe80::188:e139:774e:cea1]) by AM8PR07MB7666.eurprd07.prod.outlook.com
 ([fe80::188:e139:774e:cea1%9]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 05:31:42 +0000
From:   Emil Berg <emil.berg@ericsson.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Possible overwriting of errno
Thread-Topic: Possible overwriting of errno
Thread-Index: AdiLeXbz2aV0mg2JQcK84/XQYx5qnw==
Date:   Wed, 29 Jun 2022 05:31:42 +0000
Message-ID: <AM8PR07MB7666EEF15D803DAFB5A8284D98BB9@AM8PR07MB7666.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ebf4217-2c9d-452e-eb81-08da5990a62c
x-ms-traffictypediagnostic: DU2PR07MB8176:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYB+VZ0DUJTs7Jou8WFPtNwxFjhMq2nZS/fVgTd8r8DeYAvCGLXXfygtMt31HnRNZwYjCweOR7ysBgn1Hkvq9C4sOonOsfibk/xYhZRKt0BnyB4ewTsjrdXPb9ka32QPYhV/W/mZEL+HKAqicjjglr+AZsgX2V6gEjT9uaL5A2GOo1EbSmq6Yb1mgkISPoCxZ+HWDB0rXiJ+0gfMsvn0ifUqXzpxtGjr5D84YedYI+YJMr9g6GAEGUlPbSELvFr6FgAcp7+zB1DSBxyj6cqB9QTON6p5OM6W1+cxjSd3BxhzAhYSqYoRm7gvGulEztrtnQByearhkFSeptJap5zTG7S7dlyI1Y9NMWGRfCrf09AIfRDFb3iioQLqg3HzmIEUE94g2jS4x/pgTCzmsuAak+lQDW/CCV+jWHJ1UljO6ynlmevkcXbkWLlOLIjMMMKLdVWvv8JyhqVaxNmuNEh6pC098uJu5kQjRYBniIZBNve1c51MHRqZPwaE4z1q5TYoS1sBdkj5n+ao2umrrc22dhzL8R6wK0Cymzm7mNmdL9BUmL850J7PcLN0D4mayjLP6Tl3aRqESpphoIK89uTdQX89wwxEwUEKWYvUGdn2PJyni80Yqs49Q4JtvP3C0yWntvEfgAmM1usnSj5tHSaVkeR8CnT+nXfL+3BL5R+7lMdTFOqrWkYlTEbLfbDKFUGhrskhci6Lc1yrC0jse7BZ2O6zxwncKHL7g6QhUjy+05bnnCV7gJOk16df3bbWjJ2FokKkdYadRVbj0Uvu/RGkMg4lLsh5N7hLuqRsSp5EFFg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7666.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(3480700007)(71200400001)(6916009)(41300700001)(86362001)(38070700005)(9686003)(8676002)(5660300002)(26005)(33656002)(316002)(64756008)(186003)(4744005)(82960400001)(66476007)(44832011)(66556008)(66446008)(66946007)(52536014)(6506007)(76116006)(122000001)(7696005)(38100700002)(55016003)(2906002)(83380400001)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8fh/hDwTl8WmYoaUtj1qi54GvXWs0of+3ZVqDFbMVIRDei6zctxiCDjRvg0+?=
 =?us-ascii?Q?LlqeDpW+SQ9VQ31uN9HDyhIrk2UWEoDhcuONI4VPr4jwb+uj6H/02u4axerh?=
 =?us-ascii?Q?N5mXx0grsOPfXVBR31t4GtcGp6PbVm3VHOOrohQfPMMan57C/67slC4STY9M?=
 =?us-ascii?Q?dOWNyZigefhmsx2TXlig2oFSlKKDn8u4MkpNzp8VPSw554pZzh5AKzqjkusm?=
 =?us-ascii?Q?cm96OiJ7W+U21vFDWL7D2dalPqpm6tyjgtPgYcFayy7wNVp9W/3o6cRp1zHW?=
 =?us-ascii?Q?c4RiVbzqR1ac4AUFowdS02SA0EtBIJa27zh5s8lV8yTqvqgqt+b70C60apXK?=
 =?us-ascii?Q?QM5brWAk3rjkWleErS5KhzMnglLfIa9C1YDfNQTEO1FWox0vlb/o1Ehr0rF3?=
 =?us-ascii?Q?f7vZ61XsaVXHPw8ssxit1b1rbWe1RTdbOfysXeHeVyUb7dTtOO1LOrKKPeX6?=
 =?us-ascii?Q?IxaxI9p2hY4qNaQohqoZ6XL8s/T5TBR/NeYpe1w/ud4ePWR3JBGJcxXrgDV7?=
 =?us-ascii?Q?8MEXRv0Rdlye/yrqEPkMvy21XLHaI4QnI2GLCiPSsNSO5iEVYHVHgd5Oxv6c?=
 =?us-ascii?Q?eIQsnIfER9CBDSvqDaJPVrYXdovb94g8OZawZm+97tx36mUhHN+SBJsgC74j?=
 =?us-ascii?Q?og8EiqGf31UDGmgb9HdbVbP9prtQ8SMl6b42T+vpAz04vLD3S2S7krgJfPe0?=
 =?us-ascii?Q?dAWcK0TaS+g1FAQc4MymHMxvj0WXQFJSJedhEw/Q4FAJEK9HYLBBePVFjiAF?=
 =?us-ascii?Q?Y52Zt/xLgp3NKyWAgY9TJfM4+E7HbJWC8bfbOCGAbIG7XkbSORwKs2ePCGdH?=
 =?us-ascii?Q?xQRuwrtS7IPTIVzBW/QcosdT2IrHK3DhFo7ra545VC7Hbo0hm4AuGvMdppti?=
 =?us-ascii?Q?QEhN9vgbD6tfAxo0T47+ZZ3qbSdTZhNY0svI+ZlXhK0PNMdtnk1SEHqYChQP?=
 =?us-ascii?Q?RCIXAKKpAXqkLzN5Wtw5gFcHu18Nmy6wQuJsFvXLDZOmV9I3Iu1v3Stp68Bb?=
 =?us-ascii?Q?B8uiRgEoFfgJOoTSBc+4fxlFzMOr31pvzUDrmGM9ptqD34VawZyLfon0fvsO?=
 =?us-ascii?Q?3TPuwqfl4KPM49EWI7FIufgD5ustpAZb8/hwq/q8VMXRwvzF5ugz24x3DUe+?=
 =?us-ascii?Q?OvR02RTGrrbXuj5M65jwu4b4QmCw6kn+GiLCL2XJmI5iPNSxH/DAS0QzI7kh?=
 =?us-ascii?Q?ku1t8tctM/wGXPYsRYjndctD0CqsYehEWdIAJ08kP3j+rdf6uTiqWo7O29rp?=
 =?us-ascii?Q?ogOI9efy4Rdi5xjmHe8SuM9a8sXDFlGo3x0CLjWmFcGxeeIHgR1z8MqmOgNH?=
 =?us-ascii?Q?9A40qei0aM7Ykg/MS6i+aFcUZP7hpzLJep16gWAUptVs2ch6rxjiY5KGHftB?=
 =?us-ascii?Q?fmZQ7P7a9EynE709EkoYMXI+7ufhdsv0yx2yGbowPunNigfMSVnBVZdfdFLK?=
 =?us-ascii?Q?PIUHiewmgn8hCiHT0z1LPjdq+QZg5qcrco1F+46kWTQuYh2/W+yVIYcvr6wI?=
 =?us-ascii?Q?BSYYCZ5JwhvcgmTSTtm4Kk2s9q35J63/wiKXWwsFJu8Q/hYL6TbXoOqzBrAp?=
 =?us-ascii?Q?VIUkBHv3i8u/SoE8ISTC1Ch3F5XSpKS4CPfi1kLi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7666.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebf4217-2c9d-452e-eb81-08da5990a62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 05:31:42.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhPVrksxccwzy8U6wy5iIeQ2OKROF3Nhwc4EdOCUwO3zG3+pGIfdimX/uRWuOZ+YszBVIctblF8rUW4bdpTlJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8176
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi!

I'm getting the error "Failed to start threads: File exists" from perf, pro=
bably EEXIST.

I just want to discuss the changes to tools/perf/builtin-record.c made Feb =
10 2022 with:
perf record: Start threads in the beginning of trace streaming
SHA: 3217e9fecf118d5dcabdd68d91e0c6afcb4c3e1b

At line 2014 pthread_create() is run and on line 2017 strerror(errno) is pr=
inted. Between line 2014 and 2017 record__terminate_thread() is run.

I just think record__terminate_thread() run in-between looks like it may ov=
erwrite errno, thus messing up the error message. To be clear I think the e=
rror message should come from failure of thread creation and not from failu=
re of thread termination. Can someone enlighten me here?

if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
    for (tt =3D 1; tt < t; tt++)
        record__terminate_thread(&thread_data[t]);
    pr_err("Failed to start threads: %s\n", strerror(errno));

/Emil Berg
