Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A27192D77
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728626662; cv=none; b=CORrSPofc1Rj9ihxKtknYfjCvWNjkzKdHuyjtNSikjhTXFtElZDBWc1k0tHfTX7Ix36T/z5sCJE3rf+kX+KxmzX/lk98jnzLdWKESMdqzNOUOJbM6NHOyoTBIHmlLj1suZCHf7ebdLnILi46fPoNaF0rb4tMPINPsP6HQrOubig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728626662; c=relaxed/simple;
	bh=3H0dv7BFZ5Y7LwucxRuaWgvNMSTIrIlglR3oVUr1rN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZVI0Z6fMdFQqaKsXDhLmUF+yb8/kAZl2iuutmFXUFtVc56e4e9z94rfyeRco3i1t86Pg5NBzbKniknn1H0KQ9HOxU6yeHGj1G4h3JskuJ0JAHZHVAL7nrPyQXyq60B1vkx6bcx4WlLnfrOV7owPcTfvLFFXZ+X7qOsDJb88WiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnsbzCdo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnsbzCdo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca03687fdso104095ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728626661; x=1729231461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxjfSmLfZygvqrMS13VPlH46Tg3+4LUKlezh/w4aBGo=;
        b=fnsbzCdoG9AleHnBsR0eBLrTe/mZeo99YsREtgFtitLZzyNm7WOc6LApHcUVCvMg+M
         b++k5px6rX+aDeA5wPgtgsdVoHNV+t3eHK0km7YezgUpI+ccaCSX89VQU4AhJaSu0mH2
         b1w7/Ucwo2YOBM6U22yy3aSnnT+ipePZ3VvfHzPvPLRG8B0jK06oWY4UKmHB4BtA+BA7
         GsfcdUeaOWoNznjyIdcnKCvKNg8EY2sgck4v+va3LUeQO2vKFgObSsAXAjh/56d9fe2y
         lUTj90Bbpa6ob/g6yY9hGD2ZqROf40vxR7An/urTfcfQt6bSPj4ZmCe783RCur8mbN6R
         Uo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728626661; x=1729231461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxjfSmLfZygvqrMS13VPlH46Tg3+4LUKlezh/w4aBGo=;
        b=ehOufNn6A/W8D8aOtxCA+K3HaDAejB6OaM/1EIlVisOp44jDVslQ9utqOolatGj6+M
         MQZRV7Tp3jpi3CtmWnwpZkAlEP7vZb7sk83WZ92725D8qweC0iQ3ZIo9tB2CJQn4lLwA
         oDT3ihCMCw0F8wrTfhtrfiFDsQP4CH9S8wCwmASsCR1czr4BEVOgYphLWAXCQd7ZBUrc
         KjStuQKjT6Bni0yNr2zZIb0SGFGTVCXjoSHIV5+4BRTTkpTYPBE3BOT1KhCIKHTkgKdp
         PNXGYB10Mpkx01c4CsqQ3PTxXI96IVKCZfWw6P6JDAXx/InrtaNmXpFTqpRAKZoJSPOE
         55Xw==
X-Forwarded-Encrypted: i=1; AJvYcCW3knZJKEXcZGMxY6zJt6D79ucpAVlwC2d6EJAxQcELtVGPyufhVd1LtibqsVcC6PqyXvyFGz6E6Va+iXtMgUMW@vger.kernel.org
X-Gm-Message-State: AOJu0YyNuqyrOz7wjhtoUUGPfInWlag6m27iT+S4xU78QCvVhR+lcwMT
	RXhRBdX8HUtEv2O3meKEoP61AtMdzY7S5e3Bu2/qKXf1rFoliDD4TmLKb4bfxJDGvxUfAtOucDQ
	PJ08dBWfQO02/Z0cBtfJiD07zm8vgC6RVk9km
X-Google-Smtp-Source: AGHT+IFEEsqz7Bx4yLqpzYstl+Qz1urXLjggVcTI4BnOgCiGV6olPwNfQ3HUQpKtPtt0EaFv3bJuV19rq+XJDVzwGek=
X-Received: by 2002:a17:903:248:b0:20c:7409:bcda with SMTP id
 d9443c01a7336-20c9ee81b5emr1909855ad.14.1728626660412; Thu, 10 Oct 2024
 23:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011055700.4142694-1-howardchu95@gmail.com>
In-Reply-To: <20241011055700.4142694-1-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 10 Oct 2024 23:04:07 -0700
Message-ID: <CAP-5=fU7yGY41QJ717U+ehX6uUNviZkgr1UUTYshMTEHHKE9Xg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Delete unused Intel CQM test
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, matt@readmodwrite.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:57=E2=80=AFPM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> As Ian Rogers <irogers@google.com> pointed out, intel-cqm.c is neither
> used nor built. It was deleted in the following commit:
>
> commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifie=
r to files with no license")
>
> However, it resurfaced soon after in the following commit:
>
> commit 5c9295bfe6f5 ("perf tests: Remove Intel CQM perf test")

