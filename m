Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9057192B86
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123934; cv=none; b=ZG5wlL8npi4k27YuziGb5hqLd+VAOj689BNLni26O51d9B2Z5AJ3eOGV2PTIjjtQ9+zOImxhxfkxYPSDFPf1C3hVzjrH+T0hw1T4Sf7t+dF7d3p05Cy4vhFw2ccH2/Hknark+5+lxTo6n9szivExbOduE6bQ8bVO21TaU233d0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123934; c=relaxed/simple;
	bh=47ytQkByi69npnQJE9cuMcBCIB8J/1hpQqilY/Jfy2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DyK6tV9O22FCEJmEtOQfHCq3nmzBggswxhQXk0NC1/1ynzlFOXIFF/6ZfNen8ioGfVpM3fZnboyxRcnH6MakzeRdAFAigPfk0ffp4KAQ3zseCENCStWvSFzlivhH5A8oS4KQagIulgqa44l0uzJ9IM4oOJa2tiHFv4rqNMPieOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6QNTXFW; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6QNTXFW"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso3435ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 13:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123932; x=1734728732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47ytQkByi69npnQJE9cuMcBCIB8J/1hpQqilY/Jfy2E=;
        b=r6QNTXFW5VollexwBuV+BQe4fFVhqDgsqin3z6WJugxGRxu3LTVJCyr2HMQXORXTYX
         a+xR9dpMclso/sMLtS8E4WMOWq6UhAWwcHO0VRVWNnze+Ke5fCFUavpGuIE/SGuN7X9t
         GCvYrPQlYZn4at9e1FhfWyNiMpDeRPl975nh08PrIebCdAZDhwsWhMDwhjYGPeDdnjEr
         mQM0WEsLR2mOkx4dnZ4anvJAmgWKyzBckcAlzb82zPb0jwuW9Ztw02AFwb/6JIFhxCmc
         7rU7+G63L7YIXlM1wHyff7asJupFOWwPo2aqWlxHEFj1nj58ofAbnczV74bw5z1E04ZB
         9iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123932; x=1734728732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47ytQkByi69npnQJE9cuMcBCIB8J/1hpQqilY/Jfy2E=;
        b=c7X9Cz11plCEmc95wIif3TTGfbvDZTHtuxR8c6a3YWOLHXM8d4jGQQwX1Xaa0+q4FO
         MRMaMZO/obOXsvNgELKLkU9PgmSR3s4Bkc8b6lkgS7DzkZdo7gjQi0YmrbVXxI3kTK+r
         noefRHd2KGvIYYTpNYCt9fakdy/JEn/eejJvmCbNhKkV7UI7xhe6w+DZSocnIeK0eDBR
         w/LsK3zKLAtoiCZTqd30WmkN9Nr7KCzMf7EqVPdwELCm9TLLJEZF/yi6iMY16W19sjew
         /Hraz0xBRHjzy4fc1Lq17lGX0jGnBwio+5941syU6oRShUPOm4DVm9VTYuqRUf55iWTn
         dV/w==
X-Forwarded-Encrypted: i=1; AJvYcCUEcIr23OJm70bnBjvNRtoSEQPTZQ8vw+tjw8gL7DgkEs4mM3FlCw1Vd7kGnXXKkDR8BmdgACjz+luPAF+Pyf0i@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpd+LoUs/kaRYNSlDD0V65NXJHlxDGvTz6ECsM7O1X4jrI07Gb
	2ojl19Of+S20C4gOJq//dVnMetbYwebqkmKQwv+lK8I9oBOIaw5S/MwVqh0YMhKUEHXfbbR+UR/
	uLuDJTVCZmhid0U2R+v+a/yIbUDpKzcMwOYZQmoulhOqFQYF3su/M
X-Gm-Gg: ASbGncvKDZizQYCAiNZI02i6Fzh3XrOabBJyZD7B4jC4is7n2Lhe4WofSuaCZVMDqzn
	Xb+gq70ufKF6qCsv70G1Ol3RI/JjyK/wDfuj9S04=
X-Google-Smtp-Source: AGHT+IHo/kk7shZp2cLw78tSqgm7MN3cgHDkD698rGAaphzsbaWqhB1nqjLPEhhZeYxzO84CQfy6GmWOwDhFWaZ0IMM=
X-Received: by 2002:a92:d792:0:b0:3a7:c997:efdb with SMTP id
 e9e14a558f8ab-3b279e187f9mr478925ab.17.1734123931596; Fri, 13 Dec 2024
 13:05:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1ySfJAebZyEv8qE@x1>
In-Reply-To: <Z1ySfJAebZyEv8qE@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Dec 2024 13:05:20 -0800
Message-ID: <CAP-5=fUMr_ZqrHdopMNQwacCvuAy2ZO0JKC8j9-v9Ap4vuT8xQ@mail.gmail.com>
Subject: Re: [PATCH 1/1 v2] perf tests switch-tracking: Set this test to run exclusively
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 12:01=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> This test was failing when run with the default 'perf test' mode, which
> is to run multiple regression tests in parallel.
>
> Since it checks system_wide mode, set it to run in exclusive mode.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Link: https://lore.kernel.org/lkml/Z1yPYqYYs_isO1PJ@x1
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
