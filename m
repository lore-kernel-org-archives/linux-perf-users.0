Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5014C9579
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594809; cv=none; b=Hwskk4prwgdoQ0U921UJZ/fXrF7qu448KhLq/7Xb9VSLYPdvvcTSowdD5sqRfgZoSm8B8tv8uwXz0yctMvrcv1WPJzTsBar1GOnrEx5G6ezT7qYgsAC1+i+FJwVchgqrE7l6AIvwtfx/ucuspq9zgyXsYaWcpqyGYZuGkzLLvWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594809; c=relaxed/simple;
	bh=p1YTIWDfdex2r67Do4eJSc6rQ+viX2D3PmNC6xQ2QGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j7ZKBTrDO3UKrwf50l9sOQK+otI4zSntAiQGW0GhJDqOObwJuUkWeJR2eGVb35xsIMbhEPee5KbbmqSRmP8Gm8maLCSc+YA+41FhFmPV09/KdI8xUJHnI5zTQhWxbx+6DNcFxOflC21qdv5sCcwnUFc2aNsPhfKIf+5KRzqWXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLXXl00D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLXXl00D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2D71F00893;
	Thu,  4 Jun 2026 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780594807;
	bh=R0g3S7PG7NwjxmK5MNh610OCPYkECv0yHfMKu6GcJfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLXXl00DQgqztAjmjnDuvX7JuIZiGd69Pz67aSesJhXNcTIMVFA1yjy0YA4u/fmoE
	 SS64XsgyHaNUcmY/kl6eE9kv5OjKkDb7BH4Nnu6QES5iq8fgGizSxP5DAIC5dvrrJ9
	 68TlmnRbRP3vhoIWtp7+FLIc610YL8vGNIxUq2HhaDkuqVaFsgRkB4sAmn3hZPSsB7
	 pgCFrMifXXAtLqr5E0ivcKOEtT+Ql4J2B1LyLV7q6aIMMMlNQGyuTzNmZq5EBQjfOY
	 LEbZ6WYoOPwbTyvUL9S9J8TULQPJMx7nl5dPaNGSTfSH5UDA43x31aWNiCbUCfNzxA
	 dQUOU3u4iFP8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/5] perf test: Add inject ASLR test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604172850.683329-5-irogers@google.com>
References: <20260604172850.683329-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:40:07 +0000
Message-Id: <20260604174007.8F2D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Double execution of the cleanup function on script termination.
--

commit 15a772bdaa14c7c9486c156f196dc344720b9656
Author: Ian Rogers <irogers@google.com>

perf test: Add inject ASLR test

Add a new shell test to verify the feature. The test covers basic address
remapping for user space samples, pipe mode coverage, callchain address
remapping, report consistency, and kernel address remapping.

> diff --git a/tools/perf/tests/shell/inject_aslr.sh b/tools/perf/tests/she=
ll/inject_aslr.sh
> new file mode 100755
> index 0000000000000..ea0db1d5faf9b
> --- /dev/null
> +++ b/tools/perf/tests/shell/inject_aslr.sh

[ ... ]

> +cleanup() {
> +  local exit_code=3D$?
> +  if [ "${exit_code}" -ne 0 ] || [ "${err}" -ne 0 ]; then
> +    echo "Test failed! Preserving temp directory: ${temp_dir}"
> +    return
> +  fi
> +  # Check if temp_dir is set and looks sane before removing
> +  if [[ "${temp_dir}" =3D~ ^/tmp/perf-test-aslr\. ]]; then
> +    rm -rf "${temp_dir}"
> +  fi
> +}
> +
> +trap_cleanup() {
> +  exit 1
> +}
> +
> +trap cleanup EXIT
> +trap trap_cleanup TERM INT

[ ... ]

> +test_kernel_report_aslr
> +
> +cleanup
> +exit $err

[Severity: Low]
Does this code execute the cleanup function twice? The script registers
cleanup on the EXIT trap, but explicitly calls it here right before exit.
If a test fails, could this result in the failure message being printed twi=
ce,
or if tests succeed, might it attempt to remove the temporary directory
a second time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604172850.6833=
29-1-irogers@google.com?part=3D4
