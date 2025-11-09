Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F81DF270;
	Sun,  9 Nov 2025 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717871; cv=none; b=GBkYttf6fawP/JKbkLufTX9zh6XCyRoSqJWkveKx1Kj4sMztRqppnG0sRq4twOBisIIBBTYIeImatKS5p8kYuZ7DCZ8BRxmRptu4KjnHSYr9mcFOu75rSasG/8InNl3xvkZei28j3brpuSnaxCWBDzuP9ihfKWS4s/wBMs50IOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717871; c=relaxed/simple;
	bh=5yO2N/toACBlh0BNXaaERuOit7EXTzv0ROu0z/vmNYA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rbthqqr5VtUr6WlE2hEfQr3WHpFghJK5YyUV633DYfrfgYZT0JYP2TfAd2o2jSg5FsFnrXxq7Cx6TVZh+OxPeZndFkT5nL5PKkvgGFjkHCRHiSEHGiGnW0aOUHfZHIoPJ0g1d0YfUpWChVHY/kxwsIHGsDfY4trrt0Y6MFl9u0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABYvb9RM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABYvb9RM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB20AC4CEF8;
	Sun,  9 Nov 2025 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717871;
	bh=5yO2N/toACBlh0BNXaaERuOit7EXTzv0ROu0z/vmNYA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ABYvb9RMoK4VdSJklM+3GfIdvjyhp5+fBbWZAO/YD9ErHSCo6q5mQQnMFUV+Lm+lM
	 2fIlXGWSKUhgsdl/jlCdbbcmQLlphTJZSDpCvFJG/w9qRgtPceVYuQE0xztcZ7PrHC
	 KQ8vCwXJNITKSsrekeQjNH5Lv1YDxvL4yX21QsrgH9ffjT1tKdSvKlx/wobF6iquMK
	 SnfZ2Fu1h+D6oJkHweRBQmz8okFe/SeRDQz8fPuyT1SuUs9RyBcjD2w4e3HAAFF6Ez
	 TdWxhzhSk3djlhZ6WUPKHtQvKHYHUqbPXKhzo7fQiPmj+Sn8gosT/cP1Ivy/JsfPdn
	 83rLBABJlo9kw==
From: Namhyung Kim <namhyung@kernel.org>
To: Gabriel Marin <gmx@google.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Athira Rajeev <atrajeev@linux.ibm.com>, 
 Gautam Menghani <gautam@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
 Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Zhongqiu Han <quic_zhonhan@quicinc.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, Blake Jones <blakejones@google.com>, 
 Anubhav Shelat <ashelat@redhat.com>, Leo Yan <leo.yan@arm.com>, 
 Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251107170712.2302714-1-irogers@google.com>
References: <20251107170712.2302714-1-irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf tool: Add the perf_tool argument to all
 callbacks
Message-Id: <176271786886.1711746.4583976812483575494.b4-ty@kernel.org>
Date: Sun, 09 Nov 2025 11:51:08 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 07 Nov 2025 09:07:11 -0800, Ian Rogers wrote:
> Getting context for what a tool is doing, such as the perf_inject
> instance, using container_of the tool is a common pattern in the
> code. This isn't possible event_op2, event_op3 and event_op4 callbacks
> as the tool isn't passed. Add the argument and then fix function
> signatures to match. As tools maybe reading a tool from somewhere
> else, change that code to use the passed in tool.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


