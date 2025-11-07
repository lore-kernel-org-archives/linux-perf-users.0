Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300802046BA;
	Fri,  7 Nov 2025 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481340; cv=none; b=Ukv8en9+JjOKcm1VQIzbTBnD8xCuST9Og05nCnBdSthvNDuY9Fmo1R47NrhtA+zbm+QF9ZxMwPjyxHmsJpaFlGUPxLw99WqKYHPBiGgamKCnd2E1HHAtgW8LaECrzYo+OEkZiuzqcRVi1tyzwTUMXei/DPNrqBPDDdpvsnwPBnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481340; c=relaxed/simple;
	bh=aYkxBJryonFS6y9A2M4HFqBrn5F6mENBoEdIZ0N1Jjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgyIvtMwr+10pUCMRKTf7zTe3EUnDq9FZbNiD2EKOWcmaXMrL2/qEnc7jLu17l2TR/W7epidyU+adramKNaq92evYPvc0wfhAKM7NKN7lEsT6jXS3W3VWcKsfcsME0tMy4yCJwM3LBXHyg1+GoJX217AR/mxl5trhnYUmGH2soA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/Fv5NpM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/Fv5NpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC56C116D0;
	Fri,  7 Nov 2025 02:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762481339;
	bh=aYkxBJryonFS6y9A2M4HFqBrn5F6mENBoEdIZ0N1Jjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/Fv5NpMfAG4O50Te/AJ01//QaIqVwyrHi6mwYuGv9/hXyC75onmMHKcqQxvFr5tu
	 jwnr8cyPemmfNjmUhm3EXHNpE2ncB6DFEJqo6dmM2+n/m6ibMXm9JAlX/7P7RHjvQb
	 q/v+NBceE1q47OitScUbt4AwrGakOSg6WEN+x1dSsvJHnjSzEPj1qf4YqnjXV4UJvI
	 YEXBwI89t74wEx9NEKqlZN5DTwgY2On/4M5kDAEHgQwdS3pUR5L/QDEtwgIKx5AtGw
	 gsHd9IPT67Uqt+Tey1PmYsMrI8DMh6cj4LPjN2AfkN6beGYbBk7/eJ7s081ZGdGWIq
	 2jcew7BN0I0XA==
Date: Thu, 6 Nov 2025 18:08:57 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 4/5] perf test java symbol: Fix a false negative in
 symbol regex
Message-ID: <aQ1UuVQdjZa7HYOF@google.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
 <20251105191626.34998-5-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105191626.34998-5-iii@linux.ibm.com>

On Wed, Nov 05, 2025 at 08:10:27PM +0100, Ilya Leoshkevich wrote:
> There are a lot of symbols like InterpreterRuntime::resolve_get_put()
> in the perf report output, so the existing regex unfortunately always
> matches something. Replace it with a more precise one.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/perf/tests/shell/test_java_symbol.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_java_symbol.sh b/tools/perf/tests/shell/test_java_symbol.sh
> index f36c9321568c5..4c6bc57b87181 100755
> --- a/tools/perf/tests/shell/test_java_symbol.sh
> +++ b/tools/perf/tests/shell/test_java_symbol.sh
> @@ -55,8 +55,10 @@ fi
>  # Below is an example of the instruction samples reporting:
>  #   8.18%  jshell           jitted-50116-29.so    [.] Interpreter
>  #   0.75%  Thread-1         jitted-83602-1670.so  [.] jdk.internal.jimage.BasicImageReader.getString(int)
> +# Look for them, while avoiding false positives from lines like this:
> +#   0.03%  jshell           libjvm.so             [.] InterpreterRuntime::resolve_get_put(JavaThread*, Bytecodes::Code)
>  perf report --stdio -i "$PERF_INJ_DATA" 2>&1 |
> -	grep -E " +[0-9]+\.[0-9]+% .* (Interpreter|jdk\.internal).*" >/dev/null 2>&1
> +	grep ' jshell .* jitted-.*\.so .* \(Interpreter$\|jdk\.internal\)' &>/dev/null

Maybe 'jshell' part can go away as well.. but it's up to you. :)

Thanks,
Namhyung

>  
>  if [ $? -ne 0 ]; then
>  	echo "Fail to find java symbols"
> -- 
> 2.51.1
> 
