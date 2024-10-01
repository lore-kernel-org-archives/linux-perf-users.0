Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A151CCEFD;
	Tue,  1 Oct 2024 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816395; cv=none; b=mBGa5huLa7ZhhVNFGkjZu35BxEBuI2vExqBMdZD/z2/5oD5iT02hU9m9r9lqsaIbLWKex4jKEN7CL5bkEHqOcA+IuSkIujNmpSz5Zd+UZ/QVNE42ddToZ9jxoeLIqEutWq1QbWtZmddllziOd66IkB1/AHyeUIuvoEZ8wWLy/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816395; c=relaxed/simple;
	bh=XIMwzAM9lY+Ku7Ahc/qJd/LB2DATqRjwPoxdPhN+68M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHe3qCzuf6MCoE4Xze6RpxFiTBu6Q8olFVkywgCm2i4t92HvKdafEfGUbJ/UONVqbKHoR35u/NGnBnLl6T7eIPUoNIDJK2Q4WaOL9ceCq2Rv1wghhP/W8pER0xdZtRepygyrE4rQ9Lajc3l+8ISfRg6FpQe1mm2WYKTe93Dqy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ri/cP4in; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri/cP4in"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CB7C4CEC6;
	Tue,  1 Oct 2024 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727816395;
	bh=XIMwzAM9lY+Ku7Ahc/qJd/LB2DATqRjwPoxdPhN+68M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ri/cP4inaRK90ZvqAxT63Bn1OwUwg6hqxzt4BHBDJyOwJiV2RFdCfphn1uzb8d5/V
	 RDXdWwJVuIGi13xuKUhQvgV1mmZ4SC3tmyq0Td3xOqFMAeeHK1pgSgbCdhG8jj+qiR
	 PtX0trP9vDtUYXNOrkYPkuVjFM7IWISNqRPgBDKOqc+ukceucRClkptEwk/WDI+G/6
	 KNKsFLwIGAWwqJ/w9hFv/Yk6Mbm2avwozFgiSZ3RPbDo6muisgFYJMUz0vrDl41Wo7
	 m77tqrq1JGMqwWfMpzNpDPUF/h34g1LWhnGu1EGS1KxGgjy0RTiNv6ccjr5lz08M8z
	 ig90kRnvNp1uw==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2 -next] perf test: Use ARRAY_SIZE for array length
Date: Tue,  1 Oct 2024 13:59:50 -0700
Message-ID: <172781634749.2468314.7163578381975664500.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240929093045.10136-1-jiapeng.chong@linux.alibaba.com>
References: <20240929093045.10136-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 29 Sep 2024 17:30:45 +0800, Jiapeng Chong wrote:

> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> 
> ./tools/perf/tests/demangle-java-test.c:31:34-35: WARNING: Use ARRAY_SIZE.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
