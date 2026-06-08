Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E93A1695
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954814; cv=pass; b=q2PR6xAyMbQotKm0ihhqpQx71g89RyAjQ0OLx/LjuS0K0kp9RHHoQXfIC7xlSN1cokdUWgo2zP8pUmmplDV7ujtIIJMqeedtN8T8d5kgcdKemW735zSqw7OK9StSVZUqsv4ob33ofVJVx/EyaUeTFQ/aQpvKBpgrNMVlarGM5gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954814; c=relaxed/simple;
	bh=SJrcXI8NUct8Cdqe24SDV48oCMX7iK1KPn1dOq6KNz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGLK4X5BfkErPyAVqGgCrqmNZFApzkPmozjs0sAieOLPPxdzyEu7zLffjMgSfOKXDAVtBARKD4o5hk0+jNivVFM749inj+Lvexdt/FhstzepJFw2/J5+m1L40Ebl2mpsau6gg2CoRj3OTMH6gEdPNxgUhAyDpfbHbG4Fxf1+DLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=anA6PWCw; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="anA6PWCw"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0b1a48855so442135ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 14:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780954813; cv=none;
        d=google.com; s=arc-20240605;
        b=Ao4IUDcmB/DRT7Tfh8AYD9jEwZjiRDjuf+m9ij0DEBSIZmiiBoz79PalagQpW6P2LO
         Qr82CqJl+pC3uaf0F9gq9MhYtJZeN41jKHQ3dXPEqjDURMDGqg5NIGa9HKe6J8AgF9tC
         27H8PNISxKH3FKCKMRVcqgYhIn6g36O5H8nWvrLhp8L1hq3KE2CrsqHROazUtLEzrbh9
         8knMZoqw1EItO/qHddhrFPfXGBo5/u6d7zDp6MLCSmX9uo+1I9xZQcGQltgURRhQh4vI
         CuFlSHzKjwNEZ6xZTUgOFj3zHE2FQiNArsFv5TzMfFUmHEJ7nV/FA3pcHSPI/8sW/0rv
         NyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mo69cMUbimf/aevxLVbY2Uv+LrqijnAeesUuRWdqZVs=;
        fh=WZ9YhCS1PBh7giEtZwxRQKZZLnqGKWijxjYFJo/m9eg=;
        b=Wc8il24DBdKK4OwYiUFyrXp7bXE8WJ5voIhjDT5wAFGH+0NS3tt3lZ8m/UlQ92C9CH
         el59Nq4JEqZIBlevRZ1K6uS3w6mQaiYqPRc6N3c6ikB1BXlSe9Gvl2vICGCs7UZxH1jY
         f8pyGanA/f1DpwlkN5IIcU/Ji62Ws7lvau34eKSnWVWLMMd5b5yIcRK/7vqFpdoEDLmW
         1XJuXCGB2NF2CrluQY59uXZ22FynoUytuOCVRPJAQrfU/AEZyCdSAJDpcLldtlAP699l
         +mSbHogLuHtAmBFtRtdNEXJf2W1NNupMAn0KIVcAuK/wLM3vZVDiZ7ncbhVjs4t+jQsI
         HbFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780954813; x=1781559613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo69cMUbimf/aevxLVbY2Uv+LrqijnAeesUuRWdqZVs=;
        b=anA6PWCworDJOSjABPqXZasIEKsfszDYJy98bNeuZPnJLM6D7Bqscv4+9z7+fz5HMQ
         RcdVFE/tiAFtHUwpC/A8iA8fyF6HpAraMhqq2+ksMIgViQjrf6f1SaUOt0X99UVhvI9e
         95j+oMtCkdCGjJh7pFt9k9kcCYBq0Yah94aSHyOYsURF8Kmy9nQeKhnOJhf3SnIxnq7J
         1mRRC/WX7wKaj3DFTvjo8l6iIDC8GFccsCnsQ3Nf3dKPzrt+fx2EdMdYFhMkdKj0s8jx
         dSzjWw2y2/k7OGj8pnw/gU0Mrzrs7hVBZODKvDFTK0r/ofLVXmsVsbSG27/GCu2uTa+3
         wV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780954813; x=1781559613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mo69cMUbimf/aevxLVbY2Uv+LrqijnAeesUuRWdqZVs=;
        b=cKWheUCUCuOsHSRQZ28au+wNuCrNlZGt+FlVJmqIaRgraXIGVIX8sLRdfR7wvRuYYU
         dZMUMUcUtTHOAQ+u5r19xMvvk+44YTV3hv+yCwgRHZDXsm7jyNpQ/dM+2uYIgIVjJMXK
         yM7pwi1VRsV4NvjECU7lO6NA1NFLGPEH6ixKp5r5l/aRDPEPhj3jmVDISRfMeh8XLG9h
         /0aAMw2seWvCIWKBE0rqb0tMC/OvbiQxQSF8unPIia0byWJFgSRjRiasqMyBaTbDcSFT
         IhGEaqjPNQ1A/mW78wG4l4TQlJ6oqvxhTzWSCYyI6m/m7Dha6EC5+RBDDe17SeMafffG
         efqA==
