Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25AF33BBC5
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862556; cv=none; b=rki3OXlGVbylavLfpXyqVhpxW3Kq5+rdKJScWo39l5eUZ9TeDyKtY+BJzmMzwKxNZwfRmIYMMAz/l3Wgt+Y27ItVLA1ym9JSFfBkL2QkxVBvOIatkAg9ekKMh0S3BgOdS5RkfruVUdvCJ09gChlV8wnBivxBhPUZNA7e0yuqsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862556; c=relaxed/simple;
	bh=R6/lNprf3XopTBkoLQ/IA57GHr7GS5JmbPj3hHdMYBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qhtloKzsQolDqgNuYI7ULIum4mt4MT7/keem9Up1Ge/MyabXMe/o0l9FG/hbkz4HTKof2RsaBRe1QykiIyFthWhQwz0nWexloeAgciaEKaUdGuj6fLtNnK2ciAS4Hyz3WMO7PySTjpIhoNv77/81ykfH05o/S7VshNSU33JDtzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPQAWvAU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPQAWvAU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC911F000E9;
	Tue, 30 Jun 2026 23:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862555;
	bh=HmFMDFyhQyPzL19OlIThHEGh44G8j5Qf3IksoY5ASOM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lPQAWvAUrm+RoTwETKNM1dRWqZFMtALxDNmsprBGUZl8yl7wSCs15/DUWraYAir14
	 T+0sDd2nOuOm9Jfi0I5Oxz7cbau2FMeoc2epI5ufD0JXJZzyrsTJ/vJYYeQWopsOBf
	 qhZ5qK/ouu6BCXLhOblGoEXXRykn0YDyoN+aBuky6vqP1770cUt8uKAPg2TuM4eaT9
	 wkuf0RcHplcITd8usAJTzqgB/jnd66hgjErvOli/K492+o/XkLqAgOC3DB/4kMMEig
	 ZNiX/YPDTsu6SnDnexRqWJ7kqMs2yXvcPy+erwjk1Qj8eYyxuscJRc07uszmpuikyj
	 EPvE6lV9kfseA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com, 
 irogers@google.com, ravi.bangoria@amd.com, 
 Shivani Nittor <shivani@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com, 
 Tanushree.Shah@ibm.com
In-Reply-To: <20260627090334.67847-1-shivani@linux.ibm.com>
References: <20260627090334.67847-1-shivani@linux.ibm.com>
Subject: Re: [PATCH v3] perf scripts: Add configurable sorting option to
 powerpc-hcalls
Message-Id: <178286255535.2863034.1843900416080780002.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:55 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 27 Jun 2026 14:33:33 +0530, Shivani Nittor wrote:
> The powerpc-hcalls.py script currently prints hypercall
> statistics in a fixed sort order based on the number of
> hcall occurrences, making it difficult to analyze hcalls
> from different execution characteristics.
> 
> Add support for runtime-configurable sorting so users
> can order hypercall statistics by count, minimum
> latency, maximum latency, or average latency using
> a --sort option.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


