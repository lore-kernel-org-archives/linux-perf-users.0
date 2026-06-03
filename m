Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E4399CEE
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499574; cv=pass; b=dAmuUtSFE/rgv6+E+ADZSyo3KL+PLAKfTkvC6FhbcoG7CA7KcCtGWQZP78fP7muvOw+dlhrC4NLsqbIfYqqGArnnybW5Dsku3jTbn2aGMSeNNipJ/N995p5M/FI1A+AwS2mcTf9nKn0W7l3oJFlYq65FTkgW42kXbV3uCPc3cqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499574; c=relaxed/simple;
	bh=xohsYgTKq9zTCLMmDZTwPfpbUOiV4HW3X00Bho/FeAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/xhwPuYTW9tKpd8ZF4Zg1aMoB0d0VQh/srfmxD0ygJRBwoQ/gnqJn8Bu4Wo6L7DgeCA0WGnnzqStpOgOxJW9AlUmO5bvUxXPZ77VaBfjSZguPeXzuON9QxD5UPxubAdqjncQM3+GLrsa+la9eu5VUJQv9iqt6usITD0KJAaNCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JoYVtdFj; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JoYVtdFj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf2d865383so78825ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499572; cv=none;
        d=google.com; s=arc-20240605;
        b=Hu7Dt30da01DaFqgfp4OZ00oh0cGAMdmip088qnqvzpU+/I1qEJmepdaq8SGGnibJj
         elu5zSZmM5K+mS68z991oPSo3tk+aepc4/uMO/FXDKDFRFf2EfcTwVltN7I8FvNrQiqa
         WROFa8LxY27tnhwg5nGp9NojSkKd7aWulus7o6s8TAmcwQTQtvcLkeWvxg5o1b3HIwX1
         19NApcbuDV++VQvcOSpIvHkbK9gCAr1+XJ8vJ7xpysmtQFrfSYECHHCw2zJ1PQ0ctYmn
         MU86v5fKkPyYI9nf1Rui3UMyF6BxhJo3v9WoMPTIBw5+ak2AxunNU/myKlYLdExCDpwW
         ss0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0upglKKotXyejJcDpi/mba7XIl4JpAONYrYEYMuVQfE=;
        fh=pEdk3OSPg2lETjS1dYFWznJQ2JZmgQ/u46J+Fn5ShJA=;
        b=i1Ht1pnkLOWE3nXoZ/0yynmOOPlW/Ha4xdjl3XiLnOUucdYqAAFPIxgQaPJn4JQ/6n
         1dei3qN9F2vI8xcPyCDnLthBqc2huN0cpxQT3FTpOlQvijFpoE12DQReaxkwxqbSBnfP
         CjdnRmMukjLQmVIzbiL1OuASlELir2nI3jAGQ+IpCXpB3EzC/9J7SWHlfkDRNlA/lqSY
         gGvVZGlBp6LLR57EMobt2z2VaT3m6FNA1x8GXzK11KMHF9nrsfmxHSvidmvJ2e2Rlh6i
         WrQ1KA1KtUSKjqptEIB6iTrhotkqf2PFUWZc0kOCezjQeGOJRnrRLMWqUXg1IYPBwQDI
         FhEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499572; x=1781104372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0upglKKotXyejJcDpi/mba7XIl4JpAONYrYEYMuVQfE=;
        b=JoYVtdFjubyV7O0U8ay+8I2H0Qk3JSF3jcO6G0Imk2aYGqa4u6sn5UtMG+Sv11ORxP
         /Mg7Y8c1OFdJeR2C182P7VInfTQ0u6WCX3xTVbASYiniuKE5fjFGTnSJMMiV5ODz1Nxf
         zBXXNZlLLK7B7omkycVaUVyX2fRJvW5joU1TIOJ35z4CDjLycCN9BZy32iHplWPxqoVt
         qBJEnTlPTrqCIW0noF+5zIEBbC3pbHBatt1Z8OL7KyGVMnR5S8RXk+m6PMRPSNqoiHZI
         pPxFL1U3tLR2K/gHyaaRqMYJcd0qZvuS2YIFwM+qpmsGtLuxjYFXb/VhPZbLrdc9hwz/
         cweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499572; x=1781104372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0upglKKotXyejJcDpi/mba7XIl4JpAONYrYEYMuVQfE=;
        b=ljjBs0LFY3HTomivGHwlJkq8LItIK8Zdf5u549x1LzmdXEpBn/xsqcJSg62wfxHyZA
         lH1I9xMlX5BxpB/H/0jU+/Rw90Wj81a/UjAXfr/M4ywjzlONrCFK3hjYMfBjAa1u+g5m
         e20rHIMsFb1HtSB/NMkqN2TK7TH0LKgORuXZNg9hmHVifo0gi+XXLxbM7aagRTWi4y8r
         oPNhQ3cjO6TDDXYfHo+UxDiXe5ajUqwszDjYHQsTVTIQZUnlDs9cL8XmXh8HhX/fyNE9
         +53IcVwZWLStWmm5hVj83FwbkAONFm7f51tTtrX7bFM8+KOd2s1QgVvjeNynI66S8IIS
         Gydw==
