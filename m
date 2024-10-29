Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4EE1946C3
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215563; cv=none; b=gUBikrD0nQ2eWm7TPuSK1bsmBz2APEDUBbO6sD9zlQPnegD6/1zMNnnAgAZK2/jU6sE1sQoudZHDdcWb04l6OoicmWCmzq6fmLtynqTdsXtf/WiA/kw+d07NpreLH6WqyaJld2o8F5dmlwCMeYKLxht3z5/kCEwj3kX0xGZE6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215563; c=relaxed/simple;
	bh=mSg29KZw+GOimcMkuIU6s6KhSVXuo7YNDY8XrBlkOEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxlSOR9xpbBwOBf/UwG92APJqmelasIrYd2pGm1NV/vWj7sPoNWgq9coln8sViKbHVhQPn8n9WA4IPeXFkenAnvcOVy3FXhsyDaajGaG3/yQUIacpbmEST94KN/pF2CzqCwx9BpMl5mfVAQiGyVk1vEDCxCPdxA8ry0rFgvOYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sCxamihW; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCxamihW"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so179205ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730215560; x=1730820360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbldlQCFGYCFcl+t52QFfn7I9GA9OY/QsBJTXt81BAA=;
        b=sCxamihW+oreDBDzWlOZbpXYfY7MXS03/MvNs0gd1HL1/PYAfZvoopL6iz1a2qGmUN
         lv/fJ073tPxkVIz3Yicl6L2yUnXYc1VZ8rw07br4FrqsF6HpPcgdpXnhYFI+KtpSgrz7
         4kIbvLXuNJ2/RmJZRbG954JWy6KS0irFxIyVD1USHvZ19YlXlTqTlynH/LXypn8xhBA7
         MrcWM8Z6JV1lhenC72rMc/38F2Kd1kCn3l90L1WxVlABCQtXs+jY2ScKMI3yyurR2HwI
         JCy10eQ6OVpgEX91dkrUFwsK3P9knb9S1G37JkF9ckldXdANGDT1wkTG5nYiixn4V4mh
         HSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730215560; x=1730820360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbldlQCFGYCFcl+t52QFfn7I9GA9OY/QsBJTXt81BAA=;
        b=ifWR8AMWMuS5StbzUlsNYGSIi4921h/q3nOLLlW1M7Vdtm92grKG3Y9o2DXrntB+rU
         oj7Fumaq40v3H2YbXpaHbSOvrE/7X+MUV0opiQUL3DPwrDD8M4YOE1lLqzBdjdBVwrjF
         ne3IlNsGVZF+qj1NXXKW/QCUcENsEkaOBc1SbQlYY9BvxAo45V1gIjPQ6FunfN/7aZuw
         9pzdOLfWU5b/QDthcc6jN16ZEpMvUkCwckAaeGFA5CLsUFFzKObdd9KIuSE4Cy4nnJ3D
         Z1g0HV02Ct8WvIHTCV/WbJVM6UKYt2ubrcEDrDHqQFvUklVBa6LDb04Hju9Xc2tC6IRk
         kfZw==
X-Gm-Message-State: AOJu0YyFke5jrDydMD1MdQcb0AaegswkK7giHCgNSxmE7iU9tk8oBE+F
	NbUwJharn/UI62iC10Q+SA30YhJqaYLNyzcPbL+B2oQk83QtiNukgk/7vO8Lnd2yuWq8+j5wzLl
	6KFFAaUQN2pYYxJnPs06AAcurfhGsYnMwTcv/xCI/AghfwSVn1MGIId0=
X-Gm-Gg: ASbGncv8rSH+nMEkkOt0oQQLzKzUfzwHcJdH4cpe1m00j2IpmWtv6pJz+aAV5LT1+fL
	WdKxS3FLuJ6Em65SZA6ZwUBmdzrtbx74+BHjb9aA07oHB4/+T8JmL0U524uit2lmB
