Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E761A0732
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Sep 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118097; cv=none; b=NGqDYEb5hi7zrFxL6oG1DhF+TNaql5yOI+PbwiOvy93yS36Fm1xDPay0Q334zfdkJ7vD4mQD1sjMjiptmQdocPHCxmIjRZ0RbstOiv5i0xM135IqRmRnBVBZ/qx080ivfu1sNhHiJYTG1//ba2f7+sNNQk4HxdKEj+yNz+8WSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118097; c=relaxed/simple;
	bh=B2/RdoQY7Z+itgFh54Q2SY1jX2NKjIOcuSFCkqrM77Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbmOcnaxPIUWfVFge5nNliR8ghcyGSjgsL9FtkpDcQ8OFGbwazbb+TI4FRn/ZFZaF04FmUm+mQtM92xOGrYUqLHJDzh9yMAOxVj/og/G1CM3Fm0wWWZYNAJTGd1IC8KafbikGqaJumEQMHt5YdJ4gImL/OWLi5JaK0mj2F5ee9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LW7z0icO; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW7z0icO"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a045f08fd6so34295ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Sep 2024 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727118095; x=1727722895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2/RdoQY7Z+itgFh54Q2SY1jX2NKjIOcuSFCkqrM77Q=;
        b=LW7z0icOR/s79/JT8GtLorCOkZrDtJREIUV/l+1NBxpwZy75MMslTL/sUW0dbVJZKs
         09a6IQEyM8fbhYq0gmp/XcGn8XWxxxPdmfxD9uhuAnW/lNpeLVdLY3OcdRsn5psA8qRo
         oJP4AHbIcgrNwlZUqF7YK7D0lQHof8B/I4Q0In/uO4krnOptB8Qg/mCxoQl1zNUvfLaW
         E0QwF/5V/0oUXDIMewFQp/ITBf7V8G1ezbyE8YIxd/4zulz34sRGXGRUxJ7UNoIvAWpy
         MsTttmOx1pcsrimAMm2n/BkjFLdWub9CS4/wIR2cYWSQxSTv4ooa0SWsLPWZuhHeo8jV
         foFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727118095; x=1727722895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2/RdoQY7Z+itgFh54Q2SY1jX2NKjIOcuSFCkqrM77Q=;
        b=sAjJJOwgAEOzHmK41IX1oUAerHLtkcTG1dVzn907BNlPpgg/WB9k9Gq3LVtYJfDDts
         j1anb07KLy4ad2dgAlp8gyLGHPNEtM8yee2GmCtB2MjEH1gVNOKfLdxFZKWOoeUdZW7M
         sQQiBqcwzDlFjP+ThYXdJ5kq4IDf9OFpxE36MjCwPqlqVvzQVvUNtLE9YoBXcZVW9tgo
         40wCKtT5BQi/FbpUqrMdF6et84D6srzOPzmT/JRl+6ojhYyKaOnthd035L/oMWPI6gLq
         Skz6td98/LZ/l0OR9CHXjpcheQUEw2d8TLxIuFnJgaopDGP4Futm0c2HBeQpC9wQElJp
         X9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU2CthcS/EtnKB0zqghgItJj40b+JYkcsIPS33eLEra5zHwSmMmPuCxPliF4C7BTSouGJrPSfOk9OGKyBH7mATO@vger.kernel.org
X-Gm-Message-State: AOJu0YxefPt+hkR6issTu+byQQ45qPaZdZ6iKhK4vhpjRb5VaeXj22kY
	EplGcy1bY4ahQvW9mow7zTFgqdK/7BOeBjsI0GbR2DjYEWUYkRzaymMXVcQ0F3MDI9NV+k4HGOR
	AdqoUX2y2XRUatUDg+2/BoJz46pT8DGhyCY8Z/wucE+UTYqhNPA==
X-Google-Smtp-Source: AGHT+IH1FtFv+Bh0wXozJpze+D8RaKOIbhKzlrUVEuEq8laEBjkD4NrTvtVKpkKT2+iv2IaNbUKmVFnSsUXY7lNl6U8=
X-Received: by 2002:a05:6e02:1fea:b0:398:fc12:d70f with SMTP id
 e9e14a558f8ab-3a1a3e54f5bmr624195ab.0.1727118094854; Mon, 23 Sep 2024
 12:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912182757.762369-1-irogers@google.com> <ZuM9zc71XXXZ3eRZ@x1> <CAP-5=fUCVa3VoByKUFDp8Q+M2ZOTdy7ccL7Ter8E8dSE368KAA@mail.gmail.com>
In-Reply-To: <CAP-5=fUCVa3VoByKUFDp8Q+M2ZOTdy7ccL7Ter8E8dSE368KAA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Sep 2024 12:01:23 -0700
Message-ID: <CAP-5=fX9FO70B2Z4jp50owX-Lr3sAuECje+0s13tc9C9s1v+jw@mail.gmail.com>
Subject: Re: [PATCH v1] perf vdso: Missed put on 32-bit dsos
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 12:31=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Sep 12, 2024 at 12:15=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Thu, Sep 12, 2024 at 11:27:57AM -0700, Ian Rogers wrote:
> > > If the dso type doesn't match then NULL is returned but the dso shoul=
d
> > > be put first.
> >
> > I guess we can add:
> >
> > Fixes: f649ed80f3cabbf1 ("perf dsos: Tidy reference counting and lockin=
g")
> >
> > ?
>
> Yep, that's the one that added the reference count increment.

Noticed this isn't in the tree yet, do I need to resend for the fixes tag?

Thanks,
Ian
