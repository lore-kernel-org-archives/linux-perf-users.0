Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969730;
	b=NLCE9u7U9r/rvpEPFRa85kJpnD6/XdevlRxepXtFXB9QI/aoiBV/M6qSAdrh3UlBnT5x
	 LfrJWCOzIeVPY+nLsBf0CzImazaq2ZYjGM/PTmAjLvyAHUQ72mO3WXnqizd6i6JzZKHmP
	 TSPhH5t+Aa9nI4Owgmi/JaS+93ysjE6I1E63fDUpwwsurdEj4fGB4twen0OUyBhP7VNoM
	 xzlV7T4uSLMoKppseZgDAYfBEHY9MD0xMVAnOApFFsNFvv3D3DXv3vszml1KShr1sGf6j
	 RbTnD7VDqmgL2AUsiSHPHwmVAOiK4QvWS7maDB110TK3K+F5Xfy3qcTaMUlEyPlzQGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969730;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cVLVUDAQ/S8P7wIqNsNlHQ7D4Qx5qIHxAIVrj+ZvXUo=;
	b=wP8v91b7t5e7d9oXXn+idYBvAY9BlG8jbUiN66vaVxGgPIztqsJp06KPhNldyGqWAj0H
	 1DYmgSbzpHfeenQ3p9ysl0FBk+T3WbdWA3Ge9WJbzH22d22J5xM58ONx/wRxjmwJtYX40
	 4fNP55t0r3alejkhSlUXiuMFWsoaQwfXu6gNDoLRFIsIbvtk0mAQ6zD3Yik5ytpOUv0Qh
	 QTOsAHIlBJYIBypLInuyDhdqjWaAO2kKwJjVfgKPLo/GQ1hg3YVOEzCZmccrZlp5/fKIt
	 fdl5v98Q74xhL68Cux3RAmy57kJZ/cC06LY69gz0NKsV+Xpo/kqRAv7yZbFO3hgu4kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECT3i2U5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F043606A326;
	Fri,  6 Nov 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECT3i2U5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAD61F008A2;
	Fri,  6 Nov 2026 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969729;
	bh=cVLVUDAQ/S8P7wIqNsNlHQ7D4Qx5qIHxAIVrj+ZvXUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ECT3i2U5LWvD96+SCQy4BY79Px0+LDDQkEQLvJIAJSGkKs9QsvVoBFan9ktO5ZAoX
	 va1/OGEa1g7t2MYQt/3KARMxop2KwWT3C6iksHVrLmmSjiCvaI1zdbVttb7dFnMK7v
	 XbL211JxP8D+wxkDxkpaeehi6T0a9PmquD3ReY7t8B7KeasBnxexlU8oc5eyxDBwkE
	 ATD0mGfwA4di50LX05xToAT/GDO6sk6aWM/0i13UdQMOjzoGYb6isYxZjKdT5sm7xQ
	 kuXKCjfjhfuQKc8qKRT1/4wdspO2NsgdQi4rTVx5OsAmmREuauI4GFPpDJIHwQEM09
	 HYtPH22IRay9A==
Date: Fri, 6 Nov 2026 13:55:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Myria Sarvay <myrialsarvay@gmail.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Neal Gompa <neal@gompa.dev>, Marc Zyngier <maz@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, Yuvan Shen <yuvanshen09@gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: arm: pmu: Add Apple M3/M4/A18 Pro SoC
 CPU PMU compatibles
Message-ID: <20261106-meteoric-tench-of-proficiency-a000ee@quoll>
References: <20261103-m3-plus-pmu-events-v1-0-a8eb6c1139fe@gmail.com>
 <20261103-m3-plus-pmu-events-v1-1-a8eb6c1139fe@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-m3-plus-pmu-events-v1-1-a8eb6c1139fe@gmail.com>

On Tue, Nov 03, 2026 at 09:14:36PM +1100, Myria Sarvay wrote:
> Document the compatibles for all current M3, M4 and A18 Pro SoC PMU
> variants. Note that the M4+ are split out by chip codenames, instead of
> name for the types of cores, as they no longer have individual names for
> the performance and efficiency cores.
> 
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/pmu.yaml | 8 ++++++++

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

