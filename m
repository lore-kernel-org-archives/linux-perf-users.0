Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1818BE1
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840557; cv=none; b=RN2wI7mMDz8LNEfq3EvQaxXX0UR86sPKIroNaBPnVHHsU2Q8bZ17DGf06/D8N/bPq8B+vKeuwh73/dJjzicrA7QLFjxZR9j5Xdguwa1DL+CooVlIlMfgokAgdUJSnNhlEY73ImvXqDcgUUws0qORF8eru3ybz+apPPHpGKn0wTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840557; c=relaxed/simple;
	bh=hPOXOUOOgoX8gbO58TMVyuChX0+SAovAg3fdvXyJvpM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AR9stESh0uLTdau0S2Bs1qqOZyIO/jDFFIVN2HlEiWiPIjT3A+jf+1cknHcPcSK3UJtz2JzWPGM9T//V2qmkpSoiHEDlrFJo4cefeF7vvSdRVFMoG29eLi/24U58pCiiYXfKBYUPyOZxyMe6TVVioDTEzUZVVia7fYFIWMBHxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F2vOeiyl; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F2vOeiyl"
Date: Fri, 2 Feb 2024 10:22:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706840552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hPOXOUOOgoX8gbO58TMVyuChX0+SAovAg3fdvXyJvpM=;
	b=F2vOeiyl3zf8KxYrdfEo1ENKHx3H8H+/qVk+PXuc6jh1YuHN4wrsILiDaFB1GLzxujzLxK
	lCo/tWc1EIZagYJsna3JlcfD6zy3leE4erlYcm6OKx/oUVgVeN52C26Y6trVG8jlEjJCHn
	GT0tRU8sYaa4GvWaRkYHpn4nw9y4CMo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <James.Clark@arm.com>
Subject: Document: How to Use Perf to Debug Perf
Message-ID: <20240202022223.GA903@debian-dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi all,

I have written an article on "How to Use Perf to Debug Perf" [1] and
would like to share it here.

I call it as a self-contained topic, as the subject and the object are
the same in the same sentence. This highlights that perf is powerful
that it can debug itself ;)

Hope the doc is helpful.

Thanks,
Leo

[1] https://github.com/Leo-Yan/write_plan/blob/master/how_to_use_perf_to_debug_perf/how_to_use_perf_to_debug_perf.pdf
