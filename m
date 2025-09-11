Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D634AAE8
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604453; cv=none; b=GaSUz4xVqTYrbtqFJljUGIC9rs1Sf0Wybw7dhRB4QWnaEJqGkUaqdQr9KgDfQ7SIiwtrCJY8tw9eJcBSwK83nLcKTNkRjSsnE1gXFvoTmG/Jz+RY7vOqa72R981mBA8N8e5LAs8QqiQMYMVnTiybHmFnJkQ/oE1ecfnCcQbiFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604453; c=relaxed/simple;
	bh=FMFtleix5zAsatnkNj1rMSFaDxtgnV12O1vu0khD3xU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nU63kTCiqkeUCSReI8yctGvsPvzZrbSwjFeZfWvm1pzRpz88Aw8jBLbk+yzn7E3rVPfH32Kp/PbGCspAZwmd6IZE9TZzLWG0Zps3M2rVryOYfsHE80KYf9FSKMrirT00WOnDTpXLrhwKQB9pk/V/tO6E8IfBQrQ7RZJLiUwGsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkCdBW+z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkCdBW+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757604451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9Ty4a9j3Q13yj0WN/MFT87mJD5OZyFu8CB58bC4R9E=;
	b=HkCdBW+zVOX3XEfXxtY26kHIpoptO9JQ9/QmTZRrDpOSEKkV0ECJP8HwIDaaf2WR2W5JZt
	ENE9KMq1LqQkY13EHL7wvUESP+3s4aCiIoD8IfWSI/HXXLY5IeCyAKa647q7mmCU472HZs
	57kFJItzFp3cbPhtD9RMtTrj3ojRyR8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-OdUk1UYrOuqC18bAIYvsZA-1; Thu, 11 Sep 2025 11:27:29 -0400
X-MC-Unique: OdUk1UYrOuqC18bAIYvsZA-1
X-Mimecast-MFC-AGG-ID: OdUk1UYrOuqC18bAIYvsZA_1757604448
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-62caf055c95so1470007a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 08:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757604448; x=1758209248;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9Ty4a9j3Q13yj0WN/MFT87mJD5OZyFu8CB58bC4R9E=;
        b=INTV+sDOkwRHyRnOdDo+NTRJsdLAoytCYS9NcgJkcQgsO6QQrD4yDJjEGHSmCG/IW/
         HHABxBIf+FKH9He+HrpuOQpVgZYTuuocfCpzWapynEyvIl2AkmaapO4HRN8gumQF9VV7
         P5C5cOWRDDen8V717NMb4HYU8v849MOblZaWFr0FXvEoMsKFP8RNFiQr+cGEjZC8yXHX
         wmespnkKGiVOeusV3r6rlfu+M5nxnfw5rr5s+qRiCnVOUWtmUOoS6BjDgx49u4C1RE17
         uNgDF5WQXgXz+79NAZiQem92y2ZAaa93xOeYqYRh7+yD2ZW9Axr5S8/N3GTJ3XGg+8gT
         CdWg==
X-Forwarded-Encrypted: i=1; AJvYcCWPumh0YgPZ7171I+gRD1W8epzcaKw9T8KtPhrgUB2H/G1gEBAp5nFawPJG5YWN1WjHdPRKiIMY3fgWhUdifG62@vger.kernel.org
X-Gm-Message-State: AOJu0YxUocSJTvqq8WtN597mSytXEwzOU0sJ3nJ8dlkxWLhU/c0MlVF3
	TeCl/vblrsFYv1Pkabc4LrGZ/dkw50FlAhEzSh0haDQZbFy4y6luoDfuggn1K0D1qVASREivkg5
	LxB/qq/J9pW7Ma4NvzBd0TS24LFhTK/115gDnPjpp0qXLAaScLXo93+rg921M5IlLWYSQW3yjot
	iiTw7sEBOHmZstWDPAlvJz6Id8JRnn5CjC4g0YZxPRGrm2IA==
X-Gm-Gg: ASbGncs8OTJTYWe81u7W+rEXsZiBzbqtOAW21sMq7xXjSmy//U+3/KoH3ajLlWOOiPn
	w1hdTabtSvtjEJjXCWak5zWCvWZtClSRrvRR0LxmGk1v8DPgAPoO1Y92ADqvdtNPm0Y533fnJdx
	2GNkviQBo/p7sIoOrQoUHsA2e20qqw/VyJY+bzcTvKp24S9Yibcavod00=
X-Received: by 2002:a17:907:1c93:b0:b04:3e15:7289 with SMTP id a640c23a62f3a-b04b15434ddmr1955096466b.33.1757604448140;
        Thu, 11 Sep 2025 08:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECDDaD1Xc+Gd5ufwiAao+r9SGg6TD6pN01GK+sGitmFT+pPFvQHhinFhAw8smV+U6Cvwwz+UZGae41jogfAMU=
X-Received: by 2002:a17:907:1c93:b0:b04:3e15:7289 with SMTP id
 a640c23a62f3a-b04b15434ddmr1955092866b.33.1757604447623; Thu, 11 Sep 2025
 08:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821165831.184569-2-ashelat@redhat.com>
In-Reply-To: <20250821165831.184569-2-ashelat@redhat.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 11 Sep 2025 11:27:15 -0400
X-Gm-Features: AS18NWAzA3aD5vimmjryd8UtzLPvZlfR4xO5NIOl-oQ4HrqXIWHe__u8yx0brOw
Message-ID: <CA+G8DhK4tqVLMdNhM-bfYSc_8C2PrYeOVEJnGOb2nomHsaAhNg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: don't show comm/tid for regular syscalls for
 single-pid traces
To: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	irogers@google.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pinging

On Thu, Aug 21, 2025 at 12:59=E2=80=AFPM Anubhav Shelat <ashelat@redhat.com=
> wrote:
>
> Previously when attaching perf trace to a specific pid the output would
> look like this:
>
>          ? (         ): vest/616160  ... [continued]: clock_nanosleep()) =
                                 =3D 0
>      0.041 ( 0.013 ms): vest/616160 fstat(statbuf: 0xfffff2c60038)       =
                                 =3D 0
>      0.073 ( 0.008 ms): vest/616160 read(buf: 0x3bede330, count: 4096)   =
                                 =3D 17
>      0.090 (1000.095 ms): vest/616160 clock_nanosleep(rqtp: { .tv_sec: 1,=
 .tv_nsec: 0 }, rmtp: 0xfffff2c601d8) =3D 0
>   1000.210 ( 0.136 ms): vest/616160 openat(dfd: CWD, filename: "/tmp/some=
thing.txt", flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) =3D 3
>   1000.361 ( 0.004 ms): vest/616160 fstat(fd: 3, statbuf: 0xfffff2c60088)=
                                 =3D 0
>   1000.375 ( 0.018 ms): vest/616160 write(fd: 3, buf: SOME TEST STRING\10=
, count: 17)                     =3D 17
>   1000.395 ( 0.072 ms): vest/616160 close(fd: 3)                         =
                                 =3D 0
>   1000.476 (         ): vest/616160 exit_group()
>
> which would cause an error in the perftool-testsuite since the comm/tid
> shouldn't be in trace lines for regular syscalls. With this change the
> output looks like this:
>
>          ? (         ): vest/612038  ... [continued]: clock_nanosleep()) =
                                 =3D 0
>      0.039 ( 0.012 ms): fstat(statbuf: 0xfffff8e94cb8)                   =
                     =3D 0
>      0.069 ( 0.008 ms): read(buf: 0x3b997330, count: 4096)               =
                     =3D 17
>      0.086 (1000.436 ms): clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0=
 }, rmtp: 0xfffff8e94e58) =3D 0
>   1000.545 ( 0.136 ms): openat(dfd: CWD, filename: "/tmp/something.txt", =
flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) =3D 3
>   1000.700 ( 0.006 ms): fstat(fd: 3, statbuf: 0xfffff8e94d08)            =
                     =3D 0
>   1000.720 ( 0.024 ms): write(fd: 3, buf: SOME TEST STRING\10, count: 17)=
                     =3D 17
>   1000.750 ( 0.073 ms): close(fd: 3)                                     =
                     =3D 0
>   1000.833 (         ): vest/612038 exit_group()
>
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index fe737b3ac6e6..4cc38ee6aad9 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2955,11 +2955,17 @@ static int trace__sys_exit(struct trace *trace, s=
truct evsel *evsel,
>         if (trace->summary_only || (ret >=3D 0 && trace->failure_only))
>                 goto out;
>
> -       trace__fprintf_entry_head(trace, thread, duration, duration_calcu=
lated, ttrace->entry_time, trace->output);
> -
>         if (ttrace->entry_pending) {
> +               if (trace->opts.target.pid) {
> +                       if (trace->show_tstamp)
> +                               printed =3D trace__fprintf_tstamp(trace, =
ttrace->entry_time, trace->output);
> +                       if (trace->show_duration)
> +                               printed +=3D fprintf_duration(duration, d=
uration_calculated, trace->output);
> +               } else
> +                       trace__fprintf_entry_head(trace, thread, duration=
, duration_calculated, ttrace->entry_time, trace->output);
>                 printed =3D fprintf(trace->output, "%s", ttrace->entry_st=
r);
>         } else {
> +               trace__fprintf_entry_head(trace, thread, duration, durati=
on_calculated, ttrace->entry_time, trace->output);
>                 printed +=3D fprintf(trace->output, " ... [");
>                 color_fprintf(trace->output, PERF_COLOR_YELLOW, "continue=
d");
>                 printed +=3D 9;
> --
> 2.50.1
>

