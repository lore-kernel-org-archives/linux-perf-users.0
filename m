Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EAF18784C;
	Thu, 24 Oct 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729772743; cv=none; b=VFi6lwzHGxMlE6uhaA1qnXRRyAzTKl2rdSL4fq/2z8uxJCBakGQjnBuGBjZ7GOg8OCNfV4fTE9vkwnvc7GTcXhreaFoHj7r8jlNBMfurR3em2AKTaTR3JjX3LRFYzusC7fW7tt+7EVUTquwQ4Uj7P1nbgpVF9K7IhyKmL4pevBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729772743; c=relaxed/simple;
	bh=IjwkqMzdt6nNRdPNA6WvCMuffGMXH/yBD4kBHf+UQKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGhidempU1ubdZKeBtDvCFPix0TM5nMeU2H/+F5TP9xkm77tN9v8bRdwttjX0vJMqHDZEWQyx8DrAYXJ4K9oH1TZwktNdJ3RebhQe1Pv73r20JgENJeEFLDVIAiuBrxoJ7P/AmIrkGU/wPSf8bsVidWQE5s+DLHXjRO1vVAkBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn8YD/0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn8YD/0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238C3C4CEC7;
	Thu, 24 Oct 2024 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729772743;
	bh=IjwkqMzdt6nNRdPNA6WvCMuffGMXH/yBD4kBHf+UQKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nn8YD/0eu/WrApoW7uoZH05/vt26Rb2afHr7m40kUPmlp4p262X7y96yUvo67KeUp
	 UDHqrq1dWBmR3E4qJyAOzC/j+ko0Iz98s67Jwn4abEeg2gYS+q88i4gH5iiHWVA+yN
	 wHvGanO1owD0jWlqxQhHJZVZhcx56ZiaegIrv8G6Zxkbut9ulibJAYV3RAumYvn6Ss
	 WEG9/p56Yb/2/hT0O5C26mcJ5MeaahBMBujwpeR8wlJEVgw1xJV319UM4H0zy9ysQX
	 KDmheu7UFseYy+LPfO3+yljIQTCPBkEXpM5Ur4X4qgXBmkQDKIIKDbsXJktraIfl6J
	 cNX0712ZLKi9g==
From: Will Deacon <will@kernel.org>
To: Frank.li@nxp.com,
	mark.rutland@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	Xu Yang <xu.yang_2@nxp.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX91 compatible
Date: Thu, 24 Oct 2024 13:25:29 +0100
Message-Id: <172976962763.3759096.9371300350428892441.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240924061251.3387850-1-xu.yang_2@nxp.com>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 24 Sep 2024 14:12:49 +0800, Xu Yang wrote:
> i.MX91 has a DDR Performance Monitor Unit which is compatible with i.MX93.
> This will add a compatible for i.MX91.
> 
> 

Applied first two patches to will (for-next/perf), thanks!

[1/3] dt-bindings: perf: fsl-imx-ddr: Add i.MX91 compatible
      https://git.kernel.org/will/c/0263a1e4f5dd
[2/3] perf: imx_perf: add support for i.MX91 platform
      https://git.kernel.org/will/c/44798fe136dc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
