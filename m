Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2453363C6B
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662776; cv=pass; b=toe8QlpD4/MGqBOAJ2hzT66MZckOSnNI5OtnLDhwo+LLMi7vGEnv7uB+O4ICMuqupA/WbPUD4/lW+47EexP6pb9IZLaGti+B8mphHEUrKkB737/xPJGE4r5zx2l3Xkz0v2xtPgmJAnQ4Hg2grLZB4jTg0OV90RljrhbLrD7TUsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662776; c=relaxed/simple;
	bh=Hg7w14jt1F0BEbq76nmUIz8HW5xdv1u3AHru2kRzO+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVxiMhd+A8ENUwX5kwFsD8/FE4TvKZqDJOnmMyUS/2RAXTlOYeyE1wp9VK1Z0Gru46nUi+p2fLWBc2wOwyIuFY/g/QVFC9UOExP7skwUZEli0dF9sixw0mVBTZRC+cWtWhB597MFP18+yE35a52XQPbiuazFrZyJqLqFVM5u2+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYX4XEgP; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYX4XEgP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b243198058so14385ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 12:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777662774; cv=none;
        d=google.com; s=arc-20240605;
        b=graxaCSbzo+gG6WhDqbhybA4QLjQHvNyUs5g1oRR4pxGl2DAX5USPv5+NQXg2UDe6N
         tvmriXtmJwrE3YAQwUMMnYcUu5MgjYqhYhJaa11FLFsbXYf2LVAkTEFYFGJZ0iF0jsva
         2dAzZpw118PbhDXQv0jsV9PX/lnmc4saXSBRoOFC4ABSxsPMdymkLPyLRrsGd1Nb/+h9
         QgOYb+3fe4FiHzrf9xGsoeZi9Jf8E1F8knbfsDu5t/OE+iTuVb0dyRcZgogQYCeSpH2a
         z/CYRLGHDQhuttdKgX9goFEqI3isEjOg7Y3IYdJMCA+smEluijp4McsyOBtEZdYcuOQ0
         m8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JM8OSr2jmiFIhx5eNDcaVcj0uISR0E7SUrdgfThBDGQ=;
        fh=PG6ypKM5H76I1182pbatFe4vJfICXJCaT1vHhCe6RU0=;
        b=OIAjPeRxSBb+Z76uwgZD4vBZHvVYPmp4UQuf0005sjruuXr41osaJrnCU7YWMuwxdi
         4q2a+qHnH9r0hZrkVtFVjGymvaGNPI1/pypxwziaBuqH7t/p1o/Rp/bPMGX8n7whPuoz
         +9xouSTXtDtGbR7FLruh6Bu1udsStm5/pgI5ddgT75btONZ5y6MEZaCaKWGwfR6rJViO
         ou5PjpkwvMc8IuV/i8MHktGCdVQrfm4Ow8K/BKTipzjB1HkTDTXjTjJt9c/7SHLIQC3M
         RIOZzPTqmOOTHU3YOr8jb16uPdYOL1hPv8gnZRf9yqN1XfkniN0cY95oBQ/l08ZiB8L4
         74Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777662774; x=1778267574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM8OSr2jmiFIhx5eNDcaVcj0uISR0E7SUrdgfThBDGQ=;
        b=DYX4XEgPSBfyjftMq0/+itGnN/CvToPpPHbmB+XyuHqJQ7NRKUoVTdO0exR1SwJJsC
         cI/HHNIOdB5hR9LNQj6a3qyW4j1/aKuCUVd8Xy7dytpom9W8aMXs2gvOxMqxtfVN6z2n
         xCyo4jhLdWVdu5KETQXz9AfD10ftSwBUrjlWwV1mSyKYoC0t2Mzy4M60QF8mq5k9AT5U
         7dbHD+DY79tnVHNQIRdnf9Maa9ijyivnCpMTA+IxxNjzyGY0RSoSBwH/kzot3Z80WcNp
         8rC9zBczCgYarMvCQTMkB1bbuafjGXGhLT9h8o/Mo8mBMUKOp22eC9mmfcrcMRAG7pQk
         tYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662774; x=1778267574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JM8OSr2jmiFIhx5eNDcaVcj0uISR0E7SUrdgfThBDGQ=;
        b=A3HSL0DBNFm2fCXBDDuecVk7aorMT6WepWcBA5VUX2+nFme2aVg4U3oSEtl/ewsfrf
         woxHbiCm1MpGnbeoFmxUP4HfmcYat4bNyGznkMJRkOLoRI8rOTBa5uR3NXiaNi3Qbybs
         xGdUcEX0C5UNPq6E2sP9R7/v73tc5erbSpvlB2p02k3xAy+9i8fb2eLjBpuvtA4JgbkE
         5RBVJhLcJ9cC18IPFoKdCIibFQo7ALPmn6KoM8fLrAr4mXIM/HifT43cE5kphtx8Ld+u
         M7CdIRbjdR2B6bB5llWXLlMvQIcVPaiIIWYzbr4APxb/sG1GJHJDXCO969H4UB6aXX2S
         Ky6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ZJE41SHCoV1QeKSJS4IFhUCfSTiUr680Iwfsefyi2JyuAxRG9gczh7F7j+1JM9+MJrA8xC/n1FrB9IBrygbo7@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXnX3t1srKILLpJgp07V9CzzY0xtF7IzmrIHmot6eWy2C4BwG
	CfhT1UMaHQ8YI6tqr8dfrwI5sdILVbyK0hKlGXlyqtFnIl7uugnOggYlql68AvstitrRbpd4aCx
	Y8IZs5LTiv+nKvm+OT6Xwld0CxKNj7JOmC8VRUH42
