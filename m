Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789FA1940A1;
	Fri, 14 Feb 2025 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568194; cv=none; b=I/Qalh0wzTJ3dwJyQVyZd5hddRYLAVXlWUbjxlJUQtuqKdHIKbVk1iHx8vwF72If3ZReJM3lpdfh6aO20j5lMW7V2on8e0FluWRMnsnr7hybT/ESzGZMtzREJ5OoiTwzmrflGvIiuow5I5Xfy1cuqaPe2yq5IilE6cKigspqYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568194; c=relaxed/simple;
	bh=5gjSx2IlYtsRAfLRTCLW0PQUepqheWM8EALOFBH1aWg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UyDQKvWOSOTVnpBw53yjGRz6tTqYdxsRxAEWI5wmmlE7eC3ONYhIC6IXItybzObSnYH+l4EcdUujqJUe3lnzDoi0wcBtS386+eJLOayEkY/k07tkSEuuqjxyQShfritCD7yBo2tBHksTvI4ZtBCLWfBNcGRrlAADqrdKp/IBOoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXiHOGw7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXiHOGw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A541C4CED1;
	Fri, 14 Feb 2025 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568193;
	bh=5gjSx2IlYtsRAfLRTCLW0PQUepqheWM8EALOFBH1aWg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=aXiHOGw7sSyTp1dD57ZBhGwSN4fWVuc+SVggRE3XZwYqlLcQJKY4kIWdcD7e2ehnZ
	 2lPFGPXJSRkN4RSiuOfnS38THL5bXYGz5FBkm8R0bYY5PQiesqQOOYHbpVP3eJUKSg
	 incJM+Qq2SK1GepQa4UMBVpP7oa+bNTEpvFkm/TQnlHxmWw8WKToc5IKv8MGh11nPN
	 N29ua69//qrQM+h6JoZ0wS3H4YgFkxaEqH7/YPHMZS7j5aQ+juttR50/XIVW5SoOUy
	 9EEyG45Qhuj5/k3kM8mOeLzcqX2PvrgzMwjOxSCOvQmRZDdjz15W8EfQZNbNLjGzuL
	 VgcjkV5D0R5vA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
In-Reply-To: <20250214111025.14478-1-leo.yan@arm.com>
References: <20250214111025.14478-1-leo.yan@arm.com>
Subject: Re: [PATCH] perf: arm64: Fix compilation error
Message-Id: <173956819350.2296227.13350055330369051271.b4-ty@kernel.org>
Date: Fri, 14 Feb 2025 13:23:13 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 14 Feb 2025 11:10:25 +0000, Leo Yan wrote:
> Since the commit dc6d2bc2d893 ("perf sample: Make user_regs and
> intr_regs optional"), the building for Arm64 reports error:
> 
> arch/arm64/util/unwind-libdw.c: In function ‘libdw__arch_set_initial_registers’:
> arch/arm64/util/unwind-libdw.c:11:32: error: initialization of ‘struct regs_dump *’ from incompatible pointer type ‘struct regs_dump **’ [-Werror=incompatible-pointer-types]
>    11 |  struct regs_dump *user_regs = &ui->sample->user_regs;
>       |                                ^
> cc1: all warnings being treated as errors
> make[6]: *** [/home/niayan01/linux/tools/build/Makefile.build:85: arch/arm64/util/unwind-libdw.o] Error 1
> make[5]: *** [/home/niayan01/linux/tools/build/Makefile.build:138: util] Error 2
> arch/arm64/tests/dwarf-unwind.c: In function ‘test__arch_unwind_sample’:
> arch/arm64/tests/dwarf-unwind.c:48:27: error: initialization of ‘struct regs_dump *’ from incompatible pointer type ‘struct regs_dump **’ [-Werror=incompatible-pointer-types]
>    48 |  struct regs_dump *regs = &sample->user_regs;
>       |                           ^
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


