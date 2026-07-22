Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A1C41A51A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735872; cv=pass; b=YdJcWE42q2Bn7qNNcT4CT3+WBAXBLlClRMWklp3QhMb6Op2VqDBHHz+g/364p/CCHQrcHYOKwqYrAhVSXd+9Jlutjr45c+MtIgSWVNvmf9P+2HBpV8kCF+tgah0zqis/Ay7xYqWjcCf6utmMWTWakGembnjcQPMHTxwhEhZxIEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735872; c=relaxed/simple;
	bh=IRr/teUqDTU1SLM0uX48lbCuWDxFZwyq5ZQm35D1iT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mog0MvjlWv97GAuGEbgLltD1Q/jmVOqH2Pcq3V1H+Pvqmm/Qv43a1iZJKDj/19mHEGob+unaaU67Uo5hbFbrICh92JFRmHQdwfEGynlTlwxzdw6rt4xuVMs63K7Zc2q9+y2qy9sEAm9mnNT2814h2dn3FJgLYwPQd5TE4a5uQ8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SLXBBj0Y; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLXBBj0Y"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10e86e52so1585341cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 08:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784735867; cv=none;
        d=google.com; s=arc-20260327;
        b=PwnO+02CskDxlo8wFjJYz7uRNWjJynP2tRK92QHay+I4PqwbWM2wLDMJnjXrahjr9v
         rcpKiOlI0JTUiZS+mt85cSy8cjacmMj/4rgggXhlsjn6aaAZtk7v6Ciwa7GgsU7WoBAs
         zOiPWplLcGAfFoqPLytxzXMr/OYmmi9/nfvfCwlabO8LCDtzUqDlbMrPkk7APcAbf0zl
         bHz5Hf05zmireepTvziXb38+ckBY4vvWp7kRYwXwLPUxnQdBNv2pETED7t9Aw5yFkUKE
         mu1gIOeCekBRFAN7ZRu+rNaAWeNbFHlEjanTyEPa1V9BPMhF+BzPvFYeFVqOWkVGx7F3
         xS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W0hqwpr4ALFBzAD8qIr30SptQ0SGKXgKx8tD92vjd9o=;
        fh=WzHr+udZObwE78SmeFyE3acKu4LjxQRiPrkz0uw04iM=;
        b=Q4Pz6EoD4OrYhp36x71qasvaDh/bBl+5UY4Hai/807tvsbwtwOm6SX4MyZRxPL7fBV
         uum4EGMRLdboxn1I28sfA/DiSoFqvZLxwJJOOk3wB9vel8YqNw7a3mc+vCzF3vrqTswK
         dAEmMF7ixEbscIeoyp6L5A058UPN7BwTmnrndB2bV2bY1ivZEAfRXRBNNPfhETwGhDeR
         XT4SETrLeHfihqqPyLt0rsQZKPvV+M7kW9vuE4Rl5J682np6V5gNChEgFm3zlA2vfRrT
         i/rIFAouoAOO04FIo7XDO5ZwPLUC0z+UZKsWWkFxbc3KLwX46SV/zX/imlLH+QDnYhio
         Bd0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784735867; x=1785340667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W0hqwpr4ALFBzAD8qIr30SptQ0SGKXgKx8tD92vjd9o=;
        b=SLXBBj0Yg/ZG1R1CzOr+s/rwx2+nDrayYB7LOV1TFlA64luQjd7vMYEpZbCFwhH2iE
         xu920vra8Vw7YHFCF3C/ac3oG9oJwG09EiFL+hB/UNf/Km9f1XXT/UGdwPQEMKaU65v7
         8KAtVZgG1NsgdwiO3wMNc0WtKI8vS531S8uUSliYK0pr+9OyfIYWK+OPxY8BvOxohPDk
         W8oGuvQ48muNFLiwk3kRPynZhNr/K8DXJcaHC8Ji3/N68XdSKxdTYg68GWDyY4rgIkQg
         gPuMJSIHsaB6wMLUy5cISk2mW63HLkKVlbp+Sat6eicFpK3V4nnsTaUuwIBOKts+oCnk
         bf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784735867; x=1785340667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0hqwpr4ALFBzAD8qIr30SptQ0SGKXgKx8tD92vjd9o=;
        b=Evusn1cgZ3kt+Rc0X/058SOr4DzenuuBcJcfj3r6GgMPUfgfqq1dZuDaneOeqY0ETW
         gpyfs6kC/t+ivCQWCKxh1ktHnXwuWKrruV6tmglUCGv2pwTT6CZRlXa4viq7ViqbZ6OW
         9OmfYUIeKQM5CNJBLIIVewTWnopbn8V5tlL7rIbLYZxaEhp2UaFCv/Wgpas9evFpp6pf
         Mxl4dSzULCE6MWlSrNO0KTtw4Y/6Sf0KvgZWrJdBcdd19KZbX+PyKwgchGT88n4mZVG9
         OOkRdrZYuUDRW93dX4fAsirDf5MHTlJlIZ/2SEsvtazkAYPwHOjMzh8kZq2Oid9tHXxS
         axUQ==
