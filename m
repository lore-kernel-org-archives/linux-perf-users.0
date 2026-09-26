Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F51DFFB
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790462865; cv=pass; b=PcQ5NnjA7Uknk7bHV7Xm8DPVmixV8qYTG0tvHgiOEWXwXbCQrLdJVcxWI1U9KE0U/HdZOqorgoBWAlD/ZZvsoTErdSh6pLBBUYRMIaLm632ISlkbKRjT7FMAZlw8EdweZNKMm1FngbzO95GwFpBGummuFHTylAt3JeDsjvyOodo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790462865; c=relaxed/simple;
	bh=/SAuPxmP3YRag5UnfnqJuuo5uQMonUx2h/RhunaOorM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5uw6RmgTfq4C+NRdWONRDQCy0L/QqNEwspKW4uH50jFlcm4z+6Uaj1YQov74e6tiWGk9nfV6QWRxzRwCm1ukBRsLI4KO8CoDVyar++wjgXhfXgb/xfBVKZuTaw89QJgB73gJqJE4vUfzSAM9r5grm5T+WqkCO9ly1PSgRw+vQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvAI1zRP; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvAI1zRP"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53113d72966so165141cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 15:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790462863; cv=none;
        d=google.com; s=arc-20260327;
        b=PinPVfSf7DrRB6CVz6NqtCPG9rbo51D20xWszjmufMP64AjgIriBFG4GOE4twFGQ5E
         30cVvGRgZ+PrVGJTOO3IjCiGLKKX6eQkQk9upOYQL14I4TLb5QO3+/AQ/0P0qiRNRQvI
         509/4BlL2orqlfNBcPSednPUXGOkmuS8AUWCgEHKH8KAfMDV8ihmDIyEchwHoeyc82Hu
         TB7IpbxU6H7WvIF62ZsziaApqoDwiAr0s3rA+TfVTkB79x4mkjaajNlZURYa6IeDJ+e1
         5RRES7ZUdJ8e2mTFDc7J2jORXRlipTbMPKXDhur4p7GXi8aTHFmxiqFDSW8JQYui3Ynj
         E86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XemkzGIt/BfBHHj+ls/O2WO7JmWM4hQedDYVYfzYN9s=;
        fh=qf4Dck0NBfehNtb6AUA8pU1fSTX0VSWPG7lKbZCOOnA=;
        b=OjpKpHnenyJyJQbOvdWTd82t1Nc3jx5tVF1PKgOziqW/mlhlgDGOgx/iJnubU5LG0w
         eA2csXaU7uSx7AMbyYBQZKhdHxGTaAwf4g4Raff/VuUquGeUOKakpNyt3uOQgu6hXSf2
         OMGcxGP5jqUkOrFxHG/FCsH8RcMHc4lVRk8sI1fXmqm4SMnjrkX9uhKLxc3k2DbR1ymf
         5m6Kj4paD5hU2R+wH3x2W76+D1uHv7NTpF1lU22HQoTw9GTwFHVQaF0UddM8XKVKGYlR
         Z3g+vjHXGthrpWfsJXROqlNRCshDItpxXUHtdtMJU10CoktMa/jzmaVVY/ZbMo+lEnL6
         MU8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790462863; x=1791067663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XemkzGIt/BfBHHj+ls/O2WO7JmWM4hQedDYVYfzYN9s=;
        b=vvAI1zRPLRCklydjRULlW1r9wB1agadUesC6Xi5H/eEW5gNCR4BVM0e+oS0GbQy63I
         NtSLxvRvQLatzQ9vJ+Z3zS5/5TLHS9q5w51cCv2GKXEJpUvkGun5yVt2qIvpEWlIZYAX
         0wVyBo8knTCjhlOqHcVdpCJvgPutwv4y6mdusHXoyiHjBeS9bNrVSP+3bdHLkxrKbYgS
         HATdUvQnXJwn6AVtQZs7Z4v+Xx4K74E+pAKx10Wtcn7LP/f1KjeRBfEnjwNlBSYK9yci
         tZK4IeqbRBbJQziQPx7AaUxDJnsPBmTD2FJ2Nc+Igvgdk1AA3TBPNeD2GFQijwEUBmK6
         aAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790462863; x=1791067663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XemkzGIt/BfBHHj+ls/O2WO7JmWM4hQedDYVYfzYN9s=;
        b=2SZDjkrV8USPphys5lK9edS3NipQdeSbUYPjUHXEhILbzpntTGA5t2yzQHViBs+CeS
         KXxz2oDWjLFoqfvFli4HTTiqd71Lf8hErKQvAKubylOsc8qWl0dXlThVYeVVS424Lp6a
         tTjUcc3msv8vE4LlmEjT4/eu1RRcxxLBabFl51ECSLlbk27HAMYOpboc4xPt3XWWWG3U
         Q4i/sQSjEcAexQpWEbQ3w0/LO4+gVV9qd2aoVYCtUXfh2NnZ3Zuplp45uikphfgZ3btc
         2nkMocn3PVKswH+ctJFEQFfurt66J5oURGx4f1vOntS+kRkoIA3cWnktfAHGepSJmc1N
         YQMg==
