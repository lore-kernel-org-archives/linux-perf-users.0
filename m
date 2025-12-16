Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF623EA81
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765919047; cv=pass; b=rZkCemJs0/CGOj/yzmp3UnaV631IDdEo0egStntYtQ+0f3JxWPB3ReL56okvhVTTJo6qUSchumCNrsSbelpBgvNkHnb8DabEP6LgBkd90wvr/xp66YxQfI3RY395tAfwlizKWsciN92+uT577xrFUAxLV3Irkal/CpNsJzypSMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765919047; c=relaxed/simple;
	bh=PzrPZM6qHYHYvjxm6xJkcQiD7vOQBeqfzjWhZqFBAJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dogw8SoZOvc28/lhca8yE3zVjNUbCF+ebML0iUA5enWHv3eWnkNU6fEb7jnswxmk8NhERZwzhnfzzhRaXq2aCGOvtJYLFuRR50Bcco8lKo2WT6u3ukvF7qRrR7OXVvjy8shXngOaH41pjgYGUXvylfZ5wSIUyBFSd7FzL67eLnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a1IwHTF/; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1IwHTF/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a1462573caso44895ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 13:04:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765919045; cv=none;
        d=google.com; s=arc-20240605;
        b=CRgLqFBxj4wEWrMecRYXEiNqi0Rh5tqrNrlG48LVvZOMdUgVuBp7vfwbddFgyFYYjp
         blFvHSzyvPdAdhLG4nolmk3kSvBYQNEVRcpk3F+sBqSoLXxu6XMfA8OLEQ/zqBk1jNx9
         oYN1qsnRC0+bgPi18hjUTXuh9ZVDtfacH6vc29PRFs0MMYUKNETH4NS+vHolkT/sjNb+
         j+VCWUpBDCTaWDMvpSU0LsrjBtV9jHS3uU1ge3VkgRuH2KXEz/tMX3+FKFD8Zoe0mS1r
         Ipw6j/ZcSivMpVIE7Ls0hc3uUoGdxvKxdQtIoDq9rrl1Rp7CMGiuydIXfZxVevUXQeyr
         PCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JSPWTH5LvhyX27MDxiyB/vR3lpYpOwI1LKp0PW+a/sI=;
        fh=/c6bt1O7BJqoaqof3v8PMOgWjScWIE7RKRWItwFFJtc=;
        b=fBkt4g/+tWevNjq95W2KnLfA0OXV4msmi9jjcCSlYVwNuY92arZjFlOAevC5teqWq0
         vxz4BcOWssrH1rMZTuGzG98E/p3E1Ap5EBSqRBh+n0yZuW7uLi4zaRCTo+EeWrCHeF7S
         qz8ZRZdRRwPUScrGPqEXLK9L/5I+wtBcz73mekMlcKmAIn4QcsqVIGnJGHNVHWsDuUt/
         +Kaok0Ul7EOid17Ebh2pqX025y47IWVWvKihuzLFvDZkw9hJ3WTjR8GgBsnPzD47M0A4
         rKuPU4/lBiXrlMFTlsRZKUaMHxbdaoUYXZkJu2M23IryziVAEayQNhW1RjEUFM19ohiW
         iikQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765919045; x=1766523845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSPWTH5LvhyX27MDxiyB/vR3lpYpOwI1LKp0PW+a/sI=;
        b=a1IwHTF/fGBhcxS7WfU6AF2VHYKqSf3vOt/L7ycXWGJILPmr85op9X8G1JhLtX/4zz
         UYf+ifxXa9sC9O7Teiy1A595KnausaZYTxt/qu3ZoljG4FW2PnIju5zh50aRCEDyCsWb
         gF/1LAtN67BfPrGRFv0teK66B3BaJrnfxt590I4cnLYmP/e6CIsZz3deKLZ17yRUXg0D
         4RKoRdIVRfRhNzn0hhFe3MntOfRMxiKJK6e+Ohfmq3xA8X4PMk9sWvgH2KpmlTNEYyGF
         Cxvg+/qTdkcGEFo4rPdGxFBYQALS2Q11tGjxiNYOvV+DcCeyebR4wzE4M2HCLpU50TWw
         Y3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765919045; x=1766523845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JSPWTH5LvhyX27MDxiyB/vR3lpYpOwI1LKp0PW+a/sI=;
        b=QY/lhJ/2uW4Xev50LSBRt5bGwRKNDP31EhxxBi48TK3iBuYT2Ijr3dM2FIn3g9C6J9
         sxDFM+q+qUiPLv5z/Uwqdn5WMfVtuH+89Y9ZrGXbDGX0LGix/8Y0ezoe5Q2G/ujUM677
         fxjkZwmrE27x2YU+29WxNKUCoXOCWWR4Ldkj9PwZMctyDXPzzB+p9NIMPaa7hEk0I7g6
         IueWJUceeZwIEYtw4HIko+vYjBkmjOdVVQ8+5xkDUur+xAnRBbXjKfr+hr+lIpe2V2lc
         Kdp+cyi9rqTiSS9Uz5MYF2cDOx8JrmWPe90sgj7D3uvEhhLW9NzBdeEU4sC/+YAs67fL
         0P7A==
