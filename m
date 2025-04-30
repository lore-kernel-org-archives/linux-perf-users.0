Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4302DC777;
	Wed, 30 Apr 2025 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745976169; cv=none; b=i+F8YLKV5PNaqcZvmwHXClFWUVmgtWhiyQvtLObbpAx9hJTvmPb7/11TOcKTBEAmeLxQXzBDKF7gPT/lXMc+s3tiitRwuTw+J6/DbDNw1scFBy6UjD2FrIBpgCcSwsluTkxVXRvz3tD5DGEyYLYK1cvfhUc+mbBRySxZlCZh6wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745976169; c=relaxed/simple;
	bh=bym2hZoT+0fNnZRujiKkWmiot74In1goRfs916Mtqs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojIYnYm3lwYpN3p5kpLrXejXJ6ogd9jkKD5mzRRf3eLouFY23ClUQlQBv7BW5r57YiItnUeyQ5GAGzsUIvZ6NBmAg1plBo3+608pVaEgJMhQafmUC+KPRbeGpglGQj4XD2GU2m0x9c/Izv1fbSOUfrsCVbdeYnGemhJ2wKI4suo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+b58z85; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+b58z85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205C6C4CEE3;
	Wed, 30 Apr 2025 01:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745976168;
	bh=bym2hZoT+0fNnZRujiKkWmiot74In1goRfs916Mtqs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+b58z859CScjvXoylJA8lGf+6tnz1m76qQEArM4vUdW3oXcH5euH9vXG1WsxQPv6
	 7dLrOuELcxkityXkjCtzphPteryYnFxztSBEbr1FNNBpPQjp0wFf4l6sArfPLvUACV
	 LqQdxBsZnSDDOAjIW5huwIwjjG1hb19s35jaDqqerU+Y3YP26Od3ay5AOBWXmky8/I
	 BMk1H+0pc6nhTe7q7XTnjRml992aLzPaf0Sb6SYcG/kXkpbuFdrHub7MaRNKXc6BrO
	 oWFYnqTepZKNTa2edi69kwfade9YRYagMzBWYOOE00MA/zs5HhGlLlPlL85t80HUJr
	 ApJzP4DjZYleA==
Date: Tue, 29 Apr 2025 22:22:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Mario <jmario@redhat.com>,
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
Message-ID: <aBF7ZarWJvzeDKqF@x1>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-5-ravi.bangoria@amd.com>
 <aBE8raTOCVZLfw7J@x1>
 <aBF5UWrxvYgbnxde@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBF5UWrxvYgbnxde@x1>

On Tue, Apr 29, 2025 at 10:13:53PM -0300, Arnaldo Carvalho de Melo wrote:
> Adding the patch below cures it, still need to test on a Zen 5 system.
> 
> These issues were just in the regression test.

BTW, all is at the tmp.perf-tools-next branch at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

- Arnaldo
