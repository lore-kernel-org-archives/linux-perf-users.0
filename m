Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A812DBF5E;
	Mon, 13 Oct 2025 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396965; cv=none; b=tKZk60+2BTdqr3MpctSk68dJJ8sjPPZpE45TVzg+S9nBtBzEffopLhxg2UoA4l8QTE6LOFTCdlhp2nlXmMhigvuavZEFWMw9dEqpTyxClph1w2GODYTGm8tiKgisbZfoQNXVV7RrarbY0aomwUCpPmYBLEjtxl7QM38HbOWmwcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396965; c=relaxed/simple;
	bh=964GVitSrXLqahOLbp4jSgZ730OorJTlWGJCMIcXas4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dp2pVJo9HrL4ckKWOuZPUBt2bAIIwWxbv5ZSbv+y40Gt2WrSiDYn7i7IBSh9hzcUf5rbG943j9bVYhg1+Vz9vwzx3LQookHWTuDekXtBHb8ve0nwYaloAKyhaaF9MLc53xm662oDK9Ldo9ku3cusYadYWYxvSKBoqZUx/kBQ13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh2r9sI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh2r9sI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315E1C4CEE7;
	Mon, 13 Oct 2025 23:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760396964;
	bh=964GVitSrXLqahOLbp4jSgZ730OorJTlWGJCMIcXas4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rh2r9sI4UF3ByetUy3e+BG0uXq1IeXSKp94k1dy5x6uGSAljYhP2wwHLLqPLQaIPw
	 upE3KDhFZgNaJuZqicNFgeCH3RV540xVQqzIPV6Lh7sSBv4eUO3bmbuGpFDh2GD26b
	 39ue9VXN8AxrHHse2y8BpYLF7pjlxOLGSu6yORmTVVIdA9hWuSGao1PQ6NqexTtP49
	 y/XFsLMr3brrWFBasxgC15nVjDLEDa9bBW0tt9V3QqYmiNm9UfUUwmd6BiwaF1NX62
	 DVsByxsvDDSQ+ZFlqxC3iDxol1DJ8V8paAp5n8bRaTIfbVXmDjkXKB4I/+v6c4IGQY
	 0CKdAnDvt3X5g==
Date: Mon, 13 Oct 2025 17:09:19 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: akpm@linux-foundation.org, alex@ghiti.fr, anup@brainfault.org, 
    aou@eecs.berkeley.edu, atish.patra@linux.dev, catalin.marinas@arm.com, 
    dianders@chromium.org, johannes@sipsolutions.net, lihuafei1@huawei.com, 
    mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, 
    mingo@kernel.org, nicolas.schier@linux.dev, palmer@dabbelt.com, 
    paul.walmsley@sifive.com, suzuki.poulose@arm.com, thorsten.blum@linux.dev, 
    wangjinchao600@gmail.com, will@kernel.org, yangyicong@hisilicon.com, 
    zhanjie9@hisilicon.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
    linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
In-Reply-To: <20251009032838.63060-3-cuiyunhui@bytedance.com>
Message-ID: <c0050227-a1da-9e87-870e-de73c6164866@kernel.org>
References: <20251009032838.63060-1-cuiyunhui@bytedance.com> <20251009032838.63060-3-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Yunhui,

On Thu, 9 Oct 2025, Yunhui Cui wrote:

> Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Looks reasonable to me.  I do like Doug Anderson's feedback about avoiding 
the line continuation in arch/riscv/Kconfig/ ; we already have other lines 
that are longer than 80 characters there.

If you wouldn't mind fixing that, then:

Acked-by: Paul Walmsley <pjw@kernel.org>  # for arch/riscv


- Paul
