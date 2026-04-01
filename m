Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A53AC0CD;
	Wed,  1 Apr 2026 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080373; cv=none; b=af3RVJvzXLxgBKbZvXUjxdbotssx32+NHO27UbjAZow5Nbon610T+oI6gwkh1YiBAjuW3ZpxPO92baXn6+GPjCSV2ydRX0rezU3vLYosyhOm7yqsV81EHKuj1+BN5NUziWcLPA+yq/KmNC7HwVTPcKwF0p+gOZoucfnISDbYqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080373; c=relaxed/simple;
	bh=ksCu80ckd59s4DFmn66BsA6p5OcmXlRlDC4JaIECEjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g5XnlKjn4Ygudnb1CRvXNXm+aEvvFKnANShBjr2sIOhxOcmGX1BNsJ9TmAMRoC7z2mgJwx+6L+ikX0lRCx+FM1Gy8ZxS6dgDHYxR1GUX5QhLc4UcRHKdts9pCkkbXDJ+C59iztnmZBNW5hQnN6Tsa0VczqhO17ewWCRNN2crCkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLj+5Pg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLj+5Pg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3FDC2BCB0;
	Wed,  1 Apr 2026 21:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080373;
	bh=ksCu80ckd59s4DFmn66BsA6p5OcmXlRlDC4JaIECEjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RLj+5Pg5k6Pc5dUEFEkEVz3XWN0mV9QQle0S2k1e80J0yyF+HNckvG69gZHQtl30s
	 OhhJCn5jlTVcOkd5MrUY1XUbyFuQh1znCnjqriG5qgAkuZx3MQE5cuF/nOZ9i3cSCJ
	 A3Wj8txt174GTQ9+KXW0OCbZMU2JPPaEtJvLUGhHtN7xUayYuwtXmQn5sxucF/8gce
	 pxqaK2p9o9AG0AOXsQ47pk56z7EBkTKPY3FiLpkMuEN87T72T8gckFqfAbaGQxSZtd
	 hUph5Pi8PrpypF4PKeaXnRkTmA3l5VtTYEx9mCZwMT8Bz3/FQHhyfg4NsdwGOafrve
	 RcF/rZ1qyzylg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260331210634.2126391-1-acme@kernel.org>
References: <20260331210634.2126391-1-acme@kernel.org>
Subject: Re: [PATCHES perf-tools-next 0/2] Move some headers out of
 tools/include/ to tools/perf/trace/beauty/include
Message-Id: <177508037291.42628.8380108620524736779.b4-ty@kernel.org>
Date: Wed, 01 Apr 2026 14:52:52 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 31 Mar 2026 18:06:32 -0300, Arnaldo Carvalho de Melo wrote:
> Since those are not used to build any tool in tools/, move them to the
> directory where we just track for changes and use those headers just to
> scrape defines and turn them into id->string tables used by 'perf
> trace' (or any other tool in the future).
> 
> Best Regards,
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


