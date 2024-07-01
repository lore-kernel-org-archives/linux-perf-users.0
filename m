Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1928F4;
	Mon,  1 Jul 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848156; cv=none; b=RTNRPyZfh8sNVN9L17G6Q95bVLiUnRod9Qg54qpf7fKhVsfOArYEAxVRW9rJaOXgJc8u+9TgXa6wkA5Oa4x8BW6uYcDyRkxqc4xPycPgV5uRKaraTU4UlcwaI2Pqoy3PrilJTklsmENmoE32F17SUZP+MwcJ3ULgHguCQrKIxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848156; c=relaxed/simple;
	bh=0NfcJ7gYnWszBYiuRk/o3+NWZLSNA+vHBD+/yPg6aHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxo4TeBnptgKdBWxK4OjGj3kJXW2VSZL4fkQh3TR+Er60983oAafmmQdzj76ao5oRyZfUmuvNpouLxQbcZ+ZvTs4emgWtZlKCWY8zgoUeuY/ugegERRlCCIoxizsPhuqSb6aTHm8ewsn0AhZjePnGAmwRjEE7HPv5xb39G6DDYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adEJLY5R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adEJLY5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039DFC32781;
	Mon,  1 Jul 2024 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719848155;
	bh=0NfcJ7gYnWszBYiuRk/o3+NWZLSNA+vHBD+/yPg6aHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adEJLY5RjB7i1a+ss7/WhOQVPyqd/27E9tfDpQO4qGHsuVLyQMegZkJ/CrsIGC/eY
	 mV2PATMpJgqnNGnfQwbFv/eg94xJX46RWkNi2xWNLOF0cRktyHYT5VNbmAKfkhUodV
	 wch04o5GmxKGupYUTAplE1/fdWDGq6QIwUP/z6CiqrYpEvzU6x+zyH4RJa+yne7fLp
	 /xAsVaNUB9Y1BPQ4rYXcGwp1L2TlHxMOVJazcpN2hHR++l2cEl2KhF6UEzxdH5EPKp
	 1go793xIkl8j1Gm/d064OvowLuNGVblH1ckAa9Gf2C10SO13hg2HMBJJMNIc0YwnrQ
	 hEYeNXIM3L0Rw==
From: Will Deacon <will@kernel.org>
To: frank.li@nxp.com,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	Xu Yang <xu.yang_2@nxp.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v12 1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Mon,  1 Jul 2024 16:35:43 +0100
Message-Id: <171984498139.920238.1487474748064154257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240529080358.703784-1-xu.yang_2@nxp.com>
References: <20240529080358.703784-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 29 May 2024 16:03:51 +0800, Xu Yang wrote:
> i.MX95 has a DDR pmu. This will add a compatible for it.
> 
> 

Applied drivers changes to will (for-next/perf), thanks!

[1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
      https://git.kernel.org/will/c/f26f37482457
[2/8] perf: imx_perf: add macro definitions for parsing config attr
      https://git.kernel.org/will/c/4773dd10fda0
[3/8] perf: imx_perf: let the driver manage the counter usage rather the user
      https://git.kernel.org/will/c/27e4a6523edd
[4/8] perf: imx_perf: refactor driver for imx93
      https://git.kernel.org/will/c/fab5e5a866e8
[5/8] perf: imx_perf: fix counter start and config sequence
      https://git.kernel.org/will/c/ac9aa295f7a8
[6/8] perf: imx_perf: add support for i.MX95 platform
      https://git.kernel.org/will/c/d0d7c66c537d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
