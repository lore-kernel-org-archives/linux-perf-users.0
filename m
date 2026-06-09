Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F33624C3;
	Tue,  9 Jun 2026 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025749; cv=none; b=eoBt1Z5IwXCzQ9rweGA2uvcMbCGyR5RzaYVErU6wqOV6sRwbIqo04gf+JEgrBAxu6lyYr3iForQEqLrxwZW+2Q1buBJDdy+oqRXCCnLDMXBZcR7Z4ApWf0vPhM0eajOv082aEUf9RKEWaVMhvyvhYRHyO441QzPwxm1cd33dRLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025749; c=relaxed/simple;
	bh=Hb9sh0XqrPvMs+wMFgaBttMD3J72cATuxpC19PaBECg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opv5FbK7TdveGeSVF2ZIRHpnOMhDcUmg/O50LwXOgofbby6riGd9uv9qk45uYei2m4xmg5FRHBprCyfIl55wRyCPVVPnGRahBzI6CRG2nuQ9FYBBlF2qyA3T/Na1UrH0HgPZJ07Cq9DIkop9lVY5W0uZBZr+pTIZLv1WMMzUGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VP3XP5fK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VP3XP5fK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 266763D7A;
	Tue,  9 Jun 2026 10:22:22 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DC143FD88;
	Tue,  9 Jun 2026 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781025746; bh=Hb9sh0XqrPvMs+wMFgaBttMD3J72cATuxpC19PaBECg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VP3XP5fKK3fja/qhvB1t3AAfjIidu+vWl6InvoHzF9PxDdOxrE2KtrHumDlDCf1jE
	 aXwgGFxafMttsFq8WEG9bEUeqBXGpMPQTy2k1CpNbdEgsrvRWFOyQQFrqAYzonsWVx
	 ttswgpfXHmpl9QubXEniFxCjySz3Uuv7EQynSYJU=
Date: Tue, 9 Jun 2026 18:22:24 +0100
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
Subject: Re: [PATCH v5 15/19] perf test cs-etm: Remove unused Coresight
 workloads
Message-ID: <20260609172224.GS101133@e132581.arm.com>
References: <20260609-james-cs-context-tracking-fix-v5-0-d53a7d096a19@linaro.org>
 <20260609-james-cs-context-tracking-fix-v5-15-d53a7d096a19@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-james-cs-context-tracking-fix-v5-15-d53a7d096a19@linaro.org>

On Tue, Jun 09, 2026 at 03:40:20PM +0100, James Clark wrote:
> These are now unused and had various issues like not working with out of
> source builds and being slow to compile. Delete them.

> +There are a set of Perf tests for CoreSight which can be run with::
> +
> +  sudo perf test coresight

Tested-by: Leo Yan <leo.yan@arm.com>
