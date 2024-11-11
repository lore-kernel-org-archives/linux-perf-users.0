Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A081A704C
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347826; cv=none; b=X8MNxuB3h36Hn84B3BpVflYRZESDJdcvw5w09k2u6ZA8C9F2uBa350BnFFeCG8gSh4wDY+nGKuhzBpTEKwdzF4XkdWsJTY0z5dfbeSQhKzcjHuoCR+65KlOqYqpSiY1I6tGnMVBeL3MmorWKVxLLaFoTq9C5ph8K6yWaKbCZpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347826; c=relaxed/simple;
	bh=Ab1oytO8ZVmWhP5fgvNeeofaU0GDgKs6R1o9YfWvfhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6wRx0qL79Y1a7dmBs8VcZRmkVf3h5hJCpjr4T81ytikc/tSYSsdCNjS2QkL93BOEATo2JEtqapwfvmpcnI67ZRrgiZbg27AFoz4IRMWvMcHHDSAt2nDPbQnYwNvL9yeGaAGZfK++QpX1TUS5aGb4CWhlCgvhfJ0z8bD0A33vaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHOij0+X; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHOij0+X"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4608dddaa35so9131cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731347824; x=1731952624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhlfklFJzcq9yoGsneqDg/hSgWWKzA1mzsvO36qciE4=;
        b=DHOij0+XumRMmSNDmBPhSCLsdQjEDo1726bm4x43a6KnrlO2+UxrJw+e0ZRZMkIEuG
         FDxNcP1TGUUFelAa04h4f4aiZ+uStljBuWvmyIOAboRc/RqngY/zogBkULDVx6oi/3Su
         861GnRvtNFkE1ZR9nHPg4xcJHKnimgWkdPKNwAkN7hDclJyo/AvBdRzh+7SwRDTFVb9N
         Kh7ZRFdVWFXeyRtI6xwnaAZZuSC6+IhGNN3c8jdJFW19hYnrpkP+M/2hUPtmqbR1tDSk
         X8wXF9ZDwDVYfutiRzpNPon9AbGFRcJaT4UKZ7vK3YXw9UFaiGve0ibVBN7LMuIc1juE
         EoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347824; x=1731952624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhlfklFJzcq9yoGsneqDg/hSgWWKzA1mzsvO36qciE4=;
        b=vcIFT45g0Z1bEn4TDiNeogoMqnmZbrZ9yhsH4LYOO2FRHGBlj+QtGRqDuPtgOKhnEg
         jofou+t6q0ixf84SrXkN4NC0S1racpyDeWrVX8cBTRIqe9yzbRR5ngOjt4Hp0GBIWIIw
         wgBtm6G8Oe/agh9bTtlMuKgPMtUUFAkBiJczogXqbJWOG9kb9220rvKZDmMvpMyi6N9F
         Vyv342kK4KcvRNvqWl8md9lg2RaX3ky4w6BSsweCWr4AE76rgg5hDu6LQLSEd10R0pLn
         Gn6xNOLCkM0/ZftLF/TCBG0HheGv9QeXHYh+AAQTGZz9gKmBlQlzc6MMuA2WYbv/HTTF
         hPKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa025yC692xWN44mdpZwA/O+GH1MiNAzE+nvamUizcuKAF7y1FJNhcrwmrw75t2lhsxX9wTTW0vSTiB1ti+lGJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQ6ff61t13RHlJ3+RFWsHnXoWyzbaos6bqT6lyrEuIZTJazrl
	7KASEPPP68cBkzzHCwxjhcjHqkOhJKortM7Se7K5qhpVpD9MwzYBWgdefEZYnQCHpBalbE4pqAw
	yB4pDPFnNFM5SAQJ7AJ+tdGBOfRg+iqsqgShp
X-Gm-Gg: ASbGnct6BysPkhNlXx8+7QfUBuY8i/EHyHh9H7/vb3sFzF4nryAWHudoUwfNw3n2RW3
	9G6TQ4lk/1afetYHtvFk18AQATTq+EexBnc6s7q03dTs4I0gQvpjbcCIUncpyx7o=
X-Google-Smtp-Source: AGHT+IEu0GW0f3agX+5M8QSU8zfX5ZE8V/0IIfsBmBIY7tz78CEqDSH6OxDkACRTgK6mdAynWf2/DPiX8gol8lD3ylM=
X-Received: by 2002:a05:622a:1816:b0:461:358e:d635 with SMTP id
 d75a77b69052e-46316a1e46bmr5608461cf.18.1731347823697; Mon, 11 Nov 2024
 09:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-9-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-9-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:56:52 -0800
Message-ID: <CAP-5=fW-y3KOCDs4WMHXj03x7s1CkUC-zvx7LmHq6Fh-O9+fCw@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] perf script: Display off-cpu samples correctly
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> No PERF_SAMPLE_CALLCHAIN in sample_type, but I need perf script to
> display a callchain, have to specify manually.
>
> Also, prefer displaying a callchain:
>
>  gvfs-afc-volume    2267 [001] 3829232.955656: 1001115340 offcpu-time:
>             77f05292603f __pselect+0xbf (/usr/lib/x86_64-linux-gnu/libc.s=
o.6)
>             77f052a1801c [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-=
2.0.so.6.0.0)
>             77f052a18d45 [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-=
2.0.so.6.0.0)
>             77f05289ca94 start_thread+0x384 (/usr/lib/x86_64-linux-gnu/li=
bc.so.6)
>             77f052929c3c clone3+0x2c (/usr/lib/x86_64-linux-gnu/libc.so.6=
)
>
> to a raw binary BPF output:
>
> BPF output: 0000: dd 08 00 00 db 08 00 00  <DD>...<DB>...
>           0008: cc ce ab 3b 00 00 00 00  <CC>=CE=AB;....
>           0010: 06 00 00 00 00 00 00 00  ........
>           0018: 00 fe ff ff ff ff ff ff  .<FE><FF><FF><FF><FF><FF><FF>
>           0020: 3f 60 92 52 f0 77 00 00  ?`.R<F0>w..
>           0028: 1c 80 a1 52 f0 77 00 00  ..<A1>R<F0>w..
>           0030: 45 8d a1 52 f0 77 00 00  E.<A1>R<F0>w..
>           0038: 94 ca 89 52 f0 77 00 00  .<CA>.R<F0>w..
>           0040: 3c 9c 92 52 f0 77 00 00  <..R<F0>w..
>           0048: 00 00 00 00 00 00 00 00  ........
>           0050: 00 00 00 00              ....
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 6b6d4472db6e..1893d2117aab 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -662,7 +662,7 @@ static int perf_session__check_output_opt(struct perf=
_session *session)
>
>                 evlist__for_each_entry(session->evlist, evsel) {
>                         not_pipe =3D true;
> -                       if (evsel__has_callchain(evsel)) {
> +                       if (evsel__has_callchain(evsel) || evsel__is_offc=
pu_event(evsel)) {
>                                 use_callchain =3D true;
>                                 break;
>                         }
> @@ -2353,7 +2353,7 @@ static void process_event(struct perf_script *scrip=
t,
>         else if (PRINT_FIELD(BRSTACKOFF))
>                 perf_sample__fprintf_brstackoff(sample, thread, attr, fp)=
;
>
> -       if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
> +       if (evsel__is_bpf_output(evsel) && !evsel__is_offcpu_event(evsel)=
 && PRINT_FIELD(BPF_OUTPUT))
>                 perf_sample__fprintf_bpf_output(sample, fp);
>         perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, f=
p, al);
>
> --
> 2.43.0
>
