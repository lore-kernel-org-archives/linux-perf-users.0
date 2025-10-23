Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9128BAB1
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Oct 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236070; cv=none; b=GQGUHqazHzOT8zCXcLw35HyVgf2gnCbUa3rKWSxzcab9se0QNisCKLAAK5q7gNHjL/Zx9YyqUNeoS3GmnDeJ5oHqJmlqKq54bgnHCeFSIS5uNVpDhgxb5/eAI9+FRiMMga/edv5aBvtQg/Mxk7s//IDIJ4EiBHX1cQnJAOr1/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236070; c=relaxed/simple;
	bh=msVqp6lO9/4vj+yXj/9gsQ88ASClzyzh0hFMFZXfGJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GycVqWnwvBAIBj/zHCpG8e9sI0ngj0eIHaN9QmTm2tWAwQ90f5cxEUZr36o4olT2VAc6FkJ3gIEmDdntBDUztCD5j7t4OcOkSNOHjDh7kdGN/N6MIJt5bR7+ZRqxN4iKCv2QrZWQEJ2NxZqz+WStUx4nb/C6MG5D4AvZsxwaaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5CKdoHj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5CKdoHj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290d48e9f1fso207105ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Oct 2025 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761236069; x=1761840869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jux2OKRYi4F5rIr51U0/cJ7dhC9vk3290S0zPifbrQU=;
        b=h5CKdoHjbqhBAFNRlU80GwSfBJOQCDYdr4BS9Lgcz2biIPjvkUbYUTuIZuxj32eZDW
         LgRMHbVoH3zbF9PzxtuP+plC1mrgGIXYa3bRIhxeCI4Lu/mu67FMWQx2z/lrm83YUcIb
         GtJsbfAZrZ4X5r7OJnJxqaHthY3sViDaOoq5i9py+hm6u81zVOZ7wnCgWnTDLpfG/8SE
         pDJFCG1mUymLzzE/b8ByuaJ4Enh0n0yUvU11s/RyjytxWCB6foSsC8rGyVFDp7VjCtoV
         XagBJ5Hy6Z2SfF8XP1B13WKrBtRYG12f9C9malvS4vmW+KK6YR5tQZt8lHbq3yFsEsK5
         RD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236069; x=1761840869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jux2OKRYi4F5rIr51U0/cJ7dhC9vk3290S0zPifbrQU=;
        b=kUJqCK8Cmdn6wZ/ImUY8JRyVISvTWveBf4/T8IyNWTTpvTADXQc2tWzJdp1T66A4qv
         nUDbbviQ8hEPf23afz4Yqv2vZEaXL+uPpm6KVGTtLt+2GPG3Ust4dd2p0PQ0lScdOX5I
         sPDaGenOeRikvqZqHv9hBtOltL5Qu/E8hzSSQbyZZ0W0i0m8ShJ8lUiu6lCqKiiZk3w1
         B+ZS7WbOa4p2TejNGHZJpChRBe+USqzSH0cuC3IhcAUNGOnymxFlmdrH+mhfShVGJeEJ
         g4vmB72jXiXnd5o1ziELJByVCwltAIS68soEifZ5zpQUQuJ5Te7NHzbyKbvH4upM2r5b
         ppHw==
X-Forwarded-Encrypted: i=1; AJvYcCXX3vXQ0i6wVr8ljtP/21zB7zbvDWNZcS6xIPeM8VwgUzhBlAtQMThFTynBSuhDIJrdgJLPyRkKFUi/h8KexhK7@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYRKSaBpqW5SJ2gffjpB6xnpC/MNV3PGjPKzqB+hOyew76QsB
	ZVcatmh6EuY2sD84wzfNVJfqGL25+GUplrhURHxoZIcuNOFbVyt27Mpgm+4vOGbOERj7lwBzYpe
	2v8MzcHNrDLHHei5+7KPT4g+1B69n4GGalPBBO4nU
