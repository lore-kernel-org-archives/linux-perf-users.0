Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56673783C1;
	Wed,  3 Jun 2026 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507929; cv=none; b=qyHcJ46OdzM5eMEvN/ZOwHqxjqwJ2mtK2lVJfp4kmcwxu+4cVlHVxsZygnAsMzx9XqCagPbP4JQBcz29az07fjoyPnvbWqPsMjNaKEiQlOGMFsbA3jyvtpVE0lqhkSLr2bZ2Rj+Nqnc3gNfLYLr6pT0Sq8YbSYGgb7IQTU62oW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507929; c=relaxed/simple;
	bh=alhXeGvllIcWh6dit+t68koWNvrumjJYV4UxFn5ClNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfVyBs4fDBEAaKd4tiFtekS5WNhX13sPWgO6do1Rgd5XxB1K5X8P8hij/8jr7g2fS78n1DbF6GpMMGg6dtXDivaeOr/hzkEBtg1mTABfUUcmVeUOJ9fJ9SH14Thz5QThLyjirMeQJ2XCmEetOc1UZQKQR/eDN/jdV4438KRD+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uHcxGoYX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uHcxGoYX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F615302A;
	Wed,  3 Jun 2026 10:32:01 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D22E3F632;
	Wed,  3 Jun 2026 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780507926; bh=alhXeGvllIcWh6dit+t68koWNvrumjJYV4UxFn5ClNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHcxGoYXZdmENzuEol+nf8MLEXpM93JCCnz5oeiDOECYbi9Cbj3MmcDRbZtIbLArs
	 ODKCbDQrm8OoO7treXF8nttN0hNapYJGeqnilGNDyAoNSvpassCWu6bqO0MdmXhZce
	 ysgTtN1vl6H44dwaJOSl5rfDY8SjTv+2mj+sb2Bg=
Date: Wed, 3 Jun 2026 18:32:03 +0100
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
Subject: Re: [PATCH v2 15/18] perf test cs-etm: Make disassembly test use
 kcore
Message-ID: <20260603173203.GF101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-15-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-15-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:57PM +0100, James Clark wrote:
> Hits in modules return empty disassembly with vmlinux as an input to
> objdump. Make the disassembly test more reliable by always using kcore.
> And update the comments to say that this is supported by the script.

Even without kcore, .ko files should have been saved into buildid
folder. Before switch to kcore, can we firstly fix the issue that why
.ko does not work?

Thanks,
Leo
