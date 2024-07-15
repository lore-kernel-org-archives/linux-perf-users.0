Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30013B791
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082321; cv=none; b=Hnma2ERmIpWPl2hRvZPt2A6ZgqzcSEQq/EyLdaP5fcBH4Fc11J29ckuDJRSm++UcSF6LhjOICbeAHOfxx9DcIxvPIKUI64AxPoD5Gr8lct42hPWOstGf9essIAZUkkgezjLlmd479sidZ9znkuItup4XV+6nZsnsadn+TbznDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082321; c=relaxed/simple;
	bh=VDosR8c7HVdHMUbSmYVlLvcmNQzOGgdXeW3Tav7KBzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5A5HLR4g9x9G7TaLh7wKFFhdeDUeQxIZ8u+Bjee7Tt1wxL0cHWeMvedc0CP7lmi51BzY5J80BLEdznl2WbJ5+xflCXXHA6yiOJXG6CwxHfMmLLhP1ZVU32JMNesLFGw0xxsrGBXzWnQb9okUkXmJVSBOjPrUHBJuWjUJulwcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pn3j2b9z; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pn3j2b9z"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-447df43324fso62211cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721082317; x=1721687117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDosR8c7HVdHMUbSmYVlLvcmNQzOGgdXeW3Tav7KBzk=;
        b=pn3j2b9zi3XTrM02C7ReXE7sV/qPEgq4U+xAa8SxqmK+SATpL398jkwaBUUR1N00cR
         6A2rJAmqPZEpYkhtu+2rVG+uMtU2KuQdaA4xas+GJ9P2pe1iYOdooG+G/n3abRbEzXLM
         0LX4op730olIqcD+8Uy43xXTI9Iqq8bWc05tbPEA6R0O7Cl2mp/bmnXfFBVVBv0am7vG
         +CSHXgtxcos3mlf7udAeE4/dBj5GlcUsDoVSKAxKLD/J9v4IpEJZMCzkSniiM5puElCB
         Yy5iDJOSfZUF5JMYh3GjxiO5bOinUY0y65u2BL4ITYysQLLoA0j1RqrqSfD5QYB3s/xU
         NS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082317; x=1721687117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDosR8c7HVdHMUbSmYVlLvcmNQzOGgdXeW3Tav7KBzk=;
        b=M1Ipo0zVJ/oG4xHuZvjh95LD8Mer/oC2rGsGAPVMe0XK62M/EOHu4lwXU+sqvO4P2K
         1f4VKK678eRHdpUbVwftMpsW7GTCUlU76jLltrwcAKwaSW0G78KzocJkKHtzRtOgFQ1l
         VRQE5blbImpws78CmsN+0bCah4AM7xjf8pqPZwuyMs/1mVO0CQFYkPnHkq/2khcW/biH
         j4spe1cG255Yo5s9j8El1CSIupYO3L2XOXSkQJOY9PdBDqB5g1I8eI9XWErFJVJJruff
         DASHMn8R+1c17lJNXi+R3QhKQATH7j5c5viKqRKF1o6/MjPQEvtIJzE+IQlMMmcQn/IL
         tn+A==
X-Forwarded-Encrypted: i=1; AJvYcCWIJzh6g+ovNPPWAJUpBtkVADUhzWClWxi08twzyYuAZaUA3jMqjQqrXWO8+CZgFZqEsBajxJIof+P/ACk1PwBxM1vpOaBftV4AVILOJM7Wnw==
X-Gm-Message-State: AOJu0Yzc3MW68Kn/p+2cUvSUK06ucdlVhioHx6bPNXY6ufltEs1uTdPv
	00G9EE4jrFBhxoTzN4VGMWATZ4FHO+iqwI11SMR2PtIgqhCk/9GHFemnbs2S2tQ4JFG8uOrIV+s
	G8qjv5rLKmkZFrn9hrMH1dqUDkMQuBAb5wNKc
X-Google-Smtp-Source: AGHT+IHYyLx5NZMwuMuZh1Z+E4Fk+g7KzT9Wi9MbqWX8yuGKTcGdIruyD9WKu8v1r6Koq/eGYelxM2+D839RrwOyfs4=
X-Received: by 2002:a05:622a:5907:b0:446:64ad:ee91 with SMTP id
 d75a77b69052e-44f7a7425c9mr1258371cf.20.1721082317051; Mon, 15 Jul 2024
 15:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522204254.1841420-1-weilin.wang@intel.com> <CAP-5=fUtp_vd=EeeesXPR=nsm0VOZoyXico=EVWobOEYsxq27g@mail.gmail.com>
In-Reply-To: <CAP-5=fUtp_vd=EeeesXPR=nsm0VOZoyXico=EVWobOEYsxq27g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 15:25:05 -0700
Message-ID: <CAP-5=fXOTmMyPx_tQPoCfCP35E1o6YSyZde58ojyU1PLJBt96A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] perf test: make metric validation test return
 early when there is no metric supported on the test system
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, weilin.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 6:26=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, May 22, 2024 at 1:43=E2=80=AFPM <weilin.wang@intel.com> wrote:
> >
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > Add a check to return the metric validation test early when perf list m=
etric
> > does not output any metric. This would happen when NO_JEVENTS=3D1 is se=
t or in a
> > system that there is no metric supported.
> >
> >
> > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
>
> Tested-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian
