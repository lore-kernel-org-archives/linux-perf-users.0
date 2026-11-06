Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949995;
	b=cE1FlfNQ/8IUzj1jIluZCCqJKyWevpp+677+zUiYxcMVHOOqEc4KYEznDPnjFawjltGz
	 1xZWGJ5iBT+Ztt6f5/iFD41myflIncHOdZdACkGcHg0ohSTf9zBxLPb5DUsRV2uhTZg5X
	 c/yg0vcyVrPCVuoAixBrOr4wBasbIP57JrJQtREP8Q1KWjQA1wmyRW3tdAl0nCKllH/8P
	 SZ5TNFJvQl4jtipqKkyeDPPd0bGQ4B1pfo7HfulCJq049ABSWkMIVXxzWfVlIgrF18izU
	 uFKeuXGxQ70YA8uAG+Iv+2eKKRsbRdQbq5OMlQTNQm7RxrUoZBnFOKZ2q6kFA6gUPGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949995;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BGdQzBcMwo7usWV7WuvqWtlKe4y+jxcjyFFOJGQbfG0=;
	b=PZ/IaVUX9erXjRJMZViYjHb1+FS8Jt9tXp+q8OtkuRS5V232QJ42U/5oRy4enviSOa0Y
	 W1Sxkfehb91ToKIxYBlKkKabqQ3a/9OllhoNHH7/6uA3EB7ZffsSxaUc8p5v+iDlNCr72
	 arvD+ADusr7gzGENYmqlxrHvHON8hr8N85VR+jQ38qUeSXjj/90Vmpn+I1nKI+X0z0HQD
	 NJmVPlqPLL73Xrl4eglBlnGRJZd+3RZDHQ1qXU0ZTs8m016WlPoYSgm+EeoTMJkr9ioXt
	 4bD8FChZcapx9uBoADaO3AoRf+jTK+6+gYlAZKd0ieGVBOFjUjIGQ2WzKUA824g53fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiViVpDy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838E606A326;
	Fri,  6 Nov 2026 07:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiViVpDy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4F91F0089F;
	Fri,  6 Nov 2026 07:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949994;
	bh=BGdQzBcMwo7usWV7WuvqWtlKe4y+jxcjyFFOJGQbfG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WiViVpDyOdAL3WJwcak2d5wU00yl9klqIRBiWGYS4JgiyKJ9fWBdCSMRZ8bBPm65M
	 qgliTPuUA3nbVDUiexvb8m4fiU16Kjaxf5YKUFFPIDyA7LP4HnXfIPIu5uXluusq8q
	 7ZDD3cebC7QNVYiWxX8EhHSOu6cgHaWVnTruTtd34Ejm1vT9KXvmhrkGEtdMZnV4nv
	 NM8/KHsug6BY68XbxGlSiZ07a1eiYyfLKizSQgxwjCD2STc1wqFuUigwf6EcjI3uXY
	 5GQC3xFLoYzJhyAy6J4zvA/zEIDeC5z0GzTXfN9xSVslbQibM1ZpLvtQd8iuxUaWgK
	 EIj5YW8ly6SXw==
Date: Thu, 5 Nov 2026 23:26:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Edward Baker <edward.baker@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Perry Taylor <perry.taylor@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <yi1.lai@intel.com>
Subject: Re: [PATCH v1] perf jevents: Don't encode MSRs with no value
Message-ID: <au2BKOeDHgzqUNh5@google.com>
References: <20261105044841.102295-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105044841.102295-1-irogers@google.com>

On Wed, Nov 04, 2026 at 08:48:41PM -0800, Ian Rogers wrote:
> Fixes the events mem_trans_retired.load_latency (EMR) and
> mem_inst_retired.latency_above_threshold_0 (NHM, WSM) that were having
> their ldlat= value encoded as python's None.
> 
> Fixes: ffc606ada3d7 ("perf jevents: Add python converter script")
> Reported-by: kernel test robot <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202611050801.67bb4af4-lkp@intel.com
> Signed-off-by: Ian Rogers <irogers@google.com>

Arnaldo, I think it's good to go to v7.4.

Thanks,
Namhyung

> ---
>  tools/perf/pmu-events/jevents.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 080e04b51b8c..e083f7495e67 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -396,7 +396,7 @@ class JsonEvent:
>          event += f',{value}{canonicalize_value(jd[key])}'
>      if filter:
>        event += f',{filter}'
> -    if msr:
> +    if msr and msrval:
>        event += f',{msr}{msrval}'
>      if self.desc and extra_desc:
>        self.desc += extra_desc
> -- 
> 2.56.0.455.g6c5a503b38-goog
> 
