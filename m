Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCC8C07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 17:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B89C61183
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 17:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGMRd4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 13:33:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:29363 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhGMRd4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 13:33:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="232016199"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="232016199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 10:31:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="459662991"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2021 10:31:05 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 13 Jul 2021 10:31:05 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 13 Jul 2021 10:31:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 13 Jul 2021 10:31:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 13 Jul 2021 10:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+cJzwVRxTam1TBwLbB3hXQCYfWqW5ycYls2a2/yIv6dH6gySO9dDmlOemUvnooTKF4KurY9qaPdubQKi8OC4j5jISDd2a5lbFquvhUUmVB2N/+1MlJraExSnSzPal+Q1HJiEZIr85pl4MiygHqJ3x9BorpgsauneybNBsCMxcdRt+1s1GMwlxrg0mdV06sKOu5Rs5bEtyDbL3cGlS0NJaEjtLVXi7vnhE8rdW/vtOM+RJeZLF7cmajBUNl+fspybh5UqTsmzo7/oRhIzW4j420bJ102Y+m0EcKrDjHgFhbi771HhnNipfOqK3F8bFqhg++oaHZncEHwgW5FzouNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d6gF6USC0AZCZ26STD467cpZK4ZOXa0BjQdd7RPcyY=;
 b=guAZyA4xhc7J/weYUIsWaDsDGEQ2KnLeZN6r8vyBF17mkqthN4gKVpvMk4x3fcBQyBjuXVn0yEizjgZh6rhh6H2NDuC4lQR2h6WW2PcspFXn/Q78+id/U8WxNSQEEot2n//N6y7o0qdyxu16haGUPkhcV61Ur9CoqEcM0xoPFRO9MwerR+j77h7CkbiS+d6l6uLW7YKQqbQbNOz0ZlhI0ECz8nf0bLppsH/U3VvEcg/AJNPGpbZBoDdQc6bKeXvQ4O1HIXH82j42Q8wNFmJdmn4BXwWgDUbDVeJ14108PGzE5njJC7JIguKGU6CoXpBtmz9qqA+pdnf+YqjCviPXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d6gF6USC0AZCZ26STD467cpZK4ZOXa0BjQdd7RPcyY=;
 b=Mg8Pyf6TPEPWb0+nF/FbeyOyO8NEgoCe2yUhkKS3qYJZGfmD/Dv3IhxIE/mVLGQMW8DuQdLF/LQl3hMTSK6wUz7zojHOFfaJwZLgcpaCKjjqO7FCpTq2MZYqV00ZQ1kI5N99v+2gAmROJHUaIjnhJCzsgUByCWqPwKzBNGExdLM=
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by PH0PR11MB5641.namprd11.prod.outlook.com (2603:10b6:510:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 17:31:03 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::217e:16e5:19d5:783e]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::217e:16e5:19d5:783e%9]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 17:31:03 +0000
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 10/11] perf env: Set flag for kernel is 64-bit mode
Thread-Topic: [PATCH v4 10/11] perf env: Set flag for kernel is 64-bit mode
Thread-Index: AQHXdkFaHivs49Ex8kyMT64YmP+G0qs/pweAgAFeuoCAACa48A==
Date:   Tue, 13 Jul 2021 17:31:03 +0000
Message-ID: <PH0PR11MB56264B3A7E4709CB0635F320E0149@PH0PR11MB5626.namprd11.prod.outlook.com>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-11-leo.yan@linaro.org> <YOyGi9Zdrio7OmBX@kernel.org>
 <20210713150953.GC748506@leoy-ThinkPad-X240s>
