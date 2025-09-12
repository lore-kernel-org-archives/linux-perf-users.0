Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7227280C;
	Fri, 12 Sep 2025 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757714035; cv=none; b=vBnl27MbQyyBEiX6ZCUU6hb63eMbe7/6u0FXFaqOo/Z2Qr8qVWvpsgaap6IjVMH6vAOFI3XM+pAkznArPReJCkrq32OfmEFlbwb2qnoXXf/CXmPMmYGka5wdYlTMfEaai+RKxlGDcejRT4pkFHNduokfmLm8S1RJqIlz8q1OGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757714035; c=relaxed/simple;
	bh=mykHhQVHqrms4qZ0KQZgmzjgGYzKjRLF6ha69hI8SWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQskHvKwiqVFHPuGSViuYmR9sQAaHHT37tWvZLHFENnjYl8+lK5byykcb58j+8LTA3rLjvNt9Q097UjDNXKPr5TswFq0m2gE5L8Jo7NqxBroBXtZJwxNvvbRzGpG0gGPQEwX915hw4Otc/gW0NatGSOHvhwd4ottqkHdFa0P9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISdB5KPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISdB5KPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E2EC4CEF1;
	Fri, 12 Sep 2025 21:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757714033;
	bh=mykHhQVHqrms4qZ0KQZgmzjgGYzKjRLF6ha69hI8SWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISdB5KPOKXAd2J42i5oSdkWy6GSXhNZnHrTXkqsfKgLq7Y0+hlKqeTByly5ptmfY5
	 wM3PZIWHVAqB6qEzFmMYIqrwYh1YXbhe0QmjjYO2nChA2avytCLbuKaF6ozqswt0mD
	 fXr2h6W17QYxo0f3VM4S12zj76isnAGMXoBe19/1Lt2EkWUT88Q/hDrGAi1/k0hYGl
	 PiG4F7LqE+tGa0wG8g/qIbH54i+Q+cLiEwYT9WNeRdMiyHXN2/ZUTSw62R8xiVKSWT
	 cwx/XcjCXcK2U+RXs6AfSiNHTXY64VpKbWOa7h0kv2ojRZ/z/XF8+4Ca/n2WnO4PHd
	 rP/wv9gRCHEAw==
Date: Fri, 12 Sep 2025 18:53:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Collin Funk <collin.funk1@gmail.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: AMD IBS swfilt skip kernel tests if
 paranoia is >1
Message-ID: <aMSWbjo-qY7JYAoY@x1>
References: <20250908221727.3635572-1-irogers@google.com>
 <aL9oL8aAMam676Ra@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL9oL8aAMam676Ra@google.com>

On Mon, Sep 08, 2025 at 04:35:11PM -0700, Namhyung Kim wrote:
> Hi Ian,
> 
> On Mon, Sep 08, 2025 at 03:17:27PM -0700, Ian Rogers wrote:
> > If not root and the perf_event_paranoid is set >1 swfilt will fail to
> > open the event failing the test. Add check to skip the test in that
> > case.
> 
> Thanks for the fix!

I'm taking this as an Acked-by, ok?

- Arnaldo
 
> > 
> > Some corrections to the kernel/user sample count test.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/amd-ibs-swfilt.sh | 57 +++++++++++++++++-------
> >  1 file changed, 41 insertions(+), 16 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
> > index 7045ec72ba4c..80d5bf8db40c 100755
> > --- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
> > +++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
> > @@ -1,6 +1,10 @@
> >  #!/bin/bash
> >  # AMD IBS software filtering
> >  
> > +ParanoidAndNotRoot() {
> > +  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
> > +}
> > +
> >  echo "check availability of IBS swfilt"
> >  
> >  # check if IBS PMU is available
> > @@ -16,6 +20,7 @@ if [ ! -f /sys/bus/event_source/devices/ibs_op/format/swfilt ]; then
> >  fi
> >  
> >  echo "run perf record with modifier and swfilt"
> > +err=0
> >  
> >  # setting any modifiers should fail
> >  perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
> > @@ -31,11 +36,17 @@ if [ $? -ne 0 ]; then
> >      exit 1
> >  fi
> >  
> > -# setting it with swfilt=1 should be fine
> > -perf record -B -e ibs_op/swfilt=1/k -o /dev/null true
> > -if [ $? -ne 0 ]; then
> > -    echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_user"
> > -    exit 1
> > +if ! ParanoidAndNotRoot 1
> > +then
> > +    # setting it with swfilt=1 should be fine
> > +    perf record -B -e ibs_op/swfilt=1/k -o /dev/null true
> > +    if [ $? -ne 0 ]; then
> > +        echo "[FAIL] IBS op PMU cannot handle swfilt for exclude_user"
> > +        exit 1
> > +    fi
> > +else
> > +    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
> > +    err=2
> >  fi
> >  
> >  # check ibs_fetch PMU as well
> > @@ -46,22 +57,36 @@ if [ $? -ne 0 ]; then
> >  fi
> >  
> >  # check system wide recording
> > -perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
> > -if [ $? -ne 0 ]; then
> > -    echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
> > -    exit 1
> > +if ! ParanoidAndNotRoot 1
> > +then
> > +    perf record -aB --synth=no -e ibs_op/swfilt/k -o /dev/null true
> > +    if [ $? -ne 0 ]; then
> > +        echo "[FAIL] IBS op PMU cannot handle swfilt in system-wide mode"
> > +        exit 1
> > +    fi
> > +else
> > +    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
> > +    err=2
> >  fi
> >  
> >  echo "check number of samples with swfilt"
> >  
> > -kernel_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^K)
> > -if [ ${kernel_sample} -ne 0 ]; then
> > -    echo "[FAIL] unexpected kernel samples: " ${kernel_sample}
> > -    exit 1
> > -fi
> > -
> > -user_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^U)
> > +user_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^U)
> 
> I think it should count kernel samples now (with ^K) as it sets 'u'
> modifier (exclude_kernel).
> 
> 
> >  if [ ${user_sample} -ne 0 ]; then
> >      echo "[FAIL] unexpected user samples: " ${user_sample}
> 
> So that it should not have unexpected kernel samples.
> 
> 
> >      exit 1
> >  fi
> > +
> > +if ! ParanoidAndNotRoot 1
> > +then
> > +    kernel_sample=$(perf record -e ibs_fetch/swfilt/k -o- true | perf script -i- -F misc | grep -c ^K)
> > +    if [ ${kernel_sample} -ne 0 ]; then
> > +        echo "[FAIL] unexpected kernel samples: " ${kernel_sample}
> 
> Vice versa.  It should count unexpected user samples from 'k' modifier.
> 
> Thanks,
> Namhyung
> 
> 
> > +        exit 1
> > +    fi
> > +else
> > +    echo "[SKIP] not root and perf_event_paranoid too high for exclude_user"
> > +    err=2
> > +fi
> > +
> > +exit $err
> > -- 
> > 2.51.0.384.g4c02a37b29-goog
> > 
