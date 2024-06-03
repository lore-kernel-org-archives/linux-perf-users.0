Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA7136E34
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Jun 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432334; cv=none; b=rCjI0j/H1LTI7DVRl8JOWmLlUBrTOjKuEnTcH4R/TpPmDZcIMKbw5Q1SmfwJWnILi+i/Mgtm/YbvWF011Q2eQdWHZRqcz83++FY+PWcFmfm8WlyLsoJo3rHr28EjGKbiFQ1DGX76zXZJBqTuk/m5vvBAKwNU7TLRKAFlXpnorr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432334; c=relaxed/simple;
	bh=w9a2/atiiKAlAmz2KZIcZv+9KetM5M2FFUgSgR3Onnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDuodKYaG1ifnytfm2cSvVV6qsnoHNAdHBYVJZ1LUOG6NT4xI1SAEWzBv3ceuncUjIxTBi7bH0CAVJAHI0jNdVSVUr2TCeK4rXmAFZYP/CLHSI1QbsfuN7AAG15812P1laWJKojknkXubn1SrjT4bDxz39JEsBDOY66GDImGZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oj+s7Ufy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oj+s7Ufy"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43dfe020675so1901cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jun 2024 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717432331; x=1718037131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1p+tR727HW3fVvv0/DGxXta4E0+P8XXbCMMa/xAMnU=;
        b=Oj+s7UfyvIf91N5RfpRkcaxtFvceoYvkLaJPQ+L4I/nS4TOXinQ+50V7EolwkqJCD3
         ovFgtGuxHVVG19iOlm8ZTOw0RSx+T2NJ8vLWENLrVjmc39zPJbalE2wUueppWh27T9g0
         +a2jwG/U6WG0Qyc5nZtAv6EnADdR+gUDuV3wE74019HiktAiORZvF/mFvSZy/Ba7ehC0
         j7sPrJuKocc3AhMyfq1LXlcKiYgs83hlwdgpmAzRsLEOYQSxJBLNG4AMYUYoJtlhqSTK
         KsISTAViADO7vFfHMwAh15Kl818xXa6BjNqA+G68tWbDalQ+GAQFODS8d3M5ZLy/jUXc
         XxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432331; x=1718037131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1p+tR727HW3fVvv0/DGxXta4E0+P8XXbCMMa/xAMnU=;
        b=PVmX+7v0RhaxJ+8JSaUGUskt+VfBmqfWUCeh9t3yhgYKt4w2vt5V1V8Pe49Z24BqAr
         SVog7upIP+xRvpqeoPcCNYmEGfcfDlDLZfmjdbZI69mQ0JrC2R/GVWmt/5GXLzDofGG+
         tZ88eOEV7C/Og+31F+ZsFJlPsmTfsgEbyl2U8VdqZmC9Z/pz93D9hwwIksP8G1vrRUtV
         ATt3heANUqXxs59+7AA5+dOfWmZ47Vzc/FnKXdVnFzSkQqMpBnbVsnlfQrdnmQN/MHSt
         Dhr+I2HZe5JQKmniUpZSMdT9mkiF+nHeWeIEMo1boLzpSuB1klluNIXjt1rq6Joid6Ev
         ZeTg==
X-Forwarded-Encrypted: i=1; AJvYcCX5gz4Ng+3eS3aosDqVXZ6RmojsDonK+rCexCyMsL+AsFER7nHf6VIj67eYDNdCXbqqIODFXBDO2xdYM1yZnCBzxzsEvNVkOgTKZn6r9kyVhw==
X-Gm-Message-State: AOJu0Ywjv963b8iJOCcEiZHbrR/i/uYw/i9C9fG5d1nSGWRmk297kwGi
	V79IGXbvrTibGT+6lpAFM+VBeTqjIUJF4nnzJm11bCG9ohJkIffcYsNvLJdz0y8tgrUMdZWz3ie
	xmZhBR/0KD2ZjDaSwIVGee4rpuBnDrXW0S1Pr
X-Google-Smtp-Source: AGHT+IGjvGTOJJN5aIMZuCRwYSL9PxNrA6CXhpvYTHYYyP2QVJ2qoVuj6u5cb0dQGA8tj+JOqm1Lj1JKYauPf20NupA=
X-Received: by 2002:a05:622a:4248:b0:43e:1124:3c4c with SMTP id
 d75a77b69052e-43ffe081457mr5570481cf.28.1717432330598; Mon, 03 Jun 2024
 09:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602000709.213116-1-linux@treblig.org>
In-Reply-To: <20240602000709.213116-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 09:31:58 -0700
Message-ID: <CAP-5=fXaaDZPL44Nar9uR94QvqgiYaaDjEpM1rb1mgiU69178A@mail.gmail.com>
Subject: Re: [PATCH] perf hisi-ptt: remove unused struct 'hisi_ptt_queue'
To: linux@treblig.org
Cc: yangyicong@hisilicon.com, jonathan.cameron@huawei.com, 
	peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 5:07=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> 'hisi_ptt_queue' has been unused since the original
> commit 5e91e57e6809 ("perf auxtrace arm64: Add support for parsing
> HiSilicon PCIe Trace packet").
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi/thanks David,

Reviewed-by: Ian Rogers <irogers@google.com>

Ian

> ---
>  tools/perf/util/hisi-ptt.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> index 52d0ce302ca0..37ea987017f6 100644
> --- a/tools/perf/util/hisi-ptt.c
> +++ b/tools/perf/util/hisi-ptt.c
> @@ -35,11 +35,6 @@ struct hisi_ptt {
>         u32 pmu_type;
>  };
>
> -struct hisi_ptt_queue {
> -       struct hisi_ptt *ptt;
> -       struct auxtrace_buffer *buffer;
> -};
> -
>  static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *=
buf)
>  {
>         uint32_t head =3D *(uint32_t *)buf;
> --
> 2.45.1
>
