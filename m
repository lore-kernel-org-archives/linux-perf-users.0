Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C9919DF66
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733356577; cv=none; b=JAVW6YM5mnqZWaXfy7leoNd6SPJmoJ/YsCa65ru1ww6liL+RSsop3reGQ04gqdcQw27soFssY8S9HpCIvybfsT+1dtSC4CVbjGi/uLsvyWhlkqzDuWSnbSsw0+0Kd1d2kaAQcmQMFLatnSYejl6sov5oAx92ECAbK1wdXhw499E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733356577; c=relaxed/simple;
	bh=l3U0yJJE36QRWVI/0Ef+4QhRMoufGHj2/nrmEhWmea0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KA/NgHimHF9U66zsGIp/s3PxjHOh0Dk+mNkb5nKKF9iV1czuj+LBkBzwQeAE9Bb6bn3O024pIAwxBwee4fSpjal/d1dV9gIbSuw/1mYX3r17VTHCc8Rn5wyJDfMqNrNCt08jwIc3qPRlzXVEbmijByxr+GZr8QLO6z+2JUGiMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGPa36ly; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGPa36ly"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a7bc2d7608so22325ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 15:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733356575; x=1733961375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8Q+F6en17eJQgfw76pO4T5MKRbHqUZjXgG7qVMS2IU=;
        b=QGPa36lylsEGZfi7Vauzz0BmDxS4PgrE5o5JA3JOCfv4e8iloA6cdrBpM8LD/n3OB/
         UmOPcGiLsjW9W0BGr34ZrR1YmSXy1bSG4YyhAC8EOVy1c6Htk2uoiz+Y27f9sRNvsXnV
         B7CjGgw/tNUO3xkwv0O3V6ovS8OAne6/PiCsxAM248gGNxWNLg0kfWgowTeBaKRNJHN9
         YO1yAr0zN9mHL2JkRhMdfk1VkMamVl4pVmfCRMTHThQg+Wwta1rY30HEaGVPcwTYpafU
         9kFMHDOQoWMpzOaZHuX1naoXUmWaNm4R0nu9xCI3BWZ55bcWYaH1mAkzU3VM10CirYhv
         +Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733356575; x=1733961375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8Q+F6en17eJQgfw76pO4T5MKRbHqUZjXgG7qVMS2IU=;
        b=DovdcR5WnrvOvAUSq8FrnWwUAZ3FYsJXs34fCQyKkoL1fX4xmDTf17uPUqcprxHFNd
         11sYUhnUEfhEMCUNrwqaIiKfr46mb+UlvVo2damNLXLHjyeUhReQsQrMCrQEp35HYoc4
         baZBYn3ftHHzxmwMm4uEweR8ZE/oKg5+SsBclFXEy94aP0nmtBLBukNIPF9PALjCNJ3t
         4Knby7dHx6KnjnNarPKL7E9RCcOoMocAERT9vm+jexgSKWGeLNF2HsJLvflzPaJ6sn6S
         f+AJZ+W1FcreWLrM9r9/2mAfhtrGRvv1/cG+sXhrd6sqhA8cDq1N4soyatKyo3vQUo3Z
         YmCw==
X-Gm-Message-State: AOJu0YyiqNZQtALR9gVhYOQUUcQgdZZ1DK1Z6bGZvwhWp1HOVO/6mTeA
	TNwMreMFMxtgObikZRvgT3+tgBJYpCp3Jmsh9ig7F01PMDV63OYxt+YMSB5OGWo6+u5n0x8PUvb
	TdcIwCsdA0862MUWh7gKITfKbzy13Lu70YYdu
X-Gm-Gg: ASbGnctMsFLsrwkJJ21YExnPIav7hegJCmJ01S345nVeYZeGR3BBYdM/8FOba4pPW1e
	uoRehssDMy4urRHOFg2+1W9wbvB9RnK03
X-Google-Smtp-Source: AGHT+IHRiOICm/Y/IPwvPUgx3E/i5KvQt+b8VmnQpipO1sGUnM5NcQm+mIVfODWSKuu/gQnH8obw8GpXOkA4UKKZxJQ=
X-Received: by 2002:a05:6e02:3693:b0:3a7:5cf1:8a5f with SMTP id
 e9e14a558f8ab-3a80933c362mr625605ab.13.1733356574602; Wed, 04 Dec 2024
 15:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202182815.639124-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241202182815.639124-1-andriy.shevchenko@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Dec 2024 15:56:03 -0800
Message-ID: <CAP-5=fXbjvsmuKrNe1uAOYLV0k5U9OBuHV+drSs_5JyUuXQ9SQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pref/x86/rapl: Remove unused function
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 10:28=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> get_rapl_pmu_cpumask() is unused, it prevents kernel builds
> with clang, `make W=3D1` and CONFIG_WERROR=3Dy:
>
>   arch/x86/events/rapl.c:165:37: error: unused function 'get_rapl_pmu_cpu=
mask' [-Werror,-Wunused-function]
>
> Fix this by removing unused function.
>
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=3D1 build").
>
> Fixes: 9e9af8bbb5f9 ("perf/x86/rapl: Clean up cpumask and hotplug")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

nit: s/pref/perf/ in the commit message title

Thanks,
Ian

> ---
>  arch/x86/events/rapl.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index a8defc813c36..3ed5ea2aa867 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -162,12 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
>                                          topology_logical_die_id(cpu);
>  }
>
> -static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
> -{
> -       return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
> -                                        topology_die_cpumask(cpu);
> -}
> -
>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>  {
>         unsigned int rapl_pmu_idx =3D get_rapl_pmu_idx(cpu);
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
