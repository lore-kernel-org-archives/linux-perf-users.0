Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F5526281C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832972; cv=none; b=jSLikh0QH7nFTkVlweX7tcsUHG4BQMbhIQuYinLC3gR6nwcIF/UelnJAwHngGxOz062U8FmJAp+vvRFP2kOYt2kfbfZubq0aDH52L0LEt7jLcd/r8P6JsEo90XZtfAnDlma4BbLdupY8JAWvD0jRO1cSL3fmLEvmPCPFgo5PqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832972; c=relaxed/simple;
	bh=M4+Lrf+tBhiaUGrW68bHw0hJrDpp+VAINoN6zAcbL9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FlOjYYzqnEYBLk3paESbTXve0O63MNCT3lLunFASFhoiHQ7s2Fc85fr4mATLm1F4CTglrW5/vNEcEziqPPWQmNyIzalYwfvZYY0HTyKTU+6lX5E/aVV0Csld/0Czr/n1ZAQwqIE38MXj7WhNJ8l91KfCuD/1KOw3kU45rN0C8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afcdtANx; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afcdtANx"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242ac37caeso389275ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742832970; x=1743437770; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SRc0E5JJcFqM7BjfBegdLV1cJ0uZ5Z9Ovl532RgmCA=;
        b=afcdtANxbbleWVisj0rq1N3Gtn2QJ8XNKiXr9Asiuml8cOBcUvGIWF3KIfuU3QJnXV
         1RKj2x7dXycxp/b64g8KVK5Tt/TWkx6sCADfEukcAOMDHRdtvcRXRIRa4Mfdtlq25Ala
         jpr2iCNWj/zJ/gGNFQAB0nKlgV8U/fACNhySfEftqr7tO1hZVfaSSNxaScqjLd4Y97Pu
         /1byYASYQsZwlQbnpCqFXejMPtCW1atNljCQhI9ONsuMLbM+wHUI38ua2FbVPBAZiAIr
         GQyOobSGibTO6tro4nGJ4euifKcGk/VkSYJz2Ec2/yuN5WXaDFC9HGSIshXtQQsSHL56
         PXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832970; x=1743437770;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SRc0E5JJcFqM7BjfBegdLV1cJ0uZ5Z9Ovl532RgmCA=;
        b=W4anuVhzbmfOab/t2fqVtddAcBRGvUyijUT8yDIwbWUP+k3lT8HDM0uAY8WQqOhR0x
         sGbn2eQzqJfc7xtuFQgrfZkvYRoM6l0zPt9z9yiDNUadRuhv1tSEP8qHjTOwF6ionmrE
         E8pL1zEyNSgP/6EkvaGvRQXRQdx4xzA9yIJjb4BU3iKegpjXRyxCRMkASR8VyskRW+/n
         tUywym2WnKV1lHyX+0ApEbBx/y1arGB/Z11jNkcEzSxqHJn+Et66ANEFIuAyNnWvq2m1
         ScyPs1UPhFNEPgqvjt5Mq3Km8FT9083+CYyJp39ISxCw16D6j8XCHBj4rnRIiwrQuAJ9
         8o2w==
X-Forwarded-Encrypted: i=1; AJvYcCXDCldeBZrbSH84wD2UaaOzqxFlervL2tyxk1+sVmI3ZLTMUG1AfE+GsI8C0JlUmbvFKvhvkyhq/hU1P8QlvKno@vger.kernel.org
X-Gm-Message-State: AOJu0YxZaLJY188AjUhZly6/EO8eHFK7ej8hDWmHg3blGCzPuuX/Cg1f
	agrMWGBoCdKdrA1cDGAYeZe/+xfXiGLH+7IMNAf5GEwOeS+FpmCirGOfz+Tt06kcIyhRs13NB47
	16Y68HLFWVBBYf0b+w3B5aVhe8MkUVAYfc0dI
X-Gm-Gg: ASbGncvY8Kf5nWAeUKIn7Fq7fs6ckZd1wWHdvL1eZ6d4+BgQHu7PL73MujMEqyXjQr9
	O5JeP16JBTc+oEnU3VJmEz3GivgY0Ap2vGB6ZkQj8a+Wg8q9grnFf/h6XqKxUqBXspjesTR6PMk
	QUnTMhbMXYCR5W7oZ37BkFKXirq0PrLG8wL1sVTk1ayRvfy1xQCMR86k7zNCqdPHeEVA==
X-Google-Smtp-Source: AGHT+IFJdl0wwlNRPgxAYdSAvv48PsxCERa1aF2/9Rzp4Fd3VvhzX/0iRMyvcecJa+ev9tM8gvDsxiL/wSSwlZrUwAk=
X-Received: by 2002:a17:903:3d06:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-227982a7e42mr5582265ad.6.1742832970059; Mon, 24 Mar 2025
 09:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Mar 2025 09:15:58 -0700
X-Gm-Features: AQ5f1JpPJbKS_0ytg1eSMnLwkzKCjJrQfOfha4Pc7G-W8NP0BTmBN2w8ZWG67fc
Message-ID: <CAP-5=fUZ9_0hOx2La7B4a_3oPDFdAWDC-NDcMibAfb166kt7gA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Mypy and pylint build support
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
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
> v2: Rebase. Add James Clark's reviewed-by tags. Add example mypy and
>     pylint error output.

Ping.

Thanks,
Ian

> Ian Rogers (6):
>   tools/build: Don't pass test log files to linker
>   perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
>   perf build: Add mypy build tests
>   perf build: Add pylint build tests
>   perf test: Address attr.py mypy error
>   perf python: Fix setup.py mypy errors
>
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
> 2.49.0.rc0.332.g42c0ae87b1-goog
>
