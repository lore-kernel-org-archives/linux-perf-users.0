Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D53CF5E;
	Mon, 26 Aug 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682725; cv=none; b=jyXxSOuTb2zUV/ZoPKenry05zAs6bA4ssCmNUqg54bNK8zgYk6Y/BdS/SZFQSqRVcllNRrn4T468eK/7FsWsUP6lyvtelVvkY4DpndeBW9+pbrYV+m/jq+b3X3FATJln76FWDquZAoo/3w3g0KegCdwOUfuUNCvhS2PFHxiD92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682725; c=relaxed/simple;
	bh=uUbYtXzQ8qWLgWs0K3Z5VUpNhl89q+0KvItifOS8Ckg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtC5VJ4ynEJq0PDRzf3K5VIGmvuQI4OH2yJpDdAsKhnKBhna4QG14fmJsGWK9oKRQ/FTA4UZlABPG7Spf7f8TBCczG3GjSgWlN9RTQGahBcDBYZi4o+IRwT9jED3AKE51en8nQFU0BUDwCfwYeao+FnIihwukOnl4w7MMvhxC08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO/3GZgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO/3GZgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A335C52FE2;
	Mon, 26 Aug 2024 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724682724;
	bh=uUbYtXzQ8qWLgWs0K3Z5VUpNhl89q+0KvItifOS8Ckg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VO/3GZgIIgetjxnCL4hQ5IVkM4pBEcdf8CVpo3wUq2UDh+cZKDUEgkDRkKtge3c9L
	 Onv0WhDxg2tNh4BM/0cu1ZNilcofgNaHIKZNx/5QJKR+tkR6gngGdL260LQboeIPm6
	 O5LvwQwcAu8mDyKn5MpLGN559onMjyDB++xRcvN2oDOAdTYtWG0buypcd2oYq5QK0d
	 hwlF7jOJuhL11VLNYBZLDfeOxESRQhX7/jkgxNMxmf5qff8jG1b+Q44VCok56BcGuF
	 rrMwoiHhNPnSs10Qt8LBAcnIP8rPxtZ2NaCjcVOkKk1MjcCQFsE3tZKv+Tpx15JPpf
	 nCKMEzJl1stSw==
Date: Mon, 26 Aug 2024 11:32:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/4] Create source symlink in perf object dir
Message-ID: <ZsyR4eQr8X-q2X28@x1>
References: <20240813213651.1057362-1-ak@linux.intel.com>
 <Zstiry-K_v51oDC4@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zstiry-K_v51oDC4@tassilo>

On Sun, Aug 25, 2024 at 09:58:23AM -0700, Andi Kleen wrote:
> Arnaldo,

> can you please apply the patchkit? This fixes a regression.

First one was applied, was letting the others to be out there for a
while, I thought there were concerns about it, but I see Namhyung's Ack,
so applied.

- Arnaldo
