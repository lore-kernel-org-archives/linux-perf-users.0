Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF526A1BA
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213923; cv=none; b=eyW5TXL03B1+sxgCg06PrtxjvVdeYUscNEDlMUiGur8m7tA03USZ3K/0NIBrql1BnOZHOvr/i1DHVr5gKSVkBeQ7b0hItA6s7QJXwCrgruatjN/FUAeCCi2LlqQbulxufDyYQH9vCUMpht8CGhl7e/BoboaIFSRJx2PfntFztm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213923; c=relaxed/simple;
	bh=ONPojdIjHrzChrGArc5TbNog7k3iE1RgJww1otzhUnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMG2ebtPyg0+wxr+Dvh6GzJaMcZnqqKB8cmn1ieB6MJhlZlDYAQofbagjE+oYTBnHM9jD7OG9qnDwDYJjxyJHOvn33otWhar9ihRKuhc4A83H8zhVfMqmzsemeB5ZoIfLWKd9OXlur9jTyOTUWeTqOVKQ5HtjN8jyvIIw9NK5Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3LfF4NoW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3LfF4NoW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242ac37caeso158505ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Apr 2025 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744213921; x=1744818721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONPojdIjHrzChrGArc5TbNog7k3iE1RgJww1otzhUnk=;
        b=3LfF4NoW2Hy8cr3Rc1O5iLYzjM0eigTqpxsQAJiAWNa3OJhinVkWKdLuVhObguAng6
         oA+ImSTo0C/Z39aNmrt/VUROMriGlV+vx5ekqc5hzCdjsIXQXHjqia6u1Xiv1DLACN1s
         7Wy6NAoZshDlBokLvKbI7JccehUQQ/Emayzpf5T5XQRXk9O+Nsg987rFJIqQ7CErmV9K
         FVNGO7Diu46aKNBME0wQdPA4DmlJ/1UKltePav7hZ63WA/oB6Kxcz6xyXkVARR/oToBG
         MMwtHi5R3TMDNZ6otKRd9JUYtyqHwo/8uXMbJ+ia6l7Uxz5t5n0veguYpPJmRdGSEfBr
         4Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213921; x=1744818721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONPojdIjHrzChrGArc5TbNog7k3iE1RgJww1otzhUnk=;
        b=mJkGqG4QMIh1wvidUowuknWR46YWYbuZcrNdYUzXNTdIexJJGThO4K/8rd594ZGLE1
         Jm1+djcnBUo41ukjVdFv/ecOCxJi5CrB8NjfaS/vnJUWl81Yr/K1E5BUeKb9NAwIv6Ia
         cO55jxedxeYQL0yBVTIsOSNyKoh/ge6j+NC0AMkQFpuYfJQypPQQjuwv6/d+NOQjR18y
         23mDoX2RcvtEc/W7UtVe5zFtp4mBLnRg0Ej54brKLDxul0VILK5YG3XCc4yxKZFNtU/B
         paJOLiwrMcHAmP4IpNEvGYlVtghI1wlKYuIRjBAw8lH6hM6R28+JSXWfWXB1wvG6UQWc
         kc6w==
X-Forwarded-Encrypted: i=1; AJvYcCXLqCBqI/Z0Gj74Iodtfu6jGkReyiHThGzUsTkUTOfIhXlBDRZ1F6ooVWPQ/jJBVkIEl+3OhL/oh968POS/Vge1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1S86mBqJxXFPV6HQqxRgMXgt+z5Xt5kil3I5CN5HzSpNADWOK
	dI4hpKYRgIqnOKwkFT0F2QCvXJtIcoTxw+KeW106uuGylUaqrV7Gmh4+4JcwnTNliwsrRe2elG9
	+O0tDSmAQu/iU+aJLwa7OUOILUbhIg0NmMfTu
X-Gm-Gg: ASbGncv13+0QIb6+qNkn/8kbU4LL220xGgIMS+bytXrDaq8nkT7E4J/NpIk7a4m7Dh8
	zI2gt5fcygCKY5MqxvPZDnnqWXWMGoBENXLI+BspYiNJE4Inh9jbmlX9D4PszFZFgz9HJ4+zgsX
	FMiT7oyUurJmv9cmareKtQPtm9Z4/4oZgEzOpgT7cOik1U/Js4tLA=
X-Google-Smtp-Source: AGHT+IF6yyCNdAKPOUGDf7tH/deR8OUSPsEKAyM/GcYg8ys3pJt4ve2skebZakAwf5x4d+dQfpAfsT+Mf6DXWvSfKCY=
X-Received: by 2002:a17:902:b214:b0:224:38a:bd39 with SMTP id
 d9443c01a7336-22ac3063e0bmr2794735ad.20.1744213920688; Wed, 09 Apr 2025
 08:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com> <20241106003007.2112584-2-ctshao@google.com>
 <Z32EFouwz3IHw8h0@x1> <CAP-5=fW+HDfNcpTkjPwSLezP-XTj9hkPLrwia_JryCr8+Ro0qA@mail.gmail.com>
In-Reply-To: <CAP-5=fW+HDfNcpTkjPwSLezP-XTj9hkPLrwia_JryCr8+Ro0qA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Apr 2025 08:51:49 -0700
X-Gm-Features: ATxdqUFVim2h_otrX1XHuXbZPAT-44lJl9Ivy2fN6qb4M_vCGdOa-UQaqWaalt4
Message-ID: <CAP-5=fVX2=iRumkAAUyeVoE-rveaYzUKokGB3g2H1ED4JK3Feg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 8:42=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Jan 7, 2025 at 11:44=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Nov 06, 2024 at 12:30:06AM +0000, Chun-Tse Shao wrote:
> > > It gives useful info on knowing which PMUs are reserved by this proce=
ss.
> > > Also add config which would be useful.
> > > Testing cycles:
> >
> > I applied the first patch in the series, that already helps, Peter, wha=
t
> > about this one for the kernel?
>
> Peter, did you have any input on this? I think this is simple value
> add with no real downside. I kind of wish the patch did more than just
> dumping type and config in fdinfo, but getting those two is a big
> start.

Ping.

Thanks,
Ian
