Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7223BBFB6
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609949; cv=none; b=YE2EzTHuGC9vM/W7dZYrUEJ3Oz5cILtbyrcsE4pq2Ca246JZIMoU5r+L8xh1u4r0maYxRO9UiTHYG4SKuEou/xote8N3W3a/WClk7mdimK6TlHEdf1fQ6jwnADD2jJxCRrRXbjxM4xrW3ob3rQFF7eI9eHSgS4d78Gctu5gY0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609949; c=relaxed/simple;
	bh=C8PpqxHtCUxy871Bsv2J5UchfToJP8rxEMjN8+ETDWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAP4xEm6qFXKEYHa3Vm/ao+JOS9Cqhb2JIffzG7MSMyytruMMOxvZs9udxCEy5ncC3geOS14yOKrchg/vY1yu/7OWV/agBtRpQZZCiB9hA6um3kTHCMTtF5n4l96BaPdMIDP3zB4lzAf8W8070NO6Gdb4nYxl2ASBIXJ12eoclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i92lQs6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i92lQs6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0DC1F00893;
	Thu,  4 Jun 2026 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609948;
	bh=fEjGHV8Fh+4Wvs1j80TCC9VXLoykQeG085QL6MDeL48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i92lQs6h8zWfthmQ+p5z3z+wlWuCZc3L20OkLbLNFHFZYQwh660n0A3HPg+o4Fz7p
	 O//xcHsTpMk7nDQ+xlo59mTNgu+gP253y2BNM1UBhL53mMVu6CQRcvCRAsWDUCUsrd
	 O3WNqjQS8+yfyV7P507ddrSYZ75HJMI3+Od3R7ZurIQU5TtbHTszNX+m6uwHKdLUYw
	 35/cJ9HBBLoBiZJ7jquAYVrX36l4EuudHoPmi5Fqyp2xgno9FVdIfRnwO/KfMYGvGB
	 Jrw5+17mcFgFqW+V7lZXLK1/w9ESNn+tyRnHJoncKADWrdx3kEPZ6auH9Zu8YGFX7C
	 zWs8Ck6WuiCKA==
Date: Thu, 4 Jun 2026 14:52:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	shivani@linux.ibm.com
Subject: Re: [PATCH V4 1/2] tools/perf: Fix the check for parameterized field
 in event term
Message-ID: <aiHzm5SJskW1FbSs@google.com>
References: <20260504154205.21394-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504154205.21394-1-atrajeev@linux.ibm.com>

On Mon, May 04, 2026 at 09:12:04PM +0530, Athira Rajeev wrote:
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
> 
> Before the fix:
> 
>  # ./perf list|grep -w PM_PAU_CYC
>   hv_24x7/PM_PAU_CYC/                                [Kernel PMU event]
> 
> With this fix:
> 
>  # ./perf list|grep -w PM_PAU_CYC
>   hv_24x7/PM_PAU_CYC,chip=?/                         [Kernel PMU event]
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> Changelog:
> v3 -> v4:
> Updated commit message to show real example
> addressing review comment from Namhyung.
> 
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
