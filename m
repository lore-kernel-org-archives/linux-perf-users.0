Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039A3A6F0A;
	Mon, 14 Sep 2026 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789413788; cv=none; b=iqhzlwwkH75U/Kvu8obcC7d4sY3OXJt4f+x8o5ub3Y4VgVxnJdBxeyIrnF1c/BVkKGIWgcJKc/x3BGd2h2ZsrGsdYuTskoQ+h1AAP3VIsydxX87X51vy13TFsmcduYoYJ4hq3DR3/aNtem+QJ5umVH8I3krPzo6S2DWKtVc+nWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789413788; c=relaxed/simple;
	bh=evJaLQEQyRNf2hxxzjgl77QDJrrLVEfr0HT/6x92hHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLpf+C96QBKMixLW7mAZJJoKbYy2w0PP2A8ULspSWaTLS0TpIUNvV3DArqxxK4qjwKlprFGduTrEsLmTgkBqtcxHk1RYNNoV1n/gWbs4xeAj3HfxCaOjrKny4duS80a+45lR4/eIikRHngl06ipRP50cVN/rgvVr7SyydVvF1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ign9Zi3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ign9Zi3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504B11F000FF;
	Mon, 14 Sep 2026 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789413786;
	bh=VDDB/wkwlWchiGqvcdhf3L7C9PqwzTmWs46dFVloXeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ign9Zi3RWnvDVoDjwDs7z3tZVzy5EOGlKTyDIOTFGI9tVE/49J2h4/9wHJsJpoP3s
	 nq5176yUJH1yW3ERVwqv3COXsEEmv9CDbtmQzsfTD1tQ5YUQQXIwscLlvn91Q/WI+l
	 Fo4hVPIoJbyS539rje3o5YVBPsZNll995n/CO0p1K3uwd3Nv+e0JN4uSyy4VjNiMeb
	 6jvW8xtdyXJx8cpveP/osooEoW6Zn8ig0X6qmY0Zsuapxxuof41PGwcrLPYHXgyQ9s
	 U0amr8nTmsImDz5cuhPZ1n9B1ipKZh+vLls5o+zeKgkVxVpDkeid3eb15rjytlIKbV
	 DPxG1Haa+3L6Q==
Date: Mon, 14 Sep 2026 16:22:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
	Yanbo Zhao <yzhao62@ncsu.edu>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 1/4] perf annotate-data: Convert type histogram to
 hashmap
Message-ID: <aqhJjtWljIoMKfI_@x2>
References: <20260914064535.1671939-1-namhyung@kernel.org>
 <20260914064535.1671939-2-namhyung@kernel.org>
 <201cf528-d07c-4052-b0b0-11e5f9de97e4@huaweicloud.com>
 <aqhDYxJ9qf_gE5KC@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqhDYxJ9qf_gE5KC@x2>

On Mon, Sep 14, 2026 at 03:56:35PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 14, 2026 at 08:22:06PM +0800, Tengda Wu wrote:
> > On 2026/9/14 14:45, Namhyung Kim wrote:
> > > The type histogram maintains sample counts and periods per offset.  Use
> > > a hashmap instead of an array to reduce the memory overhead.
> 
> > > No functional changes intended.
> <SNIP>
> > > -	struct type_hist **histograms;
> > > +	struct type_hist *histograms;
> > >  };
>  
> > >  extern struct annotated_data_type unknown_type;
>  
> > Reviewed-by: Tengda Wu <wutengda@huaweicloud.com>
> 
> I'm cherry picking this first patch, as I'll need to rebase my branch on
> top of it and thus testing it as I go developing it, sashiko found no
> problems and Tengda reviewed it.

It is now in tmp.perf-tools-next, will do the usual set of containerized
build tests and push,

- Arnaldo
