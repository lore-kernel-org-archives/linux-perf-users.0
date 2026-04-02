Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9343890E9
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167050; cv=none; b=kFmjQVZX1UCs73QTFz2vNK8FMLRQeE1DgH/ZjfkX3TJxmjLlYzFpM8vY6LEVFV5TpNeUGAlV4q9RR00awthItPBB2nj3wETbXHZSFsTyTpjIOotT4HyoZtLExoWmcTByVaWCL96MtycyIvPyomjxR1sIoFayqiGaByl23CZEAlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167050; c=relaxed/simple;
	bh=boXRtZUZ/gYLObfbkVS6P6vCew4nlXtRIuyT+OOUIP8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WoqO/A2Ww0n/KhhECPH67cCe347ulC5WpPdqDGXVfNJHU6196r34KagxRZ6qISEV2l3evi1zJfHd49T5mkWccmW4+l2xNkCk/ejtnYMLBbf1QarhncDhbyZZLD6pcUebtaYPKos5czbc8Msq4rzzvO/ChAj4yopYaKVkHgMmz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeDaePwG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeDaePwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8811C2BCB5;
	Thu,  2 Apr 2026 21:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775167050;
	bh=boXRtZUZ/gYLObfbkVS6P6vCew4nlXtRIuyT+OOUIP8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BeDaePwGujF4PJhf11Web1sJnVJvH4+gCtLrzqpZoKxRQxK/+m87UoDDWmRx7ZG+5
	 720spOYzVilNEglwBpRwmTx47EfAFKIguIZsSVcDQQU0LpGzyn7061fbQt0tTr2m0s
	 D1ifigmCCUl/L2yC6vYW5U+FSLxHGLUh1oImNUKJfFX6PqSJwnJqJOBkpBZM21XCil
	 UuTpCQbeugDXZUiOKNboR7c5x5aCH0CUaQbIZeeBq8h7sk+SC8HRnl3zMrbdNs5pzs
	 xUhFivQUdRRr/bb+f2CZWlNteF4pesPzYF6yaRc32JXA74A0NAVAYJFBV5HxmoTk9k
	 fjOWGY01Y20rQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-perf-users@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20260323155804.7216-1-cel@kernel.org>
References: <20260323155804.7216-1-cel@kernel.org>
Subject: Re: [PATCH] perf symbols: Fix module symbol resolution for
 non-zero .text sh_addr
Message-Id: <177516704977.1014987.1395752916282649715.b4-ty@kernel.org>
Date: Thu, 02 Apr 2026 14:57:29 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 23 Mar 2026 11:58:04 -0400, Chuck Lever wrote:
> When perf resolves symbols from kernel module ELF files (ET_REL),
> it converts symbol addresses to file offsets so that sample IPs
> can be matched to the correct symbol. The conversion adjusts each
> symbol's st_value:
> 
>   sym->st_value -= shdr->sh_addr - shdr->sh_offset;
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


