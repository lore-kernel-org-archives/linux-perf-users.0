Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21AB44A40C
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504913; cv=pass; b=DBdn6d6J8oA5atKtVxIxjdmLroWmRR6RzuoercBnbA0+lNZkmZJME2i4Kfl27PQpR6w6unnqYT0iYIiv0e/1sg1qk3xjULTORdMDZXNHCZc5ztBf94awxygdwIVIm3/0bti1rBI4tgbafKTidTSPAHmHWli5QC70iSTSX37TxbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504913; c=relaxed/simple;
	bh=B9GyP8hNCeGmDtZ9u3NPVxdhHEoU6ZLawhHvneLNg0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg6KLku2NVkOeMKdshrpynhfSZlwR6wJT3PkIkI0ZzGBjnLGobAevifdX3QAMncFQsv0UcKnQNvNszscfnFhUB9bjsq65dugpGv650hnzWfHI4chtAn1jPULmaRoMohOnRte8znoFUDBO2j2y5SvPiZ6vZOdKmnS0HvmzMx61sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcD99Q9z; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcD99Q9z"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so18001cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789504910; cv=none;
        d=google.com; s=arc-20260327;
        b=Hy+3e0WuxV7K4oF/gdBnUUsR0wN3bFjS9Ke7XlauM+TDkjc87QPh8W72b3wc2AUhXQ
         4R01nuPbcpGwivWT+100KMUF+BnnCWtnK9oJqZEHav/3yF10rtJLAmjtjciJ+vNRh6XY
         cLhu6hEqwShhVOCHpC+fJv+GmRiz3hdULjhNANWvxlAP5NAGXtOhMEkSGb3UFa3TE6uH
         8E7kA6oafXSTVwOCBctWrqBHeHsGBD1nllrq1IypUtCVNlanKXPlbEdiexVpebQNOTFj
         +2xjnOBMiDjMAEe2M5WT4jZgn59TE5vZB0s16EvkKkvz/+yCAYmDI4K8Lgdjloo7Grxy
         Qp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ke+/Sy/w9JXzVliBlk15+zHdilgXXUHR1OHMAfai0gU=;
        fh=WSu3GNJjAv4usO7Bo6dA+S660cZr83w+C8ywBYJ3aMM=;
        b=a4Y6WMeoIXk42MIv8Wo3GHbYZCaPawQ4xLLOMQvZyYS2YBPcNxJ2t9GEPBc5YU6Iy+
         s3z7MULiFf80cwPLqyfys9nMPHB/JAIxyeHx9YG8lgLu+Qr59DE255tIonGIk4TEZIjJ
         7SfGny1qtZsQezvDlL7Ly0WSbVz0sfawBcN0S77LiHbjfLEC2D9PDt6xvkQavZOHFPCm
         FKCzmT4YiEWSe3MGe3hdPZ44v8cL6/O1s2xatXuB6erAoTYK9v9tNfcDegXXGQzh3Gyx
         pzqCmBfzIy3mp2uKNdKACY0mcSzKw9zcQ0w6v2H/rlfOZklc3lKW+4JQwlt0W5V33pqW
         NnCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789504910; x=1790109710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ke+/Sy/w9JXzVliBlk15+zHdilgXXUHR1OHMAfai0gU=;
        b=IcD99Q9zLtCFHuCdf81CzJRazTiJIWLsqH6ky7Ape20F+8l04woIpdDy/QtkQoR2n7
         FLsZ3wkxRTfGQ+Mf+d/1aCSXLoH2T7IjQ/WrNob8nBkf8Mqg62oNZB2CdyUwyAZ+kloK
         eQrDLEp+wI96Jd9WVUvnMnwR7gU5F8dwb1kv4P2GdH9vCemKA5TS9thG9wBzTbIoOCGM
         U28k1tUAMide0a0AnVSTVpq+RLnRALwdLm0fs2tLERuVnlBdYd7V2MornKV+s5Da6QH0
         y8y2Zo/ujJNhN4VyUp4NzChkjRzVGFCvdc/MYPrtrnK5ZlBG7/t77Jd0l9LqhHQLa1ox
         Uszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789504910; x=1790109710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke+/Sy/w9JXzVliBlk15+zHdilgXXUHR1OHMAfai0gU=;
        b=xGq/+qTg5b1k3KG5VTPFdhKKVjHAWlrwoonkJEe/GOa2bFARpcAh9+AhhQCfh75T+9
         xSN3Lv0m7MGFOoMsb16EWBkrmUB0t9iXKGUfb4FNyzsq/aeQCi7xNfFD81rMLY+qYgGv
         XR5GfrAv+P7Ygbc0I+5v3ISgv7L5W3mBYNpMtlp/njlokzYZ9jGN7zmVUpNJC06S1/s7
         0S/Gt84KvIt9fmEZTVTvkrvpy/eaf/B5kEAGjgryKsMhJ4UFfKXN7zaWctpUMKJJY324
         EzN+1OH1VwuYQcN+wHVnp7f7xhBSGbk1WaY+Og059sY5rPrK6JuTgyh3SB9WNuMjL+Nm
         jJVQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9abP1rKt3DJ/zRPvlTpVGEcEd65FYvkkkP7h37i0hIs2wONGdCgKyM0zXJmEOIYE9fhopzNM/o02GMq1/hZzG@vger.kernel.org
