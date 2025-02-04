Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB31FAC5C
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707818; cv=none; b=RHBZ8QedDmpsGQFVOr+VMhIDvuOodSMexXksR56yBgz0puQ/CbUvJ8iQ86Z2zV1ea/r/EmDKuGg+5Tx63udE0+R+8DLmRMHBMjxxPqq1mZxJOPBDRebJokm7laK54mbsatTIMbteEVK2rRsE80eMdSiNmCqAsAkgUB6v/1+evKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707818; c=relaxed/simple;
	bh=NL+88Ui5xhbUBhQW26o2YlcV12I+N2LlNIyfy3OECHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nKtcihOXkGDvTs8mtd52OKalORTJ29j2UgjLFVPx8GjGX4vazG+XF21jGDpAZ7wsSqZVrW3LfSCwo0/HusHbsY/ZGZfhuyixtZxsusJkBY+3waBuahA/Sy+f0rZvpJq2Qrcof+6NVpK7NJ0EvXl9aEmasXf2vTd231nZcwdHDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V0AoCC88; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0AoCC88"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so170335ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 14:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738707816; x=1739312616; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NL+88Ui5xhbUBhQW26o2YlcV12I+N2LlNIyfy3OECHM=;
        b=V0AoCC880+nd1NCKRsOmMaA1DX0lXUAvEL/WaeBt13pJE9JpeqYqEbnO7dTQeNCe3z
         T5jBn6i1jLvOO0ncKyYJMR+H2pGyBnvslST+3NjDZ+q4EXsSj0BA2IUPI+fOkccuLq9a
         w5SA9mnDADPEY8lDbBGcCjsG3cO9naw4gk9HDlokOd+Z18XTalMZ44f0o+sP4P4n46JE
         65roqge1BC3tH2WI/ncsz61/6dR0kGqyCa/bEtJuMhB3yyw1q64awVRUfxm8XQe3nBTv
         VqMo1vmAH/5gc6ZzRXcDBMFJBp0zu/r3olOW82TKSJzZIRp9D7Jo/m4adlmt3QAMYdk7
         1APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738707816; x=1739312616;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NL+88Ui5xhbUBhQW26o2YlcV12I+N2LlNIyfy3OECHM=;
        b=r5yyqljvA/AG0RD/X2NGcRbF+KqyVjcauvyZAl/X9XuTNmKm6+jKDUEHQLvZgYvM2C
         +SvHM5410Ih6SercLQgE4DPyfv/PzVYPjW8EGRsijNU0ZsGaItzE1TUkzCYybPCBVlk8
         8DAb4yZG5lJT7R73eel59YeoCfQMrTb/lYkfSzPdi9Bl8vqm+Ro2+tX6hl4BBh8N7hj/
         4FV/SO/+YNFHTJwJiQEDFPpOjvnfEpdSmSvUSMzX55rFSc0Z2m2XqUSFez/SEO96sblf
         HNw7iPtJ+w9IoGt0PrSqN/9wxTBtIVqmcOo9o1kGhwGznQaH3tWbwwpaT7Dtd1dxkzOv
         PhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw+74IuJ6itFQjXIMoBh18ehqM42akERRWeD+75XlzQmXRaVMX1VvhblJHF03nQ5dxFyhcNnfwxSwbUipyPjqP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0X7Ma5IPgAJUmeXVdxESxiihqU4+WuyjawfiuN4InLrUBUudg
	mYW+YDPVhbckgBE/v+26ulF5Plhl/S6TEUC5UPiOgde7zFDOmbTjrFAn43g0ZvtlOEK4UurNz3t
	tibCu3GcY/FG1MT6nrHagDhRFtkJhbfxdHnz8
X-Gm-Gg: ASbGncsMlbAzZj1PDAQ1+LXWkYpCDX8c7XTfpEilgKHKKN0RWkBN3CeNcauBhFP7DI7
	pWRRaUlUugVo9lIywTdwezaQZmHXsCuZ3IW8kWoWlsvklq5CuJqL0Dgv2SeleVV2nurYkNCef3/
	0tIyQdLagclTwHCMKck0QlRBPo
X-Google-Smtp-Source: AGHT+IGKBd2X6Idca1/mgKT1zkDMQR9uqrUOqhVDlQt25SdyHg7XmFYSkgsNjaL8rr/gYT1SPEFN3J2argG4vQccbG0=
X-Received: by 2002:a05:6e02:308c:b0:3ce:464a:fd2d with SMTP id
 e9e14a558f8ab-3d03fc66229mr6700015ab.28.1738707816383; Tue, 04 Feb 2025
 14:23:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 14:23:25 -0800
X-Gm-Features: AWEUYZkFyU4srdNLncxGi-Vj2Ed-9pI1VtzBEz0G0sX0lENqzqw5jjQUz597s0c
Message-ID: <CAP-5=fXL=nS1-m1+gJsYfWfvyn0ouikX3=RvyKdiM7+ewS9-mg@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Python improvements for a real use of parse_events
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> While parse_events access in python was added, it wasn't used by any
> python script. In enabling this for the tracepoint.py script a number
> of latent bugs and necessary improvements were discovered.

Ping.

Thanks,
Ian
