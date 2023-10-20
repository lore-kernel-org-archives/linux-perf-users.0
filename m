Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9B249EA
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uawZ16gW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8BEC433CA;
	Fri, 20 Oct 2023 20:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697833633;
	bh=B58u0vramlzeCm/DCDcAjwSOr9tVOF8VqXdBV/sj198=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uawZ16gW2fq1zI7L27xxovrp1zt35N6n3w08Av+jlNDmG4NQU+/HqIbRiWBv2IKvD
	 PszkIcUIcyqe4sqEcZdU33gTujo9nu3GgAzh4ayWveco8TbGVIGGMyW+92l/RfD2lG
	 SQIX8OGxb086zrhp9MX2XVSBrReazjQlUZxfRG6wBOtdxABsIQ0wH/rgTZ5GzSfZqR
	 zjOtq3Wcd2cGqn1tWntNphCbrDahPaMQIa1JrHxUHzTR+RQbCtQeRQIR39Bf0Z5m5t
	 rq7m1WCYCtvNWE4EMR2hl8LmRgbdjKMNGHfSxzga6tIVqkF7tCsVhqxHv07KGhWRfD
	 8gj4lB73vP24w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 755624035D; Fri, 20 Oct 2023 17:27:10 -0300 (-03)
Date: Fri, 20 Oct 2023 17:27:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, Aditya Gupta <adityag@linux.ibm.com>,
	jolsa@kernel.org, linux-perf-users@vger.kernel.org,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v5 0/4] Introduce perf check subcommand
Message-ID: <ZTLinqxncSO3wvSq@kernel.org>
References: <20231003055440.111907-1-adityag@linux.ibm.com>
 <CAM9d7cghSKFMOCSNb0NYEAp6ts_gvxqg4_R4ppnXbzwrApuXSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cghSKFMOCSNb0NYEAp6ts_gvxqg4_R4ppnXbzwrApuXSw@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Wed, Oct 04, 2023 at 09:48:49PM -0700, Namhyung Kim escreveu:
> Arnaldo, Ian and others,
> 
> Are you ok with this?

Its not applying to the current perf-tools-next/perf-tools-next:

[acme@quaco perf-tools-next]$ git remote -v | grep -m1 ^perf-tools-next
perf-tools-next	git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git (fetch)
[acme@quaco perf-tools-next]$

Aditya, can you please take a look, I think it needs a refresh.

- Arnaldo

[acme@quaco perf-tools-next]$ git checkout -b bla perf-tools-next/perf-tools-next
branch 'bla' set up to track 'perf-tools-next/perf-tools-next'.
Switched to a new branch 'bla'
[acme@quaco perf-tools-next]$ b4 am -ctsl --cc-trailers CAM9d7cghSKFMOCSNb0NYEAp6ts_gvxqg4_R4ppnXbzwrApuXSw@mail.gmail.com
Grabbing thread from lore.kernel.org/all/CAM9d7cghSKFMOCSNb0NYEAp6ts_gvxqg4_R4ppnXbzwrApuXSw%40mail.gmail.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 7 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH v5 1/4] perf check: introduce check subcommand
    + Link: https://lore.kernel.org/r/20231003055440.111907-2-adityag@linux.ibm.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  [PATCH v5 2/4] perf version: update --build-options to use 'supported_features' array
    + Link: https://lore.kernel.org/r/20231003055440.111907-3-adityag@linux.ibm.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  [PATCH v5 3/4] perf tests task_analyzer: use perf check for libtraceevent support
    + Link: https://lore.kernel.org/r/20231003055440.111907-4-adityag@linux.ibm.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  [PATCH v5 4/4] tools/perf/tests: Update probe_vfs_getname.sh script to use perf check --feature
    + Link: https://lore.kernel.org/r/20231003055440.111907-5-adityag@linux.ibm.com
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  NOTE: install dkimpy for DKIM signature verification
---
Total patches: 4
---
Cover: ./v5_20231003_adityag_introduce_perf_check_subcommand.cover
 Link: https://lore.kernel.org/r/20231003055440.111907-1-adityag@linux.ibm.com
 Base: not specified
       git am ./v5_20231003_adityag_introduce_perf_check_subcommand.mbx
