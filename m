Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7232ED40;
	Wed,  3 Jun 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508223; cv=none; b=GbAT3h0EOEPQ4fTia10rUEKQLqez/G8GuHNrokyIYHAq3yOuSRztRaUxmQRPto0PSDND6+tgjD8TiMoUUTlz2Z88sy1q0ojz8r3PFoalmcnhdTCC6IEI4dDDy6bScdFEduk+t2ZZzy9IZj9GuumIIGKLdl8BSsJy3A5PL5WvIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508223; c=relaxed/simple;
	bh=+4Xt+CtKvbxGQelgGSvzu5nzVW+Bub+O2k/bKYN2Wys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQPj5TbdpM/0AQ6Wrmok49TMRRq+dAgTp1dBCHQ7sF3JXIiWOmRwz4q0Qczh93pIDIciDzK5EZQktVozSgj/aSqSXvXk5R88fsnqEJoe5sHTjMYd4uQ2FUd4XFK7XCMFiTBTaSGwAm2QX/x+O93DzetuYi+J0hLUfktzrP0rkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iounbErK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iounbErK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 358E83293;
	Wed,  3 Jun 2026 10:36:55 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A154E3F632;
	Wed,  3 Jun 2026 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780508220; bh=+4Xt+CtKvbxGQelgGSvzu5nzVW+Bub+O2k/bKYN2Wys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iounbErKN43Gr733UqQB7k1iL6ifCua1TX75IAIKsL63BPD0jgoUhTxVeTJMcKsEs
	 vsKAvAZ6T3nsWRxDvRATywSP/J407r8QfzWGIF96B+hq8au2eW7A9nBVu4AnEJr3iy
	 vPuTg5VE6buUewV3J5Xjw0HqBeftRE7Emmbug0o0=
Date: Wed, 3 Jun 2026 18:36:57 +0100
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
Subject: Re: [PATCH v2 09/18] perf test: Add named_threads workload
Message-ID: <20260603173657.GG101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-9-85b5ce6f55c6@linaro.org>
 <20260603145415.GY101133@e132581.arm.com>
 <5e29907a-2533-4540-833f-977c5f0fb90b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e29907a-2533-4540-833f-977c5f0fb90b@linaro.org>

On Wed, Jun 03, 2026 at 05:12:59PM +0100, James Clark wrote:

[...]

> > Just curious this can be simplified to a thread function, like:
> > 
> >    noinline void *named_thread(void *arg)
> >    {
> >          char name[16];
> > 
> >          snprintf(name, sizeof(name), "thread%d", int(arg));
> > 
> >    	pthread_setname_np(pthread_self(), name);
> >          ...
> >    	return NULL;
> >    }
> 
> Only if you don't want to check for symbols as well. I thought if we were
> going to spawn a load of threads and look for thread names we might as well
> check that the symbols match at the same time.
> 
> If all of the threads run the same function you can't do that.

Okay, if so please ignore my comment.

Thanks,
Leo
