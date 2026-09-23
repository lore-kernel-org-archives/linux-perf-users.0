Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D73D9548
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198227; cv=pass; b=VT3be3Ed0jmdNJ9flacZQPERdpdGtSQkIzMYzed4A3ac4a/5KMAmCsoSSQsYOR1SQt7Udb+z1EoZNNuQlVXY5rgpAgrmJMcLYhDQR1eODUydIF0JPjH0wZiSlvfKaWpl4qbaXMRE+Eebn2rQU/fizlEHlVAH/kSzrI5iI9eP/5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198227; c=relaxed/simple;
	bh=C5HdZMd3V/zpNuhFOrkwdljn7AwYQiF19c8FeGsvyvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuZb7OHKeZJcVNhYqzPWw4ZAzOqBxRk2j4GeClxf5EKak+4hmgbmiEDdmBmV/ImPX8AVUai96dtCQSKGVC+uzwP9sy1ItYfAR7aBLmi9NymOYEdUk6NxRvi4q9+257dTp6Vwobw0O9ZtDLNnIRVXtRW7xYhAi64jPjNlvpxI+k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lwg3Xy5l; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lwg3Xy5l"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52faa58bff5so30241cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 14:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790198223; cv=none;
        d=google.com; s=arc-20260327;
        b=gzqPbx6KVSuPM3yaNmeWx/ooJEHYbgQl/ZZFqHMafAiLY/hY6aC12qdiF3oGOwmn3G
         714a+7Z6JxHswcHNVAxH/jGEvYwEzt3/83qxXZkJJM/osT9QAkC4bBbPdHZ/etRhGwaA
         8wwPGLHGRB8/vKKkNjXItwcN1gW6yteiHSJKSLk3rd78TOZv4srArIBX8BOyrAmNnKTX
         C33Vn2Lewi4SueXlhqxP4004ndBfYX3RKRCSiaRuc1cEk/irCmttQ34h11R9CdkyDYbV
         5QVWl+ILwoG1yF/rP8hEBJzIEHvj5ThrnYVGDFzQyz+ZCrPC9Simd87dRtEmhRYc1wEE
         uotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C5HdZMd3V/zpNuhFOrkwdljn7AwYQiF19c8FeGsvyvw=;
        fh=VbuqZEgrNayF7yHlefmgRinyjetJ81XMZ1Ss9zNeeFM=;
        b=ZUbFXXg79bdZhq+308I4oCWdNYGZx4A/+d/GYjIyK7U2KOpzBDE63gU+E2hUyC4ytd
         0+sF8tK6wjN/cBzWYH4NaTjHJdn70gQ6U6xGFHbXAEIENCZD5uA+SZLHf60TVAxVAu3Q
         MU31G0oSPsubFp8iNn7KIttWNYkMh4dDvaAvDkkTu/sKHDQG+ASf1LCJPcY4cA+4bk9z
         wkSx5YP0c1780EHbZ5vfgVo1Mdid/ANnr+0eO+GIhzFLw2taXNNu28weMx1XIbH2SRna
         AvbNb2Ss84FEsf7kSemOhDeIxPCH4kn2vu6TLBexGbpt9W2Syw4PqajbMv9HQ9+DBOi7
         VWCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790198223; x=1790803023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5HdZMd3V/zpNuhFOrkwdljn7AwYQiF19c8FeGsvyvw=;
        b=Lwg3Xy5lYMDf90jqn3ho9Cam0aqsJDBQACJYsyoKflvSObThj1DoiY/uZgx9SNYj+4
         YIODlNKf9WQJFgL0PAjRd8AswuDTSD6xxP96FIJzfSN4Rtbx7b3uFYsF4mtwI2NC62eV
         LatlIWM3bxugwqGH2aUgkqvIcxHyVj8ylNeBb/EAZV5PzLOJLkPQAjO55OyRRpJYBg0C
         FlpEfNZaZQwfP4uzyUPqKQlFvsue5GRrjYPqneT73mooODy+NgbE1+Wf3UF/ult/Bvfs
         066QfO/a40z0pz5D4KFkmPrumHvyacTwi7YqKW1K1VYT2Dz0es47IBXazjVacuUAdbur
         IfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790198223; x=1790803023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5HdZMd3V/zpNuhFOrkwdljn7AwYQiF19c8FeGsvyvw=;
        b=rHE66aRHgX97NUcoSyktPiBMZffeeOUiID4kZlsKKkzu002sBs16reLVDJfRhZ/CpR
         VWjhTnezCP/MGFI59hf5hSXUQSf0ySNCCX43Iks8EsG0O7S/mNo9Y3M1LFI+sWzZkRxW
         job4tKJvO71iuVlUrM558LJFYpU1CMOcn2M1xLU956W54J+NJVsw1X4I3wKYve6kXywG
         Wvng/3YvVOCpNmLtKfjezdixgrTjivY831LyEb7cdRKq8YnXsJ30xPPSo/g2VZz7uxLx
         ohCqMquwDmcye+tfoN7xkXOldNrgr/+UzCZ7gne9mCnhlWZaLSPrcxz6pV5EWLkyAJ4V
         fR7A==
