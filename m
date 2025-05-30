Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B925632;
	Fri, 30 May 2025 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748564619; cv=none; b=aMHg79UNh4cJALdZQWJZ1nAqamMzRrdV79P8nNhOIOBlYLi5cgheGFVFwoi/4KWKci2t0NRppga5byzN2feQfb1nVeAK8+9loWB2TTrTv97jtCKgHyHJQ5ImxOJgCjNwDLfHLlw3k0m6GVtSxIb0Y6I2veWJaHEqJU4wCed2ihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748564619; c=relaxed/simple;
	bh=2vlOeyhQIDR0+7USJizUeUX8+sOLDb4bSLVbPI9eSMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCMXz26yr2Iq6ulOGGYhCID+k3qRYFn7nIAtJ/GHSI8r3jhV4CEjuuqzN1iKyGt/qsEBaFrBCl3s7a6oMKncL9ceGJEtyWaUNjcwQ/2M2jLhcr3rCqNhZo2CrbIzdyLzBTo+hDOG2H3OLuo17phygszNKEdU2q+KDz1z6zP6Jqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsplPxFP; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsplPxFP"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7db5c13088so1421450276.1;
        Thu, 29 May 2025 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748564616; x=1749169416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYKOFHvI/E+JwMzIQQe4YyK3jvIlNIviW3jk1OLofHI=;
        b=AsplPxFPNlHZxDjvRB3/ySsybvkkAcy6IbBwOhRpiOTYS7Yage4D60SjOXDF6D6ZPa
         BcFsuD4jxctkc6ix+tVMlNo2PcjZ3yWP2ivL5p92V4dUgu82D2R4tNGRXKBjQDuwymrO
         bkDosMJnKUQvRDg0zuWrx/H4yI7mHnKC72gzB8ojYapyvQCcsQbrAGTywpEbN9nOd/qu
         ra6Oh6HlAIRrQsoKKn5DAXs8BbpA+7Ni3Uf1898Ey+kb9o0axsJDueqIrBI5dq6f2P1p
         ANy5Ta4jOu0khkm2VyPzR/GaQaccKNjiPHwy8CdB6yXrA0CrEYBBzeU1psBFSiA4etyd
         c3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748564616; x=1749169416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYKOFHvI/E+JwMzIQQe4YyK3jvIlNIviW3jk1OLofHI=;
        b=OQIEf/ZHBcdGuxXjp9YM9sspZa8V+AXshcFe6vSnpor1s3IulwL3DvGSenStXr39B3
         Ql00Rs4UIsIEPXsKSUUabj63qkrOu1jdkb0UgnIjkMkD4rohbzcodNjY2tYV/VDufOj2
         cPA4/0Y1lWnkNtIJnCYQnGCjRO9IW3ufkD9x8P0w64zRO5z6cHEgCoNz8btzGKWricJ2
         ap6cnJ3qZjq+t6irdYppTuBtEyBDENS61quicyATv8aELYfbSBjtJEKwZZvCbbJlBGjB
         viPIUDaU89e9A4panoG/DE/apn2V987eZvGzkqHv1LlgNNL0Ry5ilLO3xn0m4Y5842Yr
         jSuw==
X-Forwarded-Encrypted: i=1; AJvYcCUX1CK2FTZ+/YIz9FOabgps1hxmXp5eKBfn/CdJ2lvnAvOmShGEfoqB3yqSeOi9Eyl55Ju1jtoDCp3tI/IgSIxWHg==@vger.kernel.org, AJvYcCVbAWoa1RdkZcmpXUQFz9AT7ND1C5feZSz20NOnNuLpCTEtfPtcr3qEmO8j5p1vhVtlxo8/GRRBeZpXoks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+h7PppglOgtWf9rDucjkcXOhTwkGU8iTtyBkJcJEaOx3aWKz
	rwzCn+Le8UlOp5Ambm+mnyrhjuPv45yZ95SRSGv6sNQf3MlT1TEwymCHfXhysTbT1s+rwO95cis
	QDUrEZslOKHo1i+Ubx0TTEcYayPR2e0I=
