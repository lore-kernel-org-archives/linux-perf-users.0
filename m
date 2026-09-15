Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CBD4499A4
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501667; cv=pass; b=kqnF2Kbl8AyAA30IaEfVCST5Vzk7AzupjYP+q1SGoWikrdjdFoanLXI3AKBxyEKNUI0UsuQuGD8PgEqoGc0zU/UAlRt69GXTxE88JV7awjUvXhIuoFHXtRZGVxAls5gF+QwOxHx9LcOSoD/kAdW13pQw88+OzqtuTUdAM2bcA5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501667; c=relaxed/simple;
	bh=XPQeBwzJVFS7E7eRmzzs+WdXKCVvNPBVqu7jyYbAFec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmlvVuRnsGEEtQRK8Q0uNhutvfYcZS4hu4iuFDd6uZy4ww6p/TraHKEJBr6cFMf3nuEPiSdOStdPqEE3xnJ/hGbuvIcpdxDclk6faVyID5tRL8APuEw/Qgu0TkdL9pZSaIftK+piNo8DgEBRKqVSbMsIz6mh6SN0V//LtWm64MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKLj7tCs; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKLj7tCs"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d5fc2cd8so63081cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 12:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789501663; cv=none;
        d=google.com; s=arc-20260327;
        b=cni5HAvb0VDuBxiAnAjA3XLKE/PGQFThxqnY1j4C+iBQNZtZqhq5yvreRY7hNoqkI3
         dosG+V6YAnPEXT0c51VjB5YB4XMIvgkAi8Pg5eMN0677VO9VfxkobWGYZToI5AhGmre/
         Hx+h6Vf95HwBe31tbT/fRs6EGR96vZ1lGav7OumVphkXvDR9dzoQA6MJBVW4a123kSl2
         YeFqoBjgqFa6WyvRu2xTapXWpyhHYWDF2Q9SAD1pgYpsIByWsNtoW26TaIfY1wtLWOtV
         16TljZaiQ4m+9t26Gw6Cb1CNf+UzDZPivdT0u9Gpy9ih2ieKTdwFfZ+q9z4J4m3Lmmz2
         54Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=85J+aiA04EY/KMG60rW4VZXcI33pWG+C3OlEjBwYKSc=;
        fh=FWc0YcLhfajEgrDZPDl+Au4LuyTJkiV5qM5b6AB85KI=;
        b=kVP1tC9mSGamg9Tocyohj98c4MnBxoUoQ3wOmQ0FGt5bFdYZtMNeHtXkpEOBeq2CSc
         4GJ8EPYG0JUzkDQjH9/NEuy8NpqzOh/1Yd+kgAUhZu3xC818ij6453l20/fPftY79LRi
         XOd9vfNpd1kVU6hhDnvZY4uAkTNvJSjj6Dx3x/oRYRVTQ9HyxfLnYt8Nz8h7EAoMm7QS
         FlIu3kKlNC+05PB3oAjP05g91WajFqQmRvYQ4Ifoed9w/v/JE6+1i/0elTrRAoIrY8Lk
         xdQaD7P6+ijrILAeJU+s66h91tueNH2Pykq8NQNiu2MjisYPyNnmH/zCJbZbqecHlq6S
         4m7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789501663; x=1790106463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=85J+aiA04EY/KMG60rW4VZXcI33pWG+C3OlEjBwYKSc=;
        b=UKLj7tCs2icOB3pGYfcVmTbyedhZ38dcKCAe+A8NLDu/3RyYOW0ch4/HtKwGvfB0ES
         EExtPvUdIMq0tQDVaDYOrsxT5GRlxazsUM9JOwzwWApuKve4enW31/8EMg51qEUAAUoq
         6CeCLf4s00Mm8nGd7D4oSRlRtAGPJeT5mE7+6IBlKokeim+xP6rmSQTwUbxHsGJ1vFtD
         3HrNlfYURWiOQ+TJwe1i18iM8TOfHS3us3dfyM3xNvqB8fsMLDTlorsO/zxNFWJwyM03
         zZ+xINIL03k3MxWM+Q5kgvBaRUnStcgJ/FmTwo4ym860svP2MFAXMGLV0vj5dVQ2MLjB
         6CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789501663; x=1790106463;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=85J+aiA04EY/KMG60rW4VZXcI33pWG+C3OlEjBwYKSc=;
        b=J1+DQNvQcOEZwk08aBUxaSayrWVv2e0jhAgZdgYkCnmyG9GMOm1kUB6KthXTjGhsEb
         8u+0Dgg5ZOk3PEW/GhyfSNsrfvdz6dT3IiO+vnxe41nkOSK+ffe4Q1Pkc35z+nHQUlVc
         yL5LjNOMByjKR3HewO8TMV7D0sRjjD01r/5CS7ryYEUsRxoLVEtySxYLeCA1h6lo9ug0
         D4Li9t2mOnVGL0G/3s1r3/ER5ZV5m8Pg1bw/IeN2lhTs6WmlWtW4DIc1wCesvV+jiQek
         5xSzq6MXFVjgLzjMjgvMvfvx/4/Fv/AXOA+sNxyCz4DhIg/GKWJgt34kigrDWp0Wsl+G
         lnMg==