X-Gm-Message-State: AFuF++mfsXS8O/YoeLo4rEbhHwNt74W9LQtFlhEZD+V10w47wWzIQH9F
	xY24D/hKC8p8tmyUHnpO+ThU+pxFqjY8GlTXkInX+6ArmQJnA3dEH35Z84e+2u5K1Gw+ojz3SDt
	aYUqP4Pl/H4gZi/cV08Km8YlOXHSRdMFw7bp3jGfj
X-Gm-Gg: AYBFou2Y8jj1XS8HJF7AMXlqzq+vK+ao1sdRieEhmNkwnCpFmpOqZbsN5NZOnhzPmoF
	VpMc0Wa4VwdgtKHmhTLBtqyqB1Hqo21SWW7v6gucoa7mVUwZ4bcwBq7SD0wzoH/XfESvraQ0qYI
	sSSPtnR9QkMfgVbmIHyNrp1OnCVUFMOSbcPLj2WDchEngnGKwmSkSJ2LbpK1KwOoRF3qSqxm0Mf
	D8azAs65uV3Vwvo2LTyiMSM9lLgp9KPRPxdej/Ly+rJEwgkx0HuhFBYb0J+LlEVppg0yqbe2kKV
	yLFtZsg+ywPjPBC7S/kOQgu8rRfrrz9A8u588x8P1AsLDDZIPK1FMaYTwNd9wr38OP6niJfC1fc
	tPbjlA/lmI6A=
X-Received: by 2002:a05:622a:1f05:b0:531:219c:2de9 with SMTP id
 d75a77b69052e-5327e8ed0a4mr578601cf.6.1789504910127; Tue, 15 Sep 2026
 13:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528005136.1906479-1-junxiao.chang@intel.com> <20260528005136.1906479-2-junxiao.chang@intel.com>
In-Reply-To: <20260528005136.1906479-2-junxiao.chang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 13:41:38 -0700
X-Gm-Features: AcwNN1V3pj34wz3FgFuSX1fJjZOqnVT3G0ZwIhWIvUswQ3fN0RhMUtusr0l9OUs
Message-ID: <CAP-5=fUsX9S52mrVOZPAhSEMP5GQsJuv_MU9L6d8Bvff_KYJyQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf/core: allow trace events to be accessed from any CPU
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 5:57=E2=80=AFPM Junxiao Chang <junxiao.chang@intel.=
com> wrote:
>
> Using perf to collect trace event statistics may introduce unnecessary
> SMP IPI interrupts. For example:
>
>   perf stat -e i915:i915_context_create -I 1000
>
> In perf_event_read(), an SMP IPI is triggered when the event CPU
> differs from the local CPU.
>
> Allow trace events to be accessed from any CPU so the event CPU can
> be set to the local CPU, eliminating the extra IPI overhead.
>
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>

Hi Junxiao,

Reducing IPIs is great, but the Sashiko review pointed at a bunch of
issues that seemed like unintended consequences from the change. What
is your plan to address those issues?

Thanks,
Ian

> ---
>  kernel/events/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index acdb1f02924da..b3a817c0eb3a2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11376,6 +11376,7 @@ static struct pmu perf_tracepoint =3D {
>         .start          =3D perf_swevent_start,
>         .stop           =3D perf_swevent_stop,
>         .read           =3D perf_swevent_read,
> +       .scope          =3D PERF_PMU_SCOPE_SYS_WIDE,
>  };
>
>  static int perf_tp_filter_match(struct perf_event *event,
> --
> 2.43.0
>
