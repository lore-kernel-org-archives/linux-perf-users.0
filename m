Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9E146A79
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 21:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729719661; cv=none; b=c94QBzW6m5Z/jDa3+eH7b9HVnvTcQVEXIc4l+X15GOlNBRd0sJW1LYzBT4N1RDtJ6sn2kaC7WJlMZfyCLL4RUPhOZyiZPDDGDWZRGpb5/UrEiLbPXPIXEuIq8edUCgSbX00Pztgr6G3HJ+ollr5m95XNlN9GjZCTvvm/OuGLKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729719661; c=relaxed/simple;
	bh=1uf8OIKKp+NdtE/pJfJZCgDe/L5ipzQNnNqRIsLrXZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lt/EjJajI1S8k4k9lHCU4kiVommNJZQXlMz4FCttNFwsfTquDBjvIh/eT5tPKOL2MRomftvKBiYNejl1DVbf6xP8005SBs2s3zCgl22bVydOJ/p+zsNSs/6Yor3263LU6m6F9oMxXU7TwGWgdlQFzFdix+9tUJ7kjGJ/6u/Kcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqoBl4ab; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqoBl4ab"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460b295b9eeso23731cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2024 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729719658; x=1730324458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfvazoqlYCjqRkYx7l7QlbGhjN9SEp8GOHbwEYd68EI=;
        b=aqoBl4abMgcf+PEbRmyl9gi37e7pi0AOpPrsfj3OXH3KweP0Zh6Mh044z+oCn+Ivii
         6714UeENIL65BVlio3YwC4S4i/GS6gZGTR2tClpLqMrJ1PJCSh2maz02f8ag6cOQEEMv
         PtCEe3taG2sTRlsg9mRORoJyzFPSKf6c/PlDxDxKzhiMLqO6HfmJ+Dqdc59lsS2DeTdN
         a/80ITNvuyJQrp5IO5rkDVUseUnG4RvmVnLuB3eMi/YrTXKuGeHDjZstlU9rTs808EGd
         ZIi7pWnm76t558bk/eTopCHzAoFasZhK2RXbUkjSnqM/3wNEsioWDievVdmylZrdocyp
         OcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729719658; x=1730324458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfvazoqlYCjqRkYx7l7QlbGhjN9SEp8GOHbwEYd68EI=;
        b=vifvX+F7oSit0MMKU+FuKamS007U/6cfFGR2s5zrAX94RZuaCdrMunMLQ51Q+uK5xx
         VItOU7Nk7fbugJe91wcUtOpfgsyNo7NkEKwZ6Ek0T3kWO7tr9EiMqo1VAgVasKbp3Uxs
         LjX+Nj5LOl6O1uI6+d59W6YzA4+n9nrPxalO7vo58nb1ayoKOL39tplvBUTqPu/8ucTZ
         R3UDd5ouKIeASc7GZj90TiygX/n+3fFmzZeH0zawOyn1EvGRrdoyi19JL57xQZGjMemS
         z4yXDHY5zrMZEo7dpvYb0Oc0Deaty+IRil/StJgOM3O//SAk/J/+QY1q9LA3Cgoko/1g
         Prmw==
X-Forwarded-Encrypted: i=1; AJvYcCVAnwrQGLkUyhSOL8NLTxw+Zepp/lw0vc5c+ZdSkc3qD/kxjVaJ5M6jolzQIUmLj/ceU7PIXNeBX5bTOVOAYnYO@vger.kernel.org
X-Gm-Message-State: AOJu0YyWwfS0yKVgcKQYICjSCBfCqJSgXRZf58mfVnNl1P8dJlcgRGWw
	P/aVJddzEsJEHlfkiZvxNWmlj/vHS+Hj0IrbIxBJM0hEgKyDwI60S9X10F4NDmfJMUNFmOnRmiw
	0jc1p8Ur2f2qF8XCzkVgYTh0S2oHtgt62eQGZCc0yVuiIuBPXp/oIO0Y=
X-Google-Smtp-Source: AGHT+IGt5BrL0ynohwcQHFAarnxSHCFSAf9jK25+4hYiJBIoa94ycBS2i1HnMLE/a0ATqe+WrRn1kONilfmhu2zwb9Y=
X-Received: by 2002:ac8:7f8d:0:b0:460:4a47:fd83 with SMTP id
 d75a77b69052e-4612439f4a8mr196671cf.27.1729719657708; Wed, 23 Oct 2024
 14:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxllAtpmEw5fg9oy@x1>
In-Reply-To: <ZxllAtpmEw5fg9oy@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Oct 2024 14:40:45 -0700
Message-ID: <CAP-5=fUF1kfioGSgnXzPmadwKrd65mUpHPamPNt29ra9qZAzJw@mail.gmail.com>
Subject: Re: [PATCH 1/1 perf-tools] perf python: Fix up the build on
 architectures without HAVE_KVM_STAT_SUPPORT
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:05=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Noticed while building on a raspbian arm 32-bit system.
>
> There was also this other case, fixed by adding a missing util/stat.h
> with the prototypes:
>
>   /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1396:6: er=
ror: no previous prototype for =E2=80=98perf_stat__set_no_csv_summary=E2=80=
=99 [-Werror=3Dmissing-prototypes]
>    1396 | void perf_stat__set_no_csv_summary(int set __maybe_unused)
>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /tmp/tmp.MbiSHoF3dj/perf-6.12.0-rc3/tools/perf/util/python.c:1400:6: er=
ror: no previous prototype for =E2=80=98perf_stat__set_big_num=E2=80=99 [-W=
error=3Dmissing-prototypes]
>    1400 | void perf_stat__set_big_num(int set __maybe_unused)
>         |      ^~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>
> In other architectures this must be building due to some lucky indirect
> inclusion of that header.
>
> Fixes: 9dabf4003423c8d3 ("perf python: Switch module to linking libraries=
 from building source")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

So this will at least conflict with:
https://lore.kernel.org/lkml/20241022173015.437550-6-irogers@google.com/
where the #ifdef-ed out functions are removed. Does that series fix
the ARM32 issue? Could we land that?

Thanks,
Ian

> ---
>  tools/perf/util/python.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 31a223eaf8e65fa3..ee3d43a7ba4570f0 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -19,6 +19,7 @@
>  #include "util/bpf-filter.h"
>  #include "util/env.h"
>  #include "util/kvm-stat.h"
> +#include "util/stat.h"
>  #include "util/kwork.h"
>  #include "util/sample.h"
>  #include "util/lock-contention.h"
> @@ -1355,6 +1356,7 @@ PyMODINIT_FUNC PyInit_perf(void)
>
>  unsigned int scripting_max_stack =3D PERF_MAX_STACK_DEPTH;
>
> +#ifdef HAVE_KVM_STAT_SUPPORT
>  bool kvm_entry_event(struct evsel *evsel __maybe_unused)
>  {
>         return false;
> @@ -1384,6 +1386,7 @@ void exit_event_decode_key(struct perf_kvm_stat *kv=
m __maybe_unused,
>                            char *decode __maybe_unused)
>  {
>  }
> +#endif // HAVE_KVM_STAT_SUPPORT
>
>  int find_scripts(char **scripts_array  __maybe_unused, char **scripts_pa=
th_array  __maybe_unused,
>                 int num  __maybe_unused, int pathlen __maybe_unused)
> --
> 2.46.0
>
