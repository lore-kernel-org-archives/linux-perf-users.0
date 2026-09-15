Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE974AE12C
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509251; cv=pass; b=UejslNcymSk6KtHYypeyK4zMYFb26Y1UuU4ENmzFdnL8SML/thRS1QRRqzH+xrEG8hjPrv8tNNWO9xTaj7l6zuEFBW0nymk1RevuJhP9JRpUN3Sfq4iqcydfImz+CLg3XGmg1tfAGVZANmXggUgxQgpimW4vEFiJAPTx4DZtfdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509251; c=relaxed/simple;
	bh=0TQp8EfFx3Osrinb3pjUeqnZA4DJhjlAI5o7JdUlPZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfDlQXBAgtpUeFqsqYS1N0yJY978Nx7vu/UseQv6kKijCZcewaLxQ/k9d5q8zjAMM7pIbFBQz6XDWAghFUSAMXo/Pkhblb1gaBgR4OhSmt1EE5g0E/PQeNM9hfiWVRZgU4YH/esXAGgI35adZk22oOdEDpWUC3QDBYqm2bmGc1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hL0imPoS; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hL0imPoS"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so38171cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 14:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789509249; cv=none;
        d=google.com; s=arc-20260327;
        b=Z01YzGWVvX0/sAqxECKhotsQPYyYOrHeCIJMhUH92hn0B44aKxVFI+bnrpssKuQAM7
         apsxBVvRgL019VF3q1BOF/Ot2Py70JE0Es9JcYTYlq2b/V+VWlkEn/wX08Fz2i0Not1W
         18+wOKHwYal0CfwkEAoly0kJ13XWID/BWaBqv+2+81hH+KlrCtku4EkCfYvNwZERn/EG
         Rxuwom28cpK4kmN/sR06WerTiny+euIh/9mVkC+gyusvE2UPpFFC3S1fr4cyRZXgauMq
         kQXG2eUMKU3hqU7EDj8RozxZjU2W9m7dEGYxCW330lwZNDA+gycsUlNbqNhcm954z1aF
         M+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OMiuKQhfBcKvkFwTEw/tDiEQn5IJqyQSscIYNwp1mJI=;
        fh=toEQBgUQZhYfncSQMtRKj5EH+vuonTbPPrdk7mH26e4=;
        b=GvW5xULKDtxrfAsNJmcULcusjFcV4Udky//g+bTEYwV0eNPhjEA0xzR6zI/7XtoJFn
         l3bBaE7CvYXO+v/LBKUl0l7LXGl82bBDMhOwhv1Eem0LVA3y4pDwZoAQKY/1ZGYK61xh
         I8IVTZD9FXcwd50HYUZjakaq3W6rFNzdzuTAndEqmtRm2IsRxZfZKF0xZnNQx2v7xTj6
         wfCuDwWg/Lvvsy+Tn1e5m493CCuhPXRVrzH1WXNSYRGDtZgNm9fBPyN10LMLJYv7eGzD
         qjOLESU4Cn6DnjWoPqIz8rw3EBuzoWamPF2cCYovqg2FLtvYBh41lrRn7k+6SKFSLVfL
         UT9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789509249; x=1790114049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OMiuKQhfBcKvkFwTEw/tDiEQn5IJqyQSscIYNwp1mJI=;
        b=hL0imPoS7u9/feJj4BKaW4jx1vZpbN87VMZ8AO0yL1TfGva9tUjUdQYvLy0JaCuzQi
         03Kox3yEwnyH0i2RKWYR0Qfd6+Q11MsiDZ8GZx1/MuO6lfSJfh+VDgtU+MpxDaXEAEAU
         DXWjVGLnFENZEHU2sx0ezp6P1QR3ec4epYzhgyNgGa0u/z6Y6zI+hLZ9ycbCcONcHOpD
         gzo0Dn9/n6eL1EYXDj42hYUud7wPbec0HzU7L/SSH39WvagUOj+0svakGE6iBNOi9/aT
         jR1F3Z/Te/QJa2zbgn78EAT+jngAw16ovZX5n6rK5mHnMCHsW6+TjlIL1pOECoPd3nCR
         viwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789509249; x=1790114049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMiuKQhfBcKvkFwTEw/tDiEQn5IJqyQSscIYNwp1mJI=;
        b=LE3pfleYns2D1r/qHCwRUDREwShbsZWOZV0EUMqIfVBhHk5OydZ8GL3NgdfM1J5+cD
         iI3CzGjgkDE8B9sIVs4JxZGjtX5Pdm7iJmPhrHquz3V600cdvN0dMCTdjqOHh5OfLyN+
         nokp2vik/0Q4QGXTGFcDcbWTK8F5BAM6PKccByRfSzyIR4nfn09oLKaIyhBA3pTazYON
         yZl584bPd2m5+hymIhgJwP583yRkTda9N8EgcaqRb6awhvPIdcyf+ZOnYC9W062q/FcZ
         RlxDJ29HvG0OzltmXWcqi0TX9kR+eyA44jfkzvvsai89Wi40/gBmhtsFpe9WxhF4ocuU
         tf0A==
