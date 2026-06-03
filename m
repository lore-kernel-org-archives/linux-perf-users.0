Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6813A4508;
	Wed,  3 Jun 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495688; cv=none; b=j8DGM6PfytIaHQ+TQIbhQzDV+gU9liZ1XSoImdH172athUdLHHoP0DqUjB3StefdvR0AwVl/RNCgq4YSW1DGHV3x2JqfP6KjjryR0TLmB331BSmeKrvR2/ol/ok7cKdOtYkOnBc0qa0ZX8ymLIyv2sRVIT9DImd1gNkIRmGgApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495688; c=relaxed/simple;
	bh=J4lf7anc8bhIqqTujEh0dhSjQuwaw0eZ2Ppem51hTno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlTViEKQtWhOsT8lIU2C6d2xx5g3Z30bmFmto5V75Yg3dbVlKTMBtCST15bvy1LA5HDkP/UYCvrE5HVs0n+bUbhCkG+jDhUD9zJkS6BaV59gDVvJZMHaTvm3LeRYiNAoRd7ZJlG+snlFHBniiSjolSBbM/q3uTI1XhAD4UdkPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cZYXsPz7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cZYXsPz7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B0BA1477;
	Wed,  3 Jun 2026 07:08:01 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A54B63F632;
	Wed,  3 Jun 2026 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780495686; bh=J4lf7anc8bhIqqTujEh0dhSjQuwaw0eZ2Ppem51hTno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cZYXsPz7FqjxG8z0ST2KB10rXymP2b7jskj5ADyemTNYnrYytuu+892eQtA4MAk0U
	 DKAxA0SY/rhdlwxTc2NASHw8kQ9vpBhsjefAXtWuGYEbMDzHF4j/doDNnC3wi8+bST
	 EfHEkEP85TqWB3b7kmduuQ9TcQo/oosRiZ9oGbx8=
Date: Wed, 3 Jun 2026 15:08:03 +0100
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
Subject: Re: [PATCH v2 06/18] perf test cs-etm: Replace unroll loop thread
 with deterministic decode test
Message-ID: <20260603140803.GV101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-6-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-6-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:48PM +0100, James Clark wrote:

[...]

> +# Remove open brace lines as they may not be hit depending on the compiler
> +sed -i \
> +  -e '/deterministic.c:8$/d' \
> +  -e '/deterministic.c:15$/d' \
> +  -e '/deterministic.c:23$/d' \
> +  "$tmpdir/script"

Is this related to the function definition?

I can see the brace lines with change below. It might be more reliable
if adding unused function argument, which can give chance for hit
function entry.

  static int function1(void)
  {
      ...

      return 0;
  }

Thanks,
Leo
