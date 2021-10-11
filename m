Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5990EC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 08:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EEC60ED4
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 08:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhJKIVK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:21:10 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:38094 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234924AbhJKIVI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 04:21:08 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 04:21:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1633940349; x=1665476349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2AvPQas6Wp8vQBaxKaqOvSqERv9wuDGQKDfCpZXLZfQ=;
  b=Ut9GE8V3gmoyCdyF7eRtCq6sfkpgUo0Sp+IOPuvc6RguVjYWg6unfZIx
   dNLC26SBH3J3FRvsO85lXUoUfR9XKBMjxF1K4DKvgRWddDUXQbRA0tlxa
   a+CkfHaWk8VwWHsVYW7O66rtcW2+99wloMnVVEBmTdCdKBiWHmkkV3hze
   nng1OH/OgnIb3A0Is5b+EyotGE7lLxmTk5uXj2X0nCubY7vm7jb3nffct
   FcDFHN8IqbHHm5ID9xV0iVLTCTK0PxHE79m1KLA6FSTwrIH6qhQAaeKrJ
   CRe2/oFMp9dG3qD1EA/H+EVAd4Ti368KNEBRVOjxqKiUIIH2hagNNedSJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="49064223"
X-IronPort-AV: E=Sophos;i="5.85,364,1624287600"; 
   d="scan'208";a="49064223"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 17:11:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caNFRaMV8FhG3IgAcVeuFMg30RopbQg/TkWO1uEv3t/VQLWK8TbB/e7+hoSPJAUxzbQR8PvUfkbyI37nC7aoZvccqeTYnr+7FUsF9wTGzsiz5fM91c1si1W7iuPXeBBktFiwmN3ZoCla4qnSbIgiMAbsGOEBlrVVfhABtyOiyfrjU3GI2PSF2tdFBjXrU7Z3QWlPD1th8JXAtThvYSCzoDRSkkyliQmexIpAVngXxkoRGjhc2AUb9wIWdZToIEMqOYMZOBX6nYCFJvowWsYyCYCxTzFxHyi9OxjzDNKYeoaie71LdxCAtVBKAtMpayF7t4NPOgPtZOqZdDflDO6NtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJB6ZxPDnPRqN1nxNaQpqGodoyI6hQwFs+fbS+ilSYE=;
 b=SDN7gJtahm1ufFcQBNHThJqqe1DKq18kXathzfBCV1HNYinUZkSFEMXYzc1LKffFJc15QnD2pm1uXpIhx9E6jqeVsJRokK4FPmfmESl63VBC91rKIH/Sa8kpbHUF8JhmLb9X9KjJcwK0PhSlLxTEnQ/36lV+vmTiMORWCjrNjuJ4lBTpiaX6chHYvT1h6AzshKhe2wVblHCa72JF+nQ/4GgjOidAXmokj4pDQJA2gLhIJP8HccggdtoxH5rAIL/ic2JXcNemU5zLjH1vW38HYylD/9n5ocD0czFQdr8hnBqtyyi8hEuoWfDER7xLzLD5ZVAc5P5+O5XC9IouWG1CaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJB6ZxPDnPRqN1nxNaQpqGodoyI6hQwFs+fbS+ilSYE=;
 b=WgPpK8+n0QevEbXu9jdw70UKbwcogb5tGXZf1wlfXsB1+f8QuDhZ6sMt8fKWctro17ZThxNC6LqyjlSTuB6B9/kd4XhufosZQD9Og9DjgMM+Gwi2eNN0PWaXEfp9ThFzxo12/3h8B4rQDry88lnAKUNAf2piTPiLIVOvPYJrzMQ=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB4949.jpnprd01.prod.outlook.com (2603:1096:604:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 08:11:49 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::c4a1:9dfb:41c:bb5f%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 08:11:49 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2] libperf tests: Fix test_stat_cpu
Thread-Topic: [PATCH v2] libperf tests: Fix test_stat_cpu
Thread-Index: AQHXu52fLyXHUCgsQkOb79TNHJGPtKvJdFqAgAQDFK4=
Date:   Mon, 11 Oct 2021 08:11:49 +0000
Message-ID: <OSBPR01MB4600710A07177677DF2F6E0CF7B59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20211006094817.477494-1-nakamura.shun@fujitsu.com>
 <YV8o9nukzBTkWmlw@krava> <YWCTrY/5zQLJm6kd@kernel.org>