X-Forwarded-Encrypted: i=1; AJvYcCXOuJbySDEZzy+/gCoGChi9Zdrax/Smq6IiUN4Luy1PtEWPoybs9q8xNOHOOBjElVrULlhEPPazIMHVuxfinJOk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxob00+8asu5xmm8oRyiwbEhru1iM86/6J4sYhgF1RgmGfaKb5r
	woOWlemaQMI1vOSCMVn88aZVmM6MSnn2pabJdKYoVp6Zj/yCsxC3a/ipxWUBfQ0C90khCVkfPHi
	e45sdiMDt2KaEpnxOzxkFNih/fd/nmtlSGUSptSL7
X-Gm-Gg: AY/fxX4h11Ph0+f0sLe5cQkRCb2VBQEJROukZGUiZ0bBUDCz/YC/4Pj6qdF2LgyN7qp
	wLEsRKPblHNQ+zB19y8MyqoqpeLVrglyoap62BTB3OSkZjD0Sr/B6dhDiul3O0HORaRLy9u+rMI
	EajZeMEmLfDuEDGLDYJAA4r7ruH4b0qCsfJZgFUA3Tb4hIKKCa2y3scL0DT4+yX0ohTjAL9Uo55
	pmtH1tr5falCbsDZOzk5JdG2PlgXTdth4+oPbyDNdhusvtDBOAzGtwU5CBK2v454lR16O+LAA1K
	iUEmmPMDyovAFG7I7Hd4G9+gmQ==
X-Google-Smtp-Source: AGHT+IG5ELEF7AzQOZVlYy0IUuQ462eAR+/pa+XIzVeTo/fmvpwfzQavCHWTXXEeE4o0TNRdX8Ioon4m9vaF1JMTRnE=
X-Received: by 2002:a17:902:e80c:b0:29f:181c:1f0 with SMTP id
 d9443c01a7336-2a2060db3f5mr21095ad.11.1765919044535; Tue, 16 Dec 2025
 13:04:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212-perf_c2c_update_event-v1-0-29a26c7a949b@arm.com>
 <20251212-perf_c2c_update_event-v1-1-29a26c7a949b@arm.com> <6a642215-2834-4c27-b716-477d5444ad9c@linaro.org>
In-Reply-To: <6a642215-2834-4c27-b716-477d5444ad9c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Dec 2025 13:03:52 -0800
X-Gm-Features: AQt7F2rncr8NvM5nl7aWHc1gmXASdTJlpuNlkoAQFQxFwabBXixeogpD2unqQnc
Message-ID: <CAP-5=fWB7QxTvtEY6_9DBoQ23J471zvrRz+z6TYgNk3eJOWGRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf mem: Simplify Arm SPE event config
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 7:18=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 12/12/2025 14:44, Leo Yan wrote:
> > Since configuration fields default to zero, the zero assignments are
> > redundant, remove them.
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >   tools/perf/arch/arm64/util/mem-events.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/=
arm64/util/mem-events.c
> > index 9f8da7937255cc9b14c3c58a1119b40bd0c76f6b..eaf00e0609c6c1b7d939a02=
fe3794471d1ed119b 100644
> > --- a/tools/perf/arch/arm64/util/mem-events.c
> > +++ b/tools/perf/arch/arm64/util/mem-events.c
> > @@ -6,7 +6,7 @@
> >   #define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .event_name =3D s=
, .ldlat =3D l, .aux_event =3D a }
> >
> >   struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] =3D {
> > -     E("spe-load",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D0,min_latency=3D%u/",      NULL,   true,   0),
> > -     E("spe-store",  "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D0,s=
tore_filter=3D1/",                     NULL,   false,  0),
> > +     E("spe-load",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,m=
in_latency=3D%u/",     NULL,   true,   0),
> > +     E("spe-store",  "%s/ts_enable=3D1,pa_enable=3D1,store_filter=3D1/=
",                   NULL,   false,  0),
> >       E("spe-ldst",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D1,min_latency=3D%u/",      NULL,   true,   0),
> >   };
> >
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