X-Forwarded-Encrypted: i=1; AKwUvBzrs4CiNupjYLbdK3Vkq3O3z4m+Qlf7Jj0jwLzFQzEC0xheLIQEJhmLllL1WX2Lo0QWrmpny2T1u1X/IXwCeIET@vger.kernel.org
X-Gm-Message-State: AFuF++lR0ig0xVKGzI5O101+L8Iocd3sDWDfEpIK6Ukdu/49mAcCArlI
	7AdiQ5i6yeFuMfMJzLk53bwesuzssr/2pNysqlea11bQMFPJrussWfTDp2HMf8GpEE4DD7YO+SV
	E3600+eiDPMtM7UbgqoI3HptcCJ8V01arZHHgB/qa
X-Gm-Gg: AYBFou2dAVlmt+5RaIdEwtRNLQnJk+JJuoPbiTBes/nGlVm7kuz7dGOrEwnaGwtYm+n
	kyHaGBrlGJ070NUcEmQtPXD0W5KnXrI8RFzilFSMk0sKnXFkWwITa3ft+a/SQPXr/R3KAM817Wl
	q00/SBcedXYlp8g7XywgSUne2zkpXchOdXCxutF1Zkhb30niYajSkEUx/PValpSUwij0RepR9Rq
	dDKYoYjk5kw1eEUanTHbUFmKfqtuUAykFqQR1bfTEdablE0/MMTFoajQQDDBVRERxOftlgx89kV
	43UQuTRoGnkDvdOSApqe2qK5AqcAJvFUvouFhbYXmwyZLzaYf0P4nsOeFV7pNM13KTrOcVSfmUc
	nHwv5mQ/3EQ==
X-Received: by 2002:a05:622a:4d8c:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-5327ed8004emr1261141cf.4.1789509243807; Tue, 15 Sep 2026
 14:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131122011.492961-2-thorsten.blum@linux.dev>
In-Reply-To: <20260131122011.492961-2-thorsten.blum@linux.dev>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 14:53:51 -0700
X-Gm-Features: AcwNN1UD4Ko0WaR7iNBPqrcMZnYEXf8XodDGvSRhaJ_vRQwim3aRznf3-BfcM1w
Message-ID: <CAP-5=fXA6d=T=+JfNRHWAPaRjNWzrNLNChwYmNzrbu5rxKJe7Q@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Replace snprintf with strscpy in intel_pmu_init
To: Thorsten Blum <thorsten.blum@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 4:21=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace snprintf("%s", ...) with the faster and more direct strscpy().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index bdf3f0d0fe21..025971ab6341 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -12,6 +12,7 @@
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/export.h>
>  #include <linux/nmi.h>
>  #include <linux/kvm_host.h>
> @@ -8077,7 +8078,7 @@ __init int intel_pmu_init(void)
>                 }
>         }
>
> -       snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
> +       strscpy(pmu_name_str, name);
>
>         if (!is_hybrid()) {
>                 group_events_td.attrs  =3D td_attr;
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>
