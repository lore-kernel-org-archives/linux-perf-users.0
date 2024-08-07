Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93578171E69;
	Wed,  7 Aug 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031793; cv=none; b=GjrAbJ5kJdnLZvBqJ7CWyVIKdXk822CWLisEpGj1jjZjDXwmPm7h+d73Ikecul4L8/nJ/zpSe9Rs3p5s7H4MDBwf8LswUMw+uvFTRJi21LLJX5IgUtZog+sLlU0yqP6Bvq/ghMG/bvpY0MySI9O+/HvrUtww4p203eigawu0RG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031793; c=relaxed/simple;
	bh=ZtKMqdZ0X79oOtPHLiqIbrTmz1vuAlbbHU+ivBe+c+8=;
	h=Message-Id:Date:From:To:Cc:Subject; b=HzewAo0DLAaVA0YnHzSA2L4vJOsAflTRrC0TR+pei2N4+b9XrLDemu+1rNo7jhIR5DexVVeE49a+ItrqSpwz0GlIsZ/Dqb7n5eqvEZBiduljGhmeNnBBbTSegFwgMIHUiYGdWqBbhMwaJcEJ1evYOv3khSncco5lSOrCRtRE9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MQ7BgjWp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MQ7BgjWp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ZtKMqdZ0X79oOtPHLiqIbrTmz1vuAlbbHU+ivBe+c+8=; b=MQ7BgjWpADKL0kTYR3cVnsZbEP
	0wDlbTlEB9TR3At5xDfGiiCfrj9OmEINfESw9Ivutzw3TINKRog1y2zn2PhTFQCngin0bVyDJG+GH
	ARn33El/AcJJqxhvAavwqSoTjVl23o3YvZ5XaFINFrshTdrgec1H1YiaE2Hbaczl0paZuBG7Ytoza
	r7g5sAzu7T2g2QBz+mp2+R2SpZws94OtTZzE+ez1Cq4Sw+CMtI+7TrBDIkF8PLM0IGVsj23sL82/M
	/Jk33iqU+hWWcZRIBqvlxVs6KBuDVJCL+icFDkb5AarkBHd7U/fFCYH+nLl1f8QMbLJxJPd32IBsn
	fZaJohBA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbfHC-00000007FPe-2F3j;
	Wed, 07 Aug 2024 11:56:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 88B2630033D; Wed,  7 Aug 2024 13:56:21 +0200 (CEST)
Message-Id: <20240807112924.448091402@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 07 Aug 2024 13:29:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf: Per PMU context reschedule and misc
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Hi,

This is 'fallout' from Namhyung posting his per-pmu ctx_resched() patches. It
started with me trying to clean up and get rid of corner cases, and then got
involved when Kan noted the time keeping issue.

Anyway, please review / test.

