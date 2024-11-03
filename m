Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5812B169
	for <linux-perf-users@vger.kernel.org>; Sun,  3 Nov 2024 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730609898; cv=none; b=F+Lbqo43wU8WzewDClt2YtwVMqteYB/olsgFPiFJ9nNtaKLrmgcByiUhcedeGG50yJRVMoh/WL8gx3R1Mt5EyD8utOvgPZaFals4IxGNLfFD9ImkFGs+WdG7G0xkGpfmWRePVHdfWRflY+5dkWnhdo0eNc4oynIF2E9bVDYsZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730609898; c=relaxed/simple;
	bh=ta6LCb+pGPvyovLjg2gwE9t03Ee1bGhUCGaZkqkBiHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItYz+NCuvG1VU77w1S4zxBKqGDhR61kXwW0+UHgOHNdyCmkAgahN1hjFrdJfClp9u/XOdEgmSyeNuJuAHF2VIKUENy+McVLjKWuo3hjESpMkRKy2fqcvKsnTRhk0cXnqaRgZc/6oqtEj9zcSOMNbeJj2JeLFNCE/wJHrW3pkqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=APFs1OYX; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APFs1OYX"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so318395ab.1
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2024 21:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730609896; x=1731214696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpFV6oTBOIeC5yBjNOo7+wEyxsQ/3aWriFwbBM+vIgQ=;
        b=APFs1OYXPbLDoPoB4HJDQBoFOgjW8Q/j5kH7SWKwNeX/SDjCIaj3ponbkkg8bpB0ev
         VrlqVNEgl2OVuZePv3+TQ9DLLKAnTnQygVXmjma3TG6d7HubK2kPEV0byonmfeedfqQm
         O9lX+1QsOz7kOnpT3k1JUBqxhAed5+igcTipmv46S/YRksi9lbVQdIjE+erxnUo5dE50
         +QmSl5wgVWmiTYgFnM7RkyhEq1LOI0aK3whv4xNgboDQILR5Oe/44hi/EKOcbggbAs9T
         mFEWbToS4A0K+xi4g/rr4gfZjbC02ce/kDyjRW0vN5V1jUfSp/WG2Mc063JL7IdR6TEe
         VYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730609896; x=1731214696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpFV6oTBOIeC5yBjNOo7+wEyxsQ/3aWriFwbBM+vIgQ=;
        b=g8W47WWQcms8t19SCmXtvDXXhhRQ+jqFAGfP+BfyHCFaQh+KmLoFwxC+K2h/2EPWXg
         f4PP5EmdbgcvhaIlOqDEMMJFO44ehQcQMroSTofRTtv4T0Go9GmECoYkCqynEpeHRvJk
         G2Ea6Y+iSNIMM+DgcxEdCPcRk/gJv631/myfUAcMKH9QvtnkQ1MHSpDdvuNb3nv+f6TP
         V2Pi3KrQse8U8pEW8pwOf1IsFQlNmwi0e0nF8tCEtPBepkxUXpGL7JpYvCjhOY2A8Kge
         nvY8Zsu0F2V7CQoj6jBs0wwwHU5PrbrWQJHpTpB1Nk4rRr0zqHLeZ5b0MORbIqY2skab
         Qcmw==
X-Forwarded-Encrypted: i=1; AJvYcCV8nCjw1WXY+vCV5r8p62fswPtS8vnJWGLSuuz5BnSVW0PCEfErp7JSLEzAWytFRbBXOtz7Y+M6ebKd0odIXMoQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+LvNCZhTSioMHnPY1dVK5A/Me3caBa77YfKFLz9lPonyGkckr
	+1vWhA5ZFIWLuD9A3LTZUmMkHcPxpeZrlU32zUN43vWTjMnDoNeZ3UotU7awRntntQ+EWZwKp23
	yxKdsD2NZt9ata5YUVY1qqwY7+hWJI3GYeIKdHWKkfTZXZu6ogJ/B
