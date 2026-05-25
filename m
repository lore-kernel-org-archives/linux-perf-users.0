Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B02032D;
	Mon, 25 May 2026 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740265; cv=none; b=jR17J0fG5K/iElqg+2vDk404UkJtTPfCWPVs8Zns7Y6HPUiRDqHE7xTk3kIvkmoEqMiLfghfzu8flhQAoPD6fFJM4RCl0qEtwT5qSwwxSvKLo4LK0+h8LIhabIkKBv2dFQV372a+CjYIWKL8oFC0YxKisDqQ6nFGTxRaBbSYeTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740265; c=relaxed/simple;
	bh=aEqHNd0xiFhhf7RdCFmjZtE4wrRTz95UByr9QwBJry8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8luc4R7ZLygn9IGv1p6DTenGR7KK5excQCERYmjEInLQuvaVJ9lDO6/Huaa9apyzKIbYvpb7Ukn3yRhlMEci2xk4M85GGRupxO3Ereaw6cuZbT8rzwtE2ehUbg1vtt7Ku8GJLt1sj9GGZUzX00+4cQLsr8YP5UGtksmfZvd8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLnC2Gxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLnC2Gxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B441F000E9;
	Mon, 25 May 2026 20:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779740264;
	bh=/SFhSJg3I0yWRV11t8AuSF99CxN+vX+ywiFBDw5lm4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QLnC2GxzTRKD+Pl4uQ7YxwR4xoZBwOfsUV0Vk9keuLbcjluZK9bKvOVBNKrfiC2J8
	 m4FCU5n3AJd+GUDmQeH6oOiEwDMfBIpwN5E3Ukkd1/D1OuIcAv2OTzfmhLrCVEuuvk
	 Ji+wjxOJzq2yv1YSOBUhbFLHjttzK/wyzDNZUKdF4+0er6hruuO1jvTi42ObwLZM37
	 OP6DvxJVZeu8RdVYeS4IL7YgqGpdIdpFxXFpGp40gRuj+eMDKVbet7+UuybQocXtZl
	 EgJz4KkXyPT/gKWJrvuAUgoKiMApCXLW3zMz21cSgC0/sRiykpRQUZa/Xh4V2r+rc8
	 2EaMj22jcCPGg==
Date: Mon, 25 May 2026 17:17:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com,
	alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, leo.yan@linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v9 00/23] perf python: Modernize and extend Python API
 (Phase 1)
Message-ID: <ahSuZCJCQa4tE5aN@x1>
References: <20260428071903.1886173-1-irogers@google.com>
 <20260522220435.2378363-1-irogers@google.com>
 <ahStntuCibNk-IjO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahStntuCibNk-IjO@x1>

On Mon, May 25, 2026 at 05:14:25PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, May 22, 2026 at 03:04:11PM -0700, Ian Rogers wrote:
> > This series takes a different approach with some initial implementation posted
> > as an RFC last October:
> > https://lore.kernel.org/linux-perf-users/20251029053413.355154-1-irogers@google.com/
> > with the motivation coming up on the mailing list earlier:
> > https://lore.kernel.org/lkml/CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com/

> > The ultimate goal is to remove the embedded libpython and libperl support from
> > perf entirely, expanding the existing perf Python module to provide full access
> > to perf data files and events, allowing scripts to be run as standalone Python
> > applications.
 
> I tried applying it now and got this:
 
> Cover: ./v9_20260522_irogers_perf_python_modernize_and_extend_python_api_phase_1.cover
>  Link: https://lore.kernel.org/r/20260522220435.2378363-1-irogers@google.com
>  Base: not specified
>        git am ./v9_20260522_irogers_perf_python_modernize_and_extend_python_api_phase_1.mbx
> ⬢ [acme@toolbx perf-tools-next2]$        git am ./v9_20260522_irogers_perf_python_modernize_and_extend_python_api_phase_1.mbx
> Applying: perf arch arm: Sort includes and add missed explicit dependencies
> Applying: perf arch x86: Sort includes and add missed explicit dependencies
> Applying: perf tests: Sort includes and add missed explicit dependencies
> Applying: perf script: Sort includes and add missed explicit dependencies
> Applying: perf util: Sort includes and add missed explicit dependencies
> error: patch failed: tools/perf/util/evsel.c:11
> error: tools/perf/util/evsel.c: patch does not apply
> Patch failed at 0005 perf util: Sort includes and add missed explicit dependencies
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> ⬢ [acme@toolbx perf-tools-next2]$ git am --abort
> ⬢ [acme@toolbx perf-tools-next2]$ git diff
> ⬢ [acme@toolbx perf-tools-next2]$
 
> I agree with the intent and plan on reviewing and testing it.

What I have now is at tmp.perf-tools-next if you wish to rebase from
there,

Regards,

- Arnaldo
