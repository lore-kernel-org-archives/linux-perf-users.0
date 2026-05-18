Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FDF390CBE
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132790; cv=none; b=g4I89jZV39zH+20xkKiTVEbug1xLnVOvqGRPyuCwE51jRSnmcA0ArxCNs9pfivQ5isCxBYNVLzDEl6ECLrRpC8HSOgb4RozaqiljinEYd6TXLqZCd1+O2L8Pc2IQhypv2THlp4QmQnsK0VSKmuupv6o3BO/Kgv931TXdegTmXQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132790; c=relaxed/simple;
	bh=uxHk8tzERR71Weyu4dAxaIZR8G0eKKY7T7vgwwQ6x+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c0saPwnosHUHa0CUxslBMmhzbPpZB/fKHg0vPuUb3Oeca8W6oLLCIZPrDxk+gwDoWbuWXxlOH+a4GGlxyplCw2rmgYuj0WZHqJbPC79D6wzs/z0LZWYeDgPfJGowD3c60sDmvH0/t3AN8tvUzRpZzwpCkgvL4D7YWJg80JJ4Dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPw72/6o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPw72/6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D5CC2BCB7;
	Mon, 18 May 2026 19:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132790;
	bh=uxHk8tzERR71Weyu4dAxaIZR8G0eKKY7T7vgwwQ6x+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YPw72/6ollGZZ4GOGgYiNg26ZANo1451n7kymmxvmk+ZsuudGagpYB7+g6L60nLTT
	 8/JVUdkMlCLmWt5yn6yOiFDpYxFIF78m4g/+ovaZo4G44ZTLqDffDPOpQdrqHuh5Gu
	 l9LFga2pC7FXgtK5eP07523uwuMw+fkWO6J9B7rYla20lP92tGleIISDIgcxTkTKnF
	 jclMAwzlnFlpzTQ4dXuzUrHHFrCbezVUEdczB+ORzkwoGtBeJ0YfzvKNTo6Nw55u+N
	 0/JkdtwuNaoswr3kUtu+GmwjM9RAE4NekyezZXU2xXzA6w+QbWXZJL9MQsJFnPa9mH
	 7RcTAW6utYxcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf tests: Add test for stat delay option with
 duration_time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518183920.2894502-3-irogers@google.com>
References: <20260518183920.2894502-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 19:33:09 +0000
Message-Id: <20260518193310.00D5CC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The test lacks a lower bound check, failing to verify that durat=
ion_time is actually ~1s as claimed.
- [Medium] Parsing formatted counter output assumes commas for thousands se=
parators, causing silent test validation bypass in non-English locales.
- [Medium] The test uses a tight 1.5s threshold for duration_time, making i=
t flaky on heavily loaded systems.
--

commit c6900a5f9502c500776ded0f9cab3bb2ae678d17
Author: Ian Rogers <irogers@google.com>

perf tests: Add test for stat delay option with duration_time

This commit adds a new test case to stat.sh to verify that the duration_time
event correctly excludes the delay period when using the delay option.

> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat=
.sh
> index 4edb04039036e..e9a9b2c91cae3 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
[ ... ]
> @@ -483,6 +483,38 @@ test_stat_pid() {
>    wait $pid 2>/dev/null || true
>  }
> =20
> +test_stat_delay() {
> +  echo "stat -D test"
> +  if ! perf stat -D 1000 -e duration_time sleep 2 > "${stat_output}" 2>&1
> +  then
> +    echo "stat -D test [Failed - command failed]"
> +    cat "${stat_output}"
> +    err=3D1
> +    return
> +  fi
> +
> +  duration=3D$(grep "duration_time" "${stat_output}" | awk '{print $1}' =
| tr -d ',')

Does this correctly parse the output in non-English locales?

If the locale uses periods or spaces for thousands separators instead of
commas, the string will retain those characters. When bash evaluates the
integer condition later, a string like 1.000.000.000 causes a syntax error.
Because this occurs inside an if condition, the script will silently bypass
the failure check and incorrectly report success. Should the perf stat
command be executed with the C locale to guarantee a consistent format?

> +  if [ -z "$duration" ]
> +  then
> +    echo "stat -D test [Failed - failed to find duration_time in output]"
> +    cat "${stat_output}"
> +    err=3D1
> +    return
> +  fi
> +
> +  # duration is in ns. We expect it to be ~1s (1,000,000,000 ns) because
> +  # sleep 2 runs for 2s, and we delay by 1s, so measured window is 1s.
> +  # If it includes delay, it will be > 2s (2,000,000,000 ns).
> +  if [ "$duration" -gt 1500000000 ]

Could a heavily loaded test machine or CI environment cause the sleep comma=
nd
to take significantly longer than 2 seconds? If it takes 2.6 seconds, the
duration would exceed the 1500000000 ns threshold and cause the test to
falsely fail.

Additionally, is there a need to check a lower bound? If the delay option
breaks the counter and duration is zero or abnormally small, this upper bou=
nd
check will evaluate to false, which bypasses the failure block and leads
to a false success.

> +  then
> +    echo "stat -D test [Failed - duration_time ($duration ns) includes d=
elay]"
> +    cat "${stat_output}"
> +    err=3D1
> +    return
> +  fi
> +  echo "stat -D test [Success]"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518183920.2894=
502-1-irogers@google.com?part=3D2
