Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFD3B47F3
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283866; cv=none; b=DqkQ09O8Jnmgb7iw5cacli56yoaCTT2iWRPe9eIZ8bYR51vRm9Ln6ay1XTTqGGWnuLVsv73cbnWm7k/8c0XyLH8uB4iaAB2/8jz+KjwBWQLc+fxM8Nt7pEOzutFS70nmdIfoPEP6vCFAY5HyhDgZ1TNvieLwVg1KnOlHrmeKbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283866; c=relaxed/simple;
	bh=GkI68BjoIRlt+yuqkHUrHptnpf/4W32Ly69NNyd830o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CiTjejoYnn+P4V8RPdF9ZAFQT0J0WOF3lmLSJ5+YKgmhmUts2ZIVfuJlmg2SlTRrdkTJSS8b0hgkTU6JCK1NUzP6xBX0GC+PhTEb8rXhHy5/Jlw49K8ha+troF7QfdWYP7FdnfeiJBiSwIlPwO6icJ60QFnRLmgTCmc929uPO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOSshMK6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOSshMK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D11C2BCB8;
	Mon, 27 Apr 2026 09:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283866;
	bh=GkI68BjoIRlt+yuqkHUrHptnpf/4W32Ly69NNyd830o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lOSshMK6Wc4l9kbjVxJAPmwu+CHZPP8zzVhtl7uRtD4oXj3+vWW3dxIWHOUCnns2x
	 8g3zo6TZxzz7cveQS+WfBl2cnTm07ImHibJA8f4J+23Xu6rnJDBPQgUzEuCacJ5PRt
	 OEN3d6HX4QA1CIXCGvfBgnlScM2XqJe3dzujNLIiYpOGRqCFS+ST6Tm4OJqqkKVJtf
	 Xcg2GGXl9j7ZTF0/4o6JpPb12Mlqep3INgPF9UcodSRz4m11CWGFTv7i3vmBoymFp1
	 o4i6YqKIZ9mOPak9vh91xSH5qENlza4qEnpzni4HOV7DB2fRpdwYIvYK+YF/YSg3I6
	 UI51Jx+JWfPzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf test: fix "trace summary" test for musl-based
 systems
Reply-To: sashiko@lists.linux.dev
To: "Martin Kaiser" <martin@kaiser.cx>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260427090225.794482-4-martin@kaiser.cx>
References: <20260427090225.794482-4-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 09:57:44 +0000
Message-Id: <20260427095745.D6D11C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The `ps --help` test workload is brittle and will continue to fa=
il on many musl-based systems that use BusyBox.
--

commit 41e18297314ee059526c7fb6d14d02d61ba92d64
Author: Martin Kaiser <martin@kaiser.cx>

perf test: fix "trace summary" test for musl-based systems

This commit updates the trace summary test to use ps --help instead
of true. The goal is to ensure the test workload triggers open, read,
and close events from dynamic library loading on musl-based systems.

> diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/s=
hell/trace_summary.sh
> --- a/tools/perf/tests/shell/trace_summary.sh
> +++ b/tools/perf/tests/shell/trace_summary.sh
> @@ -14,7 +14,7 @@ OUTPUT=3D$(mktemp /tmp/perf_trace_test.XXXXX)
> =20
>  test_perf_trace() {
>      args=3D$1
> -    workload=3D"true"
> +    workload=3D"ps --help"

Will this workload still fail on musl-based systems that use BusyBox?

Many musl-based distributions, such as Alpine Linux or OpenWrt, frequently
use BusyBox to provide standard utilities. BusyBox's ps is typically
statically linked or links only to libc, without depending on libprocps.

Furthermore, running ps --help in BusyBox generally prints the usage string
and exits without performing file I/O, which means no open, read, or close
events will be generated.

Would a command that natively performs file I/O, such as cat /dev/null or
dd if=3D/dev/null of=3D/dev/null, be more robust here?

>      search=3D"^\s*(open|read|close).*[0-9]+%$"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427090225.7944=
82-1-martin@kaiser.cx?part=3D3
