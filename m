Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C143D3326
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956859; cv=pass; b=kFApqldehTx8HgWtHsRRFXAJ3GbD50N+6LhVCX3mztaLVSoArQ6CfrMbiINajq3Jc9kDR5rSpAHTer+nZJAWjBEk3FrGhOqGUELzr5E1jA76f8Tt3Lo+cH8OHbGgSsSo4doXOs33B3sM3ZVBqwDgIE5Cmljl2Dq0Kw991G9Q1u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956859; c=relaxed/simple;
	bh=gEWVlW/j1dYCq4ooAxJc70ILyIct3UK57IkN1i8Dt1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBnPF7ODI4AXlRUDceRVBv+JjwWP2J9SYb55qfTWU7AqePVW8AmP2Mo6dDYHZfGke9vGtseKFtxNJkFAHgk0qwzuH8HZgFmWR6AJfJ20xHYTO4lcOMTeNjfS/28pgt3SuFs8F6zKVECEb4bCn8LBCZ5Cl8BvcSxbgl2Z++Yqyvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zh+6CdlA; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zh+6CdlA"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10ed63c0so52811cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 12:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785956856; cv=none;
        d=google.com; s=arc-20260327;
        b=f5junKnQH+IeMOziLBjqRSLSfxQMRbuAvuCbg1SgG90ipIzI4mXIgq6+lLc3V7qUwO
         3CIBhpp+UyT/HOa5OIa+MQ8djVA+vJ0L0s9uw0F1WljGtJG6iZYn8TVLPFKDe6keuG8p
         n+LY6xBzo/8qwAF3cBiswqGCN+lF6XDlq4iqNQ5fiCYKG0RSWCPtbpqM7zOiuEOrPXYU
         WGGehUms8DTMwuJ4pZbOwyyn9VweCb8cU5Qs9Q31sgkJLLqIvgGoRC2fWQ7lQ+W2Iwge
         +lRgfJ9z2DaMNXpjQRFc0Qis7uCrFC0FX3f3vyjxH3I/jnsGL8Gm8HKHM94QEQXMzvf/
         gPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BM9mMDhmrBgxv4uxHoWZ/BZ+gXFjM7aR1C3cbVvwUrk=;
        fh=6mV7QiA0NuvTnkq8V4Law/BDmwPlDLaHfo4qftw0u7U=;
        b=QLWmc4XF+/asHEAfxMSb1mUwjcj/bMufxjP84dDohki+8ONR6uhFBa3lam+SF4WPzG
         LEckRlkB3WjnkRSHufX1w7+obesfd3VHqN3KNqwv9ceTbhpXpyIhg0kx132UNnyyHlZx
         XHFpJYEVDhyOmq3V3F+FrnbHacWENc1fobwyfMCsSQ4mRaOXP80e+kw4NF2Q8EioLEYA
         7wp2BhIX8HR8LkaD/Kll1WYlRhfgYWH6VzVHHCa7jhqH0cNLeTEmpNHODByZNdf0YmBt
         /BjZMxLL6E0rLfZiiD/REcGlvYZur9+HMG+kXnJm2CfCjPCOG45H4+DCfgCH7x/dUob9
         0/Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785956856; x=1786561656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BM9mMDhmrBgxv4uxHoWZ/BZ+gXFjM7aR1C3cbVvwUrk=;
        b=Zh+6CdlARXSZ/yFOc/WdwnWU1ynHFvXTFcTvhFV+BhLG/yBoXA8wbitZ1jCiZiD+6D
         lHp5WGsa5zR3ytb0+is5jy+v4kIe5LojV1yX9dI5g0KOX0avaTanZEgSHvNN9t0k6cTD
         YkuoamgoC0SDdDWOyq5n4vfRWcUQJcNe2d5Q4/DyZbj0kuzPuyLKWl1DNv1XtutSM4LT
         dtBcREwixgWvWiudrW1wGhL4sJxbPu7VTqyj9zVeWV0RXx/qiiKRkuePllX7hrp+734R
         PtHjOgiadtolGt8KPQqS4jYLoOymDuy2GNedno9p7jioZdAQ1EMbMpD2nFSJlXycpwA3
         Yzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785956856; x=1786561656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BM9mMDhmrBgxv4uxHoWZ/BZ+gXFjM7aR1C3cbVvwUrk=;
        b=l72RdyaA8a/FoY9MovKtfI+pAwiJgWmGBlQuuJJc0t0BDNueY0jhmmfOWUQI16rfDz
         +45LMIZsK/4E6BwRz7XBweEo//+Jqc5+gml701rEHLCaLwe/ZY9V1WqX/FcYv1a9ctZM
         PhEkSYqI4SNxucCR4zBiMkCelxzj93Hdm091mQVvPehy4ZOdNti8wJE1rphPKLhmiyyV
         Z0poT36LxmDW7Ta1uKYYsKonRv8kTdHsNQi5oB/9y7Y4hfHGNj3DZxrlgb+8S7uKIUll
         yzZhsTKu9Dk3MYZ9rvEfT5E0EW+9eHjCuAIV9cslGSfS1nH3bzsCxz47W+8aQs9XUA/b
         Iuyw==
