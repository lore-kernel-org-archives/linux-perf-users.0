Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183418787A
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446076; cv=none; b=js9cMhDP51Hpa8FfJOsV1zEra6AOWmydEyX7bZHnACk6/NBbXo26EMkrhAqtLkHw5dPXSdrpyNiIb6G0pSwzYNWpzlEJPM7xlWPJTpjvesFb4FDRs02+RmOV7jgqPyoPJHtOyH6SZpvXIk3kpfPyRfohSP/PfsJt6diN2bBvsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446076; c=relaxed/simple;
	bh=ugZpTRoY215QYVPyz/5QfbNSSDwu5aCv7SqGOKW3jX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DU7k7GDSSmRmlYgw+yY2uiJsxluW83DNw66RbKuzfsRG0Oz5kmwER7UVjafHQAoeeW7euGHp8OElyYuyK4j1A1S6UM1DL9Webej6VNAtlaqRdrkZDh9nOv7xIsvumcF0MusM2STYMQVGXM5Ly5FGkNL/1xa0/jN6QwrsCmH1+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dGtcrJFW; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGtcrJFW"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a814c54742so3295ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 10:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736446074; x=1737050874; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORjOt91OVzNWJjEkhCZRX5PBOBJZYTPcpVx08rmeKL8=;
        b=dGtcrJFW4rpbaz1VS7M5I7UKe9oMCWUNgWlFU0y0b8i4UmAHIQ6Pa410TaFxwd9YmG
         nj1bKA1dvV47tMAUqIPOL0HCjKNO7Jp5J1BWhAsPypN/GK+R3SRs4OMQaBXrGXFrHc4T
         boOoJ5ESjBIZM9SDflF/0pOGmX9LG+O5wC9M3DPWAl6nArU7ExJulyqh06qiber3lpAX
         u2OmaGxusg8GoPurVIqmqY7hqd3NQvWHwvm5H+QzLIDEK9IEYfCjvSfW9lQs7aoCtfd3
         pDe+yra9w6F6qddnbiNXIJ8vA6bc4EKiocX7L4sXeA0H86vX35WMCm47eWBZ10tjLRWX
         0H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736446074; x=1737050874;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORjOt91OVzNWJjEkhCZRX5PBOBJZYTPcpVx08rmeKL8=;
        b=DWh+v683ZCy5UoLvda1K9JN9a/v2PfdKfVnZEcSZLTsp5K5IN/rLnEt7xplEOdxHhL
         HQrUqaaiJ9zASrHEzFYcAIqFg9jZwIbl+NnHa7HSqkPA1hhAJlmnBNqT62m1djr94a3q
         pyRqkn9B5CGFv8/shP812kshHhxlI31OfOlh9AO8HW/p6Gne9A/jlxHMr9BBIvy1AtT7
         vDfr5y9NSQStLAL2QckqCCnX6hCCVD31bnUyq6Ieery9svKiP3N4V1O4vFbY/SXQxRFC
         o3XPHxh4fCWtOSSAZk7Ekaf4sWqV3xSWLpmJNeMz2NZb7FuuOz1nQ7JDCcfUn1rshhr2
         Cjeg==
X-Forwarded-Encrypted: i=1; AJvYcCV/T7iNvFKjshkis2qVIQ5bJkT7w/aTsEA+1IPm2vsP+NmAFcmnOb0P3EnRLzKbPsqcrDCg2/RasXVgpZzCNuCo@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTlu9+KSj4qvBUU6eW+JHlUqeVE6mo493P5WYKL1kjWcD+oTk
	Dlo2gDYOCqYloGxykOWWvMYER/02HEfzuFGnH2esQUUXEhVtaBCFzt451ZufWc1a1wcXE04ZMTC
	ZlTE3l82i6ML9anZXUSjy1KfiIrAqCf9WAQTZ
X-Gm-Gg: ASbGncvL0Lr672nytc9dn9j3n4sNrqzi3O5eEnJrnbch2EIhYyGVLVmEEBwZVL/cHoW
	sbdOPQwlGH4rYGjwtB8IdUVddpqr/wG0Dlh/sLNJUWvmqjD+VVFmImr7p7Xct0OeydrZGLw==
X-Google-Smtp-Source: AGHT+IGyK5p/l3EipMfZ1MTGvdUKjfXhbK8pHVtyalAw1/2NipiFpbWMu2kcVDjpXRVl8YmMfH5nt+SIgLqEfdmQGbM=
X-Received: by 2002:a05:6e02:168c:b0:3ce:2f93:a02b with SMTP id
 e9e14a558f8ab-3ce486c43c4mr4143555ab.12.1736446074248; Thu, 09 Jan 2025
 10:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025172303.77538-1-irogers@google.com>
In-Reply-To: <20241025172303.77538-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Jan 2025 10:07:43 -0800
X-Gm-Features: AbW1kva0hUwy2pBqhnvhkJ6zCkGmcob6UgPjL7j6upOAEc4G3eoUrGRGr8Z5YPw
Message-ID: <CAP-5=fWcdB5fx+GpKQqL1hjSXArZVfjZzxsTdqMp4NT5Q6QTRA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Mypy and pylint build support
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:23=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Support building perf checking the python code with mypy and/or
> pylint. Currently there are too many errors to make this a default.
>
> Shellcheck generates no output on success, so linking shellcheck files
> doesn't cause `ld` to fail. Mypy and pylint generate output that will
> break `ld` so change the Makefile.build to ignore test log files.
>
> Address some initial mypy errors.
>
> Ian Rogers (6):
>   tools/build: Don't pass test log files to linker
>   perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
>   perf build: Add mypy build tests
>   perf build: Add pylint build tests
>   perf test: Address attr.py mypy error
>   perf python: Fix setup.py mypy errors

Ping.

Thanks,
Ian

>  tools/build/Makefile.build         |  6 +++++-
>  tools/perf/Build                   | 32 +++++++++++++++++++++++++++---
>  tools/perf/Makefile.perf           | 14 +++++++++++--
>  tools/perf/arch/x86/Build          |  6 +++---
>  tools/perf/arch/x86/tests/Build    |  6 +++---
>  tools/perf/pmu-events/Build        | 25 ++++++++++++++++++++++-
>  tools/perf/scripts/Build           | 26 ++++++++++++++++++++++++
>  tools/perf/tests/Build             | 32 +++++++++++++++++++++++++++---
>  tools/perf/tests/shell/lib/attr.py |  8 +-------
>  tools/perf/trace/beauty/Build      |  6 +++---
>  tools/perf/util/Build              | 31 ++++++++++++++++++++++++++---
>  tools/perf/util/setup.py           | 10 ++++++++--
>  12 files changed, 171 insertions(+), 31 deletions(-)
>
> --
> 2.47.0.163.g1226f6d8fa-goog
>
