Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8521749B209
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351273; cv=pass; b=UEqb6PXaW90bkHHPhfyJ8y6uY15FuHNHPfPF66BpuU4zRA1V4LwbhAb+qtj8p9bQI8kXN1mq9j88ap0Bxp9xZFUsIrGFvcddt8tFN5rSc9xHUsbI48YP0/yCfj1VKbI1cbxD10QQtGu+Ux98KCXkKxQwRmHCgHKO2ccc4+8vx8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351273; c=relaxed/simple;
	bh=/ZxCthWVQLi80Q8ToT+iLne/1bHLZhdKaWMea1fHLm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ckd3Kt7AfyhgTka2Ih2fcfV2UVunIt+rXKP6MCQnlfeSXVThrAUNlCUmQSaerFepwWM89d5MJjoi3UCJddtvNVKm2aXxVfxWdt8pEm8jyFjbfp8RwXHkmOwBy3hRbNTexYQxa3tkbjVCFBPyw83MMfxjEqzB0JUewTmov1F7Umw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ASPTWO7b; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASPTWO7b"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52faa58bff5so327231cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 08:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790351269; cv=none;
        d=google.com; s=arc-20260327;
        b=HKYObiq9Y1uCHCl54r8TTkiYhmGjZ3eaMblLxAnDOdoOMJk4LRfyXU2skIG8FO0H0b
         J/+URgF2M+khNvRklmggN8BpuyH5bvGwHmFkKbRJZ+5+AOaKcw5XAVenNOx2qQ8DWy2t
         RVijYOBDxN9uLm4/RglrXVcbGQvKtLolmOX+7hLBnSerXa96b6m37eDzq6/+DFkLoR7g
         b6s/d5LIIEaXVlC4mPenl0pACBHuMAiFky2LI5gT5MfBGEtwjNMK+nMr+6oRfi6hfcDH
         BE05DRZKQoNIB0t+X1hIfm4ohx4Kc74DskqRAcZm4cluKA68dl79LzbEORhsMl21/WCx
         hGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=by084NqSG/pTnJ7x7+ZEKqaDLVSnHeDTMzS0Y6Mbr0U=;
        fh=piDAg0ttntUnY+m/kqtX/2NHp2OM2TtdEVrLJT8c9AU=;
        b=DB81I2P4lnjCp0sFE1nO6QwhjdA5uaHEuvwDgoShh4NnkRxgO/cRIzzgCQ6lNmeZVO
         qY5dvTEmjgeVXYtx6SmRsh68Bz+2H18FV3NB2TufF+XOr/P9LW3p/cM4hZU5U7nmEyvo
         UcaARskR6ZMO5ILiYCcLr3rAoyM2LGO+Xjvs323cLrEQ9vmxGa53fFy+HdDFh7Tr3NKN
         9Ep+VNkczOLUnfzhQ4nmkZaCr7+XW1MEHkAU9+dPX85ap8T4W3w4LklBYlSEylToAtPZ
         2LP6rn8gwEIgrcqTxYuY/bgDVQlvxUW6uqpsgQoAyv0OP+2IrDT9BYjnIKQMX0XjT1ut
         Ap3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790351269; x=1790956069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=by084NqSG/pTnJ7x7+ZEKqaDLVSnHeDTMzS0Y6Mbr0U=;
        b=ASPTWO7bTY5KxYlvxQ1iR0L9InWnkZxGehRiPLQaTl9TAf4HzTsPP0XDHimuvVqSPo
         NfKvCIMqM6Eq+uHQQZv++ANG2YIvLjVBdthEajP/PBI83icsLV+rwxwMe6mkQKoDf9o6
         tSnBGUnpVqzf5QPmkmEXaKQcFp5avqgCc5ZCud3YDgrbqvpmxpgwDr7Gsg1dJLZYjih2
         rM2w7OaOA2mA2ZexJy8PRh/KzpIg6mM63uqN5NwFpcgCzskpbWnu9lOjQJ82chK3sf7V
         nyrojOAzoSVkMWR6ahsoTnuk3yfp4XSkvByXoIpX/Orslco68Jbto2+ahXJou+67dyXe
         qMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351269; x=1790956069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=by084NqSG/pTnJ7x7+ZEKqaDLVSnHeDTMzS0Y6Mbr0U=;
        b=uWMXAKJf61AWM/2QXA+KudcDrcFFNMWaV6LqhSUBEXYTzX9HCQ6vropT/5AUjvlgGk
         GR298/Ck2YDFVPoPC9jK+3/AXdEjA9W3HKjIdMaTRNGUpxqKoFbcKqiIZQDdfIi6ruCy
         ObDzgGmDXGWFZFSf4BasjGI/JJVCTJE+FMtnIdNR6zV7tmTV4FJfNyTuORiIHMf7tt/+
         H12j5z4ONkCF4Ouhes4c3n/l3IIFACcEozjPmK6zgpYAUWzwv2ecSJu2AwU2ZiBF49H4
         NuDKSml/OlUS0amwgkLFSKkpUu9uwcFn0NhgfNt+ZRZa+6FJFiQBwsVuhZbCQdUQBDwa
         bWMA==
