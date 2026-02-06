Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE623C8AE
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770420801; cv=pass; b=FfhyZ78xg1+xpRN7t/MXFZXPW+kIxOPp2y5nX9uxEBxkD0zQEmjFp2Y/hVutFU46Hyxo7Jus0XQkZbHq+tFI8AmqtmFgV81PZ4CaKYv+y7reYF5EeZbf5ujz3YXGDOU7nFoMvOPhL1TnAYJNWpockybN5QiybUtpNOdz8jpxzl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770420801; c=relaxed/simple;
	bh=TmwO9WVBvAtBj3ggr8Gvf9xKu8nNomnwF33DRcluMyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqKGfp3pPNkFxA2xTTFWBQv1CEMuyhBdhkiRlkXoSeNRM3kFQxIYE5TotFItkDqwT7tsmrD9QtC+7MaYwSa6mhmAFov5yOjxUD3cFRbmdET1JNrZAdEbtAvDKROTOrDXlkxnYuliH0bAJhF9DXOKqusQ8OxY7Fx+3/myn5Il2Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gj0eF/Lk; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gj0eF/Lk"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-503347e8715so13863131cf.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 15:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770420800; cv=none;
        d=google.com; s=arc-20240605;
        b=KHgmPwIOZjO0kfClzsmHkiEfbkrmZRktea6ivFP8gmdj4PhYKfJUK6WYFy5C4J9ECl
         KcX0rQLPPL7VoVcacNGcxaeXIjAacTSE2ZXMwS8tWEm7yw1pJICf1alPUCZiWQwuDwn3
         /kKSJMdPo+uVTLEPsxn1yysS8iBv9ULx9bNdqebLwzoU+gfveo8fvXGlQujITBh7M5BN
         F2c92Cb8N9ibx3NmWN8cNNxp5ERi8fUqeYltxWfDOofVizjhMTlMOqAsX6KdbkZO+q3r
         nC/sKomzWk5O3t4FXs3XvsmzxJ5GoYYe5OtAOwWE2JdHvlHcCGpPmoiC2QF/KGHtvoA0
         waDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x9w0JL9mjtNICxg6XzWOOLYYnrjfLt9LULWdIrFxB1E=;
        fh=WcchYdCT0AFcWjtEafwahWdMK+JTnnt27m3uU5Hh4bs=;
        b=LVlN5eeHzinw14am+a11DIuRfxwTEvoL585jbAs4u4j/HJzNxOXQAn8flcjCshRABU
         QVhQ45UZB6554gbLWulVvueqbuQ8Infvrek0+Fz51/aOWRws9D9XFY7Kvu3JDNE5GvCv
         yrd4058AGWaynz9TmdXgXHPloztEY1b5D/VeKpuQ4NnzL1HEdfw6aH+BP3HxMgvOFOZQ
         GSnia/saUlEZ6uiR4pQFtJM+Z/j2h/l8kheWbHhfYBiXWTzk6BTs719KF7x6JuKPkoPA
         4yKvi+WfxshM/aqH6cjL+xF0G+lLIQ43Sgy3k8OCPigqy3CJquS1+26K78N4SZvKcO9X
         pveA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770420800; x=1771025600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9w0JL9mjtNICxg6XzWOOLYYnrjfLt9LULWdIrFxB1E=;
        b=Gj0eF/Lk1V6z5naB57Hz+H5iEZVGYCCy2KCqYSSGmtwjAwGqAiHBZChVZpSQCbWmR9
         7iyPAMpJTf55Nkq88Co/2e78JqjL03DM5Ol39KfHApNpeTJI+HaCVVNuBVfVgLPS+pd5
         Im52E/V1JJjVLo80BfgCDBvKrwQ7gY5FpxmJyEHXdeOyKIoAP9tJ/7BMZODKt54yzyxf
         3mrEANE6EnUVYooYbUCAMrhFtF1aHXCEFKqBYYwW7lNOp2iT2CDSkoEcSKt1w4IxRQYP
         gMayyBLxGjsVVekiOI4/863VwyNDhvK/+syI+KoJ78wxmtrZtSzzL5gBWjbGIJxNuTry
         8OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770420800; x=1771025600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9w0JL9mjtNICxg6XzWOOLYYnrjfLt9LULWdIrFxB1E=;
        b=lFZFs/uyudxyS0kJSfbLHh19b3OSXKi+SSBaA2R6GwLTmSmzKqZlxU6wtpPyselmaV
         ULhzFGBkYgyfk9HprB+RZEuxbakwSc19YIMD5JdxKc9IWeuYnzzfSMmJKhiAgtQaxyrD
         OCj05gOS7LbE7M6XqQGnDUBuIIuNbnxSCFVYdgDK5VjPZV9xpaJQ6OioE/NR7tCXwdnl
         pHSK8VKbIFKgSKAoL0VbgSR1dGGfp+m11LQabDIvrMWRKXPGeuWORCWwd2aLLMAlQEc+
         wXIG9dRe5a+/QxmwXE+TAw9X8uqIFpcGTmWctwUkz0FB/Bg5vFRrGMXAjT0c22EioRTL
         fmaA==
