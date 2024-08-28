Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DF1AC443
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 21:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879559; cv=none; b=EQvc8N3wpqFclJoZg9FRkLrJ0TdwA9zFnuuC92H+N4UUhJUFDmCYmbQYhXLj5J6u59jjTEdcs9vhQuGjtPWbgOHrO8Dtc78ygyUrXfJApFCgymw01TtP32LjCML4zh/07DiNBJU0Ixzxd/kDR4DpLHBR2asV6QRpryEBn2Y4cLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879559; c=relaxed/simple;
	bh=rZLIcVojekpAZS9o5dOs6fupO3feTLSdaJ9gTAu0uak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5ytEkeCLFNMvduV8ZO2QCpf6+UOd6PCrx+TTVUPbt/qIcwmr5Qo6BmAmnnx2DeO6AjBMm/PS0GyZyIL5sbEleig8UqZsr2Pz+yExZRFIjBezJrhtnwuOR9dHsWbhgyqOsRM356F8tT1EHxGHW5iq91uN7Nu1j4VAnJwsYxLUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZReDKSzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZReDKSzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CF5C4CEC0;
	Wed, 28 Aug 2024 21:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724879559;
	bh=rZLIcVojekpAZS9o5dOs6fupO3feTLSdaJ9gTAu0uak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZReDKSzEWNWTvkJQNvT+gSsUd9wngh3YB4A4MCTrzg4rBXh8EnAI3E1YAkviQqtBD
	 xMNn22IuI40dPSxhpi/p3PRTJSislfnT6B+tZatKJozXQD+5BgzG3W0910TlP145vk
	 NROLy4kNDBdB9xCRT89Ps4KQzQBKdwaP3mrH5hD3dXlqGF4ER09IRIhQWKGlyLBQuo
	 MeL3FUsU+hNtlJcLBgjEtg50yJqqLGaJLBUbNqHnGobUeEvjdAgW4a5wkFUQMWAqeX
	 dFi3ABgOYLJb1JJ85Z6j6HcNtqsAN5xRlg1GzEsUEKM1+lXNYdJxIPTxpMVojMpFSq
	 WJI0L2HiuVBYA==
Date: Wed, 28 Aug 2024 18:12:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, kernel@pengutronix.de,
	patchwork-lst@pengutronix.de
Subject: Re: [PATCH] perf vendor events arm64: Move Yitian 710 DDR PMU into
 T-Head directory
Message-ID: <Zs-Sw7aWRQ6LoDNN@x1>
References: <20240701175735.485655-1-l.stach@pengutronix.de>
 <f7af5fe9-35bd-4322-a474-a67529b06ac5@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7af5fe9-35bd-4322-a474-a67529b06ac5@linux.alibaba.com>

On Tue, Aug 27, 2024 at 11:40:07AM +0800, Jing Zhang wrote:
> 
> 
> 在 2024/7/2 上午1:57, Lucas Stach 写道:
> > The Yitian 710 is not a Freescale/NXP design and thus should
> > be located in a separate T-Head vendor directory.
> > 
> 
> You are right. Sorry, I made a mistake.
> 
> Reviewed-by: Jing Zhang <renyu.zj@linux.alibaba.com>

Thanks, applied to perf-tools-next,

- Arnaldo
