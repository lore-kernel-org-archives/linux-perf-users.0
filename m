Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CD19925A;
	Tue, 13 Aug 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562282; cv=none; b=qQltjA2GPaNIjuUptWGHsactmkz0fsLSPLDQN/ThuDd218zzqxOJg0pFlldtYcxU0QZC/fj+GNwNTHpyy36Hr5eRcAlTMzxnrEKbbpvBS2TRPyz7h332lPFyLsp23HT0pxaOOrh4tUHHCDIEvMsNZpWgShaHDuVsOwbdTkZbCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562282; c=relaxed/simple;
	bh=ORJuuh8qBCs0q6+9NYCn9FLe2LVpeI3IuubmowxMQJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGCbAkBos9t2FoqUOCgHC9smVyqF4rybrfFYZkyc+5VfVJ+kvbklqdIHUxqU+mDHYzfXlyEpz+8QAjABFsXLcgZr6nWwTKzh3ATT+ZvuXDBJM+Raie4cKB3G2OY8/ev4NZMhRZEor4SfvTCD/mdfRlKAGy6Hvu9tEllHzzw4cy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjDecaah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjDecaah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614D8C4AF0B;
	Tue, 13 Aug 2024 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723562282;
	bh=ORJuuh8qBCs0q6+9NYCn9FLe2LVpeI3IuubmowxMQJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjDecaahe7kDFtgfvmmvPyi+zMS+GYfYXCJih/x3DouS66OfS3yWXFaNrOqcYXmTp
	 R6DvkHmdvxyRdUZzbmp1Fldij9TAX4Jr76QJolxrJ3mbZHJZsbi9cTnsFet9yrnwBC
	 LQj/H6b0Cxu5cUP6QqeqVCzQGBvnTxWt3Rr1gSD3R5tTGuLui38PIqvRIbI9AXBRvb
	 Moug2ufAbDcMkww9jjyYWY1QzR7It88UrMOSFBShfHPggWVHzK7hZrTkPNJiGkmwh6
	 AWWRysUxU9hjbCFnOiAJ49exO2y/6XQqfI2SLBppdO8oGsmVUITdz1lS8LV0mnPHYW
	 JpA6OO22AxF0Q==
Date: Tue, 13 Aug 2024 12:17:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, irogers@google.com,
	peterz@infradead.org, mingo@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V2 0/9] Support branch counters in block annotation
Message-ID: <Zrt5Jm9iZ0ntKOKU@x1>
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
 <Zrpk5a2GQl5i5APD@google.com>
 <Zrps-_ajW_zfze66@x1>
 <bdf150ed-6a41-4c54-a754-13c1f194fac3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdf150ed-6a41-4c54-a754-13c1f194fac3@linux.intel.com>

On Tue, Aug 13, 2024 at 11:15:49AM -0400, Liang, Kan wrote:
> 
> 
> On 2024-08-12 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> > On Mon, Aug 12, 2024 at 12:39:17PM -0700, Namhyung Kim wrote:
> >> On Thu, Aug 08, 2024 at 12:33:15PM -0700, kan.liang@linux.intel.com wrote:
> >>> From: Kan Liang <kan.liang@linux.intel.com>
> >>> Kan Liang (9):
> >>>   perf report: Fix --total-cycles --stdio output error
> >>>   perf report: Remove the first overflow check for branch counters
> >>>   perf evlist: Save branch counters information
> >>>   perf annotate: Save branch counters for each block
> >>>   perf evsel: Assign abbr name for the branch counter events
> >>>   perf report: Display the branch counter histogram
> >>>   perf annotate: Display the branch counter histogram
> >>>   perf script: Add branch counters
> >>>   perf test: Add new test cases for the branch counter feature
> >>
> >> Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Clashed with something here, can you please take a look and rebase to
> > what is in perf-tools-next/perf-tools-next?
> 
> Tools-next/perf-tools-next doesn't include Weilin's TPEBS patch. So I
> fail at the patch 5, rather than patch 6 (the failure you observed.)
> 
> Can you please update the perf-tools-next?
> Or should I re-base on top of the tmp.perf-tools-next?

Do it over tmp.perf-tools-next please this time.

- Arnaldo
 
> $ git branch -v
>   master              1639fae5132b Merge tag 'drm-fixes-2023-06-17' of
> git://anongit.freedesktop.org/drm/drm
> * perf-tools-next     cb1898f58e0f perf annotate-data: Support
> --skip-empty option
>   tmp.perf-tools-next 9da782071202 perf test: Add test for Intel TPEBS
> counting mode
> $ git branch --show-current
> perf-tools-next
> 
> $ git am lbr_event_logging_v2/000*
> Applying: perf report: Fix --total-cycles --stdio output error
> Applying: perf report: Remove the first overflow check for branch counters
> Applying: perf evlist: Save branch counters information
> Applying: perf annotate: Save branch counters for each block
> Applying: perf evsel: Assign abbr name for the branch counter events
> error: patch failed: tools/perf/util/evlist.c:33
> error: tools/perf/util/evlist.c: patch does not apply
> Patch failed at 0005 perf evsel: Assign abbr name for the branch counter
> events
> 
> Thanks,
> Kan
> 
> > 
> > - Arnaldo
> > 
> >   ✓ [PATCH v2 9/9] perf test: Add new test cases for the branch counter feature
> >     + Acked-by: Namhyung Kim <namhyung@kernel.org> (✓ DKIM/kernel.org)
> >     + Reviewed-by: Andi Kleen <ak@linux.intel.com> (✓ DKIM/intel.com)
> >     + Link: https://lore.kernel.org/r/20240808193324.2027665-10-kan.liang@linux.intel.com
> >     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >   ---
> >   ✓ Signed: DKIM/intel.com (From: kan.liang@linux.intel.com)
> > ---
> > Total patches: 9
> > ---
> > Cover: ./v2_20240808_kan_liang_support_branch_counters_in_block_annotation.cover
> >  Link: https://lore.kernel.org/r/20240808193324.2027665-1-kan.liang@linux.intel.com
> >  Base: not specified
> >        git am ./v2_20240808_kan_liang_support_branch_counters_in_block_annotation.mbx
> > ⬢[acme@toolbox perf-tools-next]$        git am ./v2_20240808_kan_liang_support_branch_counters_in_block_annotation.mbx
> > Applying: perf report: Fix --total-cycles --stdio output error
> > Applying: perf report: Remove the first overflow check for branch counters
> > Applying: perf evlist: Save branch counters information
> > Applying: perf annotate: Save branch counters for each block
> > Applying: perf evsel: Assign abbr name for the branch counter events
> > Applying: perf report: Display the branch counter histogram
> > error: patch failed: tools/perf/util/annotate.h:551
> > error: tools/perf/util/annotate.h: patch does not apply
> > Patch failed at 0006 perf report: Display the branch counter histogram
> > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> > ⬢[acme@toolbox perf-tools-next]$
