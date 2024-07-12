Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4501174EFC;
	Fri, 12 Jul 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802797; cv=none; b=BLNzg5dZOGoN7ZF6vxGmLW11FhMPmmTQPYg1rCUsUqiORRg3T2oDcrFJ9kadkkAR8emGY4/wPd04iuJ+0uy0TBjUVb7VB48K7GTcht9SIrc95P7hhc67m+FKw8y6RADZ1gEYobQRvOARZv57CCcRcG8abvYeQF9yzLWBGN+HkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802797; c=relaxed/simple;
	bh=j4P+iGJsEuVnFAdcNPxk7ftqI8Z35LaL5iKkqQjU31A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaassXggemYxCAwjfubmX/NG1y7nPeOCGWNEYU2RRgwW4yFk0i04aYnONJUQZ4wlqrWqAAu7OYvLh3KrinCgrXzbAVElpBW8JwB8lilyH22n/xByYXW6G6AA5ZA1etOv73BoMQXzw7abrzds5Q6t6UWgAD269L6QYEfWOu/lTww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMLNTHDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMLNTHDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C071BC32782;
	Fri, 12 Jul 2024 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720802797;
	bh=j4P+iGJsEuVnFAdcNPxk7ftqI8Z35LaL5iKkqQjU31A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aMLNTHDC2d5CHARbvFEW00RmlOop/EJNLk5DN0D+zop1L+dX8c5D9YZp+v+gPDGlO
	 ZWS5AOQra/UaxRrw/twNWTvtL3VQiZv4yIkFsI5h48rsYeFYCkRFkySRqGyEonEEa4
	 FMU5JwEKWH35rZZ5D92ngMdUQ3jYNym4xE7EP0sa/aauh6UDKehei+WHGhSC3I9WmQ
	 4TMiWOX3JUSQ3+BWXXlvAEA9jnLl9794urn1sk3MwvQ/wKYhWQjo8WkHClTvd1LmlK
	 WyHKTvjEJoSQI0XcerneFaqlguBC7ZuMwbEJS7/aE4wwGyoh/2AuieR5RjyV4y5QhO
	 8IPjJBHEDZdog==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v2 0/2] perf mem: Support multiple Arm SPE PMUs
Date: Fri, 12 Jul 2024 09:46:33 -0700
Message-ID: <172080277771.2773854.17023672835306753819.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <20240706152035.86983-1-leo.yan@arm.com>
References: <20240706152035.86983-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 06 Jul 2024 16:20:33 +0100, Leo Yan wrote:

> This patch series is to enable multiple Arm SPE PMUs.
> 
> The patch 01 is to enable multiple Arm SPE PMUs. The second patch is to
> print out warning if not all CPUs support memory events, this can give
> users a hint that the memory profiling is absent on some CPUs.
> 
> Changes from v1:
> - Changed to use strstarts() (Ian Rogers)
> - Changed to use 'arm_spe_' for searching Arm SPE events (Namhyung Kim)
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