X-Gm-Gg: ASbGnctroWU/43Ax/niTk/LXnyxALD4e7cxnDU16ExQPfefeRbDXIGIxF1mmefO/+QJ
	amftk1Uc0hpDokCn/iQVVe36fxYG91GHevBW1bEMu1YkELiqSA0YYiKsi1xAwdu28oombPscIfz
	Tpogq3xHsbey/8HCkPGzTkrEw22184big=
X-Google-Smtp-Source: AGHT+IGr6RJ/yxqsH2YQMWdYvUdMh04bwGLC/nyDpNOTkQ6vpixJi7GxkXZb5cAT7wnk/2b3SnBl2H2UkH5jobfi7tg=
X-Received: by 2002:a05:6902:2808:b0:e7f:6b9d:bde4 with SMTP id
 3f1490d57ef6-e7f6f19d4c0mr8820648276.8.1748564616207; Thu, 29 May 2025
 17:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529065537.529937-1-howardchu95@gmail.com>
In-Reply-To: <20250529065537.529937-1-howardchu95@gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 29 May 2025 17:23:25 -0700
X-Gm-Features: AX0GCFuiRcsfJ-AnzJhHvt6nMc-4wXd6eGoXXSSUwy04Um8-md9PrF8G38uIfCE
Message-ID: <CAH0uvogdtqrzxamPd2zW9uz2zPMz8r33Aojp2zYTJXn_E1EbfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
To: acme@kernel.org
Cc: mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:55=E2=80=AFPM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> perf trace utilizes the tracepoint utility, the only filter in perf
> trace is a filter on syscall type. For example, if perf traces only
> openat, then it filters all the other syscalls, such as readlinkat,
> readv, etc.
>
> This filtering is flawed. Consider this case: two perf trace
> instances are running at the same time, trace instance A tracing
> readlinkat, trace instance B tracing openat. When an openat syscall
> enters, it triggers both BPF programs (sys_enter) in both perf trace
> instances, these kernel functions will be executed:
>
> perf_syscall_enter
>   perf_call_bpf_enter
>     trace_call_bpf
>       bpf_prog_run_array
>
> In bpf_prog_run_array:
> ~~~
> while ((prog =3D READ_ONCE(item->prog))) {
>         run_ctx.bpf_cookie =3D item->bpf_cookie;
>         ret &=3D run_prog(prog, ctx);
>         item++;
> }
> ~~~
>
> I'm not a BPF expert, but by tinkering I found that if one of the BPF
> programs returns 0, there will be no tracepoint sample. That is,
>
> (Is there a sample?) =3D ProgRetA | ProgRetB | ProgRetC

Sorry, I meant ProgRetA & ProgRetB & ProgRetC.

>
> Where ProgRetA is the return value of one of the BPF programs in the BPF
> program array.
>
> Go back to the case, when two perf trace instances are tracing two
> different syscalls, again, A is tracing readlinkat, B is tracing openat,
> when an openat syscall enters, it triggers the sys_enter program in
> instance A, call it ProgA, and the sys_enter program in instance B,
> ProgB, now ProgA will return 0 because ProgA cares about readlinkat only,
> even though ProgB returns 1; (Is there a sample?) =3D ProgRetA (0) |
> ProgRetB (1) =3D 0. So there won't be a tracepoint sample in B's output,

Same, ProgRetA (0) & ProgRetB (1) =3D 0.

> when there really should be one.
>
> I also want to point out that openat and readlinkat have augmented
> output, so my example might not be accurate, but it does explain the
> current perf-trace-in-parallel dilemma.
>
> Now for augmented output, it is different. When it calls
> bpf_perf_event_output, there is a sample. There won't be no ProgRetA |
> ProgRetB... thing. So I will send another RFC patch to enable

Ditto.

Thanks,
Howard
