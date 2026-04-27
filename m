Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE11EA84
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 06:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269673; cv=none; b=PHdiHYk8MRsyS7noO6cKqh5RfM0J0wEiu598S67Vskc638zz/0KuM/e3wjs2D3Mt8BLGBblM2CcCrP0wLq0Pqv0eaYJ9fdISSGpYCfMcU9pGyub5T18hL0imyqKUJGEkgWxGH/F6Nr6vQvvcPbx9abC73LN5aquF2mQvhOLWEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269673; c=relaxed/simple;
	bh=g9npv5wxukUs9LKrIQ3ajPslQck8l4k9MLfaWhvJBzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdEm8aXWAKyf/12q/bhsWZmh70jdFMfK9YtKCvDvx6j48hk4OUj9ISTE0uVc2tvtySQsyZDiu+DZGp0ayprihXSELeR58CDPiXPjoO7VgiE76yAd4lg6PVSqqsVIVQxSmPhd7zXkEwPpIiziN2dQLX44p7jyuAPlYs0rL7VOIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dpyqipqy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dpyqipqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4705CC19425;
	Mon, 27 Apr 2026 06:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777269673;
	bh=g9npv5wxukUs9LKrIQ3ajPslQck8l4k9MLfaWhvJBzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpyqipqyrIZWukguFhhrEmw9M4POHp3fIV5oe9SsFzJ5e83ykzvESZKvmfAjjCshK
	 XLL39NSCWwT6sq9Sv2t6Z/ey5N1kZF7CQd35rfJEwh7L7DFFwnh0f9/W6YjvdLPAWP
	 SAN5E2QlTZxeHVDgj1gkbiYQsD1D3KMoVd77Ovcfg+1Dxe25/Thvi5wplkbN8vqbxp
	 ij/jZ2sN/6Hfhimj82ZzEXzjfwlYWYe1iLGKUlyNw9RwIQ8CSqlONoMfw7I7D2jwk7
	 fVuAG3MWr64HGDfUo0+xrDVN4y/oWnRPzAsCF37KJRhg3huMMlsqtJc/5Emeza6UWf
	 d0ZnZpARSBT0Q==
Date: Sun, 26 Apr 2026 23:01:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com,
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com,
	Shivani.Nittor@ibm.com
Subject: Re: [PATCH V3] tools/perf: Fix the check for parameterized field in
 event term
Message-ID: <ae77o7IID7uC6hOZ@google.com>
References: <20260426080056.16558-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260426080056.16558-1-atrajeev@linux.ibm.com>

On Sun, Apr 26, 2026 at 01:30:56PM +0530, Athira Rajeev wrote:
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
> Other changes in this patch:
> - Replace snprintf with scnprintf in buffer offset calculations to
> ensure the 'used' count will not exceed the "len"

Please split this change into a separate commit.  Ideally each commit
would do one thing at a time.

Thanks,
Namhyung
