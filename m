Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4239903A;
	Fri, 27 Mar 2026 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645262; cv=none; b=PiZACZ3xZXqKGEoIiXWPsxxvYMDCCikRr2w6lnTr2KQ4ueEJBvp89qARjr53uWbAT81eFaxitsbztLXRVs+pAgJZ90+QTlX8pJxhsIh9WuQfP28YaDmkFzxdcHftWkpkQm7aGvzlUacQw5QsMfBVqGTxvmlnZteN8z+GDqZalQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645262; c=relaxed/simple;
	bh=xHV0sgbHTDly23SqJVA6EJssEeFHFkXDxKbvtF6OLY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R/c4aG8q/McDgGI0/70HgHJRCoxSPukfNWgDWjJO07JFrLVNPW/YAfbBHYOv/Ewq7OOWmQQvC6qrkp43O5J7tgf5jZLYw/PmpPCK5fA22274XZz1LHNnDpCEYhj56oGfbfw3uEVXbXHFyeDTGKobhGQFLQKolOyV1Rs+ARULB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hasxzvmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hasxzvmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334D9C19423;
	Fri, 27 Mar 2026 21:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774645261;
	bh=xHV0sgbHTDly23SqJVA6EJssEeFHFkXDxKbvtF6OLY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HasxzvmjzSx4TzS1sNvjZsIegyxF0Ktr2dBmMNuhZstmMuTOBkybg5lwPIA3MU5Jx
	 MXOtArw6v+B3JNbprDVOsjUGtKzp8f/pnXJioUbVfOi8lHt4kh+JwWc4xKT/akwvqY
	 WfTiXmUmOpaqkD0TSYo/dkPJfgUNBw2lQmU2Gtig5HLbiB0XwHMESY/WWvW8oKE8kw
	 UcgFpJIfbgvNq5N8dNrAdKa4ujOUqxxNmW5z2Mu6fPyPyWaFc6rZCGjA4Xo1X4+Nkh
	 Jl0QRSiZm3kXCvn9kZWTyQvH5lS0ERrr8fs9EJ9cKPFirhvLrEz6z/MIq9kyULsEuI
	 1cj8ijOvmQZYw==
From: Namhyung Kim <namhyung@kernel.org>
To: Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
 Mark Rutland <mark.rutland@arm.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Changbin Du <changbin.du@huawei.com>, 
 Ricky Ringler <ricky.ringler@proton.me>, Jiri Olsa <jolsa@kernel.org>, 
 Wangyang Guo <wangyang.guo@intel.com>, linux-kernel@vger.kernel.org, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Tianyou Li <tianyou.li@intel.com>, Ian Rogers <irogers@google.com>
In-Reply-To: <20260320234554.2560453-1-stephen.s.brennan@oracle.com>
References: <20260320234554.2560453-1-stephen.s.brennan@oracle.com>
Subject: Re: [PATCH v3] tools: perf: add comm_nodigit column
Message-Id: <177464526116.2796353.5018634692323933551.b4-ty@kernel.org>
Date: Fri, 27 Mar 2026 14:01:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 20 Mar 2026 16:45:53 -0700, Stephen Brennan wrote:
> The "comm" column allows grouping events by the process command. It is
> intended to group like programs, despite having different PIDs. But some
> workloads may adjust their own command, so that a unique identifier
> (e.g. a PID or some other numeric value) is part of the command name.
> This destroys the utility of "comm", forcing perf to place each unique
> process name into its own bucket, which can contribute to a
> combinatorial explosion of memory use in perf report.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