I think the two commits are swapped, but otherwise lgtm.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> It should be deleted once and for all.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/arch/x86/tests/intel-cqm.c | 128 --------------------------
>  1 file changed, 128 deletions(-)
>  delete mode 100644 tools/perf/arch/x86/tests/intel-cqm.c
>
> diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/=
tests/intel-cqm.c
> deleted file mode 100644
> index 360a082fc928..000000000000
> --- a/tools/perf/arch/x86/tests/intel-cqm.c
> +++ /dev/null
> @@ -1,128 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "tests/tests.h"
> -#include "cloexec.h"
> -#include "debug.h"
> -#include "evlist.h"
> -#include "evsel.h"
> -#include "arch-tests.h"
> -#include <internal/lib.h> // page_size
> -
> -#include <signal.h>
> -#include <sys/mman.h>
> -#include <sys/wait.h>
> -#include <errno.h>
> -#include <string.h>
> -
> -static pid_t spawn(void)
> -{
> -       pid_t pid;
> -
> -       pid =3D fork();
> -       if (pid)
> -               return pid;
> -
> -       while(1)
> -               sleep(5);
> -       return 0;
> -}
> -
> -/*
> - * Create an event group that contains both a sampled hardware
> - * (cpu-cycles) and software (intel_cqm/llc_occupancy/) event. We then
> - * wait for the hardware perf counter to overflow and generate a PMI,
> - * which triggers an event read for both of the events in the group.
> - *
> - * Since reading Intel CQM event counters requires sending SMP IPIs, the
> - * CQM pmu needs to handle the above situation gracefully, and return
> - * the last read counter value to avoid triggering a WARN_ON_ONCE() in
> - * smp_call_function_many() caused by sending IPIs from NMI context.
> - */
> -int test__intel_cqm_count_nmi_context(struct test_suite *test __maybe_un=
used, int subtest __maybe_unused)
> -{
> -       struct evlist *evlist =3D NULL;
> -       struct evsel *evsel =3D NULL;
> -       struct perf_event_attr pe;
> -       int i, fd[2], flag, ret;
> -       size_t mmap_len;
> -       void *event;
> -       pid_t pid;
> -       int err =3D TEST_FAIL;
> -
> -       flag =3D perf_event_open_cloexec_flag();
> -
> -       evlist =3D evlist__new();
> -       if (!evlist) {
> -               pr_debug("evlist__new failed\n");
> -               return TEST_FAIL;
> -       }
> -
> -       ret =3D parse_event(evlist, "intel_cqm/llc_occupancy/");
> -       if (ret) {
> -               pr_debug("parse_events failed, is \"intel_cqm/llc_occupan=
cy/\" available?\n");
> -               err =3D TEST_SKIP;
> -               goto out;
> -       }
> -
> -       evsel =3D evlist__first(evlist);
> -       if (!evsel) {
> -               pr_debug("evlist__first failed\n");
> -               goto out;
> -       }
> -
> -       memset(&pe, 0, sizeof(pe));
> -       pe.size =3D sizeof(pe);
> -
> -       pe.type =3D PERF_TYPE_HARDWARE;
> -       pe.config =3D PERF_COUNT_HW_CPU_CYCLES;
> -       pe.read_format =3D PERF_FORMAT_GROUP;
> -
> -       pe.sample_period =3D 128;
> -       pe.sample_type =3D PERF_SAMPLE_IP | PERF_SAMPLE_READ;
> -
> -       pid =3D spawn();
> -
> -       fd[0] =3D sys_perf_event_open(&pe, pid, -1, -1, flag);
> -       if (fd[0] < 0) {
> -               pr_debug("failed to open event\n");
> -               goto out;
> -       }
> -
> -       memset(&pe, 0, sizeof(pe));
> -       pe.size =3D sizeof(pe);
> -
> -       pe.type =3D evsel->attr.type;
> -       pe.config =3D evsel->attr.config;
> -
> -       fd[1] =3D sys_perf_event_open(&pe, pid, -1, fd[0], flag);
> -       if (fd[1] < 0) {
> -               pr_debug("failed to open event\n");
> -               goto out;
> -       }
> -
> -       /*
> -        * Pick a power-of-two number of pages + 1 for the meta-data
> -        * page (struct perf_event_mmap_page). See tools/perf/design.txt.
> -        */
> -       mmap_len =3D page_size * 65;
> -
> -       event =3D mmap(NULL, mmap_len, PROT_READ, MAP_SHARED, fd[0], 0);
> -       if (event =3D=3D (void *)(-1)) {
> -               pr_debug("failed to mmap %d\n", errno);
> -               goto out;
> -       }
> -
> -       sleep(1);
> -
> -       err =3D TEST_OK;
> -
> -       munmap(event, mmap_len);
> -
> -       for (i =3D 0; i < 2; i++)
> -               close(fd[i]);
> -
> -       kill(pid, SIGKILL);
> -       wait(NULL);
> -out:
> -       evlist__delete(evlist);
> -       return err;
> -}
> --
> 2.43.0
>
