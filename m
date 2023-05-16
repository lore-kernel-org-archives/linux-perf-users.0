Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A01C77B7A
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 May 2023 07:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjEPHc2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 May 2023 03:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjEPHc1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 May 2023 03:32:27 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA3244B6;
        Tue, 16 May 2023 00:32:25 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a716:0:640:8b36:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 579785EA23;
        Tue, 16 May 2023 10:32:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id IWV7H95W0Gk0-2hQZJWns;
        Tue, 16 May 2023 10:32:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1684222340;
        bh=MFjNdJMYyp7CuQaOvoVqnCB28BDnLblM6oVyHYcfyno=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=TnZzKCBtKXwa5wyHOdpB5g/glPTYIxg4OJtlOKqpf4lyTmj+eyPJuPQ3ZIDNyVidW
         MJvKxuPFmhvV2zgFsaVyHLr11/DCItE+6NhakoZhBl5IqJCv0e5cQ9s6ZNk5ASVZoI
         lBr2xnRw1xeOl7LLoOP0/cOmLJ9fkmQrG/OoKr6Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <df1ffa574ca014cf5e23b3482efc5a7f432948af.camel@maquefel.me>
Subject: Re: [PATCH 0/2] perf: add T-HEAD C9xx series cpu support
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Inochi Amaoto <inochiama@outlook.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Nikita Shubin <n.shubin@yadro.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 16 May 2023 13:32:20 +0300
In-Reply-To: <IA1PR20MB49539201E93DE46A9A2A8E74BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49539201E93DE46A9A2A8E74BB799@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Inochi Amaoto!

Thank you for your series!

Could you also provide HPM device tree bindings which were used in
OpenSBI for testing in cover letter ?

On Tue, 2023-05-16 at 10:37 +0800, Inochi Amaoto wrote:
> The T-HEAD C9xx series cpu is a series of riscv CPU IP. As this IP
> was
> proposed before the current riscv event standard. It has a non-
> standard
> events encoding for perf events and unimplemented MARCH and MIMP CSR.
> This patch add these events to support C9xx cpus.
>=20
> AFAIK, at least the following chips used C9xx cpu.
>=20
> * Allwinner D1 (C906)
> * T-HEAD th1520 (C910)
> * Sophgo mango (C920)
>=20
> Inochi Amaoto (2):
> =C2=A0 perf tools riscv: Allow get_cpuid return empty MARCH and MIMP
> =C2=A0 perf vendor events riscv: add T-HEAD C9xx JSON file
>=20
> =C2=A0tools/perf/arch/riscv/util/header.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +-
> =C2=A0tools/perf/pmu-events/arch/riscv/mapfile.csv=C2=A0 |=C2=A0 1 +
> =C2=A0.../arch/riscv/t-head/c9xx/cache.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 67
> ++++++++++++++++++
> =C2=A0.../arch/riscv/t-head/c9xx/firmware.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 68
> +++++++++++++++++++
> =C2=A0.../arch/riscv/t-head/c9xx/instruction.json=C2=A0=C2=A0 | 22 ++++++
> =C2=A0.../arch/riscv/t-head/c9xx/microarch.json=C2=A0=C2=A0=C2=A0=C2=A0 |=
 42 ++++++++++++
> =C2=A06 files changed, 201 insertions(+), 6 deletions(-)
> =C2=A0create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/cache.json
> =C2=A0create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/firmware.json
> =C2=A0create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/instruction.json
> =C2=A0create mode 100644 tools/perf/pmu-events/arch/riscv/t-
> head/c9xx/microarch.json
>=20
> --
> 2.40.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

