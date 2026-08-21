Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829122DFA4A
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306308; cv=none; b=Yq+fSWmgDil1+xkbV5XWtIsdGiCsDZVtjnQCFk0ZofZADIZS8I0dHplR1guu9aX4/gCNNYDDOCXKszs+hv1WGp7vtDwRymv/jgPOhsaun/i2iFh9cjhxGivGvTWnq+T04e5JzpJK8qOsYUQ+5os2gGB37GKCa371qtuiwvowy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306308; c=relaxed/simple;
	bh=nBiZp4SCWdL0NJ9SlEaGsAAPOo26Lxe6pBE4QWB/QpM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TEeB1xQStBpmSW6gG5GLCuPY/qebYf7M6N/rhLj2lZCsYMAeBFH6HVmFcwSF7vzVWcP6uyqlAM18mh3xgsl0lPnC+fY+/TLIMgtEcMk8U6gGK4gNvx2fUuMg4YBHasjA4KvMC3ik6rjAiYouvKqW/2WdQdRyIiS/N7rDpRDUYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwaTJC9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwaTJC9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D499E1F000E9;
	Fri, 21 Aug 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306301;
	bh=nBiZp4SCWdL0NJ9SlEaGsAAPOo26Lxe6pBE4QWB/QpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nwaTJC9sCYaqoJGqPDxNItLmdwiR94KbsYjWWm3anbxim8J5F1A+rEMZhD6hquQXW
	 6y3BbBj5hKSF9DcxKgy3S6KbddNyh0U0IZE4NpoCVpPT23aV4BuDVA5lbc1flsDQWL
	 32lcDRecgM4DfeaK3u/chiCXu9QsYjqrBpJVezPIWFTKTF9HxLgQhUCKS3VMk8Mm2E
	 zDz+tUGxrwSlZgMW3UNHuzeSpKwZp/rfB4vleUhXOEIjIOuWQUaKmiEkWPJFYfSajH
	 1pZPRHPYx9RWq9ZmXQnVJF3aIKkC3ZH47bmesXE1s12zZ9ymFFt/d8VK5in6pPCa6y
	 Mt4nSwG+QJDTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/14] perf cs-etm: Increase default timestamp
 generation period
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-5-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-5-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:58:20 +0000
Message-Id: <20260821095820.D499E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The original purpose of timestamps in per-CPU mode was to roughly emit
> samples in the order they occurred across multiple CPUs, rather than
> emit all the trace from CPU 1 followed by all from CPU 2 etc.
> Previously there was no way to change the interval from the minimum of 1
> cycle, but custom intervals are now supported by the driver.
>=20
> Drastically reduce the number of timestamps emitted by increasing the
> interval, which is more than enough to interleave sample generation.
> This reduces the size of the trace generated.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D5

