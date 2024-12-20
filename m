Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30321A43A
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734721181; cv=none; b=fnQHh+2L472qstc46yZAt/+/2HW+uEMl2SQLQ8jplWDT1QGSagFFQFi1VDEg3ZSbKXqbO7R4wBRb3QcLMXedSlHslrMjcimA3MycLUu6O6SR1IthN0Fo5c8qt904tkwXqSDftFiaRpxbpbAEn1/aIiSMM+SMy33q0RVTHZokfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734721181; c=relaxed/simple;
	bh=MXjbkIUx6EuLUXb8ut6rDdXeyEq5e4HPl9Eu3SYH4Xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqtf+Yqlm3fKGXFWHHy47HvqEBhA/44RuI7q7q+x1jAI7Uk9AfQAMpwE99nLjpu4g8Ac5woTJHqJXILNAXftE4HV6zgJfYSbHYh1nL+dTzL67F3RpKuLPYs5Lpzs2qWS9BEYrtr31ciXLh7JVX1m2vrustg4z0S/VCMI8essl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35/mZMlO; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35/mZMlO"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a814c54742so202695ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 10:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734721179; x=1735325979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXjbkIUx6EuLUXb8ut6rDdXeyEq5e4HPl9Eu3SYH4Xs=;
        b=35/mZMlObBVOKqN9vTPkbV5rc7DBuRHRWh9rM8G6aACxjIxaGhwg7KaXjjQJk1VtGg
         NViz4OsYLPXVG+DJAdD3SmKdRpJquy67DkgjPY/sXLvzF+er2jxkIIgl03o/+tAk3la3
         19yxLknB8baKIlVlMN8gH+mewcZCx24zEdpQOZpa87XUHvpt+0xYQdY5RmaZJCA7KG7I
         q1xrw4AzMtNCFGaGB27FJREd8haoUylx8X3Ay04gRqmNXl6lNQpU5jyBlX+SBuofICOw
         Q9MnbmGhkJop7LTPzt7F0le1mgq2/hWUc82v8956p3AZoWeQ8o3GGmwWui6uR6QHjlSh
         yjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734721179; x=1735325979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXjbkIUx6EuLUXb8ut6rDdXeyEq5e4HPl9Eu3SYH4Xs=;
        b=K8WU5SwJhLrQNoHIUbjed+zeIldPdZVFhyRhFzYfv0W27qm6xJ2dvTIovZdEHQql93
         x7k1smvHzqJioyOv9M4l2obiptCHikeTdnJUKAa2mn3kB8lzIfWr0g40GdYKy54FZYe8
         Tkp4GDewW5z5Og5TiDHwLFC9oPBBSls0C/84UUipS/bwJSwkDpLd0sZtgS5ksWJTiwnB
         H/C9TV90bnxVicGDtGJ7iMKyitxkBQGGfwWJf1F2JrDjivgWq6WAa9aG2GE6u+44VOln
         NpWBSlnDwSp6lfFgElqRlTROScnLoVzr1ZLLb9+5goQoZF6vo+XC+eKCi6BYvpeNzF/x
         E+bA==
X-Forwarded-Encrypted: i=1; AJvYcCVKy8BBvaFLmnBuJeAHDjN3MTQEevXddsy67rl9cxxsOKruRzve6g4WPGdvatvtrUm8gAl4tQsT5HR3cpM3Qj5C@vger.kernel.org
X-Gm-Message-State: AOJu0YyerwgXL0xlkWpt70OefJbJqndKHj7rvYWJiyfXqfNSl6flO/yV
	jj5kcVFRV2nhT/UIIXaAM/CRRM2tz1Sxy466PxaGa4P6QtAHSaEQGkJegVsC8F8JcxGB3coYbpC
	VOeolwPD93iSlrF893yWabFKNyaaScnv5+b9+
X-Gm-Gg: ASbGncsRqRfXWLazAZoTjrM3YFWCM+oqHNctHP5+Dqf5TIB5kkpRLC9n8yDJcEiwCuv
	r3ehtDDsvWfsfHod8+tl0IrP4BhKjl+EgMhqv2HI=
X-Google-Smtp-Source: AGHT+IHN+7v6JxccmGD4tDIrf9j0IJIMhGIwYoXpKzxyazrfYgbmrNBFUC9VRVtnxBN3D90gdIXHN288gYIXHdtOfLQ=
X-Received: by 2002:a92:db06:0:b0:3a7:e616:8d2f with SMTP id
 e9e14a558f8ab-3c33186aa53mr2665815ab.7.1734721179175; Fri, 20 Dec 2024
 10:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114172309.840241-1-irogers@google.com>
In-Reply-To: <20241114172309.840241-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Dec 2024 10:59:28 -0800
Message-ID: <CAP-5=fXx78Mq+rCv78V_tm7FY-aEqKzBT79GZ5gTCw5-3vLp9g@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Provide better path information for
 broken json
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:23=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> If the json input to jevents.py is broken it can be problematic to
> work out which particular json file is broken. When processing files
> catch exceptions that occur that re-raise the exception with path
> details added.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian
