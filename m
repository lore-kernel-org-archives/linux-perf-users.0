Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48013A9DA6;
	Tue, 24 Feb 2026 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955847; cv=none; b=M+rIy+iaNGbE1Ec69OmM9TsVKtjB1ERl62BTT53apaenv+DfT4cgSh/xK527lgR0EZT+08n6hO9sIxMeqJgFyQQHkxU8LfFgy4ONwicS9lEgDnwzcHDEqYJgVRmr5LUTkz5bUdVIna9cC33bqAv1E+nHywSvmKUiI0uLh0aPzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955847; c=relaxed/simple;
	bh=kmJt15VnUua9aIXCjZn+xJlUy9GEeSXcqI/BMjslXOo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KujjJMyU7cOOy4nZBhl1bl1ypwszUFKUSQhTI/b7h90q1b2impxoqoMQcLYXOzQhJp+XXhCi29ftN6OIChlCe+jqC7CZzoMUoCU5jHiRdOAJgp1Erx2NW0zRQznYAD9ud1M7P1v+zmODAf4h9S2VRcziBfZcZiGGMjy+L3DmHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWer0h3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWer0h3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40699C19423;
	Tue, 24 Feb 2026 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771955847;
	bh=kmJt15VnUua9aIXCjZn+xJlUy9GEeSXcqI/BMjslXOo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LWer0h3XgYDAE5Yv6sCd2+PvlXR4VFN+PcPey0Yao7C6b5U2qk9tvP63oaaBH32Rh
	 4ia4U0v+klf3GdkCl9HZOb+w8Gp68wTr0Sgw37DxI1nQM71BrInJH1tk7PsyYmRQq1
	 G7wCBep8mCOxlMrirDihBkIPaxSZdddZpeMj4Rb8eUX5Xm4TzvGG1TVCguArsNHEm1
	 PxcuXXCOUjUbD8R+7TtR/oPALAQsuDYde43eqf7/jRdoaFAGzC5y5/1IzluY/vwUkg
	 +cM2SoWECZaj6u72H0sE7Vrvzi1xqijLyOy9MLU9yPtQBtkAYuHRGh3mterNg1U29i
	 /z2xaJOHMngMw==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
 alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
 jolsa@kernel.org, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
In-Reply-To: <20260207004956.610458-1-irogers@google.com>
References: <CAP-5=fXPsOuqr+4DZmscoWGr1VHHJci4jRGxbOtJyy_Mp9Oa9w@mail.gmail.com>
 <20260207004956.610458-1-irogers@google.com>
Subject: Re: [PATCH v1] perf metricgroup: Fix
 metricgroup__has_metric_or_groups
Message-Id: <177195584721.2594382.13895872785223297028.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 09:57:27 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 06 Feb 2026 16:49:56 -0800, Ian Rogers wrote:
> Use metricgroup__for_each_metric rather than
> pmu_metrics_table__for_each_metric that combines the default metric
> table with, a potentially empty, CPUID table.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