X-Gm-Gg: AeBDiesOA6uZj432PPLfA1QAuiaFUUhomZIJPd14uq4Bfm1LLlDov7IkkBcZYVhRMFL
	v5pAIV1xeVN6LdmhF8RCU9xheaFJc7KNfodc18vhUvGSrci3Zr+N7i0VGfbFoK/mQXYv+a96Wm/
	3bThnbHnv1/pEd7kQDrKREzOq90QE/ixIIVXG9uHB8YHVHqDvQNDLo89UOrCi07pF1Ag0WCClDj
	0azPDFa0OncTJFbtrdrSTvmEnMIHrLdlrC6bdOteBqf3Y5HoGR9sqf8llPEbKpURdnGXJNvjXs/
	Z5k0bVAR62NmezG3qR3vxJeyA9fgKLB2Gh4qv9rpIdUgSraYjBSDQiHzZ9A=
X-Received: by 2002:a17:902:e74f:b0:2b0:b0c9:96e2 with SMTP id
 d9443c01a7336-2b9f38fe0d1mr543805ad.21.1777662773428; Fri, 01 May 2026
 12:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501181129.938256-1-ctshao@google.com>
In-Reply-To: <20260501181129.938256-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 May 2026 12:12:42 -0700
X-Gm-Features: AVHnY4KoU0LeDiCv5XsNCCmE8wdqIiYayEuZ53CSX5ghkJVyaBmzpk1EWPg0R6k
Message-ID: <CAP-5=fXbvOWgwWs_TD4rfWpN70YAuoxfbFUTEwtpEJv6btoXuw@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Check aliases in should_skip_zero_counter
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 11:11=E2=80=AFAM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Aggregation IDs (e.g. sockets, caches) with event zero counts are hidden
> in aggregated modes (like `--per-socket`) because alias merging
> aggregates counts but not CPU maps. This causes display logic to skip
> aggregation IDs not present in the leader's map.
>
> Instead of mutating CPU maps in `evsel__merge_aggr_counters` (which
> could have side effects on shared CPU maps), check aliases in
> `should_skip_zero_counter` to ensure all applicable aggregation IDs are
> displayed.
>
> Before the fix:
>   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
>
>    Performance counter stats for 'system wide':
>
>   S0       12                  0      amd_umc/config=3D0xff/
>
>          1.000721604 seconds time elapsed
>
> After the fix:
>   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
>
>    Performance counter stats for 'system wide':
>
>   S0       12                  0      amd_umc/config=3D0xff/
>   S1       12                  0      amd_umc/config=3D0xff/
>
>          1.000879376 seconds time elapsed

Does this change the behavior without --per-socket when the uncore
PMUs have different cpumasks?

> `perf test` looks good too.
>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/util/stat-display.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 993f4c4b8f44..c12a3405118a 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -945,6 +945,27 @@ static bool should_skip_zero_counter(struct perf_sta=
t_config *config,
>                 if (aggr_cpu_id__equal(id, &own_id))
>                         return false;
>         }
> +
> +       /*
> +        * If the counter is a leader in alias merging, check if the aggr=
 id
> +        * matches any of its aliases.

Could you expand why in this case we want the zero count?

> +        */
> +       if (config->aggr_mode !=3D AGGR_NONE && counter->first_wildcard_m=
atch =3D=3D NULL) {
> +               struct evsel *alias;
> +
> +               evlist__for_each_entry(counter->evlist, alias) {
> +                       if (alias->first_wildcard_match =3D=3D counter) {

Could this also have a "&& !perf_cpu_map__equal(counter->core.cpu,
alias->core.cpus)" ? ie if the alias' cpumask matches that of the
counter, then the loop above covers it. Perhaps the cpumaps of each
alias could be merged and the test only run if their intersection is
not empty.

> +                               perf_cpu_map__for_each_cpu(cpu, idx, alia=
s->core.cpus) {
> +                                       struct aggr_cpu_id own_id =3D
> +                                               config->aggr_get_id(confi=
g, cpu);

Could this fit on one line?

Thanks,
Ian

> +
> +                                       if (aggr_cpu_id__equal(id, &own_i=
d))
> +                                               return false;
> +                               }
> +                       }
> +               }
> +       }
> +
>         return true;
>  }
>
> --
> 2.54.0.545.g6539524ca2-goog
>
