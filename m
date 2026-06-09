Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260843FF892;
	Tue,  9 Jun 2026 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025418; cv=none; b=AlfpduSLfJwGPJ/1qRorCQbzXkunLJMD/dyfHu4ngi8YNVhk6okwnMJ1kJHpEOEx7qXj1/5F0cgF4AaxFPNG2OWP9IWwSiDF8xWdnJLAbvRja7lcpGDou43nABAbMU8Piz/coqjAa3iBqqoM2AV5cOEPaCXmJsmzRWGw+s4FLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025418; c=relaxed/simple;
	bh=uj6VfsawIxBC/Rh5+CjNBCM34gQ4ZfhItp4SDpOcjMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhn4nnE4xpaFAd11RnJdlkIeiIgM+GqTiKmplAvls8gq6Jk5ai5pCkYsrPr5P9Ofb2iURcdUrTTPn9WWMhBvwA/MvMC0qaVOb2RbOlyaGV4Ki0Nx/R+pp5cOAnHUqAiYJoLe9B2aOdrdCkaFIVs2cjI3GaKmcjfZ9MPyCQzGzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a5EXCdY0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a5EXCdY0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4123D7A;
	Tue,  9 Jun 2026 10:16:51 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B75F3FD88;
	Tue,  9 Jun 2026 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781025416; bh=uj6VfsawIxBC/Rh5+CjNBCM34gQ4ZfhItp4SDpOcjMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5EXCdY09uk0/ZLXoxPOOzWkhxj/WFZQdB0zwfqV3q9S9rhxvDy3fP9c3vlKssXHN
	 D40FDGhaGXghEqx5O6QIcyCI/Wd1dRw7uXVcEDwZSpVzyUGtMcFiVZ/S8cExKaDNHu
	 6h0T19hrMXUiY+TA6KShbbYWMFPTX/Mjmarnbpww=
Date: Tue, 9 Jun 2026 18:16:53 +0100
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
Subject: Re: [PATCH v5 08/19] perf test cs-etm: Replace memcpy test with raw
 dump stress test
Message-ID: <20260609171653.GQ101133@e132581.arm.com>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
 <20260609-james-cs-context-tracking-fix-v5-8-d53a7d096a19@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-8-d53a7d096a19@linaro.org>

On Tue, Jun 09, 2026 at 03:40:13PM +0100, James Clark wrote:
> Like asm_pure_loop, this memcpy test only checks that 10 of each of a
> few trace packet types occur after recording a lot of trace, which isn't
> more specific than other existing Coresight tests.
> 
> Assume it was supposed to be a stress test for dumping and replace it
> with one that doesn't require a custom binary and checks for a specific
> amount of raw output. Don't bother checking for packets because the
> other tests that test decoding will catch issues with malformed data.
> 
> This also adds coverage for exit snapshot mode which was missing.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Tested-by: Leo Yan <leo.yan@arm.com>
