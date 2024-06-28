Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCFC125AC
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558830; cv=none; b=iQWssLLpfMdi6IMG0VlCzkoHd7gbiBclaXVeHy6B3NxrWRMjqCDhSrihgSuuzDtZUuHMKI16IZE3fBfZY2rVYcQTWAR1QwPYv9jzxPjUB6k51ZRL5KFLd8+nctP0Sh7FN7v4pZxb/yFJiWAYZNYToUTliiyoBTPFzI1Sy6pWVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558830; c=relaxed/simple;
	bh=u1FT5Zqa/MQmbN8v8y1Lf0j9pzUy4Qgp3Iq91+ZJHfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ce37IP1SWAJmdKcjCYLjASiLQUhRbCMZbyMCbUWUywqN/0OSBg3ChPZmUTSu+kpA2gjvgvlt9Z4X5hLgv5xqPZCzcgEGb48t64I1R26N0/AWZPQ1yv7+CIT7HRXdT3XNt7jB4LcQLUkjM4o0j1ZPJGTlwqjMQAjUus0TAA3/YDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VSS07n5P; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VSS07n5P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CVaytg0+gie3dVfjsp515KftYaHpwjpxssr0+wxQQ0M=; t=1719558828;
	x=1719990828; b=VSS07n5PRfzDiTFQ79RAVUWWfl6K9mOJRzN/1QFEpFJqy6j1ODvx3+C4m5ZPT
	wP2jt+LdoY5eIDwIa8+VXqYaIugjZ5jMdceRIHO8FF+tt2ihsfBo//hHwvmF9rQxMUc/PELh66U9I
	NyC3RNAu6AtHFJLYfBfN2PBcBAnXJ94hNLThYgVZyuU1S8zglA9EnArv+ItvWkjEOoszkjTp1OqZB
	bo7/7Z3+RINd6IuF6TCePkLYNESTTAt0kAXSy1KiMmupFYjcWwzdyIuQJhgZT+2lQ8EEXss0t8Azh
	0j74d5thahyagMFcWZTYClQUYAwEYNCspXrRAYJtnzrzNUE4oQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sN5nk-0000PZ-Jf; Fri, 28 Jun 2024 09:13:44 +0200
Message-ID: <072d3965-7140-4f0b-bf9a-9d7edabbfde9@leemhuis.info>
Date: Fri, 28 Jun 2024 09:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf build: Use pkg-config for feature check for
 libtrace{event,fs}
To: amadio@gentoo.org, acme@kernel.org, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
References: <20240606153625.2255470-1-amadio@gentoo.org>
 <20240606153625.2255470-2-amadio@gentoo.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20240606153625.2255470-2-amadio@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1719558828;8cc01cd3;
X-HE-SMSGID: 1sN5nk-0000PZ-Jf

On 06.06.24 17:33, amadio@gentoo.org wrote:
> From: Guilherme Amadio <amadio@gentoo.org>
> 
> Needed to add required include directories for the feature detection
> to succeed. The header tracefs.h is installed either into the include
> directory /usr/include/tracefs/tracefs.h when using the Makefile, or
> into /usr/include/libtracefs/tracefs.h when using meson to build
> libtracefs. The header tracefs.h uses #include <event-parse.h> from
> libtraceevent, so pkg-config needs to pick the correct include directory
> for libtracefs and add the one for libtraceevent to succeed.
> 
> Note that in baa2ca59ec1e31ccbe3f24ff0368152b36f68720 the variable
> LIBTRACEEVENT_DIR was introduced, and now the method to compile against
> non-standard locations requires PKG_CONFIG_PATH to be set instead, which
> works for both libtraceevent and libtracefs.
> 
> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> Cc: Ian Rogers <irogers@google.com>

Since this patch landed in Linux next as 0f0e1f44569061 ("perf build:
Use pkg-config for feature check for libtrace{event,fs}") my vanilla 
-next build using the RPM spec file from Fedora fails. I'm not sure if
it causes my problems, but it looks likely.

A log of a failed build can be found here:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-x86_64/07670271-next-next-all/builder-live.log.gz

The gist:
"""

Auto-detecting system features:
...                           libtraceevent: [ on  ]
...                              libtracefs: [ OFF ]

libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
Makefile.config:46: *** Please, check the errors above..  Stop.
error: Bad exit status from /var/tmp/rpm-tmp.yNun6A (%build)
"""

But libtracefs-devel is installed and pkgconfig works (output from
another machine):

$ pkgconf --cflags libtracefs
-I/usr/include/tracefs -I/usr/include/traceevent

From a *quick* looks it seems those flags are not picked up when
building tools/verification/rv/feature/test-libtracefs.bin 

"""
+ pkg-config --cflags libtraceevent
gcc  -MD -Wall -Werror -o /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.bin test-libtracefs.c -ggdb   > /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.make.output 2>&1 -I/usr/include/traceevent  -ltracefs
+ gcc -MD -Wall -Werror -o /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.bin test-libtracefs.c -ggdb -I/usr/include/traceevent -ltracefs
make: *** [Makefile:216: /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.bin] Error 1
make: Leaving directory '/home/thl/usr/tmp/linux-next/tools/build/feature'
"""

And

"""
$ cat /home/thl/usr/tmp/linux-next/tools/verification/rv/feature/test-libtracefs.make.output 
test-libtracefs.c:2:10: fatal error: tracefs.h: No such file or directory
    2 | #include <tracefs.h>
      |          ^~~~~~~~~~~
compilation terminated.
"""

Then I ran out of time looking where it might missing and decided to write
this mail instead.

Ciao, Thorsten


> ---
>  tools/build/feature/test-libtracefs.c |  2 +-
>  tools/perf/Makefile.config            | 27 +++++++++++++--------------
>  2 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/build/feature/test-libtracefs.c b/tools/build/feature/test-libtracefs.c
> index 8eff16c0c10b..29a757a7d848 100644
> --- a/tools/build/feature/test-libtracefs.c
> +++ b/tools/build/feature/test-libtracefs.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <tracefs/tracefs.h>
> +#include <tracefs.h>
>
> [...]
