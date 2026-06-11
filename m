Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34229393DD3
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217234; cv=pass; b=BjTku/8kxZSj0mz7GLngIN3w/bLa6gxqxG2gl0ne8OqP0IuXwSzjmhg+px39tqJKldV9tgFHt3di5u0UCz+ih8oViOEWQrZ2U4CHTiCFsjTBnrB3PF0MSfAmiW0o4zhZTLOqFlgjiGJ6q5XlrSsFMk01HjU6GeWo7jkarDmOc4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217234; c=relaxed/simple;
	bh=tNwIDuQAiloYp6egZSSx45UTPLO6QE475x9DCqKPuIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7vRGUGSCDlpleObaXwDhGYvgrGt2mfgraaCV9gyxT8Hmpeg173cBzCKaHlHmxlTe1U5Wwd4XsH7CCDnyWPY/deu3zAUn85oOzuORN93sfNqBUDBMrV+4VTjHX9dCHF/kDFW71q9xPyKdMug7ULCH9QUYDUEOufXN/gYbZSlzKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1P0V9F+; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1P0V9F+"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1336742714fso2345c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781217231; cv=none;
        d=google.com; s=arc-20240605;
        b=G2dPViQwbPrOHUBVhuyc1yfsO+HIt2TW+F84xd92+GuswzU/FHaD9rZTPsNhIB7+BP
         w6zvkzGhdRqMPDt2M0hD1XMIWsuFdgFOzlJJWrmm/zmTFyTyzofTHIOkazmVeoDfDG4E
         sFy8vVF/MsbFv4vZWNYqktyMihQ4yLcfGtFkjQEjPl1rlKiX8+xXUx+fgGItwTpeWJSG
         S27uggHPQ9geYqbeojwyEhc6KGiHU+zx0CoehlicOMBcNO5JnfJLSXICjGeDNPkCVfMC
         HfQPiwPL2/onA2VSHpRtG/dgrdbty++k/Ofw3z3BXzH8mIMShIEC+vs2/B5rkB8cID5Q
         HI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nw3l4unDk7HICxwfeI3NLNCYaPCjFYuPS2CK3SIDa1U=;
        fh=oifGr1giBB6+bA4DYM+truEFcQdwEfMvPIY9cOQ6Z2I=;
        b=X9uo0ABFJvuRpIZBsEemr/HgSEf99wTUQttsW+sz6wSe1h4EoIoPDHvZ6czXTsWlaz
         tppSYQOaDDWTBnt9JjQafD6LJL4PICStVmU5cWy8fEG14ePl9xRtIPEM0SlbW7alfcmk
         QbLAyU32z5stLeXglzHo/hWN8KTBLlsOYSjyaJ9K64lBRuXnLfK0MiRvD1hsZ9416t8w
         vCRyA9kFWooBZYieBI+pno38kciZA2Xek2NqiUoIzcfbubTV7dwAhiiqmdLR9vrjK0Cd
         5GQMh+ToX7t2iny4LwrXE8VsRTM9k7ZIW+QVGqYE2iPnfi/lSTED1VHD2ftJDfoG1+Qs
         BDFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781217231; x=1781822031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw3l4unDk7HICxwfeI3NLNCYaPCjFYuPS2CK3SIDa1U=;
        b=X1P0V9F+YCJadXQ+/c5R5S86Ca+f/WIFjG2tm+TpXGwqNaUDqeOWPFKKBmPvNykG2g
         he8tMxmaQZnARRLah9o0aVfs7hcfbGxoi62DkZmeufZt3DcQfTfGmOdgMx4NP6fTdU/Z
         xufSbeszvbDZXT6O4kPyZNajG/+Xon55KapbJVyd/p3p7A3kU7I3IMAXZOior2qwBwlN
         2tel+sQ2/p5oEkdnOY6UPtphKIPUJGoewqb6WxpwNYeuDlPkZFz6b86n8qP5xRmfqDfR
         XNcag46FfETd8am84CvsMzZl/Dz7j8JNJOtrQH38zrTPdxwUX1ywZZFyylfq9jmik28i
         smLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781217231; x=1781822031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nw3l4unDk7HICxwfeI3NLNCYaPCjFYuPS2CK3SIDa1U=;
        b=pyMjg9KlCVECLLnDWfGmn18Z0kqfslrgqFv0uOjyA1+BrJ9nsnDVEeelyH7tFmZiXv
         TU5wOkPS8yJoQKJ5WHpViVblTd4Bbaxl3pZ10smCITa0qNsxzgNmWvYhR4q26VwP2ixl
         hTvgfIDjWXZJ6Dvr8rD8/FooIgSgso8cxakDkGALnlkUQ9jRK7F6n1Abwt6e1BORmzjF
         PB6Hns1SE0Wqf3NWpT6gaTPWRHgS1QuqCpH6LEyvslLMGNx9chwAg88eLQjjJR0ucsrM
         FS81Xup3/R+v0B0vgAaaPprX+523VEWHpwJdJgcKO2ixri4W2hw78ZBvGFDQDByDR8ii
         e1sg==
