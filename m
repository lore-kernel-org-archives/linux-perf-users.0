Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1319CC11;
	Sat,  9 Nov 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731170240; cv=none; b=tZIInxo2PxtnBFPQA0GlsvMkP82CCtGefXj/+TP6L145XpW1GUqVdAqDDSc/kz/e6PpKrFpyucum52GJN1jghBEbym+YtoreQuDNHTA1eUngtaLwpROV6HUx1U5lHru8WdWwyScpgs9KVUhQlU/9D6ft3ygTsIpAvdJuWy/Ov8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731170240; c=relaxed/simple;
	bh=P4RMwkegjc1YeXa38xDjfGQA07Gz+GlyJRG9oqGG6pQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N8Fd6OKGlY5UDOg6sE+T3d2ha26RUC3DlbLXA3W803IDeiXNbG1A9RioYD/iwQ9yxVGAXRs8NNMj3SXhb4DnfOWtSHbvFbrm+3Sg2A5XdPNclY2rn51voQEAtvHb+b0UdYBcd13Hwt3EVnZKecessDXixnTfQwy6Xu6nqaOXGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JASpbaJf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JASpbaJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90483C4CED6;
	Sat,  9 Nov 2024 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731170238;
	bh=P4RMwkegjc1YeXa38xDjfGQA07Gz+GlyJRG9oqGG6pQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JASpbaJfgpbnm5L3Upgxoyh1PBgSCEh3dbCONkmwGb5FvQH+uaQvy+fb6qE9eXSjk
	 MDOr7zle182CYyCuyGxPFgcjqKDTMVY5LLFqBUmSWiwUPYXsAnO/mefU2bgqqUB/5/
	 wT0jwHZNxM9+k4bZuqnH3V93xtEiamrr3bFYqLsZJ9AgjiKvNxo8O7Tjc3eQlSolWG
	 ZuEM2823eO9jq0YZ5SNPJUPAOTBJQH2+qb2Q7ZFmmGOgcw1OhUdQzQltHFuC40pmAY
	 8CnN2ffvgKejulAtYzAJ6OwreA3XA9r7qtAQOinnXMHhh/IBgRo1uYYv+784NXRoX4
	 SafkeSurwkL7g==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
 Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
 James Clark <james.clark@linaro.org>, 
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
 Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
 Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
 Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241109003759.473460-1-irogers@google.com>
References: <20241109003759.473460-1-irogers@google.com>
Subject: Re: [PATCH v9 0/7] Hwmon PMUs
Message-Id: <173117023754.3738736.6659250361794956153.b4-ty@kernel.org>
Date: Sat, 09 Nov 2024 08:37:17 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 08 Nov 2024 16:37:52 -0800, Ian Rogers wrote:

> Following the convention of the tool PMU, create a hwmon PMU that
> exposes hwmon data for reading. For example, the following shows
> reading the CPU temperature and 2 fan speeds alongside the uncore
> frequency:
> ```
> $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
>      1.001153138              52.00 'C   temp_cpu
>      1.001153138              2,588 rpm  fan1
>      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
>      1.001153138                  8      tool/num_cpus_online/
>      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
>      1.001153138      1,012,773,595      duration_time
> ...
> ```
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

