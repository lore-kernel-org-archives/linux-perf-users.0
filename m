Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7B3F5BFD;
	Fri, 25 Sep 2026 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332313; cv=none; b=X+elx7QLggPM11PAW76LWfBJfricocC6l9dX4bGc6MoNuRNzKMM2+NvS8gitGs/9Nye4I1vOTqFrCtyWfd9kqyx4PfDsLp9xi93JYO62vekpi5h1E1T8kWiEQgzQaSGqrAxrv6rXAU8ps3m2zkC2WgPqWcE6JJ64V1PebmIlim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332313; c=relaxed/simple;
	bh=A3iiIxFr/AWrVtDAz6oFNjqJfl045U2hhYWWA0kwB8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDVf1StEBiubutHH3Hu+x2Nk7X1vhYbVH2iwkdHCav0jz8TMIMJk4XCsEI6/s/z06XsHGYfTnfbv7zuS2F50BDZg/7N0Rn+bhBSw+wlg4dO8ZLDGr+7E1o8cx5iPtusTymxN0ZuM3kbR8H7IMsxV+9wsCkiNXMYhN2nyOqxgOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFh05/CW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFh05/CW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE031F000FF;
	Fri, 25 Sep 2026 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790332312;
	bh=9qa1eqfWkeyPHZy7/1Nc4UwLf1SaoqrDP6nwckO+zKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KFh05/CWgMWzK+m571PEsHrByqXxLm0wv44ws+S+yI4Jkx5GRkYOj7b1lYgGNeP8O
	 NCdFsM2EIcxZg/XCU060FBJEL8VJheWkOD6sIl5rW2LDYViIYFGcszvcf2qsJSnmcb
	 Jj8WMh7r/T3flKZENqYOaCiwtl+z7ofVBz00I74WPi0llt+j0Y1ieVljIPOBIAKVxu
	 vb+s9Bg2pqpJJctMh46kB+234Mbn9x7ZhIF3S+Et4XtN4UA43KypThjawU0wBJlLY4
	 /U5j+IIB6MXyNecyOSs2+SmLda8pEuIczb+OvcUjuNFL8zqmQ6qvwJWzpcC3prO+q3
	 +I7Bj5fJ5haZg==
Date: Fri, 25 Sep 2026 12:31:49 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v4 6/6] perf mem record: Use the IBS swfilt filter when
 available
Message-ID: <arZNlT3kb8Gg8kVo@x2>
References: <20260924212809.1733663-1-acme@kernel.org>
 <20260924212809.1733663-7-acme@kernel.org>
 <76ef085b-e8e3-41a5-b029-2cd0489aa430@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ef085b-e8e3-41a5-b029-2cd0489aa430@amd.com>

On Fri, Sep 25, 2026 at 09:32:42AM +0530, Ravi Bangoria wrote:
> Hi Arnaldo,
> 
> > IBS events with exclude_{user,kernel} bits, as used for per-thread
> > recording when kernel samples are not allowed, are rejected on hardware
> > without the privilege filter, so per-thread 'perf mem record' fails on
> > AMD:
> > 
> >   $ perf mem record -o /dev/null -- true
> >   Failure to open event 'ibs_op/ldlat=0/u' on PMU 'ibs_op' which will be removed.
> > 
> > Kernel v6.14 added swfilt, a software privilege filter exposed as the
> > 'swfilt' format term, making those events usable per-thread.  Give the
> > ibs_op memory events extra tables with the term, selected in
> > perf_pmu__arch_init() when the PMU exposes it, keeping the names that
> > need system wide mode otherwise; the knowledge that IBS needs this
> > stays in the arch code.
> > 
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > Suggested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Assisted-by: LLM
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> > + * ... Keep it even when
> > + * the event has no exclude bits yet, 'perf record' adds them on the
> > + * first open failure and retries with the same name.
> 
> Currently, 'perf record' fails rather than silently retrying with
> /swfilt=1/. The reason to not transparently add /swfilt=1/ is to
> make the user aware that software filtering is being used, and it
> is not overhead free.

Made it more concise:

+/*
+ * IBS events with exclude_{user,kernel} bits are rejected on hardware
+ * without the privilege filter unless swfilt is used: the extra tables
+ * carry the term, selected when the PMU exposes it.
+ */
 struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
        E(NULL,         NULL,           NULL,   false,  0),
        E(NULL,         NULL,           NULL,   false,  0),
        E("mem-ldst",   "%s//",         NULL,   false,  0),
 };

+struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX] = {
+       E(NULL,         NULL,           NULL,   false,  0),
+       E(NULL,         NULL,           NULL,   false,  0),
+       E("mem-ldst",   "%s/swfilt=1/", NULL,   false,  0),
+};
+
 struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX] = {
        E(NULL,         NULL,           NULL,   false,  0),
        E(NULL,         NULL,           NULL,   false,  0),
        E("mem-ldst",   "%s/ldlat=%u/", NULL,   true,   0),
 };
+
+struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX] = {
+       E(NULL,         NULL,                   NULL,   false,  0),
+       E(NULL,         NULL,                   NULL,   false,  0),
+       E("mem-ldst",   "%s/ldlat=%u,swfilt=1/",        NULL,   true,   0),
+};o
- Arnaldo
