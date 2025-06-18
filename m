Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087C3085B0
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270432; cv=none; b=OtMZG0lbmYCMyI9uPGwUzAilZ1M+uZQJe11tYDIzEpDuMFezYiJ3MoyN76lLvGbz4XJfHJx3Ue03aLso9+Q7WRkFh30lTgJLFZCMHgPzyzj/eUXdQXZOukfUkMMXOOoGEG/r9KIYyLSnZwV5Z4xS/Y9rZ5hMZknBzn6EfcTb6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270432; c=relaxed/simple;
	bh=2PlPG37A1hQiRUBqK5yk/+JFqsKLcVwWJA06Xqdws9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2HMiwxRA7OME8yQCPsvE7r0L6YP+I+LW1U03XUXdI2AHjFLINTdaZgEZgpDeXbhd+eE0klzmu7ZVyX4j975Dk4TPpHxf5e2LshNjxOOu6XrmW+MRt3sX7XjEtWlREc1osZjygm0OJkCMBpg3lypoPneW5rcQBfaCD8aO+LwJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tukQoIqz; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tukQoIqz"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so21415ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750270430; x=1750875230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZt2bPVguUP9Jit1GpdEmOTWFmDL0oG4TSpHkRQ4E8Y=;
        b=tukQoIqza+JHiQGuBiwKewp95alhNtYc48/522dqdFMcgNye1WJmNlHKhSzs5gksPy
         HgflFgFONVXKYQ1tAEsjOxneX+c4f6e3X+9K+4ibqqu4fQEM7LPw+m/pe1vSVLxu3HMJ
         xCTIQY2bMQa0ErDRV8x3K030JLoOJ+7e9Qb8rKVeGJvEyxEOm4IJA/uBulQfmaD9WvtN
         1vY310kGQeh0ana4/ijwEnKH6PMWQf+i6ThxJ0BLQFrlBcGw79SRpQWUYl05OBI2auxS
         VLiGVR4crTLTezq/sKgjn4IlSPdMFN1pXnvhZIWkWFS7ToLeUEX21vs7jzr7aUyuDmpu
         9t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750270430; x=1750875230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZt2bPVguUP9Jit1GpdEmOTWFmDL0oG4TSpHkRQ4E8Y=;
        b=CCkIbiPFNYsgX6lDoYusbVJlEuv/jZ3rjTNsBGvQJiCF5rYgnYecT9gGgXSJ8q2fRt
         HN5CFOUgOqyY5LFJWsRW5TfumtXIEkdmIGU6+Sc5QJQNpaZ3HvfkU5hpuKCG0fqft0I+
         C9f4vg1x2lpxnyeuF6FxBWhQRVn54m/JRLvyMfIz+i+9yX7dcq6GhlpJtn5l4yHobyVb
         mRv9rU5PaO5zXks6yF5rUGVyldc/KlwA9Y8iJxVHejc+aCE5T7z/QYElKnxQq5cPQC84
         19ipwci5spqEIRz2fXJKnuj9WpZGul1ez+pKfmGbCHkjglEYLoaarSa06FT3rtYv4Wka
         +4Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWw1bTMPfPm5LzFqkZfsXgsF2gjKKeXpnj5mUxm7G8jzRWXTF1uQnqC5DkVbwYWDLoj+gaRzi5mJ3mP7s1xvYZE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8E7q7mnG1IzFUB0PfJrHO4NKGKu7YZHbEguF48GFnV+EuCLB
	adQRdDZlMjjTo52d+PJvtrLaRRc7cP98R/AjXk8zQzVRTq00znYSBO22nHFmU7IQK5uQRdiTOY2
	j8Z5FQX4tiTCAYMNrpsa3fOGRLrIq1ZOliiDecxwB
