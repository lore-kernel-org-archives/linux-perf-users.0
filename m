Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9925E4BA1F2
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597353; cv=none; b=tcJD9a2+7dofaBgU+JsRzFrKxUDpHUUk7w4Yy+HibLVzgZFf1L9FNurFd99GdHwL4X3Irhvc41nLorHlSlNz6dHZH+8HXj3Fasopb3sV5sP2z/llogzCvoNuF4h88eBE7WJvobqe3xVpLobKEzSbrAtzt91yB7De+qFlpOoxTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597353; c=relaxed/simple;
	bh=4EoSMQA+XY9yuhooSgCHWM2R2uRzxq4WvC1+UMSQetM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7WBMnmchQBfciiXIW4dvrrWJoQIKxtPnRxxymkN0vo+vBNMVhP0Xn+CjkBEPU6t3s3NqYPBwyZtSzrXjIF5L4f0IkUadilw/4u79/g+LxTmpipkWeEf4ArkSwzlmwcll9OGidBMfXCKnXCIxvcjN8vSR6noSnd7sVAGiSE7VHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyDhWWuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyDhWWuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8F81F00893;
	Mon, 28 Sep 2026 12:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790597352;
	bh=XtPKbrkM1Kn/88jqbZcwsS73FQvXsAKH+oCo6vKE8CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cyDhWWuyBgP7HXhxSAbTRgAtAGr2xdkF61Nc3irZvUdWjF9RvvYYfg/WTPSrjTfzc
	 v8pdIiLY80inLS0clqoNf0JceU7lui2rNjf8RmiEC+8B535NxHPbgmxyUSNYIpbrJc
	 fDJOLO5JaAwnl1saW0Bc+2gAE5fSbcyeUCjuStgapLmYfFy8w8jQ3aDWabaGpDP92V
	 XlR942uf3n3E0aAOLW4z+e3mor6AKwm1iwOGi7EXyJtMzxpqmUI+rLuwJzlmMq3ona
	 oE6m4oe8rA2Di/lEbcD8rRrk68qd/sljNf9HoHeC7+KhKS77T3hNugWHmVpAY/Xx1S
	 2xaRd6Wl+TJNA==
Date: Mon, 28 Sep 2026 14:09:08 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools feature gettid: Undef _GNU_SOURCE before
 defining it
Message-ID: <arpY5Mgccbd20eqj@x2>
References: <arpXYeRUu3B-ouqB@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arpXYeRUu3B-ouqB@x2>

On Mon, Sep 28, 2026 at 02:02:45PM +0200, Arnaldo Carvalho de Melo wrote:
> Since most of tools/build/feature/test-*.c feature tests are included in
> tools/build/feature/test-all.c, we can't just define _GNU_SOURCE as it
> may already been defined and this will break the build with:
> 
>   acme@alta:~$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
>   In file included from test-all.c:26:
>   test-gettid.c:3:9: error: "_GNU_SOURCE" redefined [-Werror]
>       3 | #define _GNU_SOURCE
>         |         ^~~~~~~~~~~
>   In file included from /usr/include/python3.13/pyconfig.h:9,
>                    from /usr/include/python3.13/Python.h:14,
>                    from test-python-module.c:2,
>                    from test-all.c:14:
>   /usr/include/aarch64-linux-gnu/python3.13/pyconfig.h:1810:10: note: this is the location of the previous definition
>    1810 | # define _GNU_SOURCE 1
>         |          ^~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   acme@alta:~$
> 
> I.e. pyconfig.h is included by the new test-python-module.c, that is at
> the start of test-all.c, defines _GNU_SOURCE, noticed on Debian 13
> (/usr/include/aarch64-linux-gnu/python3.13/pyconfig.h, libpython
> 3.13.5-2+deb13u5), and then test-all.c includes test-gettid.c that was

Noticed as well on fedora:

make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
105: 'import perf' in python                                                                                   : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
In file included from test-all.c:26:
test-gettid.c:3:9: error: ‘_GNU_SOURCE’ redefined [-Werror]
    3 | #define _GNU_SOURCE
      |         ^~~~~~~~~~~
In file included from /usr/include/python3.14/pyconfig.h:6,
                 from /usr/include/python3.14/Python.h:14,
                 from test-python-module.c:2,
                 from test-all.c:14:
/usr/include/python3.14/pyconfig-64.h:1879:10: note: this is the location of the previous definition
 1879 | # define _GNU_SOURCE 1
      |          ^~~~~~~~~~~
cc1: all warnings being treated as errors
⬢ [acme@toolbx perf-tools-next]$ head /etc/os-release
NAME="Fedora Linux"
VERSION="44 (Toolbx Container Image)"
RELEASE_TYPE=stable
ID=fedora
VERSION_ID=44
VERSION_CODENAME=""
PRETTY_NAME="Fedora Linux 44 (Toolbx Container Image)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:44"
⬢ [acme@toolbx perf-tools-next]$
