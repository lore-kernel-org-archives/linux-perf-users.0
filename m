Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1B82D84
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Feb 2024 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330112; cv=none; b=gl4uDkWTW1S+A3KzjmHNQf8p3Aw6QzQgEUwdeDSukXBlIZ1RnHe35GerhZQkKDw42m26rlr3QWDsFj+TQDd5qWovMIH8f48eFQut4MQS41JQ4w7zmqvYJ+xt7u1fMxzAgUiO7Hf3GkRAJgwWWBJovlSW/3GZiA03j8hWYFVy8AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330112; c=relaxed/simple;
	bh=oUZHslalmQCi8QQC2yJIUpYsmPUmAiALsW68lE/Rb80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vF266m9J/YvP6XpRSud/jOWNu+pD8UdAAjS/6onSOnwRJOGKC7TbUzzZjkt6JrKk7yiXAaWbJ6aJ86rYQsgctFc3c+O0pKA0TN3DC5uo4QbfqcRT5BGA5IN2zUlJLYDX5vKJeOxY9S65VjHtddXphJxfK7mLhVuXlqJqjcczlpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cor7PLbj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cor7PLbj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d89f0ab02bso5005ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Feb 2024 10:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707330110; x=1707934910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WDqjwJwOfETzRG5eISHJ5xT9159gNm5IfIrF1ZnIaM=;
        b=cor7PLbjtTbS8DqGSsIbNgcmIRFHgO4qMIl2Rhl3qk8MiTMFrIEq6tH5prioyYFaNe
         Ib2F5H4dDGqrGCSDaFNZXtCZyVwi8USJs4X7Rs6T5H0GiU1coCznGY4pRHkE5EdJBGvl
         kz7glauX28X3VAwl9PyM7mdSpuZHPdEupUmmv9UfcafusdZi8nuitgVa9PcTyHkQpcIf
         RlEvomKWxom8qAl80iN7FJI5y/MzosFk1dqWiCwEy4/9qojMYBjqb3JuLvXLikc0cZRU
         AnMtiIlHUG96o7uLci+uPjaG0OdLp3wRZTHrN5jq5tkSOZ0uzhMDtiey6gAuqWWACkNU
         lvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707330110; x=1707934910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WDqjwJwOfETzRG5eISHJ5xT9159gNm5IfIrF1ZnIaM=;
        b=sl9KdLAlYqnOwcLSEI7n0WAywQL3gCViupSk9QGIJ/mpTQWDYP1bFslckOQ9/rLcoE
         hTBoR/5hHNBWiMBmHgHQB6vj+2YL5ZkNaIgduzFcktlgX79Qv+93YnE0bfq2gh1hjVEu
         X6Bidyj0ZMiBVo7tSlmHNlzZT3SfIygk0AVFEf61iwfswwyanYN6ejCJ9lIuAUUZHoDs
         Rpoa7NKvzw5MOR22kza2NN5GjK1ilEKSQ1rPODRkpENiJxiYVORstjvlzLOm9sdvnYfP
         Yl7ICQUVC/qh3KhSBqGY4yv4UCzBY6fqhsyI2QDnA6IYp3u1QxJA7HtzmHPoSHyO19DB
         uecA==
X-Gm-Message-State: AOJu0YybmBRAs4pY5HcyRhYoSUP4gprf7xMqiIZAMRUa84YYsM+0AQMs
	AsGpDIzLNSKo6zMAvFeVap8EsIAC8KIGrjimq7A1T6BFjHMS6/410W91NA11ZGobGWdSIQWJ8q0
	eI8GgqkMhcs93eOHhr/pv5nCiMTzVM702cEXk
X-Google-Smtp-Source: AGHT+IGq2gWu81yPlsmz+WrZj71vAdP22TF1lOOFg+ryYUw0KSTOUJwHQLTF8PJ9H8EeAJx3OF/vE2POGYvXYczhqYY=
X-Received: by 2002:a17:902:c94d:b0:1d9:e18d:2228 with SMTP id
 i13-20020a170902c94d00b001d9e18d2228mr212327pla.14.1707330109661; Wed, 07 Feb
 2024 10:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207091222.54096-1-yangyicong@huawei.com>
