Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8059B1C9B7A;
	Fri, 22 Nov 2024 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313870; cv=none; b=Ky23ijQl0DcmsF2Cf5411NISJIFnoHpDuTzLB2P6LhclWZLR4szqp7is5fgkgVamqpq8anhQ+QFxzWGtkAW2p/bynUA4ftx7YAxU4tRChOVMAKpirSiWJygB+HThgHAhEEw8Z4lAjG2mDj3/22GcA5oANaUwPrmQ9V/Os+qKDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313870; c=relaxed/simple;
	bh=8LuLaOUPRysOEbU9CT2Ha7xFxMllXf6P7hSI/1nHeaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jvcAfmW7KboaAub2HkJbNHpuC8e7ZFcIPMLWZxaDHf1vqVWcGO2a2mRl5g5RjEcoytcmyG+K7JR5nOQo9fCq4bNA9XgQHqJf5RmFhQs3okJEH2eUtAGjcvdWX8p/fZ76ULTDE26rnxlNpqyGTI99TImY0SnTfA7K5jEuQ2LZAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNCFqVuA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNCFqVuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C43C4CED8;
	Fri, 22 Nov 2024 22:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732313870;
	bh=8LuLaOUPRysOEbU9CT2Ha7xFxMllXf6P7hSI/1nHeaw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KNCFqVuA94Nex/CXmlud4McTR/b6JfNHMnTrlPUrVhX/4+Rg5zKkHhX3sROKyo35V
	 9I3z1/783ZkAtG/VQQ2kvXoeMmF0xawb040Ts8TcBGSKsyHRXRzkMlVPqeM18KEF/l
	 rWF6JJRMEwjJLBXur/MSNX+8LOiN7Ypo9yqPV899ZNalsgB6xXr0BqP6eMtx8OOOTs
	 8uTi6DRtbQrW1C9+3X1DIO7I7nBJdWZId3EaG6suGwqVxMk/71qgDy95KeshuTPSsR
	 lq4LKGPiE0TsheZYU4a7my7UtW+FXPEeFTFcSkspsWm1QS0s78TLOMFOpgYLLMbzLe
	 /tsP8fkGdTccA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 acme@kernel.org, Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>
In-Reply-To: <20241119064856.641446-1-tmricht@linux.ibm.com>
References: <20241119064856.641446-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH v3] perf/test: fix perf ftrace test on s390
Message-Id: <173231386982.85365.3847262620412779645.b4-ty@kernel.org>
Date: Fri, 22 Nov 2024 14:17:49 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 19 Nov 2024 07:48:56 +0100, Thomas Richter wrote:

> On s390 the perf test case ftrace sometimes fails as follows:
> 
>   # ./perf test ftrace
>   79: perf ftrace tests    : FAILED!
>   #
> 
> The failure depends on the kernel .config file. Some configurations
> always work fine, some do not.  The ftrace profile test mostly fails,
> because the ring buffer was not large enough, and some lines
> (especially the interesting ones with nanosleep in it) where dropped.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

