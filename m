Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7324EF76
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555442; cv=none; b=ZN6uSJdlKdt7xuanT4O4QhK5fvizcin0pBHyMxeVFjo9DWWzhwV1Vsq9IqIS6gBNDT6l3caS0Z08mKCW3IHqtDs9GK0gM6IfjAlFBvYWiPm9nrDt/5dt+yrKV/9ABseaOAWx5w5iWJPPISdFkeJsyyYYG3vo9xDg+1CldRjV+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555442; c=relaxed/simple;
	bh=G6u7wXNrmkVxiUsvwqfcp81Ql15S39BbqPwoKLL7atM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rf4QRkfhB1pERtFmI6ALWdoSYaReANloHDuqiQZs7baRIF+FvD0s1G3998Xy/SuMt/xAj7svvhll0tvAgaXJCciKc3fXKNplO0km6umnXFr6Cg7Csc1x7QYps+0TnvH5z6k9LLUBCZksYIJw4zrVEyO5D0y/MU09o8DFxMy4gwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1uTwhgCu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1uTwhgCu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-242d3be5bdfso31475ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Aug 2025 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755555440; x=1756160240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZA6ooLu7qT5iTdye/lR8tavBy+pKLzuc7v/W/TQXdE=;
        b=1uTwhgCuKBjIo6SSbIXXQC3csjQynl0U2/JcCYeAq2i4XF8LQwLXRrFiJDTQxFOzUY
         +lOGYyWvVWyMQlUAJq1zER6qNownwaasVkd1+T/NPMjAHYrnH5tdmWlOq0JyNYJO2xKT
         CVz+WnR449HtQOWvBtkT1VzLmaqhKjWReYibDtZsKFkXd2mTFTk/Gcq7OufajWP77QMN
         cuY/PvZPzcx+sAHQLLAwTcYmjKwdEly+3+bxSHT/Yq3dCLzfrnNwAfOqxE0BXVHmy3Wo
         ZTm6jfTQhyVYRX1JdBgPrLcf0YAa211lxnWNtjczP88xFUq57Si4zNNnQMfRMhXvyI3o
         mn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755555440; x=1756160240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZA6ooLu7qT5iTdye/lR8tavBy+pKLzuc7v/W/TQXdE=;
        b=cuIw6rU9kQ7+YUyUe8VQXpEyEwm6cXgp0ece70vsvHHkIzxer4ZFt7xxPqB/vFJIBw
         cRwynpRqv76PykNc7Z4mF1DXSZwEP4kTEsP0ygSESDu14dHgAwEpJGo2zRChcsnBEwOZ
         McJzAlCXcU4eXqrG6+rKufGN0kWyl/ojtKQ1+c/4q6HutM9tlbHwJWDkPaaA5aPXhsaM
         8bAhfx9t8qcksbg0aP4FYklv3Y3d7KWKleE3CEn/N0BbVS8Ee5VV4QePB3/V1Iia3Eq7
         a9IFJvJ0FwuCmqk5dXleAB1KP5jmpmh/7riuW1XtI7WLVT7FVV/IBbNoYF+ZCX8cGNwh
         YyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxZ7E0FC5tfnDnOOeNLaiqEXsLOMdH2R+/cC/lrrxy7ZsLEpPtv/G+RmNApEK6wXm9NP8b0uHpYYJ5YMZtxOq5@vger.kernel.org
X-Gm-Message-State: AOJu0YyWWngeBIxnUI+UeFsfienKF93gDyz4Ry7/wUbxKWSqkKTB+80r
	g8lGE8PYM34K837ZmSxuwgpGcjXADCF9L7b4TF536bQXX7Z8xngMXNaFRdp6G5tASbfiFFcqK5Q
	Vb8QUyCFliKRPjDelF+RggXV4dn0wl85VaZPmc/u914eQmgVg59QZvo9R
X-Gm-Gg: ASbGncsVxy2D0xdBU25J5v2xjpp3i+gQJ4YIxsH08VMo7d/JcXDswN0oe3Rvbv+vxj3
	91slPCEwDhozkY6Aji71hd9c+OGZd9xtzdLHHcBlGO0sLgI5uoEi6+zpBdQRidAxsOuAet5o6DG
	m6TKBPHbhH2DSwgGeqei/b6Nto4mWGaHQU8qehGK2GsmmQYW0CW1UaxVqKixIAE2ICudpP6iq9u
	yKW1WMxmYfKIhS5mw8tbkFyxdXVFyCXhYttXGww1tyWEsndouM2u0xKmgk0y1ru
X-Google-Smtp-Source: AGHT+IGXJsBkIUyGYgZqYNVTSCHvta/qmXssx4kJMSOLn93RuqiAfnx5Np6n2KBt1ebJbwuHyAvnkjE2SYEu0Z6XWKU=
X-Received: by 2002:a17:902:e804:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-245e064c79emr421685ad.13.1755555440291; Mon, 18 Aug 2025
 15:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808222650.2218658-1-namhyung@kernel.org>
In-Reply-To: <20250808222650.2218658-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Aug 2025 15:17:09 -0700
X-Gm-Features: Ac12FXwDIxx6_EEdocwcH_4PCk_uSDnQj-tMx1M3oppYAFONzz4UzLlze10Mx5o
Message-ID: <CAP-5=fW=Lz0NDS2=D2cKOAjVT2qP6Lw3QJsCqhac4w-X0XjH_A@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Remove a pointless check
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	David Binderman <dcb314@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 3:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Static analyser cppcheck says:
>
>   linux-6.16/tools/perf/util/tool_pmu.c:242:15: warning:
>       Opposite inner 'if' condition leads to a dead code block. [opposite=
InnerCondition]
>
> Source code is
>
>         for (thread =3D 0; thread < nthreads; thread++) {
>             if (thread >=3D nthreads)
>                 break;
>
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/tool_pmu.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
> index d99e699e646dd651..f075098488baddd9 100644
> --- a/tools/perf/util/tool_pmu.c
> +++ b/tools/perf/util/tool_pmu.c
> @@ -239,9 +239,6 @@ int evsel__tool_pmu_open(struct evsel *evsel,
>         nthreads =3D perf_thread_map__nr(threads);
>         for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
>                 for (thread =3D 0; thread < nthreads; thread++) {
> -                       if (thread >=3D nthreads)
> -                               break;
> -
>                         if (!evsel->cgrp && !evsel->core.system_wide)
>                                 pid =3D perf_thread_map__pid(threads, thr=
ead);
>
> --
> 2.51.0.rc0.155.g4a0f42376b-goog
>
