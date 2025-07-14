Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA9725A33E;
	Mon, 14 Jul 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505818; cv=none; b=qOf6KPcXyZRSXVeLLtl9vDj++Au1cWZR9CHRbFzDPU52ez42zZd7s02Aen6bIqUp9T+7qCDBbyDpoPkzXKDLHln0g5No4mvnDkbTeEuB1ebt2s0lkG7KEQA+ae2InJApFLsG/ZsalDTfb2s5xQw1ayVUyFLzOy0lLJhiDXdplic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505818; c=relaxed/simple;
	bh=tL2cvBKvP+TRNoehYql8sqSD0WsB5mk+ZMdcqb1joUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0FmW19lJGOi8hmzNiEour4UeyuwkdJTBJUDvz5z5RJyvJ/jEXrLPUTtV14yMZ0A2+3GCtbNQmerAv6XDUYy26x5sU1/hp7jiewsB5SAvWdc8b4PtoqYXsrmA36gEhX++hGs0iwY0b2YwJ3TnYA2yaBrQtCSzjw7oHnyBx34PEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWeEO09G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWeEO09G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FB9C4CEED;
	Mon, 14 Jul 2025 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752505818;
	bh=tL2cvBKvP+TRNoehYql8sqSD0WsB5mk+ZMdcqb1joUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cWeEO09GvdWR7Yxc1VYvSQtI6HYGeWlBW6L3qlJJ4vSnKlQbEwatoGUPJdS0+bmcL
	 YUkslPAQW/CggfUqF+K0X2rRRWzjo7cG7S6a7F/rbA8Wjrqid0kG8CvqgnmnmvOwh1
	 tQbHbOZyA6RppVXNWcVEwvmBPxec3+RD+VWVJS5FKyTUpvw8bGv6XJm3ufFx6HvgSV
	 4P8g4oWp+6t8A2hgZIcsdt/nf0GB5iAmhYk7Muesdzy54odJSJy7M1Ubl4wbSWV45p
	 yFyOLlnFKyyHgw5S5U1ApSOtkX6EyOJ0XzVuc8zpceXrUaKlZKxAYWvlD6810rANRw
	 FmBmcbJFyQOsw==
From: Will Deacon <will@kernel.org>
To: jonathan.cameron@huawei.com,
	mark.rutland@arm.com,
	linux-cxl@vger.kernel.org,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] perf/cxlpmu: Fix allocation argument order and minor formatting
Date: Mon, 14 Jul 2025 16:10:09 +0100
Message-Id: <175249658916.1514882.17829256501206984322.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624194350.109790-1-alok.a.tiwari@oracle.com>
References: <20250624194350.109790-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 24 Jun 2025 12:43:37 -0700, Alok Tiwari wrote:
> This patch series includes a few minor cleanups and correctness
> improvements in drivers/perf/cxl_pmu.c
> 
> Correct the argument order in devm_kcalloc() to follow the
> conventional count, size form to avoid any confusion or bugs.
> 
> Remove an unintended newline in the IRQ name string passed to
> devm_kasprintf() and  fix a formatting issue in the devm_kasprintf()
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] perf/cxlpmu: Fix devm_kcalloc() argument order in cxl_pmu_probe()
      https://git.kernel.org/will/c/6ae58c74e7aa
[2/3] perf/cxlpmu: Remove unintended newline from IRQ name format string
      https://git.kernel.org/will/c/3e870815ccf5
[3/3] perf/cxlpmu: Fix typos in cxl_pmu.c comments and documentation
      https://git.kernel.org/will/c/0259de6331df

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
