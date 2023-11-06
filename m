Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774A522D
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Nov 2023 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBZGk+jH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B19DC433C8;
	Mon,  6 Nov 2023 21:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699307052;
	bh=LBKwZloHD3GlayFamfjU11QjRAvkSMi0DO66ETP6VBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBZGk+jHlSNRYyKPzYEBn8MZwAtY0h62KDpzbvbBGFbIDwl2NxG8o1SziCxcT7xLo
	 npP5TdUrURwGEsg9Tjw2IxthXRhgC2+bU8ndf6VVhPaAvIpUkD2WYdzIqtC7X1GFID
	 9Fi35ty1X/dqWYxGtxY2Bq4sTSqXw9zuJii5sqtprVdTiZ5wreW6VfS0hWrX1gXlE6
	 gqv0aI+EHw9LwBc2VdiM2fBlAZ3usPWPsEjrbH7aWxEaVkUw4G/VIHLPIMPEIetfHi
	 j+Cj3UtmAWRf7HJVh04RgX3IXn+Ns2jK5PKS2xa5wdPYS5wfIeEBobeid96nTYCGWV
	 r1zeDkDjJlswA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id F254F4035D; Mon,  6 Nov 2023 18:44:09 -0300 (-03)
Date: Mon, 6 Nov 2023 18:44:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: James Clark <james.clark@arm.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Disha Goel <disgoel@linux.vnet.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>
Subject: Re: [PATCH 1/3] perf tests test_arm_coresight: Fix the shellcheck
 warning in latest test_arm_coresight.sh
Message-ID: <ZUleKdUrbR9oFVW4@kernel.org>
References: <20230929041133.95355-1-atrajeev@linux.vnet.ibm.com>
 <20230929041133.95355-2-atrajeev@linux.vnet.ibm.com>
 <552cbde4-6077-d5a4-251e-6c77786e1b31@arm.com>
 <3AFF6660-5A0E-4028-BA5A-D18CBAC8E1A4@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3AFF6660-5A0E-4028-BA5A-D18CBAC8E1A4@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com

Em Thu, Oct 05, 2023 at 02:24:15PM +0530, Athira Rajeev escreveu:
> > On 05-Oct-2023, at 1:50 PM, James Clark <james.clark@arm.com> wrote:
> > On 29/09/2023 05:11, Athira Rajeev wrote:
> >> Running shellcheck on tests/shell/test_arm_coresight.sh
> >> throws below warnings:
> >> 
> >> In tests/shell/test_arm_coresight.sh line 15:
> >> cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
> >>                  ^--^ SC2061: Quote the parameter to -name so the shell won't interpret it.
> >> 
> >> In tests/shell/test_arm_coresight.sh line 20:
> >> if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
> >>                              ^-- SC2166: Prefer [ p ] && [ q ] as [ p -a q ] is not well defined
> >> 
> >> This warning is observed after commit:
> >> "commit bb350847965d ("perf test: Update cs_etm testcase for Arm ETE")"
> >> 
> >> Fixed this issue by using quoting 'cpu*' for SC2061 and
> >> using "&&" in line number 20 for SC2166 warning
> >> 
> >> Fixes: bb350847965d ("perf test: Update cs_etm testcase for Arm ETE")
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> ---
> >> tools/perf/tests/shell/test_arm_coresight.sh | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> >> index fe78c4626e45..f2115dfa24a5 100755
> >> --- a/tools/perf/tests/shell/test_arm_coresight.sh
> >> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> >> @@ -12,12 +12,12 @@
> >> glb_err=0
> >> 
> >> cs_etm_dev_name() {
> >> - cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name cpu* -print -quit)
> >> + cs_etm_path=$(find  /sys/bus/event_source/devices/cs_etm/ -name 'cpu*' -print -quit)
> >> trcdevarch=$(cat ${cs_etm_path}/mgmt/trcdevarch)
> >> archhver=$((($trcdevarch >> 12) & 0xf))
> >> archpart=$(($trcdevarch & 0xfff))
> >> 
> >> - if [ $archhver -eq 5 -a "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
> >> + if [ $archhver -eq 5 ] && [ "$(printf "0x%X\n" $archpart)" = "0xA13" ] ; then
> >> echo "ete"
> >> else
> >> echo "etm"
> > 
> > 
> > Reviewed-by: James Clark <james.clark@arm.com>

Some are not applying, even after b4 picking up v2

Total patches: 3
---
Cover: ./v2_20231013_atrajeev_fix_for_shellcheck_issues_with_latest_scripts_in_tests_shell.cover
 Link: https://lore.kernel.org/r/20231013073021.99794-1-atrajeev@linux.vnet.ibm.com
 Base: not specified
       git am ./v2_20231013_atrajeev_fix_for_shellcheck_issues_with_latest_scripts_in_tests_shell.mbx
⬢[acme@toolbox perf-tools-next]$        git am ./v2_20231013_atrajeev_fix_for_shellcheck_issues_with_latest_scripts_in_tests_shell.mbx
Applying: tools/perf/tests Ignore the shellcheck SC2046 warning in lock_contention
error: patch failed: tools/perf/tests/shell/lock_contention.sh:33
error: tools/perf/tests/shell/lock_contention.sh: patch does not apply
Patch failed at 0001 tools/perf/tests Ignore the shellcheck SC2046 warning in lock_contention
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf-tools-next]$ git am --abort
⬢[acme@toolbox perf-tools-next]$
