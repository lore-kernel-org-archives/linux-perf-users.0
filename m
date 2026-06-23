Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4547C3C141F
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252505; cv=none; b=UkHwJiJaz2HVIopxPiHvIsa0cnJE8EyupmAVF0DrPMbJwX2WK1GfjgQidd4lfwBbDaA6GXs+q1phWgrQQ+qRyl0gDssRrnnrwXA3oSmGqJEPWUDZnwsM5hneByyfQbS9p2gJEExRqM1PgB6YOgS6o9pL/P3x3NvqZ1JytGaJPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252505; c=relaxed/simple;
	bh=5mkXlvSST2CP51KbfVCKM5YshcKotMcpEaCmZ5DtGMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dX9rM3bR0Luc8jAd0OukSyFy4En/R2Gxin2oSbmqtJSbW0E6UkVyO0LpQQHCY8ZQ9KpN/SwtDsJrkYNQdZ4rsU40XRMMgg6j/gZSLTxas1tEearCPU6Qy5qgHDhC/WXpQQHR+HwPOOMz01jRAqNh+gU3CB0VMMMtrgX58tYLOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny3JsrA9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny3JsrA9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED421F000E9;
	Tue, 23 Jun 2026 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782252503;
	bh=fqKtojJZ8znNjPwSDPkufAlIGcF7RdnEFNW0ch3SrMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ny3JsrA9tenOot+eRSmBK5a0MLb817SdWPAcp2djcSst1jjChJU2Mke7r6z90PpEG
	 jcbFvQnRHf3YLROvZCRU8fOna+NkB7Zz3xHS/JBrMt9/EDtTYzGtmrfytm9Q4hESxB
	 vMdy955AX9Xu+XPpvuZToaPUqnObJAEmbN3HBwGYUOXLE6o0y/3N6LJvO0s3tuApea
	 0WeWbhfZnlT7zPeJLHVP3lOp/Ohzdq8o5cK3fRZ9cPMD4UfqtN1nF4mzE6y5bNl8qv
	 WlZfvf/sWYTsOfVTt4gL1LbPL4KKa2VvdwAVrqDTPC98+ud/m9k0SvUOMl7raBTWFd
	 3QJAM0BDCRDCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] perf tests: Speed up off-cpu profiling tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623012758.2291858-11-irogers@google.com>
References: <20260616164819.370939-1-irogers@google.com>
 <20260623012758.2291858-1-irogers@google.com>
 <20260623012758.2291858-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:08:23 +0000
Message-Id: <20260623220823.AED421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message inaccurately states the new total test sleep =
overhead is 0.3s (yielding a ~2.7s speedup), but the actual new sleep overh=
ead is 0.5s due to `test_offcpu_basic` using `sleep 0.3`. Additionally, the=
 commit silently lowers `--percent-limit` from 90 to 70 without documentati=
on.
--

commit 9b1dfc522cff7ce2083aaf529f3e6b60de599b14
Author: Ian Rogers <irogers@google.com>

perf tests: Speed up off-cpu profiling tests

The commit scales down the off-cpu threshold tests to reduce test sleep
overhead from 3.0s down to a stated 0.3s.

> This reduces raw test sleep overhead from 3.0s down to 0.3s, yielding a
> ~2.7 second speedup for this test.

[Severity: Medium]
Does this commit message accurately reflect the new total sleep overhead?

Looking at the test script changes, test_offcpu_basic() uses sleep 0.3, whi=
le
test_offcpu_above_thresh() and test_offcpu_below_thresh() each use sleep 0.=
1.
This adds up to 0.5s of total sleep overhead, rather than the 0.3s mentioned
here.

> diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/s=
hell/record_offcpu.sh
> index 860a2d6f4b75f..ee095df47358b 100755
> --- a/tools/perf/tests/shell/record_offcpu.sh
> +++ b/tools/perf/tests/shell/record_offcpu.sh
> @@ -57,7 +57,7 @@ test_offcpu_basic() {
>      err=3D1
>      return
>    fi
> -  if ! perf report -i ${perfdata} -q --percent-limit=3D90 | grep -E -q s=
leep
> +  if ! perf report -i ${perfdata} -q --percent-limit=3D70 | grep -E -q s=
leep
>    then
>      echo "Basic off-cpu test [Failed missing output]"
>      err=3D1

[Severity: Medium]
Was it intentional to lower the percent-limit from 90 to 70?

This modifies the test logic for test_offcpu_basic(), but the change doesn't
appear to be documented in the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623012758.2291=
858-1-irogers@google.com?part=3D10
