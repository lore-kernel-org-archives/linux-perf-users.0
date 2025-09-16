Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3C2D6E4C
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054248; cv=none; b=kS3yC93Kcqr70/hr7DyargdJBWUjaOaA/u7Lm2jHTU7gwBXfoLbBtQjAs9b9QIUKqMZI2fV3NSP2LKo5b9grEUgUN41mi7axSvMw0kONaGxAOmUTEFHL8xLDGAMCPqfs5W7yEP0VM45mqIiTfDP//f+aO4bx9WFJQfFFkLCbIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054248; c=relaxed/simple;
	bh=Q4zFebQ9rnwof96T42+3VrrD5adTEApSj8dU5zmJ32w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCj+Y4ceMEoZQqgaqBmtm3ZuUDenM0mNyZfRw/DpE/aIDNWyPHAcH9uCn6NwM4z6tvQq62B6tQ7Fq+qFd8+dS5/qqm38lWOKIKSmwNa9tb/kbXcDz+bz00XYnNj9HzhY1MG6gCS0R50C0Yt0XZeIi6pgQi9D/Xo8d7t6sfYqDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rk0AyCV7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rk0AyCV7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2637b6e9149so18605ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758054246; x=1758659046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XwuNMaNf7pkd+lgKxPWtZffQGnjuhEb+6J3mJn1H5o=;
        b=rk0AyCV7JOnYoqEMwCk2wtLio4zPKm29omhSwW3eTOj1KnRaf04RpWvIr9v0VGLv3g
         h7W915SHblGvSAdIREeiq70M4xhqqakkSmLe20p9MCrVOQQOvFQ2ZrAalLtkILi++k2I
         KUy97jBPmAASQ/a4X/1eZj5XkcxCkO5jc1+lWWPUyGDp7zAi8a8oDNr0y8jF+KxFSMDd
         CqkbAvtedgOaJaVxUre9ovPcSTWIDBLJR8CmnJLJfaR7yuBKj2+m3k8Ga9sbqmUidu0P
         AM8P6qWzxH0Uv2wSuoIZ6ECe3IfsLQwh4xB/mt160ulAdzUlJkKYgaTIIiw/2EjRNqJ8
         glDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758054246; x=1758659046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XwuNMaNf7pkd+lgKxPWtZffQGnjuhEb+6J3mJn1H5o=;
        b=qRwsIzsvJS5FEmYSGftwDh7jhm4knvwsx7i7UGS+jgnFKuLOb6aqxkU8apwOnpdhF1
         6dRPrrozCQtBtb0YJxWUxJJYI87TG816lR0LA5DvHKmeqLCdODw5k2lU6jnN+B9jpisH
         QnCFPoLg8jgjyUohMmiBJgjeEMaJL/UxTDrixgYhxMhyECJ3xpXA2d7Z31MV8CLLJFE/
         yB20unOKXy73mBB9My0fZMlIe8sH7OPwYblm+S+zl25zY5tce/c41sYj+qVQkDG08Ikr
         yrPrICAF1AujBaSORix7g6Rcqjh6b5gn0k8Ge0/tXxsPKpUMBqx0uZQK799hZvuLNWLN
         2vGw==
X-Gm-Message-State: AOJu0Yw/N+ULsFNBX5iDwGifH7HZPOTFsNefE6BZ7NJ9tMdvLtfIjGU7
	dvAVgcRikFNSG1y3IcEu142TycD9xmWp965qHj+D+C1tmlgU8LfhfYZE6jGm5MRr2dxKOT9dHcj
	8BTPpCdRwp6jxCUdd6pHi4BNj1TERhbPcSet6NppC
X-Gm-Gg: ASbGnctaSteWhP2EaE85VEJmeVXYXhIHDNeqN8z/02UNxpTdSsq5bsOCNRq29LuXGcH
	+6a2EGVrRZjMAtpeTb9pRtKO4Lg2r7s8MrFrjcHMi4MPm4sfiZCfSrmmgoC3U3hpkTdod6l0v5G
	2qllIkiF27V1KqTPjdtJZlxu9GeZ2g8ori1G7CC6aORgUq93Kn/CYaJe8kXGVGOZ2h6Dd4y89ss
	5fDAPpoLg0fNDRxVFre4WDbUN6nQQpwzd8FsO7Bf8CyPIu4WTNAtxsHi/Ly5g8NWw==
