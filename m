Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E264B4F5E0;
	Thu,  6 Feb 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852036; cv=none; b=Y4OM/Hcs7fPjEjSOLgF3Bpl7jLH/CJxyK2fWhViQx3LNE33n5vzIRJ+vvI4iu3GwSo9QNrd50/yPjv4IjZO3D/nR1yB29RU53h4IinudZSsC3HY7jQTGlyAJy06Mqpn+OiU7mmQaH6in8xfUYQ3exbwxlhuIFUMMTW+Mq9avvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852036; c=relaxed/simple;
	bh=3tAWcnKNqDoBbrghD8bFuVei6JTnTZIxA7LitV8jDSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejva7Nso78yuSgs/2BS3DTmKHgPkJ9CxUiXaY7gniuE5bfh6d6ajwomiycYkLgpxXIVNyaYIe/AMOlowNgVH+SdhG3UJfS6MrN5AZcSyTd9Wd0fHdkkO8H4+2+Mu9rk6MhoUl0bZffpYeL4zPbEzx2s19B6kWqnpRymxUTO1OyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bkiKAwKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bkiKAwKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77F5C4CEDD;
	Thu,  6 Feb 2025 14:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738852035;
	bh=3tAWcnKNqDoBbrghD8bFuVei6JTnTZIxA7LitV8jDSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkiKAwKcGBNkb4hFno2C+qPBVfdLZiJKE1hWM8FsawRhtjRwiei04dyGsxqE1S7KH
	 cdyr0oSE3zLh/ZKPjoPii+9JLrjzGF/bQqmMlt7PhFEcnHBKitT6TFSig8y1bTRUvF
	 28/EF32FjQF3PwczmN6hfiJRBB4BYriDj4G5PAAY=
Date: Wed, 5 Feb 2025 19:45:07 +0100
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
Message-ID: <2025020544-shakily-flattered-93b7@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <CAP-5=fXwprvLc3ubPmAuyUaTL2aD1frqL+RHJzkp8oe5z85oRw@mail.gmail.com>
 <2025020444-chivalry-wanting-7f0c@gregkh>
 <CAP-5=fUk3DB4orma=vM=+cKrztsRqHVhvvPk+py+G+9w9sOdqg@mail.gmail.com>
 <2025020507-anteater-icy-44ab@gregkh>
 <CAP-5=fUCDA1YLDrMgMpr=o4ESFey1b51+DfBwCF+cG7+-yidwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUCDA1YLDrMgMpr=o4ESFey1b51+DfBwCF+cG7+-yidwg@mail.gmail.com>

On Wed, Feb 05, 2025 at 08:48:21AM -0800, Ian Rogers wrote:
> On Tue, Feb 4, 2025 at 9:41 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 04, 2025 at 10:17:17AM -0800, Ian Rogers wrote:
> > > On Mon, Feb 3, 2025 at 11:05 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Feb 03, 2025 at 11:44:13AM -0800, Ian Rogers wrote:
> > > > > On Mon, Feb 3, 2025 at 11:25 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > [snip]
> > > > > > Note, if you all don't like "pmu_bus" for the name, that's fine, please
> > > > > > let me know and I can rename it to something else, but it should be
> > > > > > something to get these objects out of the root sysfs directory.
> > > > >
> > > > > Excuse my ignorance, does the event_source bus already provide a
> > > > > similar solution?
> > > > > ```
> > > > > $ ls /sys/bus/event_source/devices
> > > > > breakpoint   i915       msr         uncore_arb     uncore_cbox_3
> > > > > uncore_cbox_7              uprobe
> > > > > cpu          intel_bts  power       uncore_cbox_0  uncore_cbox_4  uncore_clock
> > > > > cstate_core  intel_pt   software    uncore_cbox_1  uncore_cbox_5
> > > > > uncore_imc_free_running_0
> > > > > cstate_pkg   kprobe     tracepoint  uncore_cbox_2  uncore_cbox_6
> > > > > uncore_imc_free_running_1
> > > > > $ ls /sys/devices
> > > > > breakpoint   intel_pt     platform    uncore_arb     uncore_cbox_5
> > > > >          uprobe
> > > > > cpu          isa          pnp0        uncore_cbox_0  uncore_cbox_6
> > > > >          virtual
> > > > > cstate_core  kprobe       power       uncore_cbox_1  uncore_cbox_7
> > > > > cstate_pkg   LNXSYSTM:00  software    uncore_cbox_2  uncore_clock
> > > > > i915         msr          system      uncore_cbox_3  uncore_imc_free_running_0
> > > > > intel_bts    pci0000:00   tracepoint  uncore_cbox_4  uncore_imc_free_running_1
> > > > > ```
> > > >
> > > > Those are the exact same device structures :)
> > > >
> > > > Look at /sys/bus/event_source/devices/ those are symlinks back to
> > > > /sys/devices.  In other words, that's the exact same structures, and
> > > > the mess in /sys/devices/ with these event devices is what I am trying
> > > > to clean up.
> > >
> > > Thanks! Again my ignorance, why do we need pmu_bus?
> >
> > You need some sort of "bus" to group all of your devices on.  It could
> > also be a class, your call.  This is how the driver model in the kernel
> > works.
> 
> Sure, I wasn't clear how this mapped out in sysfs.
> 
> > > Could the symlinks in event_source be the actual devices?
> >
> > That's not how the driver model works.
> 
> Ok, so I guess that's what's confusing me. Where will the new devices
> be in sysfs? If it is /sys/bus/pmu_bus then why is
> /sys/bus/event_source a different case? I guess I should read docs and
> the source :-)

Look at what is in /sys/bus/event_source/devices/ today.  That's a bunch
of symlinks to where in /sys/devices/ the devices are located.

I just moved all of the pmu bus devices under /sys/devices/pmu_bus/
instead of them showing up in the root at /sys/devices/ as that's not
where a bus should be placing individual devices like this.

thanks,

greg k-h
