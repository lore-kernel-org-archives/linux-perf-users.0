Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02182E3EB
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Sep 2024 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310837; cv=none; b=Tma11yeCDXSEvXh/aJhCq1CrSOGhyn/iNodV3Kq8SxfGms1g0xe9SNo/OQ4b8UceT6qcwX1R7fDCpUX6s+3BejxgovNwhU+H9L7wxHeVuiBsO+pQW8tXrW96isqwuJKqlhDTUoSqI1i5vQKzJ4/pWEnzOhyw/6NJpGig43qJCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310837; c=relaxed/simple;
	bh=qn77SDky3QOINLZ+EK6gSXcXTNLMpa35uAhQ3UMv/QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHjG2F4Aftq3P078tY/yRo3IxeN0GHehX72Zmi7q3q09C+n/Du3Bz5s2nf8LNM6m8lmyHMHc2fK3m/MEa6P7RZRFbWeqIC9B4cBFIc++2obOGsKxv/m4uDn3a8sSz2jDv7AkzO2ThUQW3E+DAZkKiwaMzaUj1hEBF63d9A8DE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj11kMuG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj11kMuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78A5C4CEC2;
	Mon,  2 Sep 2024 21:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725310837;
	bh=qn77SDky3QOINLZ+EK6gSXcXTNLMpa35uAhQ3UMv/QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj11kMuG2sWPFiXLITDS//FNoyqnFyhoFOJi+Orligsq8JJNiQ4Li1V3IYJa5N63n
	 kk/EuQ3CMjFnE1hxfoHrBxbUpGGHpHILWKOlYCgwz7yS6u23DQNssoT3HrQctnMXBC
	 RBjr2tgL2K+xthlBixY813jGFF5VWtPYN5TfFs0lR68UaoHzPddOcjR7O5OMAx7r8n
	 9yW9L0wmwec3eBxy2JjrXYb0zx7VbhGaYHiphFpD/Jufw1EQKTbuIE85nyOkPu1znb
	 I3X1UiwPJu3Gsp0wbZL25I7xhFbcTVI0+ldRQav0qLSSIIefq+M6++9jk2hYhOVrUx
	 K2/GX1GmwNyqg==
Date: Mon, 2 Sep 2024 18:00:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
	mpetlan@redhat.com, irogers@google.com, atrajeev@linux.vnet.ibm.com,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
Message-ID: <ZtYncRvFQ6mxtioT@x1>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
 <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com>
 <Zs-LEEutfp0hkjh5@x1>
 <ZtHk6Tj7KioLRd10@x1>
 <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>
 <ZtXMRffIGVmjptcf@x1>
 <ZtXOrJdxvrI7Kk6n@x1>
 <b87e2c58-8696-48bc-92ca-93964917bf9a@redhat.com>
 <ZtYIElLzMIzEVH9t@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtYIElLzMIzEVH9t@x1>

On Mon, Sep 02, 2024 at 03:46:46PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 02, 2024 at 05:10:48PM +0200, Veronika Molnarova wrote:
> > On 9/2/24 16:41, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Sep 02, 2024 at 11:31:36AM -0300, Arnaldo Carvalho de Melo wrote:
> > >> On Mon, Sep 02, 2024 at 04:05:04PM +0200, Veronika Molnarova wrote:
> > >>> On 8/30/24 17:27, Arnaldo Carvalho de Melo wrote:
> > >> So is it just a matter of adding this output to the expected outputs?
> > >> In test_adding_blacklisted.sh?

> > > Did the patch below, now it passes, Ack?

> > > root@x1:~# export PERFTEST_KEEP_LOGS=y
> > > root@x1:~# perf test 88
> > >  88: perftool-testsuite_probe                                        : Ok
> > > root@x1:~#

> > > Or am I missing the point? :-)

> > Yeah, that would fix the test case, the question is whether we should
 
> I was lazy, but yeah, that thought crossed my mind, good thing you did
> the due diligence and found that patch! Looking at it now.
 
> > accept it as a possible output. Found some old patch that should have
> > fixed the mentioned issue: 
> > https://lore.kernel.org/all/20230628082337.1857302-3-georgmueller@gmx.net/
 
> I updated Masami's e-mail to a more recent one, Masami-san, wdyt? Can I
> have your opinion on the patch pointed out by Veronika?

And b4 doesn't like it, I'm trying to find it manually

⬢[acme@toolbox perf-tools-next]$ b4 am -ctsl --cc-trailers 20230628082337.1857302-3-georgmueller@gmx.net
Grabbing thread from lore.kernel.org/all/20230628082337.1857302-3-georgmueller@gmx.net/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 21 messages in the thread
WARNING: duplicate messages found at index 1
   Subject 1: tools/perf: Fix to avoid crashing if DW_AT_decl_file is NULL
   Subject 2: perf probe: add test for regression introduced by switch to die_get_decl_file
  2 is not a reply... assume additional patch
WARNING: duplicate messages found at index 2
   Subject 1: tools/perf: Fix to use dwarf_attr_integrate for generic attr accessor
   Subject 2: perf probe: add test for regression introduced by switch to die_get_decl_file
  2 is not a reply... assume additional patch
^CTraceback (most recent call last):
  File "/home/acme/git/b4/src/b4/command.py", line 428, in <module>
    cmd()
  File "/home/acme/git/b4/src/b4/command.py", line 410, in cmd

And then I noticed that his _was_ already merged, see below, so we're
back to the previous square, can you try to continue this analysis, I'm
rather busy with preparing for the upcoming conferences, so any help I
can get is appreciated :-)

- Arnaldo

commit c66e1c68c13b872505f25ab641c44b77313ee7fe
Author: Georg Müller <georgmueller@gmx.net>
Date:   Wed Jun 28 10:45:51 2023 +0200

    perf probe: Read DWARF files from the correct CU
    
    After switching from dwarf_decl_file() to die_get_decl_file(), it is not
    possible to add probes for certain functions:
    
      $ perf probe -x /usr/lib/systemd/systemd-logind match_unit_removed
      A function DIE doesn't have decl_line. Maybe broken DWARF?
      A function DIE doesn't have decl_line. Maybe broken DWARF?
      Probe point 'match_unit_removed' not found.
         Error: Failed to add events.
    
    The problem is that die_get_decl_file() uses the wrong CU to search for
    the file. elfutils commit e1db5cdc9f has some good explanation for this:
    
        dwarf_decl_file uses dwarf_attr_integrate to get the DW_AT_decl_file
        attribute. This means the attribute might come from a different DIE
        in a different CU. If so, we need to use the CU associated with the
        attribute, not the original DIE, to resolve the file name.
    
    This patch uses the same source of information as elfutils: use attribute
    DW_AT_decl_file and use this CU to search for the file.
    
    Fixes: dc9a5d2ccd5c823c ("perf probe: Fix to get declared file name from clang DWARF5")
    Signed-off-by: Georg Müller <georgmueller@gmx.net>
    Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: regressions@lists.linux.dev
    Cc: stable@vger.kernel.org
    Link: https://lore.kernel.org/r/20230628084551.1860532-6-georgmueller@gmx.net
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

