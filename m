Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7104C85;
	Mon,  2 Dec 2024 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733175963; cv=none; b=KswM9cpRAVExWmLJuAqrp5iBLftWac2POmL96pjw0Ov/IBjGKXB6/Qud9SvlM1biMBqQFBZM/ABeDlShq+kX7pwmKTDoLcjxJecGE+XSsTYPE7M55h5B/RZgMuw/e/i0XRRKCKZwx9p/x4VFDF+/Vh5GlwMrXwTNIbNajnMBDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733175963; c=relaxed/simple;
	bh=8Q6ANYSxDAHATAOCzAvprE5Rt+lzIaYf8FcBmFRnvX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cK2g2O+SYsQw6Ke9PBNVHK9fVufx0IyYZTuIW5Rzj/hdfhZJoXB+kBhaXhko52E6mbppKGjbYrQqmnjIuStNWkf+LbNFkU4MvceDWI6T3lmEVO8jI/WiD5f3cGM1E8DA4Si4CW6LqIAO3TMUE7ZHye68L5mPK5DwgGoX/LRQENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9W/QsDb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9W/QsDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4652CC4CED1;
	Mon,  2 Dec 2024 21:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733175962;
	bh=8Q6ANYSxDAHATAOCzAvprE5Rt+lzIaYf8FcBmFRnvX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W9W/QsDb1Sux3YFFTUJ7fL7y0wtvuMWrruwZ/hUIVdiRz9rSABimNxGqJaeb1nNhc
	 aHlaXPoz4vJRy8SNLz9afj5jhJDKLGZHXA/A3uwjSMWz0XEkslXuEcIFJhNB4F+dcB
	 larF8bakhJKsOK7RA8orhv05NwfPjzPB6GVHgG4PrCGFhVIcB1KRdRy8MKZv5g1E1e
	 EOQjU0dxWncUVdVSmufK1laH0RE0haRw8qUL7uqQQ0F0gtwiYXZAIExZQMRZhvI7+W
	 sNK/XAZNp7pP0as4/6OYfEN7NoHz87QPDUPnFun4Jd/tHwEtBYPHY/I3Jzj3xl1SS2
	 AyaldKvaB2rPg==
Date: Mon, 2 Dec 2024 13:46:00 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Yang Jihong <yangjihong@bytedance.com>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 00/12] perf record: Add event action support
Message-ID: <Z04qmNnt86zcGE5Q@google.com>
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <Z0jPPRA8JXSrwyaC@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0jPPRA8JXSrwyaC@x1>

Hello,

On Thu, Nov 28, 2024 at 05:14:53PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 28, 2024 at 09:35:41PM +0800, Yang Jihong wrote:
> > In perf-record, when an event is triggered, default behavior is to
> > save sample data to perf.data. Sometimes, we may just want to do
> > some lightweight actions, such as printing a log.
> 
> > Based on this requirement, add the --action option to the event to
> > specify the behavior when the event occurs.
> 
> 'perf record' is centered on saving data to disk without processing
> events, while it has sideband events for some needs, like processing BPF
> related events (PERF_RECORD_BPF_EVENT to catch PERF_BPF_EVENT_PROG_LOAD
> and UNLOAD), doing things in a "live" way as your patchkit does seems
> more appropriate to do in 'perf trace' :-)

Agreed, 'perf trace' looks like a better place as you seem to target
tracepoint events mostly.

Thanks,
Namhyung

