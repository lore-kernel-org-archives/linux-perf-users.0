Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801A198845
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Jun 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691863; cv=none; b=gihE49UvGVKdUwnD9fwwj7T8xPdH63tWYXn0jlY++d76lcqHlW15nUbkafzHZjTJyxBNbAKXTUVMBW6UoRpSo45SbppK6t+tQDA6HiXQ/GspODz5g3Q7luVD+X5+243/xyWV734iw2ZzvIqRLHyIfIBDn9pqxh58mpmrkvh4F9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691863; c=relaxed/simple;
	bh=b2FvQmAJ8/IEWHsWjhKFRknU1PgjVP/BwJoI+mtyIow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzB71sb/uFcAHcgy1KXcAYnWa+fPuCR+CYLMQtCQmCUNg1U9Vda7pUxeLO8/c/uw2+otU0ytsAf08RtYeoRjPrHH+Zl7RAOAkudzSgvBow6HwY3etnSHJZ//QS6BSbz9oDpcbeaUjeVXinp67oXLPa4Yce0SAIWXKaavotqCtDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 322C82F4;
	Thu,  6 Jun 2024 09:38:01 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 269303F881;
	Thu,  6 Jun 2024 09:37:36 -0700 (PDT)
Message-ID: <aade02cc-9ccb-42c5-a2ff-f8d9e6d740fe@arm.com>
Date: Thu, 6 Jun 2024 17:37:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf build: Ensure libtraceevent and libtracefs
 versions have 3 components
To: amadio@gentoo.org, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, Peter Volkov <peter.volkov@gmail.com>,
 Ian Rogers <irogers@google.com>
References: <20240606153625.2255470-1-amadio@gentoo.org>
 <20240606153625.2255470-3-amadio@gentoo.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240606153625.2255470-3-amadio@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/24 16:33, amadio@gentoo.org wrote:
> From: Guilherme Amadio <amadio@gentoo.org>
> 
> When either of these have a shorter version, like 1.8, the expression
> that computes the version has a syntax error that can be seen in the
> output of make:
> 
> expr: syntax error: missing argument after +
> 
> Link: https://bugs.gentoo.org/917559
> Reported-by: Peter Volkov <peter.volkov@gmail.com>
> Signed-off-by: Guilherme Amadio <amadio@gentoo.org>
> Cc: Ian Rogers <irogers@google.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>
