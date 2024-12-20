Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0259222594;
	Fri, 20 Dec 2024 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723725; cv=none; b=YaFPcBW/B+G50bIWkxynR4rXbHPP4lOAlHvXgfgn+E/YRp5wSE14gwdqLgc+bbFihmRqcKK3AhheysbAndXoV/+VvgkB9ihW8btdv/GKgTq3Va3dEFYk98ABcGB9TkQ/PUVCjPk+k9MGc+lZZyYEP+Vw84xve39RKjEeQh5b7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723725; c=relaxed/simple;
	bh=Pu6jjQKtTSjApmbuZTSmOj7e9RuHb1Dp9oD9rdWQzLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu3gn/1bmlKl43qSrLH+Cv/TSLEju7WAZrti2uiV3DqHMiO6AiiJwjQHmZ8piombbR2ewqwoDFN0J6hd6ESULlMaRcAGzVkiaQy7ZHHBE6CV9uqyl4NKHkVcr2/Tl6TFDSQh+ayoe5jcl5K62ZOuA1uijSM+vrLIzUWXBLNWoYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kakiW+RA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kakiW+RA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4F0C4CED6;
	Fri, 20 Dec 2024 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734723725;
	bh=Pu6jjQKtTSjApmbuZTSmOj7e9RuHb1Dp9oD9rdWQzLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kakiW+RAO6DhS5rD9nbrqeJj7uEYukiEeHIKtax8rlVEj3dlWnlZF3ib3AaixCsyG
	 YJ0FYlUc8xfJxpAcwWX356qiuh/wDefheTvT7srCa0jsrzdPY8d/Rmhg2xjBOihNIe
	 +HHMl6L8XXCn8rtg95CDX3/hQ12u6bnG34Y+sWqb0o5rtYON+SoQdllcNHwYicnwQM
	 89wedKGQOeGQo7ebiyV7zwx/KWf6MOSLSuOlz1YeZOVhY9mMvfciMPlI20jJGbBWNT
	 NiSEsnjpcnjQtB1COgrzKEgbcVxZ2FCyHusdgF8Z4yalZSVrQUZT0dmSlrxAOtOYoh
	 A/M3OcFWTKPJw==
Date: Fri, 20 Dec 2024 16:42:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tuan Phan <tuanphan@os.amperecomputing.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Bhaskara Budiredla <bbudiredla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH v2] perf Documentation: Describe the PMU naming
 convention
Message-ID: <Z2XIitYfFaZJltul@x1>
References: <20240606044959.335715-1-irogers@google.com>
 <c7d6eedb-7c5e-4411-a83f-4328dc75ec46@linux.intel.com>
 <CAP-5=fXY2Ofr_GRc7Mq7BfoR+2150o8e1JeyGctcGPRG70DqPg@mail.gmail.com>
 <060b220d-f7d6-4594-9b2b-e878a2ba98c6@arm.com>
 <CAP-5=fU+pigNLi+cTFwEmyG5tO+JHTGDgWh1sYbCiX5TppdLnQ@mail.gmail.com>
 <CAP-5=fVBsCxHbqQkEbG2zzATDYfN8bP6mN9ixkae7o9eNB5w+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVBsCxHbqQkEbG2zzATDYfN8bP6mN9ixkae7o9eNB5w+Q@mail.gmail.com>

On Fri, Dec 20, 2024 at 11:16:46AM -0800, Ian Rogers wrote:
> On Wed, Oct 23, 2024 at 9:21 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Oct 23, 2024 at 2:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 2024-10-23 5:06 am, Ian Rogers wrote:
> > > > On Thu, Jun 6, 2024 at 11:15 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 2024-06-06 12:49 a.m., Ian Rogers wrote:
> > > >>> It is an existing convention to use suffixes with PMU names. Try to
> > > >>> capture that convention so that future PMU devices may adhere to it.
> > > >>>
> > > >>> The name of the file and date within the file try to follow existing
> > > >>> conventions, particularly sysfs-bus-event_source-devices-events.
> > > >>>
> > > >>> Signed-off-by: Ian Rogers <irogers@google.com>
> > > >>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> > > >>> ---
> > > >>>   .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
> > > >>>   1 file changed, 24 insertions(+)
> > > >>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices
> > > >>>
> > > >>
> > > >> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > >
> > > > Thanks for all the reviews. Could we land this?
> > >
> > > Hmm, it's not always going to be strictly true as written though - we
> > > will also have cases where multiple PMU instances owned by the same
> > > driver don't all support the same events/filters/etc., and/or are
> > > entirely unrelated such that the same event encoding may mean completely
> > > different things. I've just landed a driver where not only are the
> > > instances going to be heterogeneous (since it's for arbitrary bits of
> > > interconnect), but for hierarchy reasons the most logical place to put
> > > the instance ID in the name wasn't even at the end :(
> >
> > Right, I was trying to capture what the tool is doing and trying to
> > encompass the problems hex suffix create. Another example of that
> > problem recently burning us is ARM's PMU naming of armv8_pmuv3_a53
> > means the a53 looks like a hex suffix. When ARM release a model with a
> > 3 digit number will the naming break? Wrt filters, I wonder if there
> > should be testing, bugs, etc. The wildcard matching will likely do its
> > thing and I think the failures should be predictable and descriptive,
> > like an event used a format that a PMU doesn't support, but I'm not
> > sure if we should do improvements in `perf list` where we try to
> > deduplicate PMUs. Perhaps the deduplication should be smarter.
> >
> >
> > > FWIW I think if we want to nail down a strict ABI, it would seem more
> > > robust to have an explicit attribute to describe underlying PMU
> > > properties like whether instances do represent identical "slices" or
> > > not. The hex suffix thing is already proving how fragile names alone are
> > > liable to be.
> >
> > Agreed. Does this mean we shouldn't land this? I worry that LKML is
> > the home of bike shedding conversations and we're likely to bike shed
> > trying to achieve 'perfect' while something 'good' would have value
> > today.
> 
> Ping.

Thanks, applied to perf-tools-next,

- Arnaldo
