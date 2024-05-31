Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA91200B7;
	Fri, 31 May 2024 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189991; cv=none; b=hqw+Gtl5ORUuxdNjYEwZq/gPgEcfqRAO6hYG4YkdqwORXLv2gkE8+7CDxbRpj07SCa3L7dIRZUtjQLE2EWJZrMYs9YX9/0an/R3+YP1pihZbqX/a8EWNOKLDOlUJtlngLsZWjhtVHlOh3KrU0iRq5u6YcmE/XF+m+h3Gu5DVtQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189991; c=relaxed/simple;
	bh=q87t1fyI81/pnxHXVoZD7reYrMZyoN6TiS1axuFNJXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMaAlF3vJWrwiH8/ICK8TUGtMd2pOTlAfpRn6ox4UBxJYd8SGAy3GGtXV40qimGMCLonUbVqrk/1SskQ9mY7Ji7+6bYBRjjcJP2/fqeYsBEk4xUlsolt2dVUWkuTYpK/eM5JPMFHug10avrwq+qUl7tI/BxgFAXydSp/kTj/cS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe2xJwua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe2xJwua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47B9C116B1;
	Fri, 31 May 2024 21:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717189991;
	bh=q87t1fyI81/pnxHXVoZD7reYrMZyoN6TiS1axuFNJXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pe2xJwuamwa/dQKxOqu4BhE5A6mUs5qG1ZImePDO4uD0jOAIM9ZTjDeRGWRClZATP
	 Cw8miAiMavv81KFN64fzbCU5oRYflY11KvW1xRr7bvaSRE9wGzcImu+4go8lzDHdc+
	 JGQMHk21Qh6DsZyb+YDKp0GmicPqOsFNWI4WcqS6nhgJG7UzPBf4ob8/i2Gh/IRApZ
	 Y5+L+mG3ymEdGhHRdZGHMLL4zytyxYpjCGsZfWGESPk9tVFT+wtYuL76XaOXxrK6XZ
	 YvqdXobrqqpAXGb9SiUZKQv4CHtuUFiZGFd64MTVReMo9ZdqCUsAaicfxDm6E9j4ZR
	 BVfvdyTcgfbyw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Changbin Du <changbin.du@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v3 0/2] Always show mmap prot even though PROT_NONE
Date: Fri, 31 May 2024 14:13:03 -0700
Message-ID: <171718991316.2179562.5066672693392732715.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240522033542.1359421-1-changbin.du@huawei.com>
References: <20240522033542.1359421-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 22 May 2024 11:35:40 +0800, Changbin Du wrote:
> Before: PROT_NONE is not shown for prot 0.
> $ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
>      0.000 ls/2979231 syscalls:sys_enter_mmap(len: 4220888, flags: PRIVATE|ANONYMOUS)
> 
> After: PROT_NONE is displayed.
> $ sudo perf trace -e syscalls:sys_enter_mmap --filter prot==0  -- ls
>      0.000 ls/2975708 syscalls:sys_enter_mmap(len: 4220888, prot: NONE, flags: PRIVATE|ANONYMOUS)
> 
> [...]

Applied to perf-tools-next, thanks!

[1/2] perf trace beauty: Always show param if show_zero is set
      commit: 92968dcc037fed045dab5c8e52b51255d77f5432
[2/2] perf trace beauty: Always show mmap prot even though PROT_NONE
      commit: f975c13d2a34a335fc559aeff76dcaba456cced0

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>
