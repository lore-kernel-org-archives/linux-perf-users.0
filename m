Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D34FC77B78
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 May 2023 17:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjEDRZw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 May 2023 13:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEDRZv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 May 2023 13:25:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80E449C
        for <linux-perf-users@vger.kernel.org>; Thu,  4 May 2023 10:25:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-95f4c5cb755so135673466b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 10:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683221149; x=1685813149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcRi0OT1PHOb52J7+pfe7c0giAH6vTm1G5lOY/4eLy8=;
        b=CZUeay9KmIpxmvT92te1g7tEn9Xl5R6m+Vvl9GmmyRtdEK1Owtwl8HtvfLnN0pC020
         NiXyIpB0BlsYjgdv5U5Bf2/VpqY5u2n1Yu/bzHP0btBkoV2zd5r0dQrYjALm2BLtVrf4
         IjB/LsxIM2IdJ1grCg0purYszkhGnDKRI/VPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683221149; x=1685813149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcRi0OT1PHOb52J7+pfe7c0giAH6vTm1G5lOY/4eLy8=;
        b=K8Nk/EyBaNGvwyYDBbSHT+G3j4M3whAMhYANnbMCVi2tmyLRX4dORzNHRESVwDfyEg
         jLZ2WmRbouMO/qTmDngK5e44HvjSmsYFOeZRX2EfUPcdrW3fki7b0Cm3yrd8cqTWRAcF
         fN0Fuduvk55u9EePWcd6HL9qRDUL5tZJIkRztBcxbjwLziu84chH0XCvtlyV+G0xthi8
         EBB+C3n/xCiXsHSlEjS/ehxBABdPFrTaxWfQ7fypN998fqnACBDxxAuzYRR0yQ+adrbv
         6xRhfkbBYUxn7g4BmDmchSaN1hjFGZY5wgE6SC6qO09LDOCb4wtlZEQ6bmZCwnkjbo2f
         CaQQ==
X-Gm-Message-State: AC+VfDwL+NIk9mVkmrLWMHh8LtOKRHWaQqJvN4Aih8b/PqbdJSCo8qCG
        ONtse3EArR4CkynZqaktkB41pOOQp5sR3SVyV/x9GWLp
X-Google-Smtp-Source: ACHHUZ40UgrSr0/4duGrMA8HunztA4JdXCGaD1w9ApurcF23Vet79SMGpTt9U/3Qw/xLwWtA8kq0dQ==
X-Received: by 2002:a17:907:9288:b0:953:3e29:f35c with SMTP id bw8-20020a170907928800b009533e29f35cmr6804584ejc.45.1683221149064;
        Thu, 04 May 2023 10:25:49 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id ia22-20020a170907a07600b0096595cc0810sm1675435ejc.72.2023.05.04.10.25.48
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:25:48 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso1494404a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 May 2023 10:25:48 -0700 (PDT)
X-Received: by 2002:a17:907:984:b0:94f:9acc:65c9 with SMTP id
 bf4-20020a170907098400b0094f9acc65c9mr6254599ejc.66.1683221148020; Thu, 04
 May 2023 10:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230503211801.897735-1-acme@kernel.org> <CAHk-=wjY_3cBELRSLMpqCt6Eb71Qei2agfKSNsrr5KcpdEQCaA@mail.gmail.com>
 <CAHk-=wgci+OTRacQZcvvapRcWkoiTFJ=VTe_JYtabGgZ9refmg@mail.gmail.com> <ZFOSUab5XEJD0kxj@kernel.org>
In-Reply-To: <ZFOSUab5XEJD0kxj@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 May 2023 10:25:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
Message-ID: <CAHk-=wgv1sKTdLWPC7XR1Px=pDNrDPDTKdX-T_2AQOwgkpWB2A@mail.gmail.com>
Subject: Re: BPF skels in perf .Re: [GIT PULL] perf tools changes for v6.4
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Roman Lozko <lozko.roma@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 4, 2023 at 4:09=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>>
> Does building runqslower works for you in this same environment where
> building perf failed?

I don't know, and I don't care. I've never used that thing, and I'm
not going to.

And it's irrelevant. Two wrongs do not make a right.

I'm going to ignore perf tools pulls going forward if this is the kind
of argument for garbage that you use.

Because a billion flies *can* be wrong.

           Linus
