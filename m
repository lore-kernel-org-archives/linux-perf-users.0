Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B122BB17
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777859368; cv=none; b=HnWV6IvL8FPoYKIWvgyWIdqTt/0gW4XMmkXEfwqcV0LujybeUNEKib70G4NMLnPgj/qgcwqqLXdB4fI1nijuMVcsQrTd+hUxS00A2eELO1fxXF98Youd/usPItH8NlRCWdOjsuCW2FOPWgS0hCm1wZP028Jyqn6Q/zgcOerde+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777859368; c=relaxed/simple;
	bh=UxNq48/xbu0OvKDwkGIsg6liRabxxjbEHw+/9JiWl3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYcrrYVSckNZSpu6ai1sgyl+OKMTPkXIvD9bRXfOZBNw+z0pzKuwEpACof7OUa3gkaI4cduwD3uskMnqDTcE2eg+qdb9QREqHbqt6bI9UyneFvGmp4/l3OmcJdS3ELNcku9LdBeFCNtLUGYzMG1UZmPI/RwnDax744ZnXILDp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJncZUcT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJncZUcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D21C2BCB4;
	Mon,  4 May 2026 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777859368;
	bh=UxNq48/xbu0OvKDwkGIsg6liRabxxjbEHw+/9JiWl3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJncZUcTdPQY5pjU3vl2D7/Zzm4ANjgyl8Al7X26x4TXYHwAMNXdBCIICyb7s/L9G
	 YP6X2CicFiinb14LdH2JW+195aOaA0Rj0GgYkFde83r3MfvVj7qIWN5UY5cljgs0AB
	 l0rORGmOOxg1dhL/99CC+QJWgNTQSBwedNi1JMflEnl1gVN7Emc1LEZ+8IEH73l5Xv
	 Yod4f/aH7Joak6kKk7VGnWN2EZmQIQMfeImh6gcnE6K4tY4oOSFkMsbxZ+0sKoNGSm
	 PPMP1gLMsSqAtgG0aD2iQkdD91dPeJAyWzeXPFXYUW57tEx5Xh6FKgRIcXbhhVLnVM
	 uHVT54pRnBsdw==
Date: Sun, 3 May 2026 18:49:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com
Subject: Re: [PATCH V3 1/2] tools/perf: Fix the check for parameterized field
 in event term
Message-ID: <aff7JnNuWpj4Mvss@z2>
References: <20260502141258.17128-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502141258.17128-1-atrajeev@linux.ibm.com>

On Sat, May 02, 2026 at 07:42:57PM +0530, Athira Rajeev wrote:
> The format_alias() function in util/pmu.c has a check to
> detect whether the event has parameterized field ( =? ).
> The string alias->terms contains the event and if the event
> has user configurable parameter, there will be presence of
> sub string "=?" in the alias->terms.
> 
> Snippet of code:
> 
>  /* Paramemterized events have the parameters shown. */
>        if (strstr(alias->terms, "=?")) {
>                /* No parameters. */
>                snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
> 
> if "strstr" contains the substring, it returns a pointer
> and hence enters the above check which is not the expected
> check. And hence "perf list" doesn't have the parameterized
> fields in the result.
> 
> Fix this check to use:
> 
> if (!strstr(alias->terms, "=?")) {
> 
> With this change, perf list shows the events correctly with
> the strings showing parameters.

Any real examples?

Thanks,
Namhyung

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> ---
> Changelog:
> v2 -> v3:
> Split the strstr correction in a single patch
> 
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 23337d2fa281..0b8d58543f17 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
>  						   skip_duplicate_pmus);
>  
>  	/* Paramemterized events have the parameters shown. */
> -	if (strstr(alias->terms, "=?")) {
> +	if (!strstr(alias->terms, "=?")) {
>  		/* No parameters. */
>  		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
>  		return buf;
> -- 
> 2.47.3
> 
