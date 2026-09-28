Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801D4E0207;
	Mon, 28 Sep 2026 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613600; cv=none; b=rkOQvyQSr+VAz+83F7q7GawJGI4z8dW6dPHbcieX5MogfrGXSfy4FtHkm8KMWfmOEnWXxSXY05fPqQaNfPjCUCxaSIqYBxjr7E2ooSVYVTkiCT7krxRAOkV/YRk5MjJ0NNcFIbM8P4tM7XDiA4AVpS4xDTdlcE5CGy8KJoLhcNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613600; c=relaxed/simple;
	bh=EI+ExcLlqUMlwR+1/cXEMXjfhgLk3Tb6j3gLOjZVYEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd9xCVfCcag8zDfNPEVpxArNgs8YAJc3nbOOwGAjzxKaWfUD7xt66jtHwLLq27w1eTrHpnrXR+umQ/5XHWum6L6ljoUweHSoIFA5Eydlc0LjSLcISSxq3+VJMZ07UCVhpuNSCApGP3JGToo3VzQqU885/7M4EZ0USSWdDEJbOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKxx/D1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKxx/D1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790FE1F000FF;
	Mon, 28 Sep 2026 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613599;
	bh=c6m6jRyI1NLeD77KG7fU8tiGxkfFIZL+IbELI4e9oc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eKxx/D1gebg9IUHY5s/CMz6d7BqsCuKd2JkInatrHw0JVYIsar9xQQ9S+c+0EXLfb
	 /Hp0eKhN97TfR3TupbIhwdt8Z52pzTpyZfJWq+GW6m+UN+XnGE511eOj1UaIgwcS43
	 TLxSfqUcLHC0EVogWHRS5o+5OW9E0uvBt/FEjMqhH1vzSPn53MwOYv15t7drPtSgvU
	 dbNhULKesvJ3HG2pFSzlFgb3i8Y/cs54ayvuZxp8QfJ4tZwzQkMktpCsIyD+XqNdUF
	 LSNW+St5VuKbGZlBSPxAI2LSymWqhpYRKjMEvz/YnYCoA8lmCrd8ibEN6pFkUs+M6j
	 W130PGtjd0Scg==
Date: Mon, 28 Sep 2026 18:39:56 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test code-reading: Fix duplicate kernel maps and
 machine leak
Message-ID: <arqYXHPRWlqbDwYh@x2>
References: <20260928075517.3057621-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928075517.3057621-1-irogers@google.com>

On Mon, Sep 28, 2026 at 12:55:17AM -0700, Ian Rogers wrote:
> Furthermore, when try_kcore is true and !have_kcore, returning
> TEST_CODE_READING_NO_KCORE directly bypasses out_err, leaking the entire
> struct machine, its kernel/module maps and DSOs, all kallsyms symbols,
> and host_env.
> 
> Remove the redundant machine__create_kernel_maps() call, check for
> !machine after machine__new_host(), and jump to out_err when returning
> TEST_CODE_READING_NO_KCORE.
 
> Fixes: 0fd4008ed755 ("perf test: Use machine__new_host in mmap thread code reading test")
> Assisted-by: Antigravity:gemini-3.1-pro

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
