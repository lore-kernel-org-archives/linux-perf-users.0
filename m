Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612204EE85F;
	Mon, 28 Sep 2026 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613079; cv=none; b=OEBt6Xt9pQa4qN7/8ZwScMaP8fAFaBfhmi1I4ImkaNmKPbg2LKdqNq2XA02B3fbfaAcdFW70PewQa3tuO0SnaimKRgjKK+6Ogq52bB55Vhkb5V5uqhSyXRNtrpvuD2uBXoQEM3++FaK5y/15yKTgS6SYv9TxPLOfd0kZTPIN0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613079; c=relaxed/simple;
	bh=zH0DVJ02puDPsbaUjxuAZFXxLZkHN2nL1uvpr3zHEp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To8FESH5vEo7A2bVpVzl868DlZNbtRGYNb33hSbTeq109IzVbqVQ7xnWE5HuV0Nqge5R/O9vtniESDbuLcDLPiB/q/KPoFx66HW/3DRZG7Uu+Cdx+10gK9c4EqqsQZvmZeO6U90On7yOQux2iQyCnd2/r+XEjyFG6a2tbFUJIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib25uwSy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib25uwSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6866C1F00899;
	Mon, 28 Sep 2026 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613078;
	bh=jy+fOa1xjY8i284m44/fZDl63yX20Ah34xZQpmbapvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ib25uwSyLD/KOs+hQ+BjeDKF+XD2P5kMw6ajYcP2wsXRyJXp4HXGU80+6NyL/0W5j
	 QwgB804Hojoro3FPNI/TluOYwXvJK1ldHx5BlmogpSbQqHbEjaZa84axiJ/nlS3lnX
	 uX8gHDJ9UEEPm+zJwWM7bzXpnedlD2Wjmm67zQ6k8tyGzFxocXZHt+vJL+HEc4/hEX
	 w8vO73oPJ+xmfsAUAMloOMJzNvBK+MPcbFgxJ1JZwgZFxeAl2NQoKNvUzsYwcCgbTS
	 LttMP4y+Hfl02y6t2bmor/d6yX5rGYSZYViCttqoI+cTEfynBAc6BVoczYbamYQ0Py
	 JNT0kCIRakD4Q==
Date: Mon, 28 Sep 2026 18:31:14 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test: Record kcore for the CoreSight callchain
 test
Message-ID: <arqWUi5qJketJ3KQ@x2>
References: <20260928-perf_cs_etm_callchain_test_add_kcore-v2-1-24fff6fab009@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-perf_cs_etm_callchain_test_add_kcore-v2-1-24fff6fab009@arm.com>

On Mon, Sep 28, 2026 at 11:15:51AM +0100, Leo Yan wrote:
> The CoreSight callchain test traces both userspace and kernel execution
> and checks the callchain across a syscall.
 
> Add --kcore to perf record to save the running kernel image alongside
> the trace data so perf script can use it to decode the kernel trace.
> If kcore is not available, the test will be skipped.
 
> Fixes: ca0e19074bd6 ("perf test: Add Arm CoreSight callchain test")
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
