Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CBC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 09:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CFD61090
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 09:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhIUJsg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:48:36 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:56875 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231392AbhIUJse (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 05:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1632217627; x=1663753627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kDMwXnOaA3aNhDF9jkKCvMvwPoFpuaa8Rg8JL4s/tLo=;
  b=diOXtTsMXGgw5cOIKeOaeiytP8dMJ6kS2rJ+WCf25wT0HgOvxVg509GN
   1udxPpQFEEil79v3v/Tm9sCpxokhaHAJ/WenfBHj8Qm7w9bXp5XzarIp4
   EE7KQIXeAmIF3k49THQCeepE707T/7pwm6loB1MxATynf9wcA0Rl6mMlB
   +TsRoHYkjU76J9UKOE0YV8d8N2rZP6k7GaZarI/m/il9T/bq6PdnNjFpQ
   73RSp85xBs8LlpRkmENh/gKDxfTeU+nIrOA623BaUDwhngQxZwy7RtljK
   Ua/H2e/xSiHZDAKB9SqYSvYWIy5bYsuWryKiPhsDKXNvaTDg+gxGZJlSf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="47733128"
X-IronPort-AV: E=Sophos;i="5.85,310,1624287600"; 
   d="scan'208";a="47733128"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 18:47:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIk7A7gbdOrYsCV1LMSs1DNrqaWWb5hUM/3YhZldu+Wijstke8mmCduUkLAoUtwrHpJZYBKOhOEww5pCJBxnq5CFIvIknVq9ED+ZwLfjYyUSzkIxvEdQWrnsaOYH0WWSurzpxtG19aSPr/d4ZgrNc6bCLnneJDq248d1Tove0HH/f+GIv4CTF7N8cHVdrrMHtQ/1k8IXKULCHgTyXQKyYC4or4RVNHGSm2TFuW4PLZfMXnmT95zG58KTSLDu1vffqeNe1hzApgzwGps9vyTdLs04EohShX/yiXt9KEO4IWL8tg3JFOiV1lTQ0KElXETeXoLArAB3X2m7ICcVeRqS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kDMwXnOaA3aNhDF9jkKCvMvwPoFpuaa8Rg8JL4s/tLo=;
 b=H0RL18aTPn00kZnlJusEoecUGeTh2ghS08BImfOWcn6Gj9GnMsr2PwCuDKTN/W6UIMayFf5Ql58PkKeNn/9iXIdtnoOJgPsTqJa8CJnvURtgV6VhRVUmbM4GcbSHlbYbmzRxvjoOcNhJG09FGC7iVggqq4nq4T9fiu1jdDbWT6vslJndXC8dpxEAtZdOaIXaYUUbzSzpO+c5GsQYDq7WdBwTdeulsjJr43Lx73ylVEtQXfD8FYamu3dbsqsK0R4zI4nSBiwiFXQIQIN5aEZP0G3Sht44EbX4vC+/FfDKzJyODGRffsNDXP7ec3YRo7m+jll1C1lJr0xg+yUsqYmr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDMwXnOaA3aNhDF9jkKCvMvwPoFpuaa8Rg8JL4s/tLo=;
 b=fwbLxuBFI0iT+frpG5rw4CytF5uEjU8bjA3AKmjoxGtdi0ZerSdN7arFezMtxjTBW+5wLSXgWIdgDczFFyBBOYA6RKCpFYbcQpsIjQMVhV9bre/XAEoi54pEc3F4hMd66cHPbV185IV46qb5O2NbcHZWhTQupLzKmcWSdi12uV0=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OS0PR01MB5571.jpnprd01.prod.outlook.com (2603:1096:604:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 09:46:59 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::e028:fc90:498f:d2e0]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::e028:fc90:498f:d2e0%3]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 09:46:59 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: libperf: lack of interface
