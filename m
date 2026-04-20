Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88A2032D
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651264; cv=none; b=eUKp0byJcHZN+Ba3glAsZn4sYI/yy4I8xA1elYbIk+47CSgJ4y5prqhS5qedqyCgz/DpTaBeGvlUJ9sMJtMhSC32xxcVv3RxPlCFOZDJ+mF2a5Fc/hStN6QCcCOY4SepAvzGaRWUnTL09T4eegBbhRhR/o4RMgdRl6JHQd5Sxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651264; c=relaxed/simple;
	bh=+GnObtH4mnIFMxSJTvlPsmbPc3NfrCVIdMTBHQKQlxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F/uhYnItbvCkm+FpkJjQHCZKx+McUf6vFD+qevhzYBYqsiy2COp9GUz3JdEcGuAtqnXp2kET8bVbT9TW+Fgx94n8Da1b7bE7mhuHMqNkR6rWspEXlRQ+ZqvwpiF1vHg2PS1SdaoU/6rYws/T4xdC8WApkJSrMDIIQ3cXxsK43SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV3o/n/K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV3o/n/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C52C2BCAF;
	Mon, 20 Apr 2026 02:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776651263;
	bh=+GnObtH4mnIFMxSJTvlPsmbPc3NfrCVIdMTBHQKQlxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bV3o/n/K1D/5qdDg4G0JP3/jpTztmDPweQGFLLCGBoTP5btwU/svmWXUePa7SkP3q
	 DBYTHSdlCvEjAfx8kw0CBrm0Hww6y24fHtjz2wz5Jwf1bdeYUOlep+dmlXGfZEosiP
	 fVI0gTLFppS3csgj0V0smAakkb/uPe7RL5eZMpAD5xsMdoCL0LQkpwhiQZJ/+Pjsp4
	 M1fB+WS/o82uGPqrp730EU/HL8EAGgt+9DnPxQj91k4OCRkvA4/Evl6drI1fBTaEDo
	 +noMnXDAy61/yGUSpTa8QdOxl6naKvEUzamHrLvTWVJLJeXx7ZYVdUKdF4NGzT5DN2
	 gT4SOmlPUn9cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 23/58] perf python: Add LiveSession helper
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-24-irogers@google.com>
References: <20260419235911.2186050-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 02:14:23 +0000
Message-Id: <20260420021423.A3C52C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] File descriptors are leaked if `self.evlist.mmap()` raises an ex=
ception.
- [Medium] Events are not configured for sampling, preventing the generatio=
n of `PERF_RECORD_SAMPLE` events.
- [Medium] Unhandled `InterruptedError` during `evlist.poll()` causes the s=
ession to crash.
--

commit 124f0d8a2c7d1fd2c50503c9af92fd9cf4a5c8b5
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

This commit introduces the LiveSession class in tools/perf/python/perf_live=
.py.
It allows running callbacks for live events using perf.evlist and
perf.parse_events, avoiding the need to fork a perf record process or use a
perf.data file.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 0000000000000..81d92f720b586
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py
[ ... ]
> +    def run(self):
> +        """Run the live session."""
> +        self.evlist.open()
> +        self.evlist.mmap()
> +
> +        try:

If self.evlist.mmap() raises an exception, will the file descriptors acquir=
ed
by self.evlist.open() be leaked?

Since the try block begins after these calls, an exception in mmap() would
cause the function to exit without reaching the finally clause that calls
self.evlist.close().

Could the try block be expanded to include self.evlist.mmap() to ensure
cleanup occurs on all exit paths?

> +            while True:
> +                # Poll for events with 100ms timeout
> +                self.evlist.poll(100)

Can this poll call raise an InterruptedError?

The Python extension wraps the system poll() call. If it is interrupted by a
non-fatal signal like SIGWINCH, it returns -1 with EINTR, which translates
to an InterruptedError in Python.

Since the except block below only catches KeyboardInterrupt, would this cau=
se
the live session to crash on normal signals instead of safely retrying?

> +                for cpu in self.cpus:
> +                    event =3D self.evlist.read_on_cpu(cpu)
> +                    while event:
> +                        if event.type =3D=3D perf.RECORD_SAMPLE:

Will event.type ever equal perf.RECORD_SAMPLE with this setup?

The LiveSession constructor initializes the event list using
perf.parse_events(), which configures standard events as counting events
(attr.sample_period =3D 0) by default.

Because self.evlist.config() is never called to enable sampling or set up
PERF_SAMPLE_* fields, it seems the kernel will not generate
PERF_RECORD_SAMPLE events. Could this cause the poll loop to time out
indefinitely instead of invoking the callback?

> +                            self.sample_callback(event)
> +                        event =3D self.evlist.read_on_cpu(cpu)
> +        except KeyboardInterrupt:
> +            pass
> +        finally:
> +            self.evlist.close()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D23
