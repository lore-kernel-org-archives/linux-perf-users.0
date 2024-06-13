Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E18A7F47B
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283313; cv=none; b=H0Z/pDZw0+BZajpy7JSSwcQ6XxAKU2OHvVfXzr6J7BWCIvXsNCjD7uDXQNSJoX2G0Bd3Pm497Xo1oZe1VjzTUuiaukRRpPxn6iDPc0y+wVzWcSAvtrzAjbYB+ECPcGeROy7lpaNS1OQ8uo3uN7bnmeOS4oqaLi+kfd6swYcx6l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283313; c=relaxed/simple;
	bh=cHa1rHauoEc0gFfW/yPSQXlPlD82Vim11NkjVnn7muc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=q6Lmzw1ykK4LT/uj3+RaznHTVAYZLRs9liOpj8k/Z8MSrfFbclA3xyXGWhftGwWTLVnlrUoJtm/yHOBxPXN+j7ez+lV8WC/QmQp4WL2smL8k54Mx03DK+eAPj95c/QMYDOdXs/yDLyQ0dj4wnCGo7jQHNxThLzB/CmCD6p7dW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E35EFEC;
	Thu, 13 Jun 2024 05:55:34 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 950183F5A1;
	Thu, 13 Jun 2024 05:55:09 -0700 (PDT)
Message-ID: <a68343ee-b450-4ae1-a5dc-da6e1c865dcb@arm.com>
Date: Thu, 13 Jun 2024 13:55:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Perf Wiki Appears Broken
From: James Clark <james.clark@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: Leo Yan <leo.yan@arm.com>
References: <87365604-bfa5-4153-b41a-84bf87fb4cfd@arm.com>
Content-Language: en-US
In-Reply-To: <87365604-bfa5-4153-b41a-84bf87fb4cfd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/06/2024 10:19, James Clark wrote:
> Hi Arnaldo,
> 
> I'm not sure if you're still the admin of the Perf wiki, but I'm getting
> a login error:
> 
>  Wiki uses cookies to log in users. You have cookies disabled. Please
>  enable them and try again.
> 
> From a quick Google I think this might be a disk space or configuration
> issue.
> 
> I was planning to add a dockerfile for cross compiling an Arm Perf on
> x86. I suppose we can also discuss here if anyone thinks that's useful
> or the right place for it.
> 
> Thanks
> James
> 

I'm able to log in now. If you poked it, thanks!
