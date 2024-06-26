Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CE53364
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719440535; cv=none; b=r3OndKLCwmxUUhMbtMHWZENlO4Y4s2KpttjY8nPxojbhWpl9KODkHS+1UFf7IncSTWG57P200w9bhVymk0+fKAY/dGFeWULPvQzzhwbCyuNnCHVuDRA9WdBUIULjkFp70keshlTwE1SQY1PQQ4JgsALKvpH/PWJdRZUKSA5g4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719440535; c=relaxed/simple;
	bh=ugZA6cpa9UcOC/1dDaq60iB9g2fiyJluPesBF18xT/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hz1FI/VfnVwwbC3a44ho0IDrGL/zMlUjWotnwurJqSlrv5OzYJFkfmT4b2snWuOASwLDYhorxUsVlCXIt8Wj8RLvDR6k9OtWV/eg+XsNlgCzDDSxn863QlUprwfL354cvnPa64/6C2WgEcSvTssMgJB4M9oGncxUiMd+WaWlQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IM62ArNx; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IM62ArNx"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375bb80e5b8so25115ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719440532; x=1720045332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF2hjKbTwUFm0fD1hWkC36rvvKOjxPrzvvCMoCJluRM=;
        b=IM62ArNxHse1QpXVfW0sArHj+jNaXVAJ+PpmJ27upyKAph98KUQkbCrx4AiTk5ixRB
         YEot404hD7U8VPSmzBF/taQVi0tcB4tWaAVKfekpANAhHsiSL3WXfgESTsZjzP7wc9Df
         ilDxzGKktOHNEpFJriTT+ACstou/Yd1VqQSsmUxfpEbPamcQUUzPgAb46VhNXgSgyy4n
         +ya6G3pxxYfGoUwpraUZ+maU5A155busfKwXlsWIRBIat4SI8cCNJeWDjiYDbq6l0OcQ
         xmwYhfNBAtWfNHzJprxCSAjUZQneRQUHoMka11NgmqpxuAiErXuI0M9x6UYsbMXoJ5mN
         Wphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719440532; x=1720045332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FF2hjKbTwUFm0fD1hWkC36rvvKOjxPrzvvCMoCJluRM=;
        b=LR8NPtwD3w9ro7W4MqGs0IRbVjm2aJ+9dxplphW24janLph0emVbcsjUlUKeRUOMNn
         eVuB//awyVJAw70MikHDB/3s9i46uwOzNOA2iWOp3f5uK91C+OOwWF2wcUQ6ssSUIIj+
         JrG9Wx/sD0eR49u54VtXYxeQmw5LoxNlkAmrTXO+2XgBtqOxyrj2Cv3OynqWF148RIap
         5XcxtNiRqtJZlLCbt7DvrXNcGztpx8acHR0OQDznxG+aR0LbtiZgoJc+wwhKD5sIpvB/
         hhLxfCWmI78D//6vQgzinK11nVIS5/8C4YvXwUbp+EaUIocvEMP796DR0DuGTCchFpls
         BX2A==
X-Gm-Message-State: AOJu0YxA2yzVfb88U/X4u0r6GWhbIHHPqwDIhwcy3v8ASccxh/2O0WZJ
	FsTvXG+crltQIJ13D1qgc2IwCLT6jVmP9ZOP6rhbR4fBAZ/BmalibD0dgmTffuhhH29FY3sLGDM
	stBsLf87/JmC+hrnp+2kN8rgWNIPoerzcIOY47w51dwmMUOjYfzN/
X-Google-Smtp-Source: AGHT+IFZzu2WbqXj3dP57bIN2IP2fOiu1vpAo4Rf9Dvwe/X0+u6Jf+VnQ64MthuU8Ate1W1PrdllWADewA5O7Nf2k/w=
X-Received: by 2002:a05:6e02:1e08:b0:375:b377:5c8f with SMTP id
 e9e14a558f8ab-3795d0f35e3mr1403245ab.14.1719440531865; Wed, 26 Jun 2024
 15:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626145448.896746-1-james.clark@arm.com>
In-Reply-To: <20240626145448.896746-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Jun 2024 15:22:00 -0700
Message-ID: <CAP-5=fWVA9sEn5JbokUipRTzu24HZxxYyHGPrM5soKRb4D8_Kw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf pmu: Event parsing and listing fixes
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	robin.murphy@arm.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 7:55=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> The second fix is related to the discussion here [1].
>
> The first fix is unrelated but I just noticed it while fixing the
> listing issue.
>
> [1]: https://lore.kernel.org/all/ce31a50b-53db-4c6f-9cb1-242280b0951c@arm=
.com/
>
> Changes since v1:
>
>  * Add Ian's suggested-by tag on patch 2
>  * Fix mistake where info.pmu_name instead of pmu->name should have
>    been used in perf_pmu__for_each_event()
>
> James Clark (2):
>   perf pmu: Restore full PMU name wildcard support
>   perf pmu: Don't de-duplicate core PMUs

Reviewed-by: Ian Rogers <irogers@google.com>

Looking forward to an update on the bugs in:
https://lore.kernel.org/lkml/CAP-5=3DfWxdZ1ibv7Pi0L38+NF-vNWZCtcDS9JVf6k3z9=
nDsrQQw@mail.gmail.com/

Thanks,
Ian


>  tools/perf/tests/pmu.c | 78 ++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.c  | 29 ++++++++++++----
>  2 files changed, 100 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>
