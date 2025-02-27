Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F51DE4E1;
	Thu, 27 Feb 2025 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675029; cv=none; b=pGeQ9JYr1YZmikPdT5XwzeXUivI2oRAMryfsyfY96Z/q8o2K3s8B1jOXVOMUiw63liUK42uCuWpFDxTpvcTCpQbQhPgrfL99nDdWAG/vgzm6qUkAAOJPB5tEzrwMcanTbxtuIwWLLxi8Dp6R7Z8SY4POsiR7pRADgaaxj7GBz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675029; c=relaxed/simple;
	bh=Nw3a/HqiA/9jZwNLrxFdA5F8h6oOiANM6gZUgomRjN8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jud7qATcvGnM+r6T1qSBqq2QAsV4QVYswpKjActbRrfJXxirW2K6/ZM/c6CaeOsDe4HLC19hP4Bn52nUwvhc0Zhatxw9Rw5dxV++VkVyGz6SW4i6K/hpa6DjWHVmPwAVirgqAVGirGIv/o3ut7o73D+KFZ1fdTEy+nB+IZFGAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkPMD6c0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkPMD6c0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427CDC4CEEC;
	Thu, 27 Feb 2025 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675028;
	bh=Nw3a/HqiA/9jZwNLrxFdA5F8h6oOiANM6gZUgomRjN8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UkPMD6c0kkXoht68ELlk6q8JqmzCyw7K0r2OSVEqiAdHz/m3a7sh5RLVlbd2uY15T
	 ptNpaG15C1IM2U4nnOo12brMjOfzLUo/0eGMDBpe7Thkge5xIJJEG/R+7CqTeJU6sK
	 uCb2Z+rsJ+p3YFdcjsIl280EkM0GLZez14K72CfXRIKKoHkcO60dt5SZtc3t02JaPc
	 fMRwPrkVfvlMV2m/qC3bn0Oz0Zh3mvgICSnLjCVYs4CtUu7KxD+ie4aNGqCx82xbIu
	 d8Xv5gGyKKBJZHsLm6jWFDMDc/Uu17rENV1b0IHXtpPgEt3x/G78iEFnKrRaYKawnF
	 0vkP/6t1GLI6g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Tim Chen <tim.c.chen@linux.intel.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Meyer <kyle.meyer@hpe.com>, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250210191231.156294-1-irogers@google.com>
References: <20250210191231.156294-1-irogers@google.com>
Subject: Re: [PATCH v3] perf cpumap: Reduce cpu size from int to int16_t
Message-Id: <174067502823.1401960.12891801652873612376.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 08:50:28 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 10 Feb 2025 11:12:31 -0800, Ian Rogers wrote:
> Fewer than 32k logical CPUs are currently supported by perf. A cpumap
> is indexed by an integer (see perf_cpu_map__cpu) yielding a perf_cpu
> that wraps a 4-byte int for the logical CPU - the wrapping is done
> deliberately to avoid confusing a logical CPU with an index into a
> cpumap. Using a 4-byte int within the perf_cpu is larger than required
> so this patch reduces it to the 2-byte int16_t. For a cpumap
> containing 16 entries this will reduce the array size from 64 to 32
> bytes. For very large servers with lots of logical CPUs the size
> savings will be greater.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


