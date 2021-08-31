Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E1C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 08:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB3F604D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 08:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbhHaI7b (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:59:31 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:1543 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240405AbhHaI7a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 04:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630400317; x=1661936317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OKyZPRP0S1b98TdOCOtjkGGX2JkMNCBRWozoEbpygE0=;
  b=clkTAzSUarOc9RLGu46VT3K0B2vfJdgfjWPTnBF+moKhMHoX/izYBqwa
   df3ufZhbLfkjixTcIj6quh5uqz3Thdhh7R77MQN17xHzY8HBs+ay+FaIo
   dT763fWWV/izJ+qnSZlEUnXUd+u4+6fLYktdq7gSpI853nmMcokA8CDGM
   CwVp9yuJ4BmxiaEA7a84Uf42eX1I5AZJu11bqE2SM21+fo3soCS0oPQZf
   EhfB79OltA9sQwpS5kgbUrDTCvEkDRzMu4Dtr3DfJWAVJ2SivwT0hrOYb
   DKegSqaHR1Wmr4jc++Lwnwk+k9oCT5YLIy4PmMqRUP6BR49PbKx9wPUzq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="46264407"
X-IronPort-AV: E=Sophos;i="5.84,365,1620658800"; 
   d="scan'208";a="46264407"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 17:58:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVnIREfYOyJRTf3JzTXILj2aK7EU4bEr29EmQqeejAksu8haG1usyb16A6dn81e5SprtKUrXl/4b0J5rxBLxsgitjw7jFZXfx/5KJReT/dHK89+Z+tdAji+/bIquWp1CtpmHf88jZr0x3Z9TCqw0Bf6NtNWmAD1VOpqQiNso6JUFZ8WMEhMBz4378/W0vuKuW8LNTB9SgT82brHBpi2UTG7mPh+Anl7pSeFmW51cVviu5Qv8kQvq+xGxjzWdmHSL3vAugY8lmauXAcRVHQUm1FBOaEPTpeajatp4aHR76GCjXz1LPHx/DOXc21VvJ9TbOyWm4ZjH+tKWSNmzbfd81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKyZPRP0S1b98TdOCOtjkGGX2JkMNCBRWozoEbpygE0=;
 b=lKM042msTyTFq65/wEZLK2C+KMN1ouuaCEondIu0mxmVjlsa00mZ5Crp+wOY9Xj9wHScfsmpKk4NL7XCj9RNMNTRBA6GjyddW+wfgTyIeEevXMOAx8J3BlKu7uChJ2eaSAyGM0pIPcXyFBD9OEGs0G9BEMmlr5rSCIoHoC+t8QuBca+/9/+DMilEQQWX0qDF2PcSOxO5ILYiJi+dw6wXES0hnzbi5QP/UZxGCDHU5cGPJwvuIBv7gjSxx9S13AV4RVOMitXqknjRDf6dQMiLGZAMZydmx4CFu/do5dWVLladymPzGhiboV+vGAyPRfUJkuXQohi95leup2d/Dj3peQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKyZPRP0S1b98TdOCOtjkGGX2JkMNCBRWozoEbpygE0=;
 b=YGqtd0i1YulJFSelvh29onzg5SuvYcBVpVxCLvx9CJ1mh2vkU+xHPDjAd0shUgSmjRSBRLu1YvkhGrX2JZepfd8zK9qko5BsoZbzlidGz6tvhwAkrBNHY1lvlNRQPwyiVtXcZDacasvSdqAEKTUZtT6VAExbGTGwDydDmzl8L7A=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 08:58:25 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::112c:564b:88c8:1cf8]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::112c:564b:88c8:1cf8%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 08:58:25 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Rob Herring <robh@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/3] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Thread-Topic: [PATCH 1/3] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Thread-Index: AQHXmFsxBFGvQYUD8Uu1pPLYL2hYdauCbgJwgArtTKA=
Date:   Tue, 31 Aug 2021 08:58:25 +0000
Message-ID: <OSBPR01MB46002E098D8F3B3919C47991F7CC9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
 <20210820093908.734503-2-nakamura.shun@fujitsu.com>
 <YSQBI+FZLBvKr088@robh.at.kernel.org>
 <OSBPR01MB4600288E176A169C07BF543EF7C59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4600288E176A169C07BF543EF7C59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-08-31T08:58:24.835Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ab42369-c7de-4fdc-6f58-08d96c5d7e35