X-Gm-Gg: ASbGnctg4Dlsar07LnG3skZsE9kGoURbVEEEhqtZ1MvEmD9CPDQkLTF1FlVdMaPMLQd
	DqSOl96P4F7xAp75iWpM2qtY4zgbD+ZTAk+2cl6XI85Ca1DCdCU+VUP7RwvNVhtxH5UXlIlK9Z7
	zc1pDmSocm/NZZ5rIyB1vociJVcxx+fMS3TED0HSJlQMv6JfA9Xfnvmbzj9jukQlbAFk/+QSO3m
	EYMgLHM57LjtJbwNeq4kTo1UDabkIyBrTKu4v/6DQDtwIzDdBkX5TVCSZd+0aWtDGZumbt953Td
	m7UokC3LTEz02CyHGrOstErenmAX13oHYvIK
X-Google-Smtp-Source: AGHT+IG+3mSaXvzfHQTY7bpJd5yQVbFC0C4UzDpWcIl4Hl4G7l40P0lQ2DoTx7fK64RDLun+ivwWqag7/5rPr949bwQ=
X-Received: by 2002:a17:902:f548:b0:292:4d93:b501 with SMTP id
 d9443c01a7336-294873808b2mr575675ad.11.1761236068215; Thu, 23 Oct 2025
 09:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022220802.1335131-1-zide.chen@intel.com>
In-Reply-To: <20251022220802.1335131-1-zide.chen@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Oct 2025 09:14:17 -0700
X-Gm-Features: AS18NWAp-JONLAyYSe-4dQoTVRjuxz5E3zfJmTGpg7goE3FX9w7Ekd9P-6YsoeA
Message-ID: <CAP-5=fUKH8Qw9t173G4HP-UzujUKJrLPPmkDSjBs=2YzV=9LHA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
To: Zide Chen <zide.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, thomas.falcon@intel.com, 
	dapeng1.mi@linux.intel.com, xudong.hao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:14=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> unconditionally called the precise_ip fallback and moved it after the
> missing-feature checks so that it could handle EINVAL as well.
>
> However, this introduced an issue: after disabling missing features,
> the event could fail to open, which makes the subsequent precise_ip
> fallback useless since it will always fail.
>
> For example, run the following command on Intel SPR:
>
> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3D3/PS}' -- ls
>
> Opening the event "cpu/mem-loads,ldlat=3D3/PS" returns EINVAL when
> precise_ip =3D=3D 3. It then sets attr.inherit =3D false, which triggers =
a
> kernel check failure since it doesn't match the group leader's inherit
> attribute. As a result, it continues to fail even after precise_ip is
> reduced.
>
> By moving the precise_ip fallback earlier, this issue is resolved, as
> well as the kernel test robot report mentioned in commit
> c33aea446bf555ab.
>
> No negative side effects are expected, because the precise_ip level is
> restored by evsel__precise_ip_fallback() if the fallback does not help.
>
> This also aligns with commit 2b70702917337a8d ("perf tools: Remove
> evsel__handle_error_quirks()").
>
> Fixes: af954f76eea56453 ("perf tools: Check fallback error and order")
> Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Any chance you could help with a test case that covers this? The
fallback logic is spread out and easy to introduce subtle bugs into.
Just having a test case that does ` perf record -e
'{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3D3/PS}' -- ls` and checks the
output for EINVAL when the events are present would be useful, as then
we can make sure this doesn't regress on SPR and later. Something with
more generic events would of course be better :-)

Thanks,
Ian

> ---
>  tools/perf/util/evsel.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ca74514c8707..6ce32533a213 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2714,12 +2714,12 @@ static int evsel__open_cpu(struct evsel *evsel, s=
truct perf_cpu_map *cpus,
>         if (err =3D=3D -EMFILE && rlimit__increase_nofile(&set_rlimit))
>                 goto retry_open;
>
> +       if (evsel__precise_ip_fallback(evsel))
> +               goto retry_open;
> +
>         if (err =3D=3D -EINVAL && evsel__detect_missing_features(evsel, c=
pu))
>                 goto fallback_missing_features;
>
> -       if (evsel__precise_ip_fallback(evsel))
> -               goto retry_open;
> -
>  out_close:
>         if (err)
>                 threads->err_thread =3D thread;
> --
> 2.51.0
>
