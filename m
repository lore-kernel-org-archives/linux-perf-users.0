Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB539B94D
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499625; cv=pass; b=Y4J23pC8ODJScrNlk4EMsgH81UgWyxbRea13g8H6/ll5x/Y+5qbI7f9LY0eO96bqWj82nNfHvltiXrN9AaQo5UQ7wlrv/r9Bofxc5aGASGU8mn5seWgYU77chSxy5UcSnIFjaCLc134D5mSbcc7NTto7weODFk+SFRE4TUTlJAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499625; c=relaxed/simple;
	bh=cFTF2I2lEv5ASq7/K0ltC/35GZ/6vuFQyjlK7h86gDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAx8qXQfRryf06a+h9IWZAUUIo4FHI9NYTcQGGxEtXiijqKykHh7jpndzCTAWtc7noHjsmY9fgXWU5gWy84dCQXhkb7SEiE52+wrRdattLNNYQBSh1yNqcciXTAgbqeiRJTFSBLaEjIby0MymWKEjxLbEz0QT6Ypqxv7pvzWfGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHGjs0ox; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHGjs0ox"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf2d865383so78995ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499621; cv=none;
        d=google.com; s=arc-20240605;
        b=dKZ24rUo4J9ClMO9TS7R9alC/CnpzGF6UgSPA5qogJqT42iDR5DetRAEmhR+XAYfCJ
         qhMxiGZjCSHVO8cg41XwblrA7VS6Pl2eSFB1PN40r8Zd5jkM4DHso9iMxeHUKNCv1wwB
         FoEx4ksqpcYcHpfBdmODkK81dhxz66uqITuSPOrivGm+JXeZejrxiQiHxAuk4SyJjMRS
         igjv0W54Rih4kLbDs//w/wg8s/11giIZIvgwiHRc0Sh239qvKnfb5A0CdWIru5tSHBZn
         cgGeQb8HIyMpPyEh/rEwMY8zSlIBZvUmGqmV4e+Cg2/rO/+575pFLqOsrRTLKbQ+isu3
         4gkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ILCvQ63fWi29wjmu60ETwqX3KKZFoosJRp1FPlozDsQ=;
        fh=9bU13tfMw2R91kkrEpzKlhGRiXnBUz5mHT2CGQUChls=;
        b=lTEIwCCAxxXIpZLGZxyG5zmDOH2kndkoKHBjQqsIfYxs6dMMj2h8qjyz4oelPKZhao
         WPkafFQ3nL3szqc/eaGPstS7LeUjLCUkKFj88QzPR9rJ4LURHBVXk0xuyjh/jg3WK0Go
         LAbXcTN5ekEj9CUe2KlkUvgFVD+Ot8e7x0usfNuVPZcSQcIV5t57qH7WWIG7xt88yEK8
         qSp96ATrX/Y1xWjU/KrKf1Ex39giJeuxzZFjp/UuIo2DzxaW5D98XGa1bGsmSphjMmwh
         4dXRDgxsNlSGjiDMLa45IFZMEkX4YdmePO6yw6clGs7GMNoX1Kz6Iv7GuN2KuAPouOxK
         Zdsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499621; x=1781104421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILCvQ63fWi29wjmu60ETwqX3KKZFoosJRp1FPlozDsQ=;
        b=CHGjs0oxNRWQgRwixLOqQpf3bi//ou071/Op1A8QSdd5RIzGhoTRhmH2WEDWva9Stn
         QeHwNTzPJd7Sl3pvXCT+x3J4WEuRMUVdwIbVfoX8Nebqn7nrXoH7Jlxo4qDarhCrkLzK
         3wv+pUvl8xBCrewB1hTbL5OxwTU/g9CaAbrelbQPJkjNwEq0JRKQ0ngD5zdgPrYFfciD
         vMw6O+3O9aY73S4DQccAbbIi8jGSyG2gTV3g5i/50n64ar1W6x0/eM/uyCphucxwg2fO
         rX3AUrSSFBqZ7MoozXM40hC0S8c1AP0lpGDiZa3pJ1ScXlSAmySVOjrciFFtllShADMC
         wICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499621; x=1781104421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILCvQ63fWi29wjmu60ETwqX3KKZFoosJRp1FPlozDsQ=;
        b=Q9pKfdeHrJANPQMZfffkmheUvVg5WOHPLNQVz9Rv6XbvTFAGLkMKJwh0vO/BioseZn
         FvP46gLtwXFuNPCK20i2DHUO7JYPKWiz7qejxgB0g54lA5G4srW8bLn5vPIGHkuMP+Wo
         PBoxC8zi6Pv3jkEd92tj+hncUirCm0xCKYfgrvvgS32g5qkxzUIrEognXu8lLJL1T0B2
         4Qegfyn4+bse+pmSZsyS0vP0RoW5tWFMVXnkEusxltt3b3376JEXOOg6ykuvzB47Cwz5
         75tQzc/Dor48ihvJOiSbcgql373SJZ5PJqrOt7o8BF/wdvgotWm6o0wy4oHvyT5ptc9m
         34WA==
