Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD4347FCC;
	Tue,  3 Mar 2026 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576318; cv=none; b=o02MlKamWoTZS3QjuYplbc3tYNaPM2L7K6Apq9GhstrSFun8wdZ9o4peCyQxQWEkMNGCUM9Tpy5OjNutPG3CmEsn/BWMik6sUq4U7DJ5+Cl07N41f6F/iQXDSMgjEr54IpdJFZKKg3GqwJCKx892qYkWq/8e9VGb0ZbWvYHZsKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576318; c=relaxed/simple;
	bh=Pakn9W4no58nctAN/1Xg6xNZXuga6upEPQzjHl7RXVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dn5v+0YFXG8fcuBM6pvNgyrzafgo9U+yLAQvgm6KBhC1sY8JAOFk1vL4QGtOVcVq3Au93cL5lLa1W52rD72Fwf0cxIOmjyLJkjkG+rDrKKFoV35yqKH1o09TthKotEyHVftsgCCsS9N4yVs/RX1RXm4Q3ZDVbl6z/2oK8vC2rrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQo40Feg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQo40Feg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C44BC116C6;
	Tue,  3 Mar 2026 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772576318;
	bh=Pakn9W4no58nctAN/1Xg6xNZXuga6upEPQzjHl7RXVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uQo40Feg+2ZFONW00MlAsoERLL2ty6I/YdZYeBNmeZyoMn7CyGyev6D+RpCpnrOGo
	 RwXduQ/Nc4zLoSiAMwu7LQEF8sh5KNDKTb69SuUGRG/fHWZOmLcxPZbapfDPtCq3aK
	 J+ttLWB1XjhORUtKETCUBP6f/zuZui7+DNU0W8YzgvvVwKSI85No+3VrUUakVfpJG4
	 l/SKV4m6nUL/F87r4cvZeR8thZuIWf6jBO+FUCplxWyV3vE3VptuIbISfP2QfKvaWa
	 VnB097aFcR2FchitGrhGZmEdY3vXyNKE5mC3iTw6+KAevu/4drZfdDhJrlP83orIPb
	 TsBsmzJLz6SXQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260301-perf_fix_kvm_stat_build-v1-1-e3d1ce3a5084@arm.com>
References: <20260301-perf_fix_kvm_stat_build-v1-1-e3d1ce3a5084@arm.com>
Subject: Re: [PATCH] perf kvm stat: Fix relative paths for including
 headers
Message-Id: <177257631810.2872307.18325173370687386544.b4-ty@kernel.org>
Date: Tue, 03 Mar 2026 14:18:38 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 01 Mar 2026 17:43:25 +0000, Leo Yan wrote:
> Add an extra "../" to the relative paths so that the uAPI headers
> provided by tools can be found correctly.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