X-Gm-Message-State: AOJu0Yw3cXDwKr5ODCn9c+EUavy1ghvBPTBKBD1YshO9VqCUJ9tgWYsl
	BzmnYGb5hHONOnEVwmyPF8fEdjNpytGkGpkfu3KK0YEg7eQ/ioA9rJ//8SFF05Mk3aEIX45Sx8S
	Cs5iNMuKgm1cNL2hVNjK3xSlbqt3aAEgMX1M2PNWn
X-Gm-Gg: AR+sD10bxvIiXKb0rKtWJA2nwgvJDx2LyF9+Sdh/Wh/bualNOhB8kRzdzN7POl1aOJ9
	tDRaZ1OJDztvgLXpP6lc1o6KjVUtyoA/e6xy3Ie1btWD5U2DtHhOllzTKPku4E+OTTE9uuVDiqw
	lldhLttMIkyTxJqbm5/nypIM8uONbQUofqjN/Gyu9P32EjUGfAMiZu3q92hmLJsCo9ETLz/Zmz6
	FVAJvmTdxJPG34jodadVuCzvd7OXpdCfGnYJ+bMljFyTsdlYm3/GjDU3CBFNyfc3wkBbi/M5ZMW
	GmqqWYzDo+ywo5I6jK0/Xr9ERjo=
X-Received: by 2002:ac8:5cc9:0:b0:516:d570:82c0 with SMTP id
 d75a77b69052e-5283a9af9d7mr505461cf.15.1784735866027; Wed, 22 Jul 2026
 08:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722102407.3755154-1-aleph.pi.gh@gmail.com>
