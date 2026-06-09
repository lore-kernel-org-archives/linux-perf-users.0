Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35784ADDAC;
	Tue,  9 Jun 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024683; cv=none; b=NgqIdWnDN3ohvoG1WCb9pRKcCotveC+mh1nWudtdWKw/dcLsS3/LGcH7PxnteM1/HpccoRZzoOZGSP4ilTxboHlSCACyqs4XaykIdXv9sKPYgNnpnxKARK3YrfjnaPBBFXwMS5bf4+vAOw2xyYZGqyexab16er0HSE9xxgi37N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024683; c=relaxed/simple;
	bh=jnKL74vtEEl5TEsaGZturjU6Ty1Crwee9CNWBBSOBzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEf5HKkI0nwmK+Sn10Xq4Qq9ETekKdvI4CYxFgkZQ/rldL7UwHtBWREOVLIbVZGlBP2L+bTmBC1WE7DU17t2FVeKuMSQQoiQRuZ6GeF25iLOI7cuFRIlUMrJzVSCGw1rSYCdGqruE2EuPQnRAdjEXAgS7CZvoUqi6cZ7SVVUPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LOqyjgl3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LOqyjgl3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B2C83D48;
	Tue,  9 Jun 2026 10:04:36 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CCFB3FD88;
	Tue,  9 Jun 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781024681; bh=jnKL74vtEEl5TEsaGZturjU6Ty1Crwee9CNWBBSOBzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOqyjgl3lbndJMFYmoAmPoNqTWBrYGQf/WeheT5JhGkhKD36cDcv4be9UUnCffRXt
	 Vl+9xg+hPGiBCs6DWPSpi3vmNYKJElixy+MLkobaZEiTG9eF/YWNAWDl+tH3v37fLy
	 q/1PLMGinPKw/fCMwcwcBxRNkMYaDLG7x4gHG8QA=
Date: Tue, 9 Jun 2026 18:04:38 +0100
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
Subject: Re: [PATCH v5 06/19] perf test cs-etm: Replace unroll loop thread
 with deterministic decode test
Message-ID: <20260609170438.GP101133@e132581.arm.com>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
 <20260609-james-cs-context-tracking-fix-v5-6-d53a7d096a19@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-6-d53a7d096a19@linaro.org>

On Tue, Jun 09, 2026 at 03:40:11PM +0100, James Clark wrote:
> Testing a long sequence without branches seems like it would be better
> as a decoder unit test, and this test doesn't test decoding either, so
> it's not clear what bugs this is trying to catch.
> 
> The new deterministic workload has somewhat long sequences when built
> unoptimized, and we can always increase them later if we want to. But
> now we test that decoding always gives the same result for the same
> sequence of code which we've never had before.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Tested-by: Leo Yan <leo.yan@arm.com>
