Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE920349B15
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875448; cv=none; b=EZOxaBBbOk4UpXoC/ceqvI1AFVbZIA0iMPp18A61YiaQfae7wC7lPnwO4+H4BLbdmRWZjuSnT+kqUMwtswdiTZv2MCwvsJ1pTi3euIYWbGGsUWq8x6McUwpQQDrZvXmhEy/PpVw5yEbZ4Zlba98Ax6aQuXXeGWBf/rcT14dhrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875448; c=relaxed/simple;
	bh=I48PDz0RhPoBY/algdOFF+TPb6qdaIPNpJJyzHAE0IY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XGpr4mvNmu6+bQb+3FnT8ioTgMOyG/nFwm/DDgOe5e9Hmh4x1C3SNFPuezd0xoIg9TiH3tNXSRMijrF0XavE4nTNREVz5C6A3NtFK/WwSqPWFWZySKmmMoLpooVaNJENtjfyV75ZXtr21vz6DhKnqa69TVjXOkf2gMRXrgXopXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc0Vmmy9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc0Vmmy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4950C16AAE;
	Thu,  4 Dec 2025 19:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764875446;
	bh=I48PDz0RhPoBY/algdOFF+TPb6qdaIPNpJJyzHAE0IY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zc0Vmmy9o+QOcoEz5uFdnKe/9P6HU98xvoP7pOzN3Yz6cn3KL6FTl1RLrQ5TW6Il2
	 OUPvISnZw9ILRtJjau+6eeZWFIkSvYXMnBfDdkpQe4j8xyIe5+wexE4/JJy2jdTqpq
	 nFoPMFyKPzSHwERzzRfR/LAaiZA2KedhbX0MNs/RSld4+M7VmPB5eybIwtIE2D6b+X
	 LktsnNUwi9tmcUUB66nU/rPXvo3vTrIfegiXRXeVnCZhWms+JqSOD9V4F80g23JaDN
	 TL9XNbIJY/rxWJ9Vij3lj3BICl6nwbW3BL8BtHDHXLjVbr0LMTGTT93NFcof8B8FB2
	 P6WD5YVy6LYwA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Leo Yan <leo.yan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20251113-perf_arm_spe_update_midr_list-v2-1-d547768f5520@arm.com>
References: <20251113-perf_arm_spe_update_midr_list-v2-1-d547768f5520@arm.com>
Subject: Re: [PATCH v2] perf arm_spe: Add CPU variants supporting common
 data source packet
Message-Id: <176487544583.182574.10220163589833287696.b4-ty@kernel.org>
Date: Thu, 04 Dec 2025 11:10:45 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 13 Nov 2025 10:57:39 +0000, Leo Yan wrote:
> Add the following CPU variants to the list for data source decoding:
> 
>   - Cortex-A715 [1]
>   - Cortex-A78C [2]
>   - Cortex-X1 [3]
>   - Cortex-X4 [4]
>   - Neoverse V3 [5]
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


