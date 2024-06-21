Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D89C208CE;
	Fri, 21 Jun 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980541; cv=none; b=fModIEkkR5qyGsLoJP1Fg9Ah4/17VUWqqJwsIuoiMTVXTwOZ+5csNMjfET6AZ88kzNmh2Fsz6RaXgk8Fh2ih702a9gioNe5Ex8U+pw39dZD+iQkk+GBJmgisa5OM6JvQHN23jyz55JP7ujCj4zLmGKd5QF8LNiGRYIDl99l0uFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980541; c=relaxed/simple;
	bh=UJ+SRvU/bulfahxJZqM9gPX5fFpLKj0ALCN9+nL+mkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmFSxUgzN5L7GoNdOeFx2leUZvZx1wGD1lO2VPGOiRL7JVL6T5II/R+F1UnTucVCgSjJ1iRVkAb32l17BwfuKgjOCvR1oNQLjYhm7GsLCjF90VwDrN5xK17iZxbV5up25677HdiVlIOh88p008+YzMH707c6G7TqYbf7JKKuetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYnrNgxb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYnrNgxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB343C2BBFC;
	Fri, 21 Jun 2024 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718980541;
	bh=UJ+SRvU/bulfahxJZqM9gPX5fFpLKj0ALCN9+nL+mkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYnrNgxbIJoeVfw6BM1pUffYaquyHRbDCcE7eH5Q5xXl2/repXtsOfPkJ5Ql9pxdT
	 Lz+Si9qcXQMdECcHQb/IhXA4fWgkDIGiWH4ejh6xBUm4wzcKnSIcFKALNlJgm6MBzS
	 Q0WYRts0EIwTUqQt3VtbLoJDDFD3DF+jV9Vtd9xsVdCqCV9OHq0ijt1AarJsux3IUq
	 ImoFxauC4O5PQ+SsIScR/QN8agKQFyVmiXAqgTyD0Xu7GzWixRkLd2JPE3FW5UdqON
	 o5X44EFEnGoQBAzIDl9vgxK/HiIy5pN9NOOUNYTe4yJb9qwInvYQ8+/+QAC4uQZfLK
	 JvA3QY7t5nK5g==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Cc: irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	yangjihong1@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	sandipan.das@amd.com,
	ananth.narayan@amd.com,
	santosh.shukla@amd.com
Subject: Re: [PATCH v2] perf doc: Add AMD IBS usage document
Date: Fri, 21 Jun 2024 07:35:39 -0700
Message-ID: <171898052835.3878160.8196161443570128436.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240620054104.815-1-ravi.bangoria@amd.com>
References: <20240620054104.815-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 05:41:04 +0000, Ravi Bangoria wrote:

> Add a perf man page document that describes how to exploit AMD IBS with
> Linux perf. Brief intro about IBS and simple one-liner examples will help
> naive users to get started. This is not meant to be an exhaustive IBS
> guide. User should refer latest AMD64 Architecture Programmer's Manual
> for detailed description of IBS.
> 
> Usage:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
