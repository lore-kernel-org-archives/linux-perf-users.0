Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435C7C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Jun 2022 17:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiFXRBX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiFXRBW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Jun 2022 13:01:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ACC62C01
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jun 2022 10:01:21 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id u9so5519124ybq.3
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jun 2022 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Jns4dsIe8eb094ZZ61J5I0GwrZpoyUPKckm9PMjM6A=;
        b=PLUzB92rTaw0yKzXR/fbqdnplZiu/04+Hcuj/qFWhBE5U7BXJBIHatMeX4obUVPbQS
         A4Bjtu0V4lRKjcan/QqiuPC4DL/T39L7jYp1vGwmbUJWDFHq4QCznjmPCi1ERCpuSmsv
         8NANYZrJIodQD6ZeyqP4fRMOU31B0gEhDwMNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Jns4dsIe8eb094ZZ61J5I0GwrZpoyUPKckm9PMjM6A=;
        b=7jhgUjGvKcsRI4K9FPJtmwdGUJDsdf45oqXT6EIJIyU3wK9aVbrt0NrcqKxtNu2HRU
         gjodoHxjxWHk1sxflWwZy/4rAk5siH5e33tcsNe+KLu3qhHFlpow640Z6QLSGrFyzErG
         H+5kUuUQu0oYPaBnOP1hiLLLtU+TIAQ5mGJeUTq3UJhAhZ4AYhkmjks0XODmKPrdDQrs
         NlQpdc1dHBGGrtTX3y8eESz87qcXN1oxnaUimHrGT0ODIusQx/KDyyM/cDh7SQ11qjes
         oBJhWcVjGrb5NW58xEPp5/XZXnYIqOoAX/jn1f8TQuSV8yDhVFNwCQPm9sD2BosF3SaH
         e9pw==
X-Gm-Message-State: AJIora9LckRN5IY+HU9o8AN1T8yvzfeAQZIhYE//v7tXNdr6RkLbyd9t
        uy3ZGrIQdRZOPBMI9jYruluGOTPewGsq67QSFpbC
X-Google-Smtp-Source: AGRyM1vBM6wzRqtQPsY/GBTxWhWMVAPeZO7wStS8yWUZs4AjrmBSarknA+yzpWkGvpKLGaRxqyMdQFgQtOsHyHWrBc4=
X-Received: by 2002:a5b:c4:0:b0:669:15d4:8b68 with SMTP id d4-20020a5b00c4000000b0066915d48b68mr100443ybp.473.1656090080201;
 Fri, 24 Jun 2022 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220624160117.3206-1-nikita.shubin@maquefel.me> <20220624160117.3206-4-nikita.shubin@maquefel.me>
In-Reply-To: <20220624160117.3206-4-nikita.shubin@maquefel.me>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 24 Jun 2022 10:01:07 -0700
Message-ID: <CAOnJCU+B+dXXhqL6CYRG7Lhr_QWwyxrDZdGZG6HphnTEE9o5Mw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf arch events: riscv arch std event files
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Anup Patel <anup@brainfault.org>,
        =?UTF-8?B?Sm/Do28gTcOhcmlvIERvbWluZ29z?= 
        <joao.mario@tecnico.ulisboa.pt>, linux <linux@yadro.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 24, 2022 at 9:01 AM Nikita Shubin <nikita.shubin@maquefel.me> w=
rote:
>
> From: Nikita Shubin <n.shubin@yadro.com>
>
> cycles, time and instret counters are defined by RISC-V privileged
> spec and they should be available on any RISC-V implementation, epose the=
m
> to arch std event files, so they can be reused by particular PMU
> bindings.
>
> Derived-from-code-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.u=
lisboa.pt>
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>

Why do we need this ? The PMU driver already parses the standard perf event=
s.
So you can pass -e cycles -e instructions.

Even though time is described as a counter and accessibility
controlled by mcounteren, you can not start/stop it (no bit in
mcountinhibit).
Thus, it can't be used from perf.

> ---
>  .../pmu-events/arch/riscv/riscv-generic.json  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-generic.json
>
> diff --git a/tools/perf/pmu-events/arch/riscv/riscv-generic.json b/tools/=
perf/pmu-events/arch/riscv/riscv-generic.json
> new file mode 100644
> index 000000000000..a7ffbe87a0f7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/riscv-generic.json
> @@ -0,0 +1,20 @@
> +[
> +  {
> +    "PublicDescription": "CPU Cycles",
> +    "EventCode": "0x00",
> +    "EventName": "riscv_cycles",
> +    "BriefDescription": "CPU cycles RISC-V generic counter"
> +  },
> +  {
> +    "PublicDescription": "CPU Time",
> +    "EventCode": "0x01",
> +    "EventName": "riscv_time",
> +    "BriefDescription": "CPU time RISC-V generic counter"
> +  },
> +  {
> +    "PublicDescription": "CPU Instructions",
> +    "EventCode": "0x02",
> +    "EventName": "riscv_instret",
> +    "BriefDescription": "CPU retired instructions RISC-V generic counter=
"
> +  }
> +]
> --
> 2.35.1
>


--=20
Regards,
Atish
