Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB51F3FE3
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908392; cv=none; b=svgU5ML+wET6xOqeW6SYwFbUG/ArtLGt4RaDzk+/bU8cLLwDtsXZCPxuwyS+yvPnGGtYTizsgZpM30B8PjxzVL0E3FoKaRCpLI1T951o6pVWVjr+ebR1eT2IyMxNL5pZkBcR44jsKByH9k+4v9jZvcGiZHghLdKvKpGNG/8pXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908392; c=relaxed/simple;
	bh=9K9DwrvmeBbzdSmjxG17JuEyCBdJKm86SEYFgpbl45I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKXwmSGg7Yi0/htP6Xj4j2DXx5Hg6D2IVD7+01mz1xc3a93ZL9U/+exVCFHUKU4h+MNrIfLNVUK+Z4p3w8ay0cw0uN7TsgyM78/Zi9wLyQ8mbBYig8CNZkMJtMxbmUyZgOEA4mll2pw7cqRwIVNmrakV01S/0NaLIMXQnCwVOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b75CgLQQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b75CgLQQ"
Message-ID: <bda3add5-a001-458e-a8d5-351967dbcab3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741908387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JcgTRng7rubdt5hkMeAB9iE5M5ixzFPc079zcVyCH+c=;
	b=b75CgLQQl6SeSsyBcyaPBnN9pO3zELeFgSPoReRiPJumiF/ry8j0aDzWPX4QFHMkrG5X9e
	wfZmTvRcXyBy2n8B5MTAnmmdh8MraWQtpjnmmT8FwX7JgJn6yS861hj86a5YGdkcVxRaO7
	NQQ8uq4LEcXEAZvOXqw/p7KcESduldY=
Date: Fri, 14 Mar 2025 07:26:10 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH linux-next] perf/ring_buffer: Add EPOLLRDNORM flag for
 poll
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250313051047.2436098-1-chen.dylane@linux.dev>
 <Z9Kt57aAC7XET7Na@gmail.com> <87b67a79-d97e-4f81-9bf2-aa34d613b5bf@linux.dev>
 <Z9MRWT5PWtPaY-pl@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <Z9MRWT5PWtPaY-pl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/14 01:09, Ingo Molnar 写道:
> explain that this patch fixes
> this particular poll() functionality and semantics

will do it, thanks.

-- 
Best Regards
Tao Chen
