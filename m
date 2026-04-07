Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781543AE18A;
	Tue,  7 Apr 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564400; cv=none; b=L/0EGAhNWtzc77YvAUTnaVoPVk8S/+bvFwn4s0em1u4HHeDIqLUd9yKB5MYGg1bSI1Ay+5T3QvXNS4iGlGzuUAfEXCZxOzYfXFxIukXAGyvXKgjKw5g2XbBlARQ1At2AR6jiHRNay/IQCz+PwHcz/nxQmNcCOrHk6sJd+ImT6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564400; c=relaxed/simple;
	bh=i87THqj59PG6AQpmQ1TngcvxJhh6ncfTaLwXvBSuzB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C++yte0x5CLk9Lam2FcLoBXk4Cn2EgGkv7hCC/lHAZD/w85nVSfOQC0WV/Jn2CwDQyfr1Zehg36Y3aLHsXE38ZMDbwF46uNnnYqotVKt51NjVXZL49JfrfrLJ6Qc0oo98nK8XpouXS662GMAWPfkmlkDUR5bPiba+pItG0dZwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrXxKE2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrXxKE2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8F1C116C6;
	Tue,  7 Apr 2026 12:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775564400;
	bh=i87THqj59PG6AQpmQ1TngcvxJhh6ncfTaLwXvBSuzB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrXxKE2quH0NqLF8ZBpxUUtWqrJMttQSiDB6HkuSq46vaqvIhQQxCxPnaLcbE3+ae
	 1MZi1Lrh0HExUqGRw9REbyJGku+WznIsPcIUiBdQCAUn3nPyfQt9vf3NW58yj4J+X1
	 38BZGprQTX7oY0Kn6cJvLLegS4CHV5skwBT8Wnh6EgGdqH01IWE1zoh/jRJ3e/oXwV
	 irFVadu6lNMY7+/V7T5dmdUZAF5EXbGeAQVb4TfEXNjuUupZILW9B5EPM2hmF6IEn+
	 dpj11hY1rpEvxAqrsw25960u/g9Dqw2+Udz6WmvQJ9rrrqU+UTmJWxBV4U2jxdY+va
	 4xdH+lKK/9dDQ==
Date: Tue, 7 Apr 2026 09:19:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix detection of latest openjdk
Message-ID: <adT2berZ52tb1O-P@x1>
References: <20260407080320.45372-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260407080320.45372-1-namhyung@kernel.org>

On Tue, Apr 07, 2026 at 01:03:20AM -0700, Namhyung Kim wrote:
> My fedora system fails to find openjdk even if I installed the
> 'java-latest-openjdk-devel' package as in the warning message.
> It turns out that the directory path is different than what's in the
> output of alternatives.
> 
>   Makefile.config:1122: No openjdk development package found, please install JDK package,
>                         e.g. openjdk-8-jdk, java-latest-openjdk-devel
> 
> The Makefile.config has the rule like below to detect the installed
> directory with a version number.
> 
>   $ alternatives --display java | tail -1 | cut -d ' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g'
>   /usr/lib/jvm/java-21-openjdk
> 
> This is to find a directory where the header file (jvmti.h) is like
> /usr/lib/jvm/java-21-openjdk/include/jvmti.h.  However the header file
> was in a different directory.
> 
>   $ rpm -ql java-latest-openjdk-devel | grep jvmti.h
>   /usr/lib/jvm/java-latest-openjdk/include/jvmti.h
> 
> It seems the directory name is fixed to provide the latest version.
> Let's check the directory name before using the parsed name.  With this
> change, the warning is gone on my system.

Interesting, I'm not noticing this on Fedora rawhide (44), I created a
fresh toolbox container with fedora:rawhide and had, as you, this:

⬢ [acme@toolbx perf-tools-next]$ m
make: Entering directory '/home/acme/git/linux/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
Makefile.config:1070: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1122: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-latest-openjdk-devel


Then I just followed the suggestion and did a:

$ sudo dnf install java-latest-openjdk-devel

And after that the 1122 warning vanished and:

⬢ [acme@toolbx perf-tools-next]$ ls -la /tmp/build/perf-tools-next/feature/test-jvmti*
-rwxr-xr-x. 1 acme acme 12384 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti.bin
-rwxr-xr-x. 1 acme acme 12392 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti-cmlr.bin
-rw-r--r--. 1 acme acme  1188 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti-cmlr.d
-rw-r--r--. 1 acme acme     0 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti-cmlr.make.output
-rw-r--r--. 1 acme acme  1122 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti.d
-rw-r--r--. 1 acme acme     0 Apr  7 09:14 /tmp/build/perf-tools-next/feature/test-jvmti.make.output
⬢ [acme@toolbx perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-jvmti.make.output
⬢ [acme@toolbx perf-tools-next]$

⬢ [acme@toolbx perf-tools-next]$ alternatives --display java | tail -1 | cut -d ' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g'
/usr/lib/jvm/java-latest-openjdk
⬢ [acme@toolbx perf-tools-next]$

⬢ [acme@toolbx perf-tools-next]$ alternatives --display java
java - status is auto.
 link currently points to /usr/lib/jvm/java-latest-openjdk/bin/java
/usr/lib/jvm/java-latest-openjdk/bin/java - priority 1
 follower jre: /usr/lib/jvm/java-latest-openjdk
 follower alt-java: /usr/lib/jvm/java-latest-openjdk/bin/alt-java
 follower jcmd: /usr/lib/jvm/java-latest-openjdk/bin/jcmd
 follower keytool: /usr/lib/jvm/java-latest-openjdk/bin/keytool
 follower rmiregistry: /usr/lib/jvm/java-latest-openjdk/bin/rmiregistry
 follower java.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/java.1
 follower alt-java.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/alt-java.1
 follower jcmd.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/jcmd.1
 follower keytool.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/keytool.1
 follower rmiregistry.1.gz: /usr/lib/jvm/java-latest-openjdk/man/man1/rmiregistry.1
Current `best' version is /usr/lib/jvm/java-latest-openjdk/bin/java.
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Makefile.config | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 333ddd0e4bd814e9..e6686641761fd0bf 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1096,8 +1096,12 @@ ifndef NO_JVMTI
>    ifneq (,$(wildcard /usr/sbin/update-java-alternatives))
>      JDIR=$(shell /usr/sbin/update-java-alternatives -l | head -1 | awk '{print $$3}')
>    else
> -    ifneq (,$(wildcard /usr/sbin/alternatives))
> -      JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g')
> +    ifneq (,$(wildcard /usr/lib/jvm/java-latest-openjdk/include))
> +      JDIR=/usr/lib/jvm/java-latest-openjdk
> +    else
> +      ifneq (,$(wildcard /usr/sbin/alternatives))
> +        JDIR=$(shell /usr/sbin/alternatives --display java | tail -1 | cut -d' ' -f 5 | sed -e 's%/jre/bin/java.%%g' -e 's%/bin/java.%%g')
> +      endif
>      endif
>    endif
>    ifndef JDIR
> -- 
> 2.53.0
