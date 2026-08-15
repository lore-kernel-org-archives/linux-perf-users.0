Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF661A8F84;
	Sat, 15 Aug 2026 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838084; cv=none; b=aHWArF+OoQJLIlyqpRuf6IKOgJVGf2JO9hV84v+8ORHvscnNyWNO5o9B2eX3g1A6pbEtCOa2Ezhnf0W38+Uujg8ZOOF2zjHXYFQ5xI8cXa6eg6e971Uqq+4SOMirpO5hhmFZl6YNxbqRyzakdFR79Vm8K0FsB2ipRQ6zr/V5A74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838084; c=relaxed/simple;
	bh=8vOKezJLCdFtwOV6AG+vjKRAiWIbgPE16r2u0spUYhQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Uu+iVt4RluOVH4jM7kvM5ky7FR9LmSSZvLFTH4Li+aud3NWaEfHMnitKe7jQ1f2491Uid2mwnGVK/gUIo07D23ClUXuIAbu4QgvN/KPkLFxcM1c0kNQRXDiiq3e/ConprDzHmJceJLTMFphp6Lb2JpNBeItZlRs9A5Ry7nQeHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGCZSHFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGCZSHFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1FD1F000E9;
	Sat, 15 Aug 2026 23:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786838083;
	bh=p+xVToHEIC/p8mzN2MnlSzxDO0X5cy64dlPT9ty5IK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MGCZSHFbrrWbq4mynZjmitAVD/9QgvCoJ9E42YGQHR0vjJH5NJGZe2Nfc1mjHk/1J
	 gfRilpZpiPnf81YSOAEYbHfIQfTFLtXzDAfEMNjTqooqRIoAqrY5wrAemQ/uvKilGu
	 OLu/7swUB8sLpWJeXP9VYdlwt5+0pKaxut6yeEFNbD2Y6m3FmqS2jLBAmjjimoROA/
	 +bjeUuxtw0hgh3tnGcpPOq1F/mUTc43VHG7LuLeDNz9PYOiOu1RcZd8cPnUzm7VOxX
	 gT9FEqXZxkXcigh1IvDjuijWTuT8YUQzL2xknpoloqG5Mf2RD9J7vrPDneQgVVNuza
	 /m1AHdZlrzroA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260813151148.23169-1-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
Subject: Re: [PATCHES v5 0/5] perf DSO hardening series
Message-Id: <178683808271.3302182.634363162393617305.b4-ty@kernel.org>
Date: Sat, 15 Aug 2026 16:54:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 13 Aug 2026 12:11:41 -0300, Arnaldo Carvalho de Melo wrote:
> 	Please consider merging,
> 
> Five hardening fixes for the perf DSO data handling code path, all found
> by the sashiko-bot AI reviewer:
> 
>   - __open_dso() can return a file descriptor of 0 (stdin) when
>     dso__get_filename() fails without setting errno, so fd = -errno = 0
>     looked like a successfully opened DSO;
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


