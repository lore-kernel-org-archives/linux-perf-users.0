Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503B2D663B;
	Wed, 25 Jun 2025 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874684; cv=none; b=gxBymoIwVna1zrDI9KUBLSh76Gfa1bgfe4TDZBvAjGoNJJ8bpbIwGzzeFxymHfMEV9iXANMHT53aSlzEB0M/zI5V2N4JNOgg9Zf8r70NXK8Y/nfqB1fsag1I5yVifTnXzzD2bPezBmcff520KUOEnM3YYtYdTqKiwbM5kvXUFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874684; c=relaxed/simple;
	bh=j/lG9G5PnT4hkS7iNPn0oFeOsjbHWyyvjjAITmPMDfM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CptYpLawvAmVYD3qHEmvfWu1WpK3lhr7DD90AzXeBpOL2Hu1hU4tqTSEyC8Jexlnf6jBgMyoffiejrVvNgRMC1+P6+vrfxl6f2SYhClt02XB/p7FtLvf8f7a1/68Vkv74U39tO/ecyuvIb4KS2kZNwxU9QJyMBm48bAtnQSZADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlY2vx5v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlY2vx5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAFAC4CEEE;
	Wed, 25 Jun 2025 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750874684;
	bh=j/lG9G5PnT4hkS7iNPn0oFeOsjbHWyyvjjAITmPMDfM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=NlY2vx5vDGBW8rbaoq7kwv6VILJ8zlkKYKF/6WvSAZaFgkq/NiB1/fHQlROnSc3Xd
	 m2iG5VgdTVrZFEI77zyVXNid/2tE7M2yT/9nKzG1ZVfB9voWsLoujnl7TF0PLSFVt4
	 YIBNGVguErAIOOQKIKtH2gSbq/8tvwhnPiscfTtClLKomdNJLOFy/2egn7Mvdwwp7g
	 GXCWDLJRW1KDoc2QyQAM1SlGbgMA+T6c260RSOL0Dwr74q9vMEnotklLbYYCRgk7+x
	 wxXa0jO+jXW+ywXuAuwVVP4j5MgwjNd6OYdPDiX2bXQws08Ym/gZmRtR7JGUo0pVv7
	 fVs/i45zgsOYw==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bhaskar Chowdhury <unixbhaskar@gmail.com>
In-Reply-To: <20250611100256.31089-1-unixbhaskar@gmail.com>
References: <20250611100256.31089-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] tools:perf: Remove excess variable declarations
Message-Id: <175087468401.1361639.2161629209103861983.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 11:04:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 11 Jun 2025 15:29:03 +0530, Bhaskar Chowdhury wrote:
> I thought array declaration might be done in the same line as assigning the value
> to it.
> 
> Hence, getting rid of extra steps of reiterating the array name.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


