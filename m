Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC818785D
	for <linux-perf-users@vger.kernel.org>; Sun, 24 Nov 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732445468; cv=none; b=XFv4zKWuVmmLXiU0NkVljratiy85GSWctqjuiclAVKYGu2eZsTMFXF0TzH3eE2r+m5ZbiQNSatQPU7TWcsGhLwKOGY+BWtjQyVwbLKyQrfzQcysyOsHNBMQPSnNMS2EbJ2B+jlNUk6KNjkCrKRxguJfoEK4NMourB8bsuRZeQDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732445468; c=relaxed/simple;
	bh=psJEf+m22acucC3woMg9+j7IJ+o0KH2DyDdbijEyQ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CflcswOVKTUYXYKw/JeJ1MI/SNRv1f0oLDUkxaReOlCDgUAP8Avrx4LbsmTIP19ymeEMmZB+FMgF0HOhLpncDd0AuX7Vg8RNdf8PnmCgthCr0lFo5UUldH0gH+aeGMr/d2TSaLvX9m+06goXILBcAatu63GynisuxBrU7Mp3v+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB4B7152B;
	Sun, 24 Nov 2024 02:51:29 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FDC53F5A1;
	Sun, 24 Nov 2024 02:50:59 -0800 (PST)
Date: Sun, 24 Nov 2024 10:50:53 +0000
From: Leo Yan <leo.yan@arm.com>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Subject: Re: perf test for inet_pton probe fails to match stacktrace
Message-ID: <20241124105053.GA812108@e132581.arm.com>
References: <Z0D5FDu/sErQ0V/2@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0D5FDu/sErQ0V/2@gentoo.org>

Hi Guilherme,

On Fri, Nov 22, 2024 at 10:35:16PM +0100, Guilherme Amadio wrote:

[...]

> Hi Arnaldo, Namhyung,
> 
> I've had this test fail for me since a while, so I'm reporting below
> in case we can find a good solution to fix it on my system without
> breaking other OSs. The test that fails is this:
> 
> gentoo ~ # perf test -vF inet_pton
> --- start ---
> ping 303105 [029] 47754.974977: probe_libc:inet_pton: (7f70ca48feb7)
> 7f70ca48feb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> 7f70ca4a2517 gaih_inet+0x112 (/usr/lib64/libc.so.6)
> FAIL: expected backtrace entry ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" got "7f70ca4a2517 gaih_inet+0x112 (/usr/lib64/libc.so.6)"
> ---- end ----
>  92: probe libc's inet_pton & backtrace it with ping                 : FAILED!
> gentoo ~ # perf version
> perf version 6.12
> 
> Here's why it fails. My stack traces has more than the test expects:
> 
> gentoo ~ # perf script | tac | sed -e /^ping/q | tac
> ping  267392 [010] 42482.886216: probe_libc:inet_pton: (7f168d9b4eb7)
>             7f168d9b4eb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
>             7f168d9c7517 gaih_inet+0x112 (/usr/lib64/libc.so.6)
>             7f168d9c8b73 getaddrinfo+0x133 (/usr/lib64/libc.so.6)
>             55947171a518 [unknown] (/usr/bin/ping)
>             7f168d8d6a72 __libc_start_call_main+0x7a (/usr/lib64/libc.so.6)
>             7f168d8d6b29 __libc_start_main@@GLIBC_2.34+0x84 (/usr/lib64/libc.so.6)
>             55947171ac55 [unknown] (/usr/bin/ping)
> 
> Likely this is due to how I compile glibc:
> gentoo ~ # cat /var/db/pkg/sys-libs/glibc-2.40-r5/CFLAGS
> -Og -march=native -Wl,--build-id -gdwarf-4 -fno-builtin-strlen -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer

This is not the first reported failure on this case, see [1] for
previous one.

I assume you are working on x86_64 machine.  Could you confirm if the
change below can fix your issue?  If yes, I will send a formal patch.

Thanks,
Leo

---8<--

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 47a26f25db9f..5a2d641bf166 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -54,6 +54,15 @@ trace_libc_inet_pton_backtrace() {
                ;;
        *)
                eventattr='max-stack=3'
+               # Add gaih_inet to expected backtrace only if it is part of libc.
+               if nm -D $libc | grep -F -q gaih_inet; then
+                       echo "gaih_inet\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+               fi
+               # The new version libc (e.g. libc 2.36) contains symbol getaddrinfo@@GLIBC_2.17
+               # which is not used. Do strict checking for 'getaddrinfo' without any suffix.
+               if nm -D $libc | grep -q 'getaddrinfo$'; then
+                       echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
+               fi
                echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
                ;;
        esac

[1] https://lore.kernel.org/linux-perf-users/20241025132021.GB359792@e132581.arm.com/

> If you could suggest a way to fix this, I'd appreciate it.
> 
> Best regards,
> -Guilherme
> 
> 
