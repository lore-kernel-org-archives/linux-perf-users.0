Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D89322E;
	Tue,  1 Oct 2024 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816451; cv=none; b=aQt0wtZqD8Xss92m/YCSSvCQ+i30Dx1SzZVImsumrtMkByaqf0yotcYCLl5RIegac0tFmut+jj2bqGkAuFpMySr+ghNy9KvfoqAvz+4AmRJTrrI/yNOU+bT3VcB+OR/l3zICa+gHzRcXlX9U8lZpj+BDGplwrX+hTijQ2eHAfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816451; c=relaxed/simple;
	bh=cWSNNHMyhEhH0XDAAmym6uzKHyht1Yh1ZPqovWtRob4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uT5mskC6TsB6hzDHYX3pr3pUNxrbNNFrzIhEQAs7OLCOrXc9CFQXxiHEwVAAaOjxK2lRb7YnAO01etDoVB65hSccK3CY5Ad24KYB1ZookMgK3Dxj7hGRgN/sNRfzcmC8dSFIY8RHllzzFcFOgPinwobefQyeOX/J+Zsz4Tq1IZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuIJ9Fwi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuIJ9Fwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46702C4CEC6;
	Tue,  1 Oct 2024 21:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727816450;
	bh=cWSNNHMyhEhH0XDAAmym6uzKHyht1Yh1ZPqovWtRob4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CuIJ9Fwixgt7wxe4v29FKyrAz41e94HVI4gtkuxAbGgVt0hgzfCOZNr5mCnBav55F
	 zBDDJZksDdDlz8EtveRHnpQ9W4FTFQk7R1v177im8m2PA4dmGtZ7ZN46HRYwRfMIBz
	 DaZdyrOjXxWYtudpxUe2Rq+nV55h92I7FZTxBUTP763LazMGxGTo+2WZfvADKvW8/s
	 px8OmFpQ02A6o0eyWSFmcvc5smnnNrYmGZKBwUWAx5p6tAWT3hkqhaVKbbrA3I3Xh9
	 Po0RnW8GW9Dzm5d+VDiLCmRxXjizs8em5LnAem5kml0Jex957ZipiLjz5koDZfJBec
	 PX0nhY7pEV9kg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v1] perf evsel: Reduce a variables scope
Date: Tue,  1 Oct 2024 14:00:48 -0700
Message-ID: <172781644142.2468715.2332968875261553392.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240918223116.127386-1-irogers@google.com>
References: <20240918223116.127386-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Sep 2024 00:31:16 +0200, Ian Rogers wrote:

> In __evsel__config_callchain avoid computing arch until code path that
> uses it.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
