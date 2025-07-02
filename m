Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645562D374D;
	Wed,  2 Jul 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475819; cv=none; b=noZNhBaSc/BUqIAmS0N1t4c1XjzPZiZ0qw3jT/+pR0BmcbiASZOaDAHbKPEMi3e5/o8GxWGr3v4/ZbQ6OH9QQ8pxC/m2m/EXHeQFOHgF2u+VrPBNIKr0YzO7jo0uUbG6b6+WELCB+7s/j8lbIDAkpmDhy3ivMufk+Tz/kKv6Ptk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475819; c=relaxed/simple;
	bh=FfAbMiOIExUx33ujBp24OXlZu0uA7H5HkaSI88+JvWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMCmII4iSBUdtqdi4/29VFLvtrUvp0HtjutMjoABJ8M/hGuIX69prBIw+zwiRCGvQcRWwEhUe0RyHqaoG3hQKzlzwB5icLbc+wYD5WTA5MRs0YMNvrrktTFprLJ3aFA3VLlM7zZ/lKAHB4nJm0tLh/Aqz8g6E1HOhcC/WuW+U9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqxzavR0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqxzavR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5463C4CEE7;
	Wed,  2 Jul 2025 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475818;
	bh=FfAbMiOIExUx33ujBp24OXlZu0uA7H5HkaSI88+JvWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqxzavR0TQr4KX66l+sjLWQrtImaTboOqXtsug2qI6s4YVO8z+ySRFZWH65QYshsr
	 iLUDf5HyPyzzIzLJJ7Sj5iX3NaZA8q1StN0m+asv0mb8KWQFjiPPFjtnV4yj2I8how
	 1KMss9x5OXThZTsY19N7gac3oGCCBZuXqmMbGpOg/ZRL14bFL9hPP/1d/qwKju5Etb
	 tOZZ6MnfYFBGwXadvWrF0MmVWeViB9j36p+yBqaFoijIDRsNzFIzZbhWz30GeCwjNl
	 IcN28fU986Pycd4XVQfxSlgzI1MTXVkm4GRcBMQkeu4VbxFwAgkmvrEiFLito2sh3T
	 5izHG2ARVqQMQ==
Date: Wed, 2 Jul 2025 10:03:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [Ping][PATCH] perf list: Add IBM z17 event descriptions
Message-ID: <aGVmZ_VQiFfYCSaS@google.com>
References: <20250623132731.899525-1-tmricht@linux.ibm.com>
 <CAP-5=fV_hXzq0A-91NakejcQGnvPp+uJGGe=vccwM+47JVCmtA@mail.gmail.com>
 <ad905a68-a89b-458d-8a8b-2081a6656b91@linux.ibm.com>
 <283e109b-9eb5-4e7d-b7df-215f54496503@linux.ibm.com>
 <CAP-5=fVcNqE9txXQgO+EUV6xz3Mvsqin9FP8FNUztPp35LW2Ng@mail.gmail.com>
 <a63ecea7-8ab0-4691-897c-09f6efa82068@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a63ecea7-8ab0-4691-897c-09f6efa82068@linux.ibm.com>

Hello,

On Wed, Jul 02, 2025 at 10:57:58AM +0200, Thomas Richter wrote:
> On 6/27/25 18:55, Ian Rogers wrote:
> > On Fri, Jun 27, 2025 at 1:13 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >>
> >> On 6/24/25 08:35, Thomas Richter wrote:
> >>
> >> Gently Ping
> >>
> >> Ian, I have responded to your comments some days ago.
> > 
> > Thanks Thomas, minor nit in your explanation the events must exist as
> > they are in json, but the json events are only exposed if the PMU is
> > present, so the has_event is more of a has_pmu test. Maybe we should
> > add a function like this to the metrics to make this kind of case
> > clearer. Maybe `perf list` should test the events of a metric and hide
> > metrics when the events aren't available to avoid the have_event
> > logic. I'm a bit uncomfortable with that as the events may not be
> > available because of permission issues, but it'd still be useful to
> > know the metrics are around. Anyway I'm digressing.
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks,
> > Ian
> > 
> 
> Arnaldo, Namhyung,
> 
> with Ian Rogers Reviewed-by: approval, it is possible to
> accept this patch soon, so it will land in the next merge-window.
> 
> That will give me an commit-id which I need for my addon work.
> 
> Thanks a lot for your help.

Sorry about the delay, I'll process this soon.

Thanks,
Namhyung

