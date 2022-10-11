Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C586C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Oct 2022 08:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiJKIEd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Oct 2022 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKIEb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Oct 2022 04:04:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671AE7E82F
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Oct 2022 01:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5bXpwzJ0HKCnpZwYZMI2Hx/K0hM9iuOIMB/sSMgFVoj48MNs4oW5AIj5aNsD0DhclK0Nz2bsvYFRjfAiaLxeGOMAuewdtezsLqnGO0GcVOoaEELznT7oK+1zZT9EOCv0qFOAPZlN4oU6nWuJWa3K4Zx+JWc/wlAtz5JrOVeXKNOizS4pS7SpB8scDtBu1gAjnDtFeLy0ZcvPG1S7VjS1M/L/6YnMHa0AhZeQYwNOTL97HUvCeiZHSBFZEoG+/uI+Id6/7hAeVfDS952vEJZDlF40uiDOJV/YUE+5eLvKZCa+AhAGQJhJ3WlajBhPbObNZFHYj6aDdHTStWE21uKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy/G8Sn60pKDJ0VBYoNuE8Mn0ydhdeK/Np6spfdeJNo=;
 b=JKbNuV64ZQwCx3q4+qIuDIT7eQrk/KZC7tT1ozI9o+E5mnmTBqs6LWb1zEp52DroVxmeyaxCqKmVn5e9PZIDN4qA50LbxKZAq7O7LY4Oa5pbizLlUnExkhB1HgSruZyuW7H79ppGgLxkSIsaZBs5zp0SYsBL5haCFS2DR+wsgo1pFGVHjt/CS0pkAj22Oig7qOp7rjFdkkHhjA7/1JArDORnVT9BYjUUJpI9VC3GEIkkTlAyDOWeE+RK/hQ1ZtMccO+SVZCOWL8NszQTNCRS/+8EJwMhHFk7CvfAC/8qU+eTKOWA3Ql0VQNRfktcRQ7dXkPD+qKQyzIfq5eWj3gwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy/G8Sn60pKDJ0VBYoNuE8Mn0ydhdeK/Np6spfdeJNo=;
 b=q3QDcVEieNdXfQuvagKSZiZpjiHL+LLKlAnUPf+RpXWBVXdL14iCM69HI39ygZWlIAuQrsK77UvsXRI84hALANwIhZpeDVZ4eQoEB8ML6KHTSGLd7haFqX6luIIjYLq6iwtnNttkkStYifYkPiHfEIJF7NG+CaLRz4nk/RYxNI8=
