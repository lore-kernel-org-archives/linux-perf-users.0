Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F63A1E7F
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499797; cv=pass; b=CrgjVyt2fdP/HCe1fJ5xuUc31zrtU0Yok97PecBNZTikn9Kz++kUT5NkCk+N/xtOzioMExSlEq3VrnXHzKrQyNg0v2ipzVKI8bE7o3K0sULGiONWnalpHtpLrwlqtfcITnTwNoRSNRV56was/T+PnzPftglXLYnKS1GuNVga/08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499797; c=relaxed/simple;
	bh=7UpSBmTUoJIuwf+lnnh32BXsIgHegfS2CE/7CI5qiLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7Mf0VyBXf6GNd2WJzg8HAXVnzBJOvyxSBojXqUtmT1KR50MkNNQuxniCWAgCu87Jku2J2sRj7jHu1QbRoQtglbEoj1pgwfujYRIXeCcZO2g9Jgf9TX47FMAgZMY0ru2a+OjoYZL9QWv6ZkPDh5hTfBS4zqompA+J/GHx6R8bL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mop3pWmM; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mop3pWmM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf22c18ad3so103365ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499795; cv=none;
        d=google.com; s=arc-20240605;
        b=ikNaZczfObYnvPLhugBi0aKvCfKZ/tBs5WIV0+uJ4O0okGhc7ZPD9JlVFz9lkRNzQX
         kwtlV+J2LmrCzAt57QY8mCGBZvd6fvoa2i/0ooPhCfcAaCv3kmZX8kflQbcfZutJoKcz
         z73PHKNhA9p13lk15OoArc8aQGfHw8oyb3RgVz+pWgP2N7WqgjwGhKBvwBNo+6EmtWp0
         +jOo4zyI2/XsOla5eHtoVcsPdfzQvjCt69HcTLS/FasU4gBsKzc4DaDBW9ivb9qHI4FC
         dpfAvHOG7Ou5LrSYMWrs5gjH/08cTDdu/hsqaHw98Ah2TYEyQLcQ99GbSall9YOrqUjL
         I2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L6RuMbBbQtjuq+AuHAhUOVNs48qOoae7a9NZ7ZqRKtE=;
        fh=m06ir+teNUfDBQBdOpOrcc2WuGi/CEXM2qtzUSCLDtU=;
        b=WY+r42EtDkeGSIFX0RCAw9snnPzkx6ERlwmGUyn+OG7AdpzfJXxURcjPq51O0KTJ3x
         V5518wzwKXsWb+G5JR1uWxE8ERmkDoNKdL4tZgsgdeMvBZrB6pHW7yUZKfm6IiMH9fxr
         zTzVXtJBQn+h3uCK+fQLyuLH5BW9xnvY1NKAYxYDtpk2h7RFdhCE93Nj4Pj0IB4h83JN
         ddzFsVUtaNCrmn6tLMse7pU4c5QPT+FwQJV6uS9m/i5qNRz7gBAhZlqTeR+SUR92zKz2
         J6NRVorxsWHzMQmsaMIFhhsStMnOkkxRcDEYqGYI99sYyFj2kSbg/RhH8lFokXAfrTFx
         Ecvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499795; x=1781104595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6RuMbBbQtjuq+AuHAhUOVNs48qOoae7a9NZ7ZqRKtE=;
        b=mop3pWmM7FMEdkk6wCmyIvGQQn2yNQSLXyETl2v/OuMlsJjsq7PXykul1xXasv/VeA
         dEcANaNjxzeQ6SPB1poCicCxY2QTUDq2+1j00fDSr0UH1GbSPYSE5lzXdngBhcnoeRgW
         s1/qN/pJ/6pJ/YJPSZY+Gsd8U2M7Dxq9h5TjIgzlD0qf4ytnTieWQs2RMmvhMp7Ku5Gh
         NeYPzNB+efCWLkxgb4LOakvIUC4r1vs0qmc/MdR7QpKR9a8e0RLRx2s1UUWRi3WlCyP1
         15PcuVX4DUnM0RrTyt0U7+zapU6yLLXn4RzAMwAICcofrEdOeArdQ4FgNaWtqBtqHuCT
         /eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499795; x=1781104595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6RuMbBbQtjuq+AuHAhUOVNs48qOoae7a9NZ7ZqRKtE=;
        b=tPlTmUFZfSuK4uo/RVI9vd37o0gqjNBMM9cT+ZuLCs4PbCJXG/Ipc4Mnz7qc22RaAt
         z+LIiBPlhJsr+bBe+pfI2QErbByaIFbB9M5boP4XvVUTW+XLsqkL8eJZTRZHJpxJ+YEd
         Kt6Ie0JVtOTrfNtpWpVTn7Boq5exWDGlMP9jcVFspktT7+BxDtwJq/Sp68lxNMBhmyms
         LRJhr5+7m/4IYGEOC04suTtAfeH3wcdG67ICKEY98p0FjqwrZghZtZR+JtplDUDyif+t
         wPKJpz3OTiJE78n+lMKrVC3vb1tz8Y0O1qVuGqooDjqJddT0NblcgXIepCByoxlfvZAZ
         X9cA==