Thread-Topic: libperf: lack of interface
Thread-Index: AQHXnxU1v7C7yDhEy0Gzl7rxTcNZhquPLp8AgAE//ACAHexCHw==
Date:   Tue, 21 Sep 2021 09:46:59 +0000
Message-ID: <OSBPR01MB4600E7C8C79D64125270D034F7A19@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <OSBPR01MB460016842A4310264B1CC5A0F7CD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <YS+B6PVHtiTmqZS+@kernel.org> <YTCOVGyffe+VwL6G@krava>
In-Reply-To: <YTCOVGyffe+VwL6G@krava>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-09-21T09:46:58.567Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: e990631d-2055-34a0-a1a2-89289315b955
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d4a0029-c625-40b7-791e-08d97ce4c19f
x-ms-traffictypediagnostic: OS0PR01MB5571:
x-microsoft-antispam-prvs: <OS0PR01MB55713980F9D1438361BCDC44F7A19@OS0PR01MB5571.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NpJ5YWAJZUL6awGKNk3mfts8a1rccazJ3I99CvImRgqmmvjqLnb6WHdGqxxXXcuv9Tf7hBotb+x+mJ7FU4uExPFMlYzc/Ze4wfBhbw0G/Rtk1Q8aMVJJJBiAEy9/bB10TGP8rX7hj41UTP5SRr6Zu8BRygKPxQX/rsq8q6DcssSHUZK9KjJZBTTcDknQfZGFIctrmx/Or+nf4RzLwIN/ps0jBgXnUSraAqaHNnC3zha0+b7ZdrHHVqu5Y+kERbn+p5Y8SrePZkwWTpQovuh/kRDPvpyng7QOm39QUBtsS8qd/HZriVzt33ZIGD2p9w6KVTKiwGczEVfnh6TCbECFKnqUiA5zniPxu7wiytPnWDIpb9y9fYAks9MPyYCWn2gPNhWiRuOwP4Zv7wilt9N7GK1UMMwdRGZgKRktRzbcWgNoicECWkZ7xowYFlFJ7ana49/SO7NZ1KlHqM3jMVeOLTcN/q6lXg/EOxXw+mewnJeH42mcTwUUmjNq+nWlelf6rljUH0lmN5Vg3Vvfmp1SSxU09nF4LxPyt31HjX8ennRySJXogzJaJM0+I5Jf4/tlUoelqmf0gvDIUFIxoK7rssTrPu6k0K2ZKNPjwPhOAiUy+q75y78wBSkTme1XPVJgqc4ryWc6ZqDZqHxhFLWXLY9WdKSbN+GWVfbrW4A82+God0/yFCo7MQm2w5FWRsk35DjJg5+7WCV/44lsLcpGEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(110136005)(316002)(33656002)(38100700002)(186003)(54906003)(38070700005)(508600001)(5660300002)(8936002)(71200400001)(8676002)(6506007)(4326008)(122000001)(76116006)(85182001)(66946007)(7696005)(55016002)(2906002)(66476007)(9686003)(66556008)(64756008)(66446008)(52536014)(86362001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dzU0dzVsSEE1SXc0ZGlCR05rOVJsRjN0K0lRb1d1YXYrcWFNMGpVeWRW?=
 =?iso-2022-jp?B?NjZraFdZMEhZdVNYTCtCUm5ZbmdoUHlISkU5bStkQThJTkJybE1WS2Ju?=
 =?iso-2022-jp?B?Vi9qNGpYQVIxZTltUlE3enFkK01sTTRzN2kzRzk2N2F1TFBDWGtPTFRT?=
 =?iso-2022-jp?B?OWpLRm5QcHltV1R4V0FrU2swOGg3eGR0NXVoR0NScVFQRVZsd2FuVzY2?=
 =?iso-2022-jp?B?WkJpd2Z3WUpnU2RaR3JmaWdXcENGQzBTSVFleDBuUFFmcHdPUnM0WXJ0?=
 =?iso-2022-jp?B?dUFCRVBPYWFVa1JSZUEwSVBoTUhqc204MVdCZ3FrN1B0OTNhTmNEbW44?=
 =?iso-2022-jp?B?aHpKTzllS2NmTnJ5ZHlURGxaaG5NYmVyTXAyRnhDYU0rV0NHMzdFMjV0?=
 =?iso-2022-jp?B?MUdjNnUweFlXWjNBSG83MTVYOFNkT2pIamU4WHJ5dXJGQWN1djZZQWp6?=
 =?iso-2022-jp?B?Qy9tRTNwSkk1ZDg2ajNkQUJqUno3ZTVGblZGYTI3M2RUSS9qU2w0a1FC?=
 =?iso-2022-jp?B?bk16YUxoaklFeHg5UFBVbzQ0eHlrMElYbWtTV3F3eUtqckE4dGlzcUpN?=
 =?iso-2022-jp?B?TjJDaTNQM0VUNmN4d2VMZ2llVUd5UVZmUFJCT2R4SG1kTGhOb3B1NGx5?=
 =?iso-2022-jp?B?b1RlQ0dVTTVqSzhmeFBqMlF5Q1pyajdxZEowU21FeEIxODN3YTRuV1pC?=
 =?iso-2022-jp?B?NG92WHFPUWFjWU9IOGozSkptWE8xUE5jb1llY2tmVTZuSzU5ZUJqQlJJ?=
 =?iso-2022-jp?B?QlA2Rjh3bDlYTTQ0M0hrYjlJV2ZUS2M0SkdJZERITVFrVm4wQ053WnVO?=
 =?iso-2022-jp?B?UStFZUQrbVA0b1lBRHhHR1lxUWYyV3lPRS9FbDRNUWFLMEZiWG9WaFgr?=
 =?iso-2022-jp?B?elMvNStVK0Q1Z0w1SnVQckFtZ1M0UlJ1MGpjK1JmbEpFT1dnQkxoQTdL?=
 =?iso-2022-jp?B?NXpvSC9qZUVxZU5vTnAwOHdNb3BremJudlpwRWZwTWF0VC9HYUVzU21E?=
 =?iso-2022-jp?B?bEV1czRJTk9mTnR4QTlidkJTbXYybTVtN3dibEJqUFgyVG1vQkRnSVY4?=
 =?iso-2022-jp?B?dEhRNTBhWFAxeU5EZ2p5WlFaQks4dExwb210K05mY1VrVDVsUGtFT1la?=
 =?iso-2022-jp?B?UkFPWkhmcWhrU3lPUC8yc1dWYkZKMkh5NDRjdGc2UEVJckZldTNrR0Mz?=
 =?iso-2022-jp?B?SWxOOS9INnIyNG1wNWxEYS83YUM5UFdKbzNaVk8rcFFrQ0t0MmR1b2Fh?=
 =?iso-2022-jp?B?VE12emxWUTVuTHJmN1Y4YnA2d01NR1k4eWM4NXdoQVJzN0xJN3RFL1Ry?=
 =?iso-2022-jp?B?UVV3TnhxbXRnYUxjdTNiTUlHL255Z1F5ajJGbFlMUHFiYkV6ZGpGZWZM?=
 =?iso-2022-jp?B?OGtpYnBUWURNV0hiTkVVTGlmc1lsZHM5N3dlS1pRRXYzRms1Z29vRjdQ?=
 =?iso-2022-jp?B?cVZJanRmZzBMaFFrWXRvVG9iZytiZnRZNWYvMjRxR0kxa0RqVXY4QS91?=
 =?iso-2022-jp?B?L3Z2T3FLNVFQYitrL2VjZ1g0aFlGRURpWDQrNHdad05mczhtbDFDRmwy?=
 =?iso-2022-jp?B?Rm0yS2VKbXE3c0JteHBkenBxZWpXT2hIVWVQUVRVRVJhYmhlem5DMk5r?=
 =?iso-2022-jp?B?elI4cHBsWmFSSUtuamVxUll3eG5leXYvL1ZhUFN3cTk1RWpBNCtRYnBG?=
 =?iso-2022-jp?B?TFZHY2l4aUJDMklhNzhvVmo5aUsralc0Njltam1PZEQ0ZHRqNDZ6K3BM?=
 =?iso-2022-jp?B?d2V2VlBQUUxoR0ZZa3I1NnZFWm9XWHh4V3dtUSt2b3E0VU9haDQ2b3Ra?=
 =?iso-2022-jp?B?bS8xcGh1S2Y3MXJvSUFPUnBKckFVemd6YXRTNDdBRS96NEtvczROWUZz?=
 =?iso-2022-jp?B?eXpmS2ozaFJBeEhGRkNKSjdDRU13PQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4a0029-c625-40b7-791e-08d97ce4c19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 09:46:59.1428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mr6i8WCOx/lPB9qRKHe0NY56Vhgr7pdhxGqrrAz9tz2Tseh4NJOge4reCta/VbfAN3DMQ/LnztkNsprNjpvejd6bkG7murz31cydqBdaVoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5571
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, Jirka, Arnaldo, and Peter=0A=
Sorry for the late reply.=0A=
=0A=
> On Wed, Sep 01, 2021 at 10:36:40AM -0300, Arnaldo Carvalho de Melo wrote:=
=0A=
> > Em Wed, Sep 01, 2021 at 09:45:10AM +0000, nakamura.shun@fujitsu.com esc=
reveu:=0A=
> > > Hello.=0A=
> > > =0A=
> > > I'm trying to change rdpmc test in perf_event_tests[1] to use libperf=
, but libperf doesn't have enough interfaces.=0A=
> > > Does anyone plan to implement any of these libperf features?=0A=
> > > =0A=
> > > - Interfaces that can run ioctl (PERF_EVENT_IOC_RESET) from userland=
=0A=
> > > - Interfaces that can run fcntl (SIGIO) from userland=0A=
> =0A=
> hi,=0A=
> we could add perf_evsel__fd like below, would it help your usecase?=0A=
> =0A=
> if you described your usecases in more details we could=0A=
> see if we could add/move something to libperf for that=0A=
> =0A=
> as Arnaldo said below it could be already in tools/perf/util/*.c=0A=
> somewhere ;-)=0A=
=0A=
As Peter says, I understood that for rdpmc, no reset is needed.=0A=
=0A=
However, PAPI resets it explicitly, for example, at PAPI_reset.=0A=
In other, PAPI also has the ability to call PERF_EVENT_IOC_REFLESH on overf=
low to call a user-registered handler, using SIGIO.=0A=
=0A=
I think it is desirable to be able to achieve similar functionality.=0A=
=0A=
Best Regards=0A=
Shunsuke=0A=
=0A=
