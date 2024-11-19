Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E101C1F2C
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732058204; cv=none; b=G8DK3q0Kg/8SWDcANKkHRX+d0gibdLcQ5u+RarPYgtO6+y4QatkCgjb54cuEhtvlA6o8aBERQRkDzQ6SjHn+qs0u2N7TMHyqqoCtc8IFT79qLtuMwaAn8Sz+LmxucF1+ydM9BPGlG3dYRIWnjZZjAaToA/esp3MHQzNdaX3XvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732058204; c=relaxed/simple;
	bh=gJVYi3jm77VpqhVfMseqvv+8fgAUOv5rTQPWXtguMXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgDGB772/hpmzmk4kmNI1qGHv0i2KIrRx9ia1gEcLR4VxBLegiBdSjUpARvSOBm8129nj2aV8yrejlHs0Ka9t2tkMCXwnYfTQz0mNIm1p76HTn0/61i5CNUmsMGbARUJ6v4WkB9iTi+gS9CRSGECXSE5aYL5znSK9YGm2kM2r3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i91ZN6N1; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i91ZN6N1"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so202645ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732058202; x=1732663002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVnhxKRj40qafR8ARBDWNX+xTYjxRZzrf4WtxCS1dp8=;
        b=i91ZN6N1nBsv64RMS23VFe3gDUxFPbFEad+QmeAsktVJfrk3IS+3ZVMSGxxHquhctS
         n4OU/e3Ve4Gn55+pox9y1sVabABizdigoxJ54z2TMy5ht6ns4CNo5TG4Lyt2HXNQC9Xb
         dc2S6GRhYDxMSPQ5FYeqH934AFXeGDxkRhff82gu8wu59BgFizxUnM9rblE3+0H6Gf36
         W7VMwyOdhs/EJJYAjCpacls6aMlVEmqjx7sfK0qJ/1r5PHujeeXYV4UxgM7pfoD7ql4V
         +pGrVuAxwaeTuzkEejQTSXSoHyaGKttZ9gILTnKyBciLkN+V2AC8zDEWB0XwCnerCcqH
         JOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732058202; x=1732663002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVnhxKRj40qafR8ARBDWNX+xTYjxRZzrf4WtxCS1dp8=;
        b=kGJVgTRPE30PSVZxC9y1NuuLvKFrxTSZm5ul+c4Z4nNnxNFeWW88/XStJsQ3wVIat1
         xsE3glB+O1EQ0pXnayTanzxNpqEOGpUxA1PebOX/04jT+ZSmgSHCLVZEqczQcs0fg67V
         bA+lfOfzZHU97m35b/d7unZIgJfnOiX2eIyjrMMpLn31p/3qkRRivaUS7qxKnbtevtXf
         EJVsNG42S+e90p1NABEL2iwp6I4cT4P4tGD+Hq6bErwJTLlFzOGR025TIL3S6W1V0o3h
         MU+a4gYy89K1N4l3ne//2bxzNaksQ/FuhY6B12ZL+NWhKMg2DwC/hPcL+ex3VCSTFHyK
         lcyA==
X-Forwarded-Encrypted: i=1; AJvYcCUcz7rkzpTAjsUmWMEq6cUdVR6WmVjCRWhsf9beRPTPCIICvaZXasQ9ZUSkfVMtbrhtWQcCs6xjyuLAqywa2WqQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29mzZcayj7HHS+C7qSsi6G8pttadbZSeICFC+4lSmv+aie/CV
	VnV0kEExuv1pBiC6bhPg8FwLO4+sfqte2yVayntBfOmQflyPzyILcnaV5Y1DG0sQaAer7J0A085
	BlbtVPwxWzdq8OfWsqMTpS27aR3ICSNpXg42O
X-Gm-Gg: ASbGncua/j7GgU+DPzyOJPRfyDG77P7s3kZwHWIw3rRkfk3bOUy4Lc2C3ys5UG66OE0
	0N37koy8N0mpDhR10q4QOrnFTVZAmspvJxKnled0zrsoW7fZsiR2lL6z91a+njZ0=
X-Google-Smtp-Source: AGHT+IE4kxt+RM91kdha5M+O5Kblvww1VGaxV1RtvZbt6tpYdKEVnjqJ6hETp11EO4U/zF94NtUJtoqNhSDu060F6JI=
X-Received: by 2002:a05:6e02:1d8a:b0:3a7:683e:2fc7 with SMTP id
 e9e14a558f8ab-3a7859160ffmr1463305ab.4.1732058201842; Tue, 19 Nov 2024
 15:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117080446.182201-1-guanjing@cmss.chinamobile.com>
In-Reply-To: <20241117080446.182201-1-guanjing@cmss.chinamobile.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Nov 2024 15:16:30 -0800
Message-ID: <CAP-5=fW-e=YPgVMYGY_8cV9-+L83dEx_s1asoAoz62bX=kEfVw@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests: Fix unsigned comparison with less than zero
To: guanjing <guanjing@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	mpetlan@redhat.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:24=E2=80=AFPM guanjing <guanjing@cmss.chinamobil=
e.com> wrote:
>
> The return value from the call to readlink() is not unsigned.
> However, the return value is being assigned to an size_t
> variable 'len', so making 'len' an ssize_t.
>
> Eliminate the following coccicheck warning:
>
> tools/perf/tests/tests-scripts.c:181:5-8: WARNING:
> Unsigned expression compared with zero: len < 0
>
> Fixes: 964461ee370f ("perf tests: Run time generate shell test suites")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Thanks, there is already an outstanding fix for this:
https://lore.kernel.org/lkml/20241115091527.128923-1-jiapeng.chong@linux.al=
ibaba.com/

Ian

> ---
>  tools/perf/tests/tests-scripts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index cf3ae0c1d871..1d5759d08141 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -174,7 +174,7 @@ static void append_script(int dir_fd, const char *nam=
e, char *desc,
>         char filename[PATH_MAX], link[128];
>         struct test_suite *test_suite, **result_tmp;
>         struct test_case *tests;
> -       size_t len;
> +       ssize_t len;
>         char *exclusive;
>
>         snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> --
> 2.33.0
>
>
>
>
