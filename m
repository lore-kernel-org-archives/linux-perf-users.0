Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D58837DAAA;
	Wed,  3 Jun 2026 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509055; cv=none; b=h3QrFTQ84CGvAmSvplblEg9V9bhqkK21fu9oJVfAlZuYkCpJBgqDzr7Z8bH7OGmTWOirepW4++JuIR2QIAQCXiKCA/ivoDVMZIn4ry2Q4TYUb1YNnIgKjtrVOvr/7s4KEpXb9hzsM3KrdFtePUly74RF5ty6MCLcEAOYNEPAZww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509055; c=relaxed/simple;
	bh=B5Lqtd1oa0rlp+ydOSNsdkfEIB24JYJistvdJ8DWLc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIKzNoYWsqId4z1Sg/xIOT0ztL7/yOONv9/ynnTelz06n6M7ugv4A8Bnn0UwyrirBQpGEh6VOwqWRAU2RcAI1Rip30P6GB1L/8wlpRdCxYnNt5YtJgJi7UEI9g2HnONqyfpJR5VWkiJt8ibEGVAuLFo9kYYJr2ew9io+XacEcLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y0sdcHkM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y0sdcHkM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D01032E4;
	Wed,  3 Jun 2026 10:50:48 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAA493F632;
	Wed,  3 Jun 2026 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780509053; bh=B5Lqtd1oa0rlp+ydOSNsdkfEIB24JYJistvdJ8DWLc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0sdcHkMQOlmliCSSMgxKSjEkEdJ13Owb0hAh4ohcOimLGuGYKLCNzG7F8d5ZHFWb
	 KhO70aTFKams8gEu+NOFsGnab5N5d4QYUdadn3SS2+QpG4XnH362H6P3WW+QmUJnZ7
	 L5h58FEJTTJsP4ONkQ/Ck1S37LbKTGjLysYOn7p0=
Date: Wed, 3 Jun 2026 18:50:50 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 17/18] perf test cs-etm: Speed up disassembly test
Message-ID: <20260603175050.GI101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-17-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-17-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:59PM +0100, James Clark wrote:
> We can use exit snapshot to limit the amount of trace to decode here
> too. Also each call to objdump is quite expensive on kcore so limit it
> to 2 samples instead of 30. We only want to see if there is no data at
> all.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