X-Forwarded-Encrypted: i=1; AKwUvByINY76CWJ86xNSrszvifqPSDeqUpIkNGjDZR8ieHONXCcpK1VInhkRt6VbOIoKnDfJLiDFWipOgATs0t73/ril@vger.kernel.org
X-Gm-Message-State: AFuF++lkcCHGrpXVUZjeWAzoDqSlh67Qu92xyYAm9AGzHgzkKmA7ex7U
	90NVxtRk4ONACH0VNZS7N2LS8uJiBHHrRqgem8xVeCtKUIP6ZiTwuE7LEQ1PTAJ+kMzrBvYJGjn
	AweDsTRIAXQYCye4SaBBW648iB45RabvIAdyW0fIL
X-Gm-Gg: AYBFou1BLe3l3of7KxtPtGCSYwpCxTCJuavzR8LA+65JsCZFlnEDFiDK3mv47sjAm8j
	Tse+0e8h/9RKL5itVSmFTOjDSGrRuWbylkahuN7eK6Xz0ASp5IET8jr4/y0+uoMtta0q95uP7g/
	DpgmX5+EVEeQWDC1CPDwO5SRsirPVx9ZENADWDf96kQgvd+IsXs1KvMZ4YiDmhgROij9mAsTCnh
	eT/eYgEqowx/aQIRPo2URD+LmiSNwTpnedVILi6NzXVFxTUidg8x19pfmDVrPomNtVPh614Hwhj
	sz0vaexCrsvQ9BUirtBp0pA898A8DEafQn7+sOadG2RbmwmkxMPFW4viFeIdDhkV1ZUvJjvtUYm
	+OnMbNNoEjw==
X-Received: by 2002:a05:622a:2ca:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-532f900c602mr5083471cf.14.1790198222132; Wed, 23 Sep 2026
 14:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923090429.2026529-1-stian@itx.no> <CAP-5=fW4bzmy5_6a-8YucOy7JGKg+izRbq+7TaOGKV5aG0oYcw@mail.gmail.com>
 <4927bb40f34ec6d3d5591dabba755452bd6b4a39.camel@itx.no>
In-Reply-To: <4927bb40f34ec6d3d5591dabba755452bd6b4a39.camel@itx.no>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 14:16:49 -0700
X-Gm-Features: AclHuK9pZsA8iY-d7bWNHMtUz0MouzhE42jjiSTkxy86JSYE5mHT9HB5K2xVHh8
Message-ID: <CAP-5=fWhk8Z22+PhFKbatO6fYgiNBgLGwVgg_NxS8fg=uEdDUw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/3] perf: sparc64 user regs and stack dump, with
 arch hooks
To: Stian Halseth <stian@itx.no>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Magnus Lindholm <linmag7@gmail.com>, 
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 1:57=E2=80=AFPM Stian Halseth <stian@itx.no> wrote:
>
> Hi Ian,
>
> On Wed, 2026-09-23 at 13:38 -0700, Ian Rogers wrote:
> >
> >
> > For the series:
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
>
> Since this series is still marked RFC, should I resend it as a regular
> PATCH v4 with your Reviewed-by, or wait for additional maintainer
> feedback?
>
> And thank you so much for the reviews!

I think we have everything we need but the kernel changes are really
up to Peter and Ingo, and the tool changes are up to Arnaldo and
Namhyung.

Thanks,
Ian

> Stian
