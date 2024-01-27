Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BF9449
	for <linux-perf-users@vger.kernel.org>; Sat, 27 Jan 2024 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320006; cv=none; b=cX8sbL0fnp8DqpCHmYQwZD9DQH7R+TIxoHA9xxNWWAm1WjGsOJiKm0k2oP6OsGx/YGsZBQiyLW3FG8DDroN30kSkHiq9QJmartGm6LT4m1JIXcbrJ81w6Wg4WVNjV3EbL8f8Ymdvw6BbyDkMqDKJgq+Ryfi0bYOMw5t03Wf3lCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320006; c=relaxed/simple;
	bh=9bsK6rRt+p3kjxZYeZ5rVjGtZIS98dlk3O2aOE48xsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEn7ZlKOkuNKrqRGgkjDiius1dHf2GIAU3uO6rLiL+dcDtb7ia/IPMD5t1KVFEy4fcsM4Xug5zTsUmuFo0pfFtgw8yJl7nzXu7PNAJb3qZYi34wK+VUGjGnGnj7xW2kFGczaUcZhaZ8uUimuHfpHMATJjzLy9dMaGqcuPC4hHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiM1wpat; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiM1wpat"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d89f0ab02bso26185ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jan 2024 17:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706320005; x=1706924805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bsK6rRt+p3kjxZYeZ5rVjGtZIS98dlk3O2aOE48xsg=;
        b=DiM1wpatm/6/eqOvBKCNkqdyQzmTU2gL/i9HiEF6Wka2DJpEQcfkz/pZ5cRD4f5BP6
         EIoQo2CO4j95CRPRaZCSymeV7ncXkXzxO+1IUIJagm0r/Q43HTGDtGlVRqZiRRXFPFQ8
         MoDdBQQjH67jnTotLRbzm3yBU/JNHrN1ftB52xRlWBtugqLgT6saF3qmuVcsaaLYeG9w
         dJ9LmOg9luID2HcirWSJx7m0vQyeqyXCDhQ9y5duTZzH3osOqJnpZHCAzVtWqoes6hAd
         zRfNTMc6kxAJ6Ipmq6laCKGV8ytAtbtf9eSdwFZ84EOD7CNqBVdsmdUGpYaOW/9Rv0/w
         RieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706320005; x=1706924805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bsK6rRt+p3kjxZYeZ5rVjGtZIS98dlk3O2aOE48xsg=;
        b=A3DsFcwBmCSzm1HvEBf57zsSe27mOptFqC9mzWYTng3/K1dBMdLdelERBeMNnOwYeU
         oKvqHYJ2BtC49v1y3+zl44UNhoTkUH7h+CMxq10Z1gBWQLrC3RpQfSHyobboMzRlFzLs
         25pBqp5GP4Dcih8j6mRkDwthR4ubpe+75jjrlG1skSdcgDrsQX0OKz9ZAuREPteSPqeZ
         kuJQYmoOyFn2RYmBofWKJ8HFwUBFFXS9syWEK6QT/x7lFZIOz+cMHElwU6B7Y6tSDeOD
         QqG3fbShMlo8WGGqLLmgX3sLmwiCMy8SsUWX4rphw61ikICJZfJdMwzpdEqH1pZW5JR/
         3KEQ==
X-Gm-Message-State: AOJu0Yy1Nj8wUQUB75Zpa+jFeQPS2Jy8SuV7MUrqSwwtZRylAMIkqUfF
	nDo7YByCoTGC0PaOUBS9/3UGp90JCyC8AH8NxxHCK46KI7AhnWBtcsaByTeGUwmrToNwdVcqcmG
	PreEyZmw7Trmmanh2QryQWNpH84S3IWM+2ACR
X-Google-Smtp-Source: AGHT+IFxcOk54B7+yHdhkNTBkVoJbACAV6awbqVb8CyFjZ68N3amco5TD/TECJMhXTkTAEcQ+zLcDMqdZ52/wzULd9Y=
X-Received: by 2002:a17:902:ce86:b0:1d7:806a:a13e with SMTP id
 f6-20020a170902ce8600b001d7806aa13emr356387plg.28.1706320004507; Fri, 26 Jan
 2024 17:46:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104231903.775717-1-irogers@google.com> <8c060937-0351-4c4f-afb3-aa6e5aa1e685@linux.intel.com>
In-Reply-To: <8c060937-0351-4c4f-afb3-aa6e5aa1e685@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Jan 2024 17:46:33 -0800
Message-ID: <CAP-5=fXpkMP0yphYLAUFNwHjBZvapzkop41LGnKDc1QAOoi7qg@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor events intel: Alderlake/sapphirerapids
 metric fixes
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 11:22=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-01-04 6:19 p.m., Ian Rogers wrote:
> > As events are deduplicated by name, ensure PMU prefixes are always
> > used in metrics. Previously they may be missed on the first event in a
> > formula.
> >
> > Update metric constraints for architectures with topdown l2 events.
> >
> > Conversion script updated in:
> > https://github.com/intel/perfmon/pull/128
> >
> > Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Closes: https://lore.kernel.org/lkml/ZZam-EG-UepcXtWw@kernel.org/
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Thanks Ian.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks,
> Kan

Ping.

Thanks,
Ian