X-Forwarded-Encrypted: i=1; AFNElJ8i05+LzUpf0HaB2qPwXZg7KBh8/AGu6hMlrIKbDTckcFmHiWHDblYZ2T/3pRwQeu3PqW+Z/b88p+xSpoqMpvT4@vger.kernel.org
X-Gm-Message-State: AOJu0YymIl4qeV1lbYG0ObJaslpIYGfvDqn2vXF7oa+mT+Rqlo1I4G1d
	dfbOzAAn+jg5+98se5Znl+GY7rmMnPzTPzlPqgYYOsjhaHaQ0h/Z56QbZTr57urL2z2tsnwNKO6
	549MeFBRNCRHj4ji+M9eGeF2UwcRLGj39N63UIbES
X-Gm-Gg: Acq92OGKVxM2698GUh64ei0RFPHomCtnmJHbPwclkFLZHQ2g7XqS1JI0jIMiL9194k5
	5ujhRnHhguoySM8UpTsusu7SE+rIkVrFhKw4cM450dvbkpZ0pFuHvRlkeAIQqYJ5fyoz3YyraPT
	hMW8utDAiG4I7QBt0JTMhoBqWwU13Cjb3OkvA5c+nH4lL3cVjYnm9i5/LPBI0HCLF00Bim42eKQ
	umlfP+xAvE7gNdC/tvoAfwF1D1dHurdXI5pJLqT4tlbdM2tRbI79K2IvHQWZhcBcgcyje7TP3wR
	3sqoSDfOzzBhooDa7uObcA+xzmthC++61onZysl7gzhMJKwU
X-Received: by 2002:a17:902:cec5:b0:2b4:641a:6b7c with SMTP id
 d9443c01a7336-2c16fb1ea23mr1544505ad.13.1780499794739; Wed, 03 Jun 2026
 08:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org> <20260602235709.1541603-7-acme@kernel.org>
