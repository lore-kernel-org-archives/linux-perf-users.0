Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1F52CCFA
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766625; cv=none; b=LF8RG03bUL7JT4BoTGhnrrTfAF5BlEAR0lD0rL3n0bs9iKr5NjqDqdydmSvYIA4CIVtR3WI4daXoG5cLchxTHc2cPVtY8GiEgRgFLz3+9o/x48p/F11hy1B67lXbdINGgyMXESj6zp+aMwQXUWB/xtdkSfCdvhwxGM0/1jy2hyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766625; c=relaxed/simple;
	bh=fQRqhWIwH8gjThcIMOF1q5n4l+/r38R/6YvT5wrNOGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=au3LkafndLnbj1NQsH1xh/ahQLrY9ekPDvpKrC3KHD24Nc0yVtuEYGfoZhQX7h0MPW/7hj093Bj3+7gL0NvO2BrKC22PLtQ+NPqegts/lfof3slP3hW20RmSRNCKqpKItAFYJzCGE3D4q5bnguY/ROHMBHmTHQHhl1x7DtkGnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux3aKcl6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux3aKcl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AAB1F000FF;
	Fri, 18 Sep 2026 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789766623;
	bh=fQRqhWIwH8gjThcIMOF1q5n4l+/r38R/6YvT5wrNOGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ux3aKcl6vPVJ/gkuUtZn7gYATx2DDghjQEYNjqq9F23HHZgwK17eCzYBoYOJzHi8n
	 nrfk68PUwJ/efYacQMMn343epKUNrwnPjYdPgsg+j2xeaV3I2AYn+YtzL6JaP871TN
	 xJe2FK4YFAJx0dp/cwK48BmmNyl0367Qi06g/IKIQppuJGFT1gJ6AAQp8rT7YD7ziB
	 fz0CvaHnh7fPKbGjj7NX0cbncKtyguGUETxKTB/iST7XV+sXB/jRb7QDuDaJtdnEHQ
	 NN1G5nQA95aatfZ8VGEGlv9eIbgSlZDS0F113a2GosCMzh8S3TW8Sxcjlw7/47Ty0C
	 /vil/f2bb2aXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/18] perf test test_task_analyzer: Isolate in
 temporary directory and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918211932.2966061-12-irogers@google.com>
References: <20260918140659.2501976-1-irogers@google.com>
 <20260918211932.2966061-1-irogers@google.com>
 <20260918211932.2966061-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 21:23:42 +0000
Message-Id: <20260918212343.48AAB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> test_task_analyzer.sh writes perf.data and temporary files directly into
> the current working directory, causing collisions when running tests in
> parallel.
>=20
> As a temporary measure until `perf script report` supports an input file
> option, resolve perfdir to an absolute path, change directory into $tmpdir
> for the test duration, and clean up in the exit trap. Remove the
> (exclusive) tag so the test runs in parallel.
>=20
> perfdir is derived from $0, which may be relative, so it has to be
> resolved before the cd into $tmpdir, otherwise both PERF_EXEC_PATH and
> the cleanup trap point at paths that no longer exist.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918211932.2966=
061-1-irogers@google.com?part=3D11

