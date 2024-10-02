Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FD12C49C;
	Wed,  2 Oct 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906753; cv=none; b=coJY3duPWlUU1xg3TPfJJlc23kgWocUGIu/5c1KUGCaUkcMLxkSTRJ5D055dhLo+UtsTISzZS55SdZsuMcuYQ8e+udEk3yAU75qvb6NWvvYXmQV8Mbis1gCIP3AUJPO+fMWse+ZHSNQYR7gGTIkCk1QPpKlsarrX0XokJbT6i4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906753; c=relaxed/simple;
	bh=KtWNp0mofQ6zZxMFdeIYZ3oOA/UVCqsia0AwwOyC2IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2wDGrkIAM7xdh/i5UM64OKRABeL1jYNHtPGPRAmrWIGR5lMjr9cNodZl5L8ILlNZhLmTicKHAGnoNCTCmgO/0kVkkpPt3b17cc0gEclqdhQH3rmCp08G84IxlucoxhuLC4KPTyx+O4gDb81AFw4Z1h28s0slHLlExw/3hJqkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4TvpEPr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4TvpEPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4044C4CEC2;
	Wed,  2 Oct 2024 22:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727906753;
	bh=KtWNp0mofQ6zZxMFdeIYZ3oOA/UVCqsia0AwwOyC2IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j4TvpEPrLqdCDYzg/w95CNPUt8kFpgxTjIdAjUPg52sHl98ON0DrpT6mhN1Rj8eeo
	 kfgs9X+07p+eqMRUo4v/WwrCHPXaV/LD5itUsnW6CfNG1iPbz2HCIEGIt4GsCLcpPh
	 B2IrJ/k4KGOVmYyCqP0VAU/wPIylO9UXtXGAd0t2F+L40VRtoPIKV5n4I7qI5Q10BM
	 u63vZ44mXf15g7qlAMSyMLziztbaBhrCXpNsc2zdqaTn5H12JDwEP3w5k/IK75B3Lc
	 O2RQqvODPqRL9bk7pzm4cuEQMbx7kZ/4Ltp3tVX3xvMhVqFEPzFUaopJMNPbspr39z
	 BeccsIgtVrpEw==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v12 0/2] tools/perf: Support PERF_SAMPLE_READ with inherit
Date: Wed,  2 Oct 2024 15:05:43 -0700
Message-ID: <172790673140.3079602.4159401527363897387.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001121505.1009685-1-ben.gainey@arm.com>
References: <20241001121505.1009685-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Oct 2024 13:15:03 +0100, Ben Gainey wrote:

> This revision of this change splits out the tools/perf changes requested
> by Namhyung Kim for my previous work to enable PERF_SAMPLE READ with inherit (see
> https://lore.kernel.org/linux-perf-users/20240730084417.7693-1-ben.gainey@arm.com/ )
> as the kernel side changes have been picked up by Peter Zijlstra.
> 
> Changes since v11:
>  - Rebased onto perf-tools-next (b38c49d8296b9eee)
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
