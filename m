Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7E4335545;
	Mon,  1 Dec 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608416; cv=none; b=YlWBP/UDuHQlT4ZQme5h+8BFKIMFxR5wuDm8N667QtuBMJ2FhGOuJc7SVWClRiFvfALl3Ag1Mg+/8c1Gfj6Ybsi+pAgbMLNA1FKiTMlocbhmmllAR3WWP4Sc7X/OYCYfcmg2Y09cZfYLwgNRuy/UKAcEgJyS4o1hFX3DueuaEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608416; c=relaxed/simple;
	bh=56pjLU6wJBvpZq0xg8M2LWoEWcVy7T6EnXCq8TsYGCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cysg4vTOwX4SgwACaxMnecdVsAd6xOfxYymqrHJEZThaOza8cYzO8SSOeW3hxMJgwzFc3XtDe4YsfQUa0Cvajj5+JJdE4dI0KUvE4P5LNglDfZYXoiBuNFrRAU5Mi49iEIdaNsjG8qdWJQfkIP7xYe9ww4U3JOyqFjgsoXU3u5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tE0Fk2MO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tE0Fk2MO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C5C4CEF1;
	Mon,  1 Dec 2025 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764608415;
	bh=56pjLU6wJBvpZq0xg8M2LWoEWcVy7T6EnXCq8TsYGCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tE0Fk2MO9UIE/hIKAg46qoUrFbg6qVHa4tyOhI3XRRRM5Hv4YpMUAX8N2M84vJPSJ
	 1SKgYWAppQs+O8OC8QB4ERzbBaTtt/vfR9BbLfYUlYwh9hwM3pkah600ZVCAX/Y+YP
	 F/XPhqtRhG7NrM/ReQq5/vvTqwlfHOL19ot7joItORWLZ3JPXJWeFqC2Zd8Zqa0YQh
	 OybN00tCfP9RFgeIvZsjPSn/pmmZXwLFNHZ9l6VbIMEy13Em1uEUXH/abR2WJxRj6i
	 epeGL+Lv0eGexscMbsN+poKIDb8uEWojAWgpjL4Fls82MAoIU8AbuNtez9dAv0Zx16
	 Qpx+mqUiOkUbA==
Date: Mon, 1 Dec 2025 14:00:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 08/17] perf jitdump: Fix missed dso__put
Message-ID: <aS3Jmx1-FGEpG0eU@x1>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-9-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:20AM -0800, Ian Rogers wrote:
> Reference count checking caught a missing dso__put following a
> machine__findnew_dso_id.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/jitdump.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index b062b1f234b6..27a2ea1b000b 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -546,6 +546,8 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
>  
>  		if (dso)
>  			dso__set_hit(dso);
> +
> +		dso__put(dso);
>  	}
>  out:
>  	perf_sample__exit(&sample);
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
> 
