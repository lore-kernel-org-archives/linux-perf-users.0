Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5DE1E530
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixPz9FJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29077C433C8;
	Fri, 20 Oct 2023 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697833311;
	bh=4JZVN8AJNpFw9WOcgziLlmxpovlDW6nL5iH2Fwv7vkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixPz9FJHRL7QnrCeBdJIjo6AKqXtnPB7faMz7SU5SVrBUCj+XmKvY/AMTdGf4Yhe5
	 3ObCZ/IBVSZDqD7Hd5Mf+uehAcr/QjypR+X2SJJvAhsX5R1ohMdD3CzG6PBPB9UJML
	 0f39ymHzaaxynOnYOsxmfbaF7B+Hwl1OBN2BrqwbWQlHCYKE0al6KVVTZMkzGngQo+
	 NJLtdK6U5s5k43cvdrQhCKUduG4kCGArS+4iGLLY71sp/4VrqlsZQOmjrquypy1ly0
	 WB+F6al40gWRidVPfXrF7F0iK1WQgR+WsdYinBIx8nZ4G4G0S7Do/USjuuB8T2A85z
	 2ntOuiBU6VvAw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 31BAC4035D; Fri, 20 Oct 2023 17:21:48 -0300 (-03)
Date: Fri, 20 Oct 2023 17:21:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, Aditya Gupta <adityag@linux.ibm.com>,
	jolsa@kernel.org, linux-perf-users@vger.kernel.org,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v5 0/4] Introduce perf check subcommand
Message-ID: <ZTLhXEQ1DbeI4rk1@kernel.org>
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

Testing/reviewing it now.

- Arnaldo
 
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
