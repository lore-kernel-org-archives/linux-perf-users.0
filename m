Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FA2BAFC
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447337; cv=none; b=ErV5ogc4VtMrjBDa7UOljIRZZxS/r2XeAQNk1In1XqM/DM03ZNflJAN7ToJpoDo1yMWH/efRPTt+VXQL7laPFIQNbA5jGxpJAsM1OIK3IU75tXzlXz7JRV37HDVqNyyy/AXbVXZ8thg0Ekzgl3VZjyqhGfOd2vKwRkteG1yZq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447337; c=relaxed/simple;
	bh=1Adio7d5YNSo8BdMKncTRyiP/Rne5Bb1BX0RdDp07bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTIDJ/EgXQhL+wJqy9Ibz6pXxrJ4SHqB2YEoPgwkyoRsOJ7qNCLrQuSS5fh7P1LaUYOMaaRHkWUsFimow49qjOA+GkNC8YCcGHkDlJDHalTv3vuTFFIyjBUy12TlMqOpJDSxlej2ZlPTFz2Y+1dBqLia+L/1PSk7lxTaxGOchiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3rctPcJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3rctPcJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc4aff530dso265345ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722447335; x=1723052135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Adio7d5YNSo8BdMKncTRyiP/Rne5Bb1BX0RdDp07bE=;
        b=L3rctPcJvebNOsP2rnicOjTHNtjSVSKVzYO4GUMUI2ipPFaFeIIrUPY3VP+3t/PfZQ
         smqlgJi6jiKhEmqPiQq1fHeKvey3kJObTknaYU9DPmcFWHnOK/HYe0lrCkJbZklph1HG
         itF6VsuzA2LMRCuvLru7ZgfW31THDe4ZZuzRs8UCyrwoU5Z/EjWF8VsCbh/Py1JFpGVl
         vcE4Meuy+Rm+sypHkxiYsOGU5GDM+pOGHp4Wwzhg969oWkelSoiN0JdiQguj+VRwtLh5
         giYwrhzX25vKZEHYKWzbD7G4bF6F+nNMEevxhfGSvsPu/aiOiJ8gbY4FqiLe9evHmdj5
         xQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722447335; x=1723052135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Adio7d5YNSo8BdMKncTRyiP/Rne5Bb1BX0RdDp07bE=;
        b=l2yHozfHae1Ll1j1kQpWdw/dTjYWca5wAlpOYLYWNEEx3kl5ua1yULeaCfZlXIFhBy
         zkjLJDLyDbmJQNLCvNXvhLvSF0xFxnrrAMBt8Wi0WctjwZ3V2GTnbfiBU8l4Fn8jXb1d
         MAkVpOprqR10czqcoCbu5osZXJsyczhMPs9m5zpXTbO64XTCPfC+5cjaGlbGk31UqcJs
         +ZbC+E+pp8cOg7+050LgvoY/kU0k1I08SH8RiHcy5nRO9bHPBkdKD/VAIt1IveqJwxj8
         9rS1Ll8a5ubKV1xNPwjl/BgtKBNGE+gm9bvzu6B24Di1uOhUql45AJNly5E6hF6BR05V
         kwJA==
X-Forwarded-Encrypted: i=1; AJvYcCVe94fis/1iPy1v93iXqbwD200eBGuSr28DDlwecGsd3RkttUdKsSSOHhnQOvKB7hay53RRtbMG8b/0paCRCeHYzPQj1Mk75B25QY5dHfGZ5g==
X-Gm-Message-State: AOJu0YzlmIDQt5Bv7gxwcn67eeH3Rvr/evdHcquT6AA8SaYwnrrH4qw9
	jPecJXiks2h2EMkp7wTqSHuiVio1u+o9XuvrbJ3L2aJDCTe0KDINAWdKuZ7J2eGt7klmvP1p3E4
	iMQQUWuuvdG1XlcoTeWJHJaucOF7972CMBqL2
X-Google-Smtp-Source: AGHT+IHNitekAJ5MMyaYnF+S2tfRTPUWTapFnl0EhNMc/agVj9zLyzKYcbU7AmjArLiWAP69FyKpxjRK1bsaoD9GK8I=
X-Received: by 2002:a17:903:110f:b0:1fd:d0c0:1a69 with SMTP id
 d9443c01a7336-1ff4263d6femr3384785ad.9.1722447334607; Wed, 31 Jul 2024
 10:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZqpUSKPxMwaQKORr@x1> <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>
In-Reply-To: <CAM9d7cgTrDEdAn=dv9ciRZfpMdYwdmDrAAvsYEYE=GssPS_aWw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 10:35:12 -0700
Message-ID: <CAP-5=fXX5RUgoXR2v4YPYQWJi=A1LejJ-MfhKqe+es+SR3WyyQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bpf: Move BPF disassembly routines to separate
 file to avoid clash with capstone bpf headers
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: Song Liu <song@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:08=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Jul 31, 2024 at 8:12=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
[snip]
> > +perf-util-y +=3D disasm_bpf.o
>
> I think this can be gated by LIBBFD and LIBBPF config, but not sure
> it can express the both requirements easily.

Should we gate things on libbfd? Given we can't distribute a binary
linked against it, I support deleting all libbfd support. Fixes like
this show the pain in carrying it.

Thanks,
Ian
