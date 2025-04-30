Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA51E501C
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026533; cv=none; b=SxR6Hp7BSsHKuuIxdKo/GwmdSoX0gR1u1p5qxQQekqakRu3HxzAFveHec0fFu+Mzsj4MvZ9NZFfeEV9E6nnPMXHfSss+SfomrrDz1Z16G5b1HnJCh1S+g5ceIZkOa6I+w/wI2kHmzS7p3qt5u9ZyzKsZFHLpmNYa8ZR3b0L5Kmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026533; c=relaxed/simple;
	bh=WZRYexjcI+FcMwQnFYdjjkqA9YMUqrFrRBtF8JzIvqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4xSPXo0B8pZj7AQMcPT9dJKo2/31S+UlBFlMbH/dgEuUSA980cnplMWViL6CfVlT6A/O07NHhl1Ja2ksmVEqTdcO3rYDRZff2ev9l4bzpG26uhTDE3/CCYXCio+2iRyreN/scWwCOMmDfm0nBXy42Pbtklh+GgqnEs755KuW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3tx83uy; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3tx83uy"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d8c4222fc9so350965ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Apr 2025 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746026531; x=1746631331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93eCSnL7YqqbeGNknrrinPW0I2Te+1gugq/NSOoUJBI=;
        b=p3tx83uyneiPanGtLTgkP+OyIoenVC8fUZg5kRbnZztHeQfT9098eqd6Ffy44wkLu9
         bXDjIt9ix2VY36VFtRnRhvoQXLMZl//5iptsLwt99sGtGJK9TrSQkdqWppy1gnaSrfgM
         dm02C41li8CRJwIPSIffowHVxiWVrclhFjNiW66p1xE47CJ5kZLjVgf5eG94biWxJqxp
         LLyYIXZ1yo9Az6puafSyb8+kO6qe7Xgxx9sfkqHnnH6IQIKp78oW4WSgpGra+G/lSBv0
         MrRH75l8azvrAvqIoc9PfyH7AiDw7R142Y2zJeFwQc2+hkS2vvWJ+N1YSxxqqDcMVPqq
         P+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746026531; x=1746631331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93eCSnL7YqqbeGNknrrinPW0I2Te+1gugq/NSOoUJBI=;
        b=YfUFbtpu8FulfBUJXJGtdg3kfTIOiwwSnFxT4lBQ7tNP/9Il+9iHa28T4iPeRYUeDb
         srxvmWiNAqdjpEXNK8Pis8+cKxpZwm6YOFk1CU9qFz3JcLYyUBwHODeziLRSodmmmkda
         siWj37+UETosjScsV+ToTpeg4Y5mfUfPKMNb2PnF9U36xsQzw5RTVMo9hqEksDcHg2mk
         7fRPcZ1ykeUCivUJogQ1U1Qk/Ix4tCwJ3N9WuiHrSKMf9sswcmxNMz7B3VSPZ7N/iQRg
         NUgmm+7UG6COm1JP+3vlrdav//pqMVGSN0/ajzy4M0VMvM4impsBVN2dvDfoacSBIbp3
         igLg==
X-Forwarded-Encrypted: i=1; AJvYcCUfNUWGowK3/UBSyk4KKkj+NkQXCDQ1sCZfPzCb0SHrCLpCMoYqT+PNTaUgrqP7NVlsh0NJYc8b3m4kTqfm3vdk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5t+lNfrsLmGDcHlAnA6iY3qLVnDA8WqW1sIcBELblWipALr5y
	wwr5PsSMtAdYhnQuy8xeviTmcufL7Z2xa84oFrT53j9IjnXCFajoNx3QejyTWl4zRa+rADXlkRo
	UgmlUvMXc+2nmqLS1/iSu5Hc2/UNEM4dCdejm
X-Gm-Gg: ASbGncvjpwlOAyeAVLrzYVGqrQFl50fWwGAWEbHn1MF7faybvY4MHpkHCL+98DQi8Ri
	m6Mq1iKNSDmJzWJpm7QWS8X3EcxKY4NONXJIFlieka5U8OQBrTTrBXFV9p1syHZs38ZnVLEiPVJ
	R4uyXvsP6qITmnoTKSO3la6kFjRxD9X8mG7gJNB78EcPSRFlYGrcw=
X-Google-Smtp-Source: AGHT+IELFRtJscY2zbXLAgGomavWrz5X4sjvrTHzwB6yFqNo7j46RHB/wvbsUhzom5/2eGNsOqexGsnaS9kImIm15og=
X-Received: by 2002:a05:6e02:330b:b0:3d6:d147:3126 with SMTP id
 e9e14a558f8ab-3d967f2dc37mr3787365ab.5.1746026530498; Wed, 30 Apr 2025
 08:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403202439.57791-1-irogers@google.com>
In-Reply-To: <20250403202439.57791-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Apr 2025 08:21:59 -0700
X-Gm-Features: ATxdqUEX8IsJnW5m4DN3_VCxfO0u0ElVgGonJIShmJi7InKGbKOKF9LlxD3eVyM
Message-ID: <CAP-5=fXkayZ7pj+EctOtSBiTcGuyi6SHm9c5RZ3HyyPYcot9zA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add support for a DRM tool like PMU
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Brendan Gregg <brendan@intel.com>, 
	gabriel.munoz@intel.com, matthew.olson@intel.com, 
	brandon.kammerdiener@intel.com
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 1:24=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> DRM clients expose information through usage stats as documented in
> Documentation/gpu/drm-usage-stats.rst (available online at
> https://docs.kernel.org/gpu/drm-usage-stats.html). Add a tool like
> PMU, similar to the hwmon PMU, that exposes DRM information.

I'm reminded by Brendan Gregg's new blog:
https://www.brendangregg.com/blog/2025-05-01/doom-gpu-flame-graphs.html
that this is still outstanding. The patches also reduce some directory
scanning for the hwmon "PMU", they are in Google's tree:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/util/drm_pmu.c

Thanks,
Ian

> v3: Minor tweak to the test so the skip (exit 2) doesn't trigger the
>     trap cleanup.
>
> v2: Add support to only scan hwmon and drm PMUs if the event or PMU
> wildcard can match. Add a test as requested by Namhyung. Add file
> comments.
>
> v1:
> https://lore.kernel.org/lkml/20250211071727.364389-1-irogers@google.com/
>
> Ian Rogers (4):
>   perf parse-events: Avoid scanning PMUs that can't contain events
>   perf parse-events: Avoid scanning PMUs that can't match a wildcard
>   perf drm_pmu: Add a tool like PMU to expose DRM information
>   perf tests: Add a DRM PMU test
>
>  tools/perf/tests/shell/drm_pmu.sh |  78 ++++
>  tools/perf/util/Build             |   1 +
>  tools/perf/util/drm_pmu.c         | 689 ++++++++++++++++++++++++++++++
>  tools/perf/util/drm_pmu.h         |  39 ++
>  tools/perf/util/evsel.c           |   9 +
>  tools/perf/util/parse-events.c    |  30 +-
>  tools/perf/util/pmu.c             |  15 +
>  tools/perf/util/pmu.h             |   4 +-
>  tools/perf/util/pmus.c            | 101 ++++-
>  tools/perf/util/pmus.h            |   2 +
>  10 files changed, 952 insertions(+), 16 deletions(-)
>  create mode 100755 tools/perf/tests/shell/drm_pmu.sh
>  create mode 100644 tools/perf/util/drm_pmu.c
>  create mode 100644 tools/perf/util/drm_pmu.h
>
> --
> 2.49.0.504.g3bcea36a83-goog
>
