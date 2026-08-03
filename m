Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D83433BA2;
	Mon,  3 Aug 2026 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783749; cv=none; b=qetfL8o4LTGSn3oBe4k6NlSwv+W2BzLlGDYTB+8cyHMywfPIEarawHfYZQfu8xlHQlyqWtEwAKtWzAyAaZU6bigEiZJoQDwmW3trNM3EJsv10g8z/oVM1OPVyBrcK6TIVpfOgTYuXSVbRPTHGYIHL0bVnoeS/UD39w6K8A/VXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783749; c=relaxed/simple;
	bh=VdEPFFIK9v4oK3n9lyzGt0+LpVa6m2n7DEC0udR6TIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEL8L/fKygGcgHHehavpGGYg94E/Q2iZvEfb95ikZH1tIVGWZ5QpKYctJfQTRz9kJU/XGRR42GV7kBNtXKrYR/99PIqIzaW+T7oho0PtPsv16oE8dGUFlcm25zUdUX3yT/BLbRL7XlPGQI6hI+Ob4H1HBtsbGMN+e/gY0DIqle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3N/K7Xz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3N/K7Xz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F39A1F000E9;
	Mon,  3 Aug 2026 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783748;
	bh=lkGUEiJlQxDIOKEqvENBdks8oX6NYvEYrvf4uwwHl+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l3N/K7XzfR1uHp0Oz2evWxsVMyMxTDIMi3ziVfnKIljOvkvXWkj2g4F2N4wT+liun
	 JOoet9k8zzd35TNYpT4KIxjTQf9cRL861g9AAs+gYLPqwgPCHv+nzW1aYNB2SO9wBS
	 KGKBUw/yWt1IK22AFSrQFQ9GSnPH/fwNXUF4JGqlPI66HA1CijHCW1+klvt7AfICiv
	 0Zg0K+pQVHQoMQxbjzFGa+oD886pG6rzPyhx0WiQs5fECo0asxZSzER/k9o1hkunB+
	 6eNEL8qHtLSDNqeDEMgh07cFO0uoqGxZZwykZ0esu8QUA3Uwwmwcuar9hCiBsh+Qf3
	 uEqiY9cx+9S1w==
Date: Mon, 3 Aug 2026 16:02:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH 5/5] perf arm-spe: Reject zero nr_cpu in metadata to
 prevent division by zero
Message-ID: <anDlvtOEBK4QRS9P@x1>
References: <20260727161705.64807-1-acme@kernel.org>
 <20260727161705.64807-6-acme@kernel.org>
 <df7bf01f-b0f6-403c-8415-305f3ea63fdb@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df7bf01f-b0f6-403c-8415-305f3ea63fdb@intel.com>

On Mon, Aug 03, 2026 at 09:46:49PM +0300, Adrian Hunter wrote:
> On 27/07/2026 19:17, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > arm_spe__alloc_metadata() reads nr_cpu from the auxtrace_info priv
> > array without validation.  When a crafted perf.data provides nr_cpu=0,
> > the per_cpu_sz calculation divides by zero:
> > 
> >   per_cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
> > 
> > Reject nr_cpu <= 0 early, before the division.  The caller already
> > treats NULL return with metadata_ver != 1 as a parse failure.
> > 
> > Fixes: e52abceb4b6c2723 ("perf arm-spe: Dump metadata with version 2")
> 
> git blame shows 7842a4b6ff698 "perf arm-spe: Support metadata version 2"
> for the relevant lines

That is right, Namhyung, can you please fix this Fixme tag while merging?

Thanks!

- Arnaldo
 
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Cc: Leo Yan <leo.yan@arm.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Assisted-by: Claude:claude-opus-4.6
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/arm-spe.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 552f063f126e6769..401aab529309cbd6 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -1605,6 +1605,10 @@ static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
> >  	hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
> >  	*nr_cpu = ptr[ARM_SPE_CPUS_NUM];
> >  
> > +	/* nr_cpu is used as a divisor below */
> > +	if (*nr_cpu <= 0)
> > +		return NULL;
> > +
> >  	metadata = calloc(*nr_cpu, sizeof(*metadata));
> >  	if (!metadata)
> >  		return NULL;
