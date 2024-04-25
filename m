Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB06A34F
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071647; cv=none; b=CpSlnwhrbnqupvu6G5+Ku2btX+P+aiOMyyfIHKw3N9SHCNEyUzPrGu/N8EIKXS750QEvzOoMh5slnPS6DxZcSmuBCIFEPDqMpf4VfOQIK9zdBcszRz5atksaSXkvDUgewzVsS7HaOMje/LUYmbWGkJjqgGEV4HFRMgfpWQaxY/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071647; c=relaxed/simple;
	bh=tqTgm88xS/dSHnnlQZyzvSvbDjwOxr7Za4pzSE4IVdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWWKccs5yO8T4v3iccCwvsQOylW3Rc0XhF01QAmXlHrjycdPC62MxWdaHDOU734VK5gl/AVFuSVgMuWYQqLwnQhqEAnkjUlNMuYPWhv99ed92tOBTR2lC+xFCM9vW0F6d+2yTpa60M8/9ElmdncmsnaQ2FCZNuO54cTm/d86ahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQn9YNml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQn9YNml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8D1C113CC;
	Thu, 25 Apr 2024 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714071646;
	bh=tqTgm88xS/dSHnnlQZyzvSvbDjwOxr7Za4pzSE4IVdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQn9YNmlPXCjuVsO4dSpHGB6xrTBNlpK3+U+4nFVeLGCh29Aakb4lfmo5DI3x0MSW
	 dvTVTa6NbmP8z7PGLdTuYRYa4H5U6H1TAxHI0wwC/E/Frb0Kbzl36mULik/DU4eeau
	 LA0eGQrvw+YoiUJAPFxYh9kKGzZWB6Mo1+6yex59S1kq7xe2qQLSNz7AA1XJeueO+C
	 F0olbpW1jc5vFJnKogTQiVLQpbJE3cZBGcOuY1VWLDjZdn7syx3gefS9IOmELH5be1
	 Jdw4Q3H1DpE5d8AtDbQSc40TCTEraOrEjxRfJxC9xoiSwZfVkaURHELw2CrtFbf8h6
	 hPPru2IW6DIWQ==
Date: Thu, 25 Apr 2024 16:00:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>,
	linux-perf-users@vger.kernel.org, acme@redhat.com
Subject: Re: [PATCH v2] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZiqoWj3f-P3ChlWa@x1>
References: <20240311081127.7652-1-vmolnaro@redhat.com>
 <alpine.LRH.2.20.2403201310220.4040@Diego>
 <ZfrwcurxSYKy9uma@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfrwcurxSYKy9uma@x1>

On Wed, Mar 20, 2024 at 11:19:30AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 20, 2024 at 01:14:32PM +0100, Michael Petlan wrote:
> > Hello Arnaldo,
> > kind reminder, any chance this being merged soon?
> > Thanks,
> > Michael
> > 
> > On Mon, 11 Mar 2024, vmolnaro@redhat.com wrote:
> > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > > 
> > > Subtest for system-wide record with '--threads=cpu' option fails due
> > > to a limit of open file descriptors on systems with 128 or more CPUs
> > > as the default limit is set to 1024.
> > > 
> > > The number of open file descriptors should be slightly above
> > > nmb_events*nmb_cpus + nmb_cpus(for perf.data.n) + 4*nmb_cpus(for pipes),
> > > which equals 8*nmb_cpus. Therefore, temporarily raise the limit to
> > > 16*nmb_cpus for the test.
> > >
> > > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Acked-by: Michael Petlan <mpetlan@redhat.com>
> 
> Its not applying, can you please check?
> 
> Please use the
> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> repo, tmp.perf-tools-next branch.

ping?

- Arnaldo
 
> - Arnaldo
> 
> ⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers alpine.LRH.2.20.2403201310220.4040@Diego
> Grabbing thread from lore.kernel.org/all/alpine.LRH.2.20.2403201310220.4040@Diego/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 2 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   [PATCH v2] perf test record.sh: Raise limit of open file descriptors
>     + Acked-by: Michael Petlan <mpetlan@redhat.com>
>     + Link: https://lore.kernel.org/r/20240311081127.7652-1-vmolnaro@redhat.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ---
>   NOTE: install dkimpy for DKIM signature verification
> ---
> Total patches: 1
> ---
>  Link: https://lore.kernel.org/r/20240311081127.7652-1-vmolnaro@redhat.com
>  Base: not specified
>        git am ./v2_20240311_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
> ⬢[acme@toolbox perf-tools-next]$ vim ./v2_20240311_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
> ⬢[acme@toolbox perf-tools-next]$ patch -p1 < ./v2_20240311_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
> patching file tools/perf/tests/shell/record.sh
> Hunk #1 succeeded at 12 with fuzz 2 (offset 1 line).
> Hunk #2 FAILED at 162.
> 1 out of 2 hunks FAILED -- saving rejects to file tools/perf/tests/shell/record.sh.rej
> ⬢[acme@toolbox perf-tools-next]$ 
