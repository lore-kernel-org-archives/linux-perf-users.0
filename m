Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5064380FF7;
	Thu, 27 Aug 2026 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850935; cv=none; b=NSfB5kT5YOcGAQ54myvyNLzhdgjreVyZVQ9xQomrWgEo+9BCSUwKQHSOu9mBNGMMKjhWnAyr/wXEH8XgUXCw4ihze0bHCJ/8MoFYuFNwmphU9NbaOLZLdXSoTPFY3PMY8bt0+HX/ujDTgFn/Rjc8S1ahpZniPLlSvt9ndl1l4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850935; c=relaxed/simple;
	bh=WpasPaJ9xcduX7UHA5UZyCSC91SDyBuKj0LkeZOtSOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy9Mi2GEyhwVX9xWFJkBzLePGxcv0mpsTY/UeKms2Y9H6TMSJjNT4TKHtIMvI6gnxCvTzCGcv1uLabLYXK5YKcFOeM8y5XMRKxje/yCqGcW/7y60XFArf+VaXKqbe7OUBFcSBCG6LzJWa6gpAJfymjlraf2JfQw17zq03mfJCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LOTKxzn5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LOTKxzn5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D27D1596;
	Thu, 27 Aug 2026 10:15:28 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F25713F7D8;
	Thu, 27 Aug 2026 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787850932; bh=WpasPaJ9xcduX7UHA5UZyCSC91SDyBuKj0LkeZOtSOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOTKxzn5p/AkoQJ7PBJNwSjNBSp8gpcXK73cXC0GhcHQ6r7k7r0mc8F/jsyM0AKRY
	 /QwQz5TQClQsVnglpZUdMghT+ZoX+cLrL1OJofm3+aP+ynWJxyVKYCzYRupw1mek1o
	 U62qjMsG0smeawdJO85xjKR2OsachZzARvxRRaW4=
Date: Thu, 27 Aug 2026 18:15:30 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 10/14] perf cs-etm: Don't print missing buffers in
 snapshot mode
Message-ID: <20260827171530.GP8904@e132581.arm.com>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-10-00c4fd0701b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-10-00c4fd0701b4@linaro.org>

On Fri, Aug 21, 2026 at 10:49:08AM +0100, James Clark wrote:
> The driver produces lots of AUX records for trace data that was never
> captured in snapshot mode. Downgrade this to a pr_debug3 message as it's
> only an error in normal mode.

This reminds why we should use circular mode instead of snapshot mode,
so that redundant AUX records can be avoided directly in the driver.

> Signed-off-by: James Clark <james.clark@linaro.org>

For this patch itself:

Reviewed-by: Leo Yan <leo.yan@arm.com>
