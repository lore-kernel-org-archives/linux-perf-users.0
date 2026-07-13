Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FED13DBA0;
	Mon, 13 Jul 2026 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966446; cv=none; b=OUq+elMXta34rpfKdupyLYtABsnc36JvjlcxtpVD9rUNR9ws4vlknuMOBmMEPDdOH0hhWnOU9HSADh09z8nq2+GPYaQ+OptMLNfN0d0YnziaAl8MR8+m8UKWg7ySGIQS47GoOqEiHuvxVWvpU8kJwkLrSVugKeFAAD+/Ap676fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966446; c=relaxed/simple;
	bh=PNW6uEQALQYHQ3Nbes9vNsK5XboWo/lfLt5aFg1E8Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKH72P948YnkHjAd5st9+IsDPilAac3C4HAREEqWeqAZgbXaWr3neObo9Ty1J3z5ZX1j4QkST0Ch+SRKYHZeG7JnmBJxlenI9FyLU5Q+ZjY63A0JnDUE3Y4UKPXCTfljsBTeuUWmIdqjww5w/WaU2nvyamJnHPEiF9htildHWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mSfYALg4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mSfYALg4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 058811570;
	Mon, 13 Jul 2026 11:14:00 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D56743F7B4;
	Mon, 13 Jul 2026 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783966444; bh=PNW6uEQALQYHQ3Nbes9vNsK5XboWo/lfLt5aFg1E8Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSfYALg4p80BtA2eQgipigPvzE6gagodqspOCUyiKymoUOgYtZ9hL223nIb9I5yd9
	 cN7fXlP8+JWzT3K9YaMW+6co12uKpSYvgY6hnZ1zcx9H5UtP2SRvKEoEm/t3xFOWni
	 aA7j6Ei/DhCseyeFwtf/GXQO6vlzAz1m4l5faYEQ=
Date: Mon, 13 Jul 2026 19:14:01 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Trevor Allison <tallison@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix static build of dlfilters
Message-ID: <20260713181401.GA512733@e132581.arm.com>
References: <20260713-perf_fix_static_build-v1-1-460be1f9e4d6@arm.com>
 <alUioShYpMSzbmf2@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUioShYpMSzbmf2@google.com>

Hi Namhyung,

On Mon, Jul 13, 2026 at 10:38:41AM -0700, Namhyung Kim wrote:

[...]

> > Fixes: e1065ed188cf ("perf build: Add LDFLAGS to dlfilters .so link")
> 
> Actually I posted the same patch.  Can I get your Tested-by?
> 
> https://lore.kernel.org/r/20260707000357.823509-1-namhyung@kernel.org

Sorry for duplicate patches. I will give my test tag on the patch.
