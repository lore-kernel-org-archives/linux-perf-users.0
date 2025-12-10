Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB03B8D74
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765346559; cv=none; b=eIJP66C6vFNC6EJYsCvyCyDjgTdq8hWRuDowni2acZkPyoS86QAGU5zBwyGpCRKavQSNCT8MkEwjionzKq7n5DXsoiN+nKeUYQUAtAftnw60fuOT68Zu8pj1Jo5+CPjYBFo7pYXPthVQ89GhaDBqBBZNDKwkmNzWWWa36mD1J/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765346559; c=relaxed/simple;
	bh=SgFXacAvKFVtLd2DYPdHloJc6s1IxWNQQlwRgL3gBEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ci4tAoF//3Jaa43kouenx9c5YXzmX1N1v5zNLDq5Z1DUnoSakLgJOW5e+h3l3pr9vCKmqlUR/sqyrxN6zr6+f0hEFWwT1K2c+GM75Z0DZrXK6lIcnJEKt4X9Wx7xPlY5lr1SiiYq1oy06IRjYcogFLAF4UmzwlWxcd37hD7zcl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/KrOsRb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/KrOsRb"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e13bf404so138755ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 22:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765346557; x=1765951357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yPAageN2/5HQ12J7/UnWkO7lYApHtjIh4SZEdT+R70=;
        b=m/KrOsRbMSuJGV/oMW42Iu45TCV4cgrkiBHMkRoWV2tB0C7AetGnRBhy9fjOdwnGf1
         FK1aKlA7zB7fDjGiQooDi1YQbLBsos3HUG0RYSK9D7xNBRoIpc/HyENz6nqk5lN/bX8I
         G7+sILm5v8Zu59sTjA3iCoWqH1P4+4ULvxYdFTgAWyfdERjF6jVRrMKNJEjsLauR0yGj
         k3fM4jpr8QKNcwaKGfyc/AMu+GtP4mwN3O6zpe7v+QkfK5Z5J2M0li9JC3gyhoCjrjNX
         LcK85/8dMMGnqLkl9585HDQA2yIPkTLzThO7/P8G0dZ5X5Zrf9w3frAPRlXSnyI/A9MB
         qDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765346557; x=1765951357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yPAageN2/5HQ12J7/UnWkO7lYApHtjIh4SZEdT+R70=;
        b=SvrhFmeitFbNqvnDfDwSRj47AnGaO6GqbyafB0F3s2YLvNCYVV623NVBFXiC+SYw1j
         kKJrkSg9x1lAiFLF2ZoKeaextYolG0vWDh/uM6ZJEdGgsG6cLL8T3fQRdgbDgheOXnco
         5IsY9gROfpHLBSqurWnXWuA3k1W3sA6lOv9yknnAMxYN8w/n4us5/yDhwH9ap3Eu2gvQ
         vs2Vo/NZ3664byaQlZpmHLEHYg52u6Iw/+DQE5AJtMv2YVGRj1avwNqpHwaNWNb9neq7
         pjC9l95+VQCqxc3Wa/HqvAHDwdS5+W6ZVeKHOl2t9uHjxPUEVYn3CN5rsPuSGXedA+My
         ZsoA==
X-Forwarded-Encrypted: i=1; AJvYcCUNPet9sA6yVplZZ9eyisKDM8iAXpiPqwab0LaUwE9e5qWJil9rV2Kpy2otDOzIBmUPaLLakR+G1tBlfJSfav/H@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9OLTt0L26wZmBWhUY1QVo3b+90cCMQcPTbm/92ckuBOdZ94o
	ge1bCRiI77sAAkmt5b/QfftKi7IeC8WpoJIW67gDnUyVapiNGsP7jIjvQD/ViasSWwNhqZz2NzY
	LDgpMdxcTLA6Nx2uONLKXMRNpAGoGUhp28mfLNWeO
