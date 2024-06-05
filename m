Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59C38396
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Jun 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608085; cv=none; b=jY8bC4JDvsnPUKUxiRDx6rth3U6uhK39KPvN8XibYXa+ere1DZk48SUlp/dEvo+vUP1zLxjX8e7dcOOpV7adE6jMItJ0mVrsVPVDCTXrg+57q1mBy/yg8T7LEwjXB0t4PEPdXnM61jWsnqiNjdMc9OyJZFcoSsH/ZQ6pUG/HD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608085; c=relaxed/simple;
	bh=Tcwq5dn9T53VXyu2UVdw5TjGv2V1CJsT9RFq6hlk9QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNKtZGOHy4No89z+cWxlp7hdZ1d74e2RBSvB9XnsH/ClLuLw4aV/UX4P0+eL/A3Iwd2OHCv3u4oUmlmxmnOcf0kXZeymRTWFI1RQ9kHxqBBebseHq7Kk+u8DixljTkjI6HvlsczgXGR5hNWdGfnEWLozwLn6avbokcSbUAaQcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBhdOLxt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBhdOLxt"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ee5f3123d8so5955ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jun 2024 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717608083; x=1718212883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYCo0S4v9XF6m0fRGRV3IsBGozW86ded8JzpR7EngjU=;
        b=nBhdOLxtqLb/6IDbSQ7cbc5oFvALnCWkUFIjJpsMkQMjQOE7dXBUGCuCe0F70vOJTp
         zhzuMjL9el0GaUd0i1WJEHri3+EanWtrRKxyHidjzQ/6xr2O0L2TViyOyN0qBsugfwTj
         s7BOzVznQsc5gt6LIzggVG1PffrMGNOJQJA7unbUKbvQDovJqfLwcqst9FQsGz+3PSfe
         TLQYIoltUHGQjUYDr/ayFtWklpnSuTK6pSXJNMna13LdoLTI7TJ2Yw72OMKZym5NiaFL
         lh0TjaY3qEEj8VMMdZZwvnfvJTPGh3hKLdiDydhLBno8R8tW+5J4LyVpNlx4xBPGKOOW
         /YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608083; x=1718212883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYCo0S4v9XF6m0fRGRV3IsBGozW86ded8JzpR7EngjU=;
        b=ZXBh72xfnhac3/0oB0mSmf/hiluP1WSqHv9Te83Q1goObBlWi0BIME5JgETQGdiyos
         Kmes52R5VvjtGkXcE8K4EHA/el2O1pd/86pzOpsL6/D4d+P8lPum3uOHtH7AOY1U0cBW
         T8ZmdmOgKBveSWs4pIOD+nHDx/K44j8jLewn0PUcOvERIuwDk1VG5hKtT3tBwCIHVUbW
         P+JJ9HihkVAPVKuCtbLRWWziSXP8FtPkqP44KBhoR0qEB8X1Cl2N8/TSYQ3z8JxOvGjF
         oFwp6Fl6JLfkQA7/PxHWb0ttLpolrHE9kKL0v7JW1sUyXz1THacRqJXkkdQ9ZhfUaI6A
         KIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/yrYRnj5Wn6n7kiz0iXMYbIn+Q7dDu6NEIAltRN6juS8yfF2X7gVFfoeDfC/zMdAtSGT9wGvvYHhn3gQHRTNpD5eKXxKbyGY89zNt8DiZ4w==
X-Gm-Message-State: AOJu0Ywk0yaaPwywxVLMPMcwMjNc92T6LBl7oHd/TDhjh2cZphb7WPY6
	ByQ+6ZWWjkLwFrbGQvWMLtd8b5phKGRl5L5BAXjim+y/4b3/w1qh4Dlheh7Sw6fKDw+Tvbv7Gzy
	NsygneLherHE8L4uf8+ACX+avMDMObAxqetDy
X-Google-Smtp-Source: AGHT+IE2SZkPszq0YruXeZgdwMZcRiyinGSYCRMCQ+02rAZyYrQw99myRkawq4RdPGWs6JBjFpE5FIBN0Whl5kn7mus=
X-Received: by 2002:a17:902:ee8a:b0:1f6:5bba:8ea3 with SMTP id
 d9443c01a7336-1f6a7b01893mr3570835ad.25.1717608083107; Wed, 05 Jun 2024
 10:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605160848.4116061-1-kan.liang@linux.intel.com>
In-Reply-To: <20240605160848.4116061-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Jun 2024 10:21:10 -0700
Message-ID: <CAP-5=fV+-ytA2st17Ar-jQ5xYqrWtxnF2TcADKrC5WoPyKz4wQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix the hard-coded metrics calculation on the hybrid
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Khalil, Amiri" <amiri.khalil@intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:10=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The hard-coded metrics is wrongly calculated on the hybrid machine.
>
> $ perf stat -e cycles,instructions -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>         18,205,487      cpu_atom/cycles/
>          9,733,603      cpu_core/cycles/
>          9,423,111      cpu_atom/instructions/     #  0.52  insn per cycl=
e
>          4,268,965      cpu_core/instructions/     #  0.23  insn per cycl=
e
>
> The insn per cycle for cpu_core should be 4,268,965 / 9,733,603 =3D 0.44.
>
> When finding the metric events, the find_stat() doesn't take the PMU
> type into account. The cpu_atom/cycles/ is wrongly used to calculate
> the IPC of the cpu_core.
>
> Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
> Reported-by: "Khalil, Amiri" <amiri.khalil@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Cc: stable@vger.kernel.org
> ---
>  tools/perf/util/stat-shadow.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 3466aa952442..4d0edc061f1a 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -176,6 +176,10 @@ static double find_stat(const struct evsel *evsel, i=
nt aggr_idx, enum stat_type
>                 if (type !=3D evsel__stat_type(cur))
>                         continue;
>
> +               /* Ignore if not the PMU we're looking for. */
> +               if (evsel->pmu !=3D cur->pmu)
> +                       continue;
> +
>                 aggr =3D &cur->stats->aggr[aggr_idx];
>                 if (type =3D=3D STAT_NSECS)
>                         return aggr->counts.val;
> --
> 2.35.1
>
