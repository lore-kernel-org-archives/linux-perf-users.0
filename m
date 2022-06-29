Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE7C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 12:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbiF2MuK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiF2MuJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 08:50:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD32C31211
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 05:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5tPLyaTdJMh1n3SuUA4OZbI9oSau/V94+FKcQXaGfOdY/Bb5eF59xCzXXu5799zL9y8hqb0anorUnMZK8SlN5IIx8Necp44Di8QYWjghh4809B5kC3GCel0s1G7VB6jV5vROMpqf7O1K3HuOFiZ2zVQ9uKs6z64m4K4dgK7n2lbIri4RnsUYsjG/14UzpTZ2GngNhhNpPqATJOa5aeGLHacJ74QKQEQoV4hBoc6999i+1Ncvu0KdgWamscfqgsn0OpEVG8dFHZx/vHFDFXyrpwb6r0f2kHnma/SsIdB7/nhK2d+xbgqeOWLe2bKKHwOBWo2eUEfRU21BSIwlISGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvZorPYeJoH/j5aC39LNa1oUxpwobU4RMUHFGFEG178=;
 b=eL+zMz/doecQRyCsNjKsMoBCndAqs41bHZbt50dSHKaYYYyY7uKmbG/22Wr0hD9eLkmR7b+Vp9jNRnydoXAGnRPViaj4csCNNc/7s0TTM+rt0qcEy0Wa66tRhmyGYOE6+tLOxTQ0lGxuC93qvIWUJZy0OAlmBaEMbfD1sG1voKe3+qK/KUHQl7qi1yQINfs6n6z1VEJyRJWo37fMaaq0MaRY9RpPXtKPRqHY8iKDzgL9xqX8XYC/BWg4dQa0kxqLz6dyI3usxC1nLZdnecOCnsY2n4XLGj3o1GXzBZfmVKuZO7v8m5XQuAoABk8vnRTPRTBiOBCzZBddc6EOhKGDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvZorPYeJoH/j5aC39LNa1oUxpwobU4RMUHFGFEG178=;
 b=jIxuYaq5NuvxMYFJa5suJ7NZ56vPpKZ5Xk41DKouUgu21jnBieQD3Ik/+ftJ4jj7lEXoY0NARiydEdZ/PBJF5hX0hjpTGjvVmE0HPZEf+TmWvboKrtOLK/wh6V1thVTlwHGbtswkOdIaVEPmlkxpgbm/AE6BgO2MWcJVUEwtMUY=
