Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B312139A1;
	Fri, 10 Jan 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526185; cv=none; b=QLcZCaFELLt3S0OPejVARm12mpInwbz/fhqRpiSQ0pKOPoNSUeOU/WhiZGUPNS9arWxC5t8cw6O3QVoC4b5420pdXvOX6ldPLvaO4+1oF/i1KU62x+h2XTOxGAcJep7KS0274E/5jNMUGS1glyeyfATctLbTkF4pDAZcxbPzbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526185; c=relaxed/simple;
	bh=CAU18YKMnncPUQohGuxYnwm1mkjP3qMIAZNL1hg/qsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6NZ2rTthy/0qCbvVofncF5sKMW0GC7RPFQ9gVF6p5Osi4N1G1ViUvcavQmbtyVUAW1ciSpQVW1YsV1xU/wiS55LQRlTrcIGvcT/PNemqc+ch4Pi8ryVd/ed6H4xVpyWKSEwmIB+3OACRlYoxt9R5v7CY/h5a2Mk5K98ivJixzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI7hkeVR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI7hkeVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D87C4CEE0;
	Fri, 10 Jan 2025 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736526184;
	bh=CAU18YKMnncPUQohGuxYnwm1mkjP3qMIAZNL1hg/qsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VI7hkeVRA4F+zcxghNwfRGBhKqFg/YTnU7L2oHpLIIZXK3MeFzMri/CFK9iT2mKZi
	 vx6nP0fTjyZk9WwgQO7YYCEtfENtfyEpRaJzbpbCkAwbOwZoMBtbKadg4xZXmVpQ+t
	 iQNR6c7ZT9Oo90HHVZUoNdQHPduCsn1zTqhjJ03KF4+MsQeJegweDza4HBqWd4Qgla
	 kLcOf9GxBSPhq2A84LBwhfW630bbTpQRSagxbdz3C4WmeGgtSGQULcxfPPX3PtP3Mh
	 8LM7qR9iTvUil2JWLDYdQDKqZZSJ3Asairpo8xwVtupOm9ErTOBfhgEgOBvmKZ6oUN
	 u5jdDJqgWxOBA==
From: Will Deacon <will@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add perf list for drivers/perf/
Date: Fri, 10 Jan 2025 16:22:50 +0000
Message-Id: <173651673981.3233561.18273789986307354275.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250109152811.3402943-1-robh@kernel.org>
References: <20250109152811.3402943-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 09 Jan 2025 09:28:10 -0600, Rob Herring (Arm) wrote:
> drivers/perf/ contains drivers for the perf subsystem, so it makes sense
> that the perf list, linux-perf-users@vger.kernel.org, should be
> included for perf drivers.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] MAINTAINERS: Add perf list for drivers/perf/
      https://git.kernel.org/will/c/d00f343a63e9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
