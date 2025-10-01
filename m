Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86C2AF03;
	Wed,  1 Oct 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326144; cv=none; b=kKaRtwfA28ytdSxz5t6lVu3nMojgnnTQtHIS0gj+2SJzI+bYUvZtfOiZJqgPQ325yHDnGFr5W6T1vQCp0XtAj9KTPBXm8v7QFrvRhibA/bYfz94gV/jM36y2Le7qZoDwTEVqIvUSjPXyu6LPuO5DI22guSIVcbd/Kg6Zym/kfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326144; c=relaxed/simple;
	bh=6r6YOlUxj5YAN+NhCn8IqrSm1p7zuCz2GYOFvW9fZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDEWPM+w1Ef4ZoH2Pv3xh+rFhJBaS28Du5IiAelfFn9pIat0nN3wdDO0PgBxjnWppnXzwVm4NV7Nn020/bu4no7sfj+Mb0KkQ9NWJDMA5iCDbxQFj27qGqN5wbpEOUvYG2mv9ZDXktHoNXL2NSrurqtsPXGgfFAOFQmYW5Owoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Moe/CVMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Moe/CVMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9A8C116D0;
	Wed,  1 Oct 2025 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759326143;
	bh=6r6YOlUxj5YAN+NhCn8IqrSm1p7zuCz2GYOFvW9fZ0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Moe/CVMHHxcX6oLaZPOLoyMu1keGZaqnXktmZdTKzepJHId0uwUn36rr9EIbrv4pZ
	 yPOT/ZTEgWAg63poFK/D7hRzb4tfDCNItxVMo6g1YI2oXrW4y6XS4AC6mio2VIQxGs
	 PlO0GneqWSpZDFwH3MrANbKWZSBdTmiFsNlYuuJkW10UkRMWpu6ZUlWmoScKOX5Y37
	 O+FVyvpCFv/Ldp8y9QmxI5B5H+gSA1hfN5TycrSSvgs91tV7CMt7OzWjwjsrUnTypD
	 GKjeH+qiJQoBWbUhuimhgljDsX8NHw4fL4fatFnPrtNuvLEdUvixUkZlhAyyjHWvvn
	 1ZQrTlD5i1wVA==
Date: Wed, 1 Oct 2025 10:42:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
Message-ID: <aN0vu4yoVWjmTbtJ@x1>
References: <20250903184248.695267-1-irogers@google.com>
 <CAP-5=fV-3d1EzYfZq6s9M2NrLFFVOrWOTx_k5tByScA4Sfqq-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV-3d1EzYfZq6s9M2NrLFFVOrWOTx_k5tByScA4Sfqq-g@mail.gmail.com>

On Tue, Sep 30, 2025 at 01:02:55PM -0700, Ian Rogers wrote:
> On Wed, Sep 3, 2025 at 11:42 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The 'import perf' test needs to set up a path to the python module as
> > well as to know the python command to invoke. These are hard coded at
> > build time to be build a directory and the python used in the build,
> > which is less than desirable. Avoid the hard coded values by reusing
> > the existing shell script python setup and determine a potential built
> > python module via the path of the perf executable.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

There is another patch in this area to make it work, right?

After applying this one I get a failure, only when I set PYTHONPATH it
works:

⬢ [acme@toolbx perf-tools-next]$ export PYTHONPATH=/tmp/build/perf-tools-next/python_ext_build/lib/
⬢ [acme@toolbx perf-tools-next]$ perf test -v pytho
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
 88: 'import perf' in python                                         : Ok
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo


 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/shell/python-use.sh | 36 ++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/python-use.sh
> >
> > diff --git a/tools/perf/tests/shell/python-use.sh b/tools/perf/tests/shell/python-use.sh
> > new file mode 100755
> > index 000000000000..fd2ee5390060
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/python-use.sh
> > @@ -0,0 +1,36 @@
> > +#!/bin/bash
> > +# 'import perf' in python
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Just test if we can load the python binding.
> > +set -e
> > +
> > +shelldir=$(dirname "$0")
> > +# shellcheck source=lib/setup_python.sh
> > +. "${shelldir}"/lib/setup_python.sh
> > +
> > +MODULE_DIR=$(dirname "$(which perf)")/python
> > +
> > +if [ -d "$MODULE_DIR" ]
> > +then
> > +    CMD=$(cat <<EOF
> > +import sys
> > +sys.path.insert(0, '$MODULE_DIR')
> > +import perf
> > +print('success!')
> > +EOF
> > +    )
> > +else
> > +    CMD=$(cat <<EOF
> > +import perf
> > +print('success!')
> > +EOF
> > +    )
> > +fi
> > +
> > +echo -e "Testing 'import perf' with:\n$CMD"
> > +
> > +if ! echo "$CMD" | $PYTHON | grep -q "success!"
> > +then
> > +  exit 1
> > +fi
> > +exit 0
> > --
> > 2.51.0.338.gd7d06c2dae-goog
> >