In-Reply-To: <20210713150953.GC748506@leoy-ThinkPad-X240s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13636953-53a7-4603-3bd0-08d94623fd5c
x-ms-traffictypediagnostic: PH0PR11MB5641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5641B6A93BAC8698F1413CCBE0149@PH0PR11MB5641.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UxfCTDydHWO6w4YRRI+mmGoTGbiTlAw7GkuLDzRhsJhVqkknk9l2gCNebOBAvKhGgsl7iZUTuRRRkHcoeZIqDMyPApM00xZRPYL3KUvUChL2ZqoSHEwgQkFf2k00esjvajFNA4HwmmHUUkx0iiuN8YOJuf6pwKUft0Jl/T/9hbJqEraKSFep278seXfc5pWjIPhouJY3BQcrGG9MSRALqftSguekW76iCpqTsjEgGQxWhk76FDSWHwU/oiHlRP+WvJCwzpIQmIfieRBRvAtAYgIBmHMTnFf3+aInZjP1V6zCfF6Vn+6tkDb7UAzudCcySGcBwXcleH9NAHH2srt8UmQSaGsg8/X67TB/1X7QFuUATnVEzR3AKH87BZnderqRtP6FTqREY2g6ahWGIopAIe1HrNdNDYPGhb9W7rcQsIucirFTHWIvhSOpkRfWvKhAVTiQcjXgd36BgdLLUZoMedOmUgJCG6yZcTC6+dkzcr9Nf8X0junuc/ExVfxcFAs/1suomraPFbyWlqJIwltmGt9PSduIy0Pp+/NCM95OOj/T/sH9Tx59LD4rHgRsKV3ifKbIVnvJkvZpBHCdiIA7VRM7070xbDIe3m+PmfcU59YfBnGIbKs5r2DusS54g9B0QkngOeP6137h6MmgzMJyNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(478600001)(8676002)(110136005)(76116006)(9686003)(53546011)(6506007)(66946007)(33656002)(7416002)(26005)(2906002)(38100700002)(83380400001)(64756008)(316002)(66446008)(7696005)(54906003)(66476007)(86362001)(8936002)(4326008)(66556008)(52536014)(5660300002)(186003)(71200400001)(122000001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e+pAA9TYVDhXHHo+jYZp6DYW/jBwSQq7pbL7yba3c4+jP4KnYWjeDSs3w7/M?=
 =?us-ascii?Q?fW02CIYFW21mI7lRu0Z2ogwzm3AJxYyXkEOMM5FRgDq2uBy4jxKzPmJDIO5e?=
 =?us-ascii?Q?5+novx01zPTt22S0Yq6WIsy/bjGxXL3UzGskj/7xL32q/C8o72UkimtMbUI0?=
 =?us-ascii?Q?9vHTxjlu2ZP3iaLKuFsCf0KFdmxxR7X226FGrrKApUWDJKXsTnHTyQdWhVzc?=
 =?us-ascii?Q?e96obOEuhgk4Ia6Sa7ZepP/9CPv50y9fSlYKUu8X/dncfNHUhk42Rs9hTH47?=
 =?us-ascii?Q?jKpkxCd4E7OeV4hlCvTFAZCloZMk4MQzxWDX0xcT4fH9mKHN6mG0HhZMsiPV?=
 =?us-ascii?Q?ofTPtvYgVrbwvD7luJcE47dwaTKeUkNmB79Bigj1VvRSuKI+TFtcouJm2ell?=
 =?us-ascii?Q?uHxl8e82elbLXkH8gs69uuTSMcUFeUMpk+nGlpsnDpTHrSuBS5oI494gIgW1?=
 =?us-ascii?Q?oronO+gmfisCiz2E9SCrrUvRcLE0CBCKckGHS2193nxS4QXVMdXSYKsZyTaF?=
 =?us-ascii?Q?f6LdbTB+l0e2eyq2l4arVH5W7++al/MhkBH0QnzxJV8LgCRoYcDyOFDlxNIe?=
 =?us-ascii?Q?mvgTvoL9eBWPTQwCkoY2jx+U2R5SR4BQ7DlVb+aMg5DT/FConeE/wWcItOW5?=
 =?us-ascii?Q?KQVDeE729rL677Desi1TsQxNZfdzwr6L/cnAUaTw1BwUikXgtqbL8NPm2aq+?=
 =?us-ascii?Q?70+jT70HYe9lpHsPxmyyYWmjmSf7qjqua9TQi4D9GFBaxNnZ80fN/WJX+jND?=
 =?us-ascii?Q?mtVWGfa6qQUy3/LO8Q/4cGg6aAw1F8bSBYoP8s/9xObf5ts5CeqVXC0rH1gp?=
 =?us-ascii?Q?iPyXUt3j52fF8j4tC6Mrtctjuke5pSbeDBEKDobLJyKFGLbiYAFrNbbRZ7x6?=
 =?us-ascii?Q?UdRBPBPTcQbsew6KGc3O616vl2/S8iVMw8Zw3PktpUmZnwFkJQEueMrIPBO8?=
 =?us-ascii?Q?JKD6tzCK+d3yey7ikvBLGcOeKM+wFwHH/0ohLBCJU9mLzL6P4J1r0+TOPahT?=
 =?us-ascii?Q?uix+w+2Z9o0k4d6pLGgyaXoroJqIVxZGbHI57ayNQ2dMNXqvznPyTlopwspt?=
 =?us-ascii?Q?JNv9SARkzDrh1dXHQK/9/yYwusoyRTS9aZGpvNx7+n8eI3FuQv6/AX/F3L9A?=
 =?us-ascii?Q?pKQ+Z/pdwIIEXqmhydUDsQO3/aqh4EUbAff0qM3Q+TkTXMl4Ybr7lQYo10XS?=
 =?us-ascii?Q?TsBUgTDyyaVt846YESzuxtOfqWc6ztNgHhZ2H8odpfQl0BssJUY/Kv08SjU?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13636953-53a7-4603-3bd0-08d94623fd5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 17:31:03.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFZHfRtaveZ8vB4R681CKEuW6/G6gSQ8HNWrrwhWPykZUzR/TtmwY252GyKK7chIOIM/8BaNnj/gbIdmjyU2XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5641
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> -----Original Message-----
> From: Leo Yan <leo.yan@linaro.org>
> Sent: Tuesday, July 13, 2021 6:10 PM
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Hunter, Adrian <adrian.hunter@intel.com>; Peter Zijlstra
> <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>; Mark Rutland
> <mark.rutland@arm.com>; Alexander Shishkin
> <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@redhat.com>;
> Namhyung Kim <namhyung@kernel.org>; Thomas Gleixner
> <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; x86@kernel.org; H.
> Peter Anvin <hpa@zytor.com>; Mathieu Poirier
> <mathieu.poirier@linaro.org>; Suzuki K Poulose
> <suzuki.poulose@arm.com>; Mike Leach <mike.leach@linaro.org>; linux-
> perf-users@vger.kernel.org; linux-kernel@vger.kernel.org;
> coresight@lists.linaro.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v4 10/11] perf env: Set flag for kernel is 64-bit mod=
e
>=20
> Hi Arnaldo, Adrian,
>=20
> On Mon, Jul 12, 2021 at 03:14:35PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Jul 11, 2021 at 06:41:04PM +0800, Leo Yan escreveu:
> > > It's useful to know that the kernel is running in 32-bit or 64-bit
> > > mode.  E.g. We can decide if perf tool is running in compat mode
> > > from this info.
> > >
> > > This patch adds a global variable "kernel_is_64_bit", it's
> > > initialized when a session setups environment, its value is decided
> > > by checking the architecture string.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/env.c | 17 ++++++++++++++++-  tools/perf/util/env.h
> > > |  1 +
> > >  2 files changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c index
> > > ebc5e9ad35db..345635a2e842 100644
> > > --- a/tools/perf/util/env.c
> > > +++ b/tools/perf/util/env.c
> > > @@ -11,6 +11,7 @@
> > >  #include <stdlib.h>
> > >  #include <string.h>
> > >
> > > +int kernel_is_64_bit;
> > >  struct perf_env perf_env;
> >
> > Why can't this be in 'struct perf_env'?
>=20
> Good question.  I considered to add it in struct perf_env but finally I u=
sed this
> way; the reason is this variable "kernel_is_64_bit" is only used during
> recording phase for AUX ring buffer, and don't use it for report.  So see=
ms to
> me it's over complexity to add a new field and just wander if it's necess=
ary to
> save this field as new feature in the perf header.

I think we store the arch, so if the "kernel_is_64_bit" calculation depends=
 only on arch
then I guess we don't need a new feature at the moment.

>=20
> Combining the comment from Adrian in another email, I think it's good to =
add
> a new field "compat_mode" in the struct perf_env, and this field will be
> initialized in build-record.c.  Currently we don't need to save this valu=
e into
> the perf file, if later we need to use this value for decoding phase, the=
n we
> can add a new feature item to save "compat_mode"
> into the perf file's header.
>=20
> If you have any different idea, please let me know.  Thanks!
>=20
> Leo
