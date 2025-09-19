Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC1139D;
	Fri, 19 Sep 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246058; cv=none; b=dSMnEV/SyTM+Zlq5u6mbUwLPPOCCUcKUosE4xlsP1S23ShM19VKfbWbyNg+Y9q/7hyXXYI6kf2YTdpovkgKFHtTPNi5CDqxRer3zwcUJtb2kutvG03AAuepbeewU8uteititIvYjdLE/BlKnv7wKAD5kUwqnWLk3PegMKiReRL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246058; c=relaxed/simple;
	bh=zPbgxi7Uh2u+IDqPDqnm42rsQFRLGFodybHJ11ddTzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IJh3c437jtZL5dvYk9y1Xphj+RN5jMZH9IVF6P53LO//A3v3HrlThF3bTWwLFYAl+6Z28LXrMzZ5nBdZrRm9jvy87c9tOxBSbLeaJLAhl0U8JWXuCDt5MX4zza3HMG+2x7Qpy0t/RgkVgywVY9u9YvrTfb/JvrnmWxgXfc/T7lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpQMoHhm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpQMoHhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B717FC4CEE7;
	Fri, 19 Sep 2025 01:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758246057;
	bh=zPbgxi7Uh2u+IDqPDqnm42rsQFRLGFodybHJ11ddTzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tpQMoHhm47Bs5bDLnjwYUKoQdkRK6kFewwAFoABQx6dGjucIipLdDoTG4QOsQ1WN8
	 8nambApnBgJ3JlJcfCCPxjjldlmCihFYtrJxmwm4CIHtewRAE3Roq9GtyDVnacIdnD
	 DKY4SL9xmCPM+gjejNtOWFSxBVlnhE1dfmr3qDSb3T5YmGe5Db/g+kbuv/vebqpltQ
	 sd86jUKXvZGL+hlgSwasSUqalKzP0ubsMNteO6cWvpHwDoUv6BiQi+Y/kmtOl+LXC+
	 0DkbpptdV37BY+EasHh/dmeVZ2wDIuLR67LxGREu0wHtn+eKsu/D6pBZYaGAK50oW9
	 IXVuEPf9WFEpA==
Date: Thu, 18 Sep 2025 19:40:55 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
cc: atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, 
    mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
    aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: riscv: skip empty batches in counter start
In-Reply-To: <20250804025110.11088-1-cuiyunhui@bytedance.com>
Message-ID: <57999508-fa1d-f6a1-4f40-188a61f54307@kernel.org>
References: <20250804025110.11088-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 4 Aug 2025, Yunhui Cui wrote:

> Avoid unnecessary SBI calls when starting non-overflowed counters
> in pmu_sbi_start_ovf_ctrs_sbi() by checking ctr_start_mask.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thanks, queued for v6.18.


- Paul
