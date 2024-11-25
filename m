Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236418D625
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Nov 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540369; cv=none; b=V4szd5v4NBZDSS6g7smEXF0gCbh675nnhPlUqOrepU57NV+S4WE6OqGoEfakpEheXe+5WBcd0gsRK0IHOz+EEvx2aVayS1QlLAwYnHhcCsLbwZ0JOOVV7a+tUG2AVJDlgs01Nmigi4apOsaJ/vr725iAsPSupraHZ9QCwbE6Du0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540369; c=relaxed/simple;
	bh=5ooC9SRR8wfj/xsB/tqu9Q40s95lynM1BbZz9VthDRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s64xhjAR5BDmJHFl6AQxX3foktcTlrHIpqYwKz5VEtjCQxa3CYVFqRJmoCXIGuZO0xbc8vwD4pXJqzG9zz0oXAV2DSJ2h2Q85uvbijvIldjDzL6+67+axhQmgiCbh8JwQfwzwGaJJAYvwNKMcnxwi3X9urVN6vjhI9biq9bP06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Mon, 25 Nov 2024 14:12:41 +0100
From: Guilherme Amadio <amadio@gentoo.org>
To: Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Subject: Re: perf test for inet_pton probe fails to match stacktrace
Message-ID: <Z0R3ySrb8iZQd17O@gentoo.org>
References: <Z0D5FDu/sErQ0V/2@gentoo.org>
 <20241124105053.GA812108@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241124105053.GA812108@e132581.arm.com>

Dear Leo,

On Sun, Nov 24, 2024 at 10:50:53AM +0000, Leo Yan wrote:
> Hi Guilherme,
> 
> On Fri, Nov 22, 2024 at 10:35:16PM +0100, Guilherme Amadio wrote:
> 
> [...]
> > [...]
> 
> This is not the first reported failure on this case, see [1] for
> previous one.
> 
> I assume you are working on x86_64 machine.  Could you confirm if the
> change below can fix your issue?  If yes, I will send a formal patch.

Indeed, I am working on an AMD 3950X, and have glibc 2.40 installed.
The patch you sent didn't work out of the box, but with minor modifications
I could fix it. I just needed to replace nm -D $libc with nm $libc for it work.
The reason is that gaih_inet doesn't show with nm -D for my glibc:

$ nm -D /usr/lib64/libc.so.6 | grep getaddrinfo
0000000000116a40 T getaddrinfo@@GLIBC_2.2.5
000000000010c140 T getaddrinfo_a@GLIBC_2.2.5
000000000010c140 T getaddrinfo_a@@GLIBC_2.34
$ nm /usr/lib64/libc.so.6 | grep getaddrinfo
0000000000116a40 t __GI_getaddrinfo
000000000010c140 t __getaddrinfo_a
0000000000115e53 t __libc_getaddrinfo_freemem
0000000000116a40 T getaddrinfo
000000000010c140 T getaddrinfo_a@@GLIBC_2.34
000000000010c140 T getaddrinfo_a@GLIBC_2.2.5

$ nm -D /usr/lib64/libc.so.6 | grep gaih_inet
$ nm /usr/lib64/libc.so.6 | grep gaih_inet
0000000000115405 t gaih_inet
00000000001139b2 t gaih_inet_serv
0000000000177780 r gaih_inet_typeproto

Using nm $libc in both cases, and increasing max-stack to 4 allows the test to pass:

$ sudo ./perf test -vF pton
--- start ---
ping 1237113 [000] 18561.204983: probe_libc:inet_pton: (7f7c34d38eb7)
7f7c34d38eb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
7f7c34d4b517 gaih_inet+0x112 (/usr/lib64/libc.so.6)
7f7c34d4cb73 getaddrinfo+0x133 (/usr/lib64/libc.so.6)
55680ac46518 [unknown] (/usr/bin/ping)
---- end ----
 86: probe libc's inet_pton & backtrace it with ping                 : Ok


The final patch I had to apply is below:

perf $ git diff
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 47a26f25db9f..18274e1c315c 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -53,7 +53,16 @@ trace_libc_inet_pton_backtrace() {
                echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
                ;;
        *)
-               eventattr='max-stack=3'
+               eventattr='max-stack=4'
+               # Add gaih_inet to expected backtrace only if it is part of libc.
+               if nm $libc | grep -F -q gaih_inet; then
+                       echo "gaih_inet\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+               fi
+               # The new version libc (e.g. libc 2.36) contains symbol getaddrinfo@@GLIBC_2.17
+               # which is not used. Do strict checking for 'getaddrinfo' without any suffix.
+               if nm $libc | grep -q 'getaddrinfo$'; then
+                       echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+               fi
                echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
                ;;
        esac

Please feel free to add Tested-by: and/or Reviewed-by: Guilherme Amadio <amadio@gentoo.org> 
to the final patch as you see fit. Thank you!

Best regards,
-Guilherme

> 
> Thanks,
> Leo
> 
> ---8<--
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 47a26f25db9f..5a2d641bf166 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -54,6 +54,15 @@ trace_libc_inet_pton_backtrace() {
>                 ;;
>         *)
>                 eventattr='max-stack=3'
> +               # Add gaih_inet to expected backtrace only if it is part of libc.
> +               if nm -D $libc | grep -F -q gaih_inet; then
> +                       echo "gaih_inet\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> +               fi
> +               # The new version libc (e.g. libc 2.36) contains symbol getaddrinfo@@GLIBC_2.17
> +               # which is not used. Do strict checking for 'getaddrinfo' without any suffix.
> +               if nm -D $libc | grep -q 'getaddrinfo$'; then
> +                       echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> +               fi
>                 echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>                 ;;
>         esac
> 
> [1] https://lore.kernel.org/linux-perf-users/20241025132021.GB359792@e132581.arm.com/
> 
> > If you could suggest a way to fix this, I'd appreciate it.
> > 
> > Best regards,
> > -Guilherme
> > 
> > 