X-Forwarded-Encrypted: i=1; AFNElJ8zfFS8xplFzG3SMZtAqZa8H+aUqxiF3cMM9iNX8kuEIDS2Hae5cx7VKZi8zvLVMfuHfKNBedN3xZ4zSUZAkPY0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg859G7mlPuoYLRlI4cq68yMpdJbMwl5kzx82EOypbVwBByVNr
	s8AjRb3bY7cK+k/Vfm/ADmfTKSZ6Nu4xuhbxDEAlRbrD6u94PQE3gYqeWID40VZ52viJGAqIs88
	3arPRK83rWQpjxKRjkOI+VnSSrQqSR44hOuO++4hI
X-Gm-Gg: Acq92OFbwhkwb5HqHzAimvPsLWlSN0xAJVd4VCKU5zesYADqqY0iVk/q/afQc139rtD
	6evDxuBNVAXyLCFf6v/KiRKEOhA6uC8eEmFGm/bmUEIbRw+PeHZcj7H8INCE7G0KtasPGfOR+33
	o0dY7LrH+k413uBWDgjwbIfXpvOCy8KHWSCHczZOyJG3JoBGlg6QucgY73tG+uOI5J6Asj34+IG
	0wo8TT+Yu+/EH1T/U7G9Z5zji8YSLv940enFcEhPsBpuae6WvLyotSpbNsiWZDz+WkuSWcHWN3V
	cEQLhi0r46VqnaWsgwyaFKNrdRbjHicAaxLNrSmeYgujwZK2
X-Received: by 2002:a17:903:2c03:b0:2bd:6dad:7cca with SMTP id
 d9443c01a7336-2c16c14548amr2060045ad.22.1780499620202; Wed, 03 Jun 2026
 08:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org> <20260602235709.1541603-4-acme@kernel.org>
In-Reply-To: <20260602235709.1541603-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:13:28 -0700
X-Gm-Features: AVHnY4LsBwje8WftsY2nqxImJQ6upnB5aTOVffUkbABWsysRBZGiyOBwrJ8iKKo
Message-ID: <CAP-5=fXRQ-e2B8Jw=aA4=FeafHmnAC0SiuHm-qk9t1qn7vKnVQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] perf sched: Include file offset in event skip messages
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
> Add the perf.data file offset to the CPU out-of-bounds and
> machine__resolve failure messages emitted when samples are skipped in
> process_sched_switch_event(), process_sched_runtime_event(), and
> timehist_sched_change_event().  Also switch event type from raw integer
> to perf_event__name() string for readability.
>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 812a1b0d56d6e5f3..9ec8e049e19b0038 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1792,8 +1792,10 @@ static int process_sched_switch_event(const struct=
 perf_tool *tool,
>         u32 prev_pid =3D perf_sample__intval(sample, "prev_pid"),
>             next_pid =3D perf_sample__intval(sample, "next_pid");
>
> +       /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
>         if (this_cpu < 0 || this_cpu >=3D MAX_CPUS) {
> -               pr_warning("Out-of-bound sample CPU %d. Skipping sample\n=
", this_cpu);
> +               pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound=
 sample CPU %d, skipping sample\n",
> +                          sample->file_offset, this_cpu);
>                 return 0;
>         }
>
> @@ -1819,8 +1821,10 @@ static int process_sched_runtime_event(const struc=
t perf_tool *tool,
>  {
>         struct perf_sched *sched =3D container_of(tool, struct perf_sched=
, tool);
>
> +       /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
>         if (sample->cpu >=3D MAX_CPUS) {
> -               pr_warning("Out-of-bound sample CPU %u. Skipping sample\n=
", sample->cpu);
> +               pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound=
 sample CPU %u, skipping sample\n",
> +                          sample->file_offset, sample->cpu);
>                 return 0;
>         }
>
> @@ -2786,15 +2790,18 @@ static int timehist_sched_change_event(const stru=
ct perf_tool *tool,
>         int rc =3D 0;
>         const char state =3D perf_sample__taskstate(sample, "prev_state")=
;
>
> +       /* perf.data is untrusted input =E2=80=94 CPU may be absent or co=
rrupted */
>         if (sample->cpu >=3D MAX_CPUS) {
> -               pr_warning("Out-of-bound sample CPU %d. Skipping sample\n=
", sample->cpu);
> +               pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound=
 sample CPU %d, skipping sample\n",
> +                          sample->file_offset, sample->cpu);
>                 return 0;
>         }
>
>         addr_location__init(&al);
>         if (machine__resolve(machine, &al, sample) < 0) {
> -               pr_err("problem processing %d event. skipping it\n",
> -                      event->header.type);
> +               pr_err("problem processing %s (%u) event at offset %#" PR=
Ix64 ", skipping it\n",
> +                      perf_event__name(event->header.type), event->heade=
r.type,
> +                      sample->file_offset);
>                 rc =3D -1;
>                 goto out;
>         }
> --
> 2.54.0
>
