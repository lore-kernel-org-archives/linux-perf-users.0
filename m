Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DB2C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 07:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FA4613EE
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 07:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhD1H4f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:56:35 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:29957
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229643AbhD1H4f (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 03:56:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTcTMXi/BoqjASwBAdaRT1Ni0PsmWALfccZsnlxvYF1TlKs9zLhjIOfQIkEyxu7hZvshv63YYsbnXpwuSKUcIg/irr5J8Q84iM99/kr4leBZf6GUgPPl12wJEPZp1A6ZoCgC/nXKL65JvJZm3QOQn0/6IvVXMzR/9SaVQHPh79DjKQmit+E3GM64p4qWhFvlrddeRC/hL8YzR9NXnS0fYIo8oou5kZ/BbX+RiF0bLVUSX4VAHrZ60QLoCdBjD7XTyBcWMHwn8wmm3sRoPxL6/dax0Tnpyw+nvVJARouosk379XVUxlLDMfTTDqLzvZPvNFNgO72pfzoHl+v2YNe4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNjvgws7XQf/7bLzkis4ROKbI39gwtohc6bycM6Bjwo=;
 b=HJWuEUKSOtuUfJ/9Rytv8Kn/Xp458Fonfse+Yxs2baC450McpY4lFEvwwHd+TQOa4k+uDSXAOL6UUhjAbM29psn4tEgIVANPiMo9+uHYQ9+Z2TE33Cl4g1PPZBYo7WWboFhznGpHvVVSUqjyEFAwGydtxY0F3oL+yLhrIK18bo5GIK5kzNdOnc6L1JY1K0fAL5+yv3h07mB5EjsKjn8otKoMQ0iwky5nYw6Zz8ZTeIE0Rk+BOFHPidnQYDHRVS/woUKSRsppsFBHPTymKGqRfns/vBEamnWPbcMxlcq+7huLZXIAnmAU89xa/BCznPBPymN7QnxtToYk54Am7qJciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens.onmicrosoft.com; s=selector1-siemens-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNjvgws7XQf/7bLzkis4ROKbI39gwtohc6bycM6Bjwo=;
 b=brl/Ymx6xujQasZnwjvOJiQH1dW1jNFYjTLJO4bb7bOh6vbMbvtArO/sOjYlIK6DVvghP6MlmPn6qkGR37+npSf+2+Ej6pTVkSLaWhiBTu4HHlT30yl8H3Hz0xPp2Iem+kN68ZcZ7LTOHrS0o1YPZKIbMOjVc0o3ZuAqDBwBHsU=
Received: from AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:44::22)
 by AM9PR10MB4279.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Wed, 28 Apr
 2021 07:55:49 +0000
