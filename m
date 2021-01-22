Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5442AC433DB
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 06:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14773238D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 06:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbhAVGCZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 01:02:25 -0500
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:24224
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbhAVGCX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Jan 2021 01:02:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7Qn8QvMa9jrWw5tjfnSIBK8Keykhj4Lpy6YBrObisIL/fVi36eGsLevN4zL5XtGRv94/ae8uWURaD8N6ixb35QuZHg5uMYTnOfQbd5Sby33wHCLO5W7BZ7d+hcxgprVSRsyWSWkAtb86n03T8bxkzsuHr5bNbXrgy9s3oc/a6BiuBShBm1qfOdEp7NgT+688pdvG+k/s7qxwCUNgJMgC5Xv5EGtowEfH+ZGjUHgh+pKacCjJEKyQs8RPeJnR6KD3xZs0oHzmbZ2LhFygOweM9NKXfhRAydpbK2a6ac0brLZU7VEEkBi69Gxm514so4wFry130/FY+xr/w/yvKUbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLWoebXGRHKnaavE27P6Df6OGLMeenY+uMNdQ+4fqqI=;
 b=mu4BIsuhbSUr0bBhuxYWBIJu+XSYmYFxmQBb5oBxAXZczLfkRYxq94DH52BLAeN2nGvVdJ4BsY/PMlqi4bmbufPFtapJb4EXKfogg6Dn5iqL7eXHdQxWu7+Zy4eoUR0AhMp63/YVzgzxTAS0HuE9jp71eonoNDCQk4Rw0okixdtCKTarz1/FyiITsy/2ofPUw/LluDzG97Zpl+9MC/rXuNh21cQHt212qpuRUr4rplWD06sbtS8xJhlczJEltEmvrzzHYFPHJVPchyTgcMRT1fmtB97MwLSFGpRVaLG+LUB0w0uWg5dlljtIHQBFnMMZZ9ZIJfiVTl5xDV9pj4Tpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLWoebXGRHKnaavE27P6Df6OGLMeenY+uMNdQ+4fqqI=;
 b=kRAeBj1wzA9Hzn/L9rFIvknQRtKffZKwotdl/GUOHv6YcxfydgB2rhkyO8Q69myW6XP5WI1gQq9UpXaqDTnJeSEHtJnHIc3iMbQTtv0O9hlv/dhIPy72BlddJbnu9NeMmPQIyN2amyt0AVmHvWGUL+f0Jtwu8vS4fevhdn9nT9Y=
Received: from PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14; Fri, 22 Jan
 2021 06:01:35 +0000
