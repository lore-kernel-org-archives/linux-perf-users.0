Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74931E834;
	Tue, 30 Jun 2026 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862555; cv=none; b=TknNxR3EsXlYSe9uBaLSQnqQqc6tEw6uVwXZK3Yh1+1wwezidSiNJRI7QvYD+HAZ5RjPpdwgKP32d5wkuAtJFmC0EcEcIFfsEcbc7/DuBmycgVMnfOzokrhje3YHQcwFtjAjawZRk6j5Bdl6MrqfU+o4mAurB8ekAoJthIqXehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862555; c=relaxed/simple;
	bh=eaYRFVK43I6xpKLOZzbMN2z2RHBJU4jxLrNyRE1EQps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d06A9reEqMxN13qQGXyEtuzAwV1X+D4WYW5Zidi/K1cn+g2yWqk7Jk5CBn7hHqvHDrOtY5PaIzLRL03ClINz/6Tu97RQuDVa2Ntf+bgony+JOr0TzmeL1rO+D3p13qsqLI5eFF+yWtQflujqINtTY32pU4vl5253g3K/ghePRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEt1WOqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEt1WOqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629C21F00A3A;
	Tue, 30 Jun 2026 23:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862554;
	bh=MVsF4Zq1bqt6PKCqvYty9/BK1F1FZZH1RH6p0K8bIoE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mEt1WOqG5nf3EDsoJk3asrxMyX1r5lH1qRH0aTDR1DpikxsKQ8DRMYkwx8wgsTbFG
	 KRqfs8lBSnFnEixvQjF2HO+7hzXGVnBws3Le/ssz8VgPVFvzOqNsRlZSHS2PuIuKXz
	 ewBrClzoPwKl0iDFLX3KdFh+KgpG1nJA9trmyjt02+RYAfjfYY4iZZLp/p8+kjZZhV
	 +rRsuCKUyufqlNx8Xjx22w4IHEtHxMjIAFWFoHujNGye4AhF7D1QCnDtj891ILnKfQ
	 KD591wB94qixlJaYDgEZUGM2gj/rHipz4qYeSbIQjxnD+Nh3sBpLSb27uUpv16VkEU
	 p9YJnWNzl8c3Q==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 atrajeev@linux.ibm.com, Gautam Menghani <Gautam.Menghani@ibm.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
References: <20260602115644.8133-1-Gautam.Menghani@ibm.com>
Subject: Re: [PATCH v2 1/2] perf script powerpc: Update the hcall list with
 new hcalls
Message-Id: <178286255436.2863034.15766902647466305951.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:54 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 02 Jun 2026 17:26:40 +0530, Gautam Menghani wrote:
> Update the hcall list with the newer hcalls in PPC.
> 
> [1]: github.com/torvalds/linux/blob/master/arch/powerpc/include/asm/hvcall.h
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


