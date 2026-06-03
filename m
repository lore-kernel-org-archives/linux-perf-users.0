Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1287A3D7D77;
	Wed,  3 Jun 2026 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486067; cv=none; b=bqRKlMM3a4OMfFHCgcTulN/2X74ZfeVIEsaz6X6mk3V9kjghGzxdKmepqPKmc0r3DaqrhPmOdHzFDn5LCzd3fFZ9cjVwQgb4iT1IQVcyaZJkJAaK/KA0lajvLr16unFS0VThw5PRuC2JyvqL5GyjhQc5CO/0guwKJampOMuagug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486067; c=relaxed/simple;
	bh=uUloJLDR/+8k+kdIq3y/lojUZwX4d30zMUIMrvc+ZGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9v7GChkrZuC8s9+toJSxe37ZvKCDrNd4r9UoGJZ7wRAIKiVy74erm9O6X1Q+sW2B7m3IfM3OYCnP+1NiZdXPmOHKmOHeriw6YGsfxMj1C4UKtXTlOTGQlFI9XFMG8tPqdpfI/ExxN/N0IENCSRhAkE3CtghSnIPQRxvKXgzQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H4IF+SS1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H4IF+SS1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7467C153B;
	Wed,  3 Jun 2026 04:27:40 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEE093F86F;
	Wed,  3 Jun 2026 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780486065; bh=uUloJLDR/+8k+kdIq3y/lojUZwX4d30zMUIMrvc+ZGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4IF+SS1tB0UfSft+S7DQqbevfdPjoQppXCBXARrA+Dr5T3XsyCRTqSG59r+fCxJd
	 CjkJeEm4IEpG5tlve2EbRscHtP/HB1Bw8bGf0EV0RZFjWYXYCv7Mc/AL9Ga25Lt8iN
	 IhfCdiy7X6/d3FIXfP6QiKLWbPrm4f2OZdUExh+k=
Date: Wed, 3 Jun 2026 12:27:42 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 05/18] perf test: Add deterministic workload
Message-ID: <20260603112742.GT101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-5-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-5-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:47PM +0100, James Clark wrote:

[...]

> @@ -22,3 +23,4 @@ CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_inlineloop.o       = -g -O2
> +CFLAGS_deterministic.o    = -g -O0

I have no strong opinion for using 'noinline' in source or using the
global option '-fno-inline', just thought this is not easy to follow
up if anyone (likely myself) will write a new workload for disabling
inline. Could we have consistent style for this?

For the patch itself:

Reviewed-by: Leo Yan <leo.yan@arm.com>
