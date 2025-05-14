Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83661B0F2C
	for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235157; cv=none; b=n4Azyeqyb2BnUMWvN1NJSZPDV5w7TTnLE/kp1k0CiN9LKNk4QZAxI+Q27gz8cLVOkgox1svGc7aCvgz369ao5YRqtA+vdguLk/R3pu95w6DDj11OE9yL2sRxAL0ieBUpgZoDK0z9Vmah76VfRpB9d6Xdas9cxZcXObhAPuuUxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235157; c=relaxed/simple;
	bh=zRHXtSXUEZEEK3PTfkjYgUsuNXEAzDR8CZiqeWbwF34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyrBchmsnB4CdQBsuO74H55z1CgjTwNT+2RMoULQ2o2soqoV8zlVIsPFWTIeO0W4FFwvNpaexP7PUGQFxWDfECmzuHf52hxyzQlV/f97z9qmQXOF9+lYjPAh9vR5/WNuIVkbiEICM2q8ZbnreU413zFlXpIhz8WiFSv3e6rALRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GcEgDbMo; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcEgDbMo"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so177465ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747235155; x=1747839955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBwEDCsbuMxxVbCaLe0ZDfbDjJ026rxYJRU1vXl/qr4=;
        b=GcEgDbMoFMDt8RNGLXom+WFmtoKUGJKpwa+Dyi9JUI3kH1QKAnU25HgQ/2Tkln3kAq
         LN952blIFVLVMp3RrAw950LiRwXfPayoew5IzNU7eBkEDnMwnZ4bUyx0pTQN68zQGldv
         4SGDg/9EyKbIlrHMzlJrpDndz47Lrd8BdEMci9bBpAhzqk+YQs0E306dK9QhkVLHlqE2
         jU3WAIBA3mPKHVNURDf9uDy9JE6Um0MRK+bKEM5q/YXeKebNLr1ajkRWr5uhQkW09GGj
         IZFVYyfMs4ggQrbzBKGMa2KxQRVxIuVggGbSofqVA40k+dndYsdfhIorUCwOYXdEpDGk
         CB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747235155; x=1747839955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBwEDCsbuMxxVbCaLe0ZDfbDjJ026rxYJRU1vXl/qr4=;
        b=CsKZkCd9zGS/fuHzLZGthiAQofxAN+X+rk4GWw6QjpzFpIgPleTFjJOgq/y6oV+GIW
         8VHjxx9TcU4wZzdXhvVNfRW6nZTo/DI9qzGtGkruImgvmkJwcMKIq4ujby6Eu9CttlIW
         4j6hiehWiq5dmuE/yh9TXbuZ9ijxbZD9ggB3gOtFreD6pnZPyDfZC3qDRfTFSHZRP8Zv
         f4/1XirfB7600+lC/znMpLZ3gREFkb+leiyfLgLgJnGWQKj97xoVe0te3auqRIL3IVYZ
         cdZzP3yuvn+am1XioGRdl+MTyRG9wwYBzGeI7hxObye2q6Yi+Url6kQJpBIFqGmgeiLz
         Japg==
X-Forwarded-Encrypted: i=1; AJvYcCVFrWXForTTEbeztw30kDItJFizp+zwbrq1y64VSWcEaZFjlMt1tD/PHOsPB0+uD1lefa+k57mij8FBGvx52csb@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLWIoDjGNk/wviOloqwhJm1YsTqb0M3DeS7rcp7iINU0ck4a8
	QMhd43ANdknzXaBH+hC9CQCgkH6Nbn7irghl1TVoPdRmkWV4rz/ixi0G68hZ4jHc78qaA9BBw5v
	ukWT1p56mQfFfT88z4oVQzoQJ3ZlXp1SyMWRfDY89
X-Gm-Gg: ASbGnculvgxmKt1A+1/Lz9/JGgDYIzGx96yrtepWQs5d5SCH5/Qr7+k8kkRs4l7ker3
	mZg2a/x9JaTOEi+8lwEXsq2/1X1LKfBdzlAaMC1qoFzWvR5ttLobEybJQMRl1evuGFg/51mwXQn
	oZkFe+mqTglSHL+uRWt0O7QClIaBLZzHHKmfv+c5w9A0thWVjm5q3jvWfqKRbpLg==
X-Google-Smtp-Source: AGHT+IHI/F+qf+jjIVI/t0RACaAA5362bq72lQw/BShbJITOcV6N2SAlxkQFjmupoAJ6GQBB/mbrwIOCeXIztyL6nGg=
X-Received: by 2002:a05:6e02:17c9:b0:3d9:6e2d:c7ed with SMTP id
 e9e14a558f8ab-3db706435a0mr3229695ab.15.1747235154528; Wed, 14 May 2025
 08:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513231813.13846-1-thomas.falcon@intel.com>
In-Reply-To: <20250513231813.13846-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 May 2025 08:05:43 -0700
X-Gm-Features: AX0GCFtnwnSh7WBr6q1x7iyJ1LE0u_2hQI7GYeSBL4LD5fFxhKoET9QpVquX4y0
Message-ID: <CAP-5=fXJtkjJ34d-Rk_APUxXuummZpwPWawUWea3NHMaRFCD3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 v1] perf: move perf_pmus__find_core_pmu() prototype to pmus.h
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 4:18=E2=80=AFPM Thomas Falcon <thomas.falcon@intel.=
com> wrote:
>
> perf_pmus__find_core_pmu() is implemented in util/pmus.c but its
> prototpye is in util/pmu.h. Move it to util/pmus.h.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/pmu.h  | 1 -
>  tools/perf/util/pmus.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index a1fdd6d50c53..d38a63ba4583 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -298,7 +298,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *p=
mus, int dirfd, const char
>                                   bool eager_load);
>  struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head =
*core_pmus);
>  void perf_pmu__delete(struct perf_pmu *pmu);
> -struct perf_pmu *perf_pmus__find_core_pmu(void);
>
>  const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)=
;
>  bool perf_pmu__is_fake(const struct perf_pmu *pmu);
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 8def20e615ad..d6a8d95af376 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -33,5 +33,6 @@ struct perf_pmu *perf_pmus__add_test_hwmon_pmu(int hwmo=
n_dir,
>                                                const char *sysfs_name,
>                                                const char *name);
>  struct perf_pmu *perf_pmus__fake_pmu(void);
> +struct perf_pmu *perf_pmus__find_core_pmu(void);
>
>  #endif /* __PMUS_H */
> --
> 2.49.0
>
