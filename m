Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B44F6482
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455115; cv=pass; b=HnXolksdEGp6zr5A+PsgDahlVeoVivii13so25ernwER6xFMn56es0Qkr+AqhfM9OC3/zr63h/JTuAdGIHpzOEB5yPMNZl5OC/4GGwO/1nE9Etv5XOEaW1bz1yqy/812LV+qmWlCEpbhwHhXgfnHszmzjoSiPZaLJawJpxtBCvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455115; c=relaxed/simple;
	bh=vlfKr5IE2AmvXuvkQWF5CvLsiSzdxYhNi70EsyDI0Lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMEmw5EgvNiB7FUSd7PEhAr9uJEUXvhuY2QQoPyenuOeFTqgavycSAIttsPJ+nMbIwKjpGXzSe5pLm03izrJpggVH9hBgAiFpSTDvfd/KtU/RGL5IZX8Ces4HGyePkrjPm/cUME5pxYACAS7SjVYtne7UwUQDIcDG+70z62GYJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOM80uqq; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOM80uqq"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so282271cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Sep 2026 10:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788455113; cv=none;
        d=google.com; s=arc-20260327;
        b=IZvDxZvOr4LDTtO+1ixVhjTbKU02EW2bTy+bnQHyhjwcYm6ssgObVelt0MLI155xVv
         TaN7YnqIfFht+e0OZPwdQLoFurCsaC3ve7H850fq1rfYfCgIusU8hIgmpIwDxqaNcOrp
         Hvc3AYPrCsLE9F1u6NCl3bwqqsxilhxVd6wiCzJpUoM0BgKfKZ/wv5Ll6C0CKebb5DE+
         +UEtt/fW1ldAqmxghUVIrSjJtY+PECgSG4y/lL1OqGOOkWQhOZZVp9MDrqRwe9Gsj3Oe
         palmb9AGnhHK2UtEWxNPs8FRO44iBe9chkbqatb3i4ZuzXNJ8NlO7CBrPOfV7MCrLvLq
         xBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TVZ6SKklgIyu/7/uPgJ03I/Ha/dghJOvVylq8CQpLeQ=;
        fh=myQiQxriMJmVskbKPhDVVqZQxOK6crbWUWzMvjJqDgk=;
        b=fG8oZOZaq0CatwIGcOLrwtMM133c7bU49x3Jj7HZL7OY7LUl7x+ABfdtmmQE3LWuoi
         0y1dFU/f1wOzDxKxOimrwd9hpruwD74frT/g1s169vUB3r6CCm+orJ65sIZ6xoxzja2K
         Xgc1kjEZboOPaVaUFQFHa8sUdPsfaKNovXQEPujY3X2LO8kD2yX/ROblhuQmMAuQJqWe
         19qqMCsgLdOq1KCOy2bJ1HF2+86YYS49ZCcpBZZ7DQzRXySSIN08c0Io34idr1pzRGRU
         6PLYhk9Ex/35JvUSNzGxxPJYwkbEC8YkyrcYy8XhqiQCMKv+pAJkJr51JzcTG6wsszyz
         sO2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788455113; x=1789059913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TVZ6SKklgIyu/7/uPgJ03I/Ha/dghJOvVylq8CQpLeQ=;
        b=tOM80uqq9p0+LHDAYKeRoMBBa6+l7BjvtD6ErlmtC/1TePtjSvOOQ0z5u+QUBht25U
         ut1Agc+ROWv9Fg4qYZG6jCduL7MDpYUrkyBcWGyjyD/3IcekNeB/3ddxiA++VbCc5CDC
         U6DFiTAGavGzu+HTkhgFLbrPH1do6gEFOwDJMOSsVM0K9ZofH+guIMq5MA9vO4nrFwsf
         HHHR6c4343RPQngxLAeRuo3t09MZbVrlTJzI0n10WKeXLsWKqFXMwpE8p/Bt6pc9wDX+
         ugGYF9ZMwSLggzNTHHBBAirBHNdj32CsIuZsJV0VNGeIp3dOCmPaYU2arQilXbnGwbc0
         feiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788455113; x=1789059913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TVZ6SKklgIyu/7/uPgJ03I/Ha/dghJOvVylq8CQpLeQ=;
        b=qWh4STZ9txzHh+zfU+D0N40c20ChrcAxw3qkGfPvr8aJvsUm4DKRT3b9a/9VOM8NHW
         bZ8gUyG2xYcqwgBRR/EMt/Qwe3P7ZlehnKhRKZxyGByTrnolC/IJZwkyvMItV/0plhpl
         e5LT0RrcoXrsxlyOkx5g5uU0p6xOWFRhCCgPxGIHhJtNEgTOpY7mqfeVtga2t78QRLFn
         ChG1y0mDW5hbxVsHzLU4MCRGxK2Z5CqB0BaZErJXZNdsYr02bN1nK5Dku92Unb7t9iHV
         /C1G03pbF0WAZLoC/nQrbN9ijm7Nv+V6zC2a+j7xPs/y7NPY4sik6Vka1GVKmqfqBrUk
         IZrA==
