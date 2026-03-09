Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C2346A10
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 18:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080325; cv=pass; b=vBJ80bo5UhnkFlGGA+Zh1c76Alb+/mdU2Py2W5fCWrB6gHUdwezgEGNebLe0EYS6+DF67TH7YoXmfD5GDfkZnIIDTYiJuuQnTHZ2Vn9VkpVdX8e2txoQfD93YL1GE+/wltjYu/iSzkHE1ez7PaNV/5hP9gExHeyd74hH4tV3sNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080325; c=relaxed/simple;
	bh=VjCK9O9mWN+S+Owop3XPnvrdHjcUqFjZT/JVHGCIYYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6qg8YCPVcIg45xRP58L0moZbzHs26uvV3xFd6YPhJRBrBqNbdgjGWBgRGLWqxevrqrzgHXCpF+FZKXSD0X6kwkp6qazCK+HkuM1ii2ScjJv3PvYJsDprlzEk3aiV9d9NAHypaFKrM125knN5CH00SXrhy1PtpGBdYD7Iaa5qi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhqsFfIx; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhqsFfIx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae3f822163so15345ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 11:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773080321; cv=none;
        d=google.com; s=arc-20240605;
        b=S1VP3lHcj1Eoh87Mp6s4K4Kzop2nmNpuNx+k5ghIH9KfvIHL/MSBm9gOYvTQxUS9Sz
         e4nKDNJnBT8o4RDQSSDTFfZXkwEfhclElu8i5Y2xIoLq3AW6RfDGE18vNQzs/II99unC
         Q1z+KvTVEpbm8ypwLGNRx7ZzDSbVf5crii1KPWttk65Rju28npMml69oqWGDAaW7rFeI
         5rtCB0ElBQI0iCszRw1kstabvbBQ2mhnTz8C8RLFx6Xp8iA0sOI6g1fstRZQT275dVaI
         Wt+LNGtMWRF3TeXrG4SZb+wsT+A0E9qK3M2FFw10XrxmTiBIkjWQJJPEk00hlM68hJ0j
         aV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mNFhEsxk7RBeGZyKEG7ERKLw/wU59C/RzDtV/jvgQtI=;
        fh=ak/IQY2RIOzOt6oh0DxI2YHl58RspwXPCtfOay4n4pA=;
        b=GUHE25jDBRaJYkqIKt2MxUDyrdb8nktHWvBB6EedkvpgwWU9YkFQKGaFOcOuLJ0Qo6
         DQhABYmdjMMzTE8wYWXS1+IeOoOYD/9gxfbJNy7HRs/FVKPw6eTlfIBzIzYxixjUAbjy
         f0MCL21WgGG1yj8afIBr6Jd3G8/6eFXaeNdC1WMzIGPB0GXaD4cUmbbsPJHl67k7tCao
         rKOUbSl2BrQvv3k6/qtd4fEjaJwKIvXK7y5jvuCBVN5MCLpoGULKCG9Aj+LVhbFSuv96
         OEf1B14auIPnxaOIkVZH+FGxYwG5guS4hhYVXArvcSJEYqpRfqujgEjR/bVtlPZ+7lq4
         ixig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773080321; x=1773685121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNFhEsxk7RBeGZyKEG7ERKLw/wU59C/RzDtV/jvgQtI=;
        b=rhqsFfIxXkYUO+SLEhAI8uUW2ZevSoZSnL/mnAgBp3JVvhxzLZTT865l3qRjuUQjOo
         hMw5+5ojFwwf3VvvXWk8TtVpV+1jsgL5NCmg9iLF+hpCv3pZwcl70nBgZXS4xT8TPrCk
         fD8YJbDq4BeIVOtgNlGkJJnR25VBBFgvT3Svyf/3URdoE2DcRUYlvKGjI30w8etGFlm7
         FfggFJt8RWLlJWdknLh16Tjl/3qbQc9VRb/0ClApDfvbeYP4QvGVSGHTHpgLYnkWwOtn
         0V9UVo4Pj34zwywouiH/37oxJEkY5j9I5h0gzsbCT6GMeFGDI64Mz6TTVk2Mc0ZxeOQA
         lSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773080321; x=1773685121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNFhEsxk7RBeGZyKEG7ERKLw/wU59C/RzDtV/jvgQtI=;
        b=uPlLTubFNuhGdgkuFHC8axFAZ9KOKz3QN5GF/O9ICXCKUm7B3qqGkbriiwZmCKfnHP
         1E30hLU2clrnum8yA4WkqkmsoXWg++6xAuAU/FCuP0fZ+G4JMV/ETbLQ2xLBEatiJ8Jr
         viNUceHTLmPoATesD4OnAqVYg3sZMpq70b2C/EiUs0gJL/K7mXOFZ0cXLjOvfnIZgN0y
         fjSfiNSNhht3Efch3AWU3BPUmff9Fc/RRVMH/uFxeeOcbZKDWpSR6GrWoBmLIpPMwQDi
         yEXyFnZsJQgAx+7wH1G6VBw5Ao5M1iIsvBdHhH0WYbuJNPBNlNBm9fXeeUk92IAYroeQ
         BAIg==
