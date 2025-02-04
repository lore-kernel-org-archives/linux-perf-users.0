Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009C204F63;
	Tue,  4 Feb 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664168; cv=none; b=pYtke4fURn2ZHFv3lgqLXx0Zphvk7NIRdOFVE9KRJVu4t4p6b1qMbdIV8SHp1Uz+PuXUV/ZH1+yUNuSGxOgqCMq9lasy1q5aHfuMIOzT+MLj5L6NW02Fe967S0Osa58+iuc2NPVtzZ82vULE4c4hdBs4GHIRWOuxpfm5McCDdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664168; c=relaxed/simple;
	bh=Qm7PjpPj+G2g67wqSuKSvfDGW1ktJADyC9sylJSFMCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd1TNHpLaNMII8dujC3xKUihaxzKbM6EpbKmRfEq8xMkKWF2ooxCcsbJFZ4JljzYees3zzNLIoaNgpSM+MDFpppWVAqHRciac4EJyEAk9CfvxjoAGM8UbFcH8cC2lbOj5KB7KcgO5JFxD1y62/podrqGrfPyEZnc/9xRbnbQUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dLaOYmrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dLaOYmrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30674C4CEDF;
	Tue,  4 Feb 2025 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738664167;
	bh=Qm7PjpPj+G2g67wqSuKSvfDGW1ktJADyC9sylJSFMCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLaOYmrELHR21XlqylH0qiuxVi/XuhVUJB+VWNUPIS4PA4dsOfpMBbccLc1veTd2D
	 kQUnBQrwP+O4x2VU0XJmINqCW6D/STtqeMtlrGH4zVbFW8YQ3nXTGMoau50PAmdvij
	 +CpKh2vuDNMn4Q/M3r/izZNopuhUMAsmhv8fPZ5Y=
Date: Tue, 4 Feb 2025 11:16:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
Message-ID: <2025020426-spool-refreeze-2870@gregkh>
References: <2025020304-chip-trench-4e56@gregkh>
 <87pljyyx68.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pljyyx68.fsf@ubik.fi.intel.com>

On Tue, Feb 04, 2025 at 09:41:03AM +0200, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > In sysfs, for some reason, all pmu devices seem to show up in the "root"
> > of /sys/devices/ making for a confusing mess as these devices are not
> > really at the root of the system at all.
> >
> > Create a fake root devices, "pmu_bus" and place them all under there if
> > they do not already have a parent device set, cleaning up sysfs to look
> > more sane.
> 
> Yeah, so what happens to the userspace that uses them via /sys/devices/*
> directly? Even I have scripts that do that.

You should never be doing that, as you have no idea what type of devices
are in that location in the tree.  You should be doing what the
documentation says to do, and look in /sys/bus/event_source/devices/
instead.  That didn't change here.

Again, system topology can, and will, change all the time in
/sys/devices/ so expect that.  The only "stable" locations are the
symlinks in the /sys/bus/ and /sys/class/ locations, which is why those
symlinks are present.

Been that way for over a decade now :)

thanks,

greg k-h
