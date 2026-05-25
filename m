Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFFD1E9B3A;
	Mon, 25 May 2026 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738604; cv=none; b=RkGM4j91I/tiUqQtGg7qKfBhPpCQbh3szpzojr/1mzmXmsZ07sbbf3O+nob0yR1TprS5qmk/CTRTVxO4ei45chG97bFMBtAJfaTl5crHLTnT9Vr9efAP4alxCzbdKLY87cOSy818JFHcE43WFVaMnZM/Jd2MgfgHFNEUcYS13PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738604; c=relaxed/simple;
	bh=joTfKnOmuxnwg5WWaL1gtcIG0oJkrhVT0QMXexRA6i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xda8EwJMHRBFLYDEtdpdgAUMabR4IODTgCndJAoJbtsxcf9+ts339vdFPSXyKorsnDPlKpAIXJGq1femiRmGwPNAx2TnL28nVFAM0vhpfiKWbED78mZukLEimq6C1kBY/svl25m4s9lwSJGK8IKTLqfCaSzvgmgrM3Lg26OUUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdMaeYsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdMaeYsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A85D1F000E9;
	Mon, 25 May 2026 19:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779738602;
	bh=QydPtImZr6UptDPlDEPVVVIvjx89L84YwLG9hcPLssw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fdMaeYscIspUwMJ99J5xZ/jbvU39zpCdJnpwwur+daxJczxSP6W61mqRIIK2q/lbY
	 jH+VedY2sF3hzIo+LSvGchlRDoa96O6BM3KoW+eN6BM0EaDF3KnY0UV3rI+ni2OCah
	 sM0Q0XBBEHMY0mNv0NDA/O5blqBsiwIRNeOAgRM2upw89KmenC+SvWNJGUEiWg4AWW
	 X4hGST3APDKQww9w+yPQNN3wdnygbaQr7f6/q+xUd8lNPkRLv1uAxZCddqgfMQ77Vl
	 9fifl472IIXQh4IlvknBRBbqi97ci3JZ/YjqadAA6MpH/aTkI/rEOwbZSnFI1sbc6D
	 wo2UFXJXaXI7Q==
Date: Mon, 25 May 2026 16:49:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, skanev@google.com
Subject: Re: [PATCH v3 2/2] perf test: Add stat metrics --for-each-cgroup test
Message-ID: <ahSn58YTobyDYr_4@x1>
References: <20260519015108.3094513-1-irogers@google.com>
 <20260519050150.3144907-1-irogers@google.com>
 <20260519050150.3144907-3-irogers@google.com>
 <agv7MMF7AEc_mdCN@z2>
 <CAP-5=fW14n=Po5fOv7nOTUoz2_W0uxU34h5V4uGX2agKqiLT9A@mail.gmail.com>
 <agyZZdFQqedToej1@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agyZZdFQqedToej1@google.com>

On Tue, May 19, 2026 at 10:09:57AM -0700, Namhyung Kim wrote:
> On Tue, May 19, 2026 at 08:13:02AM -0700, Ian Rogers wrote:
> > On Mon, May 18, 2026 at 10:54 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Mon, May 18, 2026 at 10:01:50PM -0700, Ian Rogers wrote:
> > > > +             # Parse each metric line
> > > > +             while read -r line; do
> > > > +                     [ -z "${line}" ] && continue
> > > > +
> > > > +                     local cycles_val
> > > > +                     cycles_val=$(echo "${line}" | cut -d, -f1)
> > > > +
> > > > +                     local event_name
> > > > +                     event_name=$(echo "${line}" | cut -d, -f3)
> > > > +
> > > > +                     # Find corresponding instructions event line
> > > > +                     local inst_event_name
> > > > +                     inst_event_name="${event_name/cpu-cycles/instructions}"
> > > > +                     inst_event_name="${inst_event_name/cycles/instructions}"
> > > > +
> > > > +                     local inst_line
> > > > +                     inst_line=$(echo "${output}" | \
> > > > +                             grep -F ",${cgrp}," | \
> > > > +                             grep -F "${inst_event_name}" || true)
> > > > +
> > > > +                     local inst_val
> > > > +                     inst_val=$(echo "${inst_line}" | cut -d, -f1)
> > > > +
> > > > +                     log_verbose "Cgroup '${cgrp}': event '${event_name}' \
> > > > +val '${cycles_val}', inst event '${inst_event_name}' val '${inst_val}'"

> > > Why not make log_verbose() take multiple arguments and align them
> > > properly?  Maybe you can just use 'echo'?  The same goes to the below
> > > lines.
 
> > This fixes checkpatch warnings on line length and the odd alignment
> > avoids spaces appearing in the output.
 
> How about this?

Ian posted a v4, are you ok with that now, Tested-by or Reviewed-by?

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> diff --git a/tools/perf/tests/shell/stat_metrics_cgrp.sh b/tools/perf/tests/shell/stat_metrics_cgrp.sh
> index d4226ee0ae9801cb..ecb2c053ea5158d4 100755
> --- a/tools/perf/tests/shell/stat_metrics_cgrp.sh
> +++ b/tools/perf/tests/shell/stat_metrics_cgrp.sh
> @@ -7,7 +7,7 @@ set -e
>  test_cgroups=
>  
>  log_verbose() {
> -	echo "$1"
> +	echo "$*"
>  }
>  
>  is_numeric_and_non_zero() {
> @@ -145,22 +145,22 @@ check_metric_reported()
>  				cycles_val=$(echo "${cycles_line}" | cut -d, -f1)
>  			fi
>  
> -			log_verbose "Cgroup '${cgrp}': event '${event_name}' \
> -val '${cycles_val}', inst val '${inst_val}'"
> +			log_verbose "Cgroup '${cgrp}': event '${event_name}'" \
> +				    "val '${cycles_val}', inst val '${inst_val}'"
>  
>  			# Only enforce metric check if both cycles and
>  			# instructions have non-zero numeric counts
>  			if is_numeric_and_non_zero "${cycles_val}" && \
>  			   is_numeric_and_non_zero "${inst_val}"
>  			then
> -				log_verbose "Enforcing metric check for cgroup '${cgrp}' \
> -event '${event_name}'"
> +				log_verbose "Enforcing metric check for cgroup '${cgrp}'" \
> +					    "event '${event_name}'"
>  				# Check for nan or nested in the metric value (7th field)
>  				# Actually we can just check the whole line for simplicity
>  				if echo "${line}" | grep -q -i -E ",nan,|,nested,"
>  				then
> -					echo "FAIL: Invalid metric value (nan/nested) \
> -for cgroup '${cgrp}'"
> +					echo "FAIL: Invalid metric value (nan/nested)" \
> +					     "for cgroup '${cgrp}'"
>  					echo "Line: ${line}"
>  					exit 1
>  				fi
> @@ -173,8 +173,8 @@ for cgroup '${cgrp}'"
>  					exit 1
>  				fi
>  			else
> -				log_verbose "Skipping metric check for cgroup '${cgrp}' \
> -event '${event_name}' (idle or not counted)"
> +				log_verbose "Skipping metric check for cgroup '${cgrp}'" \
> +					    "event '${event_name}' (idle or not counted)"
>  			fi
>  		done <<< "${cgrp_lines}"
>  	done
