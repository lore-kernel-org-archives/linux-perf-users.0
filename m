Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F36A95C
	for <linux-perf-users@vger.kernel.org>; Sat, 18 Jan 2025 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737224150; cv=none; b=L0LwRH7w6fDL3U5hYUMWmTu562g3th+ejwCxRaGktR4UnssFdwhbIGWj87iy8NVs68TZ8WQYzl453iKzUby8Y2cT6uVnh3hzdgx7SYNQ7QO/TD6XY26enl5ZrMj+XGUvurbrvU+VZQI25q/vfp/HkuzUgoLRtRgzR4XS4+Umu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737224150; c=relaxed/simple;
	bh=YZfo/5bDD5rEsw5JLp2uYm6eeZnDRAvH+OxwqAeGg+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUzX73eQavDW7oW1tBhI7hiMIgMC7uX5palD22z0IOY45+L4o/rayQ+9o3SCR/DeOJJMZunKAdYDT7lOK+GZQ65uqbsSzfGXtEB7q53vHG9RgZuPe1vOeSFOhJONBeW/3dFwbBB0zu4Ibwv/MoTq0Paky9PyNcyCu7PdV1G0XoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9egeTMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9egeTMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F127C4CED1;
	Sat, 18 Jan 2025 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737224149;
	bh=YZfo/5bDD5rEsw5JLp2uYm6eeZnDRAvH+OxwqAeGg+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9egeTMD2n81Rr+NB+uYXV35B6lQ2tbM09p6XliCwPWj8ltnBSZsWwQuvQY9FlvT2
	 +sP3yfY+ONKVZRls6CZmPWJTJBZA7L8jrj2EzvW0WKeLmRDvGjJ8+krX8wXrV3xV99
	 Kuy1OA8NpkkyB1Bc6LvJQY8/fs+DZTlxMaZOu+wI8EQym88OamDo+epsqVqtJ4WlC1
	 pbnM3nYXYdV7O6dN34AUEbnXfM+/qMVIV4RLY8R2IKgSeR9cAiZ239ih/slhCxxgPY
	 LUJHYy5D7zAVc1Pbr0YGOEGX2RvLFxfKSRIqaBLYl+RM+FClZxksDVjWJ5/TnHeJyB
	 BGoSpodA8gnog==
Date: Sat, 18 Jan 2025 10:15:47 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com, qzhao@redhat.com
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat'
 result
Message-ID: <Z4vv0_-GP5bbNPAj@google.com>
References: <20241122231233.79509-1-vmolnaro@redhat.com>
 <1eeb7a39-8c75-4bc3-8be6-d3d1fc0e1a61@redhat.com>
 <8f62887e-f3c5-4b43-8c77-897564dc971e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f62887e-f3c5-4b43-8c77-897564dc971e@redhat.com>

Hello,

On Thu, Jan 16, 2025 at 01:31:21PM +0100, Veronika Molnarova wrote:
> 
> 
> On 12/10/24 16:20, Veronika Molnarova wrote:
> > 
> > 
> > On 11/23/24 00:12, vmolnaro@redhat.com wrote:
> >> From: Veronika Molnarova <vmolnaro@redhat.com>
> >>
> >> Test case "stat_all_pmu.sh" is not correctly checking 'perf stat' output
> >> due to a poor design. Firstly, having the 'set -e' option with a trap
> >> catching the sigexit causes the shell to exit immediately if 'perf stat' ends
> >> with any non-zero value, which is then caught by the trap reporting an
> >> unexpected signal. This causes events that should be parsed by the if-else
> >> statement to be caught by the trap handler and are reported as errors:
> >>
> >>     $ perf test -vv "perf all pmu"
> >>     Testing i915/actual-frequency/
> >>     Unexpected signal in main
> >>     Error:
> >>     Access to performance monitoring and observability operations is limited.
> >>
> >> Secondly, the if-else branches are not exclusive as the checking if the
> >> event is present in the output log covers also the "<not supported>"
> >> events, which should be accepted, and also the "Bad name events", which
> >> should be rejected.
> >>
> >> Remove the "set -e" option from the test case, correctly parse the
> >> "perf stat" output log and check its return value. Add the missing
> >> outputs for the 'perf stat' result and also add logs messages to
> >> report the branch that parsed the event for more info.
> > 
> > Hi Ian,
> > 
> > is there anything that I am missing? If so would be great to know the idea
> > of your patch. This issue is getting quite old so would be great to get a proper
> > fix together.
> > 
> > Thanks,
> > Veronika
> 
> Hello,
> 
> just wanted to ping the patch. Would be great to sort it out and close the issue.

