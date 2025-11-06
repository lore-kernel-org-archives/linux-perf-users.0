Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2D1AA7BF;
	Thu,  6 Nov 2025 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408221; cv=none; b=hywQJbPqaZp24sbORS3FFrIhkIR0nAumPLfPC57Y4/FbmHIFnXoA+YdvqVAVMmwOtn8+JnxyFFuJ72gpjOE4Bzkji4QdaM6kCtZgn/ukcFPJCfuh6TCT4gYISQTWGq6iaZbc8ocrE838JbVU4NhL38krYFr2nonu9FO1h+dKhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408221; c=relaxed/simple;
	bh=gXgFm0nmB0YJ5yu1Fa9yesgn0tHuol5VteV6hWKXbtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQG1GrHP1Y3MbGDqRVUxilkzcXx2Xfie2KFFsz9vYf9PbPp7DMAtXJX2NlW7FxMQw9OFiCRR/R+gXuQw+qQCDCcllIGgVZ3f4vW964wXxXd2ZPhYsgPsVK/rnAyRbobsr3RXCUtgjAJ0RQzRNwfxiRlqQOALz5j0sXUoAgL4Vbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9QWCuL3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9QWCuL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5A1C4CEF7;
	Thu,  6 Nov 2025 05:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762408220;
	bh=gXgFm0nmB0YJ5yu1Fa9yesgn0tHuol5VteV6hWKXbtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9QWCuL3sJU5c1A7rBLayKmIjalVa9RTC7+SvjXo7j3b47f+rVt63Xi5ew6bw3WVf
	 ezfkuqmOLqaPb1SXyxB+p0A/MlmV8rtGi2ozdErE3WlFJA0npklQCwWX7DnLPpjXXU
	 rPqBNjGew61aVohh3JIq/OkzWKKypytCUS7ovqZeT8xlsih0FB5OOF27znyzltb8pt
	 Y2EoVf3KCqo8u6ADK7guUbhGeR2LhbaI0GHkBzwubtCdgQntTwHOSgDnBqGhHJyqVJ
	 dgMHElY4qCOh7218LSWOr+A/AAJumrtOCdyt0PBDybUiR7Mnw1WlpBX+OXMU7NV2Lu
	 ABk5pQgZOvrhw==
Date: Wed, 5 Nov 2025 21:50:18 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Add test that command line period
 overrides sysfs/json values
Message-ID: <aQw3GqjU4GRLfjIF@google.com>
References: <20251029222638.816100-1-irogers@google.com>
 <20251029222638.816100-2-irogers@google.com>
 <aQl06yRnXvdBEkJ4@google.com>
 <CAP-5=fWtixi8ykDp_BO1nz_yj_1wZfUUWrCVb+6WbVE7vON6Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWtixi8ykDp_BO1nz_yj_1wZfUUWrCVb+6WbVE7vON6Eg@mail.gmail.com>

On Mon, Nov 03, 2025 at 09:22:00PM -0800, Ian Rogers wrote:
> On Mon, Nov 3, 2025 at 7:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Oct 29, 2025 at 03:26:38PM -0700, Ian Rogers wrote:
> > > The behavior of weak terms is subtle, add a test that they aren't
> > > accidentally broken.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/shell/record_weak_term.sh | 25 ++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/record_weak_term.sh
> > >
> > > diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/tests/shell/record_weak_term.sh
> > > new file mode 100755
> > > index 000000000000..7b747b383796
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/record_weak_term.sh
> > > @@ -0,0 +1,25 @@
> > > +#!/bin/bash
> > > +# record weak terms
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Test that command line options override weak terms from sysfs or inbuilt json.
> > > +set -e
> > > +
> > > +shelldir=$(dirname "$0")
> > > +# shellcheck source=lib/setup_python.sh
> > > +. "${shelldir}"/lib/setup_python.sh
> > > +
> > > +
> > > +event=$(perf list --json | $PYTHON -c "import json,sys; next((print(e['EventName']) for e in json.load(sys.stdin) if e.get('Encoding') and 'period=' in e.get('Encoding')))")
> >
> > This line is too long
> 
> Is there a good way to split such a line?

Wouldn't this work?

  event=$(perf list --json | python -c '
  import sys, json
  for e in json.load(sys.stdin):
    if e.get("Encoding") and "period=" in e.get("Encoding"):
      print(e["EventName"])')

> 
> > and needs some explanation like what's like the original text and what it does.
> 
> I thought that was covered in the "if" below:

Yeah, but I think it's useful to have an example JSON text.

Thanks,
Namhyung

> 
> > > +if [[ "$?" != "0" ]]
> > > +then
> > > +  echo "No sysfs/json events with inbuilt period."
> > > +  exit 2
> > > +fi
> 
> Thanks,
> Ian
> 
> > > +
> > > +if ! perf record -c 1000 -vv -e "$event" -o /dev/null true 2>&1 | \
> > > +  grep -q -F '{ sample_period, sample_freq }   1000'
> > > +then
> > > +  echo "Unexpected verbose output and sample period"
> > > +  exit 1
> > > +fi
> > > +exit 0
> > > --
> > > 2.51.1.851.g4ebd6896fd-goog
> > >
