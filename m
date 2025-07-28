Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B33D7DA73
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Jul 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725805; cv=none; b=N0yD2dI9i7cCh9DdH4WTDLX34X2yJ15HmVqa0JW9tJXwQBrUf/3aOrvd50jVb+xxCthyeFRYLlazeYp10p7hW1ws8k6bCOLbng4XiwGHH8evUjOgzF1Ff24k2ltRS2pfERHGYxsN07R9ZdmD4kSjbfKUPR9nHCdZGEudDFAvBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725805; c=relaxed/simple;
	bh=c23fagygNbpmRF+b93NUmEwZj6/YWWkH2ljKoxhmcRc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dbuy9HIFKx42QD/CB8OqoEU1pn5yZrc/0CaKcEwhorAyCPiqnnwMAFCgwq+rALT0cqRPJRisJEpiAjeZIgof9VAN5iTq3/4w3MEWGFjtPP5zIDFwNIisrtjlf5EVqUuH7rV89pDC0VFhLu+yqTw9omJgUtPE91Q9WAlghJ+FKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOPRLk2U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOPRLk2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E428DC4CEE7;
	Mon, 28 Jul 2025 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753725805;
	bh=c23fagygNbpmRF+b93NUmEwZj6/YWWkH2ljKoxhmcRc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mOPRLk2UQJwWEjZSLApMo9YDsZ4C5cOWHsF9ZVrGjXhsk5RikbY5XOfP2A8mFUAPj
	 ZhVoKOJr8bnPOet5cjBxggL4eqVxeNbBYAz5FVGARH74tlE7+bOZb1gjjprMOeAvYx
	 qFKrko89xcb6PXBY3WWm34FUn0Jef1z2QGyzd6dIcZo/xJw0/Ee+A3B1CjKM6DDNhT
	 15qzbHMTQqSoMKDjdbUc7cg7vxN+R43RcCTIEIhliz7Qo0bRPO1PPOhCDVtVhyiRgh
	 y0Km3V2sBEkh7P3unL4erLdzQMyuNb3Vv5VYcxU3FrtVhXu67Zs/HBJrR+bxYftvDy
	 OqdWyFudjoAkg==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 cp0613@linux.alibaba.com
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20250726111532.8031-1-cp0613@linux.alibaba.com>
References: <20250726111532.8031-1-cp0613@linux.alibaba.com>
Subject: Re: [PATCH] perf tools: Remove libtraceevent in .gitignore
Message-Id: <175372580488.3258545.1534750682238125688.b4-ty@kernel.org>
Date: Mon, 28 Jul 2025 11:03:24 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 26 Jul 2025 19:15:32 +0800, cp0613@linux.alibaba.com wrote:
> The libtraceevent has been removed from the source tree, and .gitignore
> needs to be updated as well.
> 
> Fixes: 4171925aa9f3f7bf ("tools lib traceevent: Remove libtraceevent")
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


