Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21553417D6A;
	Wed, 15 Jul 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140811; cv=none; b=D8kUli+fADpEdYi0UsmkKHWCYOpcB0sUGabKCpzIyiJuY1pcCKDnc4xU2FJeTQ2b+7Aj/3OZQr8BNUUxC2G6LFuStY3XzsOkKmhy8EyAic8sViSSEMiWiSnRGPsJGQ8JZL2MkW6FQDFAzd3pkustP93x6UPQ6qVAvAvlXdwVf/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140811; c=relaxed/simple;
	bh=Rd46UiE3L31Q6fAtiwJMkWWP7lGpuwIMSnPMQQemUsU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sc/cqHFIGvGsgGuAaIBjPstZCUbSlTN5QD+wv8wSuj38WMfh6z2r9kB3j3kpGvV5/gzCqw4CJ8n9NXpaRdfFEcHTs+0VJLm5KvNCIiYW1Hi/oRKL48WtPH0YTaeCNfSqPdpZv5d0HOulOob2hJ9/NAu+1i/vdFH2aFeT8Nxi1lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmTaasc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmTaasc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FA21F00A3F;
	Wed, 15 Jul 2026 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784140799;
	bh=sTsEA4bFgtH+a9oW7bWTvHBG4Vck3NOg6Ir7W6myu3o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mmTaasc6Ed729km2BkSCWgBDyeNq95O5pGwsK6L0vkI3IZuzVoE+OKT3ITW0Wig6C
	 ofgW0HAm6zjLl6AjsxKX/a0Q9hjscGBJilDKyCBffK9ebwRlFSiNIo3130+g5Q/1HP
	 Mu0K5QWUfpLYLSiIYgRrGZFsvAfYu/EC7VpUpPFwlTrUgw5yKOZhvnLj0PAqa/ZdK4
	 iU6z1jrw3E7r8JU3A3IqkaEGEUQEcXT5JQjg/0iY0CiGB6w/O5JzFqrB5pQkcqTsa6
	 rBzenm3QwvkppDR7sqXgEeNgd5MH50dK/kH8PGy84usxfOS4d6olpQuycj1t3NV2Yh
	 s+hWSZBPQtskg==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 thomas.falcon@intel.com, Hongling Zeng <zenghongling@kylinos.cn>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhongling0719@126.com
In-Reply-To: <20260710080140.186199-1-zenghongling@kylinos.cn>
References: <20260710080140.186199-1-zenghongling@kylinos.cn>
Subject: Re: [PATCH] perf: evsel: Fix error handling in tp_format lookup
Message-Id: <178414079877.2318976.9672767637506939131.b4-ty@kernel.org>
Date: Wed, 15 Jul 2026 11:39:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 10 Jul 2026 16:01:40 +0800, Hongling Zeng wrote:
> In evsel__tp_format(), when trace_event__tp_format*() returns an error,
> IS_ERR() checks the local variable 'tp_format', but PTR_ERR() incorrectly
> uses 'evsel->tp_format' which hasn't been assigned yet.
> 
> Fix this by using PTR_ERR(tp_format) to extract the error code from the
> correct variable.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