In-Reply-To: <YWCTrY/5zQLJm6kd@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-10-11T08:11:48.948Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: ca6bb222-baac-c034-06c4-e030702adc52
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfd5bece-c724-4757-81bb-08d98c8ec69e
x-ms-traffictypediagnostic: OSBPR01MB4949:
x-microsoft-antispam-prvs: <OSBPR01MB494971B052BED3B21DD56962F7B59@OSBPR01MB4949.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b78NdzawC+1Ity/+KVJcu3yEkQisNGlqQ4N3aQgvfdFoFZJPlVnW0NETPXXIhUQf2EEH6/BIK452G9YJxP+md1tgEIoQQXvIG5FcwpAQEtIhR+tQ2pNvi1sQXix4l+ERrg6OCkyrTqJbue2eAyxl4Ed5gVVoayOrW3Cgypr23g/D2EF8T03A8x6IBhhqGJ/dKYNdJZDZIaAz3xLhIqZsLvdnNsSuO8JQoDJ/EcRK2xo8j/x24tgZR/qP7ZZNkdscJJrbl4ngG2stsOVx+rh/iVNYjw82nTKjHq3MBrE+NfenlFWD28N5GDeRrmEWqwUc+102Xe+ldfQba1dtjr34abdtZ358mMLwpWGbI3BE3v3wW6v/l2+fJaZvXJFTLrsUai1cxeCXxJ8c4S4pVJaryCpY/sT0N8ikiIPG62WX3tACq0zKN31CyVKTc8sheAKtEM8+kEvbTA5+LXNrfk0VfUXhP2ogKPpWLXe58nxJU63T4MU85Z8ya+Q20O+kiMw9g4q9yanAnrXLrsd5E4GT3as+fg8Ax+oiT+R+1XWWdgsnRVAo0EbBmaRdlq9U8InJEC8v5VLrpjEzEhsyu8LBavTrmG5E790rZh94A3rm9YBF2zpuA5BI5mXBdqPyH0IkIZIFZSQwMrnba2f/AUj3zwkVge3mHepGTXYos6I2jX41EGqwKsJ37DiGvGaA4RPoz9YhKR3aCqa3bGo5ubNcIBtg2jPoMPognNqsoJ8YbymPcbQiFMSIXUMd8UtV1NdtkjE6PMTIcrKXkkGydatvObtx3ExjfdfH37wMGLKmBTQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(26005)(966005)(316002)(9686003)(55016002)(508600001)(66556008)(64756008)(66476007)(66446008)(66946007)(76116006)(38070700005)(54906003)(85182001)(2906002)(71200400001)(7696005)(6506007)(86362001)(110136005)(38100700002)(5660300002)(8676002)(122000001)(83380400001)(33656002)(52536014)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?QVJYVFJBc0IrV0g5emMwMlNMQzBXWXVTVlNmeVhnL2gyRFlSN3FCV3pT?=
 =?iso-2022-jp?B?UStzVWl2MmJ1cVNWUFBreVkrWnB4TlpsYW9OMmVlM2lQZ3hMTFBoblI5?=
 =?iso-2022-jp?B?TUtGbjJjOXFKZUZ6VXMwbjJjOENKMlRtbWU2NjR4eGh6M2Z5SDRNRm1D?=
 =?iso-2022-jp?B?UDNleHdBSWw5ejNxb3MvcXEvTUw5VExudXBjVEZDWnNLR0F1RENOZ2dG?=
 =?iso-2022-jp?B?UDErazVoU1NXK29wRVhIVmFpOVlNYVdFOFBQMDlOUVp3UzlVOGsyWGdH?=
 =?iso-2022-jp?B?WWN0bktyQUpaV0hhWE82bTBDaHd0OE5Gb3FBdGtoUHlPWnhvZElzUnJI?=
 =?iso-2022-jp?B?cTRJUjBXWmtnU3lLUVc0NUtMUzhKZ3dDSU1INURMRDZWVVc5OGZoVWVB?=
 =?iso-2022-jp?B?aXhtby84aDJEc3Q2RUsrSnJxWjFBQXhXY3RRQjFySHJyZXZ0MGszaU1M?=
 =?iso-2022-jp?B?T1VMU1RkMXVzNzZpc21TQzV2RVgrNDVkWUFtdVdmZjlPbWZFUExPeVFL?=
 =?iso-2022-jp?B?NXRpVmplVUV3azN5aWNwejY2c2NyUDhCMFdyNkNCaEp0eU52QU5YaTMr?=
 =?iso-2022-jp?B?R0d0QnplRkZSMDd3WUFXT1FKcEVCTVBnZHdSKzRvZTBxaFEzN3RMRi9G?=
 =?iso-2022-jp?B?d2U2WkJHTVJGWEFVQzZLUnY1VlZtYnpiMWwwRUpvL1VvNW9zVTFyb3dj?=
 =?iso-2022-jp?B?QUNGaGQrQWN5L2RCend3R1VScjVwZkg2ZnFjYkpHVGtWUmhRRVNUeHhk?=
 =?iso-2022-jp?B?MzFIRU4wYnc3N1NvdXlmNUd4UnBaV0xsZ0p1cUFGb3V4NFdYbUFQZ0pl?=
 =?iso-2022-jp?B?bytBUkJ2RUVWWXNyVmxQVkNGM1ZRYnZiczBBZXR2MTE1V1dPSFdrVnRO?=
 =?iso-2022-jp?B?enMvSHljWlRGMWpwYzRUY2Z4aFFCTjY1dmsrV3BKTTZIc1pwd3YybXFD?=
 =?iso-2022-jp?B?MDZKV2YwZlVlbUtCSzB5dEIrajhDSE45L2NubU05QVFncG9CbkI0QkRH?=
 =?iso-2022-jp?B?VVFUeDVRaXl0QmE1RHMxZjZPZjhGMkpjU3BRQTA0eVE4TGNYMDI4SWpj?=
 =?iso-2022-jp?B?cjZZcjJldllTdnBTeXR4YzFET09uSlhOYzBVVmJHOFlmSG1SbzBBcFRY?=
 =?iso-2022-jp?B?OXJFdFMwQkNGVE9QK3JGNE9Sd0NHK09qbGh0MFcxK1B5aEh1SHhJSHF2?=
 =?iso-2022-jp?B?a3NwMlpvaUUrenFKeGF5cTJybWJLUVZpSVNUWDRQKy9DdTdLSTA2S2s1?=
 =?iso-2022-jp?B?SDQyeUlhNFNDaDNxaHkzbW5BOTZrR3VseUhyeHl6VjBJWWJLU1VtZU9B?=
 =?iso-2022-jp?B?WVp0RW1PWUFwcTJ1OUo2UVgwekRIN3lNcXZqbE9mdTV1Z2oxQnBCQ3lk?=
 =?iso-2022-jp?B?YVVXNWlKS0V6bndVTWh0SmFCNmNzZWo0NXlLWVRjc3RJemZiUk5ZUkpz?=
 =?iso-2022-jp?B?Ym81cVU2b2MraHpxeWh4ZVZkM29peEZsUnY2VHliOGczUnNwZnRLbk4z?=
 =?iso-2022-jp?B?SU0vWVpjVkVvN0RzNk1MTG1UVEw2U2QzMXdHZTFPUWRyZXMyUEwyaEF2?=
 =?iso-2022-jp?B?SU1JVXJBYW9RR1ZHVitYdUl6SEhXVktKVDNxclZZaVV3NUVTejRYVTU5?=
 =?iso-2022-jp?B?a2o1b2hlWU1sdmU5SzZYU2swNWVDeVYzSDhBM1BMRi82OUVhY29UK0xl?=
 =?iso-2022-jp?B?VWZUVGloR3RGcWkrTGlzVG9TU2JtN2dleDR1OHNabHI5NEtESkdiZXJj?=
 =?iso-2022-jp?B?SFVMUUt0NVpGajFBVmVBZlZsOUNUT3lMVGNwMDhrTEVvV1liR05PRmkv?=
 =?iso-2022-jp?B?ZStTRXhjZUtSZjI5UVo0bmNGeEdsMThMblduMEc2LytvQXNJTkg1R1JS?=
 =?iso-2022-jp?B?QUFadUJPdmR1SDNHRmNkUVhnc3BVPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd5bece-c724-4757-81bb-08d98c8ec69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 08:11:49.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+NOfzVEa8O11eGZwzxK6x+kMVDASUYw6BWa7L6mwexdEAuYptARYYTn3bIU+zkC9R8GCOPqGxgLKncSnLyDTK+NsGL2esMlxP+GJzrwmNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4949
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo, jirka=0A=
=0A=
> Em Thu, Oct 07, 2021 at 07:05:58PM +0200, Jiri Olsa escreveu:=0A=
> > On Wed, Oct 06, 2021 at 06:48:17PM +0900, Shunsuke Nakamura wrote:=0A=
> > > `cpu` of perf_evsel__read() must be specified the cpu index.=0A=
> > > perf_cpu_map__for_each_cpu is for iterating the cpu number (not index=
)=0A=
> > > and is not appropriate.=0A=
> > > So, if there is an offline CPU, the cpu number specified in the argum=
ent=0A=
> > > may point out of range because the cpu number and the cpu index are=
=0A=
> > > different.=0A=
> > =0A=
> > nice catch=0A=
> =0A=
> Indeed, Nakamura-san, please address Jiri's comment and resubmit,=0A=
=0A=
I'll send it right away.=0A=
=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> - Arnaldo=0A=
>  =0A=
> > > =0A=
> > > Fix test_stat_cpu.=0A=
> > > =0A=
> > > Committer testing:=0A=
> > > =0A=
> > >   # make tests -C tools/lib/perf/=0A=
> > >   make: Entering directory '/home/nakamura/kernel_src/linux-5.15-rc4_=
fix/tools/lib/perf'=0A=
> > >   running static:=0A=
> > >   - running tests/test-cpumap.c...OK=0A=
> > >   - running tests/test-threadmap.c...OK=0A=
> > >   - running tests/test-evlist.c...OK=0A=
> > >   - running tests/test-evsel.c...OK=0A=
> > >   running dynamic:=0A=
> > >   - running tests/test-cpumap.c...OK=0A=
> > >   - running tests/test-threadmap.c...OK=0A=
> > >   - running tests/test-evlist.c...OK=0A=
> > >   - running tests/test-evsel.c...OK=0A=
> > >   make: Leaving directory '/home/nakamura/kernel_src/linux-5.15-rc4_f=
ix/tools/lib/perf'=0A=
> > > =0A=
> > > =0A=
> > > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>=0A=
> > > ---=0A=
> > > Previous version at:=0A=
> > > https://lore.kernel.org/lkml/20211006080456.474273-1-nakamura.shun@fu=
jitsu.com/=0A=
> > > =0A=
> > > Changes in v2:=0A=
> > >  - Remove "2/2" from Patch Subject=0A=
> > > =0A=
> > >  tools/lib/perf/tests/test-evlist.c | 6 +++---=0A=
> > >  tools/lib/perf/tests/test-evsel.c  | 6 +++---=0A=
> > >  2 files changed, 6 insertions(+), 6 deletions(-)=0A=
> > > =0A=
> > > diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/test=
s/test-evlist.c=0A=
> > > index c67c83399170..47badd7eabf2 100644=0A=
> > > --- a/tools/lib/perf/tests/test-evlist.c=0A=
> > > +++ b/tools/lib/perf/tests/test-evlist.c=0A=
> > > @@ -40,7 +40,7 @@ static int test_stat_cpu(void)=0A=
> > >  		.type	=3D PERF_TYPE_SOFTWARE,=0A=
> > >  		.config	=3D PERF_COUNT_SW_TASK_CLOCK,=0A=
> > >  	};=0A=
> > > -	int err, cpu, tmp;=0A=
> > > +	int err, idx;=0A=
> > >  =0A=
> > >  	cpus =3D perf_cpu_map__new(NULL);=0A=
> > >  	__T("failed to create cpus", cpus);=0A=
> > > @@ -70,10 +70,10 @@ static int test_stat_cpu(void)=0A=
> > >  	perf_evlist__for_each_evsel(evlist, evsel) {=0A=
> > >  		cpus =3D perf_evsel__cpus(evsel);=0A=
> > >  =0A=
> > > -		perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {=0A=
> > > +		for (idx =3D 0, idx < perf_cpu_map__nr(cpus); idx++) {=0A=
> > =0A=
> > s/,/;/                      ^=0A=
> > =0A=
> > tests/test-evlist.c: In function 'test_stat_cpu':=0A=
> > tests/test-evlist.c:73:52: error: expected ';' before ')' token=0A=
> >    73 |   for (idx =3D 0, idx < perf_cpu_map__nr(cpus); idx++) {=0A=
> >       |                                                    ^=0A=
> >       |                                                    ;=0A=
=0A=
Thanks for review.=0A=
I will fix it.=0A=
=0A=
=0A=
> > =0A=
> > =0A=
> > perf_cpu_map__for_each_cpu also returns the cpu index (tmp),=0A=
> > maybe we could use that instead?=0A=
=0A=
Using only cpu index results in a build error.=0A=
=0A=
=0A=
  $ git diff=0A=
  diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/te=
st-evlist.c=0A=
  index c67c83399170..b36aa8afe95c 100644=0A=
  --- a/tools/lib/perf/tests/test-evlist.c=0A=
  +++ b/tools/lib/perf/tests/test-evlist.c=0A=
  @@ -73,7 +73,7 @@ static int test_stat_cpu(void)=0A=
                  perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {=0A=
                          struct perf_counts_values counts =3D { .val =3D 0=
 };=0A=
=0A=
  -                       perf_evsel__read(evsel, cpu, 0, &counts);=0A=
  +                       perf_evsel__read(evsel, tmp, 0, &counts);=0A=
                          __T("failed to read value for evsel", counts.val =
!=3D 0);=0A=
                  }=0A=
          }=0A=
=0A=
=0A=
  $ make tests -C tools/lib/perf/=0A=
  make: Entering directory '/ubinux-dev/common/home/nakamura/kernel_Build/l=
inux/tools/lib/perf'=0A=
    CC      tests/test-evlist.o=0A=
  tests/test-evlist.c: In function 'test_stat_cpu':=0A=
  tests/test-evlist.c:43:11: error: variable 'cpu' set but not used [-Werro=
r=3Dunused-but-set-variable]=0A=
     43 |  int err, cpu, tmp;=0A=
        |=0A=
=0A=
=0A=
Best Regards=0A=
Shunsuke=0A=