Received: from AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4969:6177:f82c:151d]) by AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4969:6177:f82c:151d%4]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 07:55:49 +0000
From:   "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Versioning of perf python bindings
Thread-Topic: Versioning of perf python bindings
Thread-Index: Adc8A9kC2rbNil8yRmGI65/cbyDsaA==
Date:   Wed, 28 Apr 2021 07:55:48 +0000
Message-ID: <AM0PR10MB1939C71C276E3503CD1CEED489409@AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-04-28T07:55:47Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=38ca2612-0b49-4f9e-b467-523094416b54;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=siemens.com;
x-originating-ip: [147.161.171.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bd2d22d-a42f-4ce9-d4e8-08d90a1b098b
x-ms-traffictypediagnostic: AM9PR10MB4279:
x-microsoft-antispam-prvs: <AM9PR10MB4279869A973C8A00F855224E89409@AM9PR10MB4279.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ti1KArSYdfgTqoTmFqeroaE9gQZF/FfB0A4SlkW8qx8/hsl4pm9NzSAiGLdv4T6CpYLgfD5wFbKO+jx5Sm7CnL5DcDQSLZZj4EZ9SzxGJMy8PStrFrnlfByrkVNuI89k3KmcozZ2TmVlZsqq4VVrVObOFRV5Qo5B5qpZ3hEzUyWwb41Ev+/Q6kKIpiT90q0qaRC9e24xFBHQpdbvl4kZLelsrFYoXqY/uRw4HcXDRVZkIQw8OEJB7oSBEckOMXJVif5XYjPX1q9a6KehZ/SkuS1lg4XF7gueGyF/A82LYBAN/qzur6VA4BHcSNJ3NPgm7VtA+G6CLntdgf2WD+qi8OWFoS+t7JrU3jm8qmcT1WdoEyY+BuhmeNLs0O5E8yFO1Umog6CveZR1iGMHPCztrWa7hmRFapjphF5YI1f7leWCxDs4MjV/F+6XyrYdaIVlBFxBm0qZJm9W7Ku6cmHtM/A9oONSW9vUdyh2uHz2XdXSE6kM4uJQjZsglCmE+Wh9ZKrJhHLprZ3trOZG0EY/3SFhVqEzBVBpdD8WauHSXW43TgvZ49rvOzMb2/3RRhLjYKvT/JJJyj26g67k9eCSKgOeEShhBi9FEoQCzsmhQ1m0VhrfD/ngi1DebLMAyGhmFqd44hjV2u7GQpt7XMF/hUgnJMWX2+ksecYZmkjbBdy/ojwf/WLjuxpuF48Wknju
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(86362001)(478600001)(8936002)(8676002)(5660300002)(966005)(7696005)(33656002)(316002)(55016002)(9686003)(71200400001)(2906002)(38100700002)(6916009)(76116006)(66946007)(6506007)(66446008)(122000001)(66556008)(52536014)(64756008)(66476007)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ODdXbcUQw4ooQN7nji5SXaXYbJd4JGzwVZewqCAq0Wdpu1Kf+2r0NFoQZm?=
 =?iso-8859-1?Q?XZVRiU3Tv1fj0a3ZHJV7s3Hy9rX946WXftgsoCLgU4C2F4cQaS3vxHWe69?=
 =?iso-8859-1?Q?pks6kHjYx3OWQiQyuLgMycxXJH0ub+6sn+8WniOprKpTm1T0B6sGkaDALr?=
 =?iso-8859-1?Q?maa4CqnVZkU5CKmZzSc08YWnmbQVfhF+ULH5IWZZEbxO5vxqsgbTIaNayB?=
 =?iso-8859-1?Q?LJeZr6aufOWzTefar4/avOzLqYkaY/9iqElDuhuvk74o4EqEYAii9QbXbd?=
 =?iso-8859-1?Q?jQ/VPhtZ7FgI9Fvjq/wgGjfx0yohy1p35ZaNeQEEleLC93+73ithfvlT/U?=
 =?iso-8859-1?Q?TzGi6dOLvyrzvdqkOCfpm3ZTb1uYx1K479rUlXUsnFxGaqBsXBiqUQgF19?=
 =?iso-8859-1?Q?Q8fAoNyLyFBL7VhM0tBq9IVEPwc5rwX407NHmnAlJ0mtLzq7jENAFxmVUw?=
 =?iso-8859-1?Q?Cp4Sm81fR3FNTw2uKEUZ6YDjAP+sonkTMEvzknCQpNAKqjyqIkdJP0NFqG?=
 =?iso-8859-1?Q?a+boUkfbmOM3jlC+p6KVYy7tPbtaqaIajACkHZn0T9Oy4+2RLmXDBguALs?=
 =?iso-8859-1?Q?d0o3qWi0BkI2LW8F85MAUZmAjN9CDcqDvf0aU5gHz1l6EEANOOEkczUOWn?=
 =?iso-8859-1?Q?11bf4Mzi5/sS6C1ZqS8knoNW3xOPVa6GMu9g9wXcAOQ4Rxn/DpdrOQ86r0?=
 =?iso-8859-1?Q?6JcnGr3S/HokfQveJato3HrDEtO3zxKkpX/bLEolL1U9hrn6pE1HxcMn9M?=
 =?iso-8859-1?Q?0/nfEw8x697My6IfcfZFmYpYy3+g+ifAnuVy8jMj3APk6TR0r+Cfumg/Vd?=
 =?iso-8859-1?Q?SNiebwpJVsZB7FuVbey3Yzwe0zdXM8BQjEuhKR3fpdIgYoRFdeAtlUfy0f?=
 =?iso-8859-1?Q?d4dnHhcHREfEwyMMqq3KXGwiKEh/X7PTiT8g8nddzxY2RMGUFbuRvH7O6f?=
 =?iso-8859-1?Q?viLFYALEZY+/uhr3xm4c3oRAbRx0Px+u29Kn6zR1p7DqMnkYX7EEtsoop4?=
 =?iso-8859-1?Q?I8BpJZTP41UTh2cjTazv6x7kVPajqU+mt6V7fsN60dt/lyJB8njaOKvmJA?=
 =?iso-8859-1?Q?aXoghkiTQOyrI+/ro7epq5QKSRrXmbhcPVJ5CmmZzQ4cVCcAYNuiDaDErF?=
 =?iso-8859-1?Q?bNv05z2W/e8lG7z/8pWDC9EQFL9WkpdbVeuDxR9K2g9fZ0FAeK5EnlHA/H?=
 =?iso-8859-1?Q?Dgt0R6z1hHVrNJFJRmkORp8v6vjmidmiG4ezIBZV9AHoQlOzgRvkBw0z2T?=
 =?iso-8859-1?Q?k4GvuVyE6G5yUV+rEJUJp0/aDkHE9ekTwnp+vRudZZ3iZU9eGUTOExg1rL?=
 =?iso-8859-1?Q?kdEI7ghZjtbZlY7+HNXCHWFKSMeHYnu9Xg1f+okxtX+zJTrJkyblujSrsj?=
 =?iso-8859-1?Q?4Smnoozwdo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd2d22d-a42f-4ce9-d4e8-08d90a1b098b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 07:55:48.9789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huIn175tdcgvGASPcUoRLNIojbjYQwqXBI43HUsCtn/nGoE/u3OdK3t9ZuPylbQ4Mh5+VIRE5IlTvGNf+vcB6bat/LZfR31ByVQZKp2d0PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4279
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I'm working on packaging the perf python bindings as a versioned package (e=
.g. perf_5_10).
Having the version number in the package name is important for distros that=
 support co-installation of multiple kernels (like Debian).
By that, multiple versions of the userland tools are installed at the same =
time and a wrapper is used to dispatch to the correct module.

However, as the package name has to match the PyInit_<package> function nam=
es,
for versioning we have to patch the tools/perf/util/python.c file.
This has to be done for each new kernel version. An example for this patch =
is found here:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D860957#10

Now to the question: Is there any versioning support built-in into perf tha=
t can be used to simplify this use-case?
I saw that there is already an auto-generated include header that provides =
version information for perf.
Could we use / extend that and replace the python-init function names with =
macros to inject the version?
Together with a define, we could implement that in a way that is backwards =
compatible.

What do you think?

Best regards,
Felix M=F6=DFbauer