x-ms-traffictypediagnostic: OSAPR01MB2737:
x-microsoft-antispam-prvs: <OSAPR01MB27374D498D7646EE7B8984A3F7CC9@OSAPR01MB2737.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uuflCY03YJJwWjtvw+AwTWnsd/SzoFOgTmuCjdsPNl4r2PoC15QDe7mVchhOpQ+LqmCorVZX6mC/YDX/MR27JP+9/ubr7mJYjN49FKGE8BEtrvQxZUUa1Y3kUM+3gBFGJd6331GzF0Wcim0aH6pEc2UWNHjVMrUrDTt+KI+9qXzROt0mofmZJ+j0Togz7emQrwxCAw4lmCrVYI32J5mH8jYihFFdmJkl1Jv6cqxczAsZ6xKVBkYHGKjetOAUQshq0OgMYur6j7FrRjNNXtmNXSjEFgSQwuU1quyQpa6Q9zE+6z4+c5nuooUCIrvegmsDwtbGkJDfFSQxbh6oI3/5o7AeRbS9zmYdSuWcIgu82j6HD2qlytH2ZBgK6Pm/XWGtzPaA8laejNRZfGwbRJAHFG4m066reRBS/Vjnu+YfpAhMmo+7wjWvPdaDiXDegPd8aFv+uXEAyLtHDPn7NPBpKGRS+I9BaskAX5O9qRqmFsI3WUuZ4jL/3O6PTjTrnr0z9+uN7B9cufzWuijPhwslnCWm6U3XKu1pank4KMy+8GiXleZ6D0DEOD1/c+GP872zVmwlbQNsm2L1e7LIp81uPauzIpAack0hbpSxBXFM1ZfJmFSV9BLn6diEsw3lysYjKiyEx5xCGVktZXKnvhWjvKrxVzxSlQ28TkKTlMkNjrGwTuovJI8G+kA+1/MAUPZqAXWlgEG4xyKKO9sOPcl2rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(7696005)(2906002)(6916009)(6506007)(33656002)(38100700002)(4326008)(91956017)(8676002)(5660300002)(76116006)(71200400001)(8936002)(316002)(9686003)(66476007)(186003)(55016002)(478600001)(52536014)(54906003)(64756008)(7416002)(86362001)(66946007)(38070700005)(66556008)(85182001)(66446008)(122000001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UDg0WFFjQzVUNU9abzBrZWJJRk5mR0I3Y09ueHZ4YTVkNFViNjRwckt2?=
 =?iso-2022-jp?B?ZTB0WHV1eDIrZCtvWTlGWmZxNnE4dVYzN3RvdElVYTRDTCs0K1daM1g0?=
 =?iso-2022-jp?B?N2lpeUZKTTA4cERUaldDSUJMbVU4aU5RZzlhTjIvNHpHWWVTa3BrbXlO?=
 =?iso-2022-jp?B?N210MUZralVjK2xXNWluMDJQS2c0eEpCMmVFUUpYQnhzQmZiaHFjRExW?=
 =?iso-2022-jp?B?ODQrVno0Nk01SGR2WmxGcG83cjVGbzdkREFVVnpqMVEyOERaZ0QrUlJa?=
 =?iso-2022-jp?B?ajVuaWlwWTQrN0UxL2ZZd2tSVTVwbTBkMkU0V1ZSWFpMaGlYR1N4NjVT?=
 =?iso-2022-jp?B?V1Y0QmdybVNRdU92b0ZiRnFmMlBsRVNKR0RkWDUxbldxbGFXL3JaaVFw?=
 =?iso-2022-jp?B?KzNwaFcvUlpJZ1VFVWo2YjEwTk1wYzRpSzQ2eDV2MUFOSWVUTnhBeVQx?=
 =?iso-2022-jp?B?aHc2QjlCdlo4NUhoUWlJWkx5ZWorNWljYWxiZUpVNGRQcXh3ZWNvK3Fz?=
 =?iso-2022-jp?B?Q0p4SHpvc0liUzJrUXlaWjMzY2VmeHRydnExdFNWTWxkRjRIdjVsSHo5?=
 =?iso-2022-jp?B?TWRsVkx3VTBVM0xFZmVZcTUwYUs2OTZNQzU5VVhQYXBPL2xENTVSMnVk?=
 =?iso-2022-jp?B?cFVyNjFJNGlDd3lUOEZ3TnJ1M2tuTndwVDFEaHVQR2VsLzd6K2o4YnFt?=
 =?iso-2022-jp?B?a2ZKOUR0eUYyYkVQamh6NkUyTkdjVnNRUGJaWEo1bndMTXF2K3EwNkpG?=
 =?iso-2022-jp?B?OXNpbzJHdWo4MUNmQnJvY09tOGlOWSs0Y2JRWWhyOENGQ1J5UFEyUlBv?=
 =?iso-2022-jp?B?OUh3SEFFd3lvUjFMQXMwMjJFNThlaUNqZjU5Sy9Ba2RSamJYMnFleVVm?=
 =?iso-2022-jp?B?OVM1Njk1dWlOdVpyQ3JqcmM0UnlJeUZ5T1IwQVp0bmk1RW1FQll6TFlS?=
 =?iso-2022-jp?B?bzduMTNpSTJRazBQL0pHU1VsMmJLV3FVZFM3VVlyOVN0a2RUOHczL25K?=
 =?iso-2022-jp?B?SFozYnUwcGJuQUp2di9CMnI1UTFHQUwzTW5kMFAvRGlHUk1PQ0ZibWQ1?=
 =?iso-2022-jp?B?T1dvUkNmY1pqeWFTWi94KzAxd0VYbFJhNjRaTEZrcnlGU24ySFZ4Tlor?=
 =?iso-2022-jp?B?YVJUNyt3NFczc2FvK1VLV1NaMTVwTTM5MTM2ZDM0Qis4dENpOW5HejJW?=
 =?iso-2022-jp?B?MFAwZjNaL3VudFUzelRBS1VseXlQdW5aL1JjRjlid2gzdk5jM01ROUR0?=
 =?iso-2022-jp?B?Tk1ZYTJWYXZHRUIreSttaVY4R3c4Wlpvd1ZvK2k4eXEvc3dSRHFpYkNZ?=
 =?iso-2022-jp?B?ZkVKQUk2dGZjVkRqdGdnYkJ1amIyN2lBeVhReUxNZkxqNEFRdmRkQXI1?=
 =?iso-2022-jp?B?UjV1ZEpYUVRNY08wdlJmcVdhd2ZrSHZzRlBuSElqSUxoR2VqYVNFUUpy?=
 =?iso-2022-jp?B?RWxzTFVFMmt2K0wwd2xGQzY3UjMzSUFpMUtXM0JCeXZMUTMyaXV1TUh3?=
 =?iso-2022-jp?B?Wm0vUEJ0SmUyVVhDQXVGeGQ1Wk8rQ1psZ0hoa0wvaXEzZk9ycTRzZU1y?=
 =?iso-2022-jp?B?Tk5US3dTaUFudW5LZXhXeHR1ZEh2MmVsdFB4T2JRMTk0K2FjYnZnY1kz?=
 =?iso-2022-jp?B?OTUvVFozd2VMVS9mMyt4bGxhQlNxRms4bHF4ZmtQRXp3M1N0NmFiQ0E0?=
 =?iso-2022-jp?B?TTFpVTVwa2lDR2VibUxBc28rRzJiMU9jUWsyZGRtMnNGSW5NaWZZNW5L?=
 =?iso-2022-jp?B?aWhzRkYvekwrLzlBRHdDbW03V1dVeWZ5SDV1QVlYbzY1U3NKais2RWZJ?=
 =?iso-2022-jp?B?Wnp6MGRVd3FvVFdOa3JIS0oxdjFpZDFINU93SWtjeGV1YUZWUzR0eWJM?=
 =?iso-2022-jp?B?czRsZVNmSkYxZWcwQUpTbkhLL2g0PQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab42369-c7de-4fdc-6f58-08d96c5d7e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 08:58:25.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wya/LpRTX84zTtPfzVhJsTOmICqF+WZjz5hO561euyZ4JqLeUEv6scHHaqHK/GWgINacDwp3E3Nf8C2kR5UrClf+F8pC90ag1iTYariypcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2737
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, Rob=0A=
=0A=
> > On Fri, Aug 20, 2021 at 06:39:06PM +0900, Shunsuke Nakamura wrote:=0A=
> > > perf_evsel__read() scales counters obtained by RDPMC during multiplex=
ing, but=0A=
> > > does not scale counters obtained by read() system call.=0A=
> > > =0A=
> > > Add processing to perf_evsel__read() to scale the counters obtained d=
uring the=0A=
> > > read() system call when multiplexing.=0A=
> > =0A=
> > Which one is right though? Changing what read() returns could break =0A=
> > users, right? Or are you implying that the RDPMC path is correct and =
=0A=
> > read() was not. More likely the former case since I wrote the latter.=
=0A=
> =0A=
> perf_evsel__read() returns both the count obtained by RDPMC and the count=
 obtained=0A=
> by the read() system call when multiplexed with RDPMC enabled.=0A=
> =0A=
> That is, there is a mix of scaled and unscaled values.=0A=
> =0A=
> As Rob says, when this patch is applied, rescaling the count obtained fro=
m=0A=
> perf_evsel__read() during multiplexing will break the count.=0A=
> =0A=
> I think the easiest solution is to change the value you get from RDPMC to=
 not scale =0A=
> and let the user scale it, but I thought it would be a little inconvenien=
t.=0A=
=0A=
Any comments?=0A=
=0A=
Best Regards=0A=
Shunsuke=
