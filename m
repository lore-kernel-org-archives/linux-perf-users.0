Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D73C198A
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252801; cv=none; b=cykDQY5syYTDdTdpt04uzA3JYGzquz1rVBqyFdyqPINImcr/7CDoKj1ZiCWo4GibqrkI5NVM727H1+Bqten4Fh0Sgx+keLfwcaVLyTpYrlT1o6YN7+/gtLTyMhIohvRnfZ4aDaxcj0SqazfB7/eWrAv31JL5/dOFwP1DzXbqMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252801; c=relaxed/simple;
	bh=W1vSLFVmXRLz+6dQ78b44QwaGAE42ymvV/G0v6dNOiE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ng2XXzveChZslQ+W/q2kcFNvk0fQ7pEbDsk15iYDJcHAIjkTaWrapsKA/eoYJ02cvAMKiHDiU6Vy3VCWdfysWrmqkUEBg3zGx0WsFlSPc1y/btybt99qONHpskjlSEe4A3QIkSrOGt6tL2edhsGkNwPgtcSkUFVeqzaT/yMaKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBVfya6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBVfya6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0878A1F000E9;
	Tue, 23 Jun 2026 22:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782252800;
	bh=GxEvoVvVe8zDLyIVh5OBeVuHbqft10YuwZkBhgqqNy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oBVfya6Tw9jKZ0XfHKpOIBjGerrR1s/XeYs1ab/9lAWCMRjHJoGMxCXcRmTPgJ7De
	 18ihSM5ILQ0tAjWQBOTP2joTcHupVUngJqRtDi0zotE9lyNNJy1YrQIgzqCCjTcC0i
	 v3xR+cfdC6tyfNm3+hLeYk8M07Ov7P/e3VlnfbR30bcNYzmbKtRyHqE3Vw/K+4OjIP
	 27A5JqL3kKw5jHet15qOLrXzKBdxy4w+zpl/+GZfT6j3m7/3TWJkiwFhbKxK4/ryf6
	 2/9Hv2ch3nLsg8z5d8whID3OMOeSSl95yQPUQ8HRv5f6YCN5WlCzq0+2UuOvkLz3ji
	 HeN7usjTLvQ1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/13] perf tests: Speed up lock contention analysis
 shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623012758.2291858-12-irogers@google.com>
References: <20260616164819.370939-1-irogers@google.com>
 <20260623012758.2291858-1-irogers@google.com>
 <20260623012758.2291858-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:13:19 +0000
Message-Id: <20260623221320.0878A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch omits the `-p` (pipe) flag from the `msg_workload` var=
iable, directly contradicting the commit message and implicitly changing th=
e test's IPC mechanism.
--

commit a71dd68d0ef76f3ef77f506f4808d8fbc7e5fa36
Author: Ian Rogers <irogers@google.com>

perf tests: Speed up lock contention analysis shell test

This commit optimizes the lock contention analysis test suite by introducing
a scaled-down messaging benchmark workload. It reduces the number of process
groups from the default to 1, aiming to decrease test runtime and trace
overhead while still exercising BPF filters.

> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests=
/shell/lock_contention.sh
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -9,6 +9,10 @@ perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  result=3D$(mktemp /tmp/__perf_test.result.XXXXX)
>  errout=3D$(mktemp /tmp/__perf_test.errout.XXXXX)
> =20
> +# Workload to generate lock contention.
> +# Using 1 group (-g 1) keeps runtime low while generating sufficient loc=
k events.
> +msg_workload=3D"perf bench sched messaging -g 1"

[Severity: Medium]
Does this assignment unintentionally omit the -p flag?

The commit message explicitly states the optimization uses the workload
"perf bench sched messaging -g 1 -p", but the flag is missing here.

According to the sched-messaging benchmark implementation, omitting the
pipe flag causes it to default to using Unix domain sockets instead of
pipes.

While the test still passes because socketpairs coincidentally generate
the unix_stream lock events that test_stack_filter looks for, this silently
alters the kernel IPC mechanisms and locking paths being stressed.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623012758.2291=
858-1-irogers@google.com?part=3D11