In-Reply-To: <20260722102407.3755154-1-aleph.pi.gh@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 22 Jul 2026 08:57:34 -0700
X-Gm-Features: AUfX_mw_GNJghEuwrBm1Smj1Ekib5Q17Ij06A8ZC92XjSJZftk4C0onz3YVVu04
Message-ID: <CAP-5=fVpWMOg8PE_b9or5PHwLBY0H1UNOZRxUXR-5=qwEW2M0g@mail.gmail.com>
Subject: Re: [PATCH] perf unwind-libdw: Fix unwinding of multi-threaded processes
To: Alessio Podda <aleph.pi.gh@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Shimin Guo <shimin.guo@skydio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:25=E2=80=AFAM Alessio Podda <aleph.pi.gh@gmail.co=
m> wrote:
>
> The libdw callback API has two levels: dwfl_getthread_frames() first find=
s
> the requested thread using the next_thread() or get_thread() callback and
> then walks its stack.
>
> Since perf only has a snapshot of the stack of a single thread, it
> provides a stubbed-out API that always returns the pid the Dwfl was
> attached with (i.e. whatever was passed to dwfl_attach_state()), rather
> than the actual sampled thread's TID.
>
> Commit 6b2658b3f36a ("perf unwind-libdw: Don't discard loaded ELF/DWARF
> after every unwind") changed libdw unwinding from recreating the Dwfl
> object for each sample to caching it in struct maps, which is shared by
> every thread in the process. It left next_thread() unchanged.
>
> Since the pid passed to dwfl_attach_state() is only set at creation, only
> the thread of the first sample is ever found. As a result,
> dwfl_getthread_frames() fails with ESRCH when asked to unwind a sample
> from another thread.
>
> Make next_thread() return the current sample's TID, provide get_thread()
> so libdw can find it directly, and pass the process PID expected by
> dwfl_attach_state(). This allows libdw to unwind samples from every threa=
d
> in a multi-threaded process.
>
> Fixes: 6b2658b3f36a ("perf unwind-libdw: Don't discard loaded ELF/DWARF a=
fter every unwind")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Alessio Podda <aleph.pi.gh@gmail.com>

This is great, thank you! Did you have a test that would reproduce
this problem? Could we add it to tools/perf/tests ?

Thanks,
Ian

> ---
>
> A standalone reproducer is available at:
>
>   https://github.com/kryggird/perf-bug-repro/tree/019c8ae97f9e4370ef2265d=
7badc3269e2a5044f
>
> Run it with the perf binary being tested:
>
>   ./reproduce.sh /path/to/perf
>
> Results:
>
>   perf 7.1.3-201.fc44.x86_64:
>   1517 of 1522 samples have no userspace callchain
>
>   patched perf 7.2.rc4.g1590cf032971:
>   15 of 1449 samples have no userspace callchain
>
>  tools/perf/util/unwind-libdw.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 7f35042be567..3735ef83c8c4 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -173,14 +173,30 @@ static int entry(u64 ip, struct unwind_info *ui)
>         return 0;
>  }
>
> -static pid_t next_thread(Dwfl *dwfl, void *arg, void **thread_argp)
> +static pid_t next_thread(Dwfl *dwfl __maybe_unused, void *arg, void **th=
read_argp)
>  {
> +       struct dwfl_ui_thread_info *dwfl_ui_ti =3D arg;
> +
>         /* We want only single thread to be processed. */
>         if (*thread_argp !=3D NULL)
>                 return 0;
>
> +       assert(dwfl_ui_ti->ui !=3D NULL);
>         *thread_argp =3D arg;
> -       return dwfl_pid(dwfl);
> +       return thread__tid(dwfl_ui_ti->ui->thread);
> +}
> +
> +static bool get_thread(Dwfl *dwfl __maybe_unused, pid_t tid, void *arg,
> +                      void **thread_argp)
> +{
> +       struct dwfl_ui_thread_info *dwfl_ui_ti =3D arg;
> +
> +       assert(dwfl_ui_ti->ui !=3D NULL);
> +       if (tid !=3D thread__tid(dwfl_ui_ti->ui->thread))
> +               return false;
> +
> +       *thread_argp =3D arg;
> +       return true;
>  }
>
>  static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
> @@ -306,6 +322,7 @@ static bool libdw_set_initial_registers(Dwfl_Thread *=
thread, void *arg)
>
>  static const Dwfl_Thread_Callbacks callbacks =3D {
>         .next_thread           =3D next_thread,
> +       .get_thread            =3D get_thread,
>         .memory_read           =3D memory_read,
>         .set_initial_registers =3D libdw_set_initial_registers,
>  };
> @@ -400,7 +417,7 @@ int libdw__get_entries(unwind_entry_cb_t cb, void *ar=
g,
>         if (err)
>                 goto out;
>
> -       dwfl_attach_state(dwfl, /*elf=3D*/NULL, thread__tid(thread), &cal=
lbacks,
> +       dwfl_attach_state(dwfl, /*elf=3D*/NULL, thread__pid(thread), &cal=
lbacks,
>                           /* Dwfl thread function argument*/dwfl_ui_ti);
>         // Ignore thread already attached error.
>
>
> base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
> --
> 2.55.0
