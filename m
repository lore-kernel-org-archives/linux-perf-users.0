Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3816247291;
	Tue,  1 Sep 2026 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788236089; cv=none; b=mH+8/uWT2wl2P5c58/bKPYZzYYApNZtvT3nnACsvf3m/9MgRsdnnqtZgzsRDt8LKmB7torVwkAQF04uIvOYqHjgG7pAoStGzLxVYJDsuMDZHXarpITmCCTcL4wQ64PyvDSkxTTbmTZTVs0jlzOZgrrkSGOk1ZSm0BdF2Tfcm63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788236089; c=relaxed/simple;
	bh=j40MW8LR70f/J/jcgnkc6dwEPEf/vJ6BOKbYI1scT1Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q52NMHzvQ6EFTtGsXvOCF/amEnWTL5PmL2nWpODfXpriDJv+zfjOvaGAq2dquTxDfr5qXvQGFKYRuzRtjxQvwJ221a7HnMe+lEpfycRoL5SBOmNu72y5YprMJoSRQ6RGLBfoIh5xDk/nE967l4vrWUbqNAvqLYSbmUHUFUSIt+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7WbJICN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7WbJICN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330971F000E9;
	Tue,  1 Sep 2026 04:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788236088;
	bh=gYH20qUIGPOMdb8eIrpGmY8D7N6+Lq4/9o5dBoVppJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=U7WbJICN9Ng/FLz0EaRfOsuTpVjIm0yqbSAIK2pa4YnZ4l6p6WIV7yAbswJbFgj9q
	 m7h+BpwMt9bB+EKv3ZJ4o5XSZriOU3L5MOTw5Oq+v6dWuqUUprw6gmlzw6Y1Eq9baE
	 s2uedcURSUijwEqpW10VXCI532W8pvGE6h6oLp3/QtrJ4XgEutOY0nqZ9iWHg4fpyg
	 HQTlAvXno2qpY7Vspe9CFbivRdnHfY8JckKllf4ZcScwz/deMR5Lmeo8V+BsrLQccR
	 nk5ztvkFP6SIzkj1hAc3pAcTSgEIge0hVXa1ZbNH1gncFQi32fEY5358tKGRQ+Go45
	 CpB8GjjXrNCkQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 tlipcon@google.com, eranian@google.com
In-Reply-To: <20260825062345.115073-1-adrian.hunter@intel.com>
References: <20260825062345.115073-1-adrian.hunter@intel.com>
Subject: Re: [PATCH] perf symbol: Do not use debug file as the binary type
Message-Id: <178823608815.2655665.2768472262374178339.b4-ty@kernel.org>
Date: Mon, 31 Aug 2026 21:14:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 25 Aug 2026 09:23:45 +0300, Adrian Hunter wrote:
> dso__load() sets the binary type of a DSO to the type of the first symbol
> source found. For a DSO with a separate debug file linked via
> .gnu-debuglink, that is DSO_BINARY_TYPE__DEBUGLINK, which makes
> dso__get_filename() return the name of the debug file instead of the file
> that was actually executed.
> 
> Consumers that need to read instruction bytes, such as Intel PT decoding
> in 'perf script', then read from the debug file and produce wrong
> instructions.
> 
> [...]
Applied to perf-tools, thanks!

Best regards,
Namhyung


