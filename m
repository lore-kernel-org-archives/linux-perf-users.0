Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C02E7BDF;
	Fri, 18 Jul 2025 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861375; cv=none; b=k+qytx2KoiLud+gannpEJ5xiFMxJqBG8ym7jukQ7pz+Xog9lllUb2ssOPcbKfA5GDNRi/+0yhjTWf59D2gvqj7S5DWY0ydWJzPrlbSYfSZM0OH+gtF0EAwM/NwowzE0FPZeAe9QXnEeblBgpUMg9kkICFV03J+qLfwpI/EzYLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861375; c=relaxed/simple;
	bh=SIhuYAbebjIRlKdk0fXIb0gSs/RnIfG2FTSjuQACq9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJOY3R97+Zwiarzsr2e+ySJXr8udPYuGaZbrnCiDFmwKxrz9AzHl4+P71aYXVkJo4WhyCQaz548m/UdkIaqKd6WZyDQwNMSOfD/2oYjxYYZW0dxelBxqeicRWftJJR2cnWiHVVAJpL4aemC0BnBHhFplCiF+gs+3Nqs+OABTDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAxoaibF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAxoaibF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67ACFC4CEEB;
	Fri, 18 Jul 2025 17:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752861374;
	bh=SIhuYAbebjIRlKdk0fXIb0gSs/RnIfG2FTSjuQACq9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAxoaibF6tAT6iz+jMvoDgKa6KdBcWA8OcyANDjTJv7ZcyBJ6T4/7TUHPdSAgqS5k
	 LUUjNOFdy2eC93njSITMPgRmsN+qQ0dYZZqTe8eKkCZ2K6YaBsEPTpB7iaMPf3wJx7
	 rL9MC27n17/qPTtmW8mpYVAvrrCA/Rh3oL0QCNmuuri81bsqjNIOFgO0lNuVU4ZGiV
	 zqynZ4X4gw+eS2rFHvUdYdUtz/TSYE/9ZvVjPTTR8UNvCouJfH2ZWVrJnrly9DsvgD
	 mshNDh8VMqjrQqsQin3qKE25Eve7sE7IKeIuPTYpSkjmGlr+PYp57+2poJS+wKuoyL
	 MDMcGs63hpOYQ==
Date: Fri, 18 Jul 2025 10:56:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Blake Jones <blakejones@google.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/12] perf parse-events: Allow the cpu term to be a
 PMU
Message-ID: <aHqKvOfY2QQOEcjB@google.com>
References: <20250627192417.1157736-1-irogers@google.com>
 <20250627192417.1157736-5-irogers@google.com>
 <aHgG-9iuoj4B72SU@google.com>
 <CAP-5=fVt4Nu3ZtKD+DWn9iT1XRzbbzvE3WXaO51V+8UGCE56cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVt4Nu3ZtKD+DWn9iT1XRzbbzvE3WXaO51V+8UGCE56cg@mail.gmail.com>

Hi Ian,

On Wed, Jul 16, 2025 at 01:25:17PM -0700, Ian Rogers wrote:
> On Wed, Jul 16, 2025 at 1:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Jun 27, 2025 at 12:24:09PM -0700, Ian Rogers wrote:
> > > On hybrid systems, events like msr/tsc/ will aggregate counts across
> > > all CPUs. Often metrics only want a value like msr/tsc/ for the cores
> > > on which the metric is being computed. Listing each CPU with terms
> > > cpu=0,cpu=1.. is laborious and would need to be encoded for all
> > > variations of a CPU model.
> > >
> > > Allow the cpumask from a PMU to be an argument to the cpu term. For
> > > example in the following the cpumask of the cstate_pkg PMU selects the
> > > CPUs to count msr/tsc/ counter upon:
> > > ```
> > > $ cat /sys/bus/event_source/devices/cstate_pkg/cpumask
> > > 0
> > > $ perf stat -A -e 'msr/tsc,cpu=cstate_pkg/' -a sleep 0.1
> >
> > It can be confusing if 'cpu' takes a number or a PMU name.  What about
> > adding a new term (maybe 'cpu_from') to handle this case?
> 
> So it is possible for terms to be defined in sysfs in the 'format/' folder:
> ```
> $ ls /sys/bus/event_source/devices/cpu_core/format/
> cmask  edge  event  frontend  inv  ldlat  offcore_rsp  pc  umask
> ```
> By not introducing a new term we leave 'cpu_from' open for use in this
> way. When I spoke to Kan we thought using the existing term made sense
> and fits the idea of leaving things open for the kernel/drivers to
> use. It is possible to add a new term though. Let me know and I can
> update the patch and documentation accordingly.

Oh, you thought about this already.  It's true that it's possible to
clash with PMU formats in sysfs unless we have a separate namespace for
tools somehow.  But that would add (maybe unnecessary) complexity.

So I'm not against with this change.  I just wanted to ring an alarm for
potential issues.  Up to you. :)

Thanks,
Namhyung