X-Forwarded-Encrypted: i=1; AJvYcCVA2V2Snie+RIGuid77wyUWwfYrGlqN/LbCLYT1ClZcEJ2/rsnSEaI7XS+t/pVYMS+qV4lpb1s0JEs9FHOt5Yim@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7afv4W8t4OaSWmcgk4o//95REP6pmhfgrkX6TP/rfojT+Y5F
	YN396IyYUA5XRcUMbY9tmPcImqhrBU/iYz4Ie/YG37nCvLGTemvgO/zbhvUFlMNJtCxDWA5Pl7F
	Z3kJOWO6Vc9/f4UkM/zH/zmq7FV1L4wRO/pG8COVv
X-Gm-Gg: AZuq6aIdX2eNj6t1j6C3Nn+wYxiBCkFU4IR2OsWme6gd1KuNoIZRLmSNYzstOFQ6+lM
	0dCbUpXGh4BmE1rbO2fpByQ3zvsKlGlVcDbTMUs4/Yt2PmgLlHvULy9CRzYYpwhGp3WS8p39YmT
	m12m+zcti72r3eXHHs0Aofgd+1BgEa3AsIyE3TnPPTwwTgCYe4fs9ecMvm/JoqpfJEK3SfR5447
	WWd9d172yMY1fB10BmpxMB0n//VoQrBy0z9IKvGSx79GJgqE66IHkCrtThPYH0R/44DtQ==
X-Received: by 2002:a05:622a:54:b0:4f4:d298:b47c with SMTP id
 d75a77b69052e-5063988b974mr59737361cf.28.1770420799567; Fri, 06 Feb 2026
 15:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206231203.11760-1-zide.chen@intel.com>
In-Reply-To: <20260206231203.11760-1-zide.chen@intel.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 6 Feb 2026 15:33:08 -0800
X-Gm-Features: AZwV_QgRtJN0JIh6IiE2jkVSxMT-5-8uO05RrsPeCGPbYwpfBVrc1NHVp8FAp_o
Message-ID: <CAJpZYjUwE1E=2+zTmSFJFViaM9oC+abby+86uVC0hbFaMwc-SQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: Remove extra double quote mark
To: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, Markus Elfring <Markus.Elfring@web.de>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Xudong Hao <xudong.hao@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 3:19=E2=80=AFPM Zide Chen <zide.chen@intel.com> wrot=
e:
>
> The third argument in INTEL_UNCORE_FR_EVENT_DESC() is subject to
> __stringify(), and the extra double quote marks can result in the
> expansion "3.814697266e-6" in the sysfs knobs, instead of
> 3.814697266e-6.
>
> This is incorrect, though it may still work for perf, e.g.
> perf stat -e uncore_iio_free_running_0/bw_in_port0/
>
> Fixes: d8987048f665 ("perf/x86/intel/uncore: Support IIO free-running cou=
nters on DMR")
> Reported-by: Chun-Tse Shao <ctshao@google.com>
> Closes: https://lore.kernel.org/all/20251231224233.113839-1-zide.chen@int=
el.com/
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Reviewed-by: Chun-Tse Shao <ctshao@google.com>

Thanks for the fix!

-CT

> ---
>  arch/x86/events/intel/uncore_snbep.c | 48 ++++++++++++++--------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index 7ca0429c4004..3b6b4bd4793a 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6909,34 +6909,34 @@ static struct freerunning_counters dmr_iio_freeru=
nning[] =3D {
>
>  static struct uncore_event_desc dmr_uncore_iio_freerunning_events[] =3D =
{
>         /*  ITC Free Running Data BW counter for inbound traffic */
> -       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port0, 0x10, "3.814697266e-6"=
),
> -       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port1, 0x11, "3.814697266e-6"=
),
> -       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port2, 0x12, "3.814697266e-6"=
),
> -       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port3, 0x13, "3.814697266e-6"=
),
> -       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port4, 0x14, "3.814697266e-6"=
),
> -       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port5, 0x15, "3.814697266e-6"=
),
> -       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port6, 0x16, "3.814697266e-6"=
),
> -       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port7, 0x17, "3.814697266e-6"=
),
> +       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port0, 0x10, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port1, 0x11, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port2, 0x12, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port3, 0x13, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port4, 0x14, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port5, 0x15, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port6, 0x16, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(inb_data_port7, 0x17, 3.814697266e-6),
>
>         /*  ITC Free Running BW IN counters */
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, "3.814697266e-6"),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, 3.814697266e-6),
>
>         /*  ITC Free Running BW OUT counters */
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x30, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x31, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x32, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x33, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port4, 0x34, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port5, 0x35, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port6, 0x36, "3.814697266e-6"),
> -       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port7, 0x37, "3.814697266e-6"),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x30, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x31, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x32, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x33, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port4, 0x34, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port5, 0x35, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port6, 0x36, 3.814697266e-6),
> +       INTEL_UNCORE_FR_EVENT_DESC(bw_out_port7, 0x37, 3.814697266e-6),
>
>         /* Free Running Clock Counter */
>         INTEL_UNCORE_EVENT_DESC(clockticks, "event=3D0xff,umask=3D0x40"),
> --
> 2.52.0
>