X-Forwarded-Encrypted: i=1; AKwUvByq52r8OV9cj75HGAGThX7PNGKPX/CHBikL81yMh8EvTLx3GPJCtkp8AmyHsKhQ32Q5IvFKIGD8RuRFSX0Xbi2i@vger.kernel.org
X-Gm-Message-State: AFuF++mfIVY5wV8UXq6t1O2YrvqQ9yk36TooQ9sCJvABUFi4Prl4Tbin
	OSXyMpOnWlof5l5WWkOjnbcseNY9LFjyMKbuFYkJfFMZaACp8a8gbzlbT+VDaYDK11XqumY2UV2
	EuqC/bvvc+BWDC1vHc17k2QZIrojlTTWWNzweuKOO
X-Gm-Gg: AYBFou1cKpAzXwvpQyODSRtQ8251QjQ6b03HHTLKDnRwG08BkSZUyfyAkm3PCvh0rY/
	LDgJP2JvJHtAMAJgH5Lhv0j9eSeFWrqBQ71ApiqGjvAMml2V7+st5GOVYLp2tIIWyDn6KYQybKB
	1xM5hloJCX9Nsi/sXQM+KcFMA6eKNsoue4iZrVd9jHscZCCxJ9uucaw49PWgtvm27sDcbEWd/8v
	EdmhIP1HvOO8tgcGuKJinNPkSIH8y49yxKhsvgow4ugUPSv8terHWbudweiPUKL0JpsQYDLu0QP
	sXaYTvChk5ilansaqoOFlEM0Zr5aRGk+m6CvmINoMnHhCzFzhUYAa5/LWWVGK/RYsN9rEA/8aA=
	=
X-Received: by 2002:a05:622a:4d92:b0:530:2d11:3e60 with SMTP id
 d75a77b69052e-53045849e54mr19391961cf.5.1788455111801; Thu, 03 Sep 2026
 10:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903132251.237029-1-acme@kernel.org> <20260903132251.237029-4-acme@kernel.org>
In-Reply-To: <20260903132251.237029-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Sep 2026 10:05:00 -0700
X-Gm-Features: AcwNN1WB6xM_NdmEDMnNnGegUJPuOH6fOdzT6FDe_1g-Nf4qfRoHyuVKpGMTrHc
Message-ID: <CAP-5=fUsp9w-AUQw3jLnS_rnGiJn42yqw4OCiJ_NBz_JeTv8oQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf jitdump: Free unwinding data even when
 eh_frame_hdr_size is zero
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 6:23=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> jit_repipe_code_load() only cleared the unwinding state when both
> unwinding_data and eh_frame_hdr_size were set.  When a record carries
> unwinding data but eh_frame_hdr_size is 0, the cleanup condition fails
> and the unwinding state persists in jd, being applied to all subsequent
> JIT_CODE_LOAD and JIT_CODE_MOVE records, duplicating unwinding sections
> in the generated ELF files and inflating their event->mmap2.len.
>
> The record is validated upstream so eh_frame_hdr_size <=3D unwinding_size
> always holds.  Free the unwinding data based on the data pointer alone.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/jitdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index e0d5cc9a828189a2..efb40d93e33ae664 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -530,7 +530,7 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>                 jd->nr_debug_entries =3D 0;
>         }
>
> -       if (jd->unwinding_data && jd->eh_frame_hdr_size) {
> +       if (jd->unwinding_data) {
>                 zfree(&jd->unwinding_data);
>                 jd->eh_frame_hdr_size =3D 0;
>                 jd->unwinding_mapped_size =3D 0;
> --
> 2.55.0
>
