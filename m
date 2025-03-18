Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978BD1FCF47;
	Tue, 18 Mar 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297130; cv=none; b=k7Sr2p1LpYLGEqSPBtCNqNtLPxXmDW7ep2EDNd2lu071aC4bR+0bXIUalFs/UCAyXSpgtE8qmEA4Hfm1DiaKNNyJe4kybw1t+i4roXMhErXx7h5UXZa+92aY5qZAzeIzU0B4p2/vYBqyAFTKGOiOo84eeaHCVoB5QtM9tIDZWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297130; c=relaxed/simple;
	bh=j2Zg/4JEx1lWoxVpbdYsbsU0lPiBAPhAfaR8/wI9JCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK7oZE+Fvv5cBusE9/ozp5egYjy6mxzNe1BQ/uBvWOjZhOu81wUpMUGifTtqDDr3FJKiBr695whUyuGZD9nlIXWFEIOBjS2xNozXpcy/WtlMKeUA/JT7GqFzohN7QR0krR7YABElTyRJOLZXkbsgKxFLElFpd+OVbpgz4XMG8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 420C013D5;
	Tue, 18 Mar 2025 04:25:36 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B0C53F694;
	Tue, 18 Mar 2025 04:25:27 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:25:23 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH v1] perf tests: Harden branch stack sampling test
Message-ID: <20250318112523.GM2487211@e132581.arm.com>
References: <20250312055846.671522-1-irogers@google.com>
 <20250312105450.GN9682@e132581.arm.com>
 <Z9M9gK4VS199CRKh@google.com>
 <20250314091314.GV9682@e132581.arm.com>
 <CAP-5=fWM2hqu02nNyBUBgLu01AC=C7mwxayezzs7frCyAsirPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWM2hqu02nNyBUBgLu01AC=C7mwxayezzs7frCyAsirPg@mail.gmail.com>

On Mon, Mar 17, 2025 at 08:38:44AM -0700, Ian Rogers wrote:

[...]

> On our testing skipped == failed, I can change 2 to 1 above but I'd
> made it 2 as it wasn't clear to me all branch filter types would be
> supported by perf record and skipping/2 was a less terrible error
> message.

My concern is changing from returned val from 1 to 2 will lead to CI
to never report errors.

> I'm keen to land the pulling apart of the perf command from the
> tr/grep as if we hit say an asan error currently that is hidden by
> code like:
> ```
> perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u --
> ${TESTPROG} > /dev/null 2>&1
> ```
> where all the output is sent to /dev/null but the asan error code will
> cause the "set -e" to fail. If this code fails with asan then
> currently the first thing to do is start pulling apart the
> expressions.

Agreed the most part in this patch, except returns err=2 in
test_user_branches() and test_filter().

> Code like:
> ```
> perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' |
> grep '.' > $TMPDIR/perf.script
> ```
> is problematic as again we lose the asan like errors. Running the previous:
> ```
>  if grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$"
> $TMPDIR/perf.script; then
> ```
> could fail because of an unexpected branch filter type, but was
> failing for me just because there were blank or similar lines in the
> output.

I saw you changed the command as:

  tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep '.' | \
      grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$" \
      > "$TMPDIR/perf.script-filtered" || true

This is a good change for me.  After we removed the noises caused by
spaces and empty lines, for an empty script output, I still think we
should report error, as the test fails to capture any branch stack.

> The new code doesn't change this but allows the output to be
> dumped for later diagnostics. The '|| true' in the expression means we
> get to dumping the diagnostics and dump just fail because some
> sub-command mismatched its input.

Yeah, agreed '|| true' is a good improvement.

Thanks,
Leo
