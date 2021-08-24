Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28375C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 10:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130B761265
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 10:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhHXKTe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:19:34 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:63752 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236023AbhHXKTd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 06:19:33 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 06:19:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629800329; x=1661336329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E6i0UZ6+gvahniZGUQ2d1Vbpc3VDd9JplBy58EPr65w=;
  b=ea687LnibRnERHcaFi+8ClpLdQr7PlP0uFY3XL7NsdQsU7jJ0JDL8nLK
   NKF0oqeNMcN++Fm/NibbtBEIMS4wCkQCcCbixh/1p07p5a9aXQM0MaaT3
   +CrZ+2y+75gNlTdnV9D44qcSoMRfDZj1W3g1+jH9WwzOhoeZdVkx9M3CP
   D7HyTQjB9hLOTf2AurH4AjOA3UvSDDpM0u4UBc0JtR+7w6iGjkYJYmbPh
   anoF4CUcWE4tE1eIyOx25Qu4b9v8XlUm70tCOi+mB3tsd2SnrlsvpYWVT
   ZTc9Fq3qEzXsa1gvArZCMUhFbCcF+sNjf8+1sgt0IuLwMzroJ9HbyONcO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="37629787"
X-IronPort-AV: E=Sophos;i="5.84,346,1620658800"; 
   d="scan'208";a="37629787"
Received: from mail-ty1jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 19:11:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzVQkVm4/ylbK9FNq0nn+fsT4JHuhUCGl9evC9IAq6oE8kFZhKUeLV17N+L2xYxRD7g8uClCak7ryYo/dZ1eZcWpNsNnnuEnMYN4kNiHTy3MW1PPqkv0FOWa1k43OmUKOGv1Hxmcccf+/X1c4j6K0ZKkSWRJOfk2LLwDTFB5r9l09rP+41uLHkwfhfiVW2BA389yATaDR+x4iMaE7togBP18RMiCJwmRobCwFrPCM0bvkOWUZDXBkfO1oCdtGZkS/Qpnvo5RuwPClT5hhdkNMCGpslpsuZJR6YY81RVBH/ohdzrDfL0NCLIpdCdgkk5ZkDzB8HLda4ZlL1Vqeld6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6i0UZ6+gvahniZGUQ2d1Vbpc3VDd9JplBy58EPr65w=;
 b=A1WGNw2I5ZsLI3lTVlo5uXKUgrsZhTl/UI6jFfDC419J2BZlQTqIr04DyR5nh5OFD39ZDfs9w4x/5/GEsvrWd+saDyfjVme9iWeYhLOmMUDHvwdCVh7MMk4VAzlBr3k1OWuTa45QRCfjyZQqwakNUvQg7HTREdaHHk6vKG8R59VnOshRM5HzpO71o8ZbDEjt3AtXeD5rSk92kFU3Wr8X3wF/jbDEwlwpLvnuHHwZ4dcMwHbGefsT+oNGfJnEngho2Mudu2SadMLLHYUdj0kdtdZQBv3ZdXeB4Bc4rzHzgPtYN5Sr3+RDd0xTBTp3hb1HfHYylQQBgyvNi8fuuLCDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6i0UZ6+gvahniZGUQ2d1Vbpc3VDd9JplBy58EPr65w=;
 b=MRZctDOF14h9PFV3WL+rDaE3PYzR4nQIP26uKUAQWPgW5lcOIBqoj2bLaRlQa8IsUHDatKr60Jx0Z1CDnqZ2emczIDMZuywpWxSaccu6opwLSM5WtVQrEsnrxfQcv/uxQTgGWOuVw7barCG7pF9WrVl5VUApqL3/EIP1/1qr+Vk=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 10:11:28 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::44e1:366f:8654:b23e]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::44e1:366f:8654:b23e%7]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 10:11:28 +0000
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
Thread-Index: AQHXmFsxBFGvQYUD8Uu1pPLYL2hYdauCbgJw
Date:   Tue, 24 Aug 2021 10:11:28 +0000
Message-ID: <OSBPR01MB4600288E176A169C07BF543EF7C59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
 <20210820093908.734503-2-nakamura.shun@fujitsu.com>
 <YSQBI+FZLBvKr088@robh.at.kernel.org>
