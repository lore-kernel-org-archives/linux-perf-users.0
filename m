Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9C8209F3E;
	Wed,  5 Feb 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780800; cv=none; b=Of4F//ZsTiISxixfiq7rAdR7W2dVX1xQQqmcb9m+Bg/+bNh1or8MK3tS14pskyTH2Qqsyf3lk9WnaCVSMxdQZoEsPg2GWrvFcEqt0A1Xfu9Hmhm6LjQU/kd+kEecg9sBfdm8Xkm2ErwGVFPqaJJa0VryGpzTJdxESzMdsVEmdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780800; c=relaxed/simple;
	bh=VcT6029LRl5PwvYgOEc1CaNbCG53BPuWJX5gM6/0FUA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c7dyNooT5AV+qXik7DMePKIdXllNIM44uGF/7BMVnpYh0Je4PdhAmYt+A54VKE0APauu7ysPhX0x1Jexd4A8EmTEv+hLk3F+vANOu+5zI48N//V2kYQ+dPjY2zLz2wGbmxdb0V0apw++f1WTA+b8+0gdlVQOiwyQ5rgCLQRGpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf+vdiwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf+vdiwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38622C4CEE2;
	Wed,  5 Feb 2025 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738780799;
	bh=VcT6029LRl5PwvYgOEc1CaNbCG53BPuWJX5gM6/0FUA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Hf+vdiwSHd/HQQ3gFOLIyjPbaVlQRXz7NqPjh2FaioYlFijgN8w7Ty3Df8k7/I/J5
	 GCNehp+VeNNY5dJSoihhE9/nmn3+TrccoHWgnn7dsWnSnzHnzKTFnzoyKWj8w4mI2R
	 DB7FNNudArGVTosZF9R4TeDSbxQQHeipsHoK23gZqhp+VI/B7oKhdQjhCYrWgShMGz
	 P9b/8EsuLs8Ch6uTN+HqAESwVP6zIXrmlIBwLKC/dya1hmLmqZn8V4XS7/7/+rOqLs
	 Ku12OdztMmx6JVR3nJCK5HIchcZNyQz6ZHhvgl7l0tVDvWKfm8Ju5yAy/9eVk3KOtf
	 ExfPklwmw9lng==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, 
 Junhao He <hejunhao3@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250201074320.746259-1-irogers@google.com>
References: <20250201074320.746259-1-irogers@google.com>
Subject: Re: [PATCH v3 0/5] perf hwmon related improvements
Message-Id: <173878079918.596119.6286788073934483189.b4-ty@kernel.org>
Date: Wed, 05 Feb 2025 10:39:59 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 31 Jan 2025 23:43:15 -0800, Ian Rogers wrote:
> Try to do less scanning of files/directories with or without hwmon
> PMUs. Don't merge all events with the same name, only merge those on
> the same PMU ignoring suffix. Tidy PMU name matching to distinguish no
> suffix or wildcard matching. Refactor uniquification so the evsels
> with the same name as other evsels in the evlist are uniquified.
> 
> v3: Address potential segv and styling nits from Kan Liang.
> v2: Rename ignore suffix PMU name matching that is really a
>     wildcard/prefix match. Use a proper ignore suffix when not merging
>     counters purely on name.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


