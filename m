Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625012;
	b=AUhR+xKLGESpiaV1ADav+H48HwM8oWk9NSH+68vVY5QAFTszh53yykSofXhVZrhaaK+6
	 2sGqiaNsE7DV0au3zcMhp3Vh6Mmoq7geyeLPDa3jd1AyJOWI1V4ihD1l8vY375pdNPm2R
	 1UQcc/oegUMmVOgty6Xdla638uyB2tB8ZiCxK+UxYRkwBVSNH/BcnJezW37ZnkikPCDD8
	 ung57YwNFK2NkiEokNel+pIdSEGEBE0er7wop7e+nU9AfYfL6DgYzvDDyPrPvSnKyi5HB
	 wnllRxk9ybU3AV9kYApREd0JkZdgfDYo5LyqqlXPhRa0dwhvUGGjACtKW1PZQwYcGUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625012;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ab973EQNbGucOhQ6oA/ZzxK3eP0627Bj14wPuM8aMpw=;
	b=r0esmngRqpuNvtvoq6DekKTJMZzEkQXvLoi6aypysXvZiB+HMXjlqjxoHEA/4eL6ARaR
	 w8iZgq/m6gL4tyl02onzRUR86LDFakkiPmf/pOROY1m4+YRNTm7iScew1Bqh2x48UgjV+
	 EUvp4JVgT9HB+h4AFv+bQJnq1S+Fkc/BkqjRBmYU9p1ZKp9fKmyJlowvFN+qckr7Vy/6a
	 jaCg98JJvsSv4Kt2fcI7YvusbN56NC2mFDr0tuYCviyyrPrV69Qn06jxa+DPlFp271ikB
	 9iEpbgv4swE1X5qezTDEnpJcXFAZl109oF6Hrs7TxUKEWIuUKNHdZjVLwY5RpgXZryw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzMdiosC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D14606A319;
	Wed, 21 Oct 2026 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzMdiosC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1A31F000C1;
	Wed, 21 Oct 2026 23:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625011;
	bh=ab973EQNbGucOhQ6oA/ZzxK3eP0627Bj14wPuM8aMpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jzMdiosCVFqagdzDaV/1YefvkeZX+pGf9owv9dt61k+xjmzyLi8INDpSW8yBtFnYC
	 IjP3byjB3hqWvORBZV9yFh9kX//+uFqqpcgXeVDtMqGJjIhvX+bVAg0yoW7EkC/rGm
	 qSHYZxL2Py6Aqa3md66ida7hlaSO8RXIOEuFKjB0Qsk8Eun7ugGUodD4c2bj2XGokX
	 fVk5w2ogPBurURrmKLe6uyhbWbIBPZ1Mw5Z6AuQYLHi/MnvNl0W9mkzGSd3IavHBPJ
	 k0tBPNZUSrxNjHKAkbBx4PZsXit4VLCqpeMihiWnjT4MvtcdKzhHxpS65++ydqJrqD
	 87QTsNldK9kkw==
Date: Wed, 21 Oct 2026 16:23:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/7] perf build: Add MINIMAL=1 to build without
 optional features
Message-ID: <atlJcgFIX31_NR9D@google.com>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-4-sashal@kernel.org>
 <CAP-5=fV_A+k-_g683q7n897YMudBwwvQPkS_cKRSdOxkEYFa0Q@mail.gmail.com>
 <20261018135332.3987231-1-sashal@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018135332.3987231-1-sashal@kernel.org>

On Sun, Oct 18, 2026 at 09:53:32AM -0400, Sasha Levin wrote:
> On Fri, Oct 16, 2026 at 08:41:29AM -0700, Ian Rogers wrote:
> >In perf-tools-next/linux-next both LIBPYTHON and LIBPERL are gone
> >(context in https://lore.kernel.org/linux-perf-users/20260926062029.800743-47-irogers@google.com/#t
> >).
> [...]
> >We should expand this with NO_MYPY and NO_PYLINT for the
> >perf-tools-next version.
> 
> The series is based on mainline, which still has NO_LIBPYTHON and runs mypy and
> pylint only when asked to, so 3/7 only covers those knobs.
> 
> I sent the perf-tools-next version on its own: it uses NO_PYTHON_MODULE and
> also sets NO_MYPY and NO_PYLINT.
> 
> https://lore.kernel.org/r/20261018135321.3986899-1-sashal@kernel.org

I've acked that, but in case you need it here:

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
