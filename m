Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8E330D4C
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453719; cv=pass; b=By6g9ZZ/+wq/t71Xyls1EjbIzhIHJWG/WOGFxo+TDpq12I54yzMA6vtddjFHyQ6Um0sd9i0dUT9ujX1bnUhxFFF4JRY0ZtcbWYyHmWUn5589ES6eb/V7hOBd0cQLsRynnk33lVcVM1OGQHgJ42/+GHY/fpo2CnNuEiwy+pmJJ8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453719; c=relaxed/simple;
	bh=J0dhx+VeUTRJHd1Uk49mYD+x7HKao8t8elSFpjtDW1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfOTb/kSJPva1tUn0WX8W28Ri7HOo1QQJsh63sYSNS+C8G1Hcu9wubh47HtbnY4I5VY9nN0FkKdgLKwOYH83ADZthpKZd325EH57Vs/celIgR7sxJrZKygnnlNmKqLz5KW9jYRTwJrwV5pW0tU5bTGQl32uqyxiEdeHfdqD7Kfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gqHlcnc5; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gqHlcnc5"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52e843c64b8so294431cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Sep 2026 09:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453716; cv=none;
        d=google.com; s=arc-20260327;
        b=AWcSj8BtLSYditrui3jhqA3o/ZATNsYSfgm2UP4XBybS5vdm825zQkFF+n/IA09mLH
         9INWgPXcC4CdaTcePIcnbkIOE1AGj7aJGSQyxHDDI3NyFlDMNmp1Ny7I8xd0KqDHoVdH
         bi5fJSsSV5pwziNifCxyJhoGLBH6obYWvzqH+UFU5wt0VsR7HWbRBNrQwBHviXygXcYb
         YTtsMHKffxnL2yg+4FKiCp4vp7wmf9PoilE2LvyD4gqGtdDAfqkdLTI9ZDxGEWHJHLeS
         Q5MHVn4dtDORwEBQwGAZP4aH14+OcXJOfwtRiYLNWPlXJCHaDFwbYDtmpfjvpfj+iukV
         9ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWWOqaCDFtUK4h2CQWXGFy/5EpfShib0USljQr9tOwA=;
        fh=CvXzuxna9ggDLQwVJqo3WW87X/xC+/PrCkzsjlcRYO8=;
        b=ADXKnrwjO3vXTxH447NoXbhUMKexkUDG4qvHnlExpUDDUv+gZR5RaZ+i6b8tDOtzz9
         /3vtYp3FO0Dxt92XBQh9QTmqXYfgLoXZtLQjFHnFEddIVeM2/LjeMZ7a5G/NULgTZXBS
         nWLE2zQ9mvDj0e5IK0oB+7QhX6na5qZVM6MhaVy+wU7Ac6Q7i0DGKuASHfqiuaYCCiYe
         axA3JJS+RxiE3pnZYDS21m1HYmJK9GnV4gpDLyn927PUNhZyWnH8+xYXfgXUtMmdZE++
         zumXj7SkJhiNdP+1jcORN5Zfkop+X8+ri5Qb/NOya0ybh1P5RNiMLV0UWaSokrlhKcKr
         pv1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788453716; x=1789058516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bWWOqaCDFtUK4h2CQWXGFy/5EpfShib0USljQr9tOwA=;
        b=gqHlcnc5gE/z5WMHVHp8irtH/zm5ZcZe3hWy+V6BhkWOc7aY9l27WAbtq343tV+CDq
         ctR2kw/q6e+Ktnx5In5WSnnxAlNgEdMvAFgaY6qVGj0RZu4wCvDNOG4j/3FK/ylXhIVT
         psb+EH/ej+QvAwGXp7jbSn8Fydn1QuZckIxdNg9nDyljsfhv6hd3JKhlfz0w0PcUviR/
         PoFtTAGjf1M0KizXdoOKRhuKBJ9R1ffMuCvpwx/tOW73xR7atJMBGRpKVW4ejeun/yn8
         WokPvts99warib7+EhJqE40ekGKOJp7x0v3qMvfByPlYPnlZabEsRWiM4Q9YI7kbXGo6
         AEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453716; x=1789058516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWWOqaCDFtUK4h2CQWXGFy/5EpfShib0USljQr9tOwA=;
        b=q+Wg+x0x1A1ZjMDBM72TO30m06pjD8r75JXqOIo1ETtm/wKWojJ/AwvvdjVBjIoiS7
         ywo4FkGHWh1SCUeSSzqvLcYrWgDTKRRdXG3yrDqd6I9ewDJcrFfuvDf6ZKMlEnQK/rYh
         Zz1ioUY2UVNuvBPcralwFHMWjPhchos04NhW8lVnB/nARpzvU4btHJcuAOQ3mqlhnw7a
         v/XLQcb7SYa4VnLYbPD1KeQKHkzK5qZIqSAzilKB+MKCRUt2RQH7BQiu4qd2A0KWGYR8
         aKYRbL6ltmq8sfjp3gKBylRuwZumVEnYt+NacJMxuXal5Nwwv9hXsEcmXNOUqk112aEJ
         jfaQ==
