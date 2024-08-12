Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C96184522
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477100; cv=none; b=de/C1Fz19xcdAiBHC95wrucj51ho2e2t79ZnKQ4ct6TQAS0uw/TgbRRaBC14p7F5RkoJwyLqNEqLe9YTRQgVYvQL3XyIdtDMo8bDAJ1gri6D0l2sike9g2I2EWUHhiNQ3m06ZKc+T12xNffS5lPL1TM46HUt2Xn2229phtzlUiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477100; c=relaxed/simple;
	bh=fovMrnD9gDJAqpq2rBZeirL5Ie5rNowYy/qO5wGZ5wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEiEhAT6n6e8kIJeZXAaFna4cWMp26ShKh+2FUmgRBBQ8jpx1MzDPTvbCuHRut7h+nJAKj1j4EoPmPh8Ya6DaI6FrOXtGbVMarQXnYZmXqWoUzgKn1v5ft9tk15Vjwlu0DwQRFMrenbUlznWZ3mC11W1WygMLumvekJhECX/r4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYk0p+yU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYk0p+yU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fed726aefcso291935ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723477099; x=1724081899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fovMrnD9gDJAqpq2rBZeirL5Ie5rNowYy/qO5wGZ5wQ=;
        b=TYk0p+yUL35MHa5EJPe+iKRiAsVVVeAIQP5C4YdSXtZwNrHksOaiiwIeLUWjJPrz47
         Zuirtoabb21W1owuBWsPJhrcpt5VfIqK3Smmn6i4knroYoYDOEpj3hteOrxPCABq9tya
         8ZlAh3aYK5Wuh8p5BZP2phsQqVuee+wXSHg0jhvq55lrt82y76dxq0rjZrEU7MyCb9YO
         oPnnZ+zf3kVYqKAnV+wbh1QRTAG9SA3huyUErxKbchTmfjZl/oKGlMSzzhKtDzenYhg4
         57PLxWTi+DaRYd4JhAyE0DDZ6l/vZ4UDjNl8pqvwyDMsGAsqSBjA+u2mQM/mGoxaYVwG
         o7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477099; x=1724081899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fovMrnD9gDJAqpq2rBZeirL5Ie5rNowYy/qO5wGZ5wQ=;
        b=mWFipfnsp/TF9OWEV+mJO8t2oMlAhPcDeaS/75MgKeBMrscL+bGc11PybreFtdF2ns
         rimsAKTMjVZLN6PMpMu5Pqr6diQIGdr1SleibjBvEIfhl3QW0zItQmBOX27oSbfow7ja
         PV9NrJDleg8HoX/IRPuXVbRIeF7n8U/nff53sO7JYaidrVDg6jiYY7JvXt6UtGwRcAuD
         5VwxT6g7amuuEOYqw4m0JEk6699v89iEDL8h3gKBtKic5VJSq4TuF2qz0NF7eQIIV+nU
         +WMXz1H8ZbkZ8UlkCvv/z0Zw/cSlBgsf7jQFgN5XzYo8hokKB6Srvepmj1fuMPqSbAde
         0KBg==
X-Forwarded-Encrypted: i=1; AJvYcCUJQg5HZx/6pDcalYoRHKDZZR3sLFoTS+ple07rsKe0LZUqZPy+RkiiypimzqAXK0DmsksJTpYHZFY36KrCCHOqFVoEwVTusyQ/oHJxqJqirQ==
X-Gm-Message-State: AOJu0YwzM0J2DbfSNv2TnsbXGvv7GfwkSKGhWW9FoLpNmP+blUopin8P
	A8ZR9W1HrprhyYfehMlkmD6+sxFrso5cgtZ7uuJ2o+Hj5UmbZnk+CFsn5yXP6siAyhBozfLkCuv
	wyAFXIo/gLjjQNdJhF7Ccw8pnXxEpRNer4F7t
X-Google-Smtp-Source: AGHT+IG97BRuEEX7J48w7ngQNipoppQKhKZdtlslt6rnfBm8NKOyyNVNUALmqitFj7qXIxa+CCCelcOZ+lqurZlacT4=
X-Received: by 2002:a17:902:ecc4:b0:1fa:cd15:985e with SMTP id
 d9443c01a7336-200bbb57eb7mr4865115ad.6.1723477098446; Mon, 12 Aug 2024
 08:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <CAM9d7cgoTyf3Zjt=+2yZi5Pat4UrxKxN=rkLHmyUWZqwZk8_Kw@mail.gmail.com>
 <CAP-5=fWr2Qna9ikzUCFavo3OTUDSP3ztr=i6E=R962CXCdHckg@mail.gmail.com>
 <ZrEpJxtm5zlp5rbo@x1> <CAP-5=fVTaHdiF8G2Dn=vnguvoapa_+ZKsQ7Wy3z51K9nDZQUtg@mail.gmail.com>
 <ZrIl8NCHkIVHQVt2@x1> <CAP-5=fUVcBw4GBT8tcOWS1MV1C6zbfbovon1pCqk7gmfMN=J_Q@mail.gmail.com>
In-Reply-To: <CAP-5=fUVcBw4GBT8tcOWS1MV1C6zbfbovon1pCqk7gmfMN=J_Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Aug 2024 08:38:06 -0700
Message-ID: <CAP-5=fXtDeddhfB8UQcjSAoWPSMo=ve1Xfr2-2K7L1LsMOQenQ@mail.gmail.com>
Subject: Re: [RFC PATCH v18 0/8] TPEBS counting mode support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, weilin.wang@intel.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:35=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
> On Tue, Aug 6, 2024 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@ker=
nel.org> wrote:
> > For now I'm removing the whole series from perf-tools-next.
>
> Ugh.

Hi, what's the plan here? The topdown (aka TMA) metrics on recent
Intel CPUs (client and server) are dependent on timed PEBS. I think we
should land this series and move forward from there.

Thanks,
Ian
