Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65724014BA;
	Wed,  6 May 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072603; cv=none; b=j21Hra+v1yc/J52L67SCidAG5uBeyHuRM+D8OCT7mJR7Rj+7ei+pt4mblD04ZT1uF0ypBQsLUolkgsXFG9ymcfY/7MXJylB9nS9POqBQEDjZppNu3K/IQIy3NkgOSp3MlQtRDjXi/PQ485PHMl6stTXuxHg8AYZy4FS6YvxFMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072603; c=relaxed/simple;
	bh=edtlEqWfgGD8Z1I9iYpifMdMSi8hM2xRKfXQvUuAQOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDv2IjUEwohngnqLH9IyeVlNH/CikuypQW55qCDgr1YD/bsBqGJRxbxWiFhuMtRSoYC6HNOGkSnaGBO+c6XTKTGL8gkG6jxAkw2P7ZvUiZchCanqwje+G2AAtT3pLEqfLBMxi8xDvblXqFsi5f8x/pv8QRePTCNtkiseXB4eaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6fNr66P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6fNr66P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23FAC2BCB8;
	Wed,  6 May 2026 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778072602;
	bh=edtlEqWfgGD8Z1I9iYpifMdMSi8hM2xRKfXQvUuAQOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6fNr66PzOxzQuZxSXFwRsHBjGKK1AdfwVI9+60BdeqThub9J4F9CqbPoIjQ7S00e
	 utx3SOaClPiB07migQPAjIrad35AoveyM7N+zAaClaT03jyDJx3YtDl+rwZOV8wKA2
	 cKKT+eo4UcyfmD3GBpJTAalHtJfe+szMEhAIzKLwdFmCGKziqRf6HY7Mp9VlJzg+TD
	 NuX0XGGlYO6MbiIPML6S05ZqSo2ROeo+cyDJRR3rmi1mfLfKIRXDHQE6aKAy32ZNSZ
	 xH4FcxeoK7P8lckl/Qm7i9O5/mm6ZQkHUCZ6M6HrU5DZBNRPWJGd0HLmOCTOv/kyPY
	 9zqanxoOIKPRA==
Date: Wed, 6 May 2026 10:03:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: atrajeev@linux.ibm.com, james.clark@linaro.org, namhyung@kernel.org,
	adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, venkat88@linux.ibm.com
Subject: Re: [PATCH v4] perf sched stats: Fix segmentation faults, memory
 leaks, and stale pointers in diff mode
Message-ID: <afs8FC96SNDD4DcM@x1>
References: <20260506000018.3113599-1-irogers@google.com>
 <20260506041004.3196084-1-irogers@google.com>
 <CAP-5=fUPdg3vu1orm_k9ZTQVgvs+vQa2Q-+gc-TkLPnqEjH7DQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUPdg3vu1orm_k9ZTQVgvs+vQa2Q-+gc-TkLPnqEjH7DQ@mail.gmail.com>

On Tue, May 05, 2026 at 11:45:56PM -0700, Ian Rogers wrote:
> On Tue, May 5, 2026 at 9:10 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The patch addresses multiple segmentation fault vectors, out-of-bounds
> > reads, and memory leaks in perf sched stats by adding bounds checks,
> > NULL checks, proper error propagation, and robust memory cleanup.
> >
> > 1. In get_all_cpu_stats(), added assert(!list_empty(head)) to prevent
> >    unsafe list_first_entry() calls on empty lists, added a missing NULL
> >    check for summary_head->cpu_data allocation, and implemented a cleanup
> >    ladder using a temporary list to prevent memory leaks on error paths.
> > 2. In free_schedstat(), fixed memory leaks by ensuring internal domain_data
> >    and cpu_data pointers are freed.
> > 3. In show_schedstat_data(), fixed a stale pointer issue where ds2 retained
> >    its value from a previous iteration when dptr2 became NULL, and added
> >    proper propagation of errors from get_all_cpu_stats().
> > 4. Propagated show_schedstat_data() errors up to perf_sched__schedstat_diff()
> >    and perf_sched__schedstat_live() to prevent output corruption on failure.
> > 5. In show_schedstat_data(), added NULL checks for cd_map1 and cd_map2
> >    to gracefully handle invalid or empty data files.
> > 6. Added parallel iteration termination checks using list_is_last() in
> >    show_schedstat_data() for both domain and CPU lists to safely terminate
> >    at the end of each list when files contain a different number of CPUs
> >    or domains.
> > 7. Added CPU bounds checks (cs1->cpu >= nr1 and cs2->cpu >= nr2) in
> >    show_schedstat_data() to prevent out-of-bounds reads from cd_map1 and
> >    cd_map2 when comparing files from machines with different CPU counts.
> > 8. Added NULL checks for cd_info1 and cd_info2 to prevent crashes when
> >    a CPU has data samples but no corresponding domain info in the header.
> > 9. Added domain bounds checks (ds1->domain >= cd_info1->nr_domains and
> >    ds2->domain >= cd_info2->nr_domains) to prevent out-of-bounds array
> >    accesses in the domains array.
> > 10. Added NULL checks for dinfo1 and dinfo2 in show_schedstat_data()
> >     to prevent crashes when a domain has no corresponding domain info.
> > 11. Zero-initialized the perf_data array in perf_sched__schedstat_diff()
> >     to prevent stack garbage from causing perf_data_file__fd() to attempt
> >     to use a NULL fptr when use_stdio happened to be non-zero.
> >
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> This version passes sashiko's scrutiny:
> https://sashiko.dev/#/patchset/20260506041004.3196084-1-irogers%40google.com

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