X-Google-Smtp-Source: AGHT+IENGPU+1xv66Y8XBNW9DYrz4RbTDGa4tjo9ronOzLZHXIaQApHEQV3W6rSYteXQZ+hhHERWsgL+kse6q6Wbezw=
X-Received: by 2002:a17:903:41c3:b0:25d:c405:132e with SMTP id
 d9443c01a7336-26800f4d873mr1222895ad.12.1758054245556; Tue, 16 Sep 2025
 13:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916193046.10054-1-tallison@redhat.com>
In-Reply-To: <20250916193046.10054-1-tallison@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Sep 2025 13:23:54 -0700
X-Gm-Features: AS18NWDadalivTAKRNmrEJbyqD_QidejZEaIW02iHo4R5RZEGFqbweL4U7VX2zA
Message-ID: <CAP-5=fXdxNLA4Ey51HdMCrY0SZuzp1WUc5A+n9EFLtaajtYEiA@mail.gmail.com>
Subject: Re: [PATCH] perf test attr: Add missing int_mist.uop_dropping event
 to test-stat files
To: Trevor Allison <tallison@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:31=E2=80=AFPM Trevor Allison <tallison@redhat.co=
m> wrote:
>
> Setup struct perf-event-attr test was failing on EMR cpu because perf sta=
t
> was providing an event that was not included in the test. Type 4 Config 4=
269
> or 10ad, int_misc.uop_dropping.
>
> Add event type=3D4 config=3D4269 to test-stat-default and test-stat-detai=
led-*
> files with optional=3D1 so EMR machines can pass test
>
> Signed-off-by: Trevor Allison <tallison@redhat.com>

Thanks! I wonder why this wasn't seen on SapphireRapids.

Reviewed-by: Ian Rogers <irogers@google.com>
Fixes: 50e2eb259650 perf vendor events: Update emeraldrapids events/metrics

Ian

> ---
>  tools/perf/tests/shell/attr/test-stat-default    | 7 +++++++
>  tools/perf/tests/shell/attr/test-stat-detailed-1 | 7 +++++++
>  tools/perf/tests/shell/attr/test-stat-detailed-2 | 7 +++++++
>  tools/perf/tests/shell/attr/test-stat-detailed-3 | 7 +++++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/tools/perf/tests/shell/attr/test-stat-default b/tools/perf/t=
ests/shell/attr/test-stat-default
> index e47fb4944679..8dd27c1fb661 100644
> --- a/tools/perf/tests/shell/attr/test-stat-default
> +++ b/tools/perf/tests/shell/attr/test-stat-default
> @@ -227,3 +227,10 @@ fd=3D28
>  type=3D4
>  config=3D270
>  optional=3D1
> +
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> +[event29:base-stat]
> +fd=3D29
> +type=3D4
> +config=3D4269
> +optional=3D1
> \ No newline at end of file
> diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-1 b/tools/per=
f/tests/shell/attr/test-stat-detailed-1
> index 3d500d3e0c5c..12a2ebf4e64a 100644
> --- a/tools/perf/tests/shell/attr/test-stat-detailed-1
> +++ b/tools/perf/tests/shell/attr/test-stat-detailed-1
> @@ -269,3 +269,10 @@ fd=3D32
>  type=3D3
>  config=3D65538
>  optional=3D1
> +
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> +[event33:base-stat]
> +fd=3D33
> +type=3D4
> +config=3D4269
> +optional=3D1
> \ No newline at end of file
> diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-2 b/tools/per=
f/tests/shell/attr/test-stat-detailed-2
> index 01777a63752f..66ea25b7d38f 100644
> --- a/tools/perf/tests/shell/attr/test-stat-detailed-2
> +++ b/tools/perf/tests/shell/attr/test-stat-detailed-2
> @@ -329,3 +329,10 @@ fd=3D38
>  type=3D3
>  config=3D65540
>  optional=3D1
> +
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> +[event39:base-stat]
> +fd=3D39
> +type=3D4
> +config=3D4269
> +optional=3D1
> \ No newline at end of file
> diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-3 b/tools/per=
f/tests/shell/attr/test-stat-detailed-3
> index 8400abd7e1e4..4a27bbfb9f87 100644
> --- a/tools/perf/tests/shell/attr/test-stat-detailed-3
> +++ b/tools/perf/tests/shell/attr/test-stat-detailed-3
> @@ -349,3 +349,10 @@ fd=3D40
>  type=3D3
>  config=3D66048
>  optional=3D1
> +
> +# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
> +[event41:base-stat]
> +fd=3D41
> +type=3D4
> +config=3D4269
> +optional=3D1
> \ No newline at end of file
> --
> 2.39.5 (Apple Git-154)
>
