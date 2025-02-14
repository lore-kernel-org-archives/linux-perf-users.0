Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11311D7E47;
	Fri, 14 Feb 2025 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568194; cv=none; b=b0eTsy4P5o9/GtQ+YjuQBBK2KxgIfrlWgGC4pZHVt2uLXEWXFRTHJPmdJeGARTKyDLRDb9xAhTNQx3B9X6oU0BEX+iIcmb+3TAET4GYKWOyKhE/srSjHmfU1V+xXtOim44rb28LsmFk7uehX9IITY/opfF5ZU3n8BagJI9CCpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568194; c=relaxed/simple;
	bh=axv0t9QvHDu5qpReuMVVi414PZiyL/gXj9Us176yriA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dafK+QFFWekuZfyI9U8gjbwSiP2x3cJtFlKqBv6KGNqnAewPCR9LDSaBADlQHNHYzCRcnOnfwsIq91Xbkjm54Ii7GOovTBxJdpfxA2eCzLeIW1V0egvnpLz7Kv5tZkeLlpjmgKaq17H09Tzemak7jFfMkexgk9Iu4f3lioSOTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdx9migU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdx9migU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EDEC4CEE8;
	Fri, 14 Feb 2025 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568194;
	bh=axv0t9QvHDu5qpReuMVVi414PZiyL/gXj9Us176yriA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hdx9migUkgBRnO8xH6MZ0A/U7/POd59CWcnyZdH/pnxMxTxXCFw/pSB/hxzlVEE4I
	 1ruv9G1RQztt8KQy3LxJRM9zYUUEo7OY9zhFHaTQqUrmXvZgmQs74SqSdvOC4f9dZV
	 8Tjzusx1XtOuqZraX+koj4oCyHgE9WFT3PUhfiZfa0YQ2IfwQPk+0hRaah20dysZST
	 CWcmlS+eh+V988Myya3DSmCf63reIDUHg4qg+2OAFGyV2IspMZUyvTf7ZqRt06YpDO
	 jUe5kw4kQZgaYAmqLj9cXsxNmuZbqQm//DIN+RDxFN+5dzJPUUYVsGesGaf983tdwG
	 ZaH1PSPUL81pg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20250214191641.756664-1-namhyung@kernel.org>
References: <20250214191641.756664-1-namhyung@kernel.org>
Subject: Re: [PATCH v2] perf tools: Fix compile error on sample->user_regs
Message-Id: <173956819403.2296227.5010989728366177558.b4-ty@kernel.org>
Date: Fri, 14 Feb 2025 13:23:14 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 14 Feb 2025 11:16:41 -0800, Namhyung Kim wrote:
> It's recently changed to allocate dynamically but misses to update some
> arch-dependent codes to use perf_sample__user_regs().
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