X-Gm-Gg: ASbGncto/l1Gos6RQEK6RXcsGlhVo6tECbCcV2+O/0Jau65+zV/tCMRWv9mas3MfpR5
	tS1oB9FQYJuixf3oC22JSZpzvKBcdzRMB
X-Google-Smtp-Source: AGHT+IGeRCqFZleClxbNKFrokdLdvP+mMQGcCgnwveM6cP572Su4M9dP4nZOdIjURl7uAdSZbXf1B13EFzzKmYaotfY=
X-Received: by 2002:a05:6e02:3dc2:b0:39d:1b64:3551 with SMTP id
 e9e14a558f8ab-3a6bf2246c3mr2561185ab.19.1730609895626; Sat, 02 Nov 2024
 21:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103002414.2281869-1-namhyung@kernel.org>
In-Reply-To: <20241103002414.2281869-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 2 Nov 2024 21:58:03 -0700
Message-ID: <CAP-5=fUg-DFKM4SQa7P2fWRd62y7kDiP+qP2kP-TiZMy2EX7mQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix LBR test by adding indirect calls
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 5:24=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> I've noticed sometimes perf record LBR tests failed on indirect call
> test because it has empty branch stacks more than expected.
>
> The test workload (thloop) spawns a thread and calls a loop function for
> 1 second both from the main thread and the new thread.  However neither
> of them has indirect calls in the body so it ended up with empty branch
> stacks.
>
>   LBR any indirect call test
>   [ perf record: Woken up 21 times to write data ]
>   [ perf record: Captured and wrote 5.607 MB /tmp/__perf_test.perf.data.p=
ujKd (7924 samples) ]
>   LBR any indirect call test: 7924 samples
>   LBR any indirect call test [Failed empty br stack ratio exceed 2%: 3%]
>
> Refactor the test workload to call the test_loop() both directly and
> indirectly.  Now expectation of indirect call is 50% but let's add some
> margin for startup and finish routines.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/record_lbr.sh | 2 +-
>  tools/perf/tests/workloads/thloop.c  | 9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shel=
l/record_lbr.sh
> index 8d750ee631f877fd..7a23b2095be8acba 100755
> --- a/tools/perf/tests/shell/record_lbr.sh
> +++ b/tools/perf/tests/shell/record_lbr.sh
> @@ -121,7 +121,7 @@ lbr_test "-j any_ret" "any ret" 2
>  lbr_test "-j ind_call" "any indirect call" 2
>  lbr_test "-j ind_jmp" "any indirect jump" 100
>  lbr_test "-j call" "direct calls" 2
> -lbr_test "-j ind_call,u" "any indirect user call" 100
> +lbr_test "-j ind_call,u" "any indirect user call" 52
>  lbr_test "-a -b" "system wide any branch" 2
>  lbr_test "-a -j any_call" "system wide any call" 2
>
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workl=
oads/thloop.c
> index 457b29f91c3ee277..fa5547939882cf6c 100644
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -18,14 +18,16 @@ static void sighandler(int sig __maybe_unused)
>
>  noinline void test_loop(void)
>  {
> -       while (!done);
> +       for (volatile int i =3D 0; i < 10000; i++)

I don't think the volatile here will stop a sufficiently eager
optimizing compiler. I think it may need to be static as well.

Thanks,
Ian

> +               continue;
>  }
>
>  static void *thfunc(void *arg)
>  {
>         void (*loop_fn)(void) =3D arg;
>
> -       loop_fn();
> +       while (!done)
> +               loop_fn();
>         return NULL;
>  }
>
> @@ -42,7 +44,8 @@ static int thloop(int argc, const char **argv)
>         alarm(sec);
>
>         pthread_create(&th, NULL, thfunc, test_loop);
> -       test_loop();
> +       while (!done)
> +               test_loop();
>         pthread_join(th, NULL);
>
>         return 0;
> --
> 2.47.0.163.g1226f6d8fa-goog
>
