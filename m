Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7513C80E;
	Tue, 26 Nov 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641291; cv=none; b=OaXbd3V9aHtgLE9AFHBwollsH7+jcdkF6druUyrzQSEOqMLp2kFS1d5F/sLOLAuBATS0oTBxeV0pvCO2na9w412EY/DQF3jH6ve4UIUX7a0DL78uHoNRmjYpMaBWr/mvDd9xLRjD22vDvNUh/Bw1sss5HBp46EJVtAxmUUekyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641291; c=relaxed/simple;
	bh=OwhxZvDVQ7bvUBv/17VAKyR0yrW09XDtvEmrBb0tY98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lit4pvfCu279OWOytSyZcJNUdx7VuAkz9e3eQ3wLKanYdvBbwbDyJ0LWmAnWKt2MnIjrPois98B7Si/NK9z3kzM0hfV0vMwompBWMNJGDE0FxNZccP9qy6pdf6UIHEWNo8gzXvsl6lpb7xXQZODe1kIuks6Bg3eoHTD1INbqUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdA1cxa2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdA1cxa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6264C4CECF;
	Tue, 26 Nov 2024 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641291;
	bh=OwhxZvDVQ7bvUBv/17VAKyR0yrW09XDtvEmrBb0tY98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdA1cxa2DMUuXe/zKICtOnyeuA0Nn0QepmepPii2stxo3nY9nh9JPp0yjWIYmHwIP
	 jOgL65CiM7wxqf2Hc4guRFYG5KLpLZ1D/fpfNET2bMAl/3LDnyw3mnNIrGvvw1RFKo
	 9v8nl2S1bhTIWOGnWdSXvBIfIitSAfedYVXevjDBFfnc2rAgQbtD5Pe+sHGiDdEvx+
	 WdsSBOiBKcc8ZEMd/RZpYuFIjRfD4KGRY1SmCfEe9usuhbIhAJyT29JAPOBNORcUWa
	 HtvukFT3xJE/OzI0CnGgZEWYPHSfFFuiYdZtWJbwCyhO4chtcHciuw5fy+/QKh+Q5h
	 D8IvtzhQpA1BA==
Date: Tue, 26 Nov 2024 14:14:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf docs: Add documentation for --force-btf
 option
Message-ID: <Z0YCCFRPahESJqfm@x1>
References: <20241123005512.342079-1-howardchu95@gmail.com>
 <20241123005512.342079-3-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123005512.342079-3-howardchu95@gmail.com>

On Fri, Nov 22, 2024 at 04:55:11PM -0800, Howard Chu wrote:
> The --force-btf option is intended for debugging purposes and is
> currently undocumented. Add documentation for it.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/Documentation/perf-trace.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> index 6e0cc50bbc13..529081599cc7 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -241,6 +241,9 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
>  	printing using the existing 'perf trace' syscall arg beautifiers to map integer
>  	arguments to strings (pid to comm, syscall id to syscall name, etc).
>  
> +--force-btf::
> +	Use btf_dump to pretty print syscall argument data, instead of using hand-crafted pretty printers.
> +

I think here we could expand a bit and explain that we want this for
testing the BTF code, and also mention that the hand-crafted pretty
printers know about integers -> strings, how to pretty print flags, etc
that BTF doesn't.

- Arnaldo

>  
>  PAGEFAULTS
>  ----------
> -- 
> 2.43.0
