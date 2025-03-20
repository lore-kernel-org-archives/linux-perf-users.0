Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D11EB198;
	Thu, 20 Mar 2025 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486442; cv=none; b=qsrSi0RHgpX5utlScALpfs8CXIilS9Ax3bY7YSMl1dvh003Kmdjxk+MGYXvWwLKHu2v4yyJ0+7BabwVp6y4cN1MkFA8kIAM6ajC1ZrX5wk/YeEBBVdrcN3F2ektlsWlDnXZArwQ+0Lf7ExX0spqs2cpR/920RZZqU3ynClOwsp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486442; c=relaxed/simple;
	bh=ScNqOhXWunAFAGfa06cLfLvXFeM250TqGzgCnafYnMI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mJWIzpNL7nSWsxl+C8cQBAghZNCDFOsFhWTB74vp1eypj+rwuyJeNqL/IV5yqNtJieqav74+ZM6zvKUZnZvo2oA6CTnRNQN5DMa3+0RPBE9qiG3FieTTE5SbrN4fxWJbW9T4PSPZlxRjNZBsc6ZIti+ya3Xr/QvnzgnBOg/+W3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrzX4B98; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrzX4B98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AED1C4CEE8;
	Thu, 20 Mar 2025 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486441;
	bh=ScNqOhXWunAFAGfa06cLfLvXFeM250TqGzgCnafYnMI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OrzX4B98T69jNgT02cY6z7qXCtPLDODKwHXpq7B1XbjfiEpOlw0dfDHwkrxcfrv38
	 1fWqxPwZdGIbLnEJOVYHZKejuBPNnxD5KxHLuEmvLM+FbgIKKoa+JvAbqbu19mK6PD
	 RjtQ3UFB512vRXheUBjeBIE+UqTqClx4jRbE2xXQJ+bTIAnUH4venTU7eGs8ieFYV6
	 GKEUyLA8vWR9pnlUCCya0u2gthNdvPqBe2MSsmllyBeLqH2Rx4EWPfNnQQ2Tfk7Uxb
	 iLPHB02xh1JrKtZQInMBqbSdaeikUwfw/z30q906Lt3qrTwm+iiMmYhL8Ym0ns1lna
	 shgAgoCBjVbhQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <20250318230012.2038790-1-stephen.s.brennan@oracle.com>
References: <20250318230012.2038790-1-stephen.s.brennan@oracle.com>
Subject: Re: [PATCH] perf dso: fix dso__is_kallsyms() check
Message-Id: <174248644099.3704425.17283492904024257461.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 09:00:41 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 18 Mar 2025 16:00:11 -0700, Stephen Brennan wrote:
> Kernel modules for which we cannot find a file on-disk will have a
> dso->long_name that looks like "[module_name]". Prior to the commit
> listed in the fixes, the dso->kernel field would be zero (for user
> space), so dso__is_kallsyms() would return false. After the commit,
> kernel module DSOs are correctly labeled, but the result is that
> dso__is_kallsyms() erroneously returns true for those modules without a
> filesystem path.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


