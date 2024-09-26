Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41C154C15;
	Thu, 26 Sep 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371695; cv=none; b=m3/Gdgva4eIE22i3miKVFSTQx/6joZkvSVnlq0cQyyyK2XCXcVIGatdD8d+KrZecvltUoC6i3LU0VDZDD91ZMljvhVeCHKkj+/yDQmiSZeVFtymcgkuTTOsVy5hWGwxvL1/DXM3CbHoeTmjZLm2ZkFVpBmcEvZjPy19nuzYwM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371695; c=relaxed/simple;
	bh=ISZTAw2uoP75IGAb5uipFimJViRv4w/H3SFYSZ91kEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAiMF1huuQ0H8j0U7JcIlYF1irbO6+xHioRnXx1rtz5oOaWJ7DzAeJJOroo9Fx6m/gW14fOspPdOQ2KG/ylRuOojw8fNJ60kP/fAbBJFl3+cPjq+JSpyUymyPuYDgurhNMf5r5320s0XlXAhXnkWhoyk4z9Iox66k6UVHzYSMXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDKa/GyO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDKa/GyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B28C4CEC5;
	Thu, 26 Sep 2024 17:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727371694;
	bh=ISZTAw2uoP75IGAb5uipFimJViRv4w/H3SFYSZ91kEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDKa/GyOLjKiK//C/OHwnR3R7qzn2f3fdB7JxFX9hmLsQ2SQCETbU0mxq2qlS17dE
	 3PFehhDZDLz6UtUTJ8CGvSeuRvAUYCfk5ODlmX9VWL9xFuDLtrQ3CqqOhl4pbeGalW
	 l8BJuWGDtuzOqXAih+jp6h4BRqb3PlQqKEYh2XVy1XRto0/qotVSeSbD1w8slMnV24
	 7m8ott9QblIMCMOBEuFvgmEcFeBfg3Q/POEu+INELuXLEtcyimuigaxROSXjVu+LDZ
	 DY0cdS7ho4dIAqy5B8qUVSVXhEvpd6iodAm3XbafyrpvQmkgyInfQAs8gZp5dp3632
	 7TEMK5rmOOFTQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	Levi Yun <yeoreum.yun@arm.com>
Cc: nd@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] Minor fixes error handling of perf stat
Date: Thu, 26 Sep 2024 10:28:09 -0700
Message-ID: <172737165675.3854690.10340683283816348263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240925132022.2650180-1-yeoreum.yun@arm.com>
References: <20240925132022.2650180-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 25 Sep 2024 14:20:20 +0100, Levi Yun wrote:

> This patchset fixes two issues that were seen when running
>   "perf stat -r" with perf_event_paranoid=3
> 
>    1. failed with Too many open files.
>      $ perf stat -r 1044 -- false
>      ...
>      failed to create 'go' pipe: Too many open files
>      failed to prepare workload: Too many open files
>      ...
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
