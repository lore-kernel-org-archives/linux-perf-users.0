Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B50259C9F;
	Mon, 16 Jun 2025 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091068; cv=none; b=htUIMdVgcYmlek5Z0tX53/CJHSyUfcJQlY/aK4u840dvjRx6I/4j8ihc6Rb56JVqAF7W1ovnBqZe8kOdU8FcbQh+Q7A5C4AkPn2eQ82lX5Q0hOfgVmC0T2mP58icePoQj7YlzwT2n2LlkkSGShMX+kzQAeAEQ6DeqD+zpvKmYQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091068; c=relaxed/simple;
	bh=ssHje7B9A7JzdKBxlmrv4L2ZZs2OmLATdFQs7jJnjv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXxH5rrORLLh6EaNEqPCfSbu0WPJZkeW3J7tFwYUKLBGrNt+sryCaLr4TxdIHsh8pCKzCtvaXD4LbEP3PCSZviQ7n4FudlpM6UCqxHj8X797IwQqlF5BF+d54TFUJSQcqEqTeDjMFNqIZZHZVMp8OS/dKpCNFpjoccYTwIPE8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy7Ma7SX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy7Ma7SX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CA8C4CEEA;
	Mon, 16 Jun 2025 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750091068;
	bh=ssHje7B9A7JzdKBxlmrv4L2ZZs2OmLATdFQs7jJnjv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qy7Ma7SX375nPIIslo9tQceoWvQeA3MGd/6WhYb3vA36GodaKOa+QsSlWRI7P4WsQ
	 O/wVEjYzu764zUel6GRX0zMLZBdd/9dvwdQUqBljZxnCKUPhaRF8dOTCBTBbCiHxO8
	 y/Wxs4ofBW4VtgvLvzv+t3H4G4fBAiBeENEoViPBpmIeu4SZLfuccTmX3VhzPFAk/u
	 gZOJ0863QmnHtIMF/KaJLzDM1jn7f59ifioWfxi7C5pm4JIlol4LMUkT72cc2CgjBz
	 knnnP25lmYjhWsnt1bSPQFBqs2fciTqeo1I1k8uwpcYwvmPo5WesqTFvUA9bcaDCn+
	 SDyPFGgckrjHg==
Date: Mon, 16 Jun 2025 13:24:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] perf evsel: Missed close when probing hybrid core
 PMUs
Message-ID: <aFBFOBUhHnF87R9q@x1>
References: <20250614004108.1650988-1-irogers@google.com>
 <20250614004108.1650988-2-irogers@google.com>
 <CAP-5=fUz6ViPHDdS9GCAEYUN39L4MpAnRR4CzJWggg0S8vn39A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUz6ViPHDdS9GCAEYUN39L4MpAnRR4CzJWggg0S8vn39A@mail.gmail.com>

On Mon, Jun 16, 2025 at 09:04:41AM -0700, Ian Rogers wrote:
> On Fri, Jun 13, 2025 at 5:41 PM Ian Rogers <irogers@google.com> wrote:
> > Add missing close to avoid leaking perf events. In past perfs this
> > mattered little as the function was just used by perf list. As the
> > function is now used to detect hybrid PMUs leaking the perf event is
> > somewhat more painful.
 
> Given this leads to leaking perf events on hybrid systems it would be
> nice to land this 1 liner in the next v6.15 rc pull request fixes if
> possible.

Sure.

Just one nit: while looking at:

void evsel__close(struct evsel *evsel)
{
        if (evsel__is_retire_lat(evsel))
                evsel__tpebs_close(evsel);
        perf_evsel__close(&evsel->core);
        perf_evsel__free_id(&evsel->core);
}

And then:

void evsel__delete(struct evsel *evsel)
{       
        if (!evsel)
                return;

        evsel__exit(evsel);
        free(evsel);
}

and:

void evsel__exit(struct evsel *evsel)
{       
        assert(list_empty(&evsel->core.node));
        assert(evsel->evlist == NULL);
        if (evsel__is_retire_lat(evsel))
                evsel__tpebs_close(evsel);
<SNIP>

I think that tpebs_close could be done just at evsel__close(), no?

The way it works I think there is no problem with calling it now twice,
but it fits better in evsel__close().

- Arnaldo
