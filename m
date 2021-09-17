Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAC2C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 08:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825FF610A6
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 08:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbhIQIKy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 04:10:54 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:33731 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245455AbhIQIKt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Sep 2021 04:10:49 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Sep 2021 04:10:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1631866168; x=1663402168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XehYVYDpTzNgbW8Ag5WGzI1vd5bUAEPlZIPJnFlz74E=;
  b=ti0dFiqeElGJPwBD1VParusp83OeqCQXlTOz9RGwRjfRR8GBfxvgyVgX
   dOV7VT8FBCvARLdQHXMsXPSfmaiVAZYspJxcMccNvVXbHcEvsJcXl9FkY
   B1hvFhBDayBlcKliIAYBF+X7A8ib5/SnJipLwasayBjoxwYurc91YAvWi
   6gdS8vCaaG5cSsoe6SMIVFKuA1E0Yhb5LAraaxWv3wlM3yCmnSpEFtDWF
   9kMHnCKAGUCbwcC/BABjKVFrZts7lcUQOBaIxtSQySLXIRvUAr0GXJQw7
   qFkp32rTKX0e+plUHWAl8PyQ5O333Th5KenCBniD32csttBKDUMNHnjfM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="39460414"
X-IronPort-AV: E=Sophos;i="5.85,300,1624287600"; 
   d="scan'208";a="39460414"
Received: from mail-ty1jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 17:04:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx4JxX6EH/Es5fGGTqn1ARxkt+ursP0vwyA2go5/4NuVgnMe/4oJnqcXmoalEU45Ouqee2VuSLNVQFMdDtbTfL/xIlzfjGGigoj3zK1xO7spCpHs3y1FeTi0sdbuhLP7M9Qxa0heHcVhbLMtBZr9JyxcvHgwQP5Cz78qIKyfdI62ZAZKZ6WT9Lzot4wHr4VR02KfGkSniZMVNlDEUGzw8WkhI3RQBnP0BIT8HgfN3RmaQ1+DdmEr5LKGXK+RZUWmdy7gsk0Nu792cnoQpnKW0VDvwmS5uVMpp/e6FQu0CjIaQjEa+KH1PJ9xtu302H+jabiPgv2PnShX95F6x8+3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XehYVYDpTzNgbW8Ag5WGzI1vd5bUAEPlZIPJnFlz74E=;
 b=aezt0GslXMJYxvp+X89kUXfoON1qWZOsOMw38A8A16sQ3POa9GMiT9kzd5AYXEVDdnw4qeL7kS1vfPODp/VF+bbVpSx/lP5T0t+ieiIhUxGWnvUtIHACJ9XTCyh/B+L+Vqj+nUNW+hjntHaR+0gmx3w+hXcCDTb4i9LDg20lRECFWedxK2JIvzXXUTL+8ZWEDpmAc5ixpy3yEuAF849fVxzEsFtQw13e1SbGkZyAdh2xiH+mAzkqleoSbffymu7zyELChLX+NUrKeLH0IqS4/Ti8FB/g5p1Q6M/td6IL/F2voV6lMxKXmhfthccU/vR1S5VXwnO4Ys+rMDR+VSpf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XehYVYDpTzNgbW8Ag5WGzI1vd5bUAEPlZIPJnFlz74E=;
 b=WumdV5x/AspaVYpOS0nps1g6rop1HZemwHKEc7IZeQAnjgqmtuSsutw32HkwnAnDwEAHiyPdzYW1pgI8VJCLTp3n/kTV7/peEw+UZcOQYZgXOvCk05+q7VREzHzaw8wmywhlXHKM6v7JtOUtHp5HxpMVzlhULDwE9ZVpIxYLTnk=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB2040.jpnprd01.prod.outlook.com (2603:1096:603:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 08:04:04 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::e028:fc90:498f:d2e0]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::e028:fc90:498f:d2e0%3]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 08:04:04 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     Ian Rogers <irogers@google.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/3] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Thread-Topic: [PATCH 1/3] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Thread-Index: AQHXmFsxBFGvQYUD8Uu1pPLYL2hYdauCbgJwgAsoEwCAC8IOAIAOquyD
