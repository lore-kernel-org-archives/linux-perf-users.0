Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CD833CE88
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924185; cv=none; b=cBuO6kn89oMLRUyWk89jpwbJZljtvgmM6eWp7CAXnAWhmMscsLWgsaJgA6e98AXPXXihfEPN/rZontQnaxixSCPFY408LhAIIvg0qLpbT3SQTszRPhM3dFyhpyKyQxK3XCzTbolo8eyLyUVQxnilOb8/8dI9N6Yb5Nbh5+QPipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924185; c=relaxed/simple;
	bh=OutRhBbS1FgllrvUBkpJuryfLvPR2Z56/LX+4uNbCdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqgQgG6rn7B1kSWzY9CijdraJ0rU4hIRXOGA8BnuxyeGcn+SYr9HnxM6rubPMs8d/UtzYCSzItLvNTdV18VVK/c3OBv8DX7cAEHo+5Kzb6+6QetSulwPZepFXZhofPPlzHah5xt2kH1l8Z1n1rfqjj0weXILmVd7XCOf101qulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a0KPzHIN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a0KPzHIN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D02B71E4D;
	Mon,  8 Jun 2026 06:09:37 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3450B3F86F;
	Mon,  8 Jun 2026 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780924182; bh=OutRhBbS1FgllrvUBkpJuryfLvPR2Z56/LX+4uNbCdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0KPzHINKIXAlM+/jwHIUlNNlw+i6YJIm++EoUWaVbab9HZ2oV1Sjf+kpreV53hJQ
	 ihuq7zWVJZh/Bhl3fkH4I4sHMrOKBySawl14BinH//uKiwep4ik2vPA9fb6kANHA0n
	 xIZbMIOHtdufso4FlApC7z0ongUF2xoMl9zcaG2o=
Date: Mon, 8 Jun 2026 14:09:39 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>
Subject: Re: [PATCH v6 6/8] perf cs-etm: Filter synthesized branch samples
Message-ID: <20260608130939.GO101133@e132581.arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
 <20260526-b4-arm_cs_callchain_support_v1-v6-6-f9f49f53c9dd@arm.com>
 <fbe0a097-ced7-44c6-ada1-01c3e9c1d7e7@linaro.org>
 <20260608112834.GM101133@e132581.arm.com>
 <b122283d-f3a7-4174-8c13-2ae9f6d1e79b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b122283d-f3a7-4174-8c13-2ae9f6d1e79b@linaro.org>

On Mon, Jun 08, 2026 at 01:35:24PM +0100, James Clark wrote:

[...]

> Ah I missed that. In that case maybe it makes sense to break it and treat it
> as a bug fix. 'c' is quite clearly documented as calls only, and the
> workaround you suggested above makes it impossible to get only calls so it
> makes separate options for call and return a bit useless.

Okay, I'll change this as the first patch and include a Fixes tag.

Thanks,
Leo
