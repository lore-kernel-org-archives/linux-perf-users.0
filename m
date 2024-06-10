Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4C218C31
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Jun 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011166; cv=none; b=SM5TwbIvl4IrTVmEZCKR7kdlTVlpeFbbCnOfdnyHpWpMwzAE0Vg+4zAgSPzYR6sc9mZBYh3vqhriiuXOMg1jfN+lQGYv0cwwMG1BTQ4/KxEj9xiUHmwT1UFXj9ITr8d3k9t4y3QKLSKOQZDSmUr8d02ZTrbZ5OEBkLJop89MH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011166; c=relaxed/simple;
	bh=XOdb3pwwC5hSDITihHOra5FpsEm7D5YzaKclNQhE7Do=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RIqpmkHL3Bz3u1G84ODGGqR/RAdk/aI+m6WTmsH/UTFjw4MAyhIoQPulkSkeWZKKQBDkszxcTUkmyRy0g6ZmoCQPVOg9OQcjpY4lo/qjQkvsrVaRIeh/LGkUCpJjCi1DlU/ZgVmgf8ypifN9zy3HNo2h7ZBvOXQDEFYdz6uTG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23E1712FC;
	Mon, 10 Jun 2024 02:19:48 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31EC93F73B;
	Mon, 10 Jun 2024 02:19:23 -0700 (PDT)
Message-ID: <87365604-bfa5-4153-b41a-84bf87fb4cfd@arm.com>
Date: Mon, 10 Jun 2024 10:19:22 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Language: en-US
Cc: Leo Yan <leo.yan@linaro.org>
From: James Clark <james.clark@arm.com>
Subject: Perf Wiki Appears Broken
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Arnaldo,

I'm not sure if you're still the admin of the Perf wiki, but I'm getting
a login error:

 Wiki uses cookies to log in users. You have cookies disabled. Please
 enable them and try again.

From a quick Google I think this might be a disk space or configuration
issue.

I was planning to add a dockerfile for cross compiling an Arm Perf on
x86. I suppose we can also discuss here if anyone thinks that's useful
or the right place for it.

Thanks
James
