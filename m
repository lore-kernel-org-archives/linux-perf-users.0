Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303C170A24;
	Mon,  2 Sep 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267405; cv=none; b=ls+GXNNG5uJfGL8tUd6OP8XLM/QL+NBGtXknHmDqFkegxbRMzDmLQVNmu4VHioYXcZltAfetryAyyHNQl8rGmkCbGyWSirAu+0iZdJ5eEl8B+DktZ2hoV9O0kcKuoYtaxMfkTXwVWlo+kpsuFj/6KeXrn6TGrGGO9pABYGxh4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267405; c=relaxed/simple;
	bh=SQDP6013XDHbO/QnpiFMa3A2WFshi81GsTsmbu8keUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDNFhYbdGrirUxFX+YG5EgGbARieXSVu85lGXhw0rlQp0Lw36V6oaT6u71qLNCmKBrh3PyQZH7ONVh0iFYynNq9ZHBVBRej/2dGkt+FnXKBtalptHYU5dww4n2UmlhlHxoVvpK8TtSqMVVMkn5mj/upkP0d41RCd6+zfHvw66Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZbNtTXub; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZbNtTXub"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9b/IjZ39V9cdoHavHl8NTPM0sJye50Q3ug0+s/XOyYc=; b=ZbNtTXubQ22MdeL3IYB2EXdHAu
	NtNuA7KCl1znuVtizZ6mLhR27QWdigT3QV+CYqqkZyvdWzmwSEBMdr7a1cxpPr3kdfysmhYlLRxpW
	9PJwvdKgPloyrzPeF7l8+1CYHG7pSpbcFJUskawdTAwNV1Q01NqwRAVJn9WL3Dx41W3EEgBepA4No
	yN6J45R6uFB+Sbx9UnVC3l7P6UK6dxHMpSvxR1SllvTnkuHChy02QUAiyFtYQpByrWvyqRYonb814
	QmPHdLZWMYc3AwfQOYaQpbqu1NA03pHfm/w43OkWeaqVG/SH9LmjVAdZ5YH6HcPQRN8Cv2okQ+1v6
	RYCgE38Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl2rN-0000000C7P7-0Euu;
	Mon, 02 Sep 2024 08:56:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4E27A300642; Mon,  2 Sep 2024 10:56:28 +0200 (CEST)
Date: Mon, 2 Sep 2024 10:56:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [RFC/PATCH 0/4] perf tools: Do not set attr.exclude_guest by
 default (v1)
Message-ID: <20240902085628.GA4723@noisy.programming.kicks-ass.net>
References: <20240902014621.2002343-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902014621.2002343-1-namhyung@kernel.org>

On Sun, Sep 01, 2024 at 06:46:17PM -0700, Namhyung Kim wrote:
> Hello,
> 
> I found perf tools set exclude_guest bit inconsistently.  It used to
> set the bit but now the default event for perf record doesn't.  So I'm
> wondering why we want the bit in the first place.
> 
> Actually it's not good for PMUs don't support any exclusion like AMD
> IBS because it disables new features after the exclude_guest due to
> the missing feature detection logic.
> 
> AFAIK it doesn't matter for the most cases but perf kvm.  If users
> need to set the bit, they can still use :H modifier.  Please let me
> know if it's ok for you.

IIRc the point of setting exclude_guest by default was so that default
perf keeps working in the precense of that PMU pass through mess, no?
