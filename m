Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68C2E36E1
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490731; cv=none; b=iHcA8Lp5EMpzmX+ymxjJV8JPiBsmEOgxsoW6K/wA6r7+u9D9a4T66zYNVklK0bMzLDgskhQIhs/a/f1YtgI+oWsmDUd4frm1PN7NlsxfEM7Yztad+U7+GZobdPwMsc77ub7Ciadi9uogmKImWEZkSCZ2yS9TWADp24H+KtI6HW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490731; c=relaxed/simple;
	bh=pxg2xmAtW+OVA7ABSm7SU28mz1UKZOLH76wzUQ4/Ls8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll1KtWw0WEXm/NYa+PZSCdeYjYez4izff9f41n1znCJ59ryCf4KllKXwvtWVs+6vMmtnsa0wfEDGwEVp8/FW3McIgtnTIoY1uFLJM3DHmsPg4bKmm4mdtfUVRoRPRf6su0GDWkNHZjJrA8TRk3hGZaD0CVrHsmbqeJGat6Rhw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoSCg8zN; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoSCg8zN"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e3ca89a34bso56655ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753490729; x=1754095529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMkVlvkOlkDsDJiJtgYXKUc2fMtBxHjk6ZcH49JTVf8=;
        b=SoSCg8zNJnOkOmVQK/nnZbmlCb9uvS96/TWhGFMSNh2uvbBECsZ3eWnUD1sVj//sUl
         kiQkdKQKZ2FeVFKUoVfJ5hPAQsxKQ4H/JDgmIRjuvpuft53APdblE4cKXHT6vj2I106M
         fkPtE2d9y+MpCfd3lUcLIpmX25IHWg622TpfqCPGOed61J6j8qtzR18xvpoh09Fx+SYA
         FLsGBIeH9StLhwv3oUpl4bMERm89k9TshCTrlxk2QcM3TG1CC+niwrOMh1TKICqWCxod
         v7NL0t07Z2B2l7AqVoJ3PUTIvt+6aSTo9gdO8iltcW1Bnu4v6ZNZIFeG90GNC4ec+cxE
         4AtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753490729; x=1754095529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMkVlvkOlkDsDJiJtgYXKUc2fMtBxHjk6ZcH49JTVf8=;
        b=aUvnaPC3uozbfnrhi4/5S+vMr5EZBBVma0LuvVYyY+TXE2d3BYDhGM5znCy1HWjFuu
         lLzisu4+9vCYEo+SzkIuawT4v9APXcwBp7NLnCbu4hScwT+ZLIhNLqpNDy+r50kqHGxM
         wbUoCwfJnXUS5GrjqPcCAxY5YmkhJQ6haukxg1e3obk5IkHj83WBJKaOwPZ55U0QbvU9
         Yt+rk6lUsfiWcbDKXy2hz1XZVzTx+dNhH/BjUjXm4AZlFZFCVVg3ARQDTcNByfR4RT5A
         2nI0Fu0VkIS5ximh68oQU9DU/Ftrsoz571nc0W5REERFfX/i+SCXyrKH17qPUFD7+1BJ
         WqJw==
X-Forwarded-Encrypted: i=1; AJvYcCWjdSA8hQ0hs0Cv4SR3aXhbCEkkZXB8NeHe/8ao59Tgngjf03ps4xvnOaaabaFfqzkW4a+KRU99VnWqSzSUdgs6@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWu/sUkT5jprEgbNAzj7IPaIfmM/nRe9BpEUIvD/RVs402Xde
	9vm8Rh96AzHzZNhSL1gJng43B89nvBbAaN9bwQ9i5qw3NgMI/6SRNouczYumZRwQoAusNT4D0af
	8vd20yvagy9zQZII07+ZhHRmSjR+baz6u/OrIf8HS
X-Gm-Gg: ASbGncvlhGZxN1GbCNF1ekR5OaOFjqeSTGE+Sycg2Pi9q3/bh1UA+DN/76MpPTu5rhS
	PluX+NiOHGzYVIbH/MwVO0rnfkNiJua9yuM2EvWfOYvX8mgOf4u61lBEDqR+48onhivfCkhZ3Mx
	/Sz1quweMAWmdbWtiUCxl/s8CrEjxBZatQGKUJGbMseF7PSvzETf5hzIHVEXX9ngad9z+FeLfGB
	07ah5fk
X-Google-Smtp-Source: AGHT+IGN6wOzatqvy/OpRoHOW2RLac4VBB3V05rQp+gk4PFfomyB5gIzPstXPdr5ruJ8rl4Jxzlz2syi3jTHQ8DVvOc=
X-Received: by 2002:a05:6e02:2167:b0:3dd:c9e4:d475 with SMTP id
 e9e14a558f8ab-3e3cbfe104amr1623005ab.22.1753490728894; Fri, 25 Jul 2025
 17:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726004023.3466563-1-blakejones@google.com>
In-Reply-To: <20250726004023.3466563-1-blakejones@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:45:15 -0700
X-Gm-Features: Ac12FXwghoIBGejz3QD5ztrbBqVaqe3VNiAirRjc2_3fAscr-xIW4oR3aZ07LEg
Message-ID: <CAP-5=fWjq-6MbYt93FOBWqV_1VNjAq0FCqxm4B1W4KXCyBZf6w@mail.gmail.com>
Subject: Re: [PATCH] Fix comment ordering.
To: Blake Jones <blakejones@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Collin Funk <collin.funk1@gmail.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 5:40=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> Commit edf2cadf01e8f2620af25b337d15ebc584911b46 ("perf test: add test for
> BPF metadata collection") overlooked a behavior of "perf test list",
> causing it to print "SPDX-License-Identifier: GPL-2.0" as a description f=
or
> that test. This reorders the comments to fix that issue.
>
> Signed-off-by: Blake Jones <blakejones@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/shell/test_bpf_metadata.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tes=
ts/shell/test_bpf_metadata.sh
> index bc9aef161664..69e3c2055134 100755
> --- a/tools/perf/tests/shell/test_bpf_metadata.sh
> +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> @@ -1,7 +1,7 @@
>  #!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> +# BPF metadata collection test
>  #
> -# BPF metadata collection test.
> +# SPDX-License-Identifier: GPL-2.0
>
>  set -e
>
> --
> 2.50.1.470.g6ba607880d-goog
>