X-Forwarded-Encrypted: i=1; AFNElJ9q5JEbYarBtqorb6pBPpFkyhZh1b6MXN7aMkzDn3VjjAWolPEhtWfvKtKOP43jtqY6U4pu/HBOvTPQs1juHDCv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kC2o23R7RAwg2ff9BCj4ibNNe7gDY9cDO/cp9MHjabwtqh4E
	ztnKlTNt6hQkHuyPUV1hSEm6m9QbHZtMP1JTq8NB9DxTJM/3eUw6s4o+B10I6Ro5Ueu/UUafcOV
	a9DygbaSMMgVN7yY7ZOv7KKv0GaSDDVDfPIoCZz0x
X-Gm-Gg: Acq92OEuFpWelhx6obicMgf/cw/6/p0ZPF1PxwhnSz7HSTjKpzRNqsbjel2X/uZ81bo
	zQ+k8Ve8hcS2CxuaGFeBvozddb6zoffVY/1ndItl1XHzGhS3RWGmje6HGuMNsqvOSJayYh5gz9C
	1XOAv1J6e86FyieoFyVb5opney9aMJckxyYFzeBQkyt2gEQFyClmcMXi+DK03E8+kW/vTgnFnOe
	KPso4JQXlZhiI5GE4802Q5Hf1i9qjiJ+GQuSpQN0KKWGUL1RWMzTHcEL5xwj2kS+C1Xn6VC/csH
	39UwYacRD0LCkP7CeiNvejz/YkEf8I1EbCI4q341y3f+evKz
X-Received: by 2002:a17:903:2a90:b0:2c1:ee6e:be1e with SMTP id
 d9443c01a7336-2c1ee6eca49mr6389865ad.28.1780954812423; Mon, 08 Jun 2026
 14:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-1-acme@kernel.org> <20260608201753.1979464-2-acme@kernel.org>
In-Reply-To: <20260608201753.1979464-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 14:40:01 -0700
X-Gm-Features: AVVi8Cfdo4zzWzIqQaJoUXI1RMVYDtgMnsWlIFaFE68IBSJqNV81QcDxInqgB5c
Message-ID: <CAP-5=fXgSdhKy2aTOe-HywkjN7f0JTmzuz2Vief9_=+BWdWFnQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] perf tools: Fix get_max_num() size_t underflow on
 empty sysfs file
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Don Zickus <dzickus@redhat.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> get_max_num() reads a sysfs file (cpu/possible, cpu/present, or
> node/possible) and scans backward from the end to find the last
> number.  If the file is empty, filename__read_str() returns num =3D=3D 0.
> The loop `while (--num)` decrements the size_t from 0 to SIZE_MAX,
> reading backward across the heap until a comma or hyphen is found
> or unmapped memory is hit.
>
> Add an early return for empty files before the backward scan.
>
> Fixes: 7780c25bae59fd04 ("perf tools: Allow ability to map cpus to nodes =
easily")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Don Zickus <dzickus@redhat.com>
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/cpumap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 21fa781b03cc7409..1fab00ec4a59a0c7 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -448,6 +448,12 @@ static int get_max_num(char *path, int *max)
>
>         buf[num] =3D '\0';
>
> +       /* empty file =E2=80=94 nothing to parse */
> +       if (num =3D=3D 0) {
> +               err =3D -1;
> +               goto out;
> +       }
> +
>         /* start on the right, to find highest node num */
>         while (--num) {
>                 if ((buf[num] =3D=3D ',') || (buf[num] =3D=3D '-')) {
> --
> 2.54.0
>
