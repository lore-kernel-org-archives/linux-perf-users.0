Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2855215F4A;
	Tue,  4 Feb 2025 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689967; cv=none; b=LhixwZyfBXYTo8zQC84ojmVHSLBQANoJzgtChFlCj9+piYWZwT9fAVy2iAr7UzE4TyeKT8gnzaYOyM6VKaIaitqzUV9E4VXwn6evExZAPhuQkCWhflSIPIGW4g17n5heADrabQa5OTtPGE+SU5fAO0qdAlm2DJk4r+ZLxh0GEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689967; c=relaxed/simple;
	bh=+AHruaIUOZFLWqMc+ElaINCkYXUbqogkFO1qg8qSoIk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HZ8EVJNhcXiH1VQu1sk7GTdytIrK/gd36EKy96sltD+w/sQxXhEbFsDhQ922mRpW4WWIIBKJ2lGDzjGhMUBL/l3OdzThK3VA08SNX2LZOcNAYeM1Siq0bSOnuHVW8bDDYiq5iyCvAYiTOCWyM+CrqdsTdo8AZMpJNgO+nCt4VV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcjpDWPc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcjpDWPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777ADC4CEDF;
	Tue,  4 Feb 2025 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738689967;
	bh=+AHruaIUOZFLWqMc+ElaINCkYXUbqogkFO1qg8qSoIk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=KcjpDWPcRBcTmJQvo5GqEiOUEl0fBHag3mmS09x2MiA9t7BTbvd5OVk5G/wwj19h0
	 Mko4yyxkMm20xHHxVA88Hi9BiuzziXNgbu1V8MLu8oTyhHmIEBznKa5lHGQMDPoJza
	 w2fEKuQGd1MIj9CLGrLMNWRVv52zh1FiYdni5wH/4CBJigFKTW5ILH/5MQRp2jtH25
	 FSe8Y8Ay55bJpa7vZCcbjqjtcGWiqqI7G3ZpJiPFDcREtnad3kPXo2UJ8s7TXLVkUh
	 8iMzpuWiJp96zD0rYrO/VQkTTAXQl2vAn5BQp0hqP4F0MRKu8sU/5j0FI9FY0XHP3d
	 C059IRMx5GhIg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250130170135.5817-1-irogers@google.com>
References: <20250130170135.5817-1-irogers@google.com>
Subject: Re: [PATCH v3] perf test shell tpebs: Extra verbosity and
 hypervisor skip
Message-Id: <173868996642.666026.11209605803068738109.b4-ty@kernel.org>
Date: Tue, 04 Feb 2025 09:26:06 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 30 Jan 2025 09:01:35 -0800, Ian Rogers wrote:
> When not running as root and with higher perf event paranoia values
> the perf record forked by TPEBS can fail to attach to the process. Skip
> the test in these scenarios.
> 
> Intel TPEBS test skips on non-Intel CPUs. On Intel CPUs under a
> hypervisor the cache-misses event may not be present or precise. Skip
> the test under this condition.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