X-Gm-Message-State: AFuF++kce8IV5oIkMAVYTH6n78uZutjZCPG7L+4hrD3HoIB/EEErrF9y
	dQKpXgz2BhTr402ka3qzzOGL+O9DPAfgmUxHnLPudZqNTh6Of8o12ZNv7H9fwiOcFPgX5978tSN
	WH0ukPdpS0XIL7tSoj7wH7LE+4ZwZv6yYO30L1vA6
X-Gm-Gg: AYBFou1f9jOqMm1zgMFMi6bmRyqPXJDYP4Q4qw6GVgPzISeRup3wqy8caD2QaUlR9uM
	I2adgxnTJAJrJwazXg8EKhdSCw5pOynPO5y4YqOfbZoFQAlzc0xyCsNMDnL17ULflr+AYIfB5xQ
	OS+BVHIh1lixGRgW61sen7g6zTU/OyabCTFXBlw/bkCUO4SEJVZdy48aK+Lpwz87bpcEZpLBAPu
	vpv+vwUONjSdA4Ko/Ziw00wMc6AXgDXAR1RenG/n8QrGN16saPKWOHMbG1RpuZHOIjbuGkuIJei
	SsyZjYhHFheC0dUj08n55/5c7wUJqADHu4jThFEgK/vou4/xHsTislq0unLisK9rXcM=
X-Received: by 2002:a05:622a:411:b0:531:16a:5a3d with SMTP id
 d75a77b69052e-5332017da1fmr14084341cf.12.1790462862716; Sat, 26 Sep 2026
 15:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <argr21X4JoSl1O2W@x2>
In-Reply-To: <argr21X4JoSl1O2W@x2>
From: Ian Rogers <irogers@google.com>
Date: Sat, 26 Sep 2026 15:47:31 -0700
X-Gm-Features: AclHuK9KZ82Jz51z8jpa4zDAk0MD9sk5jfvyH8p2hZS8jyjNrnf3AZSOn3de_Fg
Message-ID: <CAP-5=fXtC3wWrw6TKt433bdfBTEo_JL5uJ=USuTtqM60KBXE6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf timechart: Remove the unused use_old_power_events
 variable
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 1:32=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> It is set once and never read: its only reader went away in
> 20c457b8587bee46 ("perf timechart: Adjust perf timechart to the new power
> events") and nothing used it since, so the assignment was dead code for
> 13 years.
>
> clang 23 extends -Wunused-but-set-variable to file-scope variables with
> internal linkage, under the new -Wunused-but-set-global subgroup, and
> with the -Werror that perf uses by default that turns the dead
> assignment into a build error:
>
>   builtin-timechart.c:355:12: error: variable 'use_old_power_events' set =
but not used
>       [-Werror,-Wunused-but-set-global]
>
> as seen building with clang 23.1.1 on Fedora 45 and rawhide, where gcc,
> older clang and clang without -Werror all keep building it.
>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-timechart.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 3f9153d5ecfb79b0..3d88c90c6573bf88 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -351,10 +351,6 @@ static int process_exit_event(const struct perf_tool=
 *tool,
>         return 0;
>  }
>
> -#ifdef SUPPORT_OLD_POWER_EVENTS
> -static int use_old_power_events;
> -#endif
> -
>  static void c_state_start(int cpu, u64 timestamp, int state)
>  {
>         cpus_cstate_start_times[cpu] =3D timestamp;
> @@ -1943,7 +1939,6 @@ static int timechart__record(struct timechart *tcha=
rt, int argc, const char **ar
>  #ifdef SUPPORT_OLD_POWER_EVENTS
>         if (!is_valid_tracepoint("power:cpu_idle") &&
>             is_valid_tracepoint("power:power_start")) {
> -               use_old_power_events =3D 1;
>                 power_args_nr =3D 0;
>         } else {
>                 old_power_args_nr =3D 0;
> --
> 2.53.0
>
