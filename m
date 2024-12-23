Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367A1B3948;
	Mon, 23 Dec 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734980776; cv=none; b=XO96hCxPoD56rZk4/eAB3KcdI633MpviznDI3ZME5EoCBiKh/u8gnF138ES7cBmyb3l9Aoave2Gxf1YEmEvm40EfC+zzM7znLZSPGrERMjYAhffApdgYbD36uratH4EiVHqWars2vu48D60eLpsSz01ziPRM52bCvMe5hgA9y50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734980776; c=relaxed/simple;
	bh=UO1Dtfyg+/NWHFYt+qGK8e5Yf/2oj/ZCsonw/gi9Z0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ4v9IP/hejEcJZ1rfXK5Li55n1GUu/GcHDB1rxlhVhfpg1FXJhlKov663ErxjgwOM78VkJu5aB75weNsGlglmphc21HRkmxvTZL7iHzGdBXA/yusFeMWNwnawu1aK3jx427ULOO9PgW1TLEbeB0I6GYKn5BMlKrH7GponDUwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb11hK3M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb11hK3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B28C4CED3;
	Mon, 23 Dec 2024 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734980776;
	bh=UO1Dtfyg+/NWHFYt+qGK8e5Yf/2oj/ZCsonw/gi9Z0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fb11hK3MUzlVOyop/1JCfEGKjdY2fAXf7bXY/ca4NHbBRy8HyftwhicC0s+KUEGXh
	 6uUfIxmvxuHOHImWyMhvHkFYIRNXucwHh90OAd8e4yycaMJSNzYMvSISUd9JKTYrbv
	 lTePac1c1SFkjC8Fdp7u3UUFl0F2+kaIO4K2Ig62pFhKg6cfYvZPMsZjq+yRqonBCV
	 wexhhXmdz39W0BA3BXuYPlvgZkiLLzv+bSTcEOuYaIWPvyqC2uvIhfeRwCbW0p0UtU
	 vmtHoSuVoOKRCONLYcRwDdIwTtLvk32BxA4BIWnPsfMIEXDP8y09f/nrdBhzvTX9a6
	 r6gbn6zUQbjVQ==
Date: Mon, 23 Dec 2024 16:06:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf docs: Add documentation for --force-btf
 option
Message-ID: <Z2m0pWiQgZNXhvxK@x1>
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <20241215190712.787847-3-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215190712.787847-3-howardchu95@gmail.com>

On Sun, Dec 15, 2024 at 11:07:11AM -0800, Howard Chu wrote:
> The --force-btf option is intended for debugging purposes and is
> currently undocumented. Add documentation for it.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/Documentation/perf-trace.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> index 6e0cc50bbc13..fb3d2af33844 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -241,6 +241,11 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
>  	printing using the existing 'perf trace' syscall arg beautifiers to map integer
>  	arguments to strings (pid to comm, syscall id to syscall name, etc).
>  
> +--force-btf::
> +	Use btf_dump to pretty print syscall argument data, instead of using hand-crafted pretty
> +	printers. This option is intended for testing BTF integration in perf trace. btf_dump-based
> +	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
> +	better pretty-print integer flags and struct pointers.

Applied, but for the casual reader the "btf_dump" reference is vague, it
would be interesting to mention that it is part of libbpf and uses
only what is available in the BTF format.

Then talking about the "hand-crafted" pretty printers, it is not all the
time "hand crafted", but automated by all those shell scripts that
convert kernel source code that doesn't get converted into BTF info
(defines) to create tables that then get associated with those syscall
args or even struct members.

But that is something for a followup paches, I'm applying it as is as it
improves the current documentation.

- Arnaldo
