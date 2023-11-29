Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E43B782
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLY8PbCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9118BC433C7;
	Wed, 29 Nov 2023 20:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701291410;
	bh=oz1oE+pVXkj1GqtEpZDqy1MTTXf/mn39PvAchD3E9zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLY8PbCo0Fr41TUFsPWRDF6ipLMUigMVrx0G7+xzNUqjqnh02SdB04iUl+Pc/lJAg
	 ShVroHBdftI6Q8E6YMYX2GRvZauy3SLqb/YAMRMsK8EXrkzO6jmnTP0Uf5FmZlh1BU
	 klkAdgsDQq/wtnDSiv3ffOP2qZB1tHeupxq6a1WULmmpV4YR3msB4zzx+GvnBe57HT
	 PQQNV+JClVeXfu7pS7RZ6vupdCc+8iEnrnku/N+RwNGTQvuO8ZVA22pZCZu7vYBUDE
	 hfCS4Lubnj9Y+8L0TqfBFE/FyXIhowIlegca/Hkhj/Br3D8z1in/2EM93IgOX2q19h
	 Ldzy9w3TgNUrQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id BEF2140094; Wed, 29 Nov 2023 17:56:46 -0300 (-03)
Date: Wed, 29 Nov 2023 17:56:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Likhitha Korrapati <likhitha@linux.ibm.com>
Cc: jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
	james.clark@arm.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] perf test record+probe_libc_inet_pton: Fix call chain
 match on powerpc
Message-ID: <ZWeljhj9ZH4xrqjw@kernel.org>
References: <20231126070914.175332-1-likhitha@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126070914.175332-1-likhitha@linux.ibm.com>
X-Url: http://acmel.wordpress.com

Em Sun, Nov 26, 2023 at 02:09:14AM -0500, Likhitha Korrapati escreveu:
> The perf test "probe libc's inet_pton & backtrace it with ping" fails on
> powerpc as below:
> 
> root@xxx perf]# perf test -v "probe libc's inet_pton & backtrace it with
> ping"
>  85: probe libc's inet_pton & backtrace it with ping                 :
> --- start ---
> test child forked, pid 96028
> ping 96056 [002] 127271.101961: probe_libc:inet_pton: (7fffa1779a60)
> 7fffa1779a60 __GI___inet_pton+0x0
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> 7fffa172a73c getaddrinfo+0x121c
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> FAIL: expected backtrace entry
> "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/glibc-hwcaps/power10/libc.so.6\)$"
> got "7fffa172a73c getaddrinfo+0x121c
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)"
> test child finished with -1
> ---- end ----

Try to have quoted output, the ones separated by ---- at the beginning
of the line indented two spaces, so as to avoid:

perf test record+probe_libc_inet_pton: Fix call chain match on powerpc

The perf test "probe libc's inet_pton & backtrace it with ping" fails on
powerpc as below:

root@xxx perf]# perf test -v "probe libc's inet_pton & backtrace it with
ping"
 85: probe libc's inet_pton & backtrace it with ping                 :

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# Author:    Likhitha Korrapati <likhitha@linux.ibm.com>
# Date:      Sun Nov 26 02:09:14 2023 -0500


I'm copy and pasting from the original post, thanks!

- Arnaldo

> probe libc's inet_pton & backtrace it with ping: FAILED!
> 
> This test installs a probe on libc's inet_pton function, which will use
> uprobes and then uses perf trace on a ping to localhost. It gets 3
> levels deep backtrace and checks whether it is what we expected or not.
> 
> The test started failing from RHEL 9.4 where as it works in previous
> distro version (RHEL 9.2). Test expects gaih_inet function to be part of
> backtrace. But in the glibc version (2.34-86) which is part of distro
> where it fails, this function is missing and hence the test is failing.
> 
> From nm and ping command output we can confirm that gaih_inet function
> is not present in the expected backtrace for glibc version glibc-2.34-86
> 
> [root@xxx perf]# nm /usr/lib64/glibc-hwcaps/power10/libc.so.6 | grep gaih_inet
> 00000000001273e0 t gaih_inet_serv
> 00000000001cd8d8 r gaih_inet_typeproto
> 
> [root@xxx perf]# perf script -i /tmp/perf.data.6E8
> ping  104048 [000] 128582.508976: probe_libc:inet_pton: (7fff83779a60)
>             7fff83779a60 __GI___inet_pton+0x0
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
>             7fff8372a73c getaddrinfo+0x121c
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
>                11dc73534 [unknown] (/usr/bin/ping)
>             7fff8362a8c4 __libc_start_call_main+0x84
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> 
> FAIL: expected backtrace entry
> "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/glibc-hwcaps/power10/libc.so.6\)$"
> got "7fff9d52a73c getaddrinfo+0x121c
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)"
> 
> With version glibc-2.34-60 gaih_inet function is present as part of the
> expected backtrace. So we cannot just remove the gaih_inet function from
> the backtrace.
> 
> [root@xxx perf]# nm /usr/lib64/glibc-hwcaps/power10/libc.so.6 | grep gaih_inet
> 0000000000130490 t gaih_inet.constprop.0
> 000000000012e830 t gaih_inet_serv
> 00000000001d45e4 r gaih_inet_typeproto
> 
> [root@xxx perf]# ./perf script -i /tmp/perf.data.b6S
> ping   67906 [000] 22699.591699: probe_libc:inet_pton_3: (7fffbdd80820)
>             7fffbdd80820 __GI___inet_pton+0x0
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
>             7fffbdd31160 gaih_inet.constprop.0+0xcd0
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
>             7fffbdd31c7c getaddrinfo+0x14c
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
>                1140d3558 [unknown] (/usr/bin/ping)
> 
> This patch solves this issue by doing a conditional skip. If there is a
> gaih_inet function present in the libc then it will be added to the
> expected backtrace else the function will be skipped from being added
> to the expected backtrace.
> 
> Output with the patch
> 
> [root@xxx perf]# ./perf test -v "probe libc's inet_pton & backtrace it
> with ping"
>  83: probe libc's inet_pton & backtrace it with ping                 :
> --- start ---
> test child forked, pid 102662
> ping 102692 [000] 127935.549973: probe_libc:inet_pton: (7fff93379a60)
> 7fff93379a60 __GI___inet_pton+0x0
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> 7fff9332a73c getaddrinfo+0x121c
> (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> 11ef03534 [unknown] (/usr/bin/ping)
> test child finished with 0
> ---- end ----
> probe libc's inet_pton & backtrace it with ping: Ok
> 
> Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> ---
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index eebeea6bdc76..72c65570db37 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -45,7 +45,10 @@ trace_libc_inet_pton_backtrace() {
>  		;;
>  	ppc64|ppc64le)
>  		eventattr='max-stack=4'
> -		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> +		# Add gaih_inet to expected backtrace only if it is part of libc.
> +		if nm $libc | grep -F -q gaih_inet.; then
> +			echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> +		fi
>  		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
>  		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  		;;
> -- 
> 2.39.1
> 

-- 

- Arnaldo
