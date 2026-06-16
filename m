Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D241A6803
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 01:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574066; cv=none; b=kss4yXE3HKdZ8+WyMNzBydlN3pc9j4RQjObwiKsd+ZWs1Ax32wQL72FG6Qz21gKtLFyZLnst1DJ/U9ipVeQli4yK9aOXLYBHarPxp0HT5pK1iAVgBzeQzYJcUvulp+1px2WLxmn45tQS01K6q7HTm4cF3nP4o6bLkHU/fYZ4PJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574066; c=relaxed/simple;
	bh=ZlcE/ic8AZ3CdBzw99XqDoqZz8ha/GT+/WR03p6J8cw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UTlpqiLlrP8f7ifIQxMkOqmxoHdRKziMvwWM05UO6aKtX9l5iUCUbDGmiSyHXwroAHUOOzLEHihTEffdtKG3fQbyvk6FRdcgovI0CaUGodiwTVx3f5BaTb13KfyjE660nVLtbKa2Fa38p4ERHc6MQgxd2MwMcvoWt8YjkTq1kU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii2/9h6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii2/9h6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563901F00A3A;
	Tue, 16 Jun 2026 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781574064;
	bh=fRJnBu31Qs9pS1DoxslbaYe80c8ylr4HGrmP/+3S9CY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ii2/9h6AVqbufxwY5T3e4EE2dP1r2c8UB39LcabG4upmieiPNaldJ7jcOV+Yf9yXc
	 UYGyuoWIwwANBEID/DYcmcLC9klBu3nZ2gWosRMbi4vhtrTKZVMJFppu5nAIeu6wbc
	 4ZWB1kHH/lWJx+OdPcSF9dDeceO9Cvta61TXqeUDRtH3GYrLWR8NA8xdSy36TLo4xM
	 m32qotW44cW2k5qbgFxwWeCKvVog0TqUEr3fKfkeacMfFRWNtGJtujxidfqOg1bgj9
	 wAe+5tUaaNrvoJ1c9SIcT9iNuHug+N5bCQ/SeSW6DPIUDmX4c9RJx1TpK4lX8HVLjg
	 mYkWMIJCqs9dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/12] perf tests: Speed up off-cpu profiling tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616012744.4049193-11-irogers@google.com>
References: <20260616012744.4049193-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:41:03 +0000
Message-Id: <20260616014104.563901F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Scaling down the off-cpu threshold margin to 20ms in the below-t=
hreshold test introduces severe test flakiness due to scheduling latencies.
--

commit 9a01b97619e9e9de7c1d6aeb44a8dcd7c6b1f2b5
Author: Ian Rogers <irogers@google.com>

perf tests: Speed up off-cpu profiling tests
   =20
This commit speeds up the off-cpu profiling tests by scaling down workload
durations and thresholds by a factor of 10. The sleep time is reduced from
1 second to 0.1 seconds, decreasing the total test sleep overhead from 3.0
seconds to 0.3 seconds.

> diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/s=
hell/record_offcpu.sh
> --- a/tools/perf/tests/shell/record_offcpu.sh
> +++ b/tools/perf/tests/shell/record_offcpu.sh

[ ... ]

> @@ -128,8 +128,8 @@ test_offcpu_above_thresh() {
>  test_offcpu_below_thresh() {
>    echo "${test_below_thresh}"
> =20
> -  # collect direct off-cpu samples for tasks blocked for more than 1.2s
> -  if ! perf record -e dummy --off-cpu --off-cpu-thresh 1200 -o ${perfdat=
a} -- sleep 1 2> /dev/null
> +  # collect direct off-cpu samples for tasks blocked for more than 120ms
> +  if ! perf record -e dummy --off-cpu --off-cpu-thresh 120 -o ${perfdata=
} -- sleep 0.1 2> /dev/null

[Severity: Medium]
Will this tight 20ms margin cause test flakiness on busy systems or CI
environments?

In test_offcpu_below_thresh(), the test asserts that no direct off-cpu
samples are generated, requiring the total off-cpu time to remain strictly
below the 120ms threshold. Since sleep 0.1 guarantees a minimum of 100ms
off-cpu time, this leaves only 20ms for system scheduling overhead such as
timer granularity, wake-up latency, and runqueue wait time.

If scheduling latency pushes the total off-cpu time over 120ms, the BPF
program will emit a direct sample, causing the test to falsely fail. The
previous configuration of a 1000ms sleep versus a 1200ms threshold provided
a much more resilient 200ms margin.

>    then
>      echo "${test_below_thresh} [Failed record]"
>      err=3D1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616012744.4049=
193-1-irogers@google.com?part=3D10
