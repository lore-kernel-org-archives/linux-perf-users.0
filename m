Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E253C77B7A
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 May 2023 11:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjEPLRC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 May 2023 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjEPLQu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 May 2023 07:16:50 -0400
X-Greylist: delayed 13441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 04:16:24 PDT
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5AC7284;
        Tue, 16 May 2023 04:16:24 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5508:0:640:704d:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id DE5B85EC2F;
        Tue, 16 May 2023 14:15:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rFZKUqBLcmI0-RIroBFBW;
        Tue, 16 May 2023 14:15:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1684235755;
        bh=lMrZOJIB5Kq7XBazm3gjVU6sMhxH4y9CP6MxFx5bCrg=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=qo5pn4E6x10c59nkLDhfTnwDxBnodn3LJx3xTeuKTeXxVfhtiGjQjNuiDQQI1FNX6
         DrW7a73W2NDiruYW6gJZd84PXw1ppl/Bke6eQNLxMcHli632y1MlByYNGAEhbweUYX
         HvBYCPhvtwsbiY56ppdgQfKdw8R3ViKdukAX8DUY=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <28d0792b81db018aeb644096898693694b2841bc.camel@maquefel.me>
Subject: Re: [PATCH 1/2] perf tools riscv: Allow get_cpuid return empty
 MARCH and MIMP
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 16 May 2023 17:15:54 +0300
In-Reply-To: <IA1PR20MB49532515E0DD00227B7CE5F3BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <680f2d5d146a38083a28198f1a8a3694654bf8f8.camel@maquefel.me>
         <IA1PR20MB49532515E0DD00227B7CE5F3BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 2023-05-16 at 17:43 +0800, Inochi Amaoto wrote:
> > > The T-HEAD C9xx series CPU only has MVENDOR defined, and left
> > > MARCH
> > > and MIMP unimplemented.
> >=20
> > According to the docs you can still read them, but it's hardwired
> > to
> > 64h0.
> >=20
> > How it's supposed to distinguish c906 and c910 for example ?
>=20
> It is unnecessary to distinguish c9xx, their event index is
> compatible.
> The dtb and opensbi will final decide which event can be used.
>=20
> > What does /proc/cpuinfo shows on c9xx ? Why can't we use zeroes ?
>=20
> The content is as follows.
>=20
> processor=C2=A0=C2=A0=C2=A0=C2=A0 : 0
> hart=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 0
> isa=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : rv64ima=
fdc
> mmu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : sv39
> uarch=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : thead,c910
> mvendorid=C2=A0=C2=A0=C2=A0=C2=A0 : 0x5b7
> marchid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 0x0
> mimpid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : 0x0

Then why do you need first patch then ?

marchid, mimpid will never be NULL they "0x0" and "0x0" strings
respectively.

How have you tested it ?=C2=A0

There no way "0x5b7-0x0000000000000000-0x[[:xdigit:]]+" will match
"0x5b7-0x0-0x0" which cpuid in your case.

Just drop this patch.

Anyway "PAGER=3Dcat perf list pmu" gives me an empty list on licheerv.

>=20
> The `mvendorid`, `marchid`, `mimpid` are the same across allwinner D1
> (C906),
> T-HEAD th1520 (C910) and the sophgo mango (C920). It seems T-HEAD use
> MCPUID
> CSR to store CPU info. But this is not standard and not shown in
> cpuinfo.
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