[acme@quaco perf-tools-next]$        git am ./v5_20231003_adityag_introduce_perf_check_subcommand.mbx
Applying: perf check: introduce check subcommand
Applying: perf version: update --build-options to use 'supported_features' array
error: patch failed: tools/perf/builtin-version.c:46
error: tools/perf/builtin-version.c: patch does not apply
Patch failed at 0002 perf version: update --build-options to use 'supported_features' array
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
[acme@quaco perf-tools-next]$
 
> Thanks,
> Namhyung
> 
> 
> On Mon, Oct 2, 2023 at 10:54 PM Aditya Gupta <adityag@linux.ibm.com> wrote:
> >
> > The Problem
> > ===========
> >
> > Currently the presence of a feature is checked with a combination of
> > perf version --build-options and greps, such as:
> >
> >     perf version --build-options | grep " on .* HAVE_FEATURE"
> >
> > Proposed solution
> > =================
> >
> > As suggested by contributors in:
> > https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
> >
> > Introduce a subcommand "perf check --feature", with which
> > scripts can test for presence of a feature, such as:
> >
> >     perf check --feature HAVE_LIBTRACEEVENT
> >
> >     or
> >
> >     perf check --feature libtraceevent
> >
> > The usage of "perf version --build-options | grep" has been replaced in two
> > tests, with "perf check --feature" command
> >
> > Also, to not duplicate the same feature list at multiple places, a new global
> > 'supported_features' array has been introduced in builtin.h, so both commands
> > 'perf check --feature' and 'perf version --build-options' use the same array
> >
> > 'supported_features' feature is an array of 'struct feature_support', which
> > also has the name of the feature, macro used to test it's presence, and a
> > is_builtin member, which will be 0 if feature not built-in, and 1 if built-in
> >
> > Architectures Tested
> > ====================
> > * x86_64
> > * ppc64le
> >
> > Git tree
> > ========
> >
> > Git tree with this patch series applied for testing:
> > https://github.com/adi-g15-ibm/linux/tree/perf-check-feature-v5
> >
> > Changelog
> > =========
> > V5
> > + invert return value of 'has_support', but return value of perf check --feature
> > according to shell convention
> >
> > V4
> > + invert return value of perf check --feature
> >
> > V3
> > + simplified has_support code in builtin-check.c (patch #1)
> > + modified patch #3 and patch #4 according to change in return value in patch #1
> >
> > V2
> > + improved the patch series with suggestions from Namhyung
> > + fix incorrect return value, added -q option, and moved array definition to
> >   perf-check.c
> >
> > V1
> > + changed subcommand name to 'perf check --feature'
> > + added documentation for perf check
> > + support both macro (eg. HAVE_LIBTRACEEVENT), and name (eg. libtraceevent) as
> >   input to 'perf check --feature'
> > + change subject and descriptions of all patch mentioning perf check instead of
> >   perf build
> >
> > V0: Previous patch series: https://lore.kernel.org/linux-perf-users/20230825061125.24312-1-adityag@linux.ibm.com/
> >
> > Aditya Gupta (3):
> >   perf check: introduce check subcommand
> >   perf version: update --build-options to use 'supported_features' array
> >   perf tests task_analyzer: use perf check for libtraceevent support
> >
> > Athira Rajeev (1):
> >   tools/perf/tests: Update probe_vfs_getname.sh script to use perf check
> >     --feature
> >
> >  tools/perf/Build                              |   1 +
> >  tools/perf/Documentation/perf-check.txt       |  59 +++++++++
> >  tools/perf/builtin-check.c                    | 122 ++++++++++++++++++
> >  tools/perf/builtin-version.c                  |  39 ++----
> >  tools/perf/builtin.h                          |  18 +++
> >  tools/perf/perf.c                             |   1 +
> >  .../perf/tests/shell/lib/probe_vfs_getname.sh |   4 +-
> >  .../shell/record+probe_libc_inet_pton.sh      |   5 +-
> >  .../shell/record+script_probe_vfs_getname.sh  |   5 +-
> >  tools/perf/tests/shell/test_task_analyzer.sh  |   4 +-
> >  10 files changed, 221 insertions(+), 37 deletions(-)
> >  create mode 100644 tools/perf/Documentation/perf-check.txt
> >  create mode 100644 tools/perf/builtin-check.c
> >
> > --
> > 2.41.0
> >

-- 

- Arnaldo
