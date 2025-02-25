Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87E198A32;
	Tue, 25 Feb 2025 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520692; cv=none; b=CLxXCPjVr845bcjGO+Fpkh2pc5rST2vLbdOaH8HBW0aKGv94yABZU/C79GskCpkac1pSGdJfvifBcDKZNCNbC5ePrV01FJ9qQEne9NlEF0zrNxKZnPuLOauiNGneMF86Bu2kZFRPySsMi8NV//CwzNKL4JDO8A7aIFWOfwK9xYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520692; c=relaxed/simple;
	bh=hPcD2DXbQWYU6g1qckExXwya4Mc2wheV8b4OIiSU60A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pqACwcND4RlBl4JxjtSIEKZDOZweIRFWE+KPY/1sWR0eU4C8kcGaeOO5t0lavrwiJhdWYmNcAA6m0ZpfsT2L9syXmsUO62g+n7FBRyEdMn8B2dkLLoduwe0Aq2l0yI+UDB5afi567cIYtZwv7+luBZD+YHKSAkjVMS+Fcxq9fU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuHq4FUy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuHq4FUy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E834AC4CEDD;
	Tue, 25 Feb 2025 21:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740520691;
	bh=hPcD2DXbQWYU6g1qckExXwya4Mc2wheV8b4OIiSU60A=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fuHq4FUyC1zWzlwmkJ7tfX8vN2z8N/ec4eFOoUat3MsTnURgn3hNQ/xbRE6zk6nvi
	 bJGHtcFJ6R86IjY6G2/okd0GDbG9iActvfFQgUuiKDYpA4h0wTUyRfzKU6/F6kwKq2
	 i+K1q0gkA1K2PTCWI24eu4BNE3kSmjWCk+audri9E9fVvPHnP9ve7YZExYwZ4V0u9D
	 OuDWWApBdYCRmz2H6DJJc4mRe8IJVO2pT8W8T1UUnXvAAwpzPTrbbdo46dicNH50T3
	 3TV9x/Mgdh/KMGppX4dxUeiPD1RzFKDyBfdenIHl0XQfPKnrSaqRK2o5XC/FpbzJFx
	 bZbgByUNxU9kg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>, 
 Jesper Juhl <jesperjuhl76@gmail.com>, James Clark <james.clark@linaro.org>, 
 Zhongqiu Han <quic_zhonhan@quicinc.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
 Anne Macedo <retpolanne@posteo.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, 
 Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, 
 =?utf-8?q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
References: <20250222061015.303622-1-irogers@google.com>
Subject: Re: [PATCH v3 0/8] Add io_dir to avoid memory overhead from
 opendir
Message-Id: <174052069088.518612.8243648115065735498.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 13:58:10 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 21 Feb 2025 22:10:05 -0800, Ian Rogers wrote:
> glibc's opendir allocates a minimum of 32kb, when called recursively
> for a directory tree the memory consumption can add up - nearly 300kb
> during perf start-up when processing modules. Add a stack allocated
> variant of readdir sized a little more than 1kb
> 
> v3: Rebase on top of Krzysztof Łopatowski's work. Add additional
>     defines for SYS_getdents64 on all other architectures if its
>     definition is missing. Add a patch to further reduce the
>     stack/memory usage in machine__set_modules_path_dir by appending
>     to a buffer rather than creating a copy.
> v2: Remove the feature test and always use a perf supplied getdents64
>     to workaround an Alpine Linux issue in v1:
>     https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/
>     As suggested by Krzysztof Łopatowski
>     <krzysztof.m.lopatowski@gmail.com> who also pointed to the perf
>     trace performance improvements in start-up time eliminating stat
>     calls can achieve:
>     https://lore.kernel.org/lkml/20250206113314.335376-2-krzysztof.m.lopatowski@gmail.com/
>     Convert parse-events and hwmon_pmu to use io_dir.
> v1: This was previously part of the memory saving change set:
>     https://lore.kernel.org/lkml/20231127220902.1315692-1-irogers@google.com/
>     It is separated here and a feature check and syscall workaround
>     for missing getdents64 added.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