Received: from AM8PR07MB7666.eurprd07.prod.outlook.com (2603:10a6:20b:240::23)
 by HE1PR0701MB2681.eurprd07.prod.outlook.com (2603:10a6:3:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 12:50:05 +0000
Received: from AM8PR07MB7666.eurprd07.prod.outlook.com
 ([fe80::188:e139:774e:cea1]) by AM8PR07MB7666.eurprd07.prod.outlook.com
 ([fe80::188:e139:774e:cea1%9]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 12:50:05 +0000
From:   Emil Berg <emil.berg@ericsson.com>
To:     Jiri Olsa <olsajiri@gmail.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: Possible overwriting of errno
Thread-Topic: Possible overwriting of errno
Thread-Index: AdiLeXbz2aV0mg2JQcK84/XQYx5qnwAI2DkAAAZJ2hA=
Date:   Wed, 29 Jun 2022 12:50:04 +0000
Message-ID: <AM8PR07MB766699E4E763DD99B6ADFEB498BB9@AM8PR07MB7666.eurprd07.prod.outlook.com>
References: <AM8PR07MB7666EEF15D803DAFB5A8284D98BB9@AM8PR07MB7666.eurprd07.prod.outlook.com>
 <YrwfBPMR+2kZFgHH@krava>
In-Reply-To: <YrwfBPMR+2kZFgHH@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 834a6b90-2e3f-4081-86a2-08da59cde389
x-ms-traffictypediagnostic: HE1PR0701MB2681:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epeDKfoL6Wpfa3VQYGnLiS1SkE6fLj1+UIiAZo+Ai3pYRC9/Z7Sg5JKykt2eFDPIRY/s5/VTIfqbLs9kOKMo+aGad5FW4GLyAZDuXj+YaYQ3nMUIXzow4S1OmCad7ezoxUNBi65l4mZeyvamRXWORAq/GctCQnKrfEE/Hd3Ey9ejOQYH/ARsx5F5SL3pBD+PQGwzSjYT7isWUxAnhdwjgdzMaG711PcGKBf9OgMvI8VWgIhHoOJOnCfYatNQSOhkCoerK/Guqc6NkdKb2+inhPCt4RSMgFnyg20iaXe9z6Y8qJb4pvhFUmZrxHqan3MtI1pAl7GcFVC0e1H4BzGkxa5IBU4wc0qDSc2cGeObWFSAmKmUPf5EXCkKruHZgBUDnor2H527QcheidyaFSDic4UpSX0nwiyEgpcREpPzs49cDIG2ioL/TcV1lYAjZwBPc3cDAtClOMgI01UBhD/3RmKBfwDEZ2s6J7VETbj+xDDMmj+mHEGwtc70xYbExD4I2U9eE5BwX8bJLRq6PTjnadUBpxQRyQgucfhBMeD+op20PtL5F+wkPnGCkfCLOze83xdBDMcyBnwT56JU1eB6AuWBCicd6HeCZJhodaWI0gEWqQ8KtREqN4B/+yCmfn9Yjr0EcZ7NR4pE8CPICsDfCkf1gEpMn+IN7zqOygZHXe6vCukx+vgKWSocHQvXPqE6amPzDC/RbJFTGxeLSkcU+Xw6B4smINYBPROS62t/q/Us5S1B2GGa08NZBoJd26CSaRcJJmYyAFSko9GNZA/x0a9KI9jhRb4mEelJfoaPG5s/AxTiwERfi9hTvLA6H7J/93FZzCvE2cy3bQOW+JOmy2jvVque8tr4kxEwOx6O0Gc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR07MB7666.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(55016003)(3480700007)(83380400001)(122000001)(86362001)(82960400001)(38070700005)(33656002)(8936002)(478600001)(38100700002)(44832011)(52536014)(5660300002)(6506007)(41300700001)(2906002)(66946007)(71200400001)(6916009)(316002)(66476007)(8676002)(26005)(186003)(76116006)(66556008)(64756008)(7696005)(66446008)(4326008)(53546011)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7dMhnsAiuLrc7JmrGQUSS510KVN7OHCJlch7bkvZ5b0KinDYQusWKden6Hhp?=
 =?us-ascii?Q?rrDQivIkEbfDZQKXjOrtIBeFo35vQP+R2ekfVh5QMrTGRv9HyOmAze7rzpE8?=
 =?us-ascii?Q?zQ1RObOjrPMn5EV5PYTVI0nJhBcHNagQTXtUAv4ZiT0k7j+pakOfMYe9aaQg?=
 =?us-ascii?Q?KjJNNQhwjRWOk+3MUW3fj7wsrPh7n2dJWYsUUoGY7MOksCDIAABAxzkNkSQh?=
 =?us-ascii?Q?gY7YOJzJnwaWhZPvyCi4XHIy4urFXXQLr/H49ZhGkNqUgUPBqtiKRhFBXcNu?=
 =?us-ascii?Q?RTlSAR1kmFqd15oATOJyT6U+0XSOejUMwa4PUBJhKAXvfmgYjqRNXTYECWaJ?=
 =?us-ascii?Q?c0d5qBMXtDx4825JEEoEHcjD1kZ434O6r5uiQ2g6foF44Q6cIqE9WFDfyaS9?=
 =?us-ascii?Q?20qvPzhpVhs79mPouoMN8zY0UYLlzpPvQHK0HEWDSWjSkC3kaJB1v7idEoFw?=
 =?us-ascii?Q?WeTnaVDtKXRCki0yK2WpnvVE13XnfvOtkiLA0+TRoQWibjADRr+71L4jOEH8?=
 =?us-ascii?Q?jYAc5p9nxhBd6y3tW/tXrkuclQDpCB7VdGTcD9kcVCCw4KC5QJJ4iFiFly6z?=
 =?us-ascii?Q?ddKM3BvzkfbKHUOa0ig1XEjOvkoBfPFU+zVm7oY3g0ID8yx/VdInZ4xcUL7r?=
 =?us-ascii?Q?K+T+/rJJuSHHDLpl5wYnusHmzI7nxINMp2v80IbH9PQAy+DPCCiPqw3IlwFZ?=
 =?us-ascii?Q?8P67wl5PyBRK9sPA7J3rN1TqmgBfAYKNEyJKMB9TPwNAAISJ9cvl7fI5lLNP?=
 =?us-ascii?Q?556GKzl43KM9G7j5qyc1tLTq8C2I+jPZoxvk2iF6Ldj5qYa827kmfAKo7kQj?=
 =?us-ascii?Q?FHdz7Aw4bC31VtqhEmsPFiSaRLueTjejFftzSrHzgVn9B+9EGf5hlJUqIY75?=
 =?us-ascii?Q?CPO8YQN6+qALYtrPsUkcNtnoxDmC/2oxt5imyt86ysU+YB0ZUZqwtsWYTYd1?=
 =?us-ascii?Q?An1n+x7OyITk+VU6+LnKMzsdJmVXcMBuTOSJ0QrRfZvfcGRyyqpOVX/M1LLn?=
 =?us-ascii?Q?V6GICcM0ZIlZPN/6NX/DHszM/AWsMMHdYWHRshhZZFqzoWjRPQ2l3zSvGOCa?=
 =?us-ascii?Q?JlLgfzP1wUd9fX7Y0cINqP99hdTsc4btT0p8K01PmI9413VDPk9l63zte/RN?=
 =?us-ascii?Q?gjpKvwB0rLRx6Rh3waRhkStoDPFAKqZ2dOs2orS1tGN7fTvTwjw1LPIx99U+?=
 =?us-ascii?Q?nu/3FqDSQmVajBYLommVmCBPMD8ftNWaWiPHWaa38LhSsfB2t983dd9XxllV?=
 =?us-ascii?Q?ZdQ8EEgpO0/8xMRs3cMpZoT1a91JWPlP5XcsENUbW5L07pbTJcboWMi9pvAY?=
 =?us-ascii?Q?OxQhfOkM4PjoTizAIrMv3L97/1pGvydaD/SeyuBRMZD4GXDrgYaMUY7V1t3C?=
 =?us-ascii?Q?aMUrI3CZLtnTmqAEnB9KXhpedo5xqr7DPp8XUFnwVcCUY+Q0R2KYQJl+9u1+?=
 =?us-ascii?Q?4CBF4wFUKodTTZCgdNbE1DLoTMs1KNi9T6KbRA7QLxvG2x1a/grd6rjz21mJ?=
 =?us-ascii?Q?xiQblpoIVsCJeHw0ff9nU0ezfcwhNa4zxeh3Jq2jwkuqdIsF8iBnHfAX61C2?=
 =?us-ascii?Q?x4SS63jvE3UvgD+x8n+8cIQIFqRp+v15CJoIQgpq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7666.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834a6b90-2e3f-4081-86a2-08da59cde389
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 12:50:04.6486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZH5JPbXef1nH4wcs2RGgqZRgOo8WN4Ge8Yk1YZL8JGmRyEtKC37IvFpxeTGx+0/M0CIffG2D8Y26fAKjoTxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2681
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

That's nice. Right now it's a bit cumbersome to test this patch since I'm r=
unning perf via vtune in a container...

> -----Original Message-----
> From: Jiri Olsa <olsajiri@gmail.com>
> Sent: den 29 juni 2022 11:45
> To: Emil Berg <emil.berg@ericsson.com>
> Cc: linux-perf-users@vger.kernel.org
> Subject: Re: Possible overwriting of errno
>=20
> On Wed, Jun 29, 2022 at 05:31:42AM +0000, Emil Berg wrote:
> > Hi!
> >
> > I'm getting the error "Failed to start threads: File exists" from perf,
> probably EEXIST.
> >
> > I just want to discuss the changes to tools/perf/builtin-record.c made =
Feb
> 10 2022 with:
> > perf record: Start threads in the beginning of trace streaming
> > SHA: 3217e9fecf118d5dcabdd68d91e0c6afcb4c3e1b
> >
> > At line 2014 pthread_create() is run and on line 2017 strerror(errno) i=
s
> printed. Between line 2014 and 2017 record__terminate_thread() is run.
> >
> > I just think record__terminate_thread() run in-between looks like it ma=
y
> overwrite errno, thus messing up the error message. To be clear I think t=
he
> error message should come from failure of thread creation and not from
> failure of thread termination. Can someone enlighten me here?
> >
> > if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
> >     for (tt =3D 1; tt < t; tt++)
> >         record__terminate_thread(&thread_data[t]);
> >     pr_err("Failed to start threads: %s\n", strerror(errno));
> >
> > /Emil Berg
>=20
> yea, seems wrong.. could you try patch below?
>=20
> thanks,
> jirka
>=20
>=20
> ---
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c in=
dex
> cf5c5379ceaa..158bb0f293d2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2103,11 +2103,11 @@ static int record__start_threads(struct record
> *rec)
>=20
> MMAP_CPU_MASK_BYTES(&(thread_data[t].mask->affinity)),
>=20
> (cpu_set_t *)(thread_data[t].mask->affinity.bits));
>  #endif
> -		if (pthread_create(&handle, &attrs,
> record__thread, &thread_data[t])) {
> +		ret =3D pthread_create(&handle, &attrs,
> record__thread, &thread_data[t]);
> +		if (ret) {
>  			for (tt =3D 1; tt < t; tt++)
>=20
> 	record__terminate_thread(&thread_data[t]);
> -			pr_err("Failed to start threads:
> %s\n", strerror(errno));
> -			ret =3D -1;
> +			pr_err("Failed to start threads:
> %s\n", strerror(ret));
>  			goto out_err;
>  		}
>=20
