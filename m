Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B191E480;
	Sat, 16 Nov 2024 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785309; cv=none; b=Ks+0j00YhW1qqWEq+Kobau8lKr1FChlS1xKycVMvuy/96xm/fcXWYsABaAvecRxGNGZClXGEtWtaVJJ1bjGwpww9TLLrwQvuEkqJ/n03VL8JVmghmZvFrh0KVL6l9gCMdcUJry3nZTywXWg4V1xJvo8vLQ3zH6m804ZlaL8Yd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785309; c=relaxed/simple;
	bh=uAKpUtak27bs6R/2ykaK7xHh1I2NnOjMstpCvuaBX7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3DiLhNdJl/tAeq8/YJ10a1XuDDQx4G67l/lxxf1uF+HeRRpciL+QnOI+obGurFCpeAKMxpYA0RlxMLE9DPIUR1F9ProGfL1eHicx/xx+vtfj/cXfT780BkggS61P1qUbN9Nekq/6mM7Ho/B1es8DGth8suqTBa4oqwVZNArg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqAUc2n9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqAUc2n9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54FFC4CEC3;
	Sat, 16 Nov 2024 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731785308;
	bh=uAKpUtak27bs6R/2ykaK7xHh1I2NnOjMstpCvuaBX7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqAUc2n9sSDLeuL//OHSIqGfr9o2yCpgH/EFZQ+JfToUxWRbBMWkuI2AoYCXFgoxp
	 nIe8nxo/fbggEstJQqxmuusw9qap1FJSmSWat9byenctKVprcJQjjP2IcIxRoDg/bB
	 L/yWWTdOS9B+zfavCS+WKaQE1k9vEiac2jCYOYHs0Olh/2vQg8hS0JwEKJO9O+Y1e/
	 3PU8YeJMQo17LVen+e9eIcbQ/5lgV0Tqif8tkgvsc9pBFVWmxIbjDtaMUIDMmAWzHB
	 BVyORlTXTjWNoDflce0D8JCEq2hGvKCsiZuQBNBzCVr2HYzdQhVnSE2yIZkxGwxrZb
	 pOl2haXTSDp3Q==
Date: Sat, 16 Nov 2024 16:28:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: Make leader sampling test work without
 branch event
Message-ID: <ZzjyVgnEUOYknN1k@x1>
References: <20241115161600.228994-1-james.clark@linaro.org>
 <CAP-5=fUq1JLCVLQerQbK+itNg2RZaP9zCo9RUTgKoGqTQi3yYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUq1JLCVLQerQbK+itNg2RZaP9zCo9RUTgKoGqTQi3yYQ@mail.gmail.com>

On Fri, Nov 15, 2024 at 10:54:43AM -0800, Ian Rogers wrote:
> On Fri, Nov 15, 2024 at 8:16 AM James Clark <james.clark@linaro.org> wrote:
> >
> > Arm a57 only has speculative branch events so this test fails there. The
> > test doesn't depend on branch instructions so change it to instructions
> > which is pretty much guaranteed to be everywhere. The
> > test_branch_counter() test above already tests for the existence of the
> > branches event and skips if its not present.
> >
> > Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