X-Forwarded-Encrypted: i=1; AHgh+RrAztv+yZny/6aLDkBXFKOMbXZiCPot1lRJnn4WUtcVWWEcVOKT0tWgxTjamefuR+BjHBXvqbwcComVM+82eTKv@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+HsZ0GYUCN1B7C2rMXFw37ut4DZ4f8BoqjXuMxg3uI8TyhNJ
	Xns3VFhHm10wRiyYYC1f8wDfnrvMU5QvqRKYpTAZH2xHIs+ZidCcGmw1Xjp/8hBlm7iYcLby76L
	/56zu5NP5ZTPQ+ObCDVg/vFCFi0sXwpv7QSE5NwM6zzVJxdD1PqBG5lluvxU=
X-Gm-Gg: AR+sD13n86y69/YHi0P9I/PVMXoZfUK119QxOBMQbItiiNfEaf8npyRdBMkzx1asJvI
	80WE0/gc98uFwnw24ZCHzQB7N5ilZL0apKid7RzDi3qK7q2+gXRZaebWnzVrH8ly3YmmFDxwB+3
	iz+qmhIDZjktR/qeUahG3Nik2RctWTbbzOpOjauv4v9j1o7IWneJniNvVwB4tl0VR4yot5Xd1ma
	Q3pDgYtyDaxslnfGAt5lejBVARuNb/9Ni/tAXQM0e1xsuSf/52b13s/8YnTkGPFWcdmQ6tGbkYk
	0UUipQZmLDMMwU7jundV6KvO99C7Xrgr/HX0zKKmOHhDzw==
X-Received: by 2002:ac8:5d54:0:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-52cfc1176damr2502661cf.11.1785956855632; Wed, 05 Aug 2026
 12:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-6-acme@kernel.org>
In-Reply-To: <20260805133013.235016-6-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 12:07:23 -0700
X-Gm-Features: AUfX_mwIvJ95fvfFRgBHQKe1T077MGjoO95SRFzQmdxWZdeXHsd3tcfF9DEGluY
Message-ID: <CAP-5=fXRei4AivX_RcqR4xjmLtbYuNsJALOzJMAWvy7HCU09Dg@mail.gmail.com>
Subject: Re: [PATCH 05/12] perf jitdump: Check snprintf return before
 computing header size
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> snprintf() returns the would-have-been length on truncation.  When the
> jitted filename exceeds PATH_MAX, the unclamped 'size' value inflates
> sizeof(event->mmap2.filename) - size into a massive underflow, causing
> the header.size computation to write an oversized header.  The
> subsequent write to 'id =3D event + header.size - idr_size' then corrupts
> the heap.
>
> Clamp size to PATH_MAX - 1 after snprintf in both jit_repipe_code_load()
> and jit_repipe_code_move().
>
> Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/jitdump.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 078d3304d2b7ebce..fd11e07bf00b7978 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -493,6 +493,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>                         jd->dir,
>                         nspid,
>                         count);
> +       /* snprintf returns would-be length on truncation, clamp to buffe=
r */
> +       if (size >=3D PATH_MAX)
> +               size =3D PATH_MAX - 1;

Given the recent fixes to reading /proc/pid/maps where it was assumed
the file paths would be limited to PATH_MAX and it turns out that
PATH_MAX doesn't really do that and we had potential buffer overruns
during synthesis, I wonder it would be more intention revealing here
to use "sizeof(event->mmap2.filename)" rather than PATH_MAX. Other
than the constant used, I agree with the change and using PATH_MAX
isn't wrong.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
>         size++; /* for \0 */
>
> @@ -623,6 +626,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)
>                  jd->dir,
>                  nspid,
>                  jr->move.code_index);
> +       /* snprintf returns would-be length on truncation, clamp to buffe=
r */
> +       if (size >=3D PATH_MAX)
> +               size =3D PATH_MAX - 1;
>
>         size++; /* for \0 */
>
> --
> 2.55.0
>
