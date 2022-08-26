Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86468C0502F
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 22:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbiHZWDn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 18:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344438AbiHZWDk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 18:03:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2109.outbound.protection.outlook.com [40.92.19.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27985DB05A
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 15:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2xBdmEtuq/spO7/iRD2Re62oax9fG1A0lEKQ8/qSjMdkHmXa/D9edbM32b0gC51wUxXs4YlSS4kfpKoYx9OcVKktq5QAHRv5cQi3FC7u+jH7YFaJBWlYX9Mclk5tAffchcJLZvD84peL6AGZ7LwDo4rl5w493Pd0LgkU9hmETL7NiBKw/tJ1Y0UhonaIrGLRrCXOroAH4ArJva+NSfQqS2uFdGoAsuGI2YkUuw58l4232GrodR0BrBq/XwLJobe8ho4jtnt8hSij5vmVbfBAGbx7WxXlkFuwVL6cOJcsp7pLkj37iJZ+6KgWbQ1vwT85oVK6G8xqEu6un10AkmE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVvs4yQFD4Pw7Z5VNF/MUiK8E7oMsB/g+8bgGi7eueo=;
 b=AdLsWMHE2foQTFMJmt74fY1dgTEUCKcr8VQAuEfWBTtb1yu387zjF6rtTuPMyFdT9KxB09Hezci8T5C7iAS+Ec4l3VMdo1cKCZlERpj98eWvQBC6X0hEOFFBTVZgx5htJAfaJ0HSeSk/AGcGWyrJYmlSKrzcP9f/Ns6NyBorcaa0gSLnck2SKRtl24OthkVMy9xDoo+otSqxsz6493HPOPZFWe3k8j+fl+l5z6iPQSJGEHyDK6aloRMvZngEH2t0QuMu3j9laV5YAhg/84jOQ2tDPmHjDl5dJSj4CmahPCPm7l3P0PR0H6kUvnDXmrN2cub36qp6cASzX5qGLH7vmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVvs4yQFD4Pw7Z5VNF/MUiK8E7oMsB/g+8bgGi7eueo=;
 b=ZpNSNBpOYpCpkdaDGbmN0jtZ1YLcqLJAb3leWmPDS1Rf4gu9A9yoVa4Px+eiTjWwSHerHDdz3BfaAulxYr8Vfk/6E5RCumE+8cYgH4/fIXjqDL3j97hCC/y9wz5I/7PQ8M6lbk8C6ZPWAyu3gWMEdBCii5wR0lUJpt61j3HUoZZuadtkqU34agy7ddcegI8ZWLeutNjXLpSmDdZDIVV6CzeIyHHLTiEstxXdMs8l7x7WiNIcdBcj372fEeNS7D3o6buvNaDbopS04yl3MKbXIY5I1EdqyIms+S1kLbqQhgYXv9aal5wrvw2SuZ0IHy7vfavLXZMP+FdI+X9f0tks8g==
Received: from MW4PR18MB5034.namprd18.prod.outlook.com (2603:10b6:303:1b9::6)
 by BYAPR18MB2872.namprd18.prod.outlook.com (2603:10b6:a03:10c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 22:03:35 +0000
Received: from MW4PR18MB5034.namprd18.prod.outlook.com
 ([fe80::88b2:5c9f:505:a22a]) by MW4PR18MB5034.namprd18.prod.outlook.com
 ([fe80::88b2:5c9f:505:a22a%2]) with mapi id 15.20.5566.014; Fri, 26 Aug 2022
 22:03:35 +0000
From:   Hongtao Yu <Hongtao.Yu@outlook.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC:     Wenlei He <wenlei@fb.com>
Subject: Re: Cannot use address filtering with user register sampling
Thread-Topic: Cannot use address filtering with user register sampling
Thread-Index: AQHYuBefxk+4eY25oUqX67pJ/KC0qK3BP/4AgAB/AoQ=
Date:   Fri, 26 Aug 2022 22:03:35 +0000
Message-ID: <MW4PR18MB50341AD0A32C29137D3EEF178A759@MW4PR18MB5034.namprd18.prod.outlook.com>
References: <MW4PR18MB503443512239B3F40267004C8A729@MW4PR18MB5034.namprd18.prod.outlook.com>
 <9b3f785e-1370-cf23-2ba4-2b0163185b2e@linux.intel.com>
In-Reply-To: <9b3f785e-1370-cf23-2ba4-2b0163185b2e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [MGwAdVlRi3slhcJI94Lxx+ihTSyicbroxQY/ZpqJ/YNEdB2xS3r6Tw==]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e7572ea-07d2-4aa2-e93e-08da87aed271
x-ms-traffictypediagnostic: BYAPR18MB2872:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dht0moIOhv4Q7WQyisw1r0wdvbvdYVvpOcvCV7nKjsnbr1lGfy0cpHbjYOpUgEtM8bsdAZjobqj+eu0DEuxSvxjcR2Wq+nCsamLnP/Nu4bm+TeUd4cypJHtdbJNrlPU+tCGM9O7r3ddjhgZhNOycGyErKmxTnXu2mxLGucSbeWato4bw3qvtewnVq9dS44LhCAjqwLSTFsSopg9NEC1DqXWCkXUmBHgVRyiDytNG+I9YZmCrRYq4scGOsefxQVcUqxIvdHzvB1HIze6SqOW3tzv5Sv5inITTvLwYT5B6Y6J5ry+F6/5LifJxamxxXQuODpJDgUOorl9daNaiyTiSMjDRTzvyGg8ao8tn2HDjuQSS9qltCo/barjqVVBZHheSAV7kJOY6Bf5r0rmXOOCtfPpGBER3Wux1NLMU8Q87Gvcl4Ul5ms868vWXKok/mosW1jJNKk6WmAOOGb9uAWAMEizqrzRflhS9EbOfiLoW4mj4WASTtuq5Yk3lnbia0wvCo+UVkeY47Njodt00vXJOM2lsDxOlh9QmbQoE/f4mRGBqwP7yl73Q+M6NKnTnOt6wm/tv2L1WfQIBoerhkUcmgX54EF610MNi10Eq74pe5Jrpwbq1IHNq1srUjt9zqaRFFVDc24x+MyW5ni3qk+2Nbjkwd1/5PYbtrxs9rmz67gIr9GtnM2/wTbZGFZVhtyIC
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?fLFrtjGi8+l1IR8APPoav/Y9VF5dwx6vfJpXlliUwG1NTUWyZpDNOuDf?=
 =?Windows-1252?Q?AYYKZvXZYCsZR0M6KYfQlMwP/VRKiVwTTnt5hVXcHDRaUyfwtcDo8HGJ?=
 =?Windows-1252?Q?s3OJ8u/nJ4GpPM6MY81VuSa6+g/zPMrm8YlYSZpqyyLD/VDpubEKYx9A?=
 =?Windows-1252?Q?Azdq/E3hlVOYkYC5ehtmwCQ4rqpw2EYorWJMHFDpA4MOpC7fY2L/xG71?=
 =?Windows-1252?Q?L7i+Ewm/R9ACh1OKHMUj/yjZifctGCw19M4tWHJWkolWjCrJS2TEusnq?=
 =?Windows-1252?Q?VeWauh+nq4FBA8V50FcSmcTxn2Pashn2rOGLAseadfiB+M2nQuVc1JGm?=
 =?Windows-1252?Q?ElZ2GtxSdTJUxxLLE0w6x7U1ci+Vi+RD3fc+3bIBXETF2jk0+68GmIEC?=
 =?Windows-1252?Q?UqT6Q8sXAnzRcvDVGwCE4AdZPcU5G7bOniDAip9hGThkCF2YBCaskKPC?=
 =?Windows-1252?Q?b6oOs1JaWShjNxEtq+VxJzHa7YE1KFkAYejXwsz4OtnZpLnBlMMJfPdj?=
 =?Windows-1252?Q?wF0l4/tGpbfGA4K2ZHPWumqdwknLD5m0ac2hj5y0b4+4c0a9Pye05ttq?=
 =?Windows-1252?Q?XbSj+RhTyMxwU6LmLyZKU0L80lcXfIP9+if8hY0aw/Umd4owa5NqN614?=
 =?Windows-1252?Q?SAAVUoc1VdOJgOGV8orPn8x7n5PhKcASA6IkqpxBWcSNNlzrSVU2/vuP?=
 =?Windows-1252?Q?Dwu6IZp+P4B8w7x/hEpfxrHLs8FfU+hg7Cjobyo43PDdsGExkHVSLoFh?=
 =?Windows-1252?Q?U5mBsFGjwmnZuW0g0n+ZkhpqYf5F0GY2GwYUxU94RSmEsGzZ/N9p/QMP?=
 =?Windows-1252?Q?qHnFDsAivGcdk156hY+8WyINUY+oGauT8OZQxts4QWyslKqeD6XFP2bg?=
 =?Windows-1252?Q?GxRt6JBvTgiqRfX//u4JpEcXOrVxXiVGpvu/7+uBHHyqit3RplPm+37B?=
 =?Windows-1252?Q?l7nXuMHiJcfUg6u7dni/gmnDyC1DOchQ+E+Ub6mCz6ybcK2dOZyyaxbb?=
 =?Windows-1252?Q?GCCAZKnMpeY7KFfC/PdPmljL9JpurmyyaxFAta2yHUJbVKc2o+sNXNo1?=
 =?Windows-1252?Q?+GvGHxfEFQ2eHJMMWRwMH6KagH+Rt7WygKhLB8E95EQUpaNTaphA2uPY?=
 =?Windows-1252?Q?iMmDe6RXAOJSMer4TGUVFieRMUVBN4W7yDah9BVoxoNK99MgBu/koirQ?=
 =?Windows-1252?Q?bYnFpg201nLDB53PxKuol6hon3OakLgClAeo1fug7OYC3N8Zv31/lzFO?=
 =?Windows-1252?Q?q1uhG49+mK1YHTww+reml88GofoZDtcbaiOZdK0Q8P1hR1Cku5SnIQhy?=
 =?Windows-1252?Q?/v5PuJ4RKp/S5xsHJKcMR2uUIUZULx6O23kUIvi/RXqVsP6YslxPtZEY?=
 =?Windows-1252?Q?Rba1zhPKfQ2QTp/i4R5ZsqErKVIZPxYB75o=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5034.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7572ea-07d2-4aa2-e93e-08da87aed271
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 22:03:35.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2872
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks for the information and suggestions!=0A=
 =0A=
We=92ve already been using the -c options to adjust our sampling scale. The=
 new need we are having is that we=92d like to sample a particular part of =
the program instead of the whole program. Since the hardware address filter=
 doesn=92t apply here, I=92m wondering if it is practical to achieve the se=
lective sampling on software level when processing hardware interrupts, to =
avoid generating tons of useless trace data. For example, perf could do suc=
h filtering based on a section in the binary image that specifies the inter=
esting part of program to sample.=0A=
 =0A=
Thanks,=0A=
Hongtao=0A=
=0A=
=0A=
From: Liang, Kan <kan.liang@linux.intel.com>=0A=
Sent: Friday, August 26, 2022 7:28 AM=0A=
To: Hongtao Yu <Hongtao.Yu@outlook.com>; linux-perf-users@vger.kernel.org <=
linux-perf-users@vger.kernel.org>=0A=
Subject: Re: Cannot use address filtering with user register sampling =0A=
=A0=0A=
=0A=
=0A=
On 2022-08-24 8:14 p.m., Hongtao Yu wrote:=0A=
> Hi,=0A=
> =A0=0A=
> I was exploring address filtering together with user reg sampling on Inte=
l Skylake hardware. The idea behind it is to make reg sampling more selecti=
vely. Unfortunately, I hit ` This CPU does not support address filtering` e=
rror. The command I ran is:=0A=
> =A0=0A=
> =A0=A0 perf record -e br_inst_retired.all_branches:uppp --user-regs=3DDI =
--filter 'filter * @/bin/ls' =A0ls=0A=
> =A0=0A=
> =A0=A0 This CPU does not support address filtering=0A=
> =A0=0A=
> IIUC, the br_inst_retired event is also hardware-based, similarly with th=
e intel_pt event. But the latter works with address filtering while the for=
mer doesn=92t. What is rational behind this?=0A=
=0A=
The --filter only supports the tracepoint event(s) or or a hardware=0A=
trace, e.g., Intel PT. They trace and dump each single instruction. You=0A=
can use the --filter option to choose and only retrieve the=0A=
data/instructions you are interested.=0A=
=0A=
Perf record -e br_inst_retired.all_branches event does sampling. I would=0A=
recommend you to use "-c" option to control the event period.(The number=0A=
of events that triggers a single sample.) For example, -c1000 means 1000=0A=
events occur then the HW dumps a sample (only for the 1000th event).=0A=
e.g.,=0A=
=A0=A0=A0 perf record -e br_inst_retired.all_branches:uppp --user-regs=3DDI=
=0A=
-c1000 ls=0A=
=0A=
Then you can use the post-processing tools, e.g., perf report or perf=0A=
script, to filter and output the results.=0A=
e.g.,=0A=
=A0=A0 perf script --dsos ls -F+uregs=0A=
=0A=
=0A=
Thanks,=0A=
Kan=
