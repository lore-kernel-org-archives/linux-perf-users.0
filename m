Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D063D3A2
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943394; cv=none; b=lOwonD4GF7qr60eQtq+BYykAqo9p8YNB9HY1vnSSlafxARzPx2XkW4YhIgUi07NZcmAGBpip/XIYByzUaOG4GdrgoXJGCI+BfwxJ5v0W0+iz9gqUkinYLe8MJxh2M+X7oGogOIoldBigS9m30Ow12Cz0woj2km2BzNP82X9lLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943394; c=relaxed/simple;
	bh=Ke54miP9qPXO8r90ozSakTSbFC4YfneMlK2tPjZAiIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CusejIs79UMzfoLZi0CWmWgGPMXd6s1zJPembFXE1Fei3wLIJRgryan3ABcsAuaGzMryPghkxPnHwtpsHTzqSTa7jPdbL6gRMNbPtG/nY03Dd2SjgmImPHbzgu9s9mu5zR1ygsRkRVD5NrhsxFOog+iE3fp9aNpmOQvo2v9BuOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BK6kBBIV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BK6kBBIV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d73130a63aso195605ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 09:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705943392; x=1706548192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3Z/N3HWA9Fx9t3+MwGeyiGSjVEKiMcJKgJqd734MGs=;
        b=BK6kBBIVDt0V0/Bkz3NXZmnogg7aRzefOIH4uQ79ZHXgyeF5Md9+kIQZ4QE5s7xkYS
         z6tKWnlu+m1CHbr6mt32XVMhVJtwbIhLZCQIi1MumOHA4to72neEHL01uWf0NNm6FI53
         1tn8AY/ujLrnbjyoO8kn2ugq6swEYxRUaMssNQ1bwh/ZWqV03mCeN545PnBTQ5oZ/oHq
         rKVaFDYBerDNbAWv5j6YdHwxkFK+x5aLEeBUys/bUANbzdWuQKC4DnCh6nKKkHjuMdQ4
         bsAbCs6tbXcErULLYl4dCVfjosHfBmHYIPJhHoRGf+nPg4OKVCPQyPzoR7xMy72yE/f7
         DwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705943392; x=1706548192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3Z/N3HWA9Fx9t3+MwGeyiGSjVEKiMcJKgJqd734MGs=;
        b=n7tUrll64hP7E+U3clsW4qf3gZaWbU3XlOSg4WTmi4lFUtbWBeuiN1PQfxzQA8j6M/
         FkJ0nS+cUyVXmdJm9HGYaF4Bf0c0s8yOcNYybk9eQzE210AI8E8/5AsLZFkv0EIbiN5b
         /s3KZrokgTQGXNdtVAgXPuWINKwwD3DpWzBWiE1d1P5p6KGT2NkcOKfTGh7GrIcCTpIN
         9op+JSquxxFSRJKnkC8MMUPjPt0bzJf4OnbdZLoCJb2RnDCdD9ijvqk+REGccyKxLehj
         0pC357q1tYmg2O3/1HzIQL9G19hCjjiOkCsW+0xzPCNzVhT/b9y8InUOSGLWiMjMJ9+i
         46vw==
X-Gm-Message-State: AOJu0YyJpyQnc7C+GB+cpRvTEZmmaB/3KUhjRbcWUB75waTvxjyOv4sw
	kASRJwsGBgPw+EOsQlTHWWs8WVqtT11KAdCjr3QfFjR2X3AB
X-Google-Smtp-Source: AGHT+IGBl9IjXc7ZJZzXWYN2C+6ruzyOyg7bBPx3tJif18W+5+Bho7RVySSGeT7B0NoVQaQg5G9xthYg9QZLs0Vpnko=
X-Received: by 2002:a17:902:dad1:b0:1d4:d462:f5a9 with SMTP id
 q17-20020a170902dad100b001d4d462f5a9mr340205plx.20.1705943391839; Mon, 22 Jan
 2024 09:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122155436.185089-1-james.clark@arm.com>
