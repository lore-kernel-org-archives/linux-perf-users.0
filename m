Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9F3947B3
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645260; cv=none; b=afa95qmMOzdleu5B65Prxi7Q2CMS20VtVYzV2dPE8loabcdqkPaX7koenGxV2LwzDecmLx0tK9Wkq4t3BYi36xBeS0xFsPZpXMw34MXQNEUqLy7Dl5GqBvIG9jIbv7qNVRd/FPhA3RetH2Zh7iYztdk9nQuLEDHafD8GcVKgxLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645260; c=relaxed/simple;
	bh=nLgynapcgjtIkeWlL9xNdzC/a+L22vtOb8gOj4wOhEI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F0P1D1/6BNDwSGRcG6jDxaiWjo9/3RZBz7lOjS9Eprw/4MX3U2c6Se5PlwtEmEh6+3jBkudc3Kz6EcCL9vqts2uj5HQSg9ftXIlQryNTWlbOlMUOMx2uC43p4M2Bp/VJaDYNI9PKM0c9XTIlG4Rv2NsqG2OPrpk4oypkT6ckXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff4sD3a/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff4sD3a/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1EFC2BC86;
	Fri, 27 Mar 2026 21:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774645260;
	bh=nLgynapcgjtIkeWlL9xNdzC/a+L22vtOb8gOj4wOhEI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Ff4sD3a/AjCgtkkbBjciQKQMBf+sZoMi7VLZJ74HSM37i7w68T3EMRlAsjXts4La0
	 U6dS1LHnpiF+FHe/0+IqHQXLjj8dW/ZDaN26SFn/BSSV7wiNhwg9G8EsLk8kRNV8u6
	 Dadvtd8HHpFAi3RwN+rGhCeb34I5OLBXtPdypUIC7BpZ4OjN5rrygIMyT4OMtuN+wF
	 k/sDGDi7aGHdhQ9TA2ro+GEmJ5/sFzdatW670R2m14L3854TKt4t3y3x7ZESeO6lpj
	 LA1nkxf6vvSQXiw770OS93PXiXoPeh1GIagvhTx+Wlm7KvsLddKMGuldeXIa/yxKll
	 6LFpHLRpFKNzw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
In-Reply-To: <20260317-tools_fix_build_libopenssl-v3-1-7878c8342c51@arm.com>
References: <20260317-tools_fix_build_libopenssl-v3-1-7878c8342c51@arm.com>
Subject: Re: [PATCH v3] tools build: Correct link flags for libopenssl
Message-Id: <177464525973.2796353.10114002362196527060.b4-ty@kernel.org>
Date: Fri, 27 Mar 2026 14:00:59 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 17 Mar 2026 18:58:00 +0000, Leo Yan wrote:
> The perf static build reports that the BPF skeleton is disabled due to
> the missing libopenssl feature.
> 
> Use PKG_CONFIG to determine the link flags for libopenssl.  Add
> "--static" to the PKG_CONFIG command for static linking.
> 
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


