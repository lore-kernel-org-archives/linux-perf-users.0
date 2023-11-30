Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009913BB5B
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfDBPr8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9CCC433C8;
	Thu, 30 Nov 2023 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701350145;
	bh=ESm2XXf+f9FWS1yFlh8OmKYXTJZxIwuCreSBi7nmY00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfDBPr8fn0WoNKCpDTDlL374d6/n0Vh5pSkf88RafdnaRhwVotRG1gVzSgfUfMnUr
	 FnnGbWOHMSre9aDBVg64y3N8n50e+vkNiLNsLk/fSC6KIOVV0cixMVjQeVRu48jNTZ
	 VLfEY1Yafvf4nAOMyFKxPv7ydsO00A173dW3KphDPMie9GHH9/S9gBbaGrzJaSAvNS
	 wn+ISUZ23eruuJlQRrJXWjrk3uPQGmjC0iw/t3VoiVZ4XSwwI8IdU3Ar1IX/XL/OTv
	 rakfqB4dPjcYqcTFCMyhw10buFsGUMKGYcoprxGQ0d+8cndqwbSsPnFWyeCRLWv0l2
	 SW9Mu6EeOPdDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 1BF0840094; Thu, 30 Nov 2023 10:15:43 -0300 (-03)
Date: Thu, 30 Nov 2023 10:15:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ming Wang <wangming01@loongson.cn>,
	James Clark <james.clark@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Leo Yan <leo.yan@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	German Gomez <german.gomez@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
	Sandipan Das <sandipan.das@amd.com>,
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v5 02/50] libperf: Lazily allocate/size mmap event copy
Message-ID: <ZWiK/9JJjOElTTq7@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127220902.1315692-3-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 27, 2023 at 02:08:14PM -0800, Ian Rogers escreveu:
> The event copy in the mmap is used to have storage to read an
> event. Not all users of mmaps read the events, such as perf
> record. The amount of buffer was also statically set to
> PERF_SAMPLE_MAX_SIZE rather than the amount necessary from the
> header's event size. Switch to a model where the event_copy is
> reallocated if too small to the event's size. This adds the potential
> for the event to move, so if a copy of the event pointer were stored
> it could be broken. All the current users do:
> 
>   while(event = perf_mmap__read_event()) { ... }
> 
> and so they would be broken due to the event being overwritten if they
> had stored the pointer. Manual inspection and address sanitizer
> testing also shows the event pointer not being stored.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/include/internal/mmap.h |  3 ++-
>  tools/lib/perf/mmap.c                  | 21 ++++++++++++++++++---
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
> index 5a062af8e9d8..5f08cab61ece 100644
> --- a/tools/lib/perf/include/internal/mmap.h
> +++ b/tools/lib/perf/include/internal/mmap.h
> @@ -33,7 +33,8 @@ struct perf_mmap {
>  	bool			 overwrite;
>  	u64			 flush;
>  	libperf_unmap_cb_t	 unmap_cb;
> -	char			 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
> +	void			*event_copy;
> +	size_t			 event_copy_sz;
>  	struct perf_mmap	*next;
>  };
>  
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index 2184814b37dd..c829db7bf1fa 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -19,6 +19,7 @@
>  void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
>  		     bool overwrite, libperf_unmap_cb_t unmap_cb)
>  {
> +	/* Assume fields were zero initialized. */
>  	map->fd = -1;
>  	map->overwrite = overwrite;
>  	map->unmap_cb  = unmap_cb;
> @@ -51,13 +52,19 @@ int perf_mmap__mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
>  
>  void perf_mmap__munmap(struct perf_mmap *map)
>  {
> -	if (map && map->base != NULL) {
> +	if (!map)
> +		return;
> +
> +	free(map->event_copy);
> +	map->event_copy = NULL;

I´m converting this to:

	zfree(&map->event_copy);

Hopefully we'll find some tool to flag these before submitting patches,
does clang-tidy do these kinds of things?

Also, applied:

 b4 am -P2,4-7 -ctsl --cc-trailers 20231127220902.1315692-1-irogers@google.com

The ones that Namhyung acked and that applied cleanly in order.

The first one, as Namhyung noted, is already merged.

- Arnaldo
