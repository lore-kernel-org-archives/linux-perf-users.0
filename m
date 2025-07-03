Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BD226D04
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Jul 2025 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512223; cv=none; b=PnsxRAlJyJFr0brBiwFP2SKDuyJvMS/Yd0MLd+r3kcH0JOixX4I5B+ZGnYTUbnTJGP82Jvjhx1Qa4oBNWD5dQrm3T5L2BNmuA+0yL9Alsa2tZBsG/Mev2Kly/TYnvT0VIEfT5Cqby2u6PWZHylncUqzl9OrGs//hMIv2YPtH7Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512223; c=relaxed/simple;
	bh=GnDP24M2FuP6ya9HMEQ8qsEoAAD+Uo+ti/fKB1+PdCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7TL5GARhqBQR4vTHbQ0UKviUo1vl6oJPCkB1ObeHW1oeaMM0ACcYJZxILtPnngaTOrsu2z848NWi3jNKIbr0Zk67Y/BsxjHq5olBHxJarCHyqtqTeGZPEQWyQIktYBBv/XCZNqxUg3jXy8UUvR2QqDYFi7vnJTR5sPoYqo2kls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=srFtpxVU; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srFtpxVU"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so94655ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jul 2025 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751512221; x=1752117021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U10Trg2+kMrB/Phnk8oajYlRaXXMBmg0wJp6OkDPPfw=;
        b=srFtpxVUz54N+T/GfilJB7UFLiQu1UkSX7LUVPkrwu9ZE+tb8i7bsTs4uSbWoNh+jZ
         DFngbB7rzYoJx3nqi9/wgBWY4cywWCFRrhl9Hi2ovQ0lGrOZD2nitQhwYXrIUytlTbux
         JXYyVqIBOdHqVWrCANegkFezCeED56BrdOKZTu2LbNbLrA4HcYtXl5buPa51XHe91Y/7
         G6GgQJpND2LmEEFGwn1zC2kM1paGvM5IskuhRNFEGf5c8S9PdYqhMm7kEUqGmTHCzZYZ
         70j9qcs8S5wFE+eVjEea4nbqK6hDv56eIJS9HYtiQXt/NfUlysN9Rrjn0s/j+rRPly1q
         ztfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751512221; x=1752117021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U10Trg2+kMrB/Phnk8oajYlRaXXMBmg0wJp6OkDPPfw=;
        b=pi0wrD0W5ET7L0KbDnCg0ffYe/leRxvFIaFootAdx4Vw0TN5R+kuehZ91szo5xUhwV
         LD8REWk17u8m3CKc6m8CMQ9oKKLltHD1n/PkeJ1RCj02ei5eeitMdgFtKzZFI//KHgKP
         gVFpLmg8jzItBbBFPSKlxUNq5RxOokLbfqwCYinfiNAJvUXeRT4I6TOIVl3HwQ/MAd1T
         0ck743ktQ9eGoI5yLxJthOYTlI3M6ajr5+J3naaGhEIIIinyYw5uqUeUA56PYYq7Exqe
         thFCisbMLUSQfdzFrnRjEtqL/zONYi6YFeMapwCyJjU2ZFfldlaT5gAOV1FsQvO69LwA
         PDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKmxrKiYmISW+mRbsX6e+Fuf0aKb8UVhDuYHbHE/y/w6n+YZA3oI4zGL/TSkScaHKslrwP/8QfxoNw5bU+QN/n@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfAaULtyCuLU7z8Hhz/a4uHakkznNrU8VMsRMAnyu/cDGs5OU
	pRM0GSAhNwXKebRuKo7Kn88JP7GEXC44QIai3JgobJ7QMUcVcjg9hMIP6/HiV62oLLTR+fTYbVy
	NjYEPyi96xbbV7xZ/ezIAo8WWGHSpGWAfEN9TzWZ6wzQxvtY/cdNJEwsnh1o=
X-Gm-Gg: ASbGnctz/mDrgU8f46IN0w+InJbcGDQHUq/JHQ5kaWsH0A44tlxb3V8FJ0+DR1RBgzI
	rtc5LzO2EK/8qkNSbEB9yrscR5L7fvMIPRrVT6KECdUrKuqveHfuelIqzl+5GMZh1uUAZNFOJhK
	KR2iSVDG9GIoRs2sjcM5tiIXvf1kgs6x7xJ8q4SWD+tMXG
X-Google-Smtp-Source: AGHT+IHRuHQ1sBc/LAsn38NJ7OaGp/8Lfxz6PE+0mZwxQyQdfVsg72Jo2h9/3XFBRmTQyNdPwKGAceiTdyBqMZeJaXg=
X-Received: by 2002:a92:c245:0:b0:3dc:5cb1:8f24 with SMTP id
 e9e14a558f8ab-3e05d272402mr1097295ab.9.1751512221092; Wed, 02 Jul 2025
 20:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703014942.1369397-1-namhyung@kernel.org> <20250703014942.1369397-7-namhyung@kernel.org>
In-Reply-To: <20250703014942.1369397-7-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Jul 2025 20:10:09 -0700
X-Gm-Features: Ac12FXyY3OAmv0vbuKDrGKJL9ePo0TEvoxhw9G8HyPTny8ecMmqLgfmLP1sa9FY
Message-ID: <CAP-5=fULGaFXNqmcvQDc-n-7OKGq1bdWFs9mY6by7HupKkYFuQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf sched: Use RC_CHK_EQUAL() to compare pointers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> So that it can check two pointers to the same object properly when
> REFCNT_CHECKING is on.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index a6eb0462dd5be20f..087d4eaba5f7160d 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -994,7 +994,7 @@ thread_atoms_search(struct rb_root_cached *root, stru=
ct thread *thread,
>                 else if (cmp < 0)
>                         node =3D node->rb_right;
>                 else {
> -                       BUG_ON(thread !=3D atoms->thread);
> +                       BUG_ON(!RC_CHK_EQUAL(thread, atoms->thread));
>                         return atoms;
>                 }
>         }
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
