Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121861426F;
	Mon,  6 May 2024 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020573; cv=none; b=rC69j2AP9H6pBMtBSRflJfbPizAuGR+qMzHG0kypbyIFCioufX17WtbNrClioaXU+W7N/9d51+d9qZGT5NWawJm6RYpGE2xNBzOSzUnGyQIDY8yRH+LS4x4sRGgwMvdxDq5UotGt8G2HpJA5A5fJR7+9i58KZYr7IwmpC8B1sWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020573; c=relaxed/simple;
	bh=GZa/wPUGojJfxaJOHsD5KLlJ1l/5vASRHRzePy2aJGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0ZdWFiGkf/+pR5/sVwSdZZmsEWTl+mok0+ugc/cYIPPhwmZWelusrFJMhIpUvrare5Jh3BWX+rGYCfFQlp39XzGAorPdszAdvTdJwaIHarZ406ZHlLMp5LwTpiPilWFs4jFloJ6cwunu+fFrAHnLDoosuloy9R7F97LAjqa+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qql9OWjK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qql9OWjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A407C116B1;
	Mon,  6 May 2024 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715020572;
	bh=GZa/wPUGojJfxaJOHsD5KLlJ1l/5vASRHRzePy2aJGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qql9OWjKemsavWDfOZqrDHDQLdALbwxGdM2GzYG2gTYplVys3DBcZPHhqK7/gGTRg
	 Ua23ZtVxPN0GYbEvuYPfy4nRpPhWHmHUKfYPqvEtaFVjOnqK0bpn70b8zVX1ob51cN
	 e4ohCGXI1IIy653OAhPj+DuA4kvc6tgDtvh8nZ5Xq43P1AUdDAHbqwmKUNKIjfwQAn
	 Ee3yPcqkaGf0Z6eQMedAjDSXKne69hru8MwlXjqPtnrdwI1wF+MupYarbKU9Q6XYQo
	 SKRH/3kdZ1Ay8L+siLZBqm9hYbfhovSO/XHqK5BETg4SJmbRHCmw0RWdy7b+Ntb6jE
	 lSCGt2f+/6+UQ==
Date: Mon, 6 May 2024 15:36:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] perf map: Add missing dso__put in map__new
Message-ID: <ZjkjGL6krayHC_XX@x1>
References: <20240506180104.485674-1-irogers@google.com>
 <20240506180104.485674-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506180104.485674-2-irogers@google.com>

On Mon, May 06, 2024 at 11:01:01AM -0700, Ian Rogers wrote:
> A dso__put is needed for the dsos__find when the map is created and a
> buildid is sought.
 
> Fixes: f649ed80f3ca ("perf dsos: Tidy reference counting and locking")

I just sent a reply asking you to do this, thanks a lot for adding the
Fixes tag, processing this new series now.

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/map.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 117c4bb78b35..e1d14936a60d 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -200,6 +200,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  				dso__set_build_id(dso, dso__bid(header_bid_dso));
>  				dso__set_header_build_id(dso, 1);
>  			}
> +			dso__put(header_bid_dso);
>  		}
>  		dso__put(dso);
>  	}
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 
