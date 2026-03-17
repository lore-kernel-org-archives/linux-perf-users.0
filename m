Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729FD34DB4B;
	Tue, 17 Mar 2026 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737333; cv=none; b=oaobUV48W/PLIh/2JOi0uRYLd0FbcM/B58434WoEB/n5pui43yD9lZ9lRsS3bXZevLT3i4KH+vl4h0vK5MbfJl4pZ5sUcWdCRjds0CMP5kvC9+UgyDeCtq+MZhr7JicNAsZslmai7+IHYBwRJ5djvfRQS5GJblOL2cheXKF5RMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737333; c=relaxed/simple;
	bh=9bhY45VpWqhDTd5jJT+7uocNv/T/AHfAFR01ChuF9Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZxwSgFiPRc21WOQX7RqJqSqI5lH979oLEpfmji7JNJGvuH5D0y3d6FaoJZM9aXnhOyl+k5y8hZtXUWBgfytbAqKp0j47xGzKNIQZJKNKNyxhdmKw9RwLHFKl5CFoUcAsbH8/WxXhuJIzTdw7K9nFdXvC61dcc1ygpmaU6uvR0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AB471756;
	Tue, 17 Mar 2026 01:48:45 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 502B33F7BD;
	Tue, 17 Mar 2026 01:48:51 -0700 (PDT)
Date: Tue, 17 Mar 2026 08:48:49 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Blake Jones <blakejones@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools build: Link crypto lib for libopenssl feature
Message-ID: <20260317084849.GI8048@e132581.arm.com>
References: <20260307140553.2021539-1-leo.yan@arm.com>
 <abhOpjDG6hr-Sfe2@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abhOpjDG6hr-Sfe2@google.com>

Hi Namhyung,

On Mon, Mar 16, 2026 at 11:40:38AM -0700, Namhyung Kim wrote:
> Hi Leo,
> 
> On Sat, Mar 07, 2026 at 02:05:53PM +0000, Leo Yan wrote:
> > The perf static build reports that the BPF skeleton is disabled due to
> > the missing libopenssl feature.
> > 
> > Linking the crypto library fixes the static build failure.
> 
> I'm not sure if it's enough.  My build still doesn't have BPF skeleton
> support even with this change.  It seems to want zlib and zstd as well.

I did not see the build failure on Ubuntu 24.04 but I can reproduce the
issue after changed to Debian sid.  I will send a new version.

Thanks!