In-Reply-To: <YSQBI+FZLBvKr088@robh.at.kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-08-24T10:11:27.838Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db581252-1958-4e87-edda-08d966e789ae
x-ms-traffictypediagnostic: OSAPR01MB2737:
x-microsoft-antispam-prvs: <OSAPR01MB2737654D83F127ED82A09BD3F7C59@OSAPR01MB2737.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymTtgcsk3ndtZ9Vs5gRBg8m7+qADECxf/kq6wmxRv8QKDsBYGkIacYat0m2Q+6FCPnyc+JpSUqmTiUneU6rOZp5hPG7i2dvlwru3Pd4Vkd17b6pQv6dc+sCvFPO2/4S+fRnMKxLq6xf4I4uMU2nzyaRh1H4rLZB1iDg97TIaK6J3lP2zfZ5LiHPnaNrqnlDmS7x4lGPdZlSnLi6g7XtSpavSzdcF22R2BOqwjdKi0AI9qHBTgMJqA5gwtxZEi6nzOssy8AuIwvGXMAQBEiP3VMw82c3FrKyxPcKT+WdzF4q/0Mh0KdGBAoOKvMojh9cTPm9fYyCuTEyHAQvOamqZdduxg8WfmxNeEhxMqL3tVHo2MZfQS8Rp5lUDCO1JcPZDXFomd5RI6W+rYEMVm0DjknHYrNr/8ANyrRwgbx8Vto+UPL7YK1rWt4rXzi+3e0oCtUHi1wTex9P36qhUn6XzVNb3zLS68GqsN1cUHtl4+gVGTP800VJK3L5uwT59nG0XXxHVYFqbLs76whTsqHmlmtnNiu/afevcTgCLqCtc/tXWkcim61oiyAtT/fhSmkXOOeSaoG2kwG7D6f/RuMjKRs05j7f1nLmrmwX1+BitmlZjqTzLN2IOHZIeFeUKwLhRcOmU1nR53uihm/uAuIrRzHkoYc6Hj0YyfX7tMKA2JrG2baYpcdarT/+gtnHINLdy6dK5rdV0wvEg9pthqzSZkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(54906003)(7696005)(4326008)(55016002)(8936002)(5660300002)(316002)(9686003)(85182001)(478600001)(52536014)(71200400001)(86362001)(64756008)(66476007)(66446008)(38100700002)(66556008)(6506007)(8676002)(76116006)(66946007)(26005)(186003)(122000001)(2906002)(7416002)(33656002)(38070700005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?dHJXTkVpTk5YbER6eS8vK0RMZ0JxQmZtWWpkZjFUVWZpbUZjY2FlWG82?=
 =?iso-2022-jp?B?cjgyQWdubWVhMWNnZDFTYWY3K05xUzlCZjFyakNXajlVRElPRkR2YVZ6?=
 =?iso-2022-jp?B?YmxuMWxpYi81T2lUZHlwQzU4NUg4SnVobXZWdUpsd1R2TlFEZ092R0RI?=
 =?iso-2022-jp?B?emRrWGNNVlNMVWpRTTJ5TUxWNjJjWjZib1YwaXB4WTVjeTdRQkRDZDkx?=
 =?iso-2022-jp?B?MGNGc2NTS2Y0N1N1eS9RMDViTjRPdzZ5dEpxeHN0bjFWUC9YRmQxaDRP?=
 =?iso-2022-jp?B?MWZCTjJNL0dvd1ZaRW9wL2NSSDdlZXgxSDlCbFY3a2U1azNIb29VUlQr?=
 =?iso-2022-jp?B?NEpOQWxrVndMVloxN1JNNFVZci9KaUJmR0NQbkk2VXNHcDR0eUIvdDdR?=
 =?iso-2022-jp?B?RDQyRVdiZUNOSjZKV1hjcUxEcE5xRFBTYTc0MjUzM0QzdTZwWWRGVVhX?=
 =?iso-2022-jp?B?NFFrZm5uQm5GUlh5RVJHWmMwa3hBUUN4VUdQRXJOM1FJNjRmYTA2bUtp?=
 =?iso-2022-jp?B?eEdYbk4rQmxPZEJaMHVsNDhkRkdRQkNUSmxDSDZYeVRFSmFnWGh2Q2Vu?=
 =?iso-2022-jp?B?VkNvSWgyaWxKbEdFWnJ4bVg2WjROZ3kwMkI0L2o0K211eDkvOWd4bEZI?=
 =?iso-2022-jp?B?Ui8yZjlmMmlFbDRaNENaN3JsejJPaWVSSWFKaG1wNHBLOUtudzROTHFZ?=
 =?iso-2022-jp?B?ak01a0JIYVczdGVTYUFuVFcwOVh5QVR2amxheHo4b0pPN3UvbGMzK2s5?=
 =?iso-2022-jp?B?ejkzVWZiU0pSSzM4TW4rZ1lpWjRJY0xwZkhNa1dYbTdvUmhENWJrSFRz?=
 =?iso-2022-jp?B?RE9mOFJWTjBmTnJqT29iWTJWM0MwRjFBUzZjOEhtaVFhRVNZZFlaSFR1?=
 =?iso-2022-jp?B?WVgwaklZbWZEbWdZdEhteTdZTHZPT3EzeEoxWSttcmNBSDE3Vzd1V1d2?=
 =?iso-2022-jp?B?N0JxbWtqaS81UnpRb0hQR3NXZTVzcStib3Y5c3ltTjcxcHpvVlVaZmFC?=
 =?iso-2022-jp?B?Z1d1TS9yenMrSVp1U04vZjZDdmdob1ZlVXVjQ1lQWlY4cHZHUTFOQjNS?=
 =?iso-2022-jp?B?OXAyaEFsdFZyVCs5Q09NV202bHhONHZ5dzd0anNUeW5ETUVWRzlrVUtV?=
 =?iso-2022-jp?B?TWJSdmhidHFoZHFsdFhDRWlpb2RRVi9sTGJRS3RIYXdCT2lMY2hNZ2NP?=
 =?iso-2022-jp?B?QVA1dmRHOW5KV2RscGo2Q1BobUtHdHU5cWlwdzZWSmoxM0Zyc1FRWE40?=
 =?iso-2022-jp?B?Rm9KZU1PWnoxalFaY2FOd2txQnlUSGhOcWJoZmEwMHFIelBxK0RXSFk2?=
 =?iso-2022-jp?B?LzdzbHRVWUVFUzlnWGJvc1NjZi8xbUFtaFBWdU5nV0lEdG5rTzhWc2hY?=
 =?iso-2022-jp?B?Z2pTdlZ0TU8xcWU1Q1g0aUwyWEZVUDdvbFVFOG9nUkhXd2MyelZ3S0ph?=
 =?iso-2022-jp?B?MXFmSTJVWTlQbDhkRjZjRVR1MjE3SHpDL3p2SDl6MDBick5NTk1LWWl2?=
 =?iso-2022-jp?B?WWg4dHhGa29MOCsyQk5OajF4bHZhUGFKQkNNM2EwMjczM0VFalZDa2cz?=
 =?iso-2022-jp?B?N1NYdXFwaUhhSFZRUlY3MjhMNkJuZGlRMWdyRXEzSndVMldVakRVOUc3?=
 =?iso-2022-jp?B?aWtrRFhqc0dqcFU3cU43T1RLYkVpYmt1cFNpTkhZWHZhVEphN2gycUk3?=
 =?iso-2022-jp?B?dDhZU2NzRmNGVFJBTlRVMjNkbHMrU2F2U24wVmowS0dYSHAwd0prV2Zo?=
 =?iso-2022-jp?B?ZE16YStwejlodXFlVWZ6ZU1BTnhQaUpJZzhyaDlWa0l1UGRYdHhZbTVQ?=
 =?iso-2022-jp?B?QkErSXNiZDMyNnpHZWZ2M0kydFJsNWczTTVoRUU0eDNOM0dQdlVBcjJh?=
 =?iso-2022-jp?B?UjEzQmZRSmVDOTBKUldQRFJnTnBBPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db581252-1958-4e87-edda-08d966e789ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 10:11:28.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCeGUNBr5ckdI3V2zyWwxN5hqvVjXQjidEomeu8gWzmX7MG4xBn6Fnh++7+cpkHQwMIOUwqJG/X4gku1CKoOz+vuMNDn6Om70iVgY+qVrAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2737
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, Rob=0A=
=0A=
> On Fri, Aug 20, 2021 at 06:39:06PM +0900, Shunsuke Nakamura wrote:=0A=
> > perf_evsel__read() scales counters obtained by RDPMC during multiplexin=
g, but=0A=
> > does not scale counters obtained by read() system call.=0A=
> > =0A=
> > Add processing to perf_evsel__read() to scale the counters obtained dur=
ing the=0A=
> > read() system call when multiplexing.=0A=
> =0A=
> Which one is right though? Changing what read() returns could break =0A=
> users, right? Or are you implying that the RDPMC path is correct and =0A=
> read() was not. More likely the former case since I wrote the latter.=0A=
=0A=
perf_evsel__read() returns both the count obtained by RDPMC and the count o=
btained=0A=
by the read() system call when multiplexed with RDPMC enabled.=0A=
=0A=
That is, there is a mix of scaled and unscaled values.=0A=
=0A=
As Rob says, when this patch is applied, rescaling the count obtained from=
=0A=
perf_evsel__read() during multiplexing will break the count.=0A=
=0A=
I think the easiest solution is to change the value you get from RDPMC to n=
ot scale =0A=
and let the user scale it, but I thought it would be a little inconvenient.=
=0A=
=0A=
Best Regards=0A=
Shunsuke=
