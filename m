Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE3F2571CD;
	Fri, 25 Jul 2025 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753469332; cv=none; b=HoUS4vX4w6wFWbpUUODcMqW8NxL0xTsJouOtdAHana8F+WiiWBYL3jMcCaBhYbmO+XKB4Gr5QhNW/Bf4GlDD5HlsuRUDj6KU8HaUcrMKNjE/rGO9uBVBboqvkOWc6rKciRUamCBUQ2ufKdLEM7cCSZGq7AA3UGSqLBYq2VPdQVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753469332; c=relaxed/simple;
	bh=pE9/kGauhIBasz+rC8UeuJ4jdejMoZS5KgUQuzDZzrY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lJkAZQPuVLmGxLbvmY/L9iEwpl87pr9fCuUsIVueKonaIG9FWAfEpqWK3L2kWX6Q3zXDexCMoTlY635Jfd0xdj+9ltO94A0l1j2sud5Hh+USAdChfjaK+vgDDcv2+PAaRvK30mAXflzcyRKufTnsTl+fEcVZFExntRmpVkhYWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNvDKQcR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNvDKQcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D9BC4CEE7;
	Fri, 25 Jul 2025 18:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753469331;
	bh=pE9/kGauhIBasz+rC8UeuJ4jdejMoZS5KgUQuzDZzrY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=MNvDKQcRBGWqJA3WaY36Zi4v7M+joWzb5u5/EBGIi9eP9H6R/Z7J4fQAUyf08RkGY
	 Oq3WrN0M5cJaA+LaSsR9SWxetE8TL48ICftVICzHUYoSpQYc+Pefkf1TJ/uslzEKGn
	 2tClv2y32zIl20VhrlV7CY4yt2lhXT9Z2LdUJUsdmdsPuMDLimMjAE64oOexwxvp1C
	 AUdPJ8jzFdsR36Fjg6KJyju0DiWqOWgK69OmytnCL8TY2GSrsRI5pw7qZoGyuXUDUN
	 95dPK0XZH/w3Q6rbDuEew7/o6ZBrEQdfEP15SyFCACOqVU0/UraZrqWOSGC+QjFmKQ
	 h0o5sedJ26OWw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Colin Ian King <colin.i.king@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
 Dmitry Vyukov <dvyukov@google.com>, 
 Graham Woodward <graham.woodward@arm.com>, 
 Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
 Zhongqiu Han <quic_zhonhan@quicinc.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, 
 Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
 Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
 Stephen Brennan <stephen.s.brennan@oracle.com>, 
 Chun-Tse Shao <ctshao@google.com>, Yujie Liu <yujie.liu@intel.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
 Weilin Wang <weilin.wang@intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, 
 Matt Fleming <matt@readmodwrite.com>, 
 =?utf-8?q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
 Zixian Cai <fzczx123@gmail.com>, 
 Steve Clevenger <scclevenger@os.amperecomputing.com>, 
 Ben Gainey <ben.gainey@arm.com>, 
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
 Martin Liska <martin.liska@hey.com>, 
 =?utf-8?q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>, 
 Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
References: <20250724163302.596743-1-irogers@google.com>
Subject: Re: [PATCH v6 00/22] perf: Make code more generic with modern
 defaults
Message-Id: <175346933064.1444596.18163534878104152234.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 11:48:50 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 24 Jul 2025 09:32:40 -0700, Ian Rogers wrote:
> This patch series combines:
> "perf: Default use of build IDs and improvements"
> https://lore.kernel.org/lkml/20250428213409.1417584-1-irogers@google.com/
> "Remove global perf_env"
> https://lore.kernel.org/lkml/20250527064153.149939-1-irogers@google.com/
> "Generic weight struct, use env for sort key and header"
> https://lore.kernel.org/lkml/20250521135500.677508-1-irogers@google.com/
> This is done as the last 2 series depend on each other and the
> cleanups in the 1st have the potential to conflict with them.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


