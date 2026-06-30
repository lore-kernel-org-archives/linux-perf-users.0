Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB529C327
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863857; cv=none; b=eKYua4hI7VtenQtfPwuIIXIq+WmwH2DGDcpuNOXkjm0jIwtiN7r81uf9RzlhqzSgWwI2SNMR7AmvBlLk2iIlcailqpZCoWlIJ9QqJyjv+qe+81EKph8enjps7YuudXcEXCndRg4/07L7XQqk47FNuT5nCnd/slls+NUvwEdu8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863857; c=relaxed/simple;
	bh=x2ZZuVaiC2zr+BTS6zxzzK7ekvdv4n+hwgoVyVElBnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmWvDfqOM0dEB4tMgyGfAXXcxC5mDyGIzfuTLDBohOHOI2v8KQBOc4Ahb3z2kGjxFgr7Kve6TblmlSOV1lmE0kLUJ720qOMRaZIdsjtL82KtQggq4GDVMSI1Tf7T0s2v/XBaVJfkgLZvYs8x+xBjRh5QYt/XkpoxL8FCnsgCzZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djzz9z6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djzz9z6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6335F1F000E9;
	Tue, 30 Jun 2026 23:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863856;
	bh=TaUmh35sxDvqnamEeZFXqUgtr3RL3GsntqnPFMBABso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=djzz9z6MaeeZ2zZWqEaUCyi3XnoC9wIGRb23nUT0LAMSA3FQm+D6f97gsGsR2QAkD
	 LN27vCbG7SEVGF8A6vjBihlYrSU1tQAaIoVIpwhtAyPcvXu8riZiHsq6buApzZLLpg
	 y8qzqalREwXjSRq/H73PBssqV06FXQ79ftZXRGPZVjVm7ehTOfTfKhZaVLYD1rs61N
	 MJIK5vLD6hqtdsEnyex9msev7FufS6vShwmViONIuVyVfgtqrhMDhc4ek/LvL/N7SO
	 x2lzclSQOCpYkNgnfu0I7Ys5D3JfeZJF0rzmOUxnKdz7hVNg9hrBCICrX0CPooe2CP
	 TidhJfIXAgpMg==
Date: Tue, 30 Jun 2026 16:57:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH v10 0/9] perf cs-etm: Support thread stack and callchain
Message-ID: <akRX7gwfDh01AD4-@google.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
 <akMPoLNBbAEyNU64@google.com>
 <20260630082310.GE1812158@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630082310.GE1812158@e132581.arm.com>

On Tue, Jun 30, 2026 at 09:23:10AM +0100, Leo Yan wrote:
> Hi Namhyung,
> 
> On Mon, Jun 29, 2026 at 05:36:48PM -0700, Namhyung Kim wrote:
> 
> [...]
> 
> > Will you send a new version or want to merge this?  It seems there are
> > some remaining comments from Sashiko.
> 
> I prefer to merge this series.

Hmm.. it's not applying anymore..  Please rebase.

Thanks,
Namhyung