X-Forwarded-Encrypted: i=1; AKwUvByRDeb9cPIOdpKXXiW+1gymynnFPZWHg9hk2qXAJ071m70OAWFq48FSqxboVXrzJQlmhH3MK17OG/cHBgUUO3HW@vger.kernel.org
X-Gm-Message-State: AFuF++lK15uO/kK+wnWP4G39yM1BdUUUQdZssDtPsz0BayKuYtdXlhqo
	gyGpaQMFeN2StuTzFdekvZBGEsSr3H6lWNPiPRN+mgcimG/DkoZIC9QKMlQnkWEWISWwrUqG0w5
	/b6gRjPfx7YVLQXbFJ/1cXRY0pqjdQDeKXxfVh0dy
X-Gm-Gg: AYBFou3MYF52m5+QHpan+m7mmMfFALR84WUx+fSo6/C5b+x1sV2LkJGKpxPYcY3snHX
	SzGho2z4jL6cUEIzq+jKnZcWV82O8W14lJc0E0a+ADHhnPyXpJdtOvORrUOQ4HDamo/upm9PhJC
	G81y097w7YmjC4FggfwDO7WgFfjz64HoXTJLdzQKyxDodTz3eTZDMhYwN0TrEfMe8QgUcQn+OvL
	uancK+nmyZSFbhsEm532wocPf+VGDGpG4Ch89arN8my3qyXhxtmU+qKM+8Zxcq5sMoyZvBtO2wX
	bD2O0rIWAK2NM76a2VFpnCSqg0K94zR31ZVo4rQk4tQ4uQevHS/loWogKs9g8y2n1DgZOj411rG
	0ImMV2wThmg==
X-Received: by 2002:ac8:5f95:0:b0:531:6de:6028 with SMTP id
 d75a77b69052e-5331a84dc4cmr4321831cf.13.1790351268496; Fri, 25 Sep 2026
 08:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925150657.1826942-1-acme@kernel.org> <20260925150657.1826942-6-acme@kernel.org>
In-Reply-To: <20260925150657.1826942-6-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 08:47:36 -0700
X-Gm-Features: AclHuK-TlPFDsA96ifQRolrsELZLPsldk2o7CjCkF10lPuk2QTtf01ea887PV-c
Message-ID: <CAP-5=fW1gppdAiUEuRxBsB6LMa2EqxhEwbfjMOp=245Wb0VJJw@mail.gmail.com>
Subject: Re: [PATCH 5/6] perf mem record: Request PERF_SAMPLE_CPU by default
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:07=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The data type profiling per-sample stream keys cross-CPU contention on
> sample->cpu, which without PERF_SAMPLE_CPU is the "no CPU info"
> sentinel, making same-instance accesses from different cores
> indistinguishable from same-CPU traffic.  'perf mem record' already
> passes -d and -W to the record parser, add --sample-cpu and document it
> in perf-mem(1).
>
> Also grow rec_argv: the new entry overflows it on PMUs with separate
> load and store events, as the space for the fixed arguments was not
> reserved.
>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/perf-mem.txt | 4 ++++
>  tools/perf/builtin-mem.c              | 7 +++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documenta=
tion/perf-mem.txt
> index 4d164836d0943119..fe51c5e3333dc4a0 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -14,6 +14,10 @@ DESCRIPTION
>  -----------
>  "perf mem record" runs a command and gathers memory operation data
>  from it, into perf.data. Perf record options are accepted and are passed=
 through.
> +It also requests the address (-d), the weight (-W, where supported) and =
the
> +CPU id (--sample-cpu) of every sampled access by default; the CPU id is =
what
> +lets per-sample analysis tell reads and writes to the same data from
> +different cores apart from same-CPU traffic.
>
>  "perf mem report" displays the result. It invokes perf report with the
>  right set of options to display a memory access profile. By default, loa=
ds
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 6101a26b3a781e69..ade53688ebcd0f10 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -99,8 +99,8 @@ static int __cmd_record(int argc, const char **argv, st=
ruct perf_mem *mem,
>         argc =3D parse_options(argc, argv, options, record_usage,
>                              PARSE_OPT_KEEP_UNKNOWN);
>
> -       /* Max number of arguments multiplied by number of PMUs that can =
support them. */
> -       rec_argc =3D argc + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) +=
 1);
> +       /* Max number of arguments per PMU plus the fixed ones added belo=
w. */
> +       rec_argc =3D argc + 8 + 9 * (perf_pmu__mem_events_num_mem_pmus(pm=
u) + 1);
>
>         if (mem->cpu_list)
>                 rec_argc +=3D 2;
> @@ -135,6 +135,9 @@ static int __cmd_record(int argc, const char **argv, =
struct perf_mem *mem,
>
>         rec_argv[i++] =3D "-d";
>
> +       /* Cross-CPU contention keys on sample->cpu, -1 without PERF_SAMP=
LE_CPU. */
> +       rec_argv[i++] =3D "--sample-cpu";
> +
>         if (mem->phys_addr)
>                 rec_argv[i++] =3D "--phys-data";
>
> --
> 2.53.0
>