X-Gm-Gg: ASbGncu9HzV/Yosg2EGgT1B8ksfTFu+jf+ohK3Cro3hPSYBg1R2LQYZk4yU8vlKb7GM
	khxbQaOTAxt6rTNyTuxuvo6I7v/7dxLraRo74yIAwtJ+T1LN2juVXHkunYCo9uMTCuw9/mQiatt
	9aY2nB+iMdEtrQPQe7RPJBr/PUdThtB2E4AVGNTtvJ9W0PSaUT1KPoVhGnVBQ6caTMF8Nmc7CC
X-Google-Smtp-Source: AGHT+IE0Lw8MGm2ZaBXHhDLD2oEzCVtJMwgzvD5xMmQktf4MAlN9+lXnYgABgoqLt7JsoZTeODZtZvvJwfYGpnGCeC0=
X-Received: by 2002:a05:6e02:1fcd:b0:3dd:c9e4:d475 with SMTP id
 e9e14a558f8ab-3de309ea8c9mr189335ab.22.1750270429451; Wed, 18 Jun 2025
 11:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618142921.4053400-2-ashelat@redhat.com>
In-Reply-To: <20250618142921.4053400-2-ashelat@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Jun 2025 11:13:37 -0700
X-Gm-Features: AX0GCFtrD43jNQZeJZyei_8T-HbaPXt0kDWT1mvryWV3T8Y6YboCkrzsPt7GUjA
Message-ID: <CAP-5=fW5TMnb5zd5jf4g3G6CQgTGsVM2feX_rAr503T-ZAT2qg@mail.gmail.com>
Subject: Re: [PATCH] perf header: remove unecessary core id test
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 7:33=E2=80=AFAM Anubhav Shelat <ashelat@redhat.com>=
 wrote:
>
> It is possible for systems to have a greater socket id number than the
> number of cpus present on a machine, so this test is obselete and should
> be removed.
>
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

This looks good to me as discussed in:
https://lore.kernel.org/linux-perf-users/20250617150847.4029177-2-ashelat@r=
edhat.com/

Thanks,
Ian

> ---
>  tools/perf/util/header.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e3cdc3b7b4ab..d7f6ff6974aa 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2559,7 +2559,6 @@ static int process_cpu_topology(struct feat_fd *ff,=
 void *data __maybe_unused)
>         int cpu_nr =3D ff->ph->env.nr_cpus_avail;
>         u64 size =3D 0;
>         struct perf_header *ph =3D ff->ph;
> -       bool do_core_id_test =3D true;
>
>         ph->env.cpu =3D calloc(cpu_nr, sizeof(*ph->env.cpu));
>         if (!ph->env.cpu)
> @@ -2614,15 +2613,6 @@ static int process_cpu_topology(struct feat_fd *ff=
, void *data __maybe_unused)
>                 return 0;
>         }
>
> -       /* On s390 the socket_id number is not related to the numbers of =
cpus.
> -        * The socket_id number might be higher than the numbers of cpus.
> -        * This depends on the configuration.
> -        * AArch64 is the same.
> -        */
> -       if (ph->env.arch && (!strncmp(ph->env.arch, "s390", 4)
> -                         || !strncmp(ph->env.arch, "aarch64", 7)))
> -               do_core_id_test =3D false;
> -
>         for (i =3D 0; i < (u32)cpu_nr; i++) {
>                 if (do_read_u32(ff, &nr))
>                         goto free_cpu;
> @@ -2633,12 +2623,6 @@ static int process_cpu_topology(struct feat_fd *ff=
, void *data __maybe_unused)
>                 if (do_read_u32(ff, &nr))
>                         goto free_cpu;
>
> -               if (do_core_id_test && nr !=3D (u32)-1 && nr > (u32)cpu_n=
r) {
> -                       pr_debug("socket_id number is too big."
> -                                "You may need to upgrade the perf tool.\=
n");
> -                       goto free_cpu;
> -               }
> -
>                 ph->env.cpu[i].socket_id =3D nr;
>                 size +=3D sizeof(u32);
>         }
> --
> 2.49.0
>
