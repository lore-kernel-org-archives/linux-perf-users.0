Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728B402420
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513942; cv=pass; b=YkHXRYEeLPXA99GjQhfyDIqPVIDDDQWdK/fZ2hNgMOhB+Hkb8hqsnI1YkCC4FqG6bifyjTlO2B2YM8NVbuLweD1y65ZuCCoSgG/L6b6V/6md+2X4g4GFchEWJxNMNBeAMyIizy+4H5wW5uFnZvoqqpgc3Wt+FLTa/n8ltKLy7gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513942; c=relaxed/simple;
	bh=9tqko9bM/nHJoqyVkMmggmUVo5O/TCm+zFmZRgTCLFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfSFJLOe+C3kzvE+V+sCZi0vWAxG4LGjjPytHqdgtlC/sEYywHgxU7rTknbrj5XcgzuIzYgQo5Cnr7fQEi930MAoQ8Xpg8XAyw1e0sGL2gXG8njSd7n5L2rWDoReWcZjkWNpN5bsJGR7I2yE6t5t2PVwQ4lGdr7S9eudQKUh8ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1EdFT4O; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1EdFT4O"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so155ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 08:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778513941; cv=none;
        d=google.com; s=arc-20240605;
        b=fPCgzQKsipR2St6y6coofFqMvugMQ8eRacaL5t9tJBmapEaNdcaMyZdMcobHByIRvv
         v612UFMll70rjDS9MosdBTZocFsODzMxe4GuJxovLSKuhZd42IU+nEbk79OuR48SDUNu
         6n1R860kySsTezuE9w7/bydbQoRW5XdXn6ntQ/XbKJD67GOODk4LVXS9eBbJz5ZmgV8f
         6XcWSLtBOjTGWzDL3bf5BRHTiuVGAijYY6wPIMK7GAxKY+H6f3Ljvk/kibYcoJ0ThiKL
         80KVQLucsj6mvVpA5cmqdPamNTwbVgrvCU+HrdSDQmSgaUAIlkN7SaYhzKnZkkabmZDs
         QHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Moo/YvRc6i4ZD8uwWazlqLDaIfZl0fW/FJpHXzGlVLo=;
        fh=eFwsLuSDpo6g8HRJUFHnUDKhNPZQet+jFAq/jkRdmMQ=;
        b=RT/UKcYryHf6XQCIMwnJDq1vqHxmEfaLetZ/At+sYs62rtHF4Rop4RGCyGiYvZRFEA
         Qi+30q2AF6d9OobsfLr/Typ3bseQql+Zps4fAPcrDSA0ktAeMC1b4qY8ou5F8kUSDRw9
         /dN1Y5S7IgLUxrNa2R89CpWTFZoydj1Ob14zr0o+eimh7+ywQw0+VgZObvj64wj+5bbq
         BdY2B2DsqkobyDVM0tzi2kluT9li4H3KbMugeSE8/eJBGMITxBdY3qpMH+CCGBV97Jcj
         1YIU3+c3409Y0YmuqXniiPvIOTDLdslI1eZYZ13JpJH6v8CRGo10HGVNiGxZVl/5j4+n
         sglw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778513941; x=1779118741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Moo/YvRc6i4ZD8uwWazlqLDaIfZl0fW/FJpHXzGlVLo=;
        b=W1EdFT4OsZPbpI0cCPLNnEy+NkNbI64IGL3zIf3bi1Xil06oizcwDVIS/eu4NQOSfu
         9c13U1WpQqe+FCAHLcypdDIr0d1rJH8ciuJGnYZ7YdcUMGNn+zlSKUvXwm2gjzghVLFr
         Le9cGfc0gOHvkL0jXm8DOBxOh1OPTfaKNAOK/MtQ8xL8S3qzPbo66ysYdry+Sq316TgZ
         RuxI16MImWPPYWoewx1FpwLops+aLvUhM0dt71pSMmKxAmifEVTc0VwmBYC7hq5Ju7Oh
         n7DAA8A10DKR3sGjuUQWCXeodqSsMjtgpwDgDhvpd+nEFHvfjgRs5UyZakR+SqLQv8tO
         9FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513941; x=1779118741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Moo/YvRc6i4ZD8uwWazlqLDaIfZl0fW/FJpHXzGlVLo=;
        b=rrToxw9/w0MT+H0oRtgpNQarYMteGUrQtsDZVKaKKt6fZ0KtTUEnLlTxR7qDwbJS7X
         CeOmndYFmXDadEM4Io56HZqgU8lmNFXF7VSSdmR7oKUzQup13M0FM+2NPvWkQd6J8fip
         f4B4csqPalqklYfGw+7FiYiEBlb4sBI5J1B9+4oBQOqMieSNq3zYkD4CyBzkw2QqxV67
         mSloHnhZCP4NcZJ9EeRpj5mJxKAWB5dF+pQDtfieQXz6B+WvB4Zh+0CYtvjRq3rhm7bT
         1t47vAXcZK2IC3mOC4SeQqrXx2XH19CV4ihYQDgaySTuEDJUTktqCu4K4NETqLfvc1F8
         GMuw==
X-Forwarded-Encrypted: i=1; AFNElJ8Wqniste7dzIE3rASaWD0Hj/GEh3HIigoZ8K5bY+pqPNtvhXRXUAs1sIknBceJbYtIa3Hq8n5XWfHESAcLXI8B@vger.kernel.org
X-Gm-Message-State: AOJu0YyndIPdgXrJYkTvfJxsXd3JdQir+nNHFcUe5zMJLWld63XXM1QN
	Od4dFgJWjEKp8ivD8pzRLMBP472M0capfNABNI6fImp9sFak6VPFGeOEfWx1AxAtbuW/rxCmMuU
	cOcrh+MqeiAqYdwc5/RxZqY10xTZfI5ZKmPJ+EQEk
