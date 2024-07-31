Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB31AD9C3;
	Wed, 31 Jul 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431971; cv=none; b=uKqm9rkbDpXqpO9JiRMpvpdbD4s6MJ14TwrJlBqQPFSjDThL71ev2RkZNJnOZKP5zk60nu+L6Dbq40GVyiqiVkvlwsXb9+dBybG0WVSx/ygPkTDNVhUzXzLwIuEdkSeFPLhRUhkLmItDXNb9GZQajnpwtrW5FW/UUvrsHCT5TgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431971; c=relaxed/simple;
	bh=QSEndR/MK33gkGTfM0qMsV1uUgF6TjlzGBBLMLvjJuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahten3S04TCdr1lJxLe+d+WsTclEfoICsi8cZLtbk+nfMtaP/AIRZHygR5r0ZOc1VKRtDQBdK41VQaSr4Eh70F7Le/ahcfYmOou573zbaOcJpw6qQNsFk/WmPhc01ZPndQXZ5acTrxa8QkPUbqFYnx7LcpCIpSeU03r2hXxt0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSLBNGx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSLBNGx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625C9C116B1;
	Wed, 31 Jul 2024 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722431970;
	bh=QSEndR/MK33gkGTfM0qMsV1uUgF6TjlzGBBLMLvjJuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSLBNGx6JCaQ0IONv6F5u4eUZYKN5luPh3I8FQa43hT8jze2z0LyjteZmYI+Kl63G
	 VUtXKiQhCl76hPbGkSk1t+5Nu4IkeCwS6QHVJ2fow4xROMgebXIYqqhlveFy0bK2b4
	 qIlPImiwczZK1zKZpComffvxYlC0kiDBb7VMIipWeeBDvc0bbIjPVKQfgTAuk19Uj6
	 nj718ounrLwg38WmdLUp9mT1lObbWvnFigrfA73lfqt6Vic5XI2w/1yAgY+oaL8IRf
	 4sL3HtKwKhhqitYAV47KsWHnrvibGsQY1l1MANtiK4GoR3qG4FCbgzUdq+mf/H0rPB
	 d6i/kyUONImEg==
Date: Wed, 31 Jul 2024 10:19:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	philip.li@intel.com, oliver.sang@intel.com,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v3 1/2] perf jevents: Use name for special find value
Message-ID: <Zqo54HwtkDSA-IBb@x1>
References: <20240730191744.3097329-1-irogers@google.com>
 <20240730191744.3097329-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730191744.3097329-2-irogers@google.com>

On Tue, Jul 30, 2024 at 12:17:43PM -0700, Ian Rogers wrote:
> -1000 was used as a special value added in Commit 3d5045492ab2 ("perf
> pmu-events: Add pmu_events_table__find_event()") to show that 1 table
> lacked a PMU/event but that didn't terminate the search in other
> tables. Add a new constant PMU_EVENTS__NOT_FOUND for this value and
> use it.

Applied this one.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---
>  tools/perf/pmu-events/jevents.py   | 6 +++---
>  tools/perf/pmu-events/pmu-events.h | 9 +++++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index ac9b7ca41856..731776e29f47 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -906,7 +906,7 @@ static int pmu_events_table__find_event_pmu(const struct pmu_events_table *table
>    do_call:
>                  return fn ? fn(&pe, table, data) : 0;
>          }
> -        return -1000;
> +        return PMU_EVENTS__NOT_FOUND;
>  }
>  
>  int pmu_events_table__for_each_event(const struct pmu_events_table *table,
> @@ -944,10 +944,10 @@ int pmu_events_table__find_event(const struct pmu_events_table *table,
>                          continue;
>  
>                  ret = pmu_events_table__find_event_pmu(table, table_pmu, name, fn, data);
> -                if (ret != -1000)
> +                if (ret != PMU_EVENTS__NOT_FOUND)
>                          return ret;
>          }
> -        return -1000;
> +        return PMU_EVENTS__NOT_FOUND;
>  }
>  
>  size_t pmu_events_table__num_events(const struct pmu_events_table *table,
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index f5aa96f1685c..5435ad92180c 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -70,6 +70,8 @@ struct pmu_metric {
>  struct pmu_events_table;
>  struct pmu_metrics_table;
>  
> +#define PMU_EVENTS__NOT_FOUND -1000
> +
>  typedef int (*pmu_event_iter_fn)(const struct pmu_event *pe,
>  				 const struct pmu_events_table *table,
>  				 void *data);
> @@ -82,6 +84,13 @@ int pmu_events_table__for_each_event(const struct pmu_events_table *table,
>  				    struct perf_pmu *pmu,
>  				    pmu_event_iter_fn fn,
>  				    void *data);
> +/*
> + * Search for table and entry matching with pmu__name_match. Each matching event
> + * has fn called on it. 0 implies to success/continue the search while non-zero
> + * means to terminate. The special value PMU_EVENTS__NOT_FOUND is used to
> + * indicate no event was found in one of the tables which doesn't terminate the
> + * search of all tables.
> + */
>  int pmu_events_table__find_event(const struct pmu_events_table *table,
>                                   struct perf_pmu *pmu,
>                                   const char *name,
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog
