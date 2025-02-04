Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A421420C;
	Tue,  4 Feb 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682545; cv=none; b=HCCcqHXX1Y9wrfraoNJMmdGqzE9lQKEYABqBxG5xKVjoFMoUAPcTV4CWSGvJsQgABDOJJfmyA2zFa4mIGZT4U5kv5eFqPdBVnDPvM3g6YwYTpQcKviS26HK81wqW5AQwDnxnYq00zb6aA2hNJczc1u25JOyFodGiB3FbCEftSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682545; c=relaxed/simple;
	bh=PsrudWJRDvkQscYsRSOQPApkvQux7j85WLmbCr7uriI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K37qo2ZgC9rCDRMvjK0liHoxHhdJhsQOrojPcScNV5XXYYQBk02Z5pH3fzFLIBCZu48oOp/PAydquA6GOGKSfvTLClWsSPZBdPeKYGhjVBA84LrflMFNcHIBEekN7fb1Sy3QgNP2QJQyUa1BcbjsKHoXiOiEGP8bGim11iiat74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1JZvdHZt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1JZvdHZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EE4C4CEDF;
	Tue,  4 Feb 2025 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738682545;
	bh=PsrudWJRDvkQscYsRSOQPApkvQux7j85WLmbCr7uriI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1JZvdHZtT+1ani1o7soRkMc9lTeAb5Q2bKCXD3W1d5DNvVq/vdnO+wgufbQWtDYbN
	 WloBuzwMfM59aGdFibjiVXikai75hcc6rFCycW8L1dpxciEcQzu19yWM8zCUgAUZsh
	 KGUxtsQS1NVWGR3GyxBoVL99ZtYWmG+IwIrj4ZNY=
Date: Tue, 4 Feb 2025 16:21:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
Message-ID: <2025020455-engulf-snowbird-b08d@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <87pljyyx68.fsf@ubik.fi.intel.com>
 <2025020426-spool-refreeze-2870@gregkh>
 <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>

On Tue, Feb 04, 2025 at 09:06:18AM -0500, Liang, Kan wrote:
> 
> 
> On 2025-02-04 5:16 a.m., Greg Kroah-Hartman wrote:
> > On Tue, Feb 04, 2025 at 09:41:03AM +0200, Alexander Shishkin wrote:
> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >>
> >>> In sysfs, for some reason, all pmu devices seem to show up in the "root"
> >>> of /sys/devices/ making for a confusing mess as these devices are not
> >>> really at the root of the system at all.
> >>>
> >>> Create a fake root devices, "pmu_bus" and place them all under there if
> >>> they do not already have a parent device set, cleaning up sysfs to look
> >>> more sane.
> >>
> >> Yeah, so what happens to the userspace that uses them via /sys/devices/*
> >> directly? Even I have scripts that do that.
> > 
> > You should never be doing that, as you have no idea what type of devices
> > are in that location in the tree.  You should be doing what the
> > documentation says to do, and look in /sys/bus/event_source/devices/
> > instead.  That didn't change here.
> >
> 
> Not just the script, the /sys/devices/ is also used in the current perf
> tool. For example,
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/mem-events.c#n192

Ugh, it's ignoring the documentation that perf provides for how to find
these devices.  And it's really really risky to do that, you are
"assuming" that a subdir called "events" is never in any other type of
device.

I'll submit a patch to fix that.

> And the comments and document in the perf tool.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/pmu.c#n39
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-list.txt#n191

I'll fix that document and the tools as well.

> I think it should bring big impact for the end user, especially when
> they still use an older perf tool and script.

perf is tied to the kernel tree, so we should be ok here.  We can also
take the perf tool fix for all stable kernels as it will be backwards
compatible.

The idea that somehow "events" are better than any other type of device
in the system and belong all individually in the root of the device tree
is a long-standing bug that should be fixed.

thanks,

greg k-h
