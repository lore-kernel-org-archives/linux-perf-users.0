Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14A1DB551;
	Wed, 22 Oct 2025 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093559; cv=none; b=f9Xodn7Q68n4b4PSLBZPJ1BbhKYLWsHsiHhLgt3FPI7B7c6XVK2cnTR9K8sYiFcjMvqfayKx9d8oR2sqhCERJofOtTgZ2zy4Gs9IBhrk3uLHeBZsPPIDRCHtwMY7pBBxIRSMtH2MCxg2S0VrP2ofi+KwUpROV6Ubo+FE7y4AxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093559; c=relaxed/simple;
	bh=X44HyL73IiaW+fZkqQgpSvq33GrGcXgftuScMPznq1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tVGZIESdyAY6XpJUpOefWEyVZE04pmyek4ni1ZXcPRlx/1bs8Cp2V4ALGw7euK5VBlZJLXp9zZZf0agE3QxQ5n9bTsBzNvigztvRWia3g5VQDYT0VWSEsuZRxU0U6xHOAX0iKag/vxR0DMupzAs8XVHOuMQUQIrYPLabu+89rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCKvuUfd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCKvuUfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA843C116C6;
	Wed, 22 Oct 2025 00:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761093558;
	bh=X44HyL73IiaW+fZkqQgpSvq33GrGcXgftuScMPznq1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lCKvuUfdUL/0a40QEbOwZ1mgIDJ4lxzk05xjVrXgcoD15a62uu7ICsoYsVNEd/7Cu
	 bs9cQKzYLbko+la5sErowOyidkbc2/4puNwRpuWPx1B9n93Y/RVAiZpvPG5Xn9eF4w
	 Ghz9FOhVOCFcQ6ZHkVF+PqlwJ4gYnEaz4eu4DliaT/g83+2mYvXZDYQpNBhaJ3WX1m
	 5/jsY5S8ijWjTRcgm+9uJX3aPAq5CrednZdxaj6FzWzIdnmyBPdAakbhIY/TnyCQd7
	 iv6YdOcEKa/2IHWDgyfypXV8qLJeda3C9izb1LxZNzFovPZUYeH7nbH9+5FAyHOlEq
	 4byRShy8fl9zA==
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>, Tianyou Li <tianyou.li@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, wangyang.guo@intel.com, 
 pan.deng@intel.com, zhiguo.zhou@intel.com, jiebin.sun@intel.com, 
 thomas.falcon@intel.com, dapeng1.mi@intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020073005.957524-1-tianyou.li@intel.com>
References: <aPW2iiNeheOxDGw8@google.com>
 <20251020073005.957524-1-tianyou.li@intel.com>
Subject: Re: [PATCH v4 1/2] perf tools annotate: fix a crash when annotate
 the same symbol with 's' and 'T'
Message-Id: <176109355778.1850903.1376466916179653638.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 17:39:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 20 Oct 2025 15:30:04 +0800, Tianyou Li wrote:
> When perf report with annotation for a symbol, press 's' and 'T', then exit
> the annotate browser. Once annotate the same symbol, the annotate browser
> will crash.
> 
> The browser.arch was required to be correctly updated when data type
> feature was enabled by 'T'. Usually it was initialized by symbol__annotate2
> function. If a symbol has already been correctly annotated at the first
> time, it should not call the symbol__annotate2 function again, thus the
> browser.arch will not get initialized. Then at the second time to show the
> annotate browser, the data type needs to be displayed but the browser.arch
> is empty.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


