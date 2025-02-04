Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE439204C21;
	Tue,  4 Feb 2025 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738652757; cv=none; b=nmHbJiGEGjDA7Om37OO1c9VVJYqp78Yf/FDCOuSa/XdaOIgWftEOUtC1aQZzU/isonK20AB1aQkH/SLPdV0OtVXHRfdRpxtmPSC9AmnBZWS6TfSs30VHf5tOUZ3dMM8Es35hCRY5DSXQUQtdDHatDDLa0y4KR2utIrSmwTkkuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738652757; c=relaxed/simple;
	bh=v/YFn9jnZa80+VKWhInBj0Gi9tpI7ShJHQCHuCpmKP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psPHz6DPNKnd8FMAbPNbUkQPfwxBDfXjGeQKvY6JW7BBspbv2DfoLKE5NKLiZF6ZAy/DyTxoD3R6RrdwhPnK7zDxKbNspciovESLKODznI8Ie8tNV2ZH/ZhwmjYHou2UlnkRKiKijF2/MVlykxcYpjYqhwBeGZHAzmL9wGgT7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O3bISx6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O3bISx6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C5CC4CEDF;
	Tue,  4 Feb 2025 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738652757;
	bh=v/YFn9jnZa80+VKWhInBj0Gi9tpI7ShJHQCHuCpmKP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3bISx6+Yz+NPKiHfJOevA4JoPTQy2/+eFZW+D349PuND9AJaGFpiGBroXQoIofB7
	 uudixio73GEab1sPfabELTZU19Kp0UoJZdwb6V7xN9j/IZeG58p53wK83nj/VYAjSl
	 G7AQJ4rT5ptE2E6evpECKficsZl+Z9gjdWkGxGtU=
Date: Tue, 4 Feb 2025 08:05:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
Message-ID: <2025020444-chivalry-wanting-7f0c@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <CAP-5=fXwprvLc3ubPmAuyUaTL2aD1frqL+RHJzkp8oe5z85oRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXwprvLc3ubPmAuyUaTL2aD1frqL+RHJzkp8oe5z85oRw@mail.gmail.com>

On Mon, Feb 03, 2025 at 11:44:13AM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 11:25 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > In sysfs, for some reason, all pmu devices seem to show up in the "root"
> > of /sys/devices/ making for a confusing mess as these devices are not
> > really at the root of the system at all.
> >
> > Create a fake root devices, "pmu_bus" and place them all under there if
> > they do not already have a parent device set, cleaning up sysfs to look
> > more sane.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: "Liang, Kan" <kan.liang@linux.intel.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >
> > Note, if you all don't like "pmu_bus" for the name, that's fine, please
> > let me know and I can rename it to something else, but it should be
> > something to get these objects out of the root sysfs directory.
> 
> Excuse my ignorance, does the event_source bus already provide a
> similar solution?
> ```
> $ ls /sys/bus/event_source/devices
> breakpoint   i915       msr         uncore_arb     uncore_cbox_3
> uncore_cbox_7              uprobe
> cpu          intel_bts  power       uncore_cbox_0  uncore_cbox_4  uncore_clock
> cstate_core  intel_pt   software    uncore_cbox_1  uncore_cbox_5
> uncore_imc_free_running_0
> cstate_pkg   kprobe     tracepoint  uncore_cbox_2  uncore_cbox_6
> uncore_imc_free_running_1
> $ ls /sys/devices
> breakpoint   intel_pt     platform    uncore_arb     uncore_cbox_5
>          uprobe
> cpu          isa          pnp0        uncore_cbox_0  uncore_cbox_6
>          virtual
> cstate_core  kprobe       power       uncore_cbox_1  uncore_cbox_7
> cstate_pkg   LNXSYSTM:00  software    uncore_cbox_2  uncore_clock
> i915         msr          system      uncore_cbox_3  uncore_imc_free_running_0
> intel_bts    pci0000:00   tracepoint  uncore_cbox_4  uncore_imc_free_running_1
> ```

Those are the exact same device structures :)

Look at /sys/bus/event_source/devices/ those are symlinks back to
/sys/devices.  In other words, that's the exact same structures, and
the mess in /sys/devices/ with these event devices is what I am trying
to clean up.

thanks,

greg k-h
