Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFCE2D0631;
	Fri,  7 Nov 2025 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481259; cv=none; b=QIa9f//rhLDq60/sIllirIgtblpul1LhKytlGkipxrqVOXugybtFr2kciCeA7yzTwqv7+xvVu8xciDF44yejh4/zMVpfkm0nvq2cZGS6+8MBzXOiUXjTLqQvejl0H4RE7Zk9FS9yAq3p3Fp7ios/33IiMMWr6H0zDB8300Qwba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481259; c=relaxed/simple;
	bh=Jpz/o6sb9/p5BOniyc+LXuWr4Tjo1gMjStMQs7mmmjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie3mgQZFOAy6RVjPix/OzsQFJ+hcasN9K8RlZPrn3kR+SSF95D5y4ZM3eqlqicrrOrzsW5uzKDLoo2ouKexFDhyT7t36x5uPAxbZo7MnB48CRvsswCF2KODE/St6nPvWPXWPfHJFmsh9vPYpGOrDVxH8y6gH+vb/Ouctc3g8LRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvZehhm5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvZehhm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E084C116C6;
	Fri,  7 Nov 2025 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762481258;
	bh=Jpz/o6sb9/p5BOniyc+LXuWr4Tjo1gMjStMQs7mmmjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvZehhm5OERMbBp9TkEV973lEtagbutXbbhoVlncc/+pDhhB8MH3NgA4frma4vomd
	 PZJBOikmUE3Dcl6eoa9kAe4c+pdsu4TSWfFXrOxusj0+BBJZluJOw8y38eWw7P7GHp
	 dAbDEdfPxidVWM6DaFCH85vs5PicAPEjpZDmHE7wD6VMVSjGmqtRbO1URHS+2bYPsD
	 m5qgZeID1wqrtbhyWaAgGjmSiSSWS7IyHuhaph+pskb5e+Ro3w7nkTEjtuManoHpu+
	 ULqoElEKO77ZAVtZRFBBZ/q+v+1mg6Et9DTxAZgsyDYpBZjWIIHjhjo6fdGrrdy0bC
	 SL/gx/eINrMZw==
Date: Thu, 6 Nov 2025 18:07:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 2/5] perf test java symbol: Get rid of shellcheck warnings
Message-ID: <aQ1UaEbSM6jmjNEU@google.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
 <20251105191626.34998-3-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105191626.34998-3-iii@linux.ibm.com>

Hello,

On Wed, Nov 05, 2025 at 08:10:25PM +0100, Ilya Leoshkevich wrote:
> Add missing quotes and suppress the $? warnings.

Can you please share the actual shellcheck warnings you see?

> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/perf/tests/shell/test_java_symbol.sh | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
> index 499539d1c4794..b1d7cd43af01a 100755
> --- a/tools/perf/tests/shell/test_java_symbol.sh
> +++ b/tools/perf/tests/shell/test_java_symbol.sh
> @@ -4,6 +4,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Leo Yan <leo.yan@linaro.org>, 2022
>  
> +# Allow [ $? -ne 0 ], because long commands look ugly in if statements.
> +# shellcheck disable=SC2181
> +
>  # skip if there's no jshell
>  if ! [ -x "$(command -v jshell)" ]; then
>  	echo "skip: no jshell, install JDK"
> @@ -13,11 +16,12 @@ fi
>  PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  PERF_INJ_DATA=$(mktemp /tmp/__perf_test.perf.data.inj.XXXXX)
>  
> -cleanup_files()
> -{
> +# Shellcheck does not understand that this function is used by a trap.
> +# shellcheck disable=SC2317
> +cleanup_files() {

Please minimize unnecessary changes.  It seems you don't need to change
the function declaration.

Thanks,
Namhyung


>  	echo "Cleaning up files..."
> -	rm -f ${PERF_DATA}
> -	rm -f ${PERF_INJ_DATA}
> +	rm -f "$PERF_DATA"
> +	rm -f "$PERF_INJ_DATA"
>  }
>  
>  trap cleanup_files exit term int
> @@ -38,7 +42,7 @@ else
>  	exit 2
>  fi
>  
> -cat <<EOF | perf record -k 1 -o $PERF_DATA jshell -s -J-agentpath:$LIBJVMTI
> +cat <<EOF | perf record -k 1 -o "$PERF_DATA" jshell -s -J"-agentpath:$LIBJVMTI"
>  int fib(int x) {
>  	return x > 1 ? fib(x - 2) + fib(x - 1) : 1;
>  }
> @@ -56,7 +60,7 @@ if [ $? -ne 0 ]; then
>  	exit 1
>  fi
>  
> -if ! DEBUGINFOD_URLS='' perf inject -i $PERF_DATA -o $PERF_INJ_DATA -j; then
> +if ! DEBUGINFOD_URLS='' perf inject -i "$PERF_DATA" -o "$PERF_INJ_DATA" -j; then
>  	echo "Fail to inject samples"
>  	exit 1
>  fi
> @@ -64,8 +68,8 @@ fi
>  # Below is an example of the instruction samples reporting:
>  #   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
>  #   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
> -perf report --stdio -i ${PERF_INJ_DATA} 2>&1 | \
> -	grep -E " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" > /dev/null 2>&1
> +perf report --stdio -i "$PERF_INJ_DATA" 2>&1 |
> +	grep -E " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" >/dev/null 2>&1
>  
>  if [ $? -ne 0 ]; then
>  	echo "Fail to find java symbols"
> -- 
> 2.51.1
> 