Received: from AM8PR07MB7666.eurprd07.prod.outlook.com (2603:10a6:20b:240::23)
 by AS8PR07MB8965.eurprd07.prod.outlook.com (2603:10a6:20b:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.14; Tue, 11 Oct
 2022 08:04:28 +0000
Received: from AM8PR07MB7666.eurprd07.prod.outlook.com
 ([fe80::be:55d5:df83:dbf4]) by AM8PR07MB7666.eurprd07.prod.outlook.com
 ([fe80::be:55d5:df83:dbf4%4]) with mapi id 15.20.5723.018; Tue, 11 Oct 2022
 08:04:28 +0000
From:   Emil Berg <emil.berg@ericsson.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: Possible overwriting of errno
Thread-Topic: Possible overwriting of errno
Thread-Index: AdiLeXbz2aV0mg2JQcK84/XQYx5qnxRzj0PA
Date:   Tue, 11 Oct 2022 08:04:28 +0000
Message-ID: <AM8PR07MB76668E6B298FC3FEBA223EC098239@AM8PR07MB7666.eurprd07.prod.outlook.com>
References: <AM8PR07MB7666EEF15D803DAFB5A8284D98BB9@AM8PR07MB7666.eurprd07.prod.outlook.com>
In-Reply-To: <AM8PR07MB7666EEF15D803DAFB5A8284D98BB9@AM8PR07MB7666.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7666:EE_|AS8PR07MB8965:EE_
x-ms-office365-filtering-correlation-id: bddcb31b-9ed8-404f-a409-08daab5f385a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EiI2ie8grD0pTJp50BOfif869sDR7bye+IFfcscYD1EVqxYPBTolecRZptzsCafs6fPxTgR+SrHMPvJ4vfHsECAHMDUMDkgsCk3FDe221xvCxyQcTufI3w+yESFm3SIIEnJh3nfn+Dr3M/Xz6TTcvDR69ntpN/kKNchKtF+iXcdX1xyurh5u57KKObClvGROMsYHkiFJeH0uWE+YxH6YCUW4bnSPW95S9tLX/3fx6IF2oIxraAY7JRh4CakETsSkcPsb/o0xL9olakmbGopbAZR+krOQm2nPpeDpwlINxqANHinR7G1pS+X5Hnrwi1zDD/skBdVhOZGn8XoMI91Kd5GF0PpjX9z+S0LENYRNEQL8Akho/JphR0FkvIs7ns99hwPsx51K7m3Tjd6iPoJg679pGG383fQO+IGFSGauMxv+piP8FHrtlUxqQbPsTtl4pDfU5dJ2QubRPW/Z0vJ1MYIG6KxwqTkyOlnYueWM/rD5/DfTwBnlrYTXZD+JaaaNeqvXhyTuwqztQmjIPyvS/QmrbDKzAXGmMFzaDUKmX+VHJ5rX9fojwUMc385N9GQR7edSVZY1Z0qwDgelgsQE9dszo0Jid1i+dJ1OF/u+4t6v/SKJsVe3U+0rK5T6CeCPxFjS12U8sofHtPJiAcvJ1MJ2kPl2yMWDALkIr0hf96EnKU6MctPgkl9zDbVY5SFRcBjITEv/95u6IdcaIKE99fCUpDaDnVjOkSVgG5Zp3xS1k1q6YJSfH5NF0p2qVeud
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7666.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(9686003)(26005)(55016003)(7696005)(6506007)(82960400001)(71200400001)(186003)(83380400001)(478600001)(38100700002)(122000001)(86362001)(33656002)(53546011)(3480700007)(38070700005)(64756008)(66446008)(66476007)(8676002)(6916009)(66556008)(2906002)(41300700001)(316002)(8936002)(76116006)(5660300002)(52536014)(44832011)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZSIxFEGUtmWa8kv2yGzqDuoGtIMgybbAuw82Zv6Jh0OJxNfH4ut893EmlFIM?=
 =?us-ascii?Q?s4+7eYBJtiq0xzm+eF6xxaRfFoujFID+pQrE68mJ7MhU22lnIBIb23+2uyxT?=
 =?us-ascii?Q?ARiwgiARE6+oI9dcTCX9vxwQOJwKjG7EZAr4QRMtAGsllZvXg6qu4KugL+px?=
 =?us-ascii?Q?baLQ6G7D8W6tj6LK9/M7tM/va/0n8Ckk2HjVCYuPmDFKtJsj0cK6EhkVH82q?=
 =?us-ascii?Q?InWwf+SQRUZemTkwXSOontOP4o7UfBGr/sNLp19F7xK8eh9tT4zIPAUXBbst?=
 =?us-ascii?Q?JNp5LpYVQX2ZAhU0D2vbJ3+M472cwJg0+DCsXT5fBBE7F+b5VNCo1HQ+aVwa?=
 =?us-ascii?Q?AE1c7IKDPzu5ykkikAmW3nXASgqnkdEldHy52OnKryHLjjhyRqG3PTzoXw7+?=
 =?us-ascii?Q?JNoqQANRPaRaiSocbGr4GQk8sqaTi+FIPWY0utmKR3tOQhk1D4VZ/4SdLRoN?=
 =?us-ascii?Q?oP8IWoe6kLA+HQHoyh/Z+OSbsWG1MwG0omRcf4BQdJGER/HYNrKXZR9vjkbJ?=
 =?us-ascii?Q?1MYJVYHQ6XkDMb9Gys7xO9ABA3P7asjBGeYPB3aHOqwvFernpeFWbkrreGRo?=
 =?us-ascii?Q?hWiu8luGBJCgGIJdoip0WC4/XGWbAhdwQBrgAc/FmM+uu2xgbZC43XFk4i7d?=
 =?us-ascii?Q?R0XhHPw7ZTPmh/jnvo38ur0R0JJSJXYPjquttQ6fSOE/J/fAVVwVi0RtavVJ?=
 =?us-ascii?Q?DU9UOBiHhEoWAZD863xjgd7f0Nez4KOucY5ddsPK9Mye0+uk6AAEhJ6p8OS0?=
 =?us-ascii?Q?MtMOCxFQLflFdTDRZ8sq1IwaHqqDC7CVsq0CgsAjeujgAQtcrXjVph+U4JCr?=
 =?us-ascii?Q?dAvSvGpyHveeJxry50JDv4ObrcF2AZwm5ilyrmreSQMSLIbkG+sKGbYh8SnF?=
 =?us-ascii?Q?J3Dnn4nmtDeDQ20D5XtmhAE7FjEyhs3fcVZodX9nTCtHc/gH3qBV6OV2xK8d?=
 =?us-ascii?Q?ArVwC+vBbg5Q77vHed0XfcSOa89T5G7EfInzDMBJqJ282my1vEd3E/Py4a58?=
 =?us-ascii?Q?hm8gITQi2JjPt666skUZvRyGuA1ogHBnrEQHXGcz9VjtGMI+p7kSkeITiEEg?=
 =?us-ascii?Q?BWG/EDaBLnM9+zoYTm/y5vtmqXf3dEXwS3TQ8HpZuSeAqcwdS9VYL0eUYaZ2?=
 =?us-ascii?Q?DyQ0zf04pNMmUh+rdoGReoUhFg6iLpcZP/e23Mo1WvmIxe427guhzDtsJcUY?=
 =?us-ascii?Q?rBO1S9QEYWUsnGJqr5jfIK0fNad2cpyEb4oiZYqw4SAX7FZfUI9N2qpqcihy?=
 =?us-ascii?Q?vFfFegnpUbhXyLOnp0+2pRKVejRwLk0/huBLmSpbFy4RUPt/M+t7x4fS+HzR?=
 =?us-ascii?Q?cHg6UKPUJEubGbkZhMF1OAITEqC0huTBS9FRNqFKMgfdxxFCIy0jMxFLYG8s?=
 =?us-ascii?Q?/wmfeOH96zOTGuQNwNKyY1rbRoVryzjBfDAUGEz7bDnEsCiYur7zv9QNGX85?=
 =?us-ascii?Q?9K35rwqSiBbozIS7mSGUFE+ocTJCzcyhL2pr/hUEyNEEN3+IboEcDaNfPftn?=
 =?us-ascii?Q?JOGjS45saFhJd9bIPRQnc0Dh5ib97vBrAX1ABTccUaPLh42iKMty5Ihhsmxk?=
 =?us-ascii?Q?f/YxO1XeQ1DGvzSMmpMu2YFnK5EDddzIcldv9iXX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7666.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bddcb31b-9ed8-404f-a409-08daab5f385a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 08:04:28.2053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ak1d+nkpSaraHiq38AIb19Q4cweZ9nJ0j4EMPFxpGDPHBDBS6NoTgHHeNslieV+/mz9mfkbC+katqPBMtCAtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8965
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Although it's been a while I still think this is a bug. Assuming any posix =
function, e.g. close() in record__terminate_thread(), can modify errno, it =
seems like this is an issue which may produce confusing error messages. Wil=
l there be a fix for this?

See below.

> -----Original Message-----
> From: Emil Berg
> Sent: den 29 juni 2022 07:32
> To: linux-perf-users@vger.kernel.org
> Subject: Possible overwriting of errno
>=20
> Hi!
>=20
> I'm getting the error "Failed to start threads: File exists" from perf, p=
robably
> EEXIST.
>=20
> I just want to discuss the changes to tools/perf/builtin-record.c made Fe=
b 10
> 2022 with:
> perf record: Start threads in the beginning of trace streaming
> SHA: 3217e9fecf118d5dcabdd68d91e0c6afcb4c3e1b
>=20
> At line 2014 pthread_create() is run and on line 2017 strerror(errno) is
> printed. Between line 2014 and 2017 record__terminate_thread() is run.
>=20
> I just think record__terminate_thread() run in-between looks like it may
> overwrite errno, thus messing up the error message. To be clear I think t=
he
> error message should come from failure of thread creation and not from
> failure of thread termination. Can someone enlighten me here?
>=20
> if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
>     for (tt =3D 1; tt < t; tt++)
>         record__terminate_thread(&thread_data[t]);
>     pr_err("Failed to start threads: %s\n", strerror(errno));
>=20
> /Emil Berg
