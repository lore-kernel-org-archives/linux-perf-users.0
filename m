Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA83090C5
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716619; cv=none; b=nnCzOpn8HjGB86otzwcNSw2mTqF8PY5raTd8L+qLPKkizjaosM4naZ5e3TFkHu5xoCIvjDtyOqC9M0PPISMvpL8C+ZIr7AB3oKb0Bp4UEmnPDhGnv6z/eYA99bR4rxuBF8/bfO39xlCBMcMKBPFVnTQ+TQ+oHg5vMvS4C7Ln10I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716619; c=relaxed/simple;
	bh=jSGjirC705ZoSgeoY8NVsjU5YUW3H8MsHo/rW970jQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XU5WZ16EM1xlnyXh0zEq3k5EEgZyl3Rug4R+igKakbd/4BqeJtzpe937+D5zbRA35SDWXxbGnm6ekhkvOZKf9+bsJnelehM5nB+K7JSLD+LDoM4nvtAwEVDpYWc6t3ShVirFDqNFr4qZH8aJr5GNN6LfQEMMvv12/TNzmqxqvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMZepH8q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMZepH8q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29852dafa7dso27975ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 15:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716617; x=1765321417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmrCeeeXyBA1F1x8ZNK1Luww66Bq9+ARbmD+a0qWdEo=;
        b=rMZepH8qOH1rmIAJ5BDaMpFDwqqhiE70KjGhkZrMiWcbrH5z9qaPlWFuSi2VSNOUme
         30ivpCiKvCCA9ad0LAsPKgpHIAZQMTzxRXhmxjpYTqBGt4vBK2yLWweY3+uB0s9uYoav
         Q0msfc3roT7Op6JFBrTuIDV/VQQoAa7+jBjjQg3jbTdXnNVQEZFZ69ggfoyv64dVCdiz
         FFUQbeMk3W9CqbCtQ5ZsQgf4lxoKuO+2M2MJyEVqcvHX4zjsRNRdJm8bmnYFJjv0epzn
         SoZc1S8v9kARpMsxh44UwYMufcl02oolzESmABSHUs0svb9PTdYfhALoem7W1olPPDiF
         lMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716617; x=1765321417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JmrCeeeXyBA1F1x8ZNK1Luww66Bq9+ARbmD+a0qWdEo=;
        b=ccb1ppsrdGxLHpuriBJekUADpKNVGxRS1y9miZpuw4Oz0NgThmf/hTImFuKKVUgi9V
         sWmNKsfC93OGVowfB+s/cAMmDDpw+HfGGGyUWhyMvtwe06Mi3O0uLVZRI/Zq2byDBDHW
         JvEcBbY8kjb0d/m2lq4LwLMTbPvyDA+fsHei+ToglFk+IvLMAzAFy8fZSILinsD7AHSS
         tLIC/knw28LF/LRVOHADtUU8BfC4q+eNo7Mmu1DWTa/C2moHdo05GCh5/4HNHV8tLWb0
         JQNXXaBbB9dj0775n2uPLmvYBJmfYlZEaJwjbfK2QDrekeGSMlkluJ+Sb0yoYr76hcbb
         p84w==
X-Forwarded-Encrypted: i=1; AJvYcCX/KXOQFYVuJQ3IFsBhRUyLp0CtR+ASNz9b4oC4+DCVp1Rjfm9xKO+wraSg+NgEdyH34xbYolXSNWOZC89iLhh+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9+FpyamKMJt6cntw49DPajAaMItilnk39X3exTyNc+Sds9tMk
	PFjNcYknN9aJtuAgA5nhvWKmAegFRFrCt9VOm56A8DrexU/RSZtMAGr6Ft1nnEAgEiB544MH1sm
	396dgHUgsFv/10S/v4dt87G28fsNjOoUvdL+0M/al
X-Gm-Gg: ASbGncuUmDx5A/TZkxnwjpndIT426r9QR3WSVWvdcMped+u/mbYM+xd8e0y92emzLq8
	fNQGQYB0buWkUCPe6IUQCy4N2q+V53U0s+4inu2RCnHk1RwAP4YrXA4rc051n3XX/naEosDR6pj
	aeYLMC0KjXoVoa+XZCMRq9AHgdgHs9yhRKHITcgWCWdJ+P492YlscnPONhKaG7vtWxPQQdwAKSr
	3pyeMXZHFrflZIffxno4oRowC7v2mvYvbgA/02iW7CBa7nTw46XuX3nlh9xTrIaiFf4QFosh6Bg
	luvJE+Y59jR2aZ2RZebjTTu5hlNJzBod5CE=
X-Google-Smtp-Source: AGHT+IFoOcFP+TqDeWm4QDxw87U8J+RxndUsrbxruykZaCESKBHLpDHeuc2WvOs0USOuzena3PSorWDyLWvNR38Bu60=
X-Received: by 2002:a17:902:ce90:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-29d662cb7c2mr1269675ad.2.1764716616455; Tue, 02 Dec 2025
 15:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202230131.998662-1-namhyung@kernel.org>
In-Reply-To: <20251202230131.998662-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 15:03:25 -0800
X-Gm-Features: AWmQ_bkedeFcskh-xj52UjucRYj4JoUXT5tAlrq1u_F1I7QrH5ZsEsVS9jcnyF4
Message-ID: <CAP-5=fVP8+U8P9j-ex_7YPDT-1funFnLAF0g5NhB9zJh7AK9fA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Remove a trailing newline in the event terms
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 3:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> So that it can show the correct encoding info in the JSON output.
>
>   $ perf list -j hw
>   [
>   {
>           "Unit": "cpu",
>           "Topic": "legacy hardware",
>           "EventName": "branch-instructions",
>           "EventType": "Kernel PMU event",
>           "BriefDescription": "Retired branch instructions [This event is=
 an alias of branches]",
>           "Encoding": "cpu/event=3D0xc4/"
>   },
>   ...
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 1b7c712d8f9902bb..956ea273c2c7805c 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -645,6 +645,8 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, =
const char *name,
>                         pr_err("Failed to read alias %s\n", name);
>                         return ret;
>                 }
> +               if (line_len >=3D 1 && alias->terms[line_len - 1] =3D=3D =
'\n')
> +                       alias->terms[line_len - 1] =3D '\0';
>         }
>         alias->name =3D strdup(name);
>         alias->desc =3D desc ? strdup(desc) : NULL;
> --
> 2.52.0.158.g65b55ccf14-goog
>