X-Forwarded-Encrypted: i=1; AFNElJ9iEWdngZLy3OK9I8/DTDhUZz2kQZPHZ9ivmCX8jfDfEqzj/xiXjGiPpS22X42ywkf2SUVCy92Pian/Yzwpc53Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyFLsKAnvc8HDswwEwab75lzSF9/48y7DF3GJ2ZfaE7I+Iqof
	s0R78+c+ZtlKB5inTi2547sFwAa10rn53xiuM5S3jfrYDnEiCXxIoM/OgHX9q5zzwifvWwOrqIF
	LrvSDbLuHdBgFmwEQxS3IVHN9U9NYtUMlJ39txL90
X-Gm-Gg: Acq92OFYD1ahlUORNbAkYAuVOC9tzKXasEuO9paGqj/6lIGCs0qNClhAWKIR5/H2DAq
	OkxcewOwZrSF0PMkc+eQBFJhEpyJOuOrbhDXh36JFFDSSoavYq80qtIx3v91UDQSJCeo7xwx2hB
	F51I6jBZyMQwRr449y77heYQ41OUfwmyDM6bpZS4qpAgK2Pp3n+RCrS82hyuAHmu22aqmxziANW
	gsi4aGot9BocxaavMwfbP1B/fZu6vQeI0kpKG3de4Nfgetf2RLyLTOZELrHbVD+ijfY11L/wFAN
	HGmOqEN3XjjjkiHUuDcMj9sr88WQyZcSme7qV29g9rbo+x0JdWjyYKPVC7E=
X-Received: by 2002:a17:903:3d0f:b0:2c0:c3ac:fdf9 with SMTP id
 d9443c01a7336-2c16c14215bmr2183785ad.14.1780499571334; Wed, 03 Jun 2026
 08:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org> <20260602235709.1541603-3-acme@kernel.org>
