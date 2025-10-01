Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F5211706;
	Wed,  1 Oct 2025 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326285; cv=none; b=gk0GIF0CN2rc1QhCbEoxUEq7F9gtQxMpoaU1e0GUtWXZMPeIJsf/oRLw+guSLW5esRSVoMwMJPDBN/dcWW8oxWnybvywldEt7Po6bDRIJ6Ql7jsmW8muZps14sjLmvV7LmgQ9LAzkXGhzELloVyydteQif/sXNdF1Ca40iqYa/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326285; c=relaxed/simple;
	bh=xH+ycHMFLnK2tNB9GrtNwRVlBhPDvc+PH8rWcYqPAes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayj7+AGufQRbPEO/tXvEbvb4/l7c+JUfPZNWOAfyTzZHqR0TsOrhE4lCwfia0FVhuCMi7p5JPJqf6CChc6ywhEm6B7goeCc2hzGyvNeNE5/mnoq/ziW+cBUYYaWTZm32mCu9zoI3MZTGpcUD61yQ6/WDcbYlgQDzQQTfQfz/4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R13y9uja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R13y9uja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C900C116D0;
	Wed,  1 Oct 2025 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759326285;
	bh=xH+ycHMFLnK2tNB9GrtNwRVlBhPDvc+PH8rWcYqPAes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R13y9ujaWWpuEctCzmZWX65DJ/oRv4sO6PhsttudaA5KaUckIhSxZnLQxxOktWJ8m
	 RiBngY+p59vxxkRBiUA4NZv4XTzDHVGO3sy3nTDXDby0ZsZS0LJWeKtE/VdJ0zmDRc
	 1W9EJdGKaZ/+aXFj9nih6ayi8c3iBFjb9aXI2iH9xsZAC/yQO1bE/uNg+FZIyXP7om
	 3xepawUHxLM5atug6NvI9oHxcS1hZv2r1s2UFPWDpG6YAVmF/G3RczsSrBArKV7OAF
	 6sJb1Survg11RcLhwFQk1ROUSvQyPmLzj5HfjvOgXifQZOfVm+gazG2703qqdJyVaU
	 SgO0RBo//Vx3A==
Date: Wed, 1 Oct 2025 10:44:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
Message-ID: <aN0wSrTqM6Xkv0Dm@x1>
References: <20250903184248.695267-1-irogers@google.com>
 <CAP-5=fV-3d1EzYfZq6s9M2NrLFFVOrWOTx_k5tByScA4Sfqq-g@mail.gmail.com>
 <aN0vu4yoVWjmTbtJ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN0vu4yoVWjmTbtJ@x1>

On Wed, Oct 01, 2025 at 10:42:23AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 30, 2025 at 01:02:55PM -0700, Ian Rogers wrote:
> > On Wed, Sep 3, 2025 at 11:42 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > The 'import perf' test needs to set up a path to the python module as
> > > well as to know the python command to invoke. These are hard coded at
> > > build time to be build a directory and the python used in the build,
> > > which is less than desirable. Avoid the hard coded values by reusing
> > > the existing shell script python setup and determine a potential built
> > > python module via the path of the perf executable.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > 
> > Ping.
> 
> There is another patch in this area to make it work, right?
> 
> After applying this one I get a failure, only when I set PYTHONPATH it
> works:
> 
> ⬢ [acme@toolbx perf-tools-next]$ export PYTHONPATH=/tmp/build/perf-tools-next/python_ext_build/lib/
> ⬢ [acme@toolbx perf-tools-next]$ perf test -v pytho
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
>  88: 'import perf' in python                                         : Ok
> ⬢ [acme@toolbx perf-tools-next]$

⬢ [acme@toolbx perf-tools-next]$ b4 am -ctsl --cc-trailers 20250930231100.197258-1-collin.funk1@gmail.com
Grabbing thread from lore.kernel.org/all/20250930231100.197258-1-collin.funk1@gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 5 messages in the thread
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
    + Link: https://lore.kernel.org/r/20250903184248.695267-1-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v1 2/2] perf test: Remove C python_use test
    + Link: https://lore.kernel.org/r/20250903184248.695267-2-irogers@google.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✗ BADSIG: DKIM/google.com
---
Total patches: 2
---
 Link: https://lore.kernel.org/r/20250903184248.695267-1-irogers@google.com
 Base: not specified
       git am ./20250903_irogers_perf_test_add_an_import_perf_test_shell_script.mbx
⬢ [acme@toolbx perf-tools-next]$        git am ./20250903_irogers_perf_test_add_an_import_perf_test_shell_script.mbx
Applying: perf test: Add an 'import perf' test shell script
error: tools/perf/tests/shell/python-use.sh: already exists in index
Patch failed at 0001 perf test: Add an 'import perf' test shell script
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
⬢ [acme@toolbx perf-tools-next]$
