Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E56B67A
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732597698; cv=none; b=f7VKF4NdqXwH1pS8tYNYDE4NH1AoIYtB4XYvRqo/8v9ASK5a+wuDdiv2VbmHzdAxge5avbQr7rbTmaMyfoJdY18fWIaj2JbusTa3AwjvsMrMhyzTN2JJDQgJwMbZ2yQg9lYbXaKcI8o9jVIV3mnLnVHmwYNRbrYHiXIzA0oE81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732597698; c=relaxed/simple;
	bh=0P+hCGv/BbeIil0a1iHn9w0OdV5f96PghQ+7fxGVynI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAPJ52eilEyayuncX9IUhdODa7OtP1+AWm/ZZh83ifdlBzUq3JdBw0E0Ss2hSk6pgmbwt/NQV8JhNB7F+iV4IxGfcMUHJ2vdt3noEZFQAEuzMX8Qp9J/JtJOwAxEIpfK3OlLyaOz4OjFbN0Ne0Irz4uUJjiexZOw8bhaHs2E3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFzsauhp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFzsauhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B95C4CECF;
	Tue, 26 Nov 2024 05:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732597697;
	bh=0P+hCGv/BbeIil0a1iHn9w0OdV5f96PghQ+7fxGVynI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFzsauhpuLa3TI66LIXz5KHd4ISUGARhE/om/W0kVn3lsjqbYzwfxS9OqEFMB8sRp
	 4xwvGRChRowlqxzR1vtDzcYsZ8LZSoDRY43pJa1HK7NTGgJCYkZHM8a37vxN11MFo+
	 9iE0sUcFaLacxKPar8OE7qRZT4VDcxweejAGRunXloLgrkXwbhrmQV3ACJWEpHojfQ
	 yROBdW3mDV+kVolqTcDIa/t3k/0adi81Rl9SM3JN1jKnuYLESJblgAVx9J/A0YqkiN
	 iJFFjU/18ORD7rxn83MeSQSveTrVW0CXqXYBmjkfN6cqHJLrvAZ2D26fGfj0NtCjD5
	 tqIfhrSwRiZbA==
Date: Mon, 25 Nov 2024 21:08:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>, acme@kernel.org
Cc: Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org
Subject: Re: perf test for inet_pton probe fails to match stacktrace
Message-ID: <Z0VXvySyHm4q4r2c@google.com>
References: <Z0D5FDu/sErQ0V/2@gentoo.org>
 <20241124105053.GA812108@e132581.arm.com>
 <Z0R3ySrb8iZQd17O@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0R3ySrb8iZQd17O@gentoo.org>

Hello guys,

On Mon, Nov 25, 2024 at 02:12:41PM +0100, Guilherme Amadio wrote:
> Dear Leo,
> 
> On Sun, Nov 24, 2024 at 10:50:53AM +0000, Leo Yan wrote:
> > Hi Guilherme,
> > 
> > On Fri, Nov 22, 2024 at 10:35:16PM +0100, Guilherme Amadio wrote:
> > 
> > [...]
> > > [...]
> > 
> > This is not the first reported failure on this case, see [1] for
> > previous one.

Right, and I'm also seeing the failure now.

> > 
> > I assume you are working on x86_64 machine.  Could you confirm if the
> > change below can fix your issue?  If yes, I will send a formal patch.
> 
> Indeed, I am working on an AMD 3950X, and have glibc 2.40 installed.
> The patch you sent didn't work out of the box, but with minor modifications
> I could fix it. I just needed to replace nm -D $libc with nm $libc for it work.
> The reason is that gaih_inet doesn't show with nm -D for my glibc:
> 
> $ nm -D /usr/lib64/libc.so.6 | grep getaddrinfo
> 0000000000116a40 T getaddrinfo@@GLIBC_2.2.5
> 000000000010c140 T getaddrinfo_a@GLIBC_2.2.5
> 000000000010c140 T getaddrinfo_a@@GLIBC_2.34
> $ nm /usr/lib64/libc.so.6 | grep getaddrinfo
> 0000000000116a40 t __GI_getaddrinfo
> 000000000010c140 t __getaddrinfo_a
> 0000000000115e53 t __libc_getaddrinfo_freemem
> 0000000000116a40 T getaddrinfo
> 000000000010c140 T getaddrinfo_a@@GLIBC_2.34
> 000000000010c140 T getaddrinfo_a@GLIBC_2.2.5
> 
> $ nm -D /usr/lib64/libc.so.6 | grep gaih_inet
> $ nm /usr/lib64/libc.so.6 | grep gaih_inet
> 0000000000115405 t gaih_inet
> 00000000001139b2 t gaih_inet_serv
> 0000000000177780 r gaih_inet_typeproto
> 
> Using nm $libc in both cases, and increasing max-stack to 4 allows the test to pass:
> 
> $ sudo ./perf test -vF pton
> --- start ---
> ping 1237113 [000] 18561.204983: probe_libc:inet_pton: (7f7c34d38eb7)
> 7f7c34d38eb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> 7f7c34d4b517 gaih_inet+0x112 (/usr/lib64/libc.so.6)
> 7f7c34d4cb73 getaddrinfo+0x133 (/usr/lib64/libc.so.6)
> 55680ac46518 [unknown] (/usr/bin/ping)
> ---- end ----
>  86: probe libc's inet_pton & backtrace it with ping                 : Ok

I think it's very fragile as it depends on specific entries in the call
stack.  As we want to test if perf probe (for uprobes) and perf record
working correctly, maybe it can just check the number of samples only.

Arnaldo, what do you think?

Thanks,
Namhyung

> 
> 
> The final patch I had to apply is below:
> 
> perf $ git diff
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index 47a26f25db9f..18274e1c315c 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -53,7 +53,16 @@ trace_libc_inet_pton_backtrace() {
>                 echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>                 ;;
>         *)
> -               eventattr='max-stack=3'
> +               eventattr='max-stack=4'
> +               # Add gaih_inet to expected backtrace only if it is part of libc.
> +               if nm $libc | grep -F -q gaih_inet; then
> +                       echo "gaih_inet\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> +               fi
> +               # The new version libc (e.g. libc 2.36) contains symbol getaddrinfo@@GLIBC_2.17
> +               # which is not used. Do strict checking for 'getaddrinfo' without any suffix.
> +               if nm $libc | grep -q 'getaddrinfo$'; then
> +                       echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
> +               fi
>                 echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>                 ;;
>         esac
> 
> Please feel free to add Tested-by: and/or Reviewed-by: Guilherme Amadio <amadio@gentoo.org> 
> to the final patch as you see fit. Thank you!

Thanks for the report and the fix.
Namhyung

