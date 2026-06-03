Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7093E2AD7;
	Wed,  3 Jun 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507042; cv=none; b=SZG/iw8hlCjNdA9fOqJtxhAAf/edIxZU+gh/cBJTtgIvhZ6gJXIBWd+8SwLKlH53l5TwC6U4BTjAo/EJi8n3HPIkRdFKAi58X8hPerF9JaFpsnDhEtz11egzd6J8dPznSalrfLVjHrV6jRPTE5QiM9ecwN5TFnfFh1HtkNFGvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507042; c=relaxed/simple;
	bh=EJWYmAqAuHUMYPCeqOX+tr2xc0BoMIbtsUzZBmIOxMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFvBqo9K5bhSe4cAzWOnkGbl17UcFaMG/+PmwKBywYsbjCinc02A+K39HLPc8UukmHMaoncVYD8kMvye2xFFahBm7o4fAmdY4DFlQXazbf9D+gf2UtOkBw9CPld8E0f37oDIm7S0At4o7QVAeNLo08bOlIuHRh4H97vER3asJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IjB9EbEE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IjB9EbEE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99D04288E;
	Wed,  3 Jun 2026 10:17:15 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 208273F632;
	Wed,  3 Jun 2026 10:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780507040; bh=EJWYmAqAuHUMYPCeqOX+tr2xc0BoMIbtsUzZBmIOxMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjB9EbEEtCvBd/ypFuvIG6PuY2upEkS1zh6gEUFDluiNNGRcqvQZauFtpH3kGIdUu
	 +aTNNp/p1u6z/QoTmWQ7mMZa5CpRL+b7wTrwcDnuMkIKMK5vQDoXTte5GHEA3sSPPc
	 uE6LKIzlJr0HKytH5T05NIcfTtOpNnSuIaWQ7Zxs=
Date: Wed, 3 Jun 2026 18:17:18 +0100
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
Subject: Re: [PATCH v2 13/18] perf test cs-etm: Speed up basic test
Message-ID: <20260603171718.GD101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-13-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-13-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:55PM +0100, James Clark wrote:
> Like the name says, this should be the most basic test possible. Kernel
> recording is slow and already has coverage on the systemwide test. Perf
> report output also has coverage elsewhere. 'ls' also produces more trace
> than 'true'.
> 
> We only want to test if the combination of recording options works at
> all, so fix all of these things to make it as fast as possible.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
