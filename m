Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DCB285CA2;
	Tue, 14 Jul 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047847; cv=none; b=X/HT1S9bNBg/5EGfaqRFmYMTlIabeuRYvqesT4xu4ApdKM8kTC0fUUXIIvNsvNY368kXNjUmWWuBZCyitHZ+FdDmEvAAz2iDjmJFAxieO/fRZpIAhal/VBG5yVwuosa+yThJXTTx+Yat/TKD7ABM1j5XRwq2xDt0Heu2SMUlrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047847; c=relaxed/simple;
	bh=3ifxnirdEMSVUJEXYtvjlXc/CWOz0HqRMKFe0WAHQzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q3LWwG4BnYF2CUzhoNqqTG1i0gmLEySn4agw3grZEel5ialpJJ9iao7lWgzDT0OumcE2cH4T0g8aW15J9Yy7XYFj7cIcP/sctkV6U8zRswTVkVhdylODzYRMywQ2IT1tpE2SduHSK2kGSgg2Nwqw2qUGK+QXeO3CAZYFr4pXcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJjYpPrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJjYpPrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A801F00A3A;
	Tue, 14 Jul 2026 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784047846;
	bh=UZ+ssVjkRDV4y/CRybDbntm8unIymoRlFFOExyAPo8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lJjYpPrLco8C5pFSrSvz9yApEUy0ACKjGhX45HdU+T1BCn5H2P4UdIN5fBDNiMJw8
	 XYtmkx8GO3XAjIZ7b0gWL/LVAu4EVTHCVrAlk8eLwnaMH8EULFPaXCkoNznw7lJ4Gg
	 A8Q8lKJ17tFJRalKOb6ULUCvbNvTdRY2X3coyaQJcXeS2xxYiFZGHPEiWRJTdx9ER/
	 QVmKz7qPksQ9O9ivbXWwtv9wrXw8snfRvmoifvaprGNJuYI1iV/HugNvalNxvVZl+L
	 qfPtj+ZewC7tEAGW/DEiCFZeOdBvH0OqZzN2nugvqARfsQAJrZWtPvcMQT42clfQxC
	 4OPGSehbVZPrw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org, Trevor Allison <tallison@redhat.com>
In-Reply-To: <20260707000357.823509-1-namhyung@kernel.org>
References: <20260707000357.823509-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf build: Do not pass -static to dlfilters
Message-Id: <178404784583.1340197.1181201146380580405.b4-ty@kernel.org>
Date: Tue, 14 Jul 2026 09:50:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 06 Jul 2026 17:03:57 -0700, Namhyung Kim wrote:
> The recent commit caused a failure in make build-test for static builds.
> Let's not pass -static the option to dlfilters which is dynamically
> loaded as it's hard-coded with -shared even for static builds.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