X-Forwarded-Encrypted: i=1; AJvYcCWi1QMCSZRwuU/uLggi6KehGOooYUmzJheqNlvMX3thy4Dc1jXgOb4hv2saX1InkNvA5CvAyWC02W10SFsHxEOF@vger.kernel.org
X-Gm-Message-State: AOJu0YwQu4QqMZFP7ikOduvepbVy0DrQGr4/38bnbwYxvYrCfcSHfi3l
	t+7zMs3qHD7tJKQk8Srv2SkW2Cmsv5d3EFieVHRgyLGgzOxgoJx795ACS4ysGtPNCXx5xPJkHfh
	g2vPyfSmALWgS1EdtSGqtBajLlL/6N7BdqjCwlu5a
X-Gm-Gg: ATEYQzyjP3hlQNUAJSdyjMb6cl1FuVpwNegtoENHrKZ9ihMkNWiv9Hl/9xTRzFZTFEc
	KZpNdqKBBb2toV7hTONZu4g51CCwS49gVexxwNNOzU+f95Jb+aISRKZHKm9CA1dJhI4qVbViTAC
	CUOVlj+1xvs6IDBUSeqb3imFwfAT54tnKk6ErCMn3YseTnc9Fy2wO7rmtpsa79k/prOI0jLIaas
	97CKbxb0+4aXWiO+h3/hq9mpZOfNPy5NmOdZTpPphJ00yAEejRGhFt3qckivj6iIgoPBcU0AtHC
	TWlvj7hLhJn8pglHdImDLierViOCJ8S7LIvXekOmV3ky4Q==
X-Received: by 2002:a17:902:f601:b0:2ad:6f9b:7818 with SMTP id
 d9443c01a7336-2aea32a5a08mr210975ad.23.1773080320080; Mon, 09 Mar 2026
 11:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306071002.2526085-1-tmricht@linux.ibm.com>
 <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXs0UrMVhwU-_=iunCYa_ye18FHj0W1V8sE5T9nOkeZWg@mail.gmail.com> <a3b8bf7e-ec5c-460b-9ffc-ca1d2cd9e223@linux.ibm.com>
In-Reply-To: <a3b8bf7e-ec5c-460b-9ffc-ca1d2cd9e223@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 11:18:28 -0700
X-Gm-Features: AaiRm53NpshLl2TAryEIsM_KO_pJOOQiJbOuKf-KMqb7PS5CdD3Srr6i6S6j9u8
Message-ID: <CAP-5=fVziHx2B8QPWafPo0T_JWm06zD4vwtR4DmcFyePV04U0Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test case 120 and 121 for s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 5:59=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> On 3/6/26 17:53, Ian Rogers wrote:
> > On Fri, Mar 6, 2026 at 7:52=E2=80=AFAM Jan Polensky <japo@linux.ibm.com=
> wrote:
> >>
> >> On Fri, Mar 06, 2026 at 08:10:02AM +0100, Thomas Richter wrote:
> >>> Perf tests
> >>> 120: 'perf data convert --to-ctf' command test
> >>> 121: 'perf data convert --to-json' command test
> >>> fail on s390. It is caused by selecting the default event cycles
> >>> which does not exist on s390 z/VM. Use software event cpu-clock
> >>> and specify it explicitly on the command line.
> >>>
> >>> Output before:
> >>> =E2=9D=AF perf test 120 121
> >>> 120: 'perf data convert --to-ctf' command test       : FAILED!
> >>> 121: 'perf data convert --to-json' command test      : FAILED!
> >>>
> >>> Output after:
> >>> =E2=9D=AF perf test 120 121
> >>> 120: 'perf data convert --to-ctf' command test       : Ok
> >>> 121: 'perf data convert --to-json' command test      : Ok
> >>>
> >>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >> [snip]
> >> Thanks for providing this, Thomas!
> >> Tested-by: Jan Polensky <japo@linux.ibm.com>
> >> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> >
> > Should we not fallback for the cycles as a default event?
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/builtin-record.c#n1374
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/evsel.c#n3792
> >
> > Thanks,
> > Ian
> >
>
> The fallback should be cpu-clock in case hardware event cycles (or CPU_CY=
CLES on s390) does not exist.

Thanks Thomas, so the change is doing:
```
-       if ! perf record -o "$perfdata" -F 99 -g -- perf test -w noploop
+       if ! perf record -o "$perfdata" -e cpu-clock -F 99 -g -- perf
test -w noploop
```
where the default event is cycles:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/evlist.c#n116
Given that cycles will fail but then fallback to cpu-clock:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/evsel.c#n3792
I wonder if the issue is that the fallback is broken. Specifically:
```
   evsel->core.attr.type   =3D=3D PERF_TYPE_HARDWARE &&
   evsel->core.attr.config =3D=3D PERF_COUNT_HW_CPU_CYCLES) {
```
It isn't going to work well on hybrid machines or those whose PMU's
sysfs events or JSON include a cycles event. I wonder if using
`evsel__match(evsel, HARDWARE, CYCLES)` would be better, as the
evsel__match code is more robust to these kind of variances. I don't
know if that will address the fallback problem for you.

Thanks,
Ian


> Thanks Thomas
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
