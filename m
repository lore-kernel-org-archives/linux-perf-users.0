Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E730748D;
	Tue, 18 Nov 2025 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429743; cv=none; b=jCtXrrtUP/VbUBbo6bUD19G3Wc+JFnzWTHF8yKkoAfegNWQLw6Ncc+qEzH6WbWyT1it8KNmIMZtNPr8U6tmX2M2ZIn8hp8Sc7S3hEeb0b2KGgwGmcRSpCZuHRFd5eaEvhsKn3JuNq2iAzPai8sukB/+5r0VsaO0U+n1G2aeyrKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429743; c=relaxed/simple;
	bh=F7jBYq+FVv2XZh4G25jTJE2v93id2pLEDLw0Xoab4CI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n4aVMUy1rJ5exVs5mBqpCVUprQF6W2dP9p8QQw+5x7NUE3OEVRe9OWJPl621mHJSkTuEb2oEvmghz6KrpKMLSGj5hSVSZCzWifeTALINGdxfafePWYW95M/nc77TERUh3UzsG6bzJ0AxnQeIRjhlkmZulyKYwwe5GOEwZCNMqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR4Lwc90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR4Lwc90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8642C2BCAF;
	Tue, 18 Nov 2025 01:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763429740;
	bh=F7jBYq+FVv2XZh4G25jTJE2v93id2pLEDLw0Xoab4CI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=IR4Lwc90Cpf42LMqsFkX3CNTLZWFsLs84FLGOZiDS1MFaA4JmTo6RKNijuqvqGurn
	 Oy4TcvNU8O4lCUZaNho+Y7Ni5FvnUOSOnxyerWANJEo1rfapsDbVTBalgUVl0xqfAt
	 z8B/BIMkXDD7HFL3OfPigqFE8lSD8V4GV1YzjPwk5zLqqibi6/2UGWH3Y4ckiVBYmd
	 +OIJ2dmx87/hXrwh/jl9TmWqOI2IPQ0ca2gEFIu7USw7++8OKtLlZvrbNEv1bl5iqD
	 ONM0L2vKuad1EZDVZ8Uz5P003oNU7TzgrUrfOqsWrR+rp8brIjzo4hXzUglgtDMK/Z
	 Yt303aO6pWGFQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
 Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251112195311.1673981-1-irogers@google.com>
References: <20251112195311.1673981-1-irogers@google.com>
Subject: Re: [PATCH v2 0/4] Test fixes and debug logging
Message-Id: <176342973853.1348495.1043657035025955468.b4-ty@kernel.org>
Date: Mon, 17 Nov 2025 17:35:38 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 12 Nov 2025 11:53:07 -0800, Ian Rogers wrote:
> Testing in a hypervisor guest showed some issues that these patches
> try to address, or improve the debug situation upon.
> 
> v2: Rebase. Tested Arnaldo repeat case on Intel but didn't repro,
>     assume was fixed as part of the legacy metric json test fixes.
> 
> v1: https://lore.kernel.org/lkml/20250914182900.1960567-1-irogers@google.com/
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


