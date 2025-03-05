Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BDB2500C5;
	Wed,  5 Mar 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194879; cv=none; b=Bquq1q7UDsCgZaElTNj+SJw8NuFkIH+E5Nix8GG2vQ2oDnyLQhmRzk3VQeQUmEnxp2Ci42Drm/VhVgpxV6qS+iTon4oSptQDjfS0uSUHdsj4BdNkpty2bzsPWeZEoz37ue01rnH5CFywsehZc7Plng4dZlX9tGj+Vrkb309Dedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194879; c=relaxed/simple;
	bh=L4xfJvdQZxjN7GJl4EA9k+rwWwG3IwPZQ6f+e6Vswds=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nl4XUIm6epe1jqJTfiFD7NEURJDlnRO0BLkW/mgFYmqVvShj+V2SFkqeZ5mJdVeH5x2Kzx9GuEVYGbzsTdE+6gtafXFQcsfcr187+q6gmzia7BwlIQSeh0BX5xytbOHjc6m4mLVGWnvms3UErgzK8e9IDU235mWM+NqraiIAyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFMllJPl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFMllJPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D45C4CED1;
	Wed,  5 Mar 2025 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741194878;
	bh=L4xfJvdQZxjN7GJl4EA9k+rwWwG3IwPZQ6f+e6Vswds=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JFMllJPlmKRsG1YfpOozpo0/3Zc0/cVt1qp1ygVxotPLgqNc8MPOpZimb3PHYLidc
	 j6TaCIWi8pQZCtoBGd17QqbxgOMzVvL45FXrWM3O0kZ/5ZZ5j6wQz5Zh51hbCJlOig
	 s8UpU+fFYxtdYVZwh8BtsOFIB239v8GHG2HPyQUYI5IvDdFCkUGvfYbLMOVeS9Iw3l
	 mYjxW+/toULIbthp6p3c6Pkv7mOaEVBmQAuXOmif5uT39R+f3bRG2IPvoF39DLILMD
	 Mpuyga/kzhrO6eanjf7EF2xw+naSh975u7h2IA0213YzVwZKoBxOtPoMD+odnvg5OQ
	 lOewjlM90xmlw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, 
 Graham Woodward <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@arm.com>
In-Reply-To: <20250304111240.3378214-1-leo.yan@arm.com>
References: <20250304111240.3378214-1-leo.yan@arm.com>
Subject: Re: [PATCH v4 00/12] perf script: Refactor branch flags for Arm
 SPE
Message-Id: <174119487820.3243158.8048766791168980891.b4-ty@kernel.org>
Date: Wed, 05 Mar 2025 09:14:38 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 04 Mar 2025 11:12:28 +0000, Leo Yan wrote:
> This patch series refactors branch flags for support Arm SPE.  The patch
> set is divided into two parts, the first part is for refactoring common
> code and the second part is for enabling Arm SPE.
> 
> For refactoring branch flags, the sample flaghs are classified as branch
> types and events.  A program branch type can be conditional branch,
> function call, return or expection taken.  A branch event happens when
> taking a branch.  This series combines branch types and the associated
> events to present a sample flag.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


