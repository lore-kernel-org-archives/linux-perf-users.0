Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB969224D4;
	Mon,  9 Dec 2024 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760276; cv=none; b=XIyQC3SgMRq9QqfeWQA+8nwC5hgGlOLIuMMEGnCEKZ4/U20TKl+LY4esMwnyS0lVGLtH23gVTqIc9zrZfaQm4xtTR6NeeWV8Rb398TVFahkUmz7eqQXPHlLtZpI8s4OZzFS4q3qloi/JC1CDzlyKIr624NTqXb08OvvHcOjt9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760276; c=relaxed/simple;
	bh=jHJ+Lmy6qdaeBxGdsocZiv6T41J2pFCMPlAHb+BuWjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXWlCvVXtD7//QOlsvIYVRYc1Bpp0vk7C5Y4yRXxOWw4EZn8CgqqcUjdkaSKTye/NwzyQc4SRV71tELi+datA5qagO4VmkAUWs4FaM2//a6oC44MNbxcPXxr0ZpWC7i+10Mb1p5gWiEWucvDjegifHKe1trG80OxJUMJyodZWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb6X/01V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb6X/01V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD359C4CED1;
	Mon,  9 Dec 2024 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733760276;
	bh=jHJ+Lmy6qdaeBxGdsocZiv6T41J2pFCMPlAHb+BuWjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tb6X/01Vq4zkCnxcLyHCgXgsq0TpLTO/4LqdLElYb3RAbTFqRRapoQ+5aWXKtgU76
	 MQh7w50NXyKuIn/V7V1qzvG63on+46Qswowpi2ZvGiADKqe0OYujebXYRj7e9MzEVq
	 XAgrGma4qrcJOLwKRAJQA5npkG09558TanzyrGv+QBAv1wwvG3ZHxzYyiF6w0djllk
	 atxECd2jA0XPKsxeYuZYo9AAbs85CmAzLnaFxLsvGtdFh2gTHlMZiYKVkdmehbScXT
	 FaStkduyZ2s0ciMc5oQlwNXbSxvQcnsIvPWIbdqu7PRoC8FIKQ+Kyi7lTs4gr9YeI5
	 Dm6cpwrNRnmYw==
Date: Mon, 9 Dec 2024 13:04:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/8] Cpumap improvements for large MAX_NR_CPUS
Message-ID: <Z1cVETw2Tk1FzTVC@x1>
References: <20241206044035.1062032-1-irogers@google.com>
 <20241206230358.GB5430@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206230358.GB5430@e132581.arm.com>

On Fri, Dec 06, 2024 at 11:03:58PM +0000, Leo Yan wrote:
> On Thu, Dec 05, 2024 at 08:40:27PM -0800, Ian Rogers wrote:
> > 
> > Prompted by Kyle Meyer's <kyle.meyer@hpe.com> report of the
> > MAX_NR_CPUS value being too small, initiate some clean up of its
> > use. Kyle's patch is at the head of the series. The additional patches
> > hide MAX_NR_CPUS as exposed from cpumap.h, reduce its use by removing
> > perf_cpu_map__read, and try to better size the temporary CPU array in
> > perf_cpu_map__new.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks, applied to perf-tools-next,

- Arnaldo
