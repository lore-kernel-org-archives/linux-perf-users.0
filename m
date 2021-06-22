Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88384C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 08:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFBB6128A
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 08:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFVIHd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:07:33 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:39405 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230121AbhFVIHd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 04:07:33 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jun 2021 04:07:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1624349118; x=1655885118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hojyqHIdkGcpw9RgOU3aUINwRI6Y1R2XvDugqogu8FM=;
  b=ZaowFG8DXUQHvaX//7ifppOEnBp7wzcGF9GgRhg3sMTT9ISsaRseczCL
   ldcntaZZeXrmxfz8R53l3QZNp4LVRorvHJ7Ct1FKgD3NksFzScucq+KMd
   OYb87vgDozdiTBwSsHvjJF0azsI1O7sGQsdVBWOGI1yQawy/IOg8aA4D7
   mCmpKKqPe7HWwZzgIhqqmS7pvymhGzzEuNa2UIDks8mpM+dtqUQBIj9Ge
   G5Bxkj7MdI35Yise1sI793+ErkjKPO+Emd7O5/9bF3KX99zPssuoXn4+w
   UJSZ9eOCac5Fs/XVY5nTDJ8O+4E5LjUjHmymJJE7nyyhbOhQdqJyfw6t9
   g==;
IronPort-SDR: AhrsTuQwc/eGtea9MjC+oPI413fLpZ83JG0jEML40cV1rh17IlvfTp21C7Vxh7mXhf3UoaGeFX
 uCiC71jbmB6VhIjwZJX5Jc7xGyuz1v64dkpxSoTmOGhY3IyC5KruWlmqwtrQyC1nC9kMFeA+mp
 MMbY9CWcHNyJvqY9nx/OSmTL3nJjBdv45oxTYyoQn5bRzgFsYBgBCSHLqW8nuX+Uj1Tq6bcYnE
 V1uFTZUnsa5saA31jY1UIi7FhQiJ8rHc/kiIdWECJHMr4rzCnR7QcSO13hoeaWcS5g9kA0Ky1d
 kh0=
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="33505386"
X-IronPort-AV: E=Sophos;i="5.83,291,1616425200"; 
   d="scan'208";a="33505386"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 16:57:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYT5BhFP2jQUMh0toLhBOWa+GoxDgpV1lVxtQdOSQBEnJ8iwcXT0ItrvzYEt062mVryTgH37gTiSXbXNg9jmxwoqpH1Cl/iX0ejIQ3hMQQ9kZ3RRaCZAhOBsZAgqSI9raTaiRFRGZ2+7S9B/SlVbHVNT87n82K1pB39VSLC78yTuOZfRmhbPX4iJ2v+3pHg1wwKUV5KLFpfXC/uPiArqs3hrywuxDkdKleKgHRQLrYlTHOgQFyXahKFYkyM4G5MVBZhghScKCumv8vRAnlnH17YCJX3msjTF8aCj63tL5TNBsTikjIFdPdfBKvILDtjR3tCqDgdtyZon+Mof0wv1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hojyqHIdkGcpw9RgOU3aUINwRI6Y1R2XvDugqogu8FM=;
 b=M0Rha/HURsoD00zKKnjO5uU0Kr9hYmVsLWJdEDVVN9rAnx9e4REjnfIO5xuSx6sQsXTvR9tQaoooZZ1UjmVHLEaUjKkI9vS91V0Vrk2onKGvs9hAoibopvIV0KUgF7N+xSEt1UtrsXsrfXWr8LCjZLVrkDMPDOXXyknKRX7CTs76HGVoiakh6nZdPiemSxiAYQBpZu1sZR+4Zs8lNiRuMVIKmHbV/unSf3NwyJiNDv0Wtj/k2wzpeY6cUDJJNefc8aJhTKn/yWMF4OzidrMmjCtJlb1dUoilFXXj4kVzp7KgCjBnRlGY7npM91fPqS9+4PuY5lkHPOsOtOulI90Ssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hojyqHIdkGcpw9RgOU3aUINwRI6Y1R2XvDugqogu8FM=;
 b=VqlDNMtiPViyubRo6EwEFcQRWdIy95R6o/LXoCVs3oD8yQXd6RtgUsp58SkXL/Pe31rRZiDmq0V4aOdC2JgLSfIxQ55xpNlDRHl7Wa+7G6S93CfI8m6qjZZ1qYwNf2VDZ/dCUWz0NGEyw8DMWO5w0umDEI6JoERxmt1COE8IdHA=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB2497.jpnprd01.prod.outlook.com (2603:1096:604:1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 07:57:56 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::8cd6:d0ec:739d:5284]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::8cd6:d0ec:739d:5284%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 07:57:56 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: libperf : Can not create event group
