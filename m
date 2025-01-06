Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A41E04A1;
	Mon,  6 Jan 2025 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200039; cv=none; b=rN4Q9pwnMtYoDp57CsrCFkcBzHJTGG+OM86NCM3mI4RWXjc+pwH2ez0YJ9Cznj1gvlOzqvmq9tB8+ZqVVTbR8mzNRJvmUp2lUjLhaZAnHKoFtcJCXeLW3RbgZmn/QUAnaiWElWQI6BsxLyoYJVNUm6B3uYAo+b28JtYbhR8COAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200039; c=relaxed/simple;
	bh=z/VadocUdUdIq55MhvoMTnhfHHh4oQRzsFA/UPTb7nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3FDQrmBsDOnZPiN5JQrTuxOqm22vgSUhkpn+Eu+1V0x+Zv9NwdlfS1dpKu9VT0kE4H5C9AYuZ2Q5+RIp3izcN8G8GY8YdWJHmEDiRpDL7kgr84wo4Ei6bSOloCfLhdi3O41VSkrk5spLD0Dr1y7PCbF7zMRZ+6slJCOlvpbnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHHnM/nQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHHnM/nQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07880C4CED2;
	Mon,  6 Jan 2025 21:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736200038;
	bh=z/VadocUdUdIq55MhvoMTnhfHHh4oQRzsFA/UPTb7nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHHnM/nQbk1oAv8v5AOBl4xxOCqvseZqJ7vK1FK1gCAo3XQz6kGOWNThBQRWM7r+X
	 klGkGTx65ryM+XJnFZzdaZJg4ecDWy6rRteFMkSW2z/8hIwJ4C4iAFUGBHzZ4No6Kf
	 cgN5ZproSd1ReD0sIH8ZZmliM7DhDuahkoFu+fgF2pVDYH/EAglbaaP0ca2jxHf+Mr
	 k31G+HI0W/xiKuq8TkFganfdp4N1XQoPFFUi0YPDYvK4mso6Ou6q9BZzc0Pk971Prb
	 eYeCiyZ8QgEdP9O36PYbiXHsoNvCTOHwtXdbwdOFbhJt/zNvX/YvmIIWnZKJUZVC6L
	 XZ796LjJ4IIGg==
Date: Mon, 6 Jan 2025 13:47:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test trace_btf_general: Fix shellcheck warning
Message-ID: <Z3xPY-z0uXQNy6a3@google.com>
References: <20250106164300.734202-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106164300.734202-1-james.clark@linaro.org>

On Mon, Jan 06, 2025 at 04:42:58PM +0000, James Clark wrote:
> Shellcheck versions < v0.7.2 can't follow this path so add the helper to
> fix the following warning:
> 
>   tests/shell/trace_btf_general.sh line 8:
>   . "$(dirname $0)"/lib/probe.sh
>   ^--------------------------^ SC1090: Can't follow non-constant source.
>   Use a directive to specify location.
> 
> Fixes: 0255338d6975 ("perf trace: Add tests for BTF general augmentation")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>  tools/perf/tests/shell/trace_btf_general.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
> index 005c93e6c770..e9ee727f3433 100755
> --- a/tools/perf/tests/shell/trace_btf_general.sh
> +++ b/tools/perf/tests/shell/trace_btf_general.sh
> @@ -5,6 +5,7 @@
>  err=0
>  set -e
>  
> +# shellcheck source=lib/probe.sh
>  . "$(dirname $0)"/lib/probe.sh
>  
>  file1=$(mktemp /tmp/file1_XXXX)
> -- 
> 2.34.1
> 
