Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151401F472E;
	Tue,  7 Jan 2025 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736277281; cv=none; b=FC1CTckeYsxeOEpWL/igi0NBLAfKdqStIuKVNOLbJ4rVypSYD88eq9SlpiQ7zvS8Qi0XQSQ53p1cNzesME+Irgw6xXwjw37TXiqGGWE1YQkZy+T5NaTnI1VlLWVLGfvctFyUbXhKIks5BkXfdfEb5/CYreR6Uf87aut3RLHfmmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736277281; c=relaxed/simple;
	bh=A3kqU0YE6hKxCPOpaosxEcCZsr5nX+fa1OuCoBjXHLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssMjxbig+dVg6wL22Wy9HvI8Ep8A3j5nlbDsg/BCaKtDRUG3s4epIJnnmU3zLQlPYXo0orbClf4Ci0ItXIkkpJKd7now+OIRDibLmD0oh3PHMk+cUH3xMT/NnFQ0nbbyT6w6nz0dUSYv/r70SPHe19pG5/HtFm1N3f8cvrKQP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4LStcDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4LStcDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C29AC4CED6;
	Tue,  7 Jan 2025 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736277280;
	bh=A3kqU0YE6hKxCPOpaosxEcCZsr5nX+fa1OuCoBjXHLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4LStcDD2cgXHJ/OsJ92gClXa2qAxYNOPgZ247yKpfPLzERO80FNlfsi5dJW9au+n
	 3jBZznvKBgalvIVjBZ+rHifkFiVMKo6v9N9AiJ0PJ7rALe6BhJ7zPHaIxrsOGnej7T
	 fUTOSjz3bbobdL9fupnIsFk1MRMJePKCsdCLpYgOY+oR6CKqvxHyN/zt6L8TiAznPU
	 BpyspfNiUYotBtTq8bW7b6f6f7NHF6UUBWkb+7Rm5qLAuPrxpv5R1PocuWboiN+QOj
	 vfK6sDtUEpKzTA5VWMbeYrY4s1cVQo5fghCYHgwir0RZXn84SPZh/e2HJcQxP1gdjI
	 qN0PFxsrCH5UQ==
Date: Tue, 7 Jan 2025 16:14:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf Documentation: clarify sysfs event names characters
Message-ID: <Z319HMxDr_1j0vid@x1>
References: <20240513192439.18473-1-rdunlap@infradead.org>
 <CAP-5=fX020He2fdmm-tzFY383tSaaOB4q6OBzEtFHgXOW+S00w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX020He2fdmm-tzFY383tSaaOB4q6OBzEtFHgXOW+S00w@mail.gmail.com>

On Mon, May 13, 2024 at 05:44:41PM -0700, Ian Rogers wrote:
> On Mon, May 13, 2024 at 12:24 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > Specify that perf event names in sysfs must not contain mixed lower and
> > upper case characters and that they may contain numbers, ".", "_",
> > or "-" as well.
> >
> > Fixes: 785623ee855e ("perf Document: Sysfs event names must be lower or upper case")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: linux-perf-users@vger.kernel.org
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Looks good to me! Thanks,

Fell thru the cracks, finally picking this up.

- Arnaldo
