Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CF32C67
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Nov 2023 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOhsS+eL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43DAC433C8;
	Wed,  8 Nov 2023 20:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699473880;
	bh=qhUpYSukAlblxid3F/W0xizAg/bkGWOSp+MdQC9RSsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOhsS+eL+8m5YpKIsMJuRqU/oI3wEHeZX8FVzQjzYht3WTCF+HjaZNnZpg18KSKrx
	 2LSA4vsnV+P36SAglTSoapW1iVGGZw0MTTNQI36gSHSqR3lC+4QBqkTsA8Fr/2hKVr
	 /lTSNRK1zWPZXKsFH2uAuEholA8QqAmLkSQHkMLEEIND4R/Q6R1FYHIZ33qucFWYHx
	 ebZAC2fTZx1DjZdSV+iPZSSzCqieNjVTr8v9VOsj/rjjWGRYLPdYCT+oB1eWikVp7S
	 zrTeTu3GHxxbLTAy9BaQdBt4ECZFu4mIhK77l0s2byG2uKjLLmI2eJ5nohfHJ+kWpM
	 J2OpqGZoUqNEg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 7ADD24035D; Wed,  8 Nov 2023 17:04:37 -0300 (-03)
Date: Wed, 8 Nov 2023 17:04:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	James Clark <james.clark@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Disha Goel <disgoel@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/3] perf tests test_arm_coresight: Fix the shellcheck
 warning in latest test_arm_coresight.sh
Message-ID: <ZUvp1YPdOWJcLkyJ@kernel.org>
References: <20230929041133.95355-1-atrajeev@linux.vnet.ibm.com>
 <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
 <552cbde4-6077-d5a4-251e-6c77786e1b31@arm.com>
 <3AFF6660-5A0E-4028-BA5A-D18CBAC8E1A4@linux.vnet.ibm.com>
 <ZUleKdUrbR9oFVW4@kernel.org>
 <8DEA17FB-DC0B-41F9-800D-4B74371F4849@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8DEA17FB-DC0B-41F9-800D-4B74371F4849@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 07, 2023 at 12:08:25PM +0530, Athira Rajeev escreveu:
> > On 07-Nov-2023, at 3:14 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>> Reviewed-by: James Clark <james.clark@arm.com>

> > Some are not applying, even after b4 picking up v2

> > Total patches: 3

> > Cover: ./v2_20231013_atrajeev_fix_for_shellcheck_issues_with_latest_scripts_in_tests_shell.cover
> > Link: https://lore.kernel.org/r/20231013073021.99794-1-atrajeev@linux.vnet.ibm.com
> > Base: not specified
> >       git am ./v2_20231013_atrajeev_fix_for_shellcheck_issues_with_latest_scripts_in_tests_shell.mbx
> > ⬢[acme@toolbox perf-tools-next]$        git am ./v2_20231013_atrajeev_fix_for_shellcheck_issues_with_latest_scripts_in_tests_shell.mbx
> > Applying: tools/perf/tests Ignore the shellcheck SC2046 warning in lock_contention
> > error: patch failed: tools/perf/tests/shell/lock_contention.sh:33
> > error: tools/perf/tests/shell/lock_contention.sh: patch does not apply
> > Patch failed at 0001 tools/perf/tests Ignore the shellcheck SC2046 warning in lock_contention
> > hint: Use 'git am --show-current-patch=diff' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> > ⬢[acme@toolbox perf-tools-next]$ git am --abort
> > ⬢[acme@toolbox perf-tools-next]$
 
> The patch is picked up : https://lore.kernel.org/all/169757198796.167943.10552920255799914362.b4-ty@kernel.org/ .
> Thanks for looking into.

Thanks for checking, my mistake then,

- Arnaldo
