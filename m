Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7242E628;
	Mon, 13 Jan 2025 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778360; cv=none; b=eex80xJXYBbcz+oWJIQmYJwmOzJI1ag3tPZvPLRqNA2Y8sxtjJo14zRPwhAScce271okqAYd2zmggPop6EhXtyHy8eP+ybHs2cC/V8chvu3iTwAL2ZA+vaf/vrY5zN2TQbh2hlZoeVtQuiD4UWfsFEfMj6Aqp3ZSPTDNJtqPS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778360; c=relaxed/simple;
	bh=EP3pH/+ztEdEh+n7BRLJVNbr+hq+ohRw/giie9w5auw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfU31Y2fF0D/qRS9MMiGqSnEAWh5jwmb0CTYnEaWeRsP+HGo8iY31w11gs0EyRJvxRKGv3AViTlCTNcEncZG6XoA6FYg6+Xsaup33ZtWYeAvAE4X2blFV5thltVN3D8FoqtoJXdNkRti3xcuvGmj+5p+bWJmsVNdDWhq4fAeMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir6X3rQN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir6X3rQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA4BC4CEE7;
	Mon, 13 Jan 2025 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736778360;
	bh=EP3pH/+ztEdEh+n7BRLJVNbr+hq+ohRw/giie9w5auw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ir6X3rQN7FkEhXpBen5vQS/RfRIbaiWPsOmUYE5fBNLqz8GeJZ8axdwvWWBjmeI3u
	 UInUJ64NMKDab+jubaYaushVvJnY+E+yJi+zuQh96lDEqc7cW8riBkK4nm3cmw4Amt
	 vJvMWIeCq6i7ujjM0HaCPBCUunzTOViFjhv8IcujRWANXNXOGwDb8mnIwQz86ZSMge
	 msT43UQ+YQ8hQulUPVFO/umIvkfPiZ3UfFCxyWP2rXnGuA7I4XyDF7dVf+oB/clPeW
	 M0js7j4OU2bdH+X+kiicjbTyXI+w677Nw9f7ij7JgSkzrBXdLoM9HHm923/danu3uO
	 2791KZ2DLiLsw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401ab97206so4309041e87.3;
        Mon, 13 Jan 2025 06:25:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlkhyvhSIYIsFAFDhjMwAUmXR/o+2xhao9hkbD6EOn29irhugSLIrQ4roB96ctVsF8grU75b7gQR5hHvYOKowccg==@vger.kernel.org, AJvYcCXyx7q81UGbiktVV6bJ2IT2Pbxm4DWwNKeautynBvBTg0fnHTKaNtBc3AR3BgfMrgkQrIOEGh+Lf6nS9Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrA06t5KmhaUMdlVpGF1tfCO7Rrbac3KleAMq5t+GG17TLJIib
	0/IsKgOerNUnPCoJfDy3YtZ8yUsqUTIXSk1sKTOj7ARDO0EzeattFta17MG2NFWZK/PAHDK4BM8
	crCxftyI3UN6vEChGm+Q3oaOWdA==
X-Google-Smtp-Source: AGHT+IHPR6LI38cRMAUWX2FVbigUxaUXuBu3Tecz6/LlSSgkGrzbwHCYi0uJa2iD8M11/Xs8zKGh751ixtOcI5apmU4=
X-Received: by 2002:a05:6512:a96:b0:540:22e0:1f63 with SMTP id
 2adb3069b0e04-54284528df4mr6227523e87.19.1736778358376; Mon, 13 Jan 2025
 06:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213231312.2640687-2-robh@kernel.org>
In-Reply-To: <20241213231312.2640687-2-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 13 Jan 2025 08:25:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJqJzAvG1wVG2y_FBApVxF8wapP+7+xGXeZ2kHiCqy-jQ@mail.gmail.com>
X-Gm-Features: AbW1kvawPjOgvUkx9gTdS80budnTIBX569TueqNXCGivWWiNrcTwmPMwTn3XI74
Message-ID: <CAL_JsqJqJzAvG1wVG2y_FBApVxF8wapP+7+xGXeZ2kHiCqy-jQ@mail.gmail.com>
Subject: Re: [PATCH] perf: test: Speed up running brstack test
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:19=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> From: James Clark <james.clark@arm.com>
>
> The brstack test runs quite slowly in software models. Part of the reason
> is "xargs -n1" is quite inefficient in replacing spaces with newlines.
> While that's not noticeable on normal machines, it is on software models.
> Use "tr -s ' ' '\n'" instead which can do the same transformation, but is
> much faster. For comparison on an M1 Macbook Pro:
>
> $ time seq -s ' ' 10000 | xargs -n1 > /dev/null
>
> real    0m2.729s
> user    0m2.009s
> sys     0m0.914s
> $ time seq -s ' ' 10000 | tr -s ' ' '\n' | grep '.' > /dev/null
>
> real    0m0.002s
> user    0m0.001s
> sys     0m0.001s
>
> The "grep '.'" is also needed to remove any remaining blank lines.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> [robh: Drop changing loop iterations on arm64. Squash blank line fix and =
redo commit msg]
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Originally part of this series[1], but I've dropped any Arm specifics,
> and it stands on its own. No reason this needs to wait on Arm BRBE
> support (which I'm working on now). I don't expect to have other changes
> to this test related to BRBE anymore.
>
> [1] https://lore.kernel.org/all/20240613061731.3109448-8-anshuman.khandua=
l@arm.com/
>
>  tools/perf/tests/shell/test_brstack.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ping!

>
> diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/sh=
ell/test_brstack.sh
> index 5f14d0cb013f..e01df7581393 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -30,7 +30,7 @@ test_user_branches() {
>         echo "Testing user branch stack sampling"
>
>         perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u =
-- ${TESTPROG} > /dev/null 2>&1
> -       perf script -i $TMPDIR/perf.data --fields brstacksym | xargs -n1 =
> $TMPDIR/perf.script
> +       perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' =
'\n' > $TMPDIR/perf.script
>
>         # example of branch entries:
>         #       brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
> @@ -59,7 +59,7 @@ test_filter() {
>         echo "Testing branch stack filtering permutation ($test_filter_fi=
lter,$test_filter_expect)"
>
>         perf record -o $TMPDIR/perf.data --branch-filter $test_filter_fil=
ter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
> -       perf script -i $TMPDIR/perf.data --fields brstack | xargs -n1 > $=
TMPDIR/perf.script
> +       perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n=
' | grep '.' > $TMPDIR/perf.script
>
>         # fail if we find any branch type that doesn't match any of the e=
xpected ones
>         # also consider UNKNOWN branch types (-)
> --
> 2.45.2
>
