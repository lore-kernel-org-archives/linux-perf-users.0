Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D454C754A
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350405; cv=pass; b=fPOicy1w6NlMpIDJ8BP36FZAEIfKew/X0xPHscRYMXFAUgkPQ+0q7caXtyC3FW/rt75yrKg5oWaV2TGv29qKdh9Ru/5x1n45Z87gUlnzUWDSEA4GCABuCxasrCUmdK9ckHoa+6Bx7seWLnfkzP5W3pcqghxZJOfnyzEKgFu+0fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350405; c=relaxed/simple;
	bh=BTBoKRsKkhaIY8JcZ9+wHBG7cBrTi6LEsy1fpIQp3fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IyNn+oVqUt4u1Pk3eJ81gufPKfHPcfhePXbxSFzFbx+NAMrDjxunKavyR3yKfztjryDQ8zhb6aUqpkM3XDsIyWpY4nXM3/9IfwnaVYWI7J8CZcbFei+LTC0Lncn0aHB0+UTK84nEZJr6UkIlmkiYhJkxYr/SNEpmQ31F+cZFaJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGd4lK+4; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGd4lK+4"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-53113d72966so257331cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 08:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790350401; cv=none;
        d=google.com; s=arc-20260327;
        b=bv9nLlE7u+zf2nFuFCGSSWSrXgUDIcryVS4pquE0Esbok01pFl43olUYIo2qo16tI6
         UcrltKwsW4vv6JDeX+zsqfnJnhzntFjR4xrR2r3m1XuV8YiSamhU4NGti9mbw2PE1DpU
         419m7k4R+JlsPIrnA6ENR8xXTjvgW343o/PdXSCYjZ9oQFr9iU+bf3T640mdOYnYC6XS
         Et+uza5GGaNCiGxuwxaXg3TX+XHILFot7cy3eLKhMHK8I4DvH0x4OjE+qCkC8TiX9CyO
         CXRL59eQ5jFjUoaK5UTQWtqYNawTtzc3EmkvORdGsV3zICJmNqCwHz8feqv4wpL9SCsP
         fjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WspHH2q7IdJFzP5Ho9Zej6L2+bb6vQF0pB8bvL5RAhc=;
        fh=HTOpLHxzDaD18b9xf9gIOZQGt1LmvrX3F8T/lBHWjIA=;
        b=UX7arOmRt4OSf/H+CZGpPuf7lLpOH0ZciKD7Twn1wUI4ttCzTMPlEEB+xlllCAzfEY
         ytD2qqFZPvjlws+rfnpGKpp4NXayouq4QxhXl7qcFyxBEgrIm+sWrmIaBNR6Mu3YUNcp
         yMQkiFjus7hKfnev/LjwFqjHqeNBf7qc4qSsgGpT3zPpasbMTtFEadOw9O4OrmBfmPah
         07T1SCOoNh8jguKfsbypcRCD65huZr1aXPtCpUZAyWpU4iJSNkhbvZuFcgHfoCnB2dHp
         Jd8r2GYyBMPpShHIgW8aFT3NIVUSN4umK7VaAfxQeZPcwzJ8UUGpPk6VF9XO4fxvYD28
         V6pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790350401; x=1790955201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WspHH2q7IdJFzP5Ho9Zej6L2+bb6vQF0pB8bvL5RAhc=;
        b=lGd4lK+4BX/8Yrv+Y7eiHIFRENOEpbaL+HKEKgp0EU+yA2D8leochMbqvEwoere5AA
         Wv5NEKhwgzcaG0x7mWIaWZY4b3LKMxWQOdtGXTs+iLBiOXRJtYxObQ9LEVyaRR7U+gYB
         laRj8fxpY20QLVCo8m4hc2Q1hR5MgKCKNU1Swgzv9uGs/064GNXwtAdwoDWNv1F/jFI9
         bXiHW1WFxzoRcjJq+YWdeuJ1kQZ5q1TibJ7LY3Sfq9NaFEiNO7jR0sCTu8CuMZuf/ldU
         P4N/8i7oOn6NUcfhUnTop344v1F0WSIrUo2DFojX5Il2ACHDs7VpEaFWjOzGQETa2f4/
         KmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350401; x=1790955201;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WspHH2q7IdJFzP5Ho9Zej6L2+bb6vQF0pB8bvL5RAhc=;
        b=LPskCHQmFMDO5Y8yxtFv35TDPeu+18f0Sy8EaKGnJS+SyauPCnva97mHalQf3ymI8B
         YFCjgIcSgZcIT6GtNlV++EVduq18HTVhZYDnZDtsX/E7L4qwiWRTV8JVyCQEuAzbDJJq
         6H9j3H5PtIdo+IxGQ+UouqF5mJY1COLaIYhYGzTSns7u3K3wsj3/BoDajirmSnrRNwum
         yV9W94UkeOt6jGCLAQwsY3DXldvj7B0Cj18gsl+6KypF4y5S/g8yhJ/kY1JFrJXTOAVV
         97aWe0DurrxNkTYqIpxNAqMazJZ16qB0TlxgPrG+Zx/2P2uHreagUFpuO3jESKp496Ce
         bLtg==