Ian, are you ok with this?

Thanks,
Namhyung
 
> >>
> >> Fixes: 7e73ea40295620e7 ("perf test: Ignore security failures in all PMU test")
> >> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> >> ---
> >>  tools/perf/tests/shell/stat_all_pmu.sh | 48 ++++++++++++++++++--------
> >>  1 file changed, 34 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> >> index 8b148b300be1131e..9c466c0efa857fc2 100755
> >> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> >> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> >> @@ -2,7 +2,6 @@
> >>  # perf all PMU test (exclusive)
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  
> >> -set -e
> >>  err=0
> >>  result=""
> >>  
> >> @@ -16,34 +15,55 @@ trap trap_cleanup EXIT TERM INT
> >>  # Test all PMU events; however exclude parameterized ones (name contains '?')
> >>  for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g')
> >>  do
> >> -  echo "Testing $p"
> >> -  result=$(perf stat -e "$p" true 2>&1)
> >> -  if echo "$result" | grep -q "$p"
> >> +  echo -n "Testing $p -- "
> >> +  output=$(perf stat -e "$p" true 2>&1)
> >> +  stat_result=$?
> >> +  if echo "$output" | grep -q "$p"
> >>    then
> >>      # Event seen in output.
> >> -    continue
> >> -  fi
> >> -  if echo "$result" | grep -q "<not supported>"
> >> -  then
> >> -    # Event not supported, so ignore.
> >> -    continue
> >> +    if [ $stat_result -eq 0 ] && ! echo "$output" | grep -q "<not supported>"
> >> +    then
> >> +      # Event supported.
> >> +      echo "supported"
> >> +      continue
> >> +    elif echo "$output" | grep -q "<not supported>"
> >> +    then
> >> +      # Event not supported, so ignore.
> >> +      echo "not supported"
> >> +      continue
> >> +    elif echo "$output" | grep -q "No permission to enable"
> >> +    then
> >> +      # No permissions, so ignore.
> >> +      echo "no permission to enable"
> >> +      continue
> >> +    elif echo "$output" | grep -q "Bad event name"
> >> +    then
> >> +      # Non-existent event.
> >> +      echo "Error: Bad event name"
> >> +      echo "$output"
> >> +      err=1
> >> +      continue
> >> +    fi
> >>    fi
> >> -  if echo "$result" | grep -q "Access to performance monitoring and observability operations is limited."
> >> +
> >> +  if echo "$output" | grep -q "Access to performance monitoring and observability operations is limited."
> >>    then
> >>      # Access is limited, so ignore.
> >> +    echo "access limited"
> >>      continue
> >>    fi
> >>  
> >>    # We failed to see the event and it is supported. Possibly the workload was
> >>    # too small so retry with something longer.
> >> -  result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> >> -  if echo "$result" | grep -q "$p"
> >> +  output=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> >> +  if echo "$output" | grep -q "$p"
> >>    then
> >>      # Event seen in output.
> >> +    echo "supported"
> >>      continue
> >>    fi
> >>    echo "Error: event '$p' not printed in:"
> >> -  echo "$result"
> >> +  echo "$output"
> >>    err=1
> >>  done
> >>  
> 
