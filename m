Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B13BB4A;
	Wed,  8 Apr 2026 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627214; cv=none; b=FTQLrODunDDb8tgraIGbOrMj9ZLAw6ZVYKlAv6qjOk3VZo0UsbjyoKOFZQfi6m1UgzCm2los2xnIbQ8oRYQ35n/nMT9O+908V530fiJtZ0G2ESUHzSUKv8vxsVaRcLqlJWZmixU4qdzEIh0pVPQO+Zl7s+JC62PHNQy4PjOHRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627214; c=relaxed/simple;
	bh=RCQU0uJzFVTcUaHUqqfX1/iLgWP+QU1fKGYAuHtZvis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC7s9oU1PukftKBoIiazxHpKeIaNIlO3NkCqH2T8Og2bQbhsNh+XkMa9nQf3mFMXNWRy0W6NQJyKiCb1R3gueP87j+AHmipCJJNVsW2IdB8fu3wttR2lCIBQ5rQOivm1pwoQZsoEjXrUDnfAShqwBXqOQdNwr1pNVzk5GL10HdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD24hm2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD24hm2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB47C19424;
	Wed,  8 Apr 2026 05:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775627214;
	bh=RCQU0uJzFVTcUaHUqqfX1/iLgWP+QU1fKGYAuHtZvis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MD24hm2PrRfDQRLfOuUFdkoVeEQfsLO53S2LAmpYgZcqBVjOC3rE3vjkZ1A7nsj+9
	 YhvhM1q7u0hHzWsCfLUwr3Lxz82ub1PeSlzQ60I4Y1Kur1MDCdUEn3GA5SzqTNdALY
	 cH0we7KKTIQor5VJWkRMsrxKdWaO+cWqpcHTAQ3mhcASHOYcIJappoxzZ5gmuVB4aK
	 +4oJ7u7FUrE9uVRbRYrV8W2Ev35Zp/nDQyyHESfOIbwWjRq/S4zGBPjxeF2p6bROkP
	 IGDdxkC3U34vcQdubyDPk7Oh/C3S7/tzYHBZINFMVSw+biPd2tu+zPhnDfNTvJJDok
	 vbgO4GAzAaLcA==
Date: Tue, 7 Apr 2026 22:46:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix detection of latest openjdk
Message-ID: <adXrzHdEMYhxYcSx@z2>
References: <20260407080320.45372-1-namhyung@kernel.org>
 <adT2berZ52tb1O-P@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adT2berZ52tb1O-P@x1>

On Tue, Apr 07, 2026 at 09:19:57AM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 07, 2026 at 01:03:20AM -0700, Namhyung Kim wrote:
> > My fedora system fails to find openjdk even if I installed the
> > 'java-latest-openjdk-devel' package as in the warning message.
> > It turns out that the directory path is different than what's in the
> > output of alternatives.
> > 
> >   Makefile.config:1122: No openjdk development package found, please install JDK package,
> >                         e.g. openjdk-8-jdk, java-latest-openjdk-devel
> > 
> > The Makefile.config has the rule like below to detect the installed
> > directory with a version number.
> > 
> >   $ alternatives --display java | tail -1 | cut -d ' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g'
> >   /usr/lib/jvm/java-21-openjdk
> > 
> > This is to find a directory where the header file (jvmti.h) is like
> > /usr/lib/jvm/java-21-openjdk/include/jvmti.h.  However the header file
> > was in a different directory.
> > 
> >   $ rpm -ql java-latest-openjdk-devel | grep jvmti.h
> >   /usr/lib/jvm/java-latest-openjdk/include/jvmti.h
> > 
> > It seems the directory name is fixed to provide the latest version.
> > Let's check the directory name before using the parsed name.  With this
> > change, the warning is gone on my system.
> 
> Interesting, I'm not noticing this on Fedora rawhide (44), I created a
> fresh toolbox container with fedora:rawhide and had, as you, this:
> 
> ⬢ [acme@toolbx perf-tools-next]$ m
> make: Entering directory '/home/acme/git/linux/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
> Makefile.config:1070: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> Makefile.config:1122: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-latest-openjdk-devel
> 
> 
> Then I just followed the suggestion and did a:
> 
> $ sudo dnf install java-latest-openjdk-devel
> 
> And after that the 1122 warning vanished and:
> 
> ⬢ [acme@toolbx perf-tools-next]$ ls -la /tmp/build/perf-tools-next/feature/test-jvmti*
> -rwxr-xr-x. 1 acme acme 12384 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti.bin
> -rwxr-xr-x. 1 acme acme 12392 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti-cmlr.bin
> -rw-r--r--. 1 acme acme  1188 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti-cmlr.d
> -rw-r--r--. 1 acme acme     0 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti-cmlr.make.output
> -rw-r--r--. 1 acme acme  1122 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti.d
> -rw-r--r--. 1 acme acme     0 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti.make.output
> ⬢ [acme@toolbx perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-jvmti.make.output
> ⬢ [acme@toolbx perf-tools-next]$
> 
> ⬢ [acme@toolbx perf-tools-next]$ alternatives --display java | tail -1 | cut -d ' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g'
> /usr/lib/jvm/java-latest-openjdk
> ⬢ [acme@toolbx perf-tools-next]$
> 
> ⬢ [acme@toolbx perf-tools-next]$ alternatives --display java
> java - status is auto.
>  link currently points to /usr/lib/jvm/java-latest-openjdk/bin/java
> /usr/lib/jvm/java-latest-openjdk/bin/java - priority 1
>  follower jre: /usr/lib/jvm/java-latest-openjdk
>  follower alt-java: /usr/lib/jvm/java-latest-openjdk/bin/alt-java
>  follower jcmd: /usr/lib/jvm/java-latest-openjdk/bin/jcmd
>  follower keytool: /usr/lib/jvm/java-latest-openjdk/bin/keytool
>  follower rmiregistry: /usr/lib/jvm/java-latest-openjdk/bin/rmiregistry
>  follower java.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/java.1
>  follower alt-java.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/alt-java.1
>  follower jcmd.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/jcmd.1
>  follower keytool.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/keytool.1
>  follower rmiregistry.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/rmiregistry.1
> Current `best' version is /usr/lib/jvm/java-latest-openjdk/bin/java.
> ⬢ [acme@toolbx perf-tools-next]$

Thanks for checking this.  Looks like a local issue on my system.
I've updated the alternatives to point to the latest version.

Thanks,
Namhyung