Date:   Fri, 17 Sep 2021 08:04:04 +0000
Message-ID: <OSBPR01MB460074286BDE891952CBC809F7DD9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210820093908.734503-1-nakamura.shun@fujitsu.com>
 <20210820093908.734503-2-nakamura.shun@fujitsu.com>
 <YSQBI+FZLBvKr088@robh.at.kernel.org>
 <OSBPR01MB4600288E176A169C07BF543EF7C59@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <CAL_JsqLKD0DZT63MQ9vTumOf1bfRrU9Bt9Qa_GTb1siRsK+Z+g@mail.gmail.com>
 <CAP-5=fW_g9JHKWQoNiwNeSN8MjJ1OA7qLb3JD3ErEi1be4DEiQ@mail.gmail.com>
In-Reply-To: <CAP-5=fW_g9JHKWQoNiwNeSN8MjJ1OA7qLb3JD3ErEi1be4DEiQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2021-09-17T08:04:03.720Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: c4bd3b24-7c4f-2cd6-8312-17b67fd49c50
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb9bc903-8228-4ad6-7bc1-08d979b1b75b
x-ms-traffictypediagnostic: OSBPR01MB2040:
x-microsoft-antispam-prvs: <OSBPR01MB20401A33F908BF955A7B3431F7DD9@OSBPR01MB2040.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RrK++4tdrXm3FhZLL8fwzVsNoazMi1iGZItXqUyW78LZQSxQmf2UZSpy4dbbuM98SOWWrKpPenbIS3tbvG5QOp/ex1SexQolMeG1gHI0zxR2/cV+iwvmjP3wY3uR5Xr0FqwGnDvQmgVS9fpdDhfoIjXfGygQlP/MA4yyBj00bfAcf+/rKdRUeaD+BvZL053Ckf2s7h1WHuB+ynTNNYEHObj0Kj3crA/8sMBlFxeCPxms3lR/5OGB3uEFXwRMFSNBxGwBCZKPUTaBCT1t0Q7glIhg/XX0d9yK1B8cKJVqFGV/3WtAg20abmEVr51e8KrZhtHTggwG0obpyNNjtxEAGq9WNk3y2RWvrPGu7iYMmZn6i/o4PaHoe87aqc8W3Qxtj5LmEVhDyzbDF3SNslmvU1SWaT2ueZddVUmjARrEfGebN4PF6jr72MJ2D5S9AJXEaJrL7HXefNHmK5Gv8Uo4AZbh91MBjQTkuCGpZAqrmGpyKEPicnW8LvD28NnI1D9jYkfaelkKzAfbfg+z+KYNyff2TP49EzBimt1WziFaq0GroIKAOMCR0BlfBcl6FT47r4QmTAg8wSgNWxs8vNl+iJQ2wzgFeuRkBbK8BnVJ1OoPLLoqtzHxsv2Mfuj2qizf65J3NQJH0d65z/KYYjD39Ct+EqF9Abt3Qiw9p7FJdahNqApDAr3juChC6izVsaM6/0oiiamK03shYfdw6eislQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(85182001)(66946007)(38070700005)(53546011)(2906002)(6506007)(38100700002)(7416002)(316002)(76116006)(122000001)(64756008)(66556008)(66446008)(8936002)(86362001)(508600001)(33656002)(71200400001)(4326008)(54906003)(7696005)(9686003)(5660300002)(26005)(52536014)(186003)(6916009)(8676002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VUVjNjI2MmIrTXRhaDB5NGNaYXpUdjJ1TkRWUkowNFNiVk1LYUFERVc4?=
 =?iso-2022-jp?B?QTNZMTd2S3A1bmY1T0x5OTdOa0lEaW5XQTdVbEptTkdRVzdsK1hqc1BI?=
 =?iso-2022-jp?B?WXJGVklvR2tvemRodTArenlhM3hHZ3N6M0dXLzVOZ2F1MTRYRnlEMUZU?=
 =?iso-2022-jp?B?Qnh5cFVrNkJ4VEZNVVg4SFJJVkR1MDRnMjdLU0VQMEEwNkxQdm5oVitR?=
 =?iso-2022-jp?B?VUlkeUVYMFNSVzVXaEh0LzlyaTJwbnVFemdMQTRKWmZVaXl0NFZRS1NY?=
 =?iso-2022-jp?B?MENVZjhDdzFtZHY5RVk2MWNZR3ByNTN0bk1MR3NFQW5vTUwvdkFIV3Z3?=
 =?iso-2022-jp?B?eXFyNDNTMUVDMUdaQ05YV3RhbFk5TUpIYWNGVVZkcU1Mdy9HSE1aSFd2?=
 =?iso-2022-jp?B?TkhrR0ZKR01xRFBYUXJtUGEzM0JFWmhoMUx2ZVlSWU9kYkI4S1ZiQWQ2?=
 =?iso-2022-jp?B?dWpWSDk3UDMxUi9qSE5tTWNlNE13dFFpVFA1cStiWEREbEEvanpQWXVW?=
 =?iso-2022-jp?B?eFRzbnFZV2Q5NUkrY0tYcWpzV1M1RzA5eDhuNGJJS3U5VUI2MFNBV0Z2?=
 =?iso-2022-jp?B?SDNUTW5VRWpydDl0dUZ2WTdMRnNqZkU4aC9ZMlNMWmdRa3hXNFpOYmMz?=
 =?iso-2022-jp?B?V3R3SDNOYlhTYjkrN2VLTjNDbFBJbUVlWE1McGFjbTBZdjJsK005Ritk?=
 =?iso-2022-jp?B?VUZ0RTlQS1AxZkVRdkNnelkxckNDZ3M5ZFBaa3Y1ZytTNW1iVDl1a0tq?=
 =?iso-2022-jp?B?dVozS2FYS1RUbTcyNHpqWmpBeEVzVElIWENCeTJNVlFuWFFXNUt0MllM?=
 =?iso-2022-jp?B?MXZxMHlLTDlLd0JEaUgyRy9zM3lUTVRFdWFwZ0Z3SUN3OEhPOUVIelhV?=
 =?iso-2022-jp?B?NkRPaWl0UHppeS8vTmRncyt2VS84ejdrbFhrc1QvU25udTF4cDB6ZTNY?=
 =?iso-2022-jp?B?QVdzU2dZZzFrNFdJNG1iRzBkM2UyTFIvZ1Y5UTgxYjlVV1Z0MDFIT1Zn?=
 =?iso-2022-jp?B?UnBpVlJYVVFPTjZtd0Zkd0VmbnNoU1JXeHN1STJwNEs5VWEyVkI4dzlQ?=
 =?iso-2022-jp?B?T3ozeG5JOEYyajErUy9LYmhvM3IwSjBzRGNReDl3eURZempCMmwvLzQv?=
 =?iso-2022-jp?B?cHF1OTlLVmpOR1NhSExUb2xOWlhJSFBhZUg3aEY1b2tndGJhclNyUUdr?=
 =?iso-2022-jp?B?TU04cmpKMlFSbjhyOXZQUjFyUDQ3aW9YY3JpTVFpOFVFcm9rMklaSzM1?=
 =?iso-2022-jp?B?aXdpMWZBa281bmR1S3EwOUYvM0xXaW1HSW5uTzd1ZXd2U1pQdVVnNi9I?=
 =?iso-2022-jp?B?aFZGQ3Z3c1d3dlJXamRkaVZIZEk2cjkyQVVOb25vMzRMZmYzYUVNQThL?=
 =?iso-2022-jp?B?QmFva2pSN2ZRWDZxL2MvdWxpeEV5VmswZUJyTFhLUFlOLzlmUnBoaTRk?=
 =?iso-2022-jp?B?NDNKaTM5UjhpaEhIZWpVZ0lBc2FRdmd4THBNRjNGdGw2SWw1TUZLY2E1?=
 =?iso-2022-jp?B?RjRmQlZWdXYrelFDdWpadVhycE1jNmdlMGhzcWFIZzdwNVlZMjhFSlQ2?=
 =?iso-2022-jp?B?UkoyT083MnZsbXRMcG9jTElGcWg3dEpSRG15RjNLVnphSUxkdVNrdFBq?=
 =?iso-2022-jp?B?ZTdBcUNJOERZc3FFTWJ1QlJ3VzFIbmo3RVFEMDVjaFRnU3pocW02Nmp2?=
 =?iso-2022-jp?B?dFBRaXk3aGtSMkdzK0doZmt1TUJLQmdWelR2Q1RVbUxaaFMvcTBKb1Mv?=
 =?iso-2022-jp?B?NzhYVHVOUFZod2E3VmtJRGZUaEFPZkZoM1Q2R1hnZy9hakNiV3o0aVow?=
 =?iso-2022-jp?B?QVF5V0UrK2gxWERCaktRTjl6WVg3UWREVHhhZzVROTEyYlpYQkY2WnV5?=
 =?iso-2022-jp?B?Uk9mQnZNYXVPTE52YWlNK25LaHJVPQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9bc903-8228-4ad6-7bc1-08d979b1b75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2021 08:04:04.1244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vU2/bhUv0tzf04+W/z2hM2bZ7qgEIOxFUSxIu5SpJpV4doOa10zaUXkNg4FHbhpI+W7PBIGyQWcePMgCXSgFlJeIUazA2iHmfgApMSgZg8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2040
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi, Ian=0A=
=0A=
> > On Tue, Aug 24, 2021 at 5:12 AM nakamura.shun@fujitsu.com=0A=
> > <nakamura.shun@fujitsu.com> wrote:=0A=
> > >=0A=
> > > Hi, Rob=0A=
> > >=0A=
> > > > On Fri, Aug 20, 2021 at 06:39:06PM +0900, Shunsuke Nakamura wrote:=
=0A=
> > > > > perf_evsel__read() scales counters obtained by RDPMC during multi=
plexing, but=0A=
> > > > > does not scale counters obtained by read() system call.=0A=
> > > > >=0A=
> > > > > Add processing to perf_evsel__read() to scale the counters obtain=
ed during the=0A=
> > > > > read() system call when multiplexing.=0A=
> > > >=0A=
> > > > Which one is right though? Changing what read() returns could break=
=0A=
> > > > users, right? Or are you implying that the RDPMC path is correct an=
d=0A=
> > > > read() was not. More likely the former case since I wrote the latte=
r.=0A=
> > >=0A=
> > > perf_evsel__read() returns both the count obtained by RDPMC and the c=
ount obtained=0A=
> > > by the read() system call when multiplexed with RDPMC enabled.=0A=
> > >=0A=
> > > That is, there is a mix of scaled and unscaled values.=0A=
> > >=0A=
> > > As Rob says, when this patch is applied, rescaling the count obtained=
 from=0A=
> > > perf_evsel__read() during multiplexing will break the count.=0A=
> > >=0A=
> > > I think the easiest solution is to change the value you get from RDPM=
C to not scale=0A=
> > > and let the user scale it, but I thought it would be a little inconve=
nient.=0A=
> >=0A=
> > Agreed, unless someone else has an opinion. It would be good to do the=
=0A=
> > scaling in libperf with the optimized math op, but I assume there's=0A=
> > some reason the user may need unscaled values?=0A=
> =0A=
> Hi, something I've mentioned on other threads [1] is that running may=0A=
> be zero due to multiplexing but enabled be greater. =0A=
=0A=
Thanks for your comment.=0A=
I'll fix it.=0A=
=0A=
> This can lead to a divide by zero when scaling. Giving the ratio to the c=
aller=0A=
> gives more information - I may be misunderstanding this thread, apologies=
 if so.=0A=
=0A=
The perf_counts_values contains enabled and running.=0A=
So, caller can calculate the ratio.=0A=
=0A=
Best Regards=0A=
Shunsuke=