X-Gm-Gg: Acq92OF9+wlWIppua2O4s/UPs0BvvHecr9rMj734AKtmBwzF5vgQ+0UnG2RzgXGp246
	zRldJCheB3CcBgNB/eUKIU2vuLDbSw6hhA/o4kZT/+QbQCcPRMO5b8O4+JnYgqAIZRKhOArWtMz
	zR78KyXHGW3iWRlGsoCUMA0xpj2nujj+Q3DljvbJzgvDl+4e2T0yYVwLPTLCwORl7qSxR3I5GBx
	OE0k1qtgZhUKSL1DYhYS6Sm+wDAOXiwBWXtdUheRKj9RbL9ySWEi0zKRdNR68l5y0GJ6n9gjO7/
	8mn84Ixuu7isA0BMylZ+eu+7CJM3UH3AdfoT/2TW99RF8JUl
X-Received: by 2002:a17:903:1b03:b0:2b0:5193:1212 with SMTP id
 d9443c01a7336-2bc74753aafmr5356475ad.4.1778513940395; Mon, 11 May 2026
 08:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-james-perf-leafloop-stack-v2-1-79f7383f545e@linaro.org>
In-Reply-To: <20260511-james-perf-leafloop-stack-v2-1-79f7383f545e@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 May 2026 08:38:48 -0700
X-Gm-Features: AVHnY4KlauhW519SPkULdL0eS1H_jzH2JWlp6dvxWLhFC1_wEckP9ZIf56hOlUY
Message-ID: <CAP-5=fXtzHw2c_Er0WPpfFo1cfng46VXKvShb+kbdnSoxL1rmw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Make leafloop workload immune to compiler options
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 2:19=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Since the leafloop test program was moved into the main Perf binary as a
> workload, it inherited the same compiler options as Perf. In this case
> the -fstack-protector option broke the assumption that simple leaf
> frames don't have a stack frame on Arm. This causes
> test_arm_callgraph_fp.sh to pass even if the stack isn't augmented with
> the link register, making the test useless.
>
> Fix it by rewriting the leaf function in assembly seeing as it's so
> simple. Adding -fno-stack-protector would also work, but wouldn't be
> robust against other future compiler option additions.
>
> The local variables and 'a' variable were never needed so remove them to
> simplify.
>
> Assisted-by: GitHub-Copilot:GPT-5.5
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> Changes in v2:
> - Push and pop asm sections - (Sashiko)
> - Add .size directive - (Sashiko)
> - Add asm label for done and test with LTO enabled - (Sashiko)
> - Link to v1: https://lore.kernel.org/r/20260508-james-perf-leafloop-stac=
k-v1-1-637c260b2da8@linaro.org
> ---
>  tools/perf/tests/workloads/leafloop.c | 40 +++++++++++++++++++++++++++--=
------
>  1 file changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/wor=
kloads/leafloop.c
> index f7561767e32c..c20c75f7ba49 100644
> --- a/tools/perf/tests/workloads/leafloop.c
> +++ b/tools/perf/tests/workloads/leafloop.c
> @@ -6,26 +6,48 @@
>  #include "../tests.h"
>
>  /* We want to check these symbols in perf script */
> -noinline void leaf(volatile int b);
> -noinline void parent(volatile int b);
> +noinline void leaf(void);
> +noinline void parent(void);
>
> -static volatile int a;
> -static volatile sig_atomic_t done;
> +static volatile sig_atomic_t done asm("leafloop_done");
>
>  static void sighandler(int sig __maybe_unused)
>  {
>         done =3D 1;
>  }
>
> -noinline void leaf(volatile int b)
> +#if defined(__aarch64__)
> +/*
> + * Write leaf() in assembly so it stays as a minimal leaf function with =
no
> + * stack frame and won't get silently broken in the future by any Perf w=
ide
> + * compilation options like -fstack-protector-all.
> + */
> +asm(
> +       ".pushsection .text,\"ax\",%progbits\n"
> +       ".global leaf\n"
> +       ".type leaf, %function\n"
> +       "leaf:\n"
> +       "       adrp    x1, leafloop_done\n"
> +       "       ldr     w2, [x1, #:lo12:leafloop_done]\n"
> +       "       cbz     w2, leaf\n"
> +       "       ret\n"
> +       ".size leaf, .-leaf\n"
> +       ".popsection\n"
> +);

On reading this I thought, why can't we just use an asm block in a
function, but I get it, you want specific function entry/exit to test
the leaf unwinding feature.

Reviewed-by: Ian Rogers <irogers@google.com>

Fwiw, looking at the test the command line is somewhat unusual:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/test_arm_callgraph_fp.sh?h=3Dperf-tools-next#=
n32
```
perf record -o "$PERF_DATA" --call-graph fp -e cycles//u
--user-callchains -- $TEST_PROGRAM
```
cycles//u rather than cycles:u and why the extra --user-callchains?

Thanks,
Ian

> +
> +#else
> +
> +noinline void leaf(void)
>  {
>         while (!done)
> -               a +=3D b;
> +               ;
>  }
>
> -noinline void parent(volatile int b)
> +#endif
> +
> +noinline void parent(void)
>  {
> -       leaf(b);
> +       leaf();
>  }
>
>  static int leafloop(int argc, const char **argv)
> @@ -39,7 +61,7 @@ static int leafloop(int argc, const char **argv)
>         signal(SIGALRM, sighandler);
>         alarm(sec);
>
> -       parent(sec);
> +       parent();
>         return 0;
>  }
>
>
> ---
> base-commit: 8c8f2093614373ea8179b562320212a25cf937c0
> change-id: 20260508-james-perf-leafloop-stack-c221600eddf2
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