X-Forwarded-Encrypted: i=1; AKwUvByMxIxEUatds5jVPRcJbIyS2hlmucHq3TtIlmvWc8bihTmHVEMSiAb+2HVTj7ERXg/R6M9d2OcV9uLQokjml7C7@vger.kernel.org
X-Gm-Message-State: AFuF++nUINrOXinbItSLdTlDGnYbiQlBeJSgYZiIFJdaPiGBQO4Swup2
	8fmeleaq1LHu7Olyz+7XotfFwnZeIcCRSKqZGm/RHLpPTqRUCHdI2ZZGYRY+5jyLhGZX4VlJtHQ
	2mF2BBAFa46SoOm+wGshnJMy9Gwtnwc1ikNSHZuZm
X-Gm-Gg: AYBFou1pnBX4hQAoAA8X9LxTbKVk9g/E6CGqiH5xOXhLBx9E/XrHSkLjWAT3ihw1I2p
	W69wIrefbHE0nOxqXOYDc/jeTsp6bazb6xNtmXu0AR5wHZiopla+M3gJPKJe4M867+XMqTos0Jg
	LSheVpIfbov6yhUqBU7Oz4fAyW9Q017H48k/i0cxl/ZqOK5CLPHF768VnCKtVLS+txe5MUMMxou
	kbMPt2bmC16fAjQDDVFnxzj1GiZYg6K7XdCkANWrHsu5scYbrmJkw0lDxXTq4S62vArEvImr7p6
	FRnAf848rp05YMR7ko5Snow93EAeuelC0o5Y/0LRkFJwQ9KFgpVBzkvUOhN73RUOmjWIU7LDMEP
	O6npSInI=
X-Received: by 2002:a05:622a:293:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-53043e62d4fmr18986561cf.4.1788453653083; Thu, 03 Sep 2026
 09:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903132251.237029-1-acme@kernel.org> <20260903132251.237029-6-acme@kernel.org>
In-Reply-To: <20260903132251.237029-6-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Sep 2026 09:40:40 -0700
X-Gm-Features: AcwNN1UEzYLyLW7bFheLs0fRmukHfSV8n-mDlL9d14htXgMHbEC_TGM3Ry1Umms
Message-ID: <CAP-5=fUu4F2kj=8S+EPU21pffRJpNJs_z84oJdZhJ6n7tmi=+g@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf dso: Defer dropping the open list reference
 until after the lock
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
> There was a problem in the code with some resources potentially being
> left unbalanced, and the logic on dso__data_close() becoming confused
> if the fd had been closed already.
>
> The reference taken by dso__list_add() on the open list cannot be
> dropped while holding the open lock: dso__put() may call
> dso__data_close(), which takes dso__data_open_lock() itself,
> deadlocking and leaving the list and its counter inconsistent for
> concurrent threads.
>
> Fix it by changing dso__list_del() to transfer the reference to a
> deferred node, drained by dso__put_deferred() right after every
> unlock of dso__data_open_lock().  Since the counter is now decremented
> under the open lock, do_open()'s close_first_dso() no longer races
> with a stale count.

So I'm not a fan of this change due to its complexity. There reference
counting with dso_data is funny, see:
https://lore.kernel.org/r/20240506180104.485674-5-irogers@google.com
Basically a dso has a dso_data embedded within it. Perhaps the cleaner
fix is to allocate the dso_data, separate from the dso, and have a
reference to the dso from the dso_data. We should be able to scope our
lock usage and avoid deadlock without resorting to a deferral
mechanism.

Thanks,
Ian

> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/dso.c | 75 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 71 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 42bfe30a3b518e80..a4b2361bc7420084 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -531,18 +531,79 @@ static void dso__list_add(struct dso *dso) EXCLUSIV=
E_LOCKS_REQUIRED(_dso__data_o
>         dso__data_open_cnt++;
>  }
>
> +#ifdef REFCNT_CHECKING
> +/*
> + * A deferred put: carries the reference taken by dso__list_add() for an
> + * entry removed from dso__data_open.  Dedicated nodes are used so that
> + * the dso_data's own open_entry node can be relinked by a concurrent
> + * dso__list_add() without corrupting this list or its reference.
> + */
> +struct dso_data_put {
> +       struct list_head entry;
> +       struct dso *dso;
> +};
> +static LIST_HEAD(dso__data_open_put);
> +#endif
> +
>  static void dso__list_del(struct dso *dso) EXCLUSIVE_LOCKS_REQUIRED(_dso=
__data_open_lock)
>  {
> -       list_del_init(&dso__data(dso)->open_entry);
>  #ifdef REFCNT_CHECKING
> -       mutex_unlock(dso__data_open_lock());
> -       dso__put(dso__data(dso)->dso);
> -       mutex_lock(dso__data_open_lock());
> +       struct dso_data_put *put;
>  #endif
> +
> +       list_del_init(&dso__data(dso)->open_entry);
>         WARN_ONCE(dso__data_open_cnt <=3D 0,
>                   "DSO data fd counter out of bounds.");
>         dso__data_open_cnt--;
> +#ifdef REFCNT_CHECKING
> +       /*
> +        * The reference taken in dso__list_add() cannot be dropped while
> +        * holding the open lock: dso__put() may call dso__data_close(),
> +        * which takes dso__data_open_lock itself, deadlocking and leavin=
g
> +        * the list/counter state inconsistent for concurrent threads.
> +        * Transfer the reference to a deferred node drained by
> +        * dso__put_deferred() once the lock is released.
> +        */
> +       put =3D zalloc(sizeof(*put));
> +
> +       if (put =3D=3D NULL)
> +               return;
> +
> +       put->dso =3D dso__data(dso)->dso;
> +       dso__data(dso)->dso =3D NULL;
> +       list_add_tail(&put->entry, &dso__data_open_put);
> +#endif
> +}
> +
> +#ifdef REFCNT_CHECKING
> +/*
> + * Drop the references deferred by dso__list_del().  Must be called
> + * without holding dso__data_open_lock: dso__put() may re-enter it via
> + * dso__data_close().
> + */
> +static void dso__put_deferred(void) LOCKS_EXCLUDED(_dso__data_open_lock)
> +{
> +       for (;;) {
> +               struct dso_data_put *put;
> +               struct dso *dso;
> +
> +               mutex_lock(dso__data_open_lock());
> +               put =3D list_first_entry_or_null(&dso__data_open_put, str=
uct dso_data_put, entry);
> +               if (put =3D=3D NULL) {
> +                       mutex_unlock(dso__data_open_lock());
> +                       return;
> +               }
> +               list_del_init(&put->entry);
> +               dso =3D put->dso;
> +               mutex_unlock(dso__data_open_lock());
> +
> +               free(put);
> +               dso__put(dso);
> +       }
>  }
> +#else
> +static void dso__put_deferred(void) {}
> +#endif
>
>  static void close_first_dso(void);
>
> @@ -805,6 +866,7 @@ void dso__data_close(struct dso *dso)
>         mutex_lock(dso__data_open_lock());
>         close_dso(dso);
>         mutex_unlock(dso__data_open_lock());
> +       dso__put_deferred();
>  }
>
>  static void try_to_open_dso(struct dso *dso, struct machine *machine)
> @@ -865,12 +927,14 @@ bool dso__data_get_fd(struct dso *dso, struct machi=
ne *machine, int *fd)
>                 return true;
>
>         mutex_unlock(dso__data_open_lock());
> +       dso__put_deferred();
>         return false;
>  }
>
>  void dso__data_put_fd(struct dso *dso __maybe_unused)
>  {
>         mutex_unlock(dso__data_open_lock());
> +       dso__put_deferred();
>  }
>
>  bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by=
)
> @@ -1058,6 +1122,7 @@ static ssize_t file_read(struct dso *dso, struct ma=
chine *machine,
>         ret =3D pread(dso__data(dso)->fd, data, DSO__DATA_CACHE_SIZE, off=
set);
>  out:
>         mutex_unlock(dso__data_open_lock());
> +       dso__put_deferred();
>         return ret;
>  }
>
> @@ -1188,6 +1253,7 @@ static int file_size(struct dso *dso, struct machin=
e *machine)
>
>  out:
>         mutex_unlock(dso__data_open_lock());
> +       dso__put_deferred();
>         return ret;
>  }
>
> @@ -1405,6 +1471,7 @@ uint16_t dso__e_machine_endian(struct dso *dso, str=
uct machine *machine, uint32_
>                 *e_flags =3D 0;
>
>         mutex_unlock(dso__data_open_lock());
> +       dso__put_deferred();
>         return e_machine;
>  }
>
> --
> 2.55.0
>
