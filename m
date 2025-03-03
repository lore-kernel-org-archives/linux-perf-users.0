Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8631D63F0;
	Mon,  3 Mar 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021011; cv=none; b=lbyDgA7GOZDJ7dboqneJTgWvsj+SBSA9jeqdrm7pX3lYL8m2i2AsWVitmgcBVoCoaN3yHKckU8w5TrXK2C6Eh5rm3eF1toopHygop2gpkwaJUva0SaGCnuykJa9hKtzMvDGcFIxhshuob+lo2AgWawtWZJam0WQswvJx0R+Muc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021011; c=relaxed/simple;
	bh=FIXN8HYAa/2wJPdCaQ+/v34h2EmsnF4vgapM2g6Djc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYdAzyj9zVjURv9taY+s3GYPMOQtTV21V0Eue46npDgOAB4m51R3PAmR1xY+yjO6ddWynZ7wWJJ2eHzOoRCkeZLLseeFOn0a0127RVna+Vo/XZpcc/MMwrXUXnVgMUIw9tDjwhvVKLwqRJI4ZMmNp193ucaA+p9a8zIKeEQJhy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tddHoUZk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tddHoUZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDC2C4CED6;
	Mon,  3 Mar 2025 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741021010;
	bh=FIXN8HYAa/2wJPdCaQ+/v34h2EmsnF4vgapM2g6Djc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tddHoUZkM9KOD2jfE+9AMz+D4KPhSmGyY1LJFg/NgA7DWdx5f+UipN4yFzMdqec0c
	 b/BMPxc2STMF92tw8SQrQm4uH4fJbCKMcKTSpoyZAgwJE9XXoxmJB/gg+CRKGpL3PH
	 GiDRSulpiVt9jZZ1cDhJDR00gTNLhBmP4bZ8yk3NQnbbeZ49VPQv6qXf05jf5Iml1w
	 nuP1/e6NuHpAybqZaIAkDm2Iwes0611IqxaJRm8UGdfJGBSOXLsqHV23mjgtQGUwVG
	 a/2ZTGRxlu/aC1zp2TPRWe2Xvc+EbsFkeuTvdVcAEgwQfY2QoKgWHOIdJzodMb4v29
	 6KQ0o1FPOHAyg==
Date: Mon, 3 Mar 2025 08:56:47 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: fix in-tree build
Message-ID: <Z8XfT0cboPCMsr_9@google.com>
References: <20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com>

On Fri, Jan 24, 2025 at 02:06:08PM +0100, Luca Ceresoli wrote:
> Building perf in-tree is broken after commit 890a1961c812 ("perf tools:
> Create source symlink in perf object dir") which added a 'source' symlink
> in the output dir pointing to the source dir.
> 
> With in-tree builds, the added 'SOURCE = ...' line is executed multiple
> times (I observed 2 during the build plus 2 during installation). This is a
> minor inefficiency, in theory not harmful because symlink creation is
> assumed to be idempotent. But it is not.
> 
> Considering with in-tree builds:
> 
>   srctree=/absolute/path/to/linux
>    OUTPUT=/absolute/path/to/linux/tools/perf
> 
[...]

Applied to perf-tools-next, thanks!

Best Regards,
Namhyung

