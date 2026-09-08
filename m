Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2248F01B;
	Tue,  8 Sep 2026 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905300; cv=none; b=Ah4/FFukAWRWOsfG9fsHpEtaEGAG4vRVH8MO2kJSRtoMQ0gHotlnJ+yLoWis/poqNEszQsuoJ31j/tv3pdeTnfj/p0e2B8WIvovimJZkNy6zhKXDW7u/kqBu8tu1hNAFpvTPx+jn71RtheuZ3aO73UGnl9xtYrTvY51hJcSkxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905300; c=relaxed/simple;
	bh=fGgTZvjY36/wB/uAxX25FOYeTblqb7YMtdvqvdINyy0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GaiBe9ZLP3u1j7Ql5O674H6wgsPeUI2EFDxkVtVyohm6FAASRDYu4MEsKiLr/MYUvjDnbfdcupptUzzEm3l2yL9FEeddLMFsUJF7Zo12UY/YgKbu4Z3nDVFvzojjSsfLqEul+vnQC10PK4+8zKAANL76rScu65XbGS1MgSMtEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH7flFfe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH7flFfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422781F00A3A;
	Tue,  8 Sep 2026 22:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788905298;
	bh=dOiFhq8I88BVcZtuFbjPLOvWG1Y1WY5skTD6v32H6kM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=XH7flFfei05ZPRPwExgckouFMZOyTeZMb3U1eLh6GGQMCNVjQY83rYsO+MV4uN9FH
	 /kHyhzpqTS2DSW15FpCJUzVln6rYt8tA6Hbag8H48TAYCm0iQ9jH/xHj1XaSUStpN+
	 yK5KTTmV8W2imROzeUVVqj905fsq/6vd7m6P8b7xsFBnqQce7Wjibp6SjzbVxgusdp
	 siPdifxC6403siNDmzxprjXppdgnVaQTQO3Rs+d+4VP3HDVLrMIXmnICfVt6Rl26zi
	 oP3SY+qxSDmqAR6RcP/ccWNuW1cSxX+FCq8sKrnktcKb/9lRK4vN3XUNA0efSh8Oiv
	 guMG/3m+/F0xA==
Message-ID: <28beb73e-5cee-4263-bd72-95e15f3aa028@kernel.org>
Date: Tue, 8 Sep 2026 23:08:14 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Track perf counter snapshot
 state
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
Content-Language: en-GB
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-08 07:27 UTC-0700 ~ Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> A perf counter can be zero at fentry. PMU multiplexing can schedule the
> event during the BPF program. The old counter check then drops a valid
> sample.
> 
> Use an armed flag to track each successful fentry snapshot. Reset all
> flags before new reads. The fexit path clears each flag when it consumes
> the snapshot.
> 
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Acked-by: Quentin Monnet <qmo@kernel.org>
