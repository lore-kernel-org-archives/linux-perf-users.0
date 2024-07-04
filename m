Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA718AED;
	Thu,  4 Jul 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720123246; cv=none; b=iT+ZAEZFTyhG5NaszOjuw58cobbRMVmpxFvnvBSfB3nHum7h/Jg2+myNWDJ+vemqe9+WzEk64yvVDVHJLg1OKxBODlusI0Ip/30jERqsWK637iKbH96xabzSDl1i2KYm3JNzt64FL+jZFKzKLERPCOOA4JfAhN1wb9769xwv9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720123246; c=relaxed/simple;
	bh=xkKEx3pQtRGUtiF+vrh8STcy+yMQddVCrT+qL1b2P5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnbrOTmUz+hlrulh5OSyBgD0z1GjIAVnsqPWRHcUtd8Iz/WKFxnO9VnVNauf3oqkSmjziFHwygEPglr5PGok9uss68X0m9lSVvdMkgy0NwqBJN9Y2U7ZeDXgELoju7h4pLqQwJoUgPe3Ewf/h8AAxrEokwD8Ef7f1YcEimolyKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BObVCqHC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BObVCqHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54034C3277B;
	Thu,  4 Jul 2024 20:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720123246;
	bh=xkKEx3pQtRGUtiF+vrh8STcy+yMQddVCrT+qL1b2P5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BObVCqHC232hzCHtxWsILnHE11T59N08Xthxy2d8r2rdd3NssXzaNEIqb4LkQRvy6
	 qr5I2TXj6uB6FEv6X2PtOC3cmOkxwQjNV5JBwpBtCyQTyVRvbFSEmJkTcmR9fv6BUB
	 L+4nOYFoLtMoWBvI3mIh3qPKHXWBux9ZRvhkjkPUhRqey8jars8tEp89baIQ82XVIa
	 qix/wI6DHhb685Oyf4raCrS/MtmQ78AdsfkMLHBg8XJ6osrNR4O9Yf8DVs4+0eRZRD
	 wXK37pQqMd+aGg5ejpt9uQob/8uzF6EBPfsTmSJaZ+RIAtZWK7KVgta+y0mT5YBWo8
	 X9afIGBwgTnww==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nicolas Schier <n.schier@avm.de>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] perf install: Don't propagate subdir to Documentation submake
Date: Thu,  4 Jul 2024 13:00:44 -0700
Message-ID: <172012322389.184679.7075228600607494733.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240523-make-tools-perf-install-v1-1-3903499e637f@avm.de>
References: <20240523-make-tools-perf-install-v1-1-3903499e637f@avm.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 23 May 2024 10:06:40 +0200, Nicolas Schier wrote:

> Explicitly reset 'subdir' variable when descending to
> tools/perf/Documentation.  Similar to commit f89fb55714b62 ("perf build:
> Don't propagate subdir to submakes for install_headers", 2023-01-02),
> calling the 'tools/perf_install' target via top-levels Makefile results
> in repeated subdir components when attempting to call the perf
> documentation installation rules:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
