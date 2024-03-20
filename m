Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A689D41C84
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944373; cv=none; b=XXXpaDkSTnVKG5QjOr8NZOpQ9JPlM9kGiXHlPLSZYk87t6h7MjY9tP1nQa1rJ22A13XqsTkToUSw6jU9luIeS7DzFQ8Yo+0KYfv+/eFXq5K0un1pVS43QF4aKU3uzXnD97gu/oJNjYzwaNm8RMRSOs1BjxCvwSp3kvR+4o1jA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944373; c=relaxed/simple;
	bh=rIly7YZyoe0bASacPjoo0y1zWW+9QHWJoihngsaciUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBEf0rSoRP08eck8kTT00yb7yCNF3oAMwNTG6CTeQlU09BAYgeZodR2IF/7H1a9T2j8GuWPGRNk0XO46c3vKUQF/54t/Aaqyc84D9DTfF+G4RchxP19G4YEFiZA/JMP7iYUIwAWfABymXxkvq9UFotn9g18q8dSkOxmmdGA+SRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNNNTqGx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNNNTqGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5B4C43390;
	Wed, 20 Mar 2024 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710944373;
	bh=rIly7YZyoe0bASacPjoo0y1zWW+9QHWJoihngsaciUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNNNTqGxZCOnHrxT/MPrHrbOeSZjyolZDrkQDglIlZ5rGw3qDNx+x1nbmXhmq54lh
	 hEJimttAn+ndnTq1QIwfY6PpWNGS+Axss/8/ZlWNEG2gS/D7fTg9oeLFC92t+ggbla
	 QdIJC51lJha90SRfsX4cfK0C1p4IIFGrZO2meajetNWEIziFj0NBcivbcQkaVO46XD
	 9CMW5u0HNGnk9Acr8AHGSPkjokA+cwEa1aawZ5unD3aZ4i/2RiTLDBl7zIVLDd+4dJ
	 Yjw/hPMwC7z2Ity+JP0yB2FLhmHPCMY7q6RLQdtltitpYkvslOGymVD0NFfthgwt2C
	 HIhWz1HcwELug==
Date: Wed, 20 Mar 2024 11:19:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org, acme@redhat.com
Subject: Re: [PATCH v2] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZfrwcurxSYKy9uma@x1>
References: <20240311081127.7652-1-vmolnaro@redhat.com>
 <alpine.LRH.2.20.2403201310220.4040@Diego>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LRH.2.20.2403201310220.4040@Diego>

On Wed, Mar 20, 2024 at 01:14:32PM +0100, Michael Petlan wrote:
> Hello Arnaldo,
> kind reminder, any chance this being merged soon?
> Thanks,
> Michael
> 
> On Mon, 11 Mar 2024, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Subtest for system-wide record with '--threads=cpu' option fails due
> > to a limit of open file descriptors on systems with 128 or more CPUs
> > as the default limit is set to 1024.
> > 
> > The number of open file descriptors should be slightly above
> > nmb_events*nmb_cpus + nmb_cpus(for perf.data.n) + 4*nmb_cpus(for pipes),
> > which equals 8*nmb_cpus. Therefore, temporarily raise the limit to
> > 16*nmb_cpus for the test.
> >
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Acked-by: Michael Petlan <mpetlan@redhat.com>

Its not applying, can you please check?

Please use the
git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
repo, tmp.perf-tools-next branch.

- Arnaldo

⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers alpine.LRH.2.20.2403201310220.4040@Diego
Grabbing thread from lore.kernel.org/all/alpine.LRH.2.20.2403201310220.4040@Diego/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 2 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH v2] perf test record.sh: Raise limit of open file descriptors
    + Acked-by: Michael Petlan <mpetlan@redhat.com>
    + Link: https://lore.kernel.org/r/20240311081127.7652-1-vmolnaro@redhat.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  NOTE: install dkimpy for DKIM signature verification
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20240311081127.7652-1-vmolnaro@redhat.com
 Base: not specified
       git am ./v2_20240311_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
⬢[acme@toolbox perf-tools-next]$ vim ./v2_20240311_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
⬢[acme@toolbox perf-tools-next]$ patch -p1 < ./v2_20240311_vmolnaro_perf_test_record_sh_raise_limit_of_open_file_descriptors.mbx
patching file tools/perf/tests/shell/record.sh
Hunk #1 succeeded at 12 with fuzz 2 (offset 1 line).
Hunk #2 FAILED at 162.
1 out of 2 hunks FAILED -- saving rejects to file tools/perf/tests/shell/record.sh.rej
⬢[acme@toolbox perf-tools-next]$ 
