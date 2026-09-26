Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923F3A9850;
	Sat, 26 Sep 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790418911; cv=none; b=uegBD1y16J0qEw6qMk9/QJ13kZcoB4XdnwIUMWQ+QTwRqTeRsysQcaEerpW/gAKBWIBQFWJvUNIURQ0dL19yyi6U7k8NAgbgSqfaErF2299EX/rQ8gjYOBZ1KhUx0DV9kU8UkGgVBhOBXFjjY46c/qyMvBTtR0S3PioXWi6z79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790418911; c=relaxed/simple;
	bh=fEl8jD+QNIXWLS7gZpRsbmLbSiAmV8GM1+qiu6QuTxY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References; b=ENjNeTXqhygwe6L5LxOWbKfO77l2P6Si607ra7jE5hNL4vpo1uD3+8xG8m+tjVzFMQBG7doP3aRO+O1NUzPAjtPFKpWmnZqfJJrfjpJ7iJzyz9ni04icI4LYBW5vnMuAsODKEfguHI8Ra9TIxD+me5NidibD6gpLpqBq7pQ7ZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pWY7sjeQ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pWY7sjeQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:From:To:Subject:Date; bh=fEl8jD+QNIXWLS7
	gZpRsbmLbSiAmV8GM1+qiu6QuTxY=; b=pWY7sjeQKpoHd7QbfbY64v5w7ybqbvy
	Ybmz9VN+cZeQVRWjXE9CGezDZE9HEkqj5iGGrbt3SYwop6z5IEloK6icMOHrsq3R
	yvPSdctF73LU0Pow8VrXzD/kUIgMM+O68v3+NUY6E4lUvrHk/rsNvxxdvCCg9Xui
	CBX6LRIfVK68=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC3oEmyn7dqpOvwBQ--.7131S2;
	Sat, 26 Sep 2026 18:34:27 +0800 (CST)
Message-ID: <4c3a6187e83a9d2e7074122316e65a18.sh_def@163.com>
From: Hui Su <sh_def@163.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: Re: [PATCH] perf synthetic-events: Check schedstat domain allocation failure
Date: Sat, 26 Sep 2026 19:31:08 +0900
In-Reply-To: <20260912031112.1814574-3-sh_def@163.com>
References: <20260912031112.1814574-3-sh_def@163.com>
X-CM-TRANSID:PygvCgC3oEmyn7dqpOvwBQ--.7131S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRMc_aDUUUU
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhOc+2q3n7OwCAAA3-
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Hi Arnaldo,

A gentle ping on this patch.

The separate schedstat event lifetime issue found during review has since
been fixed and applied to perf-tools-next for v7.4. This allocation
failure fix is independent and is still outstanding.

Thanks,
Hui