In-Reply-To: <20260602235709.1541603-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:12:40 -0700
X-Gm-Features: AVHnY4IZXXvZkV-lgISxRZ3yCNHWjnyk6KtJ9WbXQR_Lmf2HPDi2HLwwoWE4Yss
Message-ID: <CAP-5=fVPBt79JiC8a1XUDKOOKT0hHePmWzXq0_3-RS2kWp9O7A@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf session: Include file offset in event skip/stop messages
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Add 'at offset %#<hex>' to all warning and error messages in session.c
> that fire when events are skipped or processing stops due to validation
> failures.  This lets users cross-reference with 'perf report -D' output
> to inspect the surrounding records and understand the corruption context.
>
> Covers messages in perf_session__process_event() (alignment, min size,
> swap failure), perf_session__deliver_event() (no evsel, parse failure,
> CPU clamping), machines__deliver_event() (NAMESPACES, TEXT_POKE,
> null-terminated string checks for MMAP/MMAP2/COMM/CGROUP/KSYMBOL), and
> perf_session__process_user_event() (THREAD_MAP, CPU_MAP, STAT_CONFIG,
> BPF_METADATA, HEADER_BUILD_ID).
>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/session.c | 112 ++++++++++++++++++++------------------
>  1 file changed, 60 insertions(+), 52 deletions(-)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7996787d742e32c6..e4efb75509278a4e 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1931,13 +1931,14 @@ static int session__flush_deferred_samples(struct=
 perf_session *session,
>   * read-only (MAP_SHARED + PROT_READ) so we cannot write a
>   * null byte in place; skip the event instead.
>   */
> -static bool perf_event__check_nul(const char *str, const void *end, cons=
t char *event_name)
> +static bool perf_event__check_nul(const char *str, const void *end,
> +                                 const char *event_name, u64 file_offset=
)
>  {
>         size_t max_len =3D (const char *)end - str;
>
>         if (max_len =3D=3D 0 || strnlen(str, max_len) =3D=3D max_len) {
> -               pr_warning("WARNING: PERF_RECORD_%s: string not null-term=
inated, skipping event\n",
> -                          event_name);
> +               pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_=
%s: string not null-terminated, skipping event\n",
> +                          file_offset, event_name);
>                 return false;
>         }
>
> @@ -1995,7 +1996,7 @@ static int machines__deliver_event(struct machines =
*machines,
>         case PERF_RECORD_MMAP:
>                 if (!perf_event__check_nul(event->mmap.filename,
>                                            (void *)event + event->header.=
size,
> -                                          "MMAP"))
> +                                          "MMAP", file_offset))
>                         return 0;
>                 return tool->mmap(tool, event, sample, machine);
>         case PERF_RECORD_MMAP2:
> @@ -2003,13 +2004,13 @@ static int machines__deliver_event(struct machine=
s *machines,
>                         ++evlist->stats.nr_proc_map_timeout;
>                 if (!perf_event__check_nul(event->mmap2.filename,
>                                            (void *)event + event->header.=
size,
> -                                          "MMAP2"))
> +                                          "MMAP2", file_offset))
>                         return 0;
>                 return tool->mmap2(tool, event, sample, machine);
>         case PERF_RECORD_COMM:
>                 if (!perf_event__check_nul(event->comm.comm,
>                                            (void *)event + event->header.=
size,
> -                                          "COMM"))
> +                                          "COMM", file_offset))
>                         return 0;
>                 return tool->comm(tool, event, sample, machine);
>         case PERF_RECORD_NAMESPACES: {
> @@ -2027,8 +2028,8 @@ static int machines__deliver_event(struct machines =
*machines,
>                  * cross-endian path.
>                  */
>                 if (event->namespaces.nr_namespaces > max_nr) {
> -                       pr_warning("WARNING: PERF_RECORD_NAMESPACES: nr_n=
amespaces %" PRIu64 " exceeds payload (max %" PRIu64 "), skipping\n",
> -                                  (u64)event->namespaces.nr_namespaces, =
max_nr);
> +                       pr_warning("WARNING: at offset %#" PRIx64 ": PERF=
_RECORD_NAMESPACES: nr_namespaces %" PRIu64 " exceeds payload (max %" PRIu6=
4 "), skipping\n",
> +                                  file_offset, (u64)event->namespaces.nr=
_namespaces, max_nr);
>                         return 0;
>                 }
>                 return tool->namespaces(tool, event, sample, machine);
> @@ -2036,7 +2037,7 @@ static int machines__deliver_event(struct machines =
*machines,
>         case PERF_RECORD_CGROUP:
>                 if (!perf_event__check_nul(event->cgroup.path,
>                                            (void *)event + event->header.=
size,
> -                                          "CGROUP"))
> +                                          "CGROUP", file_offset))
>                         return 0;
>                 return tool->cgroup(tool, event, sample, machine);
>         case PERF_RECORD_FORK:
> @@ -2078,7 +2079,7 @@ static int machines__deliver_event(struct machines =
*machines,
>         case PERF_RECORD_KSYMBOL:
>                 if (!perf_event__check_nul(event->ksymbol.name,
>                                            (void *)event + event->header.=
size,
> -                                          "KSYMBOL"))
> +                                          "KSYMBOL", file_offset))
>                         return 0;
>                 return tool->ksymbol(tool, event, sample, machine);
>         case PERF_RECORD_BPF_EVENT:
> @@ -2090,7 +2091,8 @@ static int machines__deliver_event(struct machines =
*machines,
>                                        event->text_poke.new_len;
>
>                 if (event->header.size < text_poke_len) {
> -                       pr_warning("WARNING: PERF_RECORD_TEXT_POKE: old_l=
en+new_len exceeds event, skipping\n");
> +                       pr_warning("WARNING: at offset %#" PRIx64 ": PERF=
_RECORD_TEXT_POKE: old_len+new_len exceeds event, skipping\n",
> +                                  file_offset);
>                         return 0;
>                 }
>                 return tool->text_poke(tool, event, sample, machine);
> @@ -2120,14 +2122,17 @@ static int perf_session__deliver_event(struct per=
f_session *session,
>         perf_sample__init(&sample, /*all=3D*/false);
>         evsel =3D evlist__event2evsel(session->evlist, event);
>         if (!evsel) {
> -               pr_err("No evsel found for event type %u\n",
> +               pr_err("ERROR: at offset %#" PRIx64 ": no evsel found for=
 %s (%u) event\n",
> +                      file_offset, perf_event__name(event->header.type),
>                        event->header.type);
>                 ret =3D -EFAULT;
>                 goto out;
>         }
>         ret =3D evsel__parse_sample(evsel, event, &sample);
>         if (ret) {
> -               pr_err("Can't parse sample, err =3D %d\n", ret);
> +               pr_err("ERROR: at offset %#" PRIx64 ": can't parse %s (%u=
) sample, err =3D %d\n",
> +                      file_offset, perf_event__name(event->header.type),
> +                      event->header.type, ret);
>                 goto out;
>         }
>         sample.file_offset =3D file_offset;
> @@ -2204,8 +2209,8 @@ static int perf_session__deliver_event(struct perf_=
session *session,
>                          * Downstream array users (timechart, kwork) have
>                          * their own per-callback bounds checks.
>                          */
> -                       pr_warning_once("WARNING: sample CPU %u >=3D nr_c=
pus_avail %u, clamping to 0\n",
> -                                       sample.cpu, nr_cpus_avail);
> +                       pr_warning_once("WARNING: at offset %#" PRIx64 ":=
 sample CPU %u >=3D nr_cpus_avail %u, clamping to 0\n",
> +                                       file_offset, sample.cpu, nr_cpus_=
avail);
>                         sample.cpu =3D 0;
>                 }
>         }
> @@ -2278,7 +2283,7 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>         case PERF_RECORD_HEADER_BUILD_ID:
>                 if (!perf_event__check_nul(event->build_id.filename,
>                                            (void *)event + event_size,
> -                                          "HEADER_BUILD_ID")) {
> +                                          "HEADER_BUILD_ID", file_offset=
)) {
>                         err =3D 0;
>                         break;
>                 }
> @@ -2311,8 +2316,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                 u64 max_nr;
>
>                 if (event_size < sizeof(event->thread_map)) {
> -                       pr_err("PERF_RECORD_THREAD_MAP: header.size (%u) =
too small\n",
> -                              event_size);
> +                       pr_err("ERROR: at offset %#" PRIx64 ": PERF_RECOR=
D_THREAD_MAP: header.size (%u) too small\n",
> +                              file_offset, event_size);
>                         err =3D -EINVAL;
>                         break;
>                 }
> @@ -2320,8 +2325,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                 max_nr =3D (event_size - sizeof(event->thread_map)) /
>                          sizeof(event->thread_map.entries[0]);
>                 if (event->thread_map.nr > max_nr) {
> -                       pr_err("PERF_RECORD_THREAD_MAP: nr %" PRIu64 " ex=
ceeds max %" PRIu64 "\n",
> -                              (u64)event->thread_map.nr, max_nr);
> +                       pr_err("ERROR: at offset %#" PRIx64 ": PERF_RECOR=
D_THREAD_MAP: nr %" PRIu64 " exceeds max %" PRIu64 "\n",
> +                              file_offset, (u64)event->thread_map.nr, ma=
x_nr);
>                         err =3D -EINVAL;
>                         break;
>                 }
> @@ -2345,8 +2350,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                                      sizeof(data->cpus_data.cpu[0]);
>
>                         if (data->cpus_data.nr > max_nr) {
> -                               pr_warning("WARNING: PERF_RECORD_CPU_MAP:=
 nr %u exceeds payload (max %u), skipping\n",
> -                                          data->cpus_data.nr, max_nr);
> +                               pr_warning("WARNING: at offset %#" PRIx64=
 ": PERF_RECORD_CPU_MAP: nr %u exceeds payload (max %u), skipping\n",
> +                                          file_offset, data->cpus_data.n=
r, max_nr);
>                                 err =3D 0;
>                                 goto out;
>                         }
> @@ -2359,8 +2364,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                                              sizeof(data->mask32_data.mas=
k[0]);
>
>                                 if (data->mask32_data.nr > max_nr) {
> -                                       pr_warning("WARNING: PERF_RECORD_=
CPU_MAP mask32: nr %u exceeds payload (max %u), skipping\n",
> -                                                  data->mask32_data.nr, =
max_nr);
> +                                       pr_warning("WARNING: at offset %#=
" PRIx64 ": PERF_RECORD_CPU_MAP mask32: nr %u exceeds payload (max %u), ski=
pping\n",
> +                                                  file_offset, data->mas=
k32_data.nr, max_nr);
>                                         err =3D 0;
>                                         goto out;
>                                 }
> @@ -2375,14 +2380,14 @@ static s64 perf_session__process_user_event(struc=
t perf_session *session,
>                                                              mask64_data.=
mask)) /
>                                          sizeof(data->mask64_data.mask[0]=
);
>                                 if (data->mask64_data.nr > max_nr) {
> -                                       pr_warning("WARNING: PERF_RECORD_=
CPU_MAP mask64: nr %u exceeds payload (max %u), skipping\n",
> -                                                  data->mask64_data.nr, =
max_nr);
> +                                       pr_warning("WARNING: at offset %#=
" PRIx64 ": PERF_RECORD_CPU_MAP mask64: nr %u exceeds payload (max %u), ski=
pping\n",
> +                                                  file_offset, data->mas=
k64_data.nr, max_nr);
>                                         err =3D 0;
>                                         goto out;
>                                 }
>                         } else {
> -                               pr_warning("WARNING: PERF_RECORD_CPU_MAP:=
 unsupported long_size %u, skipping\n",
> -                                          data->mask32_data.long_size);
> +                               pr_warning("WARNING: at offset %#" PRIx64=
 ": PERF_RECORD_CPU_MAP: unsupported long_size %u, skipping\n",
> +                                          file_offset, data->mask32_data=
.long_size);
>                                 err =3D 0;
>                                 goto out;
>                         }
> @@ -2404,8 +2409,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                  * cannot clamp nr in place.  Skip the event instead.
>                  */
>                 if (event->stat_config.nr > max_nr) {
> -                       pr_warning("WARNING: PERF_RECORD_STAT_CONFIG: nr =
%" PRIu64 " exceeds payload (max %" PRIu64 "), skipping\n",
> -                                  (u64)event->stat_config.nr, max_nr);
> +                       pr_warning("WARNING: at offset %#" PRIx64 ": PERF=
_RECORD_STAT_CONFIG: nr %" PRIu64 " exceeds payload (max %" PRIu64 "), skip=
ping\n",
> +                                  file_offset, (u64)event->stat_config.n=
r, max_nr);
>                         err =3D 0;
>                         goto out;
>                 }
> @@ -2446,8 +2451,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                 u64 nr_entries, max_entries;
>
>                 if (event_size < sizeof(event->bpf_metadata)) {
> -                       pr_warning("WARNING: PERF_RECORD_BPF_METADATA: he=
ader.size (%u) too small, skipping\n",
> -                                  event_size);
> +                       pr_warning("WARNING: at offset %#" PRIx64 ": PERF=
_RECORD_BPF_METADATA: header.size (%u) too small, skipping\n",
> +                                  file_offset, event_size);
>                         err =3D 0;
>                         break;
>                 }
> @@ -2458,7 +2463,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                  */
>                 if (strnlen(event->bpf_metadata.prog_name,
>                             BPF_PROG_NAME_LEN) =3D=3D BPF_PROG_NAME_LEN) =
{
> -                       pr_warning("WARNING: PERF_RECORD_BPF_METADATA: pr=
og_name not null-terminated, skipping\n");
> +                       pr_warning("WARNING: at offset %#" PRIx64 ": PERF=
_RECORD_BPF_METADATA: prog_name not null-terminated, skipping\n",
> +                                  file_offset);
>                         err =3D 0;
>                         break;
>                 }
> @@ -2467,8 +2473,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                 max_entries =3D (event_size - sizeof(event->bpf_metadata)=
) /
>                               sizeof(event->bpf_metadata.entries[0]);
>                 if (nr_entries > max_entries) {
> -                       pr_warning("WARNING: PERF_RECORD_BPF_METADATA: nr=
_entries %" PRIu64 " exceeds max %" PRIu64 ", skipping\n",
> -                                  nr_entries, max_entries);
> +                       pr_warning("WARNING: at offset %#" PRIx64 ": PERF=
_RECORD_BPF_METADATA: nr_entries %" PRIu64 " exceeds max %" PRIu64 ", skipp=
ing\n",
> +                                  file_offset, nr_entries, max_entries);
>                         err =3D 0;
>                         break;
>                 }
> @@ -2478,7 +2484,8 @@ static s64 perf_session__process_user_event(struct =
perf_session *session,
>                                     BPF_METADATA_KEY_LEN) =3D=3D BPF_META=
DATA_KEY_LEN ||
>                             strnlen(event->bpf_metadata.entries[i].value,
>                                     BPF_METADATA_VALUE_LEN) =3D=3D BPF_ME=
TADATA_VALUE_LEN) {
> -                               pr_warning("WARNING: PERF_RECORD_BPF_META=
DATA: entry %" PRIu64 " key/value not null-terminated, skipping\n", i);
> +                               pr_warning("WARNING: at offset %#" PRIx64=
 ": PERF_RECORD_BPF_METADATA: entry %" PRIu64 " key/value not null-terminat=
ed, skipping\n",
> +                                          file_offset, i);
>                                 err =3D 0;
>                                 goto out;
>                         }
> @@ -2752,22 +2759,22 @@ int perf_session__peek_event(struct perf_session =
*session, off_t file_offset,
>             event->header.type !=3D PERF_RECORD_HEADER_TRACING_DATA &&
>             event->header.type !=3D PERF_RECORD_COMPRESSED &&
>             event->header.type !=3D PERF_RECORD_HEADER_FEATURE) {
> -               pr_warning("WARNING: peek_event: event type %u size %u no=
t aligned to %zu\n",
> -                          event->header.type,
> -                          event->header.size, sizeof(u64));
> +               pr_warning("WARNING: at offset %#" PRIx64 ": %s (%u) even=
t size %u not aligned to %zu\n",
> +                          (u64)file_offset, perf_event__name(event->head=
er.type),
> +                          event->header.type, event->header.size, sizeof=
(u64));
>                 return -1;
>         }
>
>         if (event->header.type >=3D PERF_RECORD_HEADER_MAX) {
> -               pr_warning("WARNING: peek_event: unsupported event type %=
u, skipping\n",
> -                          event->header.type);
> +               pr_warning("WARNING: at offset %#" PRIx64 ": unsupported =
event type %u, skipping\n",
> +                          (u64)file_offset, event->header.type);
>                 return 0;
>         }
>
>         if (perf_event__too_small(event, &min_sz)) {
> -               pr_warning("WARNING: peek_event: %s event size %u too sma=
ll (min %u)\n",
> -                          perf_event__name(event->header.type),
> -                          event->header.size, min_sz);
> +               pr_warning("WARNING: at offset %#" PRIx64 ": %s (%u) even=
t size %u too small (min %u)\n",
> +                          (u64)file_offset, perf_event__name(event->head=
er.type),
> +                          event->header.type, event->header.size, min_sz=
);
>                 return -1;
>         }
>
> @@ -2883,9 +2890,9 @@ static s64 perf_session__process_event(struct perf_=
session *session,
>             event->header.type !=3D PERF_RECORD_HEADER_TRACING_DATA &&
>             event->header.type !=3D PERF_RECORD_COMPRESSED &&
>             event->header.type !=3D PERF_RECORD_HEADER_FEATURE) {
> -               pr_err("ERROR: %s event size %u is not 8-byte aligned, ab=
orting\n",
> -                      perf_event__name(event->header.type),
> -                      event->header.size);
> +               pr_err("ERROR: at offset %#" PRIx64 ": %s (%u) event size=
 %u is not 8-byte aligned, aborting\n",
> +                      file_offset, perf_event__name(event->header.type),
> +                      event->header.type, event->header.size);
>                 return -EINVAL;
>         }
>
> @@ -2905,16 +2912,17 @@ static s64 perf_session__process_event(struct per=
f_session *session,
>          * can be safely stepped over without misaligning the stream.
>          */
>         if (perf_event__too_small(event, &min_sz)) {
> -               pr_warning("WARNING: %s event size %u too small (min %u),=
 skipping\n",
> -                          perf_event__name(event->header.type),
> -                          event->header.size, min_sz);
> +               pr_warning("WARNING: at offset %#" PRIx64 ": %s (%u) even=
t size %u too small (min %u), skipping\n",
> +                          file_offset, perf_event__name(event->header.ty=
pe),
> +                          event->header.type, event->header.size, min_sz=
);
>                 return 0;
>         }
>
>         if (session->header.needs_swap &&
>             event_swap(event, evlist__sample_id_all(evlist))) {
> -               pr_warning("WARNING: swap failed for %s event, skipping\n=
",
> -                          perf_event__name(event->header.type));
> +               pr_warning("WARNING: at offset %#" PRIx64 ": swap failed =
for %s (%u) event, skipping\n",
> +                          file_offset, perf_event__name(event->header.ty=
pe),
> +                          event->header.type);
>                 return 0;
>         }
>
> --
> 2.54.0
>
