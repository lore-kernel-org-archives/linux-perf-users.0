Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0C2E624
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jan 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM+8c5b/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39547C433C7;
	Fri,  5 Jan 2024 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704467341;
	bh=U1+K7aDo51XqJDu0LIYAZu0FbZZGsHO5WKmX6sqRhVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eM+8c5b/xo4hXUJgn4o86rNOpr9TcTcsie9VDdw0kXTLG6MO4tdLLzFxiJXH9xh5Q
	 ViJteh3LdYGNvdTgLgoJg4zvU9IPvd3toKkqt+hGxGgJuT9O15k71/fh/aEGgmlGiC
	 aKEZYsoHxiafUL8T/lxWwAOmDYU9nuCPvaDqvVDv6b+EXQ64d5MdzTaje1T2ZIiNlN
	 tqlVM7wVIFSEXWvqGzMe+JpDOema9lTDiUNmpfharQ2Tg6QvCzh8kF28LlscaR4EXE
	 oD1Sqwn5PTdABuwzP/aGz+qCOaupPmKJm4NrtSL+mtHTgMKI6+ITNBP/zAdyQjv37N
	 7a/CMNLFGiLbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 5091F403EF; Fri,  5 Jan 2024 12:08:57 -0300 (-03)
Date: Fri, 5 Jan 2024 12:08:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v8 0/4] Introduce perf check subcommand
Message-ID: <ZZgbifOT9Xgr-1Wo@kernel.org>
References: <20231204093954.304030-1-adityag@linux.ibm.com>
 <h5dyqz55bcbrrcykdrherwpioclnmbr4egccsr4qb5n7zky747@brkblmk7vazt>
 <3bgpdf5ha4go7xpxtgfa2ophxokoyiu2hjjumlwmtioi3bgjmv@bah667fiqp7x>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bgpdf5ha4go7xpxtgfa2ophxokoyiu2hjjumlwmtioi3bgjmv@bah667fiqp7x>
X-Url: http://acmel.wordpress.com

Em Fri, Jan 05, 2024 at 01:30:19PM +0530, Aditya Gupta escreveu:
> Hi Arnaldo,
> Any comments on the series ?

I'm trying now to finish the pull req for v6.8, trying to avoid adding
new features, Namhyung will take care for patches for v6.9, where he
will most likely consider your latest v8 kit.

Thanks,

- Arnaldo
 
> Thanks,
> Aditya
> 
> > On Mon, Dec 04, 2023 at 03:09:50PM +0530, Aditya Gupta wrote:
> > > The Problem
> > > ===========
> > > 
> > > Currently the presence of a feature is checked with a combination of
> > > perf version --build-options and greps, such as:
> > > 
> > >     perf version --build-options | grep " on .* HAVE_FEATURE"
> > > 
> > > Proposed solution
> > > =================
> > > 
> > > As suggested by contributors in:
> > > https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
> > > 
> > > Introduce a subcommand "perf check --feature", with which
> > > scripts can test for presence of a feature or multiple features, such as:
> > > 
> > >     perf check --feature HAVE_LIBTRACEEVENT
> > > 
> > >     or
> > > 
> > >     perf check --feature libtraceevent
> > > 
> > >     or
> > > 
> > >     perf check --feature libtraceevent,bpf
> > > 
> > > The usage of "perf version --build-options | grep" has been replaced in two
> > > tests, with "perf check --feature" command
> > > 
> > > Also, to not duplicate the same feature list at multiple places, a new global
> > > 'supported_features' array has been introduced in builtin.h, so both commands
> > > 'perf check --feature' and 'perf version --build-options' use the same array
> > > 
> > > 'supported_features' feature is an array of 'struct feature_support', which
> > > also has the name of the feature, macro used to test it's presence, and a
> > > is_builtin member, which will be 0 if feature not built-in, and 1 if built-in
> > > 
> > > Architectures Tested
> > > ====================
> > > * x86_64
> > > * ppc64le
> > > 
> > > Git tree
> > > ========
> > > 
> > > Git tree with this patch series applied for testing:
> > > https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v8
> > > 
> > > Changelog
> > > =========
> > > V8
> > > + handle return value of 'malloc' in patch #1
> > > + fix error due to strncpy depending on source string's length
> > > 
> > > V7
> > > + modified patch #1 to fix compile issue, and add feature to allow
> > >   multiple comma-separated features
> > > 
> > > V6
> > > + rebased to perf-tools-next/perf-tools-next
> > > + modified patch #1 to include FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL)
> > > 
> > > V5
> > > + invert return value of 'has_support', but return value of perf check --feature
> > > according to shell convention
> > > 
> > > V4
> > > + invert return value of perf check --feature
> > > 
> > > V3
> > > + simplified has_support code in builtin-check.c (patch #1)
> > > + modified patch #3 and patch #4 according to change in return value in patch #1
> > > 
> > > V2
> > > + improved the patch series with suggestions from Namhyung
> > > + fix incorrect return value, added -q option, and moved array definition to
> > >   perf-check.c
> > > 
> > > V1
> > > + changed subcommand name to 'perf check --feature'
> > > + added documentation for perf check
> > > + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
> > >   input to 'perf check --feature'
> > > + change subject and descriptions of all patch mentioning perf check instead of
> > >   perf build
> > > 
> > > V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/
> > > 
> > > Aditya Gupta (3):
> > >   perf check: introduce check subcommand
> > >   perf version: update --build-options to use 'supported_features' array
> > >   perf tests task_analyzer: use perf check for libtraceevent support
> > > 
> > > Athira Rajeev (1):
> > >   tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
> > >     --feature
> > > 
> > >  tools/perf/Build                              |   1 +
> > >  tools/perf/Documentation/perf-check.txt       |  59 +++++++++
> > >  tools/perf/builtin-check.c                    | 122 ++++++++++++++++++
> > >  tools/perf/builtin-version.c                  |  39 ++----
> > >  tools/perf/builtin.h                          |  18 +++
> > >  tools/perf/perf.c                             |   1 +
> > >  .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
> > >  .../shell/record+probe_libc_inet_pton.sh      |   5 +-
> > >  .../shell/record+script_probe_vfs_getname.sh  |   5 +-
> > >  tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
> > >  10 files changed, 221 insertions(+), 37 deletions(-)
> > >  create mode 100644 tools/perf/Documentation/perf-check.txt
> > >  create mode 100644 tools/perf/builtin-check.c
> > > 
> > > -- 
> > > 2.41.0
> > > 

-- 

- Arnaldo