X-Forwarded-Encrypted: i=1; AFNElJ+NR5JqgQxLoiglAJPs6U9X35pe4ZUYb6GnftQxCUmlg8nj8kA9tUAQKgQg8WpSVlKp8t1SUfWd40s7Fw3kN5NH@vger.kernel.org
X-Gm-Message-State: AOJu0YxXvD9Vtoky3hPtbDnBkKc7yk0kBTssOTxBt4p/5KwcOBVg8jvT
	9ZzkiiOEKdysGLIXns3r+x3TWn66w22g8e4xEKXCpuHgFw8lLk/wQPf5hgTCHdUf+fIjrqdFoQK
	hYpzYhtyOWWFxKZgfdv7s2uZlhu8UA9NaoLu2UJ/0
X-Gm-Gg: Acq92OHcrTkrknKm20TkyCt9HBKo1LrpsiC5JPfa5NnXK5k2iAsRsRrXh9KqczG2Mr6
	NdNkdvUfZaDUCQr5T25x2VJXliAE8NDhwKMPQFoSUjwoEE/ppIVEmWd8aF9C5n6f8kt7m926dhB
	2Fv4WExjnj7ApkCVdy8+OBoFi5WzGQ9R/gXK8L3JuMSUOAA8YEPnYYwdi3gycWD34RsuD8duhg2
	S69vGzUZs8NYLBT7DXrNT5p468+GO4rPD2xQY3yJ0IV5XjU8JjjGdW/SPGT+3/IT18nu3gbR7+n
	flszoReAI4zViMPSVa82w+RILfS9IitVbkEEBQ==
X-Received: by 2002:a05:7022:6886:b0:134:f1e8:e591 with SMTP id
 a92af1059eb24-1384ab3fa42mr75651c88.24.1781217230412; Thu, 11 Jun 2026
 15:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611215632.562900-1-ctshao@google.com>
In-Reply-To: <20260611215632.562900-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jun 2026 15:33:38 -0700
X-Gm-Features: AVVi8CeZhQqMl6JxuJjVoyMHrsSe8sdOOF4UwvF0sBcqoZARDrFmiHmNihnQ30o
Message-ID: <CAP-5=fWgNn=VkHmdhR2+R2J_m0WitAf+sXNRh+k=P3+dNApchQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Fix false NMI watchdog warning in
 aggregation modes
To: Chun-Tse Shao <ctshao@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 2:56=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> In aggregation modes (e.g. --per-socket, --per-die, etc.), a
> counter might not be scheduled or counted on specific aggregate
> groups if it was not assigned to the CPUs belonging to those
> groups. However, the printout() check triggers the
> "print_free_counters_hint" logic unconditionally for any
> supported counter with a missing count. This results in a false
> "Some events weren't counted. Try disabling the NMI watchdog"
> warning.
>
> Furthermore, the NMI watchdog only reserves performance counters
> on core PMUs. Uncore PMU events (e.g. CHA, IMC) are not affected
> by the NMI watchdog, but their failures also falsely triggered
> this warning.
>
> This warning was originally introduced in commit 02d492e5dcb7
> ("perf stat: Issue a HW watchdog disable hint").
>
> To fix this, restrict setting of print_free_counters_hint to
> only trigger for core PMU events by checking counter->pmu and
> counter->pmu->is_core.
>
> Example before/after:
>
> $ perf stat -M lpm_miss_lat --metric-only --per-socket -a -- sleep 1
>
> Before:
>  Performance counter stats for 'system wide':
>
>        ns  lpm_miss_lat_rem ns  lpm_miss_lat_loc
> S0      126                202.3               207.9
> S1      126                231.9               259.3
>
>        1.006029831 seconds time elapsed
>
> Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
>
> After:
>  Performance counter stats for 'system wide':
>
>        ns  lpm_miss_lat_rem ns  lpm_miss_lat_loc
> S0      126                202.3               207.9
> S1      126                231.9               259.3
>
>        1.006029831 seconds time elapsed
>
> Assisted-by: Gemini:gemini-next
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

The suggestion for something like:
```
pmu =3D evsel__find_pmu(counter);
if (pmu && pmu->is_core)
```
isn't really necessary because we nearly always set the PMU. Also, a
case where we lack a pmu has historically been for a core PMU, making
the whole thing contradictory. The patch as-is is clear.

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 2b69d238858c..0a5750bb59fa 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -821,9 +821,9 @@ static void printout(struct perf_stat_config *config,=
 struct outstate *os,
>                 ok =3D false;
>
>                 if (counter->supported) {
> -                       if (!evlist__has_hybrid_pmus(counter->evlist)) {
> +                       if (!evlist__has_hybrid_pmus(counter->evlist) &&
> +                           counter->pmu && counter->pmu->is_core)
>                                 config->print_free_counters_hint =3D 1;
> -                       }
>                 }
>         }
>
> --
> 2.54.0.1136.gdb2ca164c4-goog
>
