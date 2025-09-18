Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAA31771E;
	Thu, 18 Sep 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213805; cv=none; b=DGKdilSy6oTZYl8zp/+5Gj7fnFDRSnLs0ape2dgANWWA3jTy1Nms+9DAtNHX63vdtMSlk3wwCyaes+yTToe3Lmzy7HsAHAmGy1Odn4mi7MSqnBB8YsmYXU0yUNXsCCCG8a1WgmCTdBIh2FTNIpv03jvWMSgLECLNXp30+4YLPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213805; c=relaxed/simple;
	bh=cvU+rUTH7Fb+pH4bvUfM3aUE1C5EoH36lDNS95ZtEdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbp1UZp0J7Rt0eM9fGBybb89dYJmjd4he+4LlaZPnZXezfH1/5Uqw02KD/tvFx0tAO4VMruYg6+lG6MgRuK5tWTk96ViC+dwNBgB5W2l7iU/XIHl5h1rNvkJeZ6Vyqklq804b8FsRZ7DiPPRL9Suakmy60oC60R2wC+Jpv2UNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/xfk4Br; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/xfk4Br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C074C4CEF0;
	Thu, 18 Sep 2025 16:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758213805;
	bh=cvU+rUTH7Fb+pH4bvUfM3aUE1C5EoH36lDNS95ZtEdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/xfk4BrUMmyH7LB4Zm7NKYDcvd8wqK74Ud6aTjWsat/0bTFzu7ms7O9Yl8mpkpY3
	 k6N/LnhSNvdzQe/jAM5usS4yjwwP8eYOO0IZrO6BKR3KYZwpYaNg4czg0hvdlZ4kaP
	 Y9XnewD/PVXGgDEXoebIAC1WTqtWJAKOc1QvA8ESLO7QoZbZPRRmA0yx7aKwRm5XZY
	 IW2JJx5gR868TfQdssmJKPXb3FEWacfaHRZeb0vq+V4yId54LFcK5uEz3ng03NrYQM
	 iOP38txIEwQQI22JZbs+UqhZeSXQgwmNdfF3mfT2nQNBAxpSo6Yx5qVXiA1InAB22h
	 5Jef6AAy9OvnQ==
From: Will Deacon <will@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/dwc_pcie: Support counting multiple lane events in parallel
Date: Thu, 18 Sep 2025 17:43:07 +0100
Message-Id: <175819993397.3464193.5312337667087987176.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828223519.2812844-1-ilkka@os.amperecomputing.com>
References: <20250828223519.2812844-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 28 Aug 2025 15:35:19 -0700, Ilkka Koskinen wrote:
> While Designware PCIe PMU allows to count only one time based event
> at a time, it allows to count all the lane events simultaneously.
> After the patch one is able to count a group of lane events:
> 
>   $  perf stat -e '{dwc_rootport/tx_memory_write,lane=1/,dwc_rootport/rx_memory_read,lane=0/}' dd if=/dev/nvme0n1 of=/dev/null bs=1M count=1
> 
> Earlier the events wouldn't have been counted successfully.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/dwc_pcie: Support counting multiple lane events in parallel
      https://git.kernel.org/will/c/71396cfac97d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
