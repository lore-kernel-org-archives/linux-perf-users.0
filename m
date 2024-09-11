Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A547A5C;
	Wed, 11 Sep 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070468; cv=none; b=gxl26I+leot8bwTMRA6ebgWTZvsFZ/2PBe2DtuhgWON8YH8lexIQ9Ocq4GBAGMWcdM1euQwRSDQC677RZXqg3xivRFmvIrkDFsCYInBs0UGweyCJQwchRoMoPjX9dmWv/6uN9Bky5PRvxeI0LvbhtAg/7oZRv0EUIGYK7OfjWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070468; c=relaxed/simple;
	bh=H2C4nQRQIXywEImqZgT4emGEgeXXI7enjYcyeze8tMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Utps4P8niqbwCecn8L09JuMufDNNqZwnqIkNWui2lAiR9w4leuI7N+wkg7trWQbTOC0LmBUjVUx8oC5vie762ZxoGDXfGtPgBWhArIQWVyRoNXM+vIRdxqs9y3Vc8nkJWKiqm517yAqbbF4WcftJEbC9b5Vdmn2NqGze0opeV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzry8bWq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzry8bWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965D8C4CEC0;
	Wed, 11 Sep 2024 16:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726070468;
	bh=H2C4nQRQIXywEImqZgT4emGEgeXXI7enjYcyeze8tMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qzry8bWqGWBEzNhFZ2j/oY/Yf5QS/3UxemKYyCUue3qsAk7fVqHvmXOD8bvUXWXtZ
	 CSip7oZ0vcGLvkB8KAU1qOeCmCCL6sLktLDAG+dhOX2E/dV+WAhLQ4K++5p9n4Unnf
	 EjYFUkeZb2L+jEy7AvWdWD8HGwAj1KE7LxrOleXP1lpXrUbFm47XUo5hp9RV5lzMG7
	 bTwoe87pzO2Rq6Co+Sfym9rWYd2f6AIkx3jQ8Y0r4ogFL3i539Xdt/BZUIcAsKZFNN
	 cu5NmytE+MgQzeaSKDSUV5dgj/KVDvLQEIMg4hXFSes4qU9KB5O0lBBxVxxk9DtJQP
	 3h6b6lPX8bMgw==
Date: Wed, 11 Sep 2024 13:01:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: namhyung@kernel.org, irogers@google.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf env: Find correct branch counter info on hybrid
Message-ID: <ZuG-wWTiQm6ZzXbN@x1>
References: <20240909184201.553519-1-kan.liang@linux.intel.com>
 <ZuGnCqBa4HZUzrmX@x1>
 <17676366-31b8-4c7c-b2e5-a91b054a5e7c@linux.intel.com>
 <ZuG-FYTFnE6U3PTn@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuG-FYTFnE6U3PTn@x1>

On Wed, Sep 11, 2024 at 12:58:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 11, 2024 at 11:41:54AM -0400, Liang, Kan wrote:
> > On 2024-09-11 10:19 a.m., Arnaldo Carvalho de Melo wrote:
> > > On Mon, Sep 09, 2024 at 11:42:00AM -0700, kan.liang@linux.intel.com wrote:
> > >> From: Kan Liang <kan.liang@linux.intel.com>
> > >>
> > >> No event is printed in the "Branch Counter" column on hybrid machines.
> > >>
> > >> For example,
> > >>  $perf record -e "{cpu_core/branch-instructions/pp,cpu_core/branches/}:S"
> > >>  -j any,counter
> > >>  $perf report --total-cycles
> > > 
> > > So I tried this on an Intel Hybrid system, I start the TUI, then try 'B'
> > > and, after applying your patch:
> > > 
> > >   0.66%  67.8K  0.00%   75                    ┌─Branch counter abbr list────────────┐ibc_write+18]          libc.so.6
> > >   0.63%  65.4K  0.00%  106                  [p│                                     │r_active+159]          [kernel.kallsyms]
> > >   0.61%  63.2K  0.01%  175  [native_queued_spi│ The branch counter is not available.│in_lock_slowpath+528]  [kernel.kallsyms]
> > >   0.57%  58.4K  0.00%   39         [syscall_ex│Press any key...                     │ser_mode+109]          [kernel.kallsyms]
> > >   0.54%  55.6K  0.00%    1  [_IO_file_xsputn@@└─────────────────────────────────────┘BC_2.2.5+316]          libc.so.6
> > > 
> > > The perf.data was obtained from:
> > > 
> > > root@number:~# perf record -e "{cpu_core/branch-instructions/pp,cpu_core/branches/}:S" -j any,counter find /
> > > 
> > > And:
> > > 
> > > root@number:~# perf evlist --group 
> > > {cpu_core/branch-instructions/pp,cpu_core/branches/}
> > > dummy:u
> > > root@number:~# 
> > > 
> > > Only mishap above we discussed already, the missing :S, and then:
> > > 
> > > root@number:~# perf evlist -v
> > > cpu_core/branch-instructions/pp: type: 4 (cpu_core), size: 136, config: 0xc4 (branch-instructions), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|READ|PERIOD|BRANCH_STACK|IDENTIFIER, read_format: ID|GROUP|LOST, disabled: 1, freq: 1, enable_on_exec: 1, precise_ip: 2, sample_id_all: 1, exclude_guest: 1, branch_sample_type: ANY
> > 
> > For a hybrid client, the "Branch Counter" feature is only supported
> > starting from the just released Lunar Lake. Perf falls back to only
> > "ANY" on your Raptor Lake.
> > 
> > The "The branch counter is not available" message is expected.
> > 
> > Here is the perf evlist result from my Lunar Lake machine,
> > 
> > #perf evlist -v
> > cpu_core/branch-instructions/pp: type: 4 (cpu_core), size: 136, config:
> > 0xc4 (branch-instructions), { sample_period, sample_freq }: 4000,
> > sample_type: IP|TID|TIME|READ|PERIOD|BRANCH_STACK|IDENTIFIER,
> > read_format: ID|GROUP|LOST, disabled: 1, freq: 1, enable_on_exec: 1,
> > precise_ip: 2, sample_id_all: 1, exclude_guest: 1, branch_sample_type:
> > ANY|COUNTERS
> 
> So I'll just take the patch and add these explanations there, ok?

Added this:

Committer notes:

While testing I couldn't s ee those "Branch counter" columns enabled by
pressing 'B' on the TUI, after reporting it to the list Kan explained
the situation:

<quote Kan Liang>
For a hybrid client, the "Branch Counter" feature is only supported
starting from the just released Lunar Lake. Perf falls back to only
"ANY" on your Raptor Lake.

The "The branch counter is not available" message is expected.

Here is the 'perf evlist' result from my Lunar Lake machine,

  # perf evlist -v
  cpu_core/branch-instructions/pp: type: 4 (cpu_core), size: 136, config: 0xc4 (branch-instructions), { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|READ|PERIOD|BRANCH_STACK|IDENTIFIER, read_format: ID|GROUP|LOST, disabled: 1, freq: 1, enable_on_exec: 1, precise_ip: 2, sample_id_all: 1, exclude_guest: 1, branch_sample_type: ANY|COUNTERS
  #
</quote>