Received: from PH0PR11MB4902.namprd11.prod.outlook.com
 ([fe80::a14c:c696:84f:31cf]) by PH0PR11MB4902.namprd11.prod.outlook.com
 ([fe80::a14c:c696:84f:31cf%5]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 06:01:35 +0000
From:   "Wang, Dongyang" <Dongyang.Wang@windriver.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Perf can't trace the temporary variables.
Thread-Topic: Perf can't trace the temporary variables.
Thread-Index: AdbwhAkqs06ZSyVaSQe130vN5f8o2w==
Date:   Fri, 22 Jan 2021 06:01:35 +0000
Message-ID: <PH0PR11MB4902AD6E0095A82025F85B88F9A09@PH0PR11MB4902.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 602ec64e-5130-419d-f310-08d8be9b2cba
x-ms-traffictypediagnostic: PH0PR11MB4854:
x-microsoft-antispam-prvs: <PH0PR11MB48540A40BFCB356784F9C0B5F9A09@PH0PR11MB4854.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YpRcmf+GZWR8+QVkZybIqAUWCXf8Dot6PNImeKPaFb2YV1QPmmre9O2CVIDQb5nN9OzvQHA8CXE+2iU5oyUZY9cC4QTd8wML+ZUGxA/OGAOWUddZfomXUVgkjVtG6zQGHq5gJlB6MT98EUeynwgNkY1qJKF7Dz6PX88XHQ7EyegLBlUpI2a2RdoputAjAdw7ENqWbCOnhnssWaa9q9hv7SQ7yp8+eAB3BboeiEynSVhjJjxtFmWG3GgkCFdBRw074Tuhh1REF7syzbuxuRkJz9EWyyA3JQ1L1ju5mX7gRJLnCV7ph7W9apKaugHkV/W7kFc6qDe1oh/jrRvDDXZoQvCaoNttCtTNeQwKGn7llLx2ExzazUrsCPVO0EO7r7hj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39850400004)(376002)(6506007)(316002)(4744005)(2906002)(5660300002)(8936002)(186003)(8676002)(26005)(33656002)(52536014)(55016002)(478600001)(86362001)(9686003)(71200400001)(76116006)(66556008)(6916009)(64756008)(66946007)(66476007)(7696005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?l/RVeke+79PJ7V6TlQZwDIVCTzcv/xXALmXYPrKIU2asB/acAUMjqEt29IIa?=
 =?us-ascii?Q?7K+J9EkaV/wG6RNXCNoiWlXd+BoBofQlEFRqyC9AtkaYmEIarSb41Hm2OzCT?=
 =?us-ascii?Q?v71/po3Dx9dmtLjxy1WLu95GVNWxA95m3rwVJ6lvgfrjk18t8200hybqCsjv?=
 =?us-ascii?Q?7bQyisrnyJiC08cXQ87jk/gvwWFCDdrtfCqmkVXmkafOMZYi80Mof9j2d5+f?=
 =?us-ascii?Q?mXXfjYsN7lvcRokoJcSfoL59ZWDu1xMU1/+Z4tDOp3j4WIamP+jtSai89rPH?=
 =?us-ascii?Q?PJeTmDEnPLQU0EQV/KBsd5n/GZDfyhlllWOW/vyRZr59X5VBRKcclQbtoRv5?=
 =?us-ascii?Q?+1Ky5CWOPIWbJfbIeYdeXjYAsWBWpl+W0OjPqbq7LTQ7wDndBi4Z2qUOGwPP?=
 =?us-ascii?Q?1nf+iVdPGixVPAbMfTunP1PE5wYNMs1tmPa9mR+9TM3PvuWWcs9X+ZPrf9Bb?=
 =?us-ascii?Q?8nr5cixdVsFf4xJ1AE/qX/5x7z102M1M830H6+wwP9GXVE3HUfnhOvJTCZ/f?=
 =?us-ascii?Q?SeH+v1tSUZ6DdoByJgYusb0JNEqeDxjKYbxPDlbiFSY0vgqY+Iyov4N4caVs?=
 =?us-ascii?Q?deVOXoum5W22enHYmM10CwGVyYHWXLJpPicVlTTO1BjBkTcOBRv8aFsFhfz/?=
 =?us-ascii?Q?RxlJI/W+9oOOsfIhtJ+Uoh7Bf7xD/NErib6Puc6E6IlfvpJgeMFlkwEdVRI3?=
 =?us-ascii?Q?/XmMawVzeoOLw25T398xx+gfS2khuMohiZADHdrub6sDxaGkWpMGbfCOp/91?=
 =?us-ascii?Q?3tuXlj+ouv4NURSRokURN5oOsw7UVCz7DSmGuvlTOXhZscx1Cw4SP9uor3Bi?=
 =?us-ascii?Q?tOj6YIbTIFnXvNFEufDnpd2s/+aW+ULvCw52ySjBeK9mWJuAODpHhULc5O7y?=
 =?us-ascii?Q?QZBw+OBCgkn4nSIRJtZnqmB4gHwHWWEtDfigJDkdIZrVvylpXAwFxerOFxNS?=
 =?us-ascii?Q?tMP2KVdkEsWsYvqUyen12aARhHfZ2UL+wRQlYVVaSn8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602ec64e-5130-419d-f310-08d8be9b2cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 06:01:35.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vreKo5RT7lSjbroE7n4hAEZiSY4Rb4QoMNhyl65X0bkgwQMJox6zqQj9hDsugqNJjNgCPqGSG2nFpsH5Yj6RjBlqUS4QB3jwBQCkAThGTOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi guys,

Sometimes, we want to trace a temporary variables, but many of them can't b=
e traced.=20
Eg:
perf probe --line tcp_retransmit_timer
<tcp_retransmit_timer@/xxxxx
      0  void tcp_retransmit_timer(struct sock *sk)
      1  {
             struct tcp_sock *tp =3D tcp_sk(sk);
             struct inet_connection_sock *icsk =3D inet_csk(sk);

      5      if (tp->fastopen_rsk) {
      6          WARN_ON_ONCE(sk->sk_state !=3D TCP_SYN_RECV &&

perf probe --var tcp_retransmit_timer:5
Available variables at tcp_retransmit_timer:5
        @<tcp_retransmit_timer+28>
                struct sock*    sk   ------ here don't have the "tcp_sock *=
tp"

perf probe --add 'tcp_retransmit_timer:5 tp'
Failed to find 'tp' in this function.
  Error: Failed to add events.

I want to know many values of the structure tp element.  But the tp can't b=
e traced. =20
How to resolve this problem?  Thanks a lot..

------------------------------------
System info:
Kernel version: 4.1
Perf:      4.1
DWARF:  4
GCC:      4.6
ARCH:   X86-64
------------------------------------

BTW:=20
I found a gcc cflag "-fno-eliminate-unused-debug-types", I used it, but it =
can't work.

Best Regards,
Dongyang
