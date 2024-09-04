Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9971DA61C;
	Wed,  4 Sep 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454327; cv=none; b=TyesS1Kz2sSbtxdJdZPPqhNr0EShsBzZV4cbFwMOyG90cwx2t9aSfnrewqTgGGKMb3iJOcD/lgfhDf77zl7+Ey3Nr1FL6i1SmEwKZi/03iSJzQnxS1cDx9Rl91eTiTmBsrAnC+Apdt9/2LB1XgHQnbiC7CFx2Tq9ul1LhIi8keM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454327; c=relaxed/simple;
	bh=PolUDoiLK1Rlm0vB2fRgVhY7iyZj2X/5X7qhFSMKruY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBgAmLQ9TmArzacVkPgQOQecO50WZEMhH35hpyN2iAVNtwO2LuwCzjpTYl2lObWSNT2/lF5wQQJrVHgMJoyPmV/h0L0kbQLFqwgy2O1gzZh6vr0uDiohXYhYngYnHBvWTzf36Z1Ywjt5iTnQ7pjV3wlRQlWcCA8EemrOR6EN3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJSpbqSB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJSpbqSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89E7C4CECC;
	Wed,  4 Sep 2024 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725454326;
	bh=PolUDoiLK1Rlm0vB2fRgVhY7iyZj2X/5X7qhFSMKruY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJSpbqSBF46hEtoAb2DfXFr/qsQBsYZHwiPFoLTXhG12aesJmUTxe2NsCG7X3nMYh
	 whU7FDctNPBPhnUPzI14mNXLJDLe8HSROu6+aGMlRt0lZxTtH20rE6s6AonV7GHn7D
	 puxgSWsWSEBcEFsPlhqnRzDbY/xftsjdv1mduDyt8CbfnWbOIdZdWJl+x8W//uPFjM
	 35+1TO4hHA3m+bxxHx4zBlj2l3WvDPi8VvkHOKhzvCIWm2LofMrX056E9XSLywF/5q
	 GbXh0AFSNVry4MjyQiR0YWfYcVj3N6tyKV9EzggHC2LkLTpBIyweXYhUzBQRPJ0Ql4
	 yALwGUgJe4OTw==
Date: Wed, 4 Sep 2024 09:51:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Various 32-bit and test fixes
Message-ID: <ZthX7bVSLYrlcey4@x1>
References: <20240904050606.752788-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904050606.752788-1-irogers@google.com>

On Tue, Sep 03, 2024 at 10:06:00PM -0700, Ian Rogers wrote:
> The 4th and 5th cases fix the breakpoint length, on i386 so the
> sizeof(long) used matches the kernel's sizeof(long). On aarch64 the
> value is change to 4 instead of sizeof(long), ie 8, as future kernels
> may make 8 an invalid argument.

Applied these, the others were already in tmp.perf-tools-next, thanks.

- Arnaldo
