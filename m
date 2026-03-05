Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161962882B7;
	Thu,  5 Mar 2026 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692074; cv=none; b=HuNm/woF2BDXmlc19Ec4aviykczC/dIE3wuT7KVt81ZjGpHbmjqDSzxdbiyoj5wTe2LiIq3muh9UYEKF0GKPgHBiW44WLjgyNOLs9d912cmha33b53SMdxLJgQjP0hLhWRif+eRWO0yXb7xB/6M/iixZIpAgT5sf1WDUTvoObEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692074; c=relaxed/simple;
	bh=aakXQvT8QCdtoItYFfR6oq2KvgljUs9J7kTaek8gkiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thXUOKjw02IwgCrjWVtk6KyblzCOv0YmSTSKAwqV9Q2QeTq+HJTX+rIjjAebubeTseq3XcXYRRXUhf5DhnBJKbRuBlrGTnDJR5frX9rmkwzj3A3ud94/QOiMXdNUsDFa9dTDchXY2UQGd1FG6q0KqIeCW6MZTiOiU6YjJWAS4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cISl1FEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cISl1FEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB22C116C6;
	Thu,  5 Mar 2026 06:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772692073;
	bh=aakXQvT8QCdtoItYFfR6oq2KvgljUs9J7kTaek8gkiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cISl1FEfYD1WiVv4u2qK6Y+lY7bOYtCPfdVGZkHCLEd52NtSdzROQwJkgCI5OZ3SP
	 nIlTP0EdjkDc2s6Wq7/4C2jbMOaAjdG1J55aq2oJhavp8XHJQjW6qLWGMScgtXUSk8
	 u3G26G3NXdUKHGL8hondPPG6uigspX4Q5miZ5lE3nA1Iv05Jld58sNeQhyFaNPmgcV
	 mpdX/ooqH2/WzKBliO86DF8RDNY+tUfO/cZSPtaWRSsNSmNQSPzhUpiqAsqFD5HP8O
	 xrmJeLgVoa2/HkCJfJU7o6Bflh6Qx2e6IN3KcqlWXUiegQ72IMxY55khlwRDidhxnO
	 msvJT0RZFbuag==
Date: Wed, 4 Mar 2026 22:27:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Derek Foreman <derek.foreman@collabora.com>,
	Howard Chu <howardchu95@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Hrishikesh Suresh <hrishikesh123s@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] perf ordered-events: Event processing consistency
 with the regular reader
Message-ID: <aakiZ_NyxlLvVSoy@z2>
References: <20260228065953.3226283-1-irogers@google.com>
 <20260228065953.3226283-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260228065953.3226283-6-irogers@google.com>

On Fri, Feb 27, 2026 at 10:59:51PM -0800, Ian Rogers wrote:
> Some event processing functions like perf_event__process_tracing_data
> return a zero or positive value on success. Ordered event processing
> handles any non-zero value as an error, which is inconsistent with
> reader__process_events and reader__read_event that only treat negative
> values as errors. Make the ordered events error handling consistent
> with that of the events reader.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/ordered-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index 8c62611f10aa..a5857f9f5af2 100644
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@ -243,7 +243,7 @@ static int do_flush(struct ordered_events *oe, bool show_progress)
>  		if (iter->timestamp > limit)
>  			break;
>  		ret = oe->deliver(oe, iter);
> -		if (ret)
> +		if (ret < 0)

Are you sure all oe->deliver callbacks return negative for errors?

Thanks,
Namhyung


>  			return ret;
>  
>  		ordered_events__delete(oe, iter);
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
