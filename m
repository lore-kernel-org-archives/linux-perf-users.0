Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC35298CA3;
	Tue,  2 Dec 2025 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764650476; cv=none; b=EDzpvSa7po344a78YToXpNdbgO/WmA7JPIsoGVAkcdGlVUfPpMznr57wG09acKv5doTIinHuwYI+VBhO3O3S10CXrtMVnT/9fuM+1AGqU3FNRaIZNSm9cS43/gwkeFsuxgCm5p8Hf2kLtbK2SXN5/bX5T2b6fUofLkecP3w9xbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764650476; c=relaxed/simple;
	bh=paPfaUVECUv+Wab7ih1QhE2SzsUA62tC1hQ0kXpLzrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8oJoBPHkX/R2+rdS5R+zvGEB5cX1kKP8yW2Rczyuay1G4sdNi8CoZ/PI7l9dpYMWLF6n6PORRtUkjR8sJOCSQhJRYPxs0Y/KY95HhTQF3ADfEMdRxYZfaE+VYVFp3MoADKUqgRYaMCNql7jd7pm56iGu6zkMmymp2f6lAjL7qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glMUP8v3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glMUP8v3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD64C4CEF1;
	Tue,  2 Dec 2025 04:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764650476;
	bh=paPfaUVECUv+Wab7ih1QhE2SzsUA62tC1hQ0kXpLzrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=glMUP8v3ICx4BK2oWwPegexzlHKE2xOiIQq7YqEm2T+h936J3S51CGKZQnHsoydE2
	 V2UA6+7WRHMdOaqqxwIXKTotOG//XOZNBNgP/XdxDHQNXJAt6KfE6mgeYxuwIjNkjP
	 BWDerSNK9JgHKLXMiyomar132GD2ji1qTuvP5h1Op2EcEwREfT2OibfmQ6Rgi/ZV9N
	 3j+7yLMXXoQkVyuO329TXFPJbYkh0oX6f3O6VL+QdvpQ60yBt58YA0F+U8tq47WgtT
	 3EwhJExrAZF831wQouzadftPsRmgDpB5PBCtrT5zgM9NHMoXDQfoKt1+lLQeCjA+pe
	 62TNWGmNFYlXA==
Date: Tue, 2 Dec 2025 05:41:10 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] perf stat: Allow no events to open if this is a
 "--null" run
Message-ID: <aS5t5hCk0vde4QvY@gmail.com>
References: <20251201230904.290733-1-irogers@google.com>
 <aS5tRnf801Sm3z8P@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS5tRnf801Sm3z8P@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> Note that without the cpumask workaround patch I sent 
> 'perf stat --null' still segfaults on perf-tools-next 
> even with the above patch applied - I suppose that's 
> expected, right?

Ignore me, I just saw your fix series:

  git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next

Thanks,

	Ingo
