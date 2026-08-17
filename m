Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D85379C23
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787002794; cv=pass; b=WUHn1Q9VrHvaa9KWmDHq+3ftQorYTlUUh1MSM5UzhMK/slzW5uXbJibDughN2qSIidkkybe9DrkPm0+9Y6OTpoWWmxhnIvUCySNAf9haJf8wsB0M1Whck2ef4AuPwqpxvVqKM4bLDGjvkdfbvEhrE/wCgVYBjcFAFzt1eEym53k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787002794; c=relaxed/simple;
	bh=QBKZFkScatwZzh2s89tt2/UC0bSsv+cuExkBA7lm3H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJ+9rau1dDHDV0ZG4++sU4Ih4/XlaO0WZGJxCOgrU28HupMY7KVETku6CT6aDkYomLNODCznSMoxVp3UI7CuBDqWa/kpKGQusbA2irqoeyqoJkdoycUAJDE26ULcRWzXDinrpeLFBnfYr8tCt9zouxQ60cjc0paidj5dlIi9H+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knp7H8rI; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knp7H8rI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c10e86e52so32941cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 14:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002791; cv=none;
        d=google.com; s=arc-20260327;
        b=CbWtEJQLSGgY5+LMWg8YdESqjCdX7+TgN4yPxfacWot4fKqxh3CdAuQKd0cImNZsH5
         VhuSzBCYb5rttsWKlzQif5ELUFAI+c4NSJldHxAMxSgG+iq/qauoECrIllCLQTwuIUK0
         qBn0Sf1fhj+QztbMVlrjU8EiJaIQIjGOMwrqpeWrpmHNIykkKyA4x/h8QygHzpjTm/dh
         Eo3Ydo2UtSJbgHBZGOkxHwDZa1E99LMvtV2Eg/3UG4/jfyB8bVjERGwgWh0Vu7UfFF8O
         D9DR+UJWvVRWWOHBjpf6tCO9Y1dipek0ikwxM+7SGkfphcYfiqE+e5a0dyFOvBj7xLra
         IaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kqqfClJ80WFRd55SgOZuJLLVI3LEO46ifEryb68r4Ks=;
        fh=I3PvSkzWDwsGHyhacpJfadHy3j8bOQC0AbesDZwY31g=;
        b=hNlV9uL8HZ1DlkqlHKWxHIIc9VvNxamk/qmdD3yc38RUIbYvCm8x52dHjkm8HN5ONv
         USqqcB71XknC+59WyDX478vXJMYlgiL5J0DRYLyUcjExj54Ro/fFBmaORlDAkK+he6+w
         eNBse11d6PGoyBn33RiyM4/jFOQsL0K38ZKjmrm7KFpG+sROwWx9GIFKEDGZEs4dEjiW
         HVAzp3myl07HXGq8YAiUIjWe/3LrHelne71L6T3X7aXEkgw5XjkxFFbAIw+4tFidgXpf
         DdG01KhiUMsMdgp088lyBjzMGZLaHGJuqd8ese5DSJWmQL12/LaHq0fAn7yRhd3kQm7K
         ShUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787002791; x=1787607591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kqqfClJ80WFRd55SgOZuJLLVI3LEO46ifEryb68r4Ks=;
        b=knp7H8rIEsrSy6vLsj2oPnf3a5gvlyta+JL+EO4rxW563jAEtyzzDQqZGkB3+nbRCW
         XPfns5aFvw2Gv+tQ26t4DxewPqP1rweaDlp3DP0bEJr5Xx9+GbHSWIQICxZm9/+3E28e
         9DD6iHFnrWiY11IiOgEtiTmKfcsKvY7I8esdC0d2LboS2olPZRucPLUDpUv93xsKeVzR
         zFc09fL0GqP0r/MmkmYpFR0UT3KbZ9UIUWcn9+GP19SKrmBH2NkWWJNVS6FoROMH66g5
         i5Ywujny+NWUHuGWbBjIHqCIJ0hLiZziX7Xlxor+E+T8j41GpBPTMT4uVRw4xU9cp3Sr
         u5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787002791; x=1787607591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqqfClJ80WFRd55SgOZuJLLVI3LEO46ifEryb68r4Ks=;
        b=e9oyPRGa+YijComZDm7mwN5djAgO0W07OkXv7nQJF/pE/Hg6395uo2axYLXdikvspe
         vi/3tzWL4t7BhcPottChXv6nhMH1Umg8kP7yc6jpqdI3U1GVNt5beOufg81KoqVmUdug
         kZkEStzC83nUVH3ufR1xOUmisZp6wOLdxB+jZeM6nmp8FDiIByNfZGyf+INOr3yuerqm
         iUUnwP6a/I0V8SM5+JJCZa1hY93eUWxNygaKlipr9cmmgg0v4SaKcwrainkA7FAcPNYO
         yVRqbHonzVxBrUwZRZwCLBkJT0D3Mam0RcpbRXWMa9WKDDhqfKHp2LrpPv7s2tpS6tpP
         Py/w==
X-Forwarded-Encrypted: i=1; AHgh+RoMMuPNPJV9tVXpfgSJDGsNzuyl85KIsaZyDdnfP6hOb9Ai9mU6fOUmx+yoAWINfBK/U+Lf1c7K4kgoHMXQu7kC@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUZQeVLSgT5i65Tg7PbF2TIOMRR7GvxUjj8+JVx5Y6CGOi/b6
	utUHZ2l94cqGmFhINIH8gE2uLvYvgaM0QNBDNOhGIVK/6/p7fL9MlNeX3qiSPZQVH8wIbx4ycE2
	BnKXVhcw3ZLuAdx883c7Jt48t+2Uq2s9tX/e6iBKH
X-Gm-Gg: AR+sD10d7RSPdNQuV2peNOaCLH0YduXrxalp2SIQ1KXL8X5Mis3hgVpaq6RDdFHE5HW
	a9OBRFvaLzw1CMcVrWSp9cQNwHSbE39miRPQpNWBmjlfft8CcrPAVbZ2L0/L7EDRYlYXmUBxr60
	prSLdJPYpnS2idstqiE25pHglLiE1bQVGI9FFgSvNzgIsx5TCJcli+mP8b0y+/D4dK/uLB/j1RQ
	+tcV23TuSurDy03oEVDQIAMsORFk6O8Z55Be998l7tXBjLkOPOELeV7LE+AzwSNY13mLbGAACiz
	UjikvzbzeEkWJB0mMPEpwy0HV26t7hTZTqylHwk40mOkCQ78H0qbBNG2dUMgOitEf3TfGUBV3Zs
	=
X-Received: by 2002:a05:622a:2518:b0:51c:ae6:a57 with SMTP id
 d75a77b69052e-52dc4821345mr128931cf.11.1787002790733; Mon, 17 Aug 2026
 14:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811173340.96013-1-thomas.falcon@intel.com> <20260811173340.96013-7-thomas.falcon@intel.com>
In-Reply-To: <20260811173340.96013-7-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 14:39:39 -0700
X-Gm-Features: AcwNN1XpTcpnHcZKiSrQzMvMXHYdbte8aB5tdURM8-1fFIImsxbLZKyRZ45tqHI
Message-ID: <CAP-5=fVXr5e8sALHiowXaL=Cv7wqVaOXedHsSdFqq8fqzTA=TQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] perf c2c: print memory region data with stdio output
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:34=E2=80=AFAM Thomas Falcon <thomas.falcon@intel=
.com> wrote:
>
> Print memory range data in perf-c2c subcommand. Only available in stdio
> mode currently. If memory ranges are not supported or present, print
> nothing.
>
> Example output of perf c2c report --stdio:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                   Memory Ranges
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Range 0: [0x0000000000000000-0x00000000bfffffff] Node 0, local region id =
0, remote region id 255
> Range 1: [0x0000000100000000-0x000000203fffffff] Node 0, local region id =
0, remote region id 255
> Range 2: [0x0000008000000000-0x0000027fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 3: [0x0000028000000000-0x0000047fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 4: [0x0000048000000000-0x000004ffffffffff] Node -2, local region id=
 1, remote region id 255
>
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

I wonder about opportunities around this information and what is in
/proc/iomem as exposed in the mem-phys-addr.py script:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/scripts/python/mem-phys-addr.py?h=3Dtmp.perf-tools-next

Thanks,
Ian

> ---
> v3: Included examples of memory range output in commit message
> ---
>  tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 8cd90524fe49..7739023ced41 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2635,6 +2635,34 @@ static void print_c2c_info(FILE *out, struct perf_=
session *session)
>         fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl=
_sort);
>  }
>
> +
> +static void print_memory_ranges_info(FILE *out, struct perf_session *ses=
sion)
> +{
> +       struct perf_env *env =3D perf_session__env(session);
> +       int nr_ranges =3D 0;
> +
> +       if (!perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES=
))
> +               return;
> +       nr_ranges =3D env->nr_memory_ranges;
> +       if (nr_ranges =3D=3D 0) {
> +               pr_debug("No memory ranges found, skipping\n");
> +               return;
> +       }
> +
> +       fprintf(out, "\n");
> +       fprintf(out, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D\n");
> +       fprintf(out, "                  Memory Ranges                  \n=
");
> +       fprintf(out, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D\n");
> +
> +       for (int i =3D 0; i < nr_ranges; i++) {
> +               struct memory_range *r =3D &env->memory_ranges[i];
> +
> +               fprintf(out, "Range %d: [0x%016" PRIx64 "-0x%016" PRIx64 =
"] Node %d, local region id %u, remote region id %u\n",
> +                       i, r->base, r->base + r->length - 1, r->node,
> +                       r->local_region_id, r->remote_region_id);
> +       }
> +}
> +
>  static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *sess=
ion)
>  {
>         setup_pager();
> @@ -2648,6 +2676,8 @@ static void perf_c2c__hists_fprintf(FILE *out, stru=
ct perf_session *session)
>         if (c2c.stats_only)
>                 return;
>
> +       print_memory_ranges_info(out, session);
> +
>         fprintf(out, "\n");
>         fprintf(out, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D\n");
>         fprintf(out, "           Shared Data Cache Line Table          \n=
");
> --
> 2.55.0
>
