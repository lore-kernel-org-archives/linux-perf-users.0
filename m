Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553983;
	b=PmYxcA03qoeAfpKFYqk7wNLzkzVXJmQZsV1xO23jMxKger3RGMynIkZZkRt9UqPbU0rE
	 THFZHGlbCeoZz3etF0ObjcgaQ8XmsJGC6CisjR3BwUoJGEeaY8NagCQkV71RmMH8qW55y
	 +o0ja989xLqx1ou6QlFQF+2Pe/GHe7ewhoJjQPphPc0zHUAzwmrRY47mvZio6xMEO8stz
	 wiuBJqamv/mjEzgASj821l7wRMZVlajExuNl0UYN5U8wvzL9Fb0C1rKrzKeQcmOwm1gDI
	 B6ND3oDNJWGqMHiAUr+Y2b5gUyIO8fRw3DQ7gYDeoSJvpQZmgWe95EUbMPzduUmCGaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553983;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=abfVBgtUzVMGbO5UpNDXE2mkw/l6QecM28q/kqCOo7A=;
	b=ahthonujjwrrSfHHGoymbkgiazGJaA166DAo2Twj3EOuPWI5IYi32GhyWylmbX593PZ6
	 bS5Py62yjovkxvs58aJzntzQcPN0IU4Omj07Xd8kDhYYk/vtYHlETSjWEAX1i2zLLWmOo
	 sjk9GSTNDULOTHMibiiJg3e497gLn/7kB2S6tV7H8/QmEUC+wsgyPk/36ne1lzSlxICqE
	 X7eO10XN0PGHBOtzNs7WFvYVElmfWKlH1P0WkaTZzYg6ZNZjpApeyEgOCXzqhqEhCVsID
	 nWgmCAWrQAndIe9SFmKTfECJVYuL0h47fdtGsPs8K9414G0ERUxMvupxjovy0zFLTIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dw0cXMEb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2A606A330;
	Tue, 24 Nov 2026 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dw0cXMEb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74911F000D2;
	Tue, 24 Nov 2026 20:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795553982;
	bh=abfVBgtUzVMGbO5UpNDXE2mkw/l6QecM28q/kqCOo7A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dw0cXMEbmlwILrKDEyzNiO8EyxA454GRJmOtYATc36le2/SmAONUqj1340XqlHyv3
	 0svNBBdMXFbfn+5Xk/5gXNjgQZEjPxkLMrV+AatKCnTVM7JUjQDm6wal8fN3zgq5o1
	 NV9xdIR6lWjh/S223bamUlNH8DPbcReANZPUICsCt2qv4A37mK4jozOB4mtZoWrnNY
	 bCG429aOFsIJPZKp1DKS1h0VrzMEvw2P1V9muXPSGxeFTm22ls2r9fGyO4PXLrgvja
	 54wZ9+ESmX64dLENlpAdUcHW+fXf2JKTEpVOxp/qwPbMtfFoj7+kdN3OuxF20fb/yn
	 Qwr4PRTTPcWVQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Chun-Tse Shao <ctshao@google.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 james.clark@linaro.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261118212655.2262601-1-ctshao@google.com>
References: <20261118212655.2262601-1-ctshao@google.com>
Subject: Re: [PATCH v1 0/3] perf vendor events intel: update
Message-Id: <179555398103.1562760.14266539008589484942.b4-ty@b4>
Date: Tue, 24 Nov 2026 12:59:41 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 18 Nov 2026 13:26:52 -0800, Chun-Tse Shao wrote:
> Sync Intel PMU JSON event files with the latest Intel perfmon repository
> (https://github.com/intel/perfmon/commit/1e224c0fd9d9):
> - Add Diamond Rapids (DMR) v1.00 events
> - Update Lunar Lake (LNL) events from v1.26 to v1.27
> - Update Nova Lake (NVL) events from v1.04 to v1.05
> 
> Chun-Tse Shao (3):
>   perf vendor events intel: Add diamondrapids v1.00 events
>   perf vendor events intel: Update lunarlake events from 1.26 to 1.27
>   perf vendor events intel: Update novalake events from 1.04 to 1.05
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


