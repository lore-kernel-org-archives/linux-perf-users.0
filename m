Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98BB318EE6;
	Tue,  7 Apr 2026 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576661; cv=none; b=BANIH7WTkjH6edvX4szspdEotR+V+GuDZOTY0pZhztR0Bn1j6l93THgitk9Y/4rSYeqpBwNKU22O4EcAxX79/9PdQofh2FOPFLhoslZm0sAoUezLpBVKWIENTQbT1RgAK5K1CkjBLalWH1kKvKf8KRA0mtmN1M54O3UdIDdj9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576661; c=relaxed/simple;
	bh=EjYqOhtLEqmY+b7rAs62lsA48b8Hs7qduxXC5kiQPUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V16Z2iwfemxynMnvVRAOP/sw5SmPojFIO+UEd142yRBh7X3fjkogVkx2vFHKvDl+KO03trf8seDDLcUFtI5SND+fOBa2WXvPuh3vbUvHdckvg4ws5DpRGykzrQL4njvAOqsDFyZbJo+zsT34YwWhIoSp2IXg75xHQxQkkC/CKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Slq0f9JG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Slq0f9JG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D3216F2;
	Tue,  7 Apr 2026 08:44:06 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC2633F7D8;
	Tue,  7 Apr 2026 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775576652; bh=EjYqOhtLEqmY+b7rAs62lsA48b8Hs7qduxXC5kiQPUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Slq0f9JGTcRm7UT+H0qe2Bqpub1A70mpb8xXMOtHtS+cFF39GaEXOPXJk3g0cmDVq
	 1mgapIMhlGD0XMDZP2M1i1t1vjJctYa5BQU159ca0wBEo3YQJ+SjdUy3m/QnG5k/+s
	 E70bStER7y6hx48R7k3JYbRMu/tStUCR6hnBB3GU=
Date: Tue, 7 Apr 2026 16:44:09 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] perf arm_spe: Decode Arm N1 IMPDEF events
Message-ID: <20260407154409.GP356832@e132581.arm.com>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
 <20260407-james-spe-impdef-decode-v2-5-55d3ef997c48@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-james-spe-impdef-decode-v2-5-55d3ef997c48@linaro.org>

On Tue, Apr 07, 2026 at 03:05:19PM +0100, James Clark wrote:
> From the TRM [1], N1 has one IMPDEF event which isn't covered by the
> common list. Add a framework so that more cores can be added in the
> future and that the N1 IMPDEF event can be decoded. Also increase the
> size of the buffer because we're adding more strings and if it gets
> truncated it falls back to a hex dump only.
> 
> [1]: https://developer.arm.com/documentation/100616/0401/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
> Suggested-by: Al Grant <al.grant@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
