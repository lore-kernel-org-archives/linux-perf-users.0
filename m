Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcC4xhGr"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AFCCA
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 11:11:08 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50beed2a46eso448e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701717066; x=1702321866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVSNr1Qot00fXFMvviV2konhIWgpkJd6arMvwOKUXZQ=;
        b=LcC4xhGrxScAfPw759dioNUG3N8Py6uN5JUzcJS7LHSxtKuEDd66x+MKFLdmw1qOL7
         PiellQUqT/Ty1qcIvth/a3kS50L73LJYAuyOmAfiv9uIpmYN8VvLioQJkXT/RpSKK5mU
         kQ6EczhzP6DPAf6ffJqHDntAvcA/eYiTvGZQ+XdrzNI74fS/7SrlXpokxAUxjQ88wkIx
         g4peC04WLqqbxcYy6GlVoxoLbw3imUExgxvw/sYGqZk1hfpTEEGzxKcOdXNRplqoZSse
         h7ENQNG1q+ZuJZv2f4lhK8d/RaA9lvfHhPg38xdiL3lCUB9VyOCkxdpVQv6QtTnnRFmq
         uKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717066; x=1702321866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVSNr1Qot00fXFMvviV2konhIWgpkJd6arMvwOKUXZQ=;
        b=DgPVAzbVIF5Qhse/+aewE1MXWxuB6Sv/LYXFEr10vETmEABDbDbBDuOZ5sfaQyvP3s
         qgPj2BEHNQdWkcaoJrjflthCa74OgAF5CYFbfWSxU1ora8SbyL1woUOjydVFvYlAh0Ua
         nqDGuWbOaz2ockXY8NicutsmZB9oDPMs8TpnBRIbWwy5N3LdBQNIAGRyctT4s+z/VR0F
         RJTl+XeVuDbxRK/6HZjJf4ITi2KKYH0yDhagUVTGOkWpSi136IKtzuW22nlze51jw7b/
         s0EFY9MIGx2kkbUVzqXZvHyFlbPfgpvK07MgVpiZHDT7jD6Ms5D3ADn5KxVOhFylbxs2
         sDqg==
X-Gm-Message-State: AOJu0YxFaXcrhqCcqTPC+RLJsei7KRmQAdRZd38Y31824izioxCeht9z
	oWzY3/OvT8QkS6KjfItRZNQAVfK93zesraKcQ+DnLA==
X-Google-Smtp-Source: AGHT+IFbZXqoGl/WdTMR7T1nW5A9qFR+v28+geM54U7dMEdA4nWpaQuSsrDolKMUo4O6BUGaMsu/bSyVe8dHQBeIMJE=
X-Received: by 2002:a05:6512:12c4:b0:50b:fc76:42c with SMTP id
 p4-20020a05651212c400b0050bfc76042cmr75442lfg.2.1701717066213; Mon, 04 Dec
 2023 11:11:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201203046.486596-1-acme@kernel.org>
In-Reply-To: <20231201203046.486596-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 11:10:54 -0800
Message-ID: <CAP-5=fWJMcJb0+Nmkd1=HoOc5j7LEzGkJmqyAgdpfekOJtjybg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Cache the arch specific stderrno routine
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 12:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi,
>
>         Please take a look,
>
> - Arnaldo
>
> Arnaldo Carvalho de Melo (2):
>   perf env: Introduce perf_env__arch_strerrno()
>   perf env: Cache the arch specific strerrno function in perf_env__arch_s=
trerrno()

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/builtin-trace.c                  | 6 ++----
>  tools/perf/trace/beauty/arch_errno_names.sh | 6 +++---
>  tools/perf/trace/beauty/beauty.h            | 2 --
>  tools/perf/util/env.c                       | 9 +++++++++
>  tools/perf/util/env.h                       | 6 ++++++
>  5 files changed, 20 insertions(+), 9 deletions(-)
>
> --
> 2.41.0
>