Thread-Topic: libperf : Can not create event group
Thread-Index: AQHXYOz1byLB4GfrUUijoG/ejweJRKsTW8YAgAxaN1M=
Date:   Tue, 22 Jun 2021 07:57:56 +0000
Message-ID: <OSBPR01MB4600B6FCE4D95F6B84E7E17CF7099@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com>,<YMc6tBoIQiUQkRbq@krava>
In-Reply-To: <YMc6tBoIQiUQkRbq@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-06-22T07:57:56.211Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed896097-06c4-4217-4f29-08d93553726f
x-ms-traffictypediagnostic: OSAPR01MB2497:
x-microsoft-antispam-prvs: <OSAPR01MB2497CB0D34236391EABAE343F7099@OSAPR01MB2497.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bU78w2HowH/ScY9kc2Rl9xVnOdofAsU84IDv85HQ82wUJncjHet1+N+/7fCHbdEpi+C3oa/O/23Ej3J+of94gTANJ2p5sYuQnqdhXVOvYYBOZoP0LRqDy5oftCpX5YHnPr63agIluLMl88o99oo8GBbsstoetP+mxy8l4D/7tF4Ba0uIrHLsMgGHn8qKrEajK91Zur5GP5eNm/QZeFH6P4ccVOGLTBKflfjhU2nmmMhAthhLYnlNjmIkqHcmkkmqcs18fgPTpPqPwVTQe2qlfd7XAHULBImkwqxYa+Ucokd9SekWvY18PUnQEo7AaCrIN4ERA/nsAEDunmhrdliq0+SKAD/+2CqIr0d/ptJeyQqjY0SE/2lljU8ZHFE3Eby1z6b6KOU5WCEaiMJCTuWuxL485eI41HeGVBFofWz7GgYLugqbon8SIi2a3mDH9xl//cSjSGoEj8MICNgTUUXfbgJEdCuGQ2It3qnI4pnAnCdxIR6Uqah25aF9uR2LMp+gUoftWwp0jwBkF3UWax43xPy5rTusUhzcGK37HhXsH+U8pyJIAl+932iNv0GlsT23whc6+xQUHyOd0RXA72ClXIyU9/pAYjYMvqHSrjYJYLs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(85182001)(52536014)(5660300002)(2906002)(8676002)(186003)(71200400001)(4326008)(38100700002)(33656002)(86362001)(122000001)(83380400001)(26005)(66446008)(6916009)(6506007)(66946007)(76116006)(7696005)(8936002)(558084003)(54906003)(316002)(66476007)(66556008)(64756008)(9686003)(55016002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UHhEY0hOLzFEeFhNU2I4dGgreGxJSktjYzgxKzZZRmtiY2FVaTkzQzUv?=
 =?iso-2022-jp?B?UXlrUFAreUlJcDFBYnFFRWZML01meTFRS21uMFhnTktHYTJSaDJ6aVFs?=
 =?iso-2022-jp?B?NGp1bnNNRklydnFkUmNpei9wOUluWlh6TnJ1TWRrZ3pnYWZBWXNiY1dJ?=
 =?iso-2022-jp?B?aEprR2xqVEk5NjRXZDkrKytJWkFmRWQ3RUlsSC9YWElhZVBzWFViVGZK?=
 =?iso-2022-jp?B?RDFBUHRWcHljbEdLV2kwUnJVZ0h2ZE82RkFUYzhZVHFxL3NaZ3ZjNW9J?=
 =?iso-2022-jp?B?ZVZOOUE1RVVDZ1VuNHd2d2VtV3RuTkJuWk91WExYRlVtOUFNN1RGUE9O?=
 =?iso-2022-jp?B?TVl6NHMxUlNRajgyNk5rcDFvOWt6bXVlbFpZa1ZNSC9PWllZdEp2MFQr?=
 =?iso-2022-jp?B?a29HbDJ5TjY5cDFneElpbG9pWXp5U1JmNzhDVEJSdU5RZWt2dVN6Qk0v?=
 =?iso-2022-jp?B?WmdpTUk0cloyRzIvRytsWjJ6QWdRTWZUbU80NDYzeGdYTEdrbU9VbE5q?=
 =?iso-2022-jp?B?bVR2Y25JOWlCcnBKaHhUYXpIR3ZROXFha0xuZy80cDZoVjhNVE9GZVdn?=
 =?iso-2022-jp?B?bVE3NWY0UUJuZktmdHh3Rjk5Ryt6ejBrOUF3OEhJakNmZkFJcCtURERP?=
 =?iso-2022-jp?B?WDJjUThGOHVYOTdBOHZtaUxKQnJoL1NZaUtjQSsrZnhkeGg2aVhoKzhP?=
 =?iso-2022-jp?B?ZnBkeFBSek5YK0Q3TW56bGhaZjIwc2dlOE9WSmE2VFFzWkk3N3NQKzE1?=
 =?iso-2022-jp?B?Z2tOcVlQWGtDR0VObklZV3A1THRtSVR4dVNyZXFWb0k1bjJTY0tMU3ln?=
 =?iso-2022-jp?B?aHB3N3MvWlkyK2VIczNoSWNzS0s1L0p1eVdUOE9zK2JpSTYwa25RbnZU?=
 =?iso-2022-jp?B?cE5PcjkwL3NyRHU0TjlhUmVBalVFVVMxZ3pBd3JZckZsU1FyS3BDc0dK?=
 =?iso-2022-jp?B?WjQrajY0NEVvNysrUVZYU21zWG41Wi9UVlk5VmovS0Mvd3Vsd2VGL0ox?=
 =?iso-2022-jp?B?czNlMGxrYzNRa1JzVzlBRUVKLzhWQUNNRlQwL082NC9heTBYeE5NWHB6?=
 =?iso-2022-jp?B?VUU3QW12SGZYNHVaOVBZdG50cHFrRlRuMFkvanpmdHduM2ZIS1JkaU52?=
 =?iso-2022-jp?B?OXMwWnluOWF1VmROSW13NkJSQ3gyMVdnaFBsUlpQTi9TV2VlUkllTEJ6?=
 =?iso-2022-jp?B?OHZYN1NkNmNrdThhNmhacnhzamVsQW1vVnNGSXo2SE5rRzRYaGdHa1Uz?=
 =?iso-2022-jp?B?cXBVQm55bVNWZE1kN3JOTkVoYkQ0dmRpdzZNbmNaamhxWnZET3ZZQTVG?=
 =?iso-2022-jp?B?bjBOa0tqd2xIZTFCL0Fia1ExcmlSdlZUZGM3MUhTMElFODAwZzJBTm1h?=
 =?iso-2022-jp?B?ekxZV2doalZ1TmhnRit3NFVYaVFPYUFHdGZ4dkhaUFJhT0JydHhMT3lV?=
 =?iso-2022-jp?B?MEhZSHc3ZSt3QUlmMlBUYW1DUXpFMzlhSnFWaDBvSXBFODlLcXJOSGlo?=
 =?iso-2022-jp?B?ZmVTZmh4VlJvWERBNUJLa21MYWxkVUNrTEtiL3BHb3RENnJjRFFhSzNG?=
 =?iso-2022-jp?B?aDVXRklWd2I1VURkSS82a0lVRC9UaTg2YmVYbXYrYUUxNlJsT0tEM2Z5?=
 =?iso-2022-jp?B?WFlOdGJSYm5mMXNjZ21ySFAweFQxZ0hZbVhKZlRrN3prR2RTT2JUYnFW?=
 =?iso-2022-jp?B?VlBiUWs3SlA2K0xRNGtIS2tqN1A2TGFxSHRmYXViSW9nK2luekhMemVm?=
 =?iso-2022-jp?B?eU5tUU1uY1ZqNU9sZCtUQ3FJdHF3SGVFQWlSQ1NpZzNkRHE3WkkzSnZ3?=
 =?iso-2022-jp?B?M2tVNWFtZFFoMHJLdk5ubEpZM2poMDZOSkZqT21tNWFON256MDRmMW9h?=
 =?iso-2022-jp?B?ZkFVaWY1ZHFrSjFKTGwrYStmak1nPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed896097-06c4-4217-4f29-08d93553726f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 07:57:56.7331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NM+MOqYz9wKuAkHxViafLyVhNA3+OXoyrBX45YSVgN117wcgh+uQx09FAq2xSNqHdxglX9xecd/5PT4zVmH4yZN1NRzASALAeDG3GFgbeTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2497
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, jirka=0A=
=0A=
> there'no leader link on this level yet (in struct evsel)=0A=
> so this is not implemented at the moment=0A=
=0A=
Thanks for the info.=0A=
=0A=
Do you have any plans to support the event group in libperf?=0A=
=0A=
Best Regards=0A=
Shunsuke=
