Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF818DF8D;
	Wed,  5 Mar 2025 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196724; cv=none; b=Ati04LTUwfLABSXHr+bCUVJt3rJYmp8dM3/rPwAl39DwKcLO7YXjmi0O1YuXHbNBWuGKbruq4h5UGy1k0p6XLrF3yvjGoqfs6+MCdk5fIfyq73smTcdIazOM8yFqFjqe3fm6I06pb9+FP4Jjc6ZxKHJb8jb9Y8AJ6jX04j66hbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196724; c=relaxed/simple;
	bh=ZUhCuM8H0R253y8eMtAf0airPgJTVO1TO4CiN5J2T4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzyozQ+PDiU5FKTKrGgPj9YT1lNeYIPER4zEFsi8vWGdBm6XKerGYnr07+As+halyqxEHKDwjJERQG23fr0/qb7MgAsM1LFsK8s2GFhvvJkvlx6TxhwSGFGcwjmhjRNDOQsxHsl/G8LeCIZ3BjhlbpNCRCJCULqmDOe1bcE3koM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQiTZrKq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQiTZrKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123D4C4CED1;
	Wed,  5 Mar 2025 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196723;
	bh=ZUhCuM8H0R253y8eMtAf0airPgJTVO1TO4CiN5J2T4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQiTZrKqj4+5GycZ1ZfH2pNAbCwF6tBpCADknMpLcL350XnvX7qiL+qPjOBZCLOYB
	 rV//65NFg3HFBWUT3E2jdnwd9mD23qbfwSGGd+XlnTr+/uvgru0mV4YfLi4Xvg/QiE
	 IlRFb0RB2YlBoLeT4xotwUttvjJSWijSH8wOfPvu5oeB09cNu5dfhMACVGbfrCwKlL
	 AiniUKY9jLyfT1L51HTCLvAQ5zAnMrqWInNhZfTzwvaWJfeK7BZbrDcIUAJhcvT0hl
	 T/ylRl57Y3/2Oglcnx67qlvblm5g43Ii58F3idRyWr0/jBhvZ358k2JhRf8xJdTDD1
	 S+sWJFROJGJzw==
Date: Wed, 5 Mar 2025 14:45:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf test: Skip perf probe tests when running as
 non-root
Message-ID: <Z8iNr0Lh61o_GZgg@x1>
References: <20250301040252.1586750-1-namhyung@kernel.org>
 <20250301040252.1586750-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250301040252.1586750-3-namhyung@kernel.org>

On Fri, Feb 28, 2025 at 08:02:50PM -0800, Namhyung Kim wrote:
> perf trace requires root because it needs to use [ku]probes.
> Skip those test when it's not run as root.
> 
> Before:
>   $ perf test probe
>    47: Probe SDT events                                                : Ok
>   104: test perf probe of function from different CU                   : FAILED!
>   115: perftool-testsuite_probe                                        : FAILED!
>   117: Add vfs_getname probe to get syscall args filenames             : FAILED!
>   118: probe libc's inet_pton & backtrace it with ping                 : FAILED!
>   119: Use vfs_getname probe to get syscall args filenames             : FAILED!

Do you have ShellCheck installed?

  TEST    /tmp/build/perf-tools-next/tests/shell/probe_vfs_getname.sh.shellcheck_log
  TEST    /tmp/build/perf-tools-next/tests/shell/record+probe_libc_inet_pton.sh.shellcheck_log
  TEST    /tmp/build/perf-tools-next/tests/shell/record+script_probe_vfs_getname.sh.shellcheck_log

In tests/shell/probe_vfs_getname.sh line 11:
[ "$(id -u)" == 0 ] || exit 2
             ^-- SC3014 (warning): In POSIX sh, == in place of = is undefined.

For more information:
  https://www.shellcheck.net/wiki/SC3014 -- In POSIX sh, == in place of = is ...

In tests/shell/record+script_probe_vfs_getname.sh line 16:
[ "$(id -u)" == 0 ] || exit 2
             ^-- SC3014 (warning): In POSIX sh, == in place of = is undefined.

For more information:
  https://www.shellcheck.net/wiki/SC3014 -- In POSIX sh, == in place of = is ...
make[4]: *** [tests/Build:91: /tmp/build/perf-tools-next/tests/shell/probe_vfs_getname.sh.shellcheck_log] Error 1
make[4]: *** Waiting for unfinished jobs....
make[4]: *** [tests/Build:91: /tmp/build/perf-tools-next/tests/shell/record+script_probe_vfs_getname.sh.shellcheck_log] Error 1

In tests/shell/record+probe_libc_inet_pton.sh line 108:
[ "$(id -u)" == 0 ] || exit 2
             ^-- SC3014 (warning): In POSIX sh, == in place of = is undefined.

For more information:
  https://www.shellcheck.net/wiki/SC3014 -- In POSIX sh, == in place of = is ...
make[4]: *** [tests/Build:91: /tmp/build/perf-tools-next/tests/shell/record+probe_libc_inet_pton.sh.shellcheck_log] Error 1
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:138: tests] Error 2
make[2]: *** [Makefile.perf:810: /tmp/build/perf-tools-next/perf-test-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:321: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbox perf-tools-next]$

The patch below seems to make it happy.

But since it seems to be mixed up, i.e. its not a string comparision, so
why the quotes?

Probably it should be

[ $(id -u) -eq 0 ] || exit 2

?

It all works with bash, but ShellCheck being installed stops the build
with that POSIX error.

⬢ [acme@toolbox perf-tools-next]$ [ "$(id -u)" == 1000 ] && echo bla
bla
⬢ [acme@toolbox perf-tools-next]$ [ "$(id -u)" = 1000 ] && echo bla
bla
⬢ [acme@toolbox perf-tools-next]$ [ $(id -u) -eq 1000 ] && echo bla
bla
⬢ [acme@toolbox perf-tools-next]$ id
uid=1000(acme) gid=1000(acme) groups=1000(acme),10(wheel)
⬢ [acme@toolbox perf-tools-next]

- Arnaldo

diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index b8e53a9d8473bf6b..c51a32931af6313e 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -8,7 +8,7 @@
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
-[ "$(id -u)" == 0 ] || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
 # shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 07a1527c5c03b93d..c4bab5b5cc59f0b3 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -105,7 +105,7 @@ delete_libc_inet_pton_event() {
 
 # Check for IPv6 interface existence
 ip a sh lo | grep -F -q inet6 || exit 2
-[ "$(id -u)" == 0 ] || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
 skip_if_no_perf_probe && \
 add_libc_inet_pton_event && \
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 0af3af90a8dcc742..fd5b10d469158b65 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -13,7 +13,7 @@
 . "$(dirname "$0")/lib/probe.sh"
 
 skip_if_no_perf_probe || exit 2
-[ "$(id -u)" == 0 ] || exit 2
+[ "$(id -u)" = 0 ] || exit 2
 
 # shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname "$0")/lib/probe_vfs_getname.sh"
