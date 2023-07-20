Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC25EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 20 Jul 2023 15:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjGTPvI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 20 Jul 2023 11:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGTPvI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 20 Jul 2023 11:51:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09069114
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2023 08:51:07 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso356501cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jul 2023 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689868266; x=1690473066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YK0KVqgT80x9gtOq8ZA4JrTzkCJPsXRqm4bTuq2qlc=;
        b=Ux7AodmvVSgABqN8P9sESis9DMtsCCYYycRlF3jYnEXnLRqzslfx+efIH3YOOlY0V5
         xXMYjhh3QKN5JUMlxLaRoHULgvNR0gdfhl0RsOSpwLan84ipcIZWY9IKLff+elYshUEB
         dbU/Rq+bMdZ92ziIkBxmO21TQrdVA7M3LDPdqky2fIEDYRhoHWHEiK8ve6udyd4qlKlJ
         Ja3wf8udsBgNgKWc0BCGqnXey0COz3h6a+M127j54JftWLipcQthgFUTgajCGF44mfhk
         WNi1MK3PD2N9j4dxU6ZbgdLoM/DOQ3vMco7weu1xBemc9MXM91q6oqPeD7MZDxwXwnq0
         QnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689868266; x=1690473066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YK0KVqgT80x9gtOq8ZA4JrTzkCJPsXRqm4bTuq2qlc=;
        b=iCkNWU5f0NlkZ5Nz+pA9Yjk/yW9kd7g6Ub8Fara9dI/i+Bud/LQbun/KQV18D/Bja7
         8OKYpjNZPnv+iTF6mjccf54x834mMYVUkQs9WL/U0EhffWRXghmy4wuJzMi1KoZBQD7O
         VC1rOmSxHsprrqAqkVGCFI/J1gU4DtLXDQMOJOzEfCat81UTWWzaZbNbQThuyzoSvaun
         sfX7iRcN6+1B5m8ftxKTqH/f5lqiaOqU+1G+C0n6taF0G46OFLzoK8o79jIluqZOqaQS
         B0XJUXa9Qdc/QxlB8+vZ5JLKNPj3zsUl6aPG2z7nX0hKhUfJFXQuEALLbtf3ulAHywOR
         PhbQ==
X-Gm-Message-State: ABy/qLa4c/85sVOIv+vhR0PXNQidg7Vfl+7GL0IcJNNU/vh6FJIKG8GW
        1ZGY7cnOZAdfk9J6Bkvz6jRxdt9xpADa5fCRJtsIug==
X-Google-Smtp-Source: APBJJlEBDbt+lYzvGvMdMQJx6mphhH/41Ih+Sj4asX1FokH/uh8yfDLqFyjOqh05Q0xlYUlT0WwMUSay6wyjGUPP/y0=
X-Received: by 2002:a05:622a:101:b0:3f4:f0fd:fe7e with SMTP id
 u1-20020a05622a010100b003f4f0fdfe7emr231958qtw.3.1689868266021; Thu, 20 Jul
 2023 08:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748843.git.sandipan.das@amd.com> <a70b1ef6ab427b768f21401af280d235dd095412.1689748843.git.sandipan.das@amd.com>
 <CAP-5=fX1NQzus3MQapmBrdgEhDG4+XmawgytfugHHOKD0E-COg@mail.gmail.com> <fef0492b-60c3-70ea-c7f1-370bf2734fc3@amd.com>
In-Reply-To: <fef0492b-60c3-70ea-c7f1-370bf2734fc3@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Jul 2023 08:50:54 -0700
Message-ID: <CAP-5=fX=1t51+a9=Fj-xt4zyLw9OG44bu9wRdPsu2hPoh8cNZQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] perf vendor events amd: Add Zen 4 memory controller events
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 19, 2023 at 10:23=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> On 7/19/2023 9:42 PM, Ian Rogers wrote:
> > On Tue, Jul 18, 2023 at 11:58=E2=80=AFPM Sandipan Das <sandipan.das@amd=
.com> wrote:
> >>
> >> Make the jevents parser aware of the Unified Memory Controller (UMC) P=
MU
> >> and add events taken from Section 8.2.1 "UMC Performance Monitor Event=
s"
> >> of the Processor Programming Reference (PPR) for AMD Family 19h Model =
11h
> >> processors. The events capture UMC command activity such as CAS, ACTIV=
ATE,
> >> PRECHARGE etc. while the metrics derive data bus utilization and memor=
y
> >> bandwidth out of these events.
> >>
> >> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> >
> >> ---
> >>  .../arch/x86/amdzen4/memory-controller.json   | 101 +++++++++++++++++=
+
> >>  .../arch/x86/amdzen4/recommended.json         |  84 +++++++++++++++
> >>  tools/perf/pmu-events/jevents.py              |   2 +
> >>  3 files changed, 187 insertions(+)
> >>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-cont=
roller.json
> >>
> >> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.=
json b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
> >> new file mode 100644
> >> index 000000000000..55263e5e4f69
> >> --- /dev/null
> >> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
> >> @@ -0,0 +1,101 @@
> >> +[
> >> +  {
> >> +    "EventName": "umc_mem_clk",
> >> +    "PublicDescription": "Number of memory clock cycles.",
> >> +    "EventCode": "0x00",
> >> +    "PerPkg": "1",
> >> +    "Unit": "UMCPMC"
> >
> > nit: Why use UMCPMC and then rewrite to amd_umc, why not just use "amd_=
umc" ?
> >
>
> I followed the convention that has been historically used for AMD uncore =
PMUs e.g.
> the "Unit" for amd_df is "DFPMC" and for amd_l3 is "L3PMC". I do agree th=
at its
> simpler to use the same naming so will change this. If you prefer, I can =
send out
> a separate patch to change the unit naming for amd_df and amd_l3.

Thanks for the explanation. I don't mind but it is nicer to have fewer
renames imo. If we get rid of one, perhaps we can get rid of them all?
Perhaps merge this and follow up with simplification.

Thanks,
Ian

> - Sandipan
>
