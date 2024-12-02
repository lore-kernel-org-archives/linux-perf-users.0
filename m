Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A771DE8A6
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Dec 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168500; cv=none; b=P2GN9iDTuINljrw2Lam66864WeBJVq1SnPKDY56XHsOVEFLhsmYmfsLUXEUTn7UZrPFD3l64CHzUJXGhjJ6XO2Z76SPHE+OrjxUcrlPHkjLXyV86TzeaniKZ/x0xrOPqbfp+5ssTnDEt5oJYGRtTzwJWZJMe/mG8r9q/tdipp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168500; c=relaxed/simple;
	bh=As/FOErKvBYbGJn88WHC2HsCL7lbQfLVl4/Hjnx2LNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rI5+F8X6nuApAb8Mfyw7mOzg7WGLiKv/D2evCdXxtEAvYs8Ps9JbE6hgLsS9tezIpFayfmPzCd2FA6XkFIzm729tYdmG/D1PuQ8ZwcD7extzhq5teMDJZ5Mrh8scdUfdIeudwia2QNFmi5U56QNtc38AUFgSKRM6j3oXGaBD3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4v7PmnEg; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4v7PmnEg"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a7bc2d7608so598035ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Dec 2024 11:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733168498; x=1733773298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0iSdNhnjULIPyo2eRYyGtVtHmGQVMsGxnXK3XxUefU=;
        b=4v7PmnEgO76Oqv7CSwIa5OIOZF7CMTMoF6cFQKPycSPV3a2nlxdA1PjevLQRwaNSxg
         8Ml18Sf5t7fQnuL2hEax/dLTh+QdCcrHGhgb1GxzPovn3rknByHv357aNHh0IyXeXCQx
         57l+VhfR7GClwHI/rKrGw2bOXG3J37kKcOGUWfDmAGE25eYYomitQ173wYWsE3cAKTqo
         fH8h4Ljp+92NXn8ne/qDsA2ootssard2pm9LL2Wi79dcbmPGVLd4Ri0RI5N5DQaLxvIn
         Q6KjPMyLFqR0hZFzkauC7JwFq9Nl3fue+mirMMAS4NfsD9Nuwiz3ff06r39eJejkOBc3
         RwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733168498; x=1733773298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0iSdNhnjULIPyo2eRYyGtVtHmGQVMsGxnXK3XxUefU=;
        b=PSbkcOPQqm7ybRwq51Db6zBLmBE7hMGiUK9ObcHNqFZ5QnyromT8DhvsfALDoNMcjB
         tczE/580pu478gp2LIHFQXK2I7lbaC9Rtgx+ALC+Jcg2y4IT1lckFulvFBl3JEIMnTgf
         fwN1LXtxIRGSeAXH6+5DnnGVsLhCJvMRVsK8n+pViAsXwz2Lo6pp8Hogqyb3iPa5xnHh
         V+PipBAkxxioGj9T1wOLYPA+ZeCWwWjOkVZeGlBUrpGuNTTwT9/IJBfhxZ/Kon+ayF5o
         2fAawRaJPC7Lx679xX+s8MMOvFUFH7WNOxnLBUIx/I/1xsFUIHMi4yfoKdhOfltrf4NX
         RaLA==
X-Gm-Message-State: AOJu0YyzYDehFWYxivRlvxw+5MTpQTq/nHaKIGyts+yFUo39I+SmisO1
	cEsEMcpX6f++QLX8RmLKORlLC01KeTygCM+rdKihMF8ww/GC/MvA2kUMoEj004imolstP8Nrm2H
	cC3xIaJuuEhoKfe+ZHbFt/4AhNbIgY6MjbOSp
X-Gm-Gg: ASbGncs9xtHpiehUfaTmybRQCU5bZ0GY5j7clP58sDLEPBkFf1Vjq+x/QXLY/Ii3B1v
	G5+MKinws7aeZX1MBmU1LSyPR/j+ukYdB
X-Google-Smtp-Source: AGHT+IF4vCGxTeBduPcSx0FlsZVC4RXwdR4sgnRQ2tIfTGKloCqxfN7XIU8iOIPKkOQpfhJQtWNVMsYNCOtxj5lET1M=
X-Received: by 2002:a05:6e02:320b:b0:3a5:e506:162b with SMTP id
 e9e14a558f8ab-3a7cd11fcfcmr10676225ab.11.1733168498253; Mon, 02 Dec 2024
 11:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129151948.3199732-1-james.clark@linaro.org>
In-Reply-To: <20241129151948.3199732-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Dec 2024 11:41:27 -0800
Message-ID: <CAP-5=fWvxxZzxuFjiPCfNgY0uTLo+VL-az-Wig6mmi-H4hs4uQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Don't signal all processes on system when
 interrupting tests
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 7:20=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> This signal handler loops over all tests on ctrl-C, but it's active
> while the test list is being constructed. process.pid is 0, then -1,
> then finally set to the child pid on fork. If the Ctrl-C is received
> during this point a kill(-1, SIGINT) can be sent which affects all
> processes.
>
> Make sure the child has forked first before forwarding the signal. This
> can be reproduced with ctrl-C immediately after launching perf test
> which terminates the ssh connection.
>
> Fixes: 553d5efeb341 ("perf test: Add a signal handler to kill forked chil=
d processes")
> Signed-off-by: James Clark <james.clark@linaro.org>

(Resend as plain text)

Reviewed-by: Ian Rogers <irogers@google.com>

Sorry for the lost ssh connections :-)

Thanks,
Ian

>
> ---
>  tools/perf/tests/builtin-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 8dcf74d3c0a3..4751dd3c6f67 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -508,7 +508,7 @@ static int __cmd_test(struct test_suite **suites, int=
 argc, const char *argv[],
>                 for (size_t x =3D 0; x < num_tests; x++) {
>                         struct child_test *child_test =3D child_tests[x];
>
> -                       if (!child_test)
> +                       if (!child_test || child_test->process.pid <=3D 0=
)
>                                 continue;
>
>                         pr_debug3("Killing %d pid %d\n",
> --
> 2.34.1
>