X-Forwarded-Encrypted: i=1; AKwUvBziVpOKOJ5XqEFSjpuqqNflG1/mO4ZmDGYFhdRP1488qGpZMyJ60TWaJlOr3Irnso9mi3OvPe/BzG/PGMoLZ2qv@vger.kernel.org
X-Gm-Message-State: AFuF++megH97SvrshTe6q2uatzl2D/ScIcRW3wXIccweF/ZSzWLznnOj
	XEisVF0U2rHZFTEPwtkm492MFLlqRkYMKYHuPW35dOIvJ+0QhMKARpu7/pzKMUc8nPO2DxFtAke
	xM29d+Ppdux+FEQmY3z1M0sfgpf7V3kz+M+4UCAUP
X-Gm-Gg: AYBFou0L5GfpgbUSsqzYgr+BzFwTkmVyKw/pohPli/aXaHVsgbbFNArR/XqYuymsIai
	+H9MrvD4Ef9cX02y5iuxxoyc86TfXmajuzYGlFiwm91oE7qAdmr7wP08Dkffg/mxDQAr5RzKw58
	5eO2Xyp1sK3yv5EhCkV+KycKQa5EV70WeDnE0BS2PXm6F93ugJt3HtgINKWvRtYFgmxT891/UFu
	t3/O+JvvZn6mth6wNoe8Rd2+P7v/3xMg28S74ozADOkRvGX1FoAhcxeG4l1i2GJVFjic5NFmyKv
	cjjcbF2NPhIzMw3DWZgMESutuEDO6qS5d35YeJ5qx/8ftQcrUcShwa3XbDN4VsrvvN04KnmfcXn
	gYncZ9N/gf58=
X-Received: by 2002:a05:622a:11c5:b0:531:129b:2dba with SMTP id
 d75a77b69052e-53259a9396dmr2409481cf.3.1789501657735; Tue, 15 Sep 2026
 12:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821125538.3721169-1-jremus@linux.ibm.com> <ba75c436-ae41-4754-8a73-80e2e5df76e7@linux.ibm.com>
In-Reply-To: <ba75c436-ae41-4754-8a73-80e2e5df76e7@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 12:47:25 -0700
X-Gm-Features: AcwNN1XUo01KXBIUBoyjPH1IxD3wuQZzmLQBC8pBcdAs-LnVLvB7_CmYe-5vPlQ
Message-ID: <CAP-5=fXGKJk6VrWTcdC8iUdhzw6djscJ8SBoJiBgFaPH8TWSZw@mail.gmail.com>
Subject: Re: [PATCH v2] perf evsel: Improve callchain warning for s390
To: Jens Remus <jremus@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 6:03=E2=80=AFAM Jens Remus <jremus@linux.ibm.com> w=
rote:
>
> On 8/21/2026 2:55 PM, Jens Remus wrote:
>
> > Instead, warn on s390 when callchain sampling is requested with an even=
t
> > provided by the CPUMSF hardware PMU, because that combination is not
> > supported.
>
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>
> > @@ -1078,9 +1078,8 @@ static void __evsel__config_callchain(struct evse=
l *evsel, const struct record_o
> >       bool function =3D evsel__is_function_event(evsel);
> >       struct perf_event_attr *attr =3D &evsel->core.attr;
> >
> > -     if (EM_HOST =3D=3D EM_S390 && param->record_mode =3D=3D CALLCHAIN=
_FP) {
> > -             pr_warning_once(
> > -                     "Framepointer unwinding lacks kernel support. Use=
 '--call-graph dwarf'\n");
> > +     if (EM_HOST =3D=3D EM_S390 && evsel->pmu && !perf_pmu__is_softwar=
e(evsel->pmu)) {
> > +             pr_warning_once("Cannot use hardware CPUMSF event with -g=
 and --call-graph.\n");
>
> Jan, Thomas, could you please do me a favor and test whether this works
> as expected on LPAR with CPUMSF?  Time was running out before I leave on
> vacation.

Thomas, the change looks good to me. What are your thoughts?

Thanks,
Ian

> >       }
> >
> >       evsel__set_sample_bit(evsel, CALLCHAIN);
> Thanks and regards,
> Jens
> --
> Jens Remus
> Linux on Z Development (D3303)
> jremus@de.ibm.com / jremus@linux.ibm.com
>
> IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsra=
ts: Wolfgang Wendt; Gesch=C3=A4ftsf=C3=BChrung: David Faller; Sitz der Gese=
llschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
> IBM Data Privacy Statement: https://www.ibm.com/privacy/
>
