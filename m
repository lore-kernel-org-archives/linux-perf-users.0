Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B719E81F;
	Wed,  1 Oct 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342987; cv=none; b=Lvn2e5c6fURTxDsb+RurDK4EUjgHDVURFpaGiRwmgVSiUeum2WzP1VJAOMSX/skJe3Ycd87e+0EOTsgQAazV5aniNxIBBKaOdNTKNSFLm2VY7oqwU1NgrmH2xajyO5NXlA3F2cSagml0e8wWByHEf8aekbL4YqxUObRH+hwhd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342987; c=relaxed/simple;
	bh=4ezjVUs1oMR01gV1BtL7wfTOiKjGMYdHtpOPd8vslf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7bELqBEtc3N3bOWM60DQaugMHSEdKEzrfQPTyHj6AMz8fHkn4FFPY/lX8efTQ2ybPhEPRHYfj93zuREWo3Kh59XgO455koAuSy0J6Doiq4q6FsmxZtSUYa8DDtldpsi6H9wSCDBkRuLSLJ9FYjgz+XJv+Pi+IKl4xKmrWlVcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPga7GiL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPga7GiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CA1C4CEF1;
	Wed,  1 Oct 2025 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759342987;
	bh=4ezjVUs1oMR01gV1BtL7wfTOiKjGMYdHtpOPd8vslf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPga7GiLNzJgOYilTUpLKUGTfgi64CZ4rAHkulqUYvyna24mK2CqRlOMJV74bbVoN
	 6K3PSafJxrq5QBJuya6ng2rAJlIkBHiICA6epzJtsiFcayZqDORfI+BubdSb15xQt2
	 zXdtt6RXOKSrnOyKeB6BX53UaE5/5RnumP9T1bIoepCKlzYfVdMlrgSltswF3sqsbv
	 kEHs4aqbnwVa+j68QaiB+GVSeNUhkkmvAqpmfnIo4gJiSk/mLHfT9lVP6/PuHLnUJ+
	 N4z560NlSVBsB+SXew1KPrT6XXZpGxrFs+wodyj177rXWrypJbDwxfXB+o9GdqfG2z
	 V2f5nkKh98wZQ==
Date: Wed, 1 Oct 2025 15:23:04 -0300
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
Message-ID: <aN1xiDKUpNw83h8B@x1>
References: <20250903184248.695267-1-irogers@google.com>
 <CAP-5=fV-3d1EzYfZq6s9M2NrLFFVOrWOTx_k5tByScA4Sfqq-g@mail.gmail.com>
 <aN0vu4yoVWjmTbtJ@x1>
 <CAP-5=fX46C2A22B1TBSgNb0BR1BumvqQeZvaFbU=9OqHmYPqrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX46C2A22B1TBSgNb0BR1BumvqQeZvaFbU=9OqHmYPqrQ@mail.gmail.com>

On Wed, Oct 01, 2025 at 07:55:12AM -0700, Ian Rogers wrote:
> On Wed, Oct 1, 2025 at 6:42 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > On Tue, Sep 30, 2025 at 01:02:55PM -0700, Ian Rogers wrote:
> > > On Wed, Sep 3, 2025 at 11:42 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > The 'import perf' test needs to set up a path to the python module as
> > > > well as to know the python command to invoke. These are hard coded at
> > > > build time to be build a directory and the python used in the build,
> > > > which is less than desirable. Avoid the hard coded values by reusing
> > > > the existing shell script python setup and determine a potential built
> > > > python module via the path of the perf executable.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > Ping.
> >
> > There is another patch in this area to make it work, right?
> >
> > After applying this one I get a failure, only when I set PYTHONPATH it
> > works:
> >
> > ⬢ [acme@toolbx perf-tools-next]$ export PYTHONPATH=/tmp/build/perf-tools-next/python_ext_build/lib/
> > ⬢ [acme@toolbx perf-tools-next]$ perf test -v pytho
> > Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> >  88: 'import perf' in python                                         : Ok
> > ⬢ [acme@toolbx perf-tools-next]$
> 
> Hmm.. if you are running from the install directory then I guess the
> assumption should be that the install bin directory is in the PATH,
> lib in LD_LIBRARY_PATH and PYTHONPATH set up for the directory too? We
> could have the script look for a python module going from ..../bin to
> ..../lib and fix the PYTHONPATH for you. Wdyyt?

I reported it more in the sense that something that was working before
stopped working but having not yet tried to see why it stopped working.

Another thing that I just noticed that may be related:

  35    97.47 fedora:rawhide                : Ok   gcc (GCC) 15.2.1 20250924 (Red Hat 15.2.1-2) , clang version 21.1.2 (Fedora 21.1.2-1.fc44) flex 2.6.4
  36    36.81 gentoo:stage3                 : Ok   gcc (Gentoo 13.3.1_p20240614 p17) 13.3.1 20240614  flex 2.6.4
  37    77.37 manjaro:base                  : FAIL clang version 16.0.6
      AR      /tmp/build/perf/libpmu-events.a
      LINK    /tmp/build/perf/perf
      GEN     /tmp/build/perf/python/perf.cpython-311-x86_64-linux-gnu.so
    /tmp/build/perf/python_ext_build/tmp/git/perf-6.17.0-rc6/tools/perf/util/python.o: file not recognized: file format not recognized
    clang-16: error: linker command failed with exit code 1 (use -v to see invocation)
    error: command '/usr/sbin/clang' failed with exit code 1
    cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory
    make[2]: *** [Makefile.perf:747: /tmp/build/perf/python/perf.cpython-311-x86_64-linux-gnu.so] Error 1
    make[1]: *** [Makefile.perf:289: sub-make] Error 2
    make: *** [Makefile:76: all] Error 2
    make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
    + exit 1
  38   130.27 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 15.0.7 flex 2.6.4
  39   119.76 opensuse:15.5                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 15.0.7 flex 2.6.4
  40   120.03 opensuse:15.6                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 17.0.6 flex 2.6.4o

- Arnaldo