In-Reply-To: <20260602235709.1541603-7-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:16:23 -0700
X-Gm-Features: AVHnY4LZR2k0BFzhv-5J48HqtrycV2NljFsqjLpMX0c3SZ6UHSSbKo8u8kpHkc4
Message-ID: <CAP-5=fU0xWWZ2+uCOe-3Pm0F0U-Qu_hbmVZoQ2pyRYo=iwshUg@mail.gmail.com>
Subject: Re: [PATCH 6/8] perf timechart: Fix cat_backtrace() use-after-free on
 corrupted callchain
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, sashiko-bot@kernel.org, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> cat_backtrace() uses open_memstream() to build a backtrace string.
> When an invalid callchain context is encountered, zfree(&p) frees
> the memstream buffer, then the exit path calls fclose(f), which
> flushes to the already-freed buffer =E2=80=94 a use-after-free.  The func=
tion
> then returns a dangling pointer that the caller passes to a handler
> and subsequently double-frees.
>
> Fix by replacing the zfree(&p) with a 'corrupted' flag.  At the exit
> label, always fclose(f) first (which finalizes the buffer), then
> conditionally free it when corrupted.  This ensures the memstream
> contract is honored: the buffer remains valid until fclose().
>
> While here, update the machine__resolve failure message to include
> file_offset and the event type name, matching the pattern from the
> preceding series.  Also update the three legacy power event handlers
> under SUPPORT_OLD_POWER_EVENTS to include file_offset in their
> out-of-bounds CPU messages for consistency.
>
> Reported-by: sashiko-bot@kernel.org # Running on a local machine
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-timechart.c | 36 ++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechar=
t.c
> index 071987241a528ba4..85a9ad0455aecccd 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -489,6 +489,10 @@ static void sched_switch(struct timechart *tchart, i=
nt cpu, u64 timestamp,
>         }
>  }
>
> +/*
> + * Returns a malloc'd backtrace string built via open_memstream, or NULL
> + * on error.  Caller must free() the returned pointer.
> + */
>  static char *cat_backtrace(union perf_event *event,
>                            struct perf_sample *sample,
>                            struct machine *machine)
> @@ -500,6 +504,7 @@ static char *cat_backtrace(union perf_event *event,
>         u8 cpumode =3D PERF_RECORD_MISC_USER;
>         struct ip_callchain *chain =3D sample->callchain;
>         FILE *f =3D open_memstream(&p, &p_len);
> +       bool corrupted =3D false;
>
>         if (!f) {
>                 perror("open_memstream error");
> @@ -511,8 +516,9 @@ static char *cat_backtrace(union perf_event *event,
>                 goto exit;
>
>         if (machine__resolve(machine, &al, sample) < 0) {
> -               fprintf(stderr, "problem processing %d event, skipping it=
.\n",
> -                       event->header.type);
> +               pr_err("problem processing %s (%u) event at offset %#" PR=
Ix64 ", skipping it.\n",
> +                      perf_event__name(event->header.type), event->heade=
r.type,
> +                      sample->file_offset);
>                 goto exit;
>         }
>
> @@ -537,14 +543,8 @@ static char *cat_backtrace(union perf_event *event,
>                                 cpumode =3D PERF_RECORD_MISC_USER;
>                                 break;
>                         default:
> -                               pr_debug("invalid callchain context: "
> -                                        "%"PRId64"\n", (s64) ip);
> -
> -                               /*
> -                                * It seems the callchain is corrupted.
> -                                * Discard all.
> -                                */
> -                               zfree(&p);
> +                               pr_debug("invalid callchain context: %" P=
RId64 "\n", (s64) ip);
> +                               corrupted =3D true;
>                                 goto exit;
>                         }
>                         continue;
> @@ -561,7 +561,14 @@ static char *cat_backtrace(union perf_event *event,
>         }
>  exit:
>         addr_location__exit(&al);
> +       /*
> +        * fclose() on an open_memstream always sets p to a valid buffer,
> +        * even if nothing was written =E2=80=94 see open_memstream(3).  =
So p is
> +        * never NULL after fclose and we need the flag to discard it.
> +        */
>         fclose(f);
> +       if (corrupted)
> +               zfree(&p);
>
>         return p;
>  }
> @@ -686,7 +693,8 @@ process_sample_power_start(struct timechart *tchart _=
_maybe_unused,
>
>         /* perf.data is untrusted input =E2=80=94 cpu_id may be corrupted=
 */
>         if (cpu_id >=3D MAX_CPUS) {
> -               pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long lo=
ng)cpu_id);
> +               pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu_id %l=
lu\n",
> +                        sample->file_offset, (unsigned long long)cpu_id)=
;
>                 return -1;
>         }
>         c_state_start(cpu_id, sample->time, value);
> @@ -700,7 +708,8 @@ process_sample_power_end(struct timechart *tchart,
>  {
>         /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
>         if (sample->cpu >=3D MAX_CPUS) {
> -               pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
> +               pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu %u\n"=
,
> +                        sample->file_offset, sample->cpu);
>                 return -1;
>         }
>         c_state_end(tchart, sample->cpu, sample->time);
> @@ -717,7 +726,8 @@ process_sample_power_frequency(struct timechart *tcha=
rt,
>
>         /* perf.data is untrusted input =E2=80=94 cpu_id may be corrupted=
 */
>         if (cpu_id >=3D MAX_CPUS) {
> -               pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long lo=
ng)cpu_id);
> +               pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu_id %l=
lu\n",
> +                        sample->file_offset, (unsigned long long)cpu_id)=
;
>                 return -1;
>         }
>         p_state_change(tchart, cpu_id, sample->time, value);
> --
> 2.54.0
>