In-Reply-To: <20240207091222.54096-1-yangyicong@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 7 Feb 2024 10:21:38 -0800
Message-ID: <CAP-5=fVYdh-u=FhmLwNrTZPkP+oGLkzQjOw-RP3cB692oAZb2Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip metric w/o event name on arm64 in stat
 STD output linter
To: Yicong Yang <yangyicong@huawei.com>
Cc: acme@kernel.org, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, yangyicong@hisilicon.com, 
	linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 1:16=E2=80=AFAM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> stat+std_output.sh test fails on my arm64 machine:
> [root@localhost shell]# ./stat+std_output.sh
> Checking STD output: no args Unknown event name in TopDownL1             =
    #     0.18 retiring
> [root@localhost shell]# ./stat+std_output.sh
> Checking STD output: no args [Success]
> Checking STD output: system wide [Success]
> Checking STD output: interval [Success]
> Checking STD output: per thread Unknown event name in tmux: server-111496=
0                                                   #     0.41 frontend_bou=
nd
>
> When no args specified `perf stat` will add TopdownL1 metric group
> and the output will be like:
> [root@localhost shell]# perf stat -- stress-ng --vm 1 --timeout 1
> stress-ng: info:  [3351733] setting to a 1 second run per stressor
> stress-ng: info:  [3351733] dispatching hogs: 1 vm
> stress-ng: info:  [3351733] successful run completed in 1.02s
>
>  Performance counter stats for 'stress-ng --vm 1 --timeout 1':
>
>           1,037.71 msec task-clock                       #    1.000 CPUs =
utilized
>                 13      context-switches                 #   12.528 /sec
>                  1      cpu-migrations                   #    0.964 /sec
>             67,544      page-faults                      #   65.090 K/sec
>      2,691,932,561      cycles                           #    2.594 GHz  =
                       (74.56%)
>      6,571,333,653      instructions                     #    2.44  insn =
per cycle              (74.92%)
>        521,863,142      branches                         #  502.901 M/sec=
                       (75.21%)
>            425,879      branch-misses                    #    0.08% of al=
l branches             (87.57%)
>                         TopDownL1                 #     0.61 retiring    =
                (87.67%)
>                                                   #     0.03 frontend_bou=
nd              (87.67%)
>                                                   #     0.02 bad_speculat=
ion             (87.67%)
>                                                   #     0.34 backend_boun=
d               (74.61%)
>
>        1.038138390 seconds time elapsed
>
>        0.844849000 seconds user
>        0.189053000 seconds sys
>
> Metrics in group TopDownL1 don't have event name on arm64 but are not
> listed in the $skip_metric list which they should be listed. Add them
> to the skip list as what does for x86 platforms in [1].
>
> [1] commit 4d60e83dfcee ("perf test: Skip metrics w/o event name in stat =
STD output linter")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Thanks!

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/tests/shell/stat+std_output.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> index 4fcdd1a9142c..f46a0c9908c0 100755
> --- a/tools/perf/tests/shell/stat+std_output.sh
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -13,7 +13,7 @@ stat_output=3D$(mktemp /tmp/__perf_test.stat_output.std=
.XXXXX)
>
>  event_name=3D(cpu-clock task-clock context-switches cpu-migrations page-=
faults stalled-cycles-frontend stalled-cycles-backend cycles instructions b=
ranches branch-misses)
>  event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "fr=
ontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of=
 all branches")
> -skip_metric=3D("stalled cycles per insn" "tma_")
> +skip_metric=3D("stalled cycles per insn" "tma_" "retiring" "frontend_bou=
nd" "bad_speculation" "backend_bound")
>
>  cleanup() {
>    rm -f "${stat_output}"
> --
> 2.24.0
>
