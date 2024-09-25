Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1814A4F7;
	Wed, 25 Sep 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727304088; cv=none; b=kCZG7dP+g2gepLrlUvHzawSzcYdQb6zY5L5lD1zWF848YaLpGE+tc2LjcHQ389W7nzFbuaBpPDjl78f/VmjnL52zdTrz3uwVCzQXs8asXUNgA8sovxERt3nhizrwtZNgOCmIYcBCL1nGw3HfM5++8FPIfGu1uoznaWTEGXzRL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727304088; c=relaxed/simple;
	bh=f8rgSsrdqhPl8sTal/zHbbynm32osaID12MIGLYJ7hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDp7OQVTBUIl6oNtFJroQjXQslOlOQLyswrmRNsAw+7Y3s5q7C67fQVOvZ9bghCEqz/dLKnnsHzNEc9IByGcLU1olOtG7RUcaZuhRT9Pwd8FYYdJX0QIsU8Tp/39ZlbSt6/rPJ+2WGHRRC0uKE8Q+VGRKTs3TwF8dCQ12ws6MyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXi+mWOb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXi+mWOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1A7C4CEC3;
	Wed, 25 Sep 2024 22:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727304088;
	bh=f8rgSsrdqhPl8sTal/zHbbynm32osaID12MIGLYJ7hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXi+mWObndtA/pVacgk+1v6m8erLJbOBtJxg6xI4e17vlzWC2KK+gwkoMZYeGzn7H
	 kytY5h7iWxVdOpwCMbbqBA2iUKrg+DIux11UpLD8InbPVQ6Mz7Fns+nuhEHvhpU0G1
	 bwrJaGiD7pmquRlUF9Cdv9JuQZVAsPnJPc/dade4yslLUCLi5QAwMOMxJnTfRYU3Wi
	 vcBM7mJ/G+/MQt6Rdop190LTnm/ZBHo9kJL74OqLMEk1qSMCguoeN0JKHjQaLsqbid
	 MkhAahCbW8P9xaZDV961ZRsNELKH8RoYXj9ZvEeulO98jluMHG33P2VxxCShcy85fF
	 dJkAl0vl6lk+Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Masum Reza <masumrezarock100@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Yunseong Kim <yskelg@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evsel: display dmesg command of showing a hardcoded path
Date: Wed, 25 Sep 2024 15:41:25 -0700
Message-ID: <172730392642.3246951.14949475927195901266.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240922112619.149429-1-masumrezarock100@gmail.com>
References: <20240922112619.149429-1-masumrezarock100@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 22 Sep 2024 16:56:16 +0530, Masum Reza wrote:

> In non-FHS compliant distros like NixOS, nothing resides in `/bin`
> and `/usr/bin`. Instead dynamically symlinked into
> `/run/current-system/sw/bin/`, the executable resides in `/nix/store`.
> 
> With this patch,`/bin` prefix from the dmesg command in the error
> message is stripped.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
