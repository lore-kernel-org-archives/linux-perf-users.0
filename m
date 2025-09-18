Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6E2BD04;
	Thu, 18 Sep 2025 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225582; cv=none; b=roeVc3jXmNXqI5G5dkjIFiXC8hlrQHMpjM6Rxg//enQ3DIoioUbJfXT2TrN1oDa3cDxQcU8upN27y+DYNVPkrYWDn46bF42WMbJRcreEwSakiliGy2hyHtDlYx7iNjUAmc7riGtZ/JVr30b62V5b42E1i/TxDP7bf8T0NroUZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225582; c=relaxed/simple;
	bh=R1QX696odm1TCUI2x6CZHjFJPTvpael/7rOj+EdLefo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG5Csy5KwjEECWYEylxT00Q88H4msNzFusSw8qYDPhnAa2/1CLINJVf9wtj75gDFd5gYE6lp5L3ie39D3Vvh2BFgsxUZFdK6VkjXi1yt6IvAlBGS802nWqQQZctNQ+AQXCuQAcxTATadVGCS549DXamah7GNer4hCTe9UHehc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri2W5Vqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri2W5Vqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27727C4CEE7;
	Thu, 18 Sep 2025 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758225581;
	bh=R1QX696odm1TCUI2x6CZHjFJPTvpael/7rOj+EdLefo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri2W5VqrWa86d8MWJ9v29lTCulg17j8U1LEbudNKv5NVCHYA93UJEIVubjj/7GaOV
	 pFrhtSTZ0l0E3nkbsPaRaeKxFA6u9CjwifyM9oDYtPkImGYMJWjS+gOYqqyIl3+kAD
	 Up9PyuFMCop66PmjjEHCzMKrI+ZbmvoOYdmEKXfNV/3oWCZ3D9tazkx0dXzQEut0dm
	 UJrS27dCmzJpSp/6SaYwwN26UDls9xMxWTbVH/9IjGa5RMbxXGL15W4SR5BWNlzZvB
	 DmyQhXCrIKuKXYfPxKJ4nFDBzm9h/rsz9LA7FwADhtQaXRAGmd54Tz0jE0XtsihFWF
	 qHgjwJ0yX4hKw==
Date: Thu, 18 Sep 2025 16:59:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 0/6] Perf kvm commands bug fix
Message-ID: <aMxkqnXdrvv9BN8s@x1>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fWcf7F1QvWXzAD_KMpOnnKGw9PFM7mNtgzp_jh4Vi6V-w@mail.gmail.com>
 <189e060b-207b-469f-9b6e-314380d12a42@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <189e060b-207b-469f-9b6e-314380d12a42@linux.intel.com>

On Thu, Sep 18, 2025 at 07:52:43AM +0800, Mi, Dapeng wrote:
> On 9/18/2025 5:12 AM, Ian Rogers wrote:
> > On Sun, Aug 10, 2025 at 10:56 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
> >> his patch-set fixes perf kvm commands issues, like missed memory
> >> allocation check/free, out of range memory access and especially the
> >> issue that fails to sample guest with "perf kvm record/top" commands on
> >> Intel platforms.
> >>
> >> The commit 634d36f82517 ("perf record: Just use "cycles:P" as the
> >>  default event") changes to use PEBS event to do sampling by default
> >> including guest sampling. This breaks host to sample guest with commands
> >> "perf kvm record/top" on Intel platforms.
> > Huh? That change is:
> > ```
> > $ git show 634d36f82517
> > commit 634d36f82517eb5c6a9b9ec7fe3ba19dbbcb7809
> > Author: Namhyung Kim <namhyung@kernel.org>
> > Date:   Tue Oct 15 23:23:58 2024 -0700
> >
> >     perf record: Just use "cycles:P" as the default event
> >
> >     The fallback logic can add ":u" modifier if needed.
> > ...
> > -               bool can_profile_kernel = perf_event_paranoid_check(1);
> > -
> > -               err = parse_event(rec->evlist, can_profile_kernel ?
> > "cycles:P" : "cycles:Pu");
> > +               err = parse_event(rec->evlist, "cycles:P");
> > ...
> > ```
> > isn't the precision the same before and after? I think you've blamed
> > the wrong patch.
> >
> > The change to use cycles:P looks to come from commit 7b100989b4f6
> > ("perf evlist: Remove __evlist__add_default") but the old code was
> > doing things like "evsel->precise_max = true;" so I think I was just
> > carrying forward behavior. The use of precise_max comes from commit
> > 4e8a5c155137 ("perf evsel: Fix max perf_event_attr.precise_ip
> > detection") from over 6 years ago, and the behavior before that also
> > appears to have been to use the maximum supported precision.
> >
> > Apart from the blame and commit message being off I think the change
> > is okay, delta my usual complaint that weak symbols are the devil's
> > work.
> 
> Hmm, yeah, you're right. Thanks for correcting this. 

Hi Dapeng,

	Can you please fix the patch descriptions and Fixes references
and resubmit?

- Arnaldo
