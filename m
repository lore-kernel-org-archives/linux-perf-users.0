Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5331CC16B
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805663; cv=none; b=K8X/XzyCLBS79qOKgFk11MEA9YfXhGvepE/TbSaTMjVSMGJtyrRsLNyEjbHqsbySyuvLodlkLHy2Q+AnAJjhRae9nwlxdEA248xjSlSuLY2gEeZMf3F1yZ7kkxBs3L+dNNgCHCZCyacvkhXGLisnR15s+kBffRzZDH00b53dPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805663; c=relaxed/simple;
	bh=3dKh4rYpTPR0eObJ8nP2w/6rINF7r1NuQvusAAAfsno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfovAPpLwi72aSkgAmd5RH0PT5f5aq+CS4sKZmGljS+GXtJjK0OvMY3SwiUYfEpV2TsOB1ddFu4+QdUpjhw4wNG41wPslJErvOqw5ZVxNwPinjO37yQ7jjkAiePHL1FvOMtf1Ocfxvy5xrfxn/6EDyalkoqNv8bWWt4Tpsf4kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=370FzfYg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="370FzfYg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b40c7fd8eso20595ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727805660; x=1728410460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjfzTjPgLCnOCOJF0AMdN0inZLS6zO/4QzB2WyLqC4M=;
        b=370FzfYgmqheUDX9kjEwys6imKcIfMr2d5mH5PimgFKa8f5Kn0Z2Sm/WJTOQv9Zker
         jw6b8AiXC0PMLNpcuEXWbt/Bwp6qF20URj0c9x2qcPfv8OuZdoKL+ZmmszhHXIXFJboE
         5hoQI75Nhw4HbDqJsuCTYGUEd1T2Yt4PH04YeKH22QtmaiCXVxvzkwfibC7BQ+65L5Yu
         HYiLVEm4KGxQq43B1xlnz+q8v+D26jcHmWfL/Jn3CFbrylQ7h1jiN0W+qMD9KzaodpkC
         2sC68qF/md+jOPDyHK+mUh3849WXICqt6MWyW0OXEku0RyQXWDU6qlW/KMOf2U8fKFy/
         n4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727805660; x=1728410460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjfzTjPgLCnOCOJF0AMdN0inZLS6zO/4QzB2WyLqC4M=;
        b=ctUNRgC+VpflgizPid4WuAgnlr4+kAjjuOcgJnmj6FGsaGGmz+6yBN4ADhWfFnqVkZ
         iFrOCjIr5jfxR9SRIIFiuwkrm46rpew/qeW6ftri/GIt9ZQK6aD1TOQrkAO7ZxWKXeXa
         nkyTv5KPdyoZu9Z3C/qUbvW1VCh6yBjx2GIFn2SqU+uRK3kDxGDCYAdc4Pht1WQu2QFH
         Ngu5/+W2HM5nWdDi5pZ810A5Ec6D0RBZfALuXf8qc8x1bsPyJswwXm4z4hBZ5AZ5eHjX
         UX9BUFUtkDsTS5vFGCc7RfbJFDkFEKX9gaQ2Gp+EHJ9MsZK64pEGt71qGxTDVIolWLQl
         QkVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMnNSsErOOEywpSEhLVokEryXE38jgNsbHjbr66H8t9TlTFjTGcVuyVhcQ/VuHXFhU4ytwdah181AwLOrne+YP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+y0pgo1YyFi7NRXmcU0r7Z2lZqvbsA3jhx3nFVxy+7Ah4ZGiS
	W+kcWYJH8LqqBBfZykkbE//B+nzj+JujyeezI7hyRHqUBEgcvYNq3wBTv63/BjaMPUnfQqv3iEH
	ESmBJQ7ipY3b2JF7h+R65ox1wkOyQFscRZhba
X-Google-Smtp-Source: AGHT+IFKX3B6h9UbMQsqjcSWNwq7OQStd0wsM4uq7rXlnXsOuOq/jKl73nPFIxrgnlbxtDx2zeQK6n65eWVYdWnpv28=
X-Received: by 2002:a17:902:f94b:b0:209:dc6d:76a7 with SMTP id
 d9443c01a7336-20bc6aae1a8mr162825ad.14.1727805659835; Tue, 01 Oct 2024
 11:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001002027.1272889-1-namhyung@kernel.org> <20241001002027.1272889-9-namhyung@kernel.org>
In-Reply-To: <20241001002027.1272889-9-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 11:00:48 -0700
Message-ID: <CAP-5=fXEd+m7WMi3JxTF8kA+jB7h97NT2Z3P87YOLGuvebi9qA@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf record: Just use "cycles:P" as the default event
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The fallback logic can add ":u" modifier if needed.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index adbaf80b398c1f4c..f8325247292112d7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -4157,9 +4157,7 @@ int cmd_record(int argc, const char **argv)
>                 record.opts.tail_synthesize =3D true;
>
>         if (rec->evlist->core.nr_entries =3D=3D 0) {
> -               bool can_profile_kernel =3D perf_event_paranoid_check(1);
> -
> -               err =3D parse_event(rec->evlist, can_profile_kernel ? "cy=
cles:P" : "cycles:Pu");
> +               err =3D parse_event(rec->evlist, "cycles:P");
>                 if (err)
>                         goto out;
>         }
> --
> 2.46.1.824.gd892dcdcdd-goog
>
