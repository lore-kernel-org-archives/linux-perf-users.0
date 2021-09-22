Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317C9C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 05:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111336112F
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 05:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhIVF1X (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 01:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhIVF1W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 01:27:22 -0400
Received: from forward106j.mail.yandex.net (forward106j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671FFC061574;
        Tue, 21 Sep 2021 22:25:53 -0700 (PDT)
Received: from myt6-43c1316fdabf.qloud-c.yandex.net (myt6-43c1316fdabf.qloud-c.yandex.net [IPv6:2a02:6b8:c12:370d:0:640:43c1:316f])
        by forward106j.mail.yandex.net (Yandex) with ESMTP id 7BDD5136A87F;
        Wed, 22 Sep 2021 08:25:48 +0300 (MSK)
Received: from myt5-cceafa914410.qloud-c.yandex.net (myt5-cceafa914410.qloud-c.yandex.net [2a02:6b8:c12:3b23:0:640:ccea:fa91])
        by myt6-43c1316fdabf.qloud-c.yandex.net (mxback/Yandex) with ESMTP id aeAFcq1fO2-PlD8hGMN;
        Wed, 22 Sep 2021 08:25:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1632288348;
        bh=T51rUNPVohQf+3lV1GDaVcNQ8Jynk/Br7M1fk9sxHeQ=;
        h=Message-ID:Subject:To:From:In-Reply-To:Cc:References:Date;
        b=kVVNjrWLABjth60iiq6/rI7wNDsrf8wtQE3jiJFWN9IFfl9wKMwY/ObWvd9xSbBI7
         T0XiwT2WbKtYQXJBIIYi1w6iPJc2QTdnd9q/IdsspgQlv2oHDAdEDHPPIL2S5QcEuh
         YAGM5Guw/vkXQCG9YolVo+ZNkJsCJ+Mwub7Rf47M=
Authentication-Results: myt6-43c1316fdabf.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt5-cceafa914410.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id Me1tdhdSba-Pkxqs8sr;
        Wed, 22 Sep 2021 08:25:46 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Wed, 22 Sep 2021 08:25:43 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [v3 01/10] RISC-V: Remove the current perf implementation
Message-ID: <20210922082543.71fc5619@redslave.neermore.group>
In-Reply-To: <238571632287002@mail.yandex.ru>
References: <20210910192757.2309100-1-atish.patra@wdc.com>
        <20210910192757.2309100-2-atish.patra@wdc.com>
        <238571632287002@mail.yandex.ru>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 22 Sep 2021 08:11:44 +0300
nikita.shubin@maquefel.me wrote:

> Hello Atish.
> =C2=A0
> 10.09.2021, 22:28, "Atish Patra" <atish.patra@wdc.com>:
>=20
> > The current perf implementation in RISC-V is not very useful as it
> > can not count any events other than cycle/instructions. Moreover,
> > perf record can not be used or the events can not be started or
> > stopped.
> >=20
> > Remove the implementation now for a better platform driver in future
> > that will implement most of the missing functionality.
> Your v3 version still breaks the build with CONFIG_BPF_SYSCALL
> enabled:=20
> kernel/events/core.c: In function 'bpf_overflow_handler':
> kernel/events/core.c:9914:18: error: assignment to
> 'bpf_user_pt_regs_t *' {aka 'struct user_regs_struct *'} from
> incompatible pointer type 'struct pt_regs *'
> [-Werror=3Dincompatible-pointer-types] 9914 | =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ctx.regs =3D
> perf_arch_bpf_user_pt_regs(regs); | =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^=20

Sorry for the noise.

Everything complies fine - i mistaken and applied older version again.=20

> Yours,
> Nikita Shubin.
>=20