In-Reply-To: <20240122155436.185089-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jan 2024 09:09:40 -0800
Message-ID: <CAP-5=fX=GDGoZaACtPagB23k-1JGN6yaNgEdCS2QMnpz1htiyg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix session topology test on heterogeneous systems
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, mark.rutland@arm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Changbin Du <changbin.du@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James, I think the subject should be something like "perf evlist:
Fix new_default for >1 core PMU" as the change will apply more widely
than just the test. The test failure fix can be in the subject. You
could add a:

Closes: https://lore.kernel.org/lkml/CAP-5=3DfWVQ-7ijjK3-w1q+k2WYVNHbAcejb-=
xY0ptbjRw476VKA@mail.gmail.com/

On Mon, Jan 22, 2024 at 7:55=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> The test currently fails with this message when evlist__new_default()
> opens more than one event:
>
>   32: Session topology                                                :
>   --- start ---
>   templ file: /tmp/perf-test-vv5YzZ
>   Using CPUID 0x00000000410fd070
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xb00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 4
>   Opening: unknown-hardware:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             0 (PERF_TYPE_HARDWARE)
>     config                           0xa00000000
>     disabled                         1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 5
>   non matching sample_type
>   FAILED tests/topology.c:73 can't get session
>   ---- end ----
>   Session topology: FAILED!
>
> This is because when re-opening the file and parsing the header, Perf
> expects that any file that has more than one event has the session ID
> flag set. Perf record already sets the flag in a similar way when there
> is more than one event, so add the same logic to evlist__new_default().
>
> evlist__new_default() is only currently used in tests, so I don't
> expect this change to have any other side effects.
>
> The session topology test has been failing on Arm big.LITTLE platforms
> since commit 251aa040244a ("perf parse-events: Wildcard most
> "numeric" events") when evlist__new_default() started opening multiple
> events for 'cycles'.
>
> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/evlist.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 95f25e9fb994..56db37fac6f6 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -95,6 +95,7 @@ struct evlist *evlist__new_default(void)
>         struct evlist *evlist =3D evlist__new();
>         bool can_profile_kernel;
>         int err;
> +       struct evsel *evsel;
>
>         if (!evlist)
>                 return NULL;
> @@ -106,6 +107,10 @@ struct evlist *evlist__new_default(void)
>                 evlist =3D NULL;
>         }
>
> +       if (evlist->core.nr_entries > 1)
> +               evlist__for_each_entry(evlist, evsel)
> +                       evsel__set_sample_id(evsel, false);
> +

nit: the if should have curlies, with them we can reduce the scope of
evsel like below. It is also nice for constants to name the arguments
[1].

if (evlist->core.nr_entries > 1) {
    struct evsel *evsel;

    evlist__for_each_entry(evlist, evsel)
        evsel__set_sample_id(evsel, /*can_sample_identifier=3D*/false);
}

Tested-by: Ian Rogers <irogers@google.com>
(also Reviewed-by)

When testing with this with Mark's change [2] I see on alderlake two failur=
es:
```
irogers@alderlake:~$ perf test 74 -vv
Couldn't bump rlimit(MEMLOCK), failures may take place when creating
BPF maps, etc
74: daemon operations                                               :
--- start ---
test child forked, pid 553821
test daemon list
test daemon reconfig
test daemon stop
test daemon signal
signal 12 sent to session 'test [554082]'
signal 12 sent to session 'test [554082]'
FAILED: perf data no generated
test daemon ping
test daemon lock
test child finished with -1
---- end ----
daemon operations: FAILED!
irogers@alderlake:~$ perf test 76 -vv
Couldn't bump rlimit(MEMLOCK), failures may take place when creating
BPF maps, etc
76: perf list tests                                                 :
--- start ---
test child forked, pid 554167
Json output test
Expecting ',' delimiter: line 4971 column 2 (char 243497)
test child finished with -1
---- end ----
perf list tests: FAILED!
```
So I think this patch may be exposing other latent issues. I'll try to
take a look.

Another thought, rather than having an evlist validate we should just
assert the evlist is always in a good shape whenever it is mutated.
That would have avoided this bug as the code would have blown up
early.

Thanks,
Ian

[1] https://clang.llvm.org/extra/clang-tidy/checks/bugprone/argument-commen=
t.html
[2] https://lore.kernel.org/lkml/20240116170348.463479-1-mark.rutland@arm.c=
om/

>         return evlist;
>  }


>
> --
> 2.34.1
>
