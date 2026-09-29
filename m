Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2EA4BF936;
	Tue, 29 Sep 2026 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672922; cv=none; b=QW2T68mUzQ/yTJ81MEVObgu8iAZ0xAU3gM86sDzGEyA7FUw921J4XdhtM97vkXOWfDWM4wTHk1m+X+oy0ryyyNFuCfi+PRzTFyySiG4hRUQUAIMY2Xlcc2KOneeffkoKqIbWY3rUVKQfZYdp9b/BSgPPzcctOGfemXUfci4yMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672922; c=relaxed/simple;
	bh=m1Kg2+YeJeivJxsBfOWC501ehjI+0hjwdQFQz6IieNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fh4R49HmrrUOUc54tUdx9szKyFGN1qosytimB57XitGfPZxq24P+LAQ42zayRqvbyl4Kd9L3cBdBIPcAOLwx2ktGjzWXsIDL+nb0RTcHhs0WWCq57RNKOkR/oybvoTXkDriDrm/lfKWWSd83MxocJ/+V/L69C07OhM/HpfBp0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ez42vH7S; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ez42vH7S"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790672904; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=eFQ4vreHXDUaO3HsKcHYviwry83Esj7w8plbIxQJJDY=;
	b=ez42vH7S94t6cXtoSNdBuRyQlyxr+GU8OoXtEq0RIB/ksRC05exGLaKCVkm+Si/Q4cSProTZYPv90l6OLMejpcIScx093dIvXKBocoDritZrdxZU4OKPMEnB87sTUnpALpmmm9RnB/0y7oCSs+wR6JI0kZKTg9ntGGXNn1+xWpA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0XBsgidE_1790672898;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBsgidE_1790672898 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 17:08:22 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: acme@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	leo.yan@linux.dev,
	john.g.garry@oracle.com,
	will@kernel.org,
	mike.leach@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	guoren@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tsc: Replace the compile-time TSC support check with a weak hook
Date: Tue, 29 Sep 2026 17:08:13 +0800
Message-ID: <20260929090818.2651-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929092850.697bce16@pumpkin>
References: <20260928094739.2605-1-cp0613@linux.alibaba.com> <20260928094739.2605-3-cp0613@linux.alibaba.com> <20260929092850.697bce16@pumpkin>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

Thanks a lot for the review.

> If you mark the prototype in the .h file "weak" you don't need a default
> - instead check the symbol for being NULL.
>
> Then you can do:
> 	if (!rdtsc)  {
> 		pr_debug("Test not supported on this architecture\n");
> 		return TEST_SKIP;
> 	}

I've just sent v2, which declares the support from the build system
instead, following the existing PERF_HAVE_JITDUMP pattern, so the
decision is made at compile time and there is no symbol left to test for
NULL.

Keeping the __weak rdtsc() stub also means the callers that already call
it unconditionally don't have to grow a NULL check.

Thanks again for the suggestion.

Best regards,
Pei
