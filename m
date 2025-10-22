Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5588F54;
	Wed, 22 Oct 2025 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093557; cv=none; b=DY+pyTrE2/zlbPZ+467MPbcN0dv6Mmt5oOTESbeFvvJbwMvZB+cAbFPHtUBUNmINTYpx5jU8NMks2Gx5S9aEWAha3nggOtmdRjqGR6dwbddIWqWzEyx4R5NlsOFQOOa8/eor2Sa7u6Mwoao5Np9z+cuJiEq+3edfIwnhAlXwjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093557; c=relaxed/simple;
	bh=n6HXD5TiXRdOHMl0HJ9ijcZJ1DzLL9mTOPFdai4aiCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gb6hoGF7WVmEPa+ugadEuzWyZif0MRuODwBfxKtOlhkN2x0KwbmFZmma0XyapFo36uzMA2conw6y1klylizMSpdx9AXyF1xIXdaNqxb0mbkR5PkolKortl+8lC4yX6LOfyhnP9ID/2s9t32IMk0+YZGXGdqaa3qEwIftSJQm9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG6lSGnH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG6lSGnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73DAC4CEF1;
	Wed, 22 Oct 2025 00:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761093557;
	bh=n6HXD5TiXRdOHMl0HJ9ijcZJ1DzLL9mTOPFdai4aiCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HG6lSGnH1FXvByCqfpNb+a/k0tmVS8ZiLIRzr7fkJOjrGOU23YdCLabvSOKmpE9o2
	 oXYlVtp/tYwyFKD5hVi7y90noEBrXlphX/UGnYJnHm7y1lBRnDSnBjN/j8DXbDrY7L
	 MUPT/W8dHbyRZceNP9c1I8Q5kHsDL61FS1fJEBjmbZp2yFo4mtbZSRvv8xA75hv7h5
	 gT0LDPXErnzUS+KLuk9jQjqCBckCG102hMX0fFN6UdvFU2I+YXJk7Z4al4Zy697z66
	 F644tv02pMwcDK6AQgCM/ikI/+dnZEjFLcxHOyMUXwbPHYVrQA7/R+zRHB26RfNtbb
	 lIh25jzlVnzVA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
Subject: Re: [PATCH 0/3] perf jevents: Fix build when there are other json
 files in the tree
Message-Id: <176109355662.1850903.15541679412583990245.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 17:39:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 20 Oct 2025 17:08:25 +0100, James Clark wrote:
> I hit this issue because I'm using clangd with a json compile database.
> Not sure if anyone else will actually hit this, but it's not impossible
> and the fix is trivial anyway. The first commit is the fix so has a tag.
> The other two commits are minor related cleanups.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