X-Gm-Gg: AY/fxX4Z14vMfhjgzWUoOjSVj79fqCi9d37SBLqRQilA4zM9fSyzOC85RYszWzK9Tbd
	V2P794bLwpvrKAcxiZyGVHNT2jz4fsCizw2CIOoqxlxbu8PeVXrwMotOun5NcNdXlIJ6yCWAKFp
	KdYZWaqaI2PH7Xxiq1gd1IJihiUZ3nYFJdAG46Nw+tR17pLRMie0R8cMxpgtxl7JCK84tVRIOSR
	PRFKz/PnJQ9msNqkx4juiHnZfcNOuj9lYGkeMfrVwDjq0nkksNdQptlPY5ZXm7beSCXSFVB
X-Google-Smtp-Source: AGHT+IHz23T4qNrwEjb65oJXbjaw9i5Qnh1R0diIvfy1mfJ0BuJ95/Yn4GT5xwRf7nxFLwLD+zIMwV7awKqtaNNyVEQ=
X-Received: by 2002:a17:902:da85:b0:299:c367:9e02 with SMTP id
 d9443c01a7336-29ec3dfe2abmr1523905ad.17.1765346557129; Tue, 09 Dec 2025
 22:02:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031162637.1456191-1-irogers@google.com> <a980f102-b468-4d55-abd6-885f02dc01e9@linux.ibm.com>
In-Reply-To: <a980f102-b468-4d55-abd6-885f02dc01e9@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Dec 2025 22:02:26 -0800
X-Gm-Features: AQt7F2oNqdLAK3p33bJwAGtoN4knCvXCxh7bjOtintvC-qXSV05WB0WviG2Jzi4
Message-ID: <CAP-5=fVqt_bUcqjiGArVuQFfFjn3duJZUye48_LCgLVa9iPdwA@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor power9 nest metrics: Correct unit from MB
 to MiB
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 9:39=E2=80=AFPM Madhavan Srinivasan <maddy@linux.ibm=
.com> wrote:
>
>
> On 10/31/25 9:56 PM, Ian Rogers wrote:
> > 6.1e-5 is very close to 1/16384, where 16384 is 2^14, i.e. a power of
> > 2. When units are in powers of 2 the IEC unit is MiB (mebibytes)
> > rather than MB (megabytes) where the values are powers of 10. This
> > patch corrects the unit for uniformity and because such units may be
> > pattern matched against.
>
>
> Changes looks fine to me.
>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> b/w  power10 metrics file could also have this fix I guess.

Thanks for the review! I don't see the same issue clearly on power10
as the ScaleUnits are different:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json?h=3Dper=
f-tools-next

Thanks!
Ian

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   .../perf/pmu-events/arch/powerpc/power9/nest_metrics.json | 8 ++++---=
-
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.jso=
n b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > index 7a5d1bf543f8..8d028a7c2777 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > @@ -29,25 +29,25 @@
> >       "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + ne=
st_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
> >       "MetricName" : "mcs01-read",
> >       "MetricGroup" : "memory-bandwidth",
> > -     "ScaleUnit": "6.1e-5MB"
> > +     "ScaleUnit": "6.1e-5MiB"
> >       },
> >       {
> >       "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + ne=
st_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
> >       "MetricName" : "mcs23-read",
> >       "MetricGroup" : "memory-bandwidth",
> > -     "ScaleUnit": "6.1e-5MB"
> > +     "ScaleUnit": "6.1e-5MiB"
> >       },
> >       {
> >       "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + ne=
st_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
> >       "MetricName" : "mcs01-write",
> >       "MetricGroup" : "memory-bandwidth",
> > -     "ScaleUnit": "6.1e-5MB"
> > +     "ScaleUnit": "6.1e-5MiB"
> >       },
> >       {
> >       "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + ne=
st_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
> >       "MetricName" : "mcs23-write",
> >       "MetricGroup" : "memory-bandwidth",
> > -     "ScaleUnit": "6.1e-5MB"
> > +     "ScaleUnit": "6.1e-5MiB"
> >       },
> >       {
> >       "MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
