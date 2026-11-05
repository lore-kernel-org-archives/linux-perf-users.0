Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878999;
	b=ZTd48aeUPAv7X+QA90zFWI20jNvH4c3F2u4F4fVs3nn5lRSyCkgQI+lj1c+tY+3Dqdao
	 mPSeJV9bnksNQMJrKui/p2L+jCsaBboRls1YhEaQDWsrcPi9XSqj5+2AQA7XgPOe7wmtT
	 bqjyRszYOsu3XzOlviKFkbHs+cEgFpoVCSUztBcxx0yLxOxWCcMJxsJS3DNGsfYJ/qsnd
	 KVu32wgLtiIX6ZiNAjl/xuikQoNdpkr++cmkF17ZMBWmC1qsq+avhwifvyJ3Hs4SAH9/w
	 2kajAnzqQ0A14gqPK4XWjtleT4FV7H1pH6KT+QQZ0QJH8qxTfoo2LWpnVJLfaKEGhYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878999;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3arWtRYMgXECqw7+BWms5meFgKjfCsn5/zO/hbfOvZ8=;
	b=nkoupdAQJu6mJA4ww1H8nDPjMkNYQQLscDrRxXaqTrY05Jug9oO4dIUlexb/ItE4InTH
	 xzXQLgOuCn8dYPxPFWzT4djiuuLEYC8om1PrQMSOPdgFTDmLdouQTHdjtKiSeky48buLW
	 f5dI/Tw25dU+nAseuw1pHdIF/h19WFAXEqL10W42kmqqbm06KlJ6uEr1fFx8X0jJlgqxJ
	 AmsBkh1kl0CkgFnEAAYs7clTME7hEih3rqU1LzPJX0B9ImUVz81ZZrCEfkVUXIrfdVUUQ
	 cffA/ugYOjk8/ZkiUM58GI6/RQwl26waxrNDQKw9B4UI2LPfGzY+hLfBeNIzDrtX6mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vAw5UIhC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4D60A5BFE;
	Thu,  5 Nov 2026 11:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F4D60A5BFE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vAw5UIhC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F65A1684;
	Thu,  5 Nov 2026 03:43:14 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A1A13F628;
	Thu,  5 Nov 2026 03:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793878997; bh=tNLSO+hdm+nSfzMoKkNnsSWYMdy8kNf8a0WRixCTXUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAw5UIhC3psCGMOX+MMnb+D9GR290XkKa9AuHmSzLQJdiC0S0HbR7Iw5xHPxficMw
	 +TW40584w8silG5YCpCe0YcnPdUIGx5aR6jKkTCPT2UtXjT2DrSxQxUUJgZJVJ0OK+
	 tSJJs5TLqJStkuTvwEC8gE4FdxkqVgPJAtDF0E/E=
Date: Thu, 5 Nov 2026 11:43:15 +0000
From: Leo Yan <leo.yan@arm.com>
To: Amir Ayupov <aaupov@fb.com>
Cc: James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Pereira <danielmaraboo@gmail.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] coresight: Pulse an ETM external output for a PMU
 event
Message-ID: <20261105114315.GT9176@e132581.arm.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792989860.git.aaupov@fb.com>

On Sun, Oct 25, 2026 at 10:48:20PM -0700, Amir Ayupov wrote:
> Add an ETMv4 configuration, pmu_pulse, that drives trace unit external
> output 1 on every traced cycle, so a PMU event counting it (TRCEXTOUT1)
> can end a fixed-length ETM window, for example with aux-action=pause.
> The feature only loads on an ETE whose PMU counts its external outputs.
> 
> Patch 1 is Leo's fix for TRCIDR0.NUMEVENT decoding, which patch 6 relies
> on for the number of external outputs.

Maybe it is worth to update patch 03 for Suzuki's comment:
https://lore.kernel.org/linux-arm-kernel/82adee03-a169-4106-99f2-7624a4926037@arm.com/

This series looks good to me and I have verified it:

Tested-by: Leo Yan <leo.yan@arm.com>
