Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FD63128C3;
	Thu, 18 Sep 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213814; cv=none; b=Fhe8N/eCSEy+C8+hzoTTgpXyYf95ghm2GDsjTd4fEDPPZM96gQeVM8PgRZXlMtk+GutgcUDdu8Y5U4uuVjHPg8sw99GBb9ZkSvz7eUTnWVt/lUD0lzArZCwC0BHfNIiZcFN6v564OkCL8MuXMIe1yDUo2TMSfBw/HAZ0jIXj4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213814; c=relaxed/simple;
	bh=lgTAwC7SD+XTZHXWyaraCwOTJrZ9IajXNT1Smh9SYCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAz5t1Sza719UmMrFHSYRJP3ToKD/MqVQ4hwDrU1vc4ISSmzTCorQVJuFXlQ4ZG0k2aGDrHVL6mBuBMcZI5zEImz1x2fFFel1d34XQqQoe/pIvJvM3gFoFVhLpltNx1HobXuar26Avo7jAeNVG1gdJdFdHtBp13nx9RRZxrJ2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKV6d/eB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKV6d/eB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D201AC4CEFA;
	Thu, 18 Sep 2025 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758213813;
	bh=lgTAwC7SD+XTZHXWyaraCwOTJrZ9IajXNT1Smh9SYCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKV6d/eBACcqz84SNmSBOByAIwvUGDKyeLwYqGHbdnIrfuSOKVTefQa7MendYNDzo
	 gD3pJdJy/Coannw2zGQIpFRhEb9YWOYRdqqn/kWiC6J0pSHanvhFcx5kIIfDr2NbYY
	 5oLiFm8ihkGzxPkCp3XvlYCRgRadyXja5XDBc6KtYQ1Gldr95Wcoi9tRKEMkaiSfo2
	 3iRKlYeJNgTcdw3mgw4mbMeLcthK7KCq/w70f5puTtMNMp2yCF48WmYd3XGiv8pOMk
	 ZTLOpUzNFNDhAM4/6ZBhKNp8MhH7XIPA0KlpEp31UkIrqRD11rw38FycVPQV2+S9uA
	 f0IjxDTlXZHwg==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Leo Yan <leo.yan@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] perf: Fix overflow in PERF_IDX2OFF() for Arm SPE and TRBE drivers
Date: Thu, 18 Sep 2025 17:43:09 +0100
Message-Id: <175820544017.3483828.18098921754214406254.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250917-fix_aux_trace_index-v1-0-e36a76ac6292@arm.com>
References: <20250917-fix_aux_trace_index-v1-0-e36a76ac6292@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 17 Sep 2025 18:41:37 +0100, Leo Yan wrote:
> If the AUX buffer size is specified as 2 GiB or larger, the expression
> "(buf)->nr_pages << PAGE_SHIFT" may exceed 0x8000_0000. Since
> (buf)->nr_pages is a signed integer, the shift can overflow and produce
> a negative value. As a result, PERF_IDX2OFF() fails to work correctly.
> 
> Fix this by casting (buf)->nr_pages to unsigned long before the shift,
> which allows PERF_IDX2OFF() to handle large buffers properly.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] coresight: trbe: Prevent overflow in PERF_IDX2OFF()
      https://git.kernel.org/will/c/105f56877f2d
[2/2] perf: arm_spe: Prevent overflow in PERF_IDX2OFF()
      https://git.kernel.org/will/c/a29fea30dd93

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
