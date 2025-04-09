Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6B1E5B8A
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744233979; cv=none; b=anhW/3M24zqokYoF5GId0mHtRmY1R0gw9VZKMy4NEKQ/Eiif6WrFG+YlW2X1YjjJTBp1Il4EJflPHMh7zN6XJrNG39HAf0X5BYA8ZIDuh0AvXVaLRsy3icBka3Jq7OCFOzF5Iapaj9Ad+cIaw9rm5yfxGuQUjESAzPCiQf8eJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744233979; c=relaxed/simple;
	bh=/kC9I28nS9NYQDJ4fzpMUS4puGcI6hizqgHRv3uj2dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPwQLMeo/2UBaFm8YrYzGpFv3+G0Fh8LzS/Ur3Ddyz8LmiWP3lOa3XWBn8IL/tD0j4kIyDTfBVme7Oaex1je597ha4Cj+Pe8h6P+u90OQ50NglXf69TD12g9Eogo1XfBAxiRE3u7FfwkMRcBcU8YK7LVRjPGLvw9wO1ecRM01sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3dYwSy2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3dYwSy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379FEC4CEE2;
	Wed,  9 Apr 2025 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744233975;
	bh=/kC9I28nS9NYQDJ4fzpMUS4puGcI6hizqgHRv3uj2dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3dYwSy2Jw9RQ8cZ8czrJni/LInL/ngujVnH2HX0ik+gn0zWrkWSW0EvOlss9I8tf
	 UVzmNk23vVdLnUxYZue37iB6R6WJ+qc9EQ/wgEMKrxCO5k/xQclRcN1RFrKdmoyC+9
	 xpWs2vO/yzLHqzQI4vy0eO7T9n3fuQ8CLs9anESerEWgjPqGCjQRvmaJTMms87EeOF
	 DMH8+6kD8jy+3wcKfapGop//hZRAkKVKHVWo4LJD6F7SPx3Ua8LavEprW08DX99//3
	 t2hqoy05jEDrnwy+FiCGvsFvYB7kTcdX+4d8sL6HR1T/aIxsT5AgURPjFRNGF33r7z
	 Wxq42xvXL2hzA==
Date: Wed, 9 Apr 2025 23:26:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_bl8tabAwfqKuy-@gmail.com>
References: <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_TYux5fUg2pW-pF@gmail.com>
 <Z_XaOp4TCBKe-M0o@x1>
 <Z_ZltdaHx9XuKcd9@x1>
 <Z_aY0fTs53id77CS@x1>
 <Z_bHtD7umCsKeWJ6@x1>
 <Z_bI7wK8mJYVOWDH@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_bI7wK8mJYVOWDH@x1>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> On Wed, Apr 09, 2025 at 04:17:11PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Apr 09, 2025 at 12:57:05PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Apr 09, 2025 at 09:19:01AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Tue, Apr 08, 2025 at 11:23:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Tue, Apr 08, 2025 at 10:05:15AM +0200, Ingo Molnar wrote:
> > > > > >      - Yay! But very unintuitive. The intuitive step would have been 
> > > > > >        the left arrow key BTW. (with restoring the cursor position to 
> > > > > >        the cc1 entry I pressed 'Enter' on originally), but that doesn't 
> > > >  
> > > > > That is how I implemented it initially, yes, over 10 years ago.
> > > > 
> > > > I'll experiment with making the Left arrow key, if already on the first
> > > > column, to work as zoom out.
> > > 
> > > Can you try this, on top of the series or even just this, pressing left
> > > should do what we want.
> > 
> > This is working for zooming into/out of a DSO, but for threads, which is
> > what you described, it is not working, checking that...
> 
> Using 't' to zoom into a thread and then LEFT to zoom out works, ditto
> for 'd' + LEFT, 'k' (zoom into the kernel) + LEFT its just 'm' + thread
> or ENTER + Zoom into Thread that isn't working...
> 
> Not even that, there is something subtle, investigating.
> 
> But as a suggestion, pressing 't' zooms into a thread, pressing it again
> zooms out of that thread, rinse repeat.

Indeed, this works it around. It's not *that* easy though: 't' goes 
into thread view, but has to be pressed another 3(?) times to get back 
to the previous non-threaded view again.

> 
> Ditto for 'd' for DSO and 'k' for the kernel DSO, 'S' for a CPU socket
> (Kan Liang implemented this, but not for 'c' CPU, will try to add that).
> 
> Anyway, back to the bug.

Thanks for having a look! :)

	Ingo