X-Google-Smtp-Source: AGHT+IFvrmt/FS7+vhebrqGGHEMe/yzuAr4QA+ywuAtV+Y2wTfuY7IkOdY6/yV/Uxztv6DejR2Br275D6zUjVMisJbE=
X-Received: by 2002:a05:6e02:3d88:b0:3a0:9f85:d74a with SMTP id
 e9e14a558f8ab-3a509beefb2mr4104595ab.14.1730215560106; Tue, 29 Oct 2024
 08:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029144347.25651-1-vmolnaro@redhat.com>
In-Reply-To: <20241029144347.25651-1-vmolnaro@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 29 Oct 2024 08:25:46 -0700
Message-ID: <CAP-5=fWAH1qzLrFhVjrJBu33NSfqktM30thUohC-zA+94_sf_g@mail.gmail.com>
Subject: Re: [PATCH] perf test: Parse perf stat Topdown events for aarch64
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
	mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.co, kan.liang@linux.intel.com, 
	yangyicong@hisilicon.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 7:44=E2=80=AFAM <vmolnaro@redhat.com> wrote:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> The 'perf stat' output on aarch64 machines with topdown events wasn't
> counted for in the 'perf stat STD output linter' test case. Add the
> topdown metric to the skip_metric list as it is done for topdown events
> on other systems.
>
> The Topdown events are also disabled on aarch64 KVM guests because the
> value of caps/slots is set to 0 due to the part of the system register
> being a stub. This prevents the metric for the topdown events from being
> computed, leaving the 'perf stat' topdown metric without any value at
> all. Add the "TopdownL1" to the skip_metric list as well to handle this
> possibility.
>
> Before aarch64:
>
>     100: perf stat STD output linter:
>     --- start ---
>     test child forked, pid 403305
>     Checking STD output: no args Unknown event name in TopdownL1         =
        #      4.3 percent of slots  slots_lost_misspeculation_fraction
>     ---- end(-1) ----
>     100: perf stat STD output linter                                     =
: FAILED!
>
> Before aarch64 KVM:
>
>     100: perf stat STD output linter:
>     --- start ---
>     test child forked, pid 404671
>     Checking STD output: no args Unknown event name in TopdownL1
>     ---- end(-1) ----
>     100: perf stat STD output linter                                     =
: FAILED!
>
> After:
>
>     100: perf stat STD output linter:
>     --- start ---
>     test child forked, pid 404777
>     Checking STD output: no args [Success]
>     Checking STD output: system wide [Success]
>     Checking STD output: interval [Success]
>     Checking STD output: per thread [Success]
>     Checking STD output: per node [Success]
>     Checking STD output: system wide no aggregation [Success]
>     Checking STD output: per core [Success]
>     Checking STD output: per cache instance [Success]
>     Checking STD output: per cluster [Success]
>     Checking STD output: per die [Success]
>     Checking STD output: per socket [Success]
>     ---- end(0) ----
>     100: perf stat STD output linter                                     =
: Ok
>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>
> ---
>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> index cbf2894b2c846a04..0f7967be60afdc7d 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -13,7 +13,7 @@ stat_output=3D$(mktemp /tmp/__perf_test.stat_output.std=
.XXXXX)
>
>  event_name=3D(cpu-clock task-clock context-switches cpu-migrations page-=
faults stalled-cycles-frontend stalled-cycles-backend cycles instructions b=
ranches branch-misses)
>  event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "fr=
ontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of=
 all branches")
> -skip_metric=3D("stalled cycles per insn" "tma_" "retiring" "frontend_bou=
nd" "bad_speculation" "backend_bound")
> +skip_metric=3D("stalled cycles per insn" "tma_" "retiring" "frontend_bou=
nd" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")

I saw similar issues and sent:
https://lore.kernel.org/lkml/20240417183219.1208493-1-irogers@google.com/
but got distracted. A difference there is automating the generation of
the skip_metric list rather than hard coding it. Hard coding may be
the most pragmatic thing to do in the near term.

Thanks,
Ian

>  cleanup() {
>    rm -f "${stat_output}"
> --
> 2.43.0
>