X-Forwarded-Encrypted: i=1; AKwUvBx7pWKpW0NRoTP2SqNl2OkEE3roHmQO76ejCBSbcoRVQyQGLLrVNpxYn3K0L82RsQLjAX9JVo9rJ5usxZtmLDjH@vger.kernel.org
X-Gm-Message-State: AFuF++nf/r3FxUO8t9Oh/2CI8nfKIOUh78RujCpDSnvv0wCH8Mp5+qHw
	WSMd/XBEHVoz6KmTN8QYjlaAkj63NpmDPsTGqznBBQF2I3mJqTPXOi6CVGOP1UVzYZLhV8Eip9R
	oqLWaHOYsuKxxrZMMMnnUBELredw/vaJqiyEQqhCK
X-Gm-Gg: AYBFou3tbcMTg2urj2Aa8x1TbP2LjI+PGL5TxW4gcaj4q6DykpgWDsK1iukZblzfJcs
	vwfHKoW6UBDgfhM5aaCk44A2OUE5TIm5Yzu7T3jcbgs7q5/ZGh2EQEhL8rRZ/+kag6UsEsvwMDJ
	f+3UWt+HkQCbyRQJ9plV1R2qft2ceJduVe+JYfm4nggRvjeFg4zHOrbUSACtJ21uowCeBkuVGEn
	ix2OCr9R+QTmICdq97A3bVVu3dksUILkrVX+o9DItS6MJFZkEnhMyrRKytIXKhb8l96dzHnhube
	YMQWCst4O1syHNLaN8Py79J6SNg1qnfuKt5ViWc8HKY6SkpwcmF7lKh7bwt0SPyhXUXZA3nw48n
	aQ5sVCva1xg==
X-Received: by 2002:a05:622a:11c4:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-5331a787127mr4656621cf.2.1790350400731; Fri, 25 Sep 2026
 08:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917061312.820074-1-irogers@google.com>
In-Reply-To: <20260917061312.820074-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 08:33:08 -0700
X-Gm-Features: AclHuK9bHrGPf8FuyoHNYaQY6jmF3U-YBLL6uatLtXIzCa91FydxfPvQBlHCV1k
Message-ID: <CAP-5=fW36Momg+N_P4vU08Pd_t+8PGK_-KfEn9HZjLPM4UO8nA@mail.gmail.com>
Subject: Re: [PATCH v1] perf test: stat metrics cgroup strip possible slash
 from cgroup name
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:13=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> The grep to match cgroup name in metric output assumes no leading / on
> the cgroup name, however, cgroups in /proc/self/cgroup may have a
> leading /. Strip the / if it exists to avoid failures to match the
> cgroup name in the perf stat output.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/tests/shell/stat_metrics_cgrp.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tes=
ts/shell/stat_metrics_cgrp.sh
> index d4226ee0ae98..0728f48f21fa 100755
> --- a/tools/perf/tests/shell/stat_metrics_cgrp.sh
> +++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
> @@ -86,6 +86,13 @@ check_metric_reported()
>
>         for cgrp in "${cgrps[@]}"; do
>                 # Find metric lines for this cgroup
> +               case "$cgrp" in
> +                       /)  # The root cgroup, leave unchanged.
> +                         ;;
> +                       /*) # Strip any starting slashes.
> +                         cgrp=3D"${cgrp#/}"
> +                         ;;
> +               esac
>                 # We use exact cgroup match with surrounding commas
>                 local cgrp_lines
>                 cgrp_lines=3D$(echo "${output}" | grep -F ",${cgrp}," | g=
rep "insn_per_cycle" || true)
> --
> 2.55.0.1082.g2b9226bbc0-goog
>
