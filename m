Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2BA1482F2
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354410; cv=none; b=lmmsNnizTx8tBIb2bQmhPiAmj++X+tiOukiNxYu2Eq+0uAKI+nqLHi+8DnS4tfQeFCFg32Zf9YalB9fL6PCXz9zBV+EpqwMPZP6w4p1sjvJ4NWRPU6hmknDpvWTYFvpW/uRDkQsxA+mNyR1wCkR0bD34KLUDAdx9FrztsW9DZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354410; c=relaxed/simple;
	bh=SVD/D1neY/VMzCUafgxPxYWWoSXIv9EEnzkncaGe/f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt6cyUaP9mg3aisYnYIFuC/Bads2zcsjr/A9ZjLalpYIsV/m13jyNcIo2Op5BAVpERgMqaHDFJB7cMIPkTT8InUUnpIAPT9U9VCTjXfiHbA6DkRcG+WvIStPTSxg13WCFQD8oVO7n8xrfrLMp7j7r/0rePrSYNZkztLqrjOH62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwSCkS3g; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwSCkS3g"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8ac50b79so27315ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 11:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731354408; x=1731959208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb/lRtOScrkbHEVqeEiNru9i+NEX9M9BCRiwMog+ERw=;
        b=MwSCkS3gWyEZWgTrC0O8WdnNURPdIQN+4foMKL5wkrt7g8uh5KUB0Ew0LFrmy787Tz
         4P1YMXL1+tbU8XIQFZT73RcNGk6Cl9OxvkfwehpdWQ8+EtcaAVwc5hbqjGwxB3BDXyPE
         +tmrlgvgaloHgwdpQB9zhpxK3GBri/7DyjV4U/o3yL2fby2t6SSpjkkaGgoyB1rmtrWC
         cu3dfQjHWPTi182oaARP3xGr2NW/8Yt0AUW5PRL5gNNszq4wFyg24HhwJGA8ukGf4DiT
         6UypoFodUDAy+Bo4S24O+HGluFj7qVWQuVwflWpGy38rpMcltnP1YcT1ZC85YPsji5IU
         qNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354408; x=1731959208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb/lRtOScrkbHEVqeEiNru9i+NEX9M9BCRiwMog+ERw=;
        b=UDLqlURmKDcIO7d5uPaVhvHRJ1trkLdPcKoE2ZpmrhE3bMjzdWsJsvAgQLNltKoc+F
         saiuMq4BuNhxHqjqSlakS77Rb7PziG/IfsC2c6MOa+7pVYvtxgUbGDXcNQxHHUJTe3lr
         tjO76Pr+l93YU2SUr1m2lUUeH12cWmG3LAU99XwhIrtrbUQwSWGkk5phQn4T4pI/q/3Z
         QyUCPzyKbelntC6crI4ipgPASYn4+HUhHUbP0XPlrgpABseCtvj9GCg3uD8ydMBtxZYp
         k9BXRHQCvTS6GBX1li8eQVxFf5hKF+f7fM0Jyh8yGbCZltRi8Nmt4vU2KNfM+RhBe2eG
         zsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX729AMq44ItGy9eSQ4HNzjcW5x9L6uGo4rVKb4zDEpcsJyC56dQ9YsSYc52mMayEYjPEJz+IQ7p6U4M3tkjrkz@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJl67S3cMRZyWJQ+15Hj7HUWxl9gwd4MrHxNyk7NVjsPMQ84L
	gVtMAmRC5w9py7zqhbmb9u3eeX4f2JokLkubVo/wEJacsxNfgwC05YQSB+cXpmowfV6l5oAYmjn
	UIb6OPsXP3wD80uunK03yBh1KRCzGjLKfu4bc
X-Gm-Gg: ASbGncvFmE3HB5GGKeDAFmr7pluhT9j2OMU77s3HP5/QSXBmGZ0BZm3kEJJJn8PDLYD
	XAPc6B1QXARWVdijae3NHePumBm0ttnQbiGXJTZseSgiK0wLV/W4vZ21DT04xolo=
X-Google-Smtp-Source: AGHT+IG3Voeoea9hH7MagKOMnVkHeysRZ87ScGQtbCyWe5pD36B+XNBUQSB/AHysZ4FWUFGnwuCGsdWTmHyzBa4M8Q4=
X-Received: by 2002:a17:902:e541:b0:20c:79f1:fee2 with SMTP id
 d9443c01a7336-211ab6fd382mr58045ad.10.1731354408310; Mon, 11 Nov 2024
 11:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108061500.2698340-1-namhyung@kernel.org>
