Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523312C46D
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202921; cv=none; b=ggYrj/HG5uokuxOg/FZ3JLpYjPsthr+wVmWlu9BdQLHmAvj0q+KDU3xs5mOgMiHre0Qq+HyMoGnKnRDOFSnlquIu77QZEucas4/mRW9lN2VTLImZl6PE5uv215XDzDWhKJJ8mp87k4eShhCKfYbeMT6OxzEq+t27srTAkzSj4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202921; c=relaxed/simple;
	bh=/YDQ0WxJJklkc+rlfzPXrJClvoOkdo9oLL2pvc+03GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3J8P4cG83ht85OwC+VAl9oIq9vXUvMDeprws/uXe+juIP+lrhJUMJhNFd7t3qh8/VY2PJRjSrEE198bljYhPPNou54+APkA4Kn80UzcANVOgnhPjszVlAKIu23UemDGv4aHQUfYH6fnR1Q5F5vDheYbGQJ7TK/FECbN2irSPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgA6E1mn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgA6E1mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD040C113CC;
	Mon, 15 Apr 2024 17:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713202921;
	bh=/YDQ0WxJJklkc+rlfzPXrJClvoOkdo9oLL2pvc+03GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VgA6E1mnSUxfxETXp+6NaPzZ/yK7QotQ4ElAkGQAE/1tfr3t034fEQFZsWphTMetG
	 FmxY/e8+74lTl0h4v2hSEo5Z5FWZbcFUow4QbUxGWnZVgLd7af1zFzmpNyDUl3p8LF
	 vBXHIyMLXj3ZWjbo0wNwwpIsjT6cRPsmxnVeEKFQNmMEfbzLxlB3kG/EzT4UHtwwuW
	 IP2gMwQKpPxPYoN6iNZXbZkIICfnZwg+y1RGV+2c05jJ1/XOEHlH7OPAjhIG1OGxtg
	 SSNrC8N0CXbEgJ8GtNdR9z7NhXRH2RWXRFH6SOJk5ZMZdRY49kjkan6KDs7KYAnaT0
	 2NIzjX5BsRlHA==
Date: Mon, 15 Apr 2024 14:41:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, mpetlan@redhat.com
Subject: Re: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf
 stat
Message-ID: <Zh1m5jSuhmMkT951@x1>
References: <ZhgpWkUAto8nzvle@x1>
 <20240415094220.11639-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415094220.11639-1-vmolnaro@redhat.com>

On Mon, Apr 15, 2024 at 11:42:20AM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> With the upstream MR !3916 of commit a381bd3615de6 ('powerpc/hv-gpci:

I'm still not finding this commit upstream:

⬢[acme@toolbox perf-tools-next]$ git remote update torvalds
Fetching torvalds
remote: Enumerating objects: 298, done.
remote: Counting objects: 100% (173/173), done.
remote: Compressing objects: 100% (18/18), done.
remote: Total 298 (delta 156), reused 168 (delta 155), pack-reused 125
Receiving objects: 100% (298/298), 208.17 KiB | 859.00 KiB/s, done.
Resolving deltas: 100% (213/213), completed with 71 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
   586b5dfb51b962c1..0bbac3facb5d6cc0  master     -> torvalds/master
 * [new tag]                           v6.9-rc4   -> v6.9-rc4
⬢[acme@toolbox perf-tools-next]$ git show a381bd3615de6
fatal: ambiguous argument 'a381bd3615de6': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$

IS this one:

⬢[acme@toolbox perf-tools-next]$ git log | grep "Fix the H_GET_PERF_COUNTER_INFO hcall return value checks"
      powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks
    powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks
^C
⬢[acme@toolbox perf-tools-next]$

⬢[acme@toolbox perf-tools-next]$ git log | grep -B4 "Fix the H_GET_PERF_COUNTER_INFO hcall return value checks"
      powerpc/fsl: Fix mfpmr build errors with newer binutils
      powerpc/64s: Use .machine power4 around dcbt
      powerpc/64s: Move dcbt/dcbtst sequence into a macro
      powerpc/mm: Code cleanup for __hash_page_thp
      powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks
--
commit ad86d7ee43b22aa2ed60fb982ae94b285c1be671
Author: Kajol Jain <kjain@linux.ibm.com>
Date:   Thu Feb 29 17:58:47 2024 +0530

    powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks
^C
⬢[acme@toolbox perf-tools-next]$

I think it is, now looking at
https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
I see the reference to ad86d7ee43b22aa2ed60fb982ae94b285c1be671

I'm replacing this:

> With the upstream MR !3916 of commit a381bd3615de6 ('powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks')

with:

> With the upstream MR !3916 of commit ad86d7ee43b22aa2 ("powerpc/hv-gpci: Fix the H_GET_PERF_COUNTER_INFO hcall return value checks")

Ok?

- Arnaldo

> Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
> stat for hv_gpci events without required permission set returns an
> error value of -1 to differentiate the output from the unsupported
> events. The stat_all_pmu test was designed in a way, that if any
> command exits with a non-zero value the test exits with an error
> value without any information provided due to the 'set -e' option.
> 
> Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
> event causes failure after the MR as the zero return value was required.
> The issue propagated upstream as the list of the files that affected perf
> did not cover the changed files and was updated after the issue was
> discovered. It was caught by CKI testing where it was triaged to stop
> blocking further MRs, as most of the powerpc machines do not support
> some of the hv_gpci events.
> 
> Remove the 'set -e' option from the test and rework the test case to log
> the status of the event for better maintainability. Instead of exiting
> immediately after 'perf stat' ends with a non-zero value, check the
> return value and output of the 'perf stat' command with the appropriate action.
> 
> Link to the MR !3916 of commit a381bd3615de6:
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916
> 
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/tests/shell/stat_all_pmu.sh | 36 ++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index c77955419173..d9f0d2100baa 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -2,21 +2,35 @@
>  # perf all PMU test
>  # SPDX-License-Identifier: GPL-2.0
>  
> -set -e
>  
>  # Test all PMU events; however exclude parametrized ones (name contains '?')
>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
> -  echo "Testing $p"
> -  result=$(perf stat -e "$p" true 2>&1)
> -  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> -    # We failed to see the event and it is supported. Possibly the workload was
> -    # too small so retry with something longer.
> -    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> -    if ! echo "$result" | grep -q "$p" ; then
> -      echo "Event '$p' not printed in:"
> -      echo "$result"
> -      exit 1
> +  echo -n "Testing event '$p' -- "
> +  stat_output=$(perf stat -e "$p" true 2>&1)
> +  stat_result=$?
> +  if echo "$stat_output" | grep -q "$p"; then
> +    # return value 0 if counters gets printed either if the event is supported or not
> +    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
> +        echo "supported"
> +    elif [ $stat_result -eq 0 ]; then
> +        echo "not supported"
> +    # return value 255 when the required pemission for the event is not set
> +    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
> +        echo "no permission to enable"
> +    # return value 129 when trying to run 'perf stat' with a non-existent event
> +    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
> +        echo "Fail: Bad event name"
> +        echo "$stat_output"
> +        exit 1
> +    else
> +        echo "Fail: Unknown return value $stat_result"
> +        echo "$stat_output"
> +        exit 1
>      fi
> +  else
> +      echo "Fail: Event '$p' not printed in:"
> +      echo "$stat_output"
> +      exit 1
>    fi
>  done
>  
> -- 
> 2.43.0
> 
