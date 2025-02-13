Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081250285;
	Thu, 13 Feb 2025 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739406366; cv=none; b=ERmR6tb8m/gv9dXYE+40HrgJLb1nwwnx1EcjQj5aD4TqoXJqfw388Q4eZAy0C/p/x0/kGrlEV8DuwF8l8hycY29OKZniffsyb1Pqjd3axdTUqfAhbTAHrF6VisS+D8krrJd0F8nOJkTlkmEMCYQKumw4RO6+dShsgbEm73hPOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739406366; c=relaxed/simple;
	bh=nFM5me4xq1gWguZOwtBEVUs5Whc8m0pa1tk/zNsZCQY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qQGpPwCeeYIIh10zL+4JRIX1Q8ne+z/70sStEvQwbznui67K0zYAdnvh/H4njD0Ca09KDrMRlN6dAL/8UuFHtDjjuPEhlaNK/rCj94h+k7mS69wvVAtdl1Y2PK01ZieVQelGr8K6YBADkz67m3cCvcvQq3YtfK0fAn8yLatJXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCPAH/r9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCPAH/r9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB73C4CEDF;
	Thu, 13 Feb 2025 00:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739406365;
	bh=nFM5me4xq1gWguZOwtBEVUs5Whc8m0pa1tk/zNsZCQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rCPAH/r97QD/RFW0lmsmH6kWgsZX1CQghb7COEj1mdrIEAXFRHoyOvjffaeT9BLNH
	 HHdOueGVE8SVlwnRRyxW6kYmeV7C0E4pS7uJO4cwB5+FAZQCP78S/+POK8o31iWtNY
	 gfnpMc12gzouioFTYHHSXbDJ/5ZxWDOw3ndXCS5D5qPBQmi5FN1PIEeSJVD5e76kJp
	 wpQW59HInTX8PsrnpxMfB/w5RH3E+MixN+tUIZiVazAvDNhC5535CBIZ0fFIDvZ6a5
	 FbmMUdsVRDoPi5QgJSXJJVOcdzTJshbj/kyH/UCV/K+9sM06QA1hTeRkmKqXFufscG
	 Imfnj6BgUyKcg==
Date: Thu, 13 Feb 2025 09:26:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
 <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf tools: Use symfs when opening debuginfo by path
Message-Id: <20250213092601.186507efa09e71bac9b898b6@kernel.org>
In-Reply-To: <20250212221445.437481-1-namhyung@kernel.org>
References: <20250212221445.437481-1-namhyung@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 14:14:45 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> I found that it failed to load a binary using --symfs option.  Say I
> have a binary in /home/user/prog/xxx and a perf data file with it.  If I
> move them to a different machine and use --symfs, it tries to find the
> binary in some locations under symfs using dso__read_binary_type_filename(),
> but not the last one.
> 
>   ${symfs}/usr/lib/debug/home/user/prog/xxx.debug
>   ${symfs}/usr/lib/debug/home/user/prog/xxx
>   ${symfs}/home/user/prog/.debug/xxx
>   /home/user/prog/xxx
> 
> It should check ${symfs}/home/usr/prog/xxx.  Let's fix it.
> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Good catch! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  tools/perf/util/debuginfo.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 19acf4775d3587a4..b5deea7cbdf24620 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -125,8 +125,12 @@ struct debuginfo *debuginfo__new(const char *path)
>  	dso__put(dso);
>  
>  out:
> +	if (dinfo)
> +		return dinfo;
> +
>  	/* if failed to open all distro debuginfo, open given binary */
> -	return dinfo ? : __debuginfo__new(path);
> +	symbol__join_symfs(buf, path);
> +	return __debuginfo__new(buf);
>  }
>  
>  void debuginfo__delete(struct debuginfo *dbg)
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