In-Reply-To: <20241108061500.2698340-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 11:46:37 -0800
Message-ID: <CAP-5=fWqE6bM=MVQy7P0tTSWW-ZBXY4in_bfQYFK-C4h6L-Ykw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf lock contention: Symbolize locks using slab
 cache names
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 10:15=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This is to support symbolization of dynamic locks using slab
> allocator's metadata.  The kernel support is in the bpf-next tree now.
>
> It provides the new "kmem_cache" BPF iterator and "bpf_get_kmem_cache"
> kfunc to get the information from an address.  The feature detection is
> done using BTF type info and it won't have any effect on old kernels.
>
> v2 changes)
>
>  * don't use libbpf_get_error()  (Andrii)
>
> v1) https://lore.kernel.org/linux-perf-users/20241105172635.2463800-1-nam=
hyung@kernel.org
>
> With this change, it can show locks in a slab object like below.  I
> added "&" sign to distinguish them from global locks.

I know the & is intentional but I worry it could later complicate
parsing of filters. Perhaps @ is a viable alternative. Other than
that:

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>     # perf lock con -abl sleep 1
>      contended   total wait     max wait     avg wait            address =
  symbol
>
>              2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498 =
  &task_struct (mutex)
>              1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538 =
  &task_struct (mutex)
>              4      1.12 us       354 ns       279 ns   ffff9d5e841ca800 =
  &kmalloc-cg-512 (mutex)
>              2       859 ns       617 ns       429 ns   ffffffffa41c3620 =
  delayed_uprobe_lock (mutex)
>              3       691 ns       388 ns       230 ns   ffffffffa41c0940 =
  pack_mutex (mutex)
>              3       421 ns       164 ns       140 ns   ffffffffa3a8b3a0 =
  text_mutex (mutex)
>              1       409 ns       409 ns       409 ns   ffffffffa41b4cf8 =
  tracepoint_srcu_srcu_usage (mutex)
>              2       362 ns       239 ns       181 ns   ffffffffa41cf840 =
  pcpu_alloc_mutex (mutex)
>              1       220 ns       220 ns       220 ns   ffff9d5e82b534d8 =
  &signal_cache (mutex)
>              1       215 ns       215 ns       215 ns   ffffffffa41b4c28 =
  tracepoint_srcu_srcu_usage (mutex)
>
> The first two were from "task_struct" slab cache.  It happened to
> match with the type name of object but there's no guarantee.  We need
> to add type info to slab cache to resolve the lock inside the object.
> Anyway, the third one has no dedicated slab cache and was allocated by
> kmalloc.
>
> Those slab objects can be used to filter specific locks using -L or
>  --lock-filter option.  (It needs quotes to avoid special handling in
> the shell).
>
>     # perf lock con -ab -L '&task_struct' sleep 1
>        contended   total wait     max wait     avg wait         type   ca=
ller
>
>                1     25.10 us     25.10 us     25.10 us        mutex   pe=
rf_event_exit_task+0x39
>                1     21.60 us     21.60 us     21.60 us        mutex   fu=
tex_exit_release+0x21
>                1      5.56 us      5.56 us      5.56 us        mutex   fu=
tex_exec_release+0x21
>
> The code is available at 'perf/lock-slab-v2' branch in my tree
>
> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf lock contention: Add and use LCB_F_TYPE_MASK
>   perf lock contention: Run BPF slab cache iterator
>   perf lock contention: Resolve slab object name using BPF
>   perf lock contention: Handle slab objects in -L/--lock-filter option
>
>  tools/perf/builtin-lock.c                     |  39 ++++-
>  tools/perf/util/bpf_lock_contention.c         | 140 +++++++++++++++++-
>  .../perf/util/bpf_skel/lock_contention.bpf.c  |  70 ++++++++-
>  tools/perf/util/bpf_skel/lock_data.h          |  15 +-
>  tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   8 +
>  tools/perf/util/lock-contention.h             |   2 +
>  6 files changed, 267 insertions(+), 7 deletions(-)
>
> --
> 2.47.0.277.g8800431eea-goog
>
