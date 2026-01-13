Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5EA1CAA79;
	Tue, 13 Jan 2026 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319307; cv=none; b=PTTLq6IGorB8SFBk4gpvEJxdeu39pUl1zEj0u1bFF2iqoEvm8cp8zp5Kq7J28n+uPk2LVvnIL2TUNafJNWeue3+a8ub7Dd0HO8V9jFG0GjqGNx9Qe7n7lYWH2efyrGMrf7szZKGEJyITaxwSjiAHeBeUiY/sg+9+fK5MLPlJm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319307; c=relaxed/simple;
	bh=Mw1wuH5t6knsXTu/DD9sgF9X26UR3qFSwgFjSQ4aft4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBmC61t5mbRqilIICpcUeGQojsJcmlyUbvhIWfDTXDhr9DTC2dOpIRcD+Ya8fQvpxej7ZxmDxJ+PSPCFwkbRKzYktFAGk+BY3BacoBbxaR7Hn1Caf1m5YSgKVDbBxMBrpWG5vhBL7ZIzICeJQLEZCpfZd8BgjciXX6Ive+1ocY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWHYGsmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWHYGsmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6B1C116C6;
	Tue, 13 Jan 2026 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768319307;
	bh=Mw1wuH5t6knsXTu/DD9sgF9X26UR3qFSwgFjSQ4aft4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWHYGsmjcSKbL0PDWZBeGtbuPGgxz7xJTUIQibOKNTw4N8qSkbRnZLW23lafbf3JY
	 z5xfPN0SyQm8rT/dZqrTxt5MzYvxjNgac2lMsMDAwWE3undNCPcvnmL02Rg7PjNVsw
	 ufmWeJfRc1fXQPcsezUQzWhJ8mju1L0Rz7C235IVBnZq+sBYHqROGrWGYGM+A30bXC
	 vco51mWnea/bmeBAhuWbJmxdjHQFD4QD23A8vAY0OW4/sM0aPLj7wMSwbgoNY2hmZh
	 YAohly6+eJ7FhN3GhB1C3nZ4bfB6lteJJlxHPmaRS9mZtELfaljuVN+aomff2lBMQK
	 0V98Qohydsf/Q==
Date: Tue, 13 Jan 2026 08:48:24 -0700
From: Tycho Andersen <tycho@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf: fix segfault in `lock contention -b`
Message-ID: <aWZpSBMnz43t1Mss@tycho.pizza>
References: <20260109164417.396138-1-tycho@kernel.org>
 <fb38d19e-f4b4-4f89-a41a-78a845861468@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb38d19e-f4b4-4f89-a41a-78a845861468@amd.com>

On Tue, Jan 13, 2026 at 08:41:24AM +0530, K Prateek Nayak wrote:
> Hello Tycho,
> 
> On 1/9/2026 10:14 PM, Tycho Andersen wrote:
> > @@ -43,19 +43,20 @@ static void check_slab_cache_iter(struct lock_contention *con)
> >  	con->btf = btf__load_vmlinux_btf();
> >  	if (con->btf == NULL) {
> >  		pr_debug("BTF loading failed: %s\n", strerror(errno));
> > -		return;
> > +		return -errno;
> >  	}
> >  
> >  	ret = btf__find_by_name_kind(con->btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT);
> >  	if (ret < 0) {
> >  		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
> >  		pr_debug("slab cache iterator is not available: %d\n", ret);
> > -		return;
> > +		return ret;
> >  	}
> >  
> >  	has_slab_iter = true;
> >  
> >  	bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entries);
> > +	return 0;
> >  }
> >  
> >  static void run_slab_cache_iter(void)
> > @@ -301,7 +302,8 @@ int lock_contention_prepare(struct lock_contention *con)
> >  			skel->rodata->use_cgroup_v2 = 1;
> >  	}
> >  
> > -	check_slab_cache_iter(con);
> > +	if (check_slab_cache_iter(con) < 0)
> > +		return -1;
> >  
> >  	if (con->filters->nr_slabs && has_slab_iter) {
> 
> nit.
> 
> Now that lock_contention_prepare() bails out when
> check_slab_cache_iter() fails, we no longer need the "has_slab_iter"
> global indicator.
> 
> Both this, and run_slab_cache_iter() that depend on "has_slab_iter"
> will only run if check_slab_cache_iter() succeeded and the global
> indicator will be true in both those cases.
> 
> Can be separate follow-up cleanup.

I guess this depends on whether it should work without BTF. Presumably
we'd want to keep this check if the goal is to make it work without
BTF.

I'm can send an addition cleanup patch if we decide not to go that
route.

Tycho
