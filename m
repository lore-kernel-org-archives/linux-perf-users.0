Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C151F76A5;
	Wed, 12 Feb 2025 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386186; cv=none; b=PAcjPjef0j95fvoSWKhJrzsscGQXhjKknpzQ7N+eCQS9KuNmlg7p7lkc57rX4Tp011GuRcEBotyLUEJe6ImzHtQ8iXUlOtMeneLOAJosZUfa8+qRYZCWQtrpss0t901XQpoT+z/CZMXdzRhacI3qyRH5EXhEmjH55lE4bcSajnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386186; c=relaxed/simple;
	bh=RqfhnIV3YItta8b9FGmPv++jTM3WitRHhMgMDo7CxQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNcPuL9WtBuqiVrnCAeDP58+uOEqMWwl3BwlWfQzJHIdpzq9YNIgQeGwmDjjAAFSEDDDhGaovTsjcLvLHCRKw2FvD8Cxd9Udy2j11PXyzGZdQSGQyHKs9SoMkwoGaInES1win9ISMyjtMkptpg5YRntZWvxhErcElYdsk65zsXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udY+qVWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udY+qVWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89A5C4CEDF;
	Wed, 12 Feb 2025 18:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739386186;
	bh=RqfhnIV3YItta8b9FGmPv++jTM3WitRHhMgMDo7CxQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udY+qVWHqcMx0ldKogKNsjtHDvADgFstVaxgyau4tRgQOSiO5HFIGwkL0u3xIerIO
	 o159wFltZ+d+L6V3OprpIFU8/qoWqjmlEsHlEQUWaskVNm3vrU+iHPqbhKsvlEyLaG
	 gQ9E3kSrcYUf54KYV29fNvEcrAjFdLl76UKeGyS/Ar2/PTGWS0DCJUKgk2EajzZMmX
	 Gsx1AKRs7gSJ60xk2MaE9MpHHn8/CfV0P50gc1IQMMaPrVF1UNppNja5JD9cn8dJxo
	 2ZCNmWHvSaayvy0o8AB+/NwzU7d1n9JKSgcT6UEvVtOQE17W84e+R4YmYCDZqvpqdX
	 sXVLa+78gXsyg==
Date: Wed, 12 Feb 2025 10:49:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/4] perf trace: Add --summary-mode option
Message-ID: <Z6ztSE_yo2t28w45@google.com>
References: <20250205205443.1986408-1-namhyung@kernel.org>
 <CAH0uvoinT1ZH3Cifj_skJOjfKrvQ8jdbU_3gFp21eD4PwGOwkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoinT1ZH3Cifj_skJOjfKrvQ8jdbU_3gFp21eD4PwGOwkQ@mail.gmail.com>

On Fri, Feb 07, 2025 at 09:25:02PM -0800, Howard Chu wrote:
> Hello Namhyung,
> 
> On Wed, Feb 5, 2025 at 12:54 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > I've realized that perf trace shows system call summary at the end for
> > each thread.  But sometimes users want to see the global whole system
> > summary or statistics instead.
> >
> > So I've added --summary-mode option like below:
> >
> >     $ sudo ./perf trace -as --summary-mode=total sleep 1
> >
> >      Summary of events:
> >
> >      total, 21580 events
> >
> >        syscall            calls  errors  total       min       avg       max       stddev
> >                                          (msec)    (msec)    (msec)    (msec)        (%)
> >        --------------- --------  ------ -------- --------- --------- ---------     ------
> >        epoll_wait          1305      0 14716.712     0.000    11.277   551.529      8.87%
> >        futex               1256     89 13331.197     0.000    10.614   733.722     15.49%
> >        poll                 669      0  6806.618     0.000    10.174   459.316     11.77%
> >        ppoll                220      0  3968.797     0.000    18.040   516.775     25.35%
> >        clock_nanosleep        1      0  1000.027  1000.027  1000.027  1000.027      0.00%
> >        epoll_pwait           21      0   592.783     0.000    28.228   522.293     88.29%
> >        nanosleep             16      0    60.515     0.000     3.782    10.123     33.33%
> >        ioctl                510      0     4.284     0.001     0.008     0.182      8.84%
> >        recvmsg             1434    775     3.497     0.001     0.002     0.174      6.37%
> >        write               1393      0     2.854     0.001     0.002     0.017      1.79%
> >        read                1063    100     2.236     0.000     0.002     0.083      5.11%
> >        ...
> >
> > Also it changes internal data structure to hash table to track
> > statistics of syscalls.  And removes the rb_resort code.
> >
> > v3 changes)
> > * Add Acked-by from Howard
> > * Update commit messages  (Ian)
> 
> Sorry for the delay.
> 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks for your review!

Arnaldo and Ian, are you ok with this?

Thanks,
Namhyung

> >
> > v2 changes)
> > * Rebase to current perf-tools-next
> > * Fix some style issues  (Howard)
> > * Rename to --summary-mode  (Howard)
> >
> > Thanks,
> > Namhyung
> >
> >
> > Namhyung Kim (4):
> >   perf trace: Allocate syscall stats only if summary is on
> >   perf trace: Convert syscall_stats to hashmap
> >   perf tools: Get rid of now-unused rb_resort.h
> >   perf trace: Add --summary-mode option
> >
> >  tools/perf/Documentation/perf-trace.txt |   4 +
> >  tools/perf/builtin-trace.c              | 247 +++++++++++++++++++-----
> >  tools/perf/util/rb_resort.h             | 146 --------------
> >  3 files changed, 203 insertions(+), 194 deletions(-)
> >  delete mode 100644 tools/perf/util/rb_resort.h
> >
> > --
> > 2.48.1.502.g6dc24dfdaf-goog
> >
