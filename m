Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1092222B2;
	Tue,  2 Dec 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685462; cv=none; b=S6JU1Y4+PNIRQjbS/BfeSR9WJp/ilzkOM1Ir6rst7yf9iXYDR904tOslKia/P7XwqDVOnVrslZlR6iAVG+kV4uA3vSGA6xbcSsa+5cpP80wARhSzkJfpEiPVlO9RQGO+DSGTzk5Np19xP1fXE6h/48H58ff9jtYyWaG7myhNgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685462; c=relaxed/simple;
	bh=mce4JBsxEdZhkNL8QanhegEJATWa2s9OY46mz+/orF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKlAKcDTI/PX7ZYVPnOQkxfXn1OEpsUqZjEL6LlIpXEDoqn+LkXb3YTVGgNVozfoJWuhzsW23EQJ9I9LU6Ss7kGn5uyPjSV1WGbIDkARwqRn0N4lSxpP5hPcVtVNLVL5W3flaj1oMFUeGFZIDKIhiGqFfPe4xu4py0LDiTsqXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B98321477;
	Tue,  2 Dec 2025 06:24:11 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B04D33F73B;
	Tue,  2 Dec 2025 06:24:18 -0800 (PST)
Date: Tue, 2 Dec 2025 14:24:16 +0000
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 06/19] coresight: trbe: Refactor syndrome decoding
Message-ID: <20251202142416.GC724103@e132581.arm.com>
References: <20251201-trbe_buffer_refactor_v1-1-v1-0-7da32b076b28@arm.com>
 <20251201-trbe_buffer_refactor_v1-1-v1-6-7da32b076b28@arm.com>
 <65c84357-0bda-454f-88c3-623b3ff9d29d@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65c84357-0bda-454f-88c3-623b3ff9d29d@arm.com>

On Tue, Dec 02, 2025 at 11:06:48AM +0000, Suzuki K Poulose wrote:
> Hi Leo
> 
> A couple of minor nits below. Otherwise looks like a nice cleanup
> 
> 
> On 01/12/2025 11:21, Leo Yan wrote:
> > It gives priority to TRBSR_EL1.EA (external abort); an external abort
> > will immediately bail out and return an error.
> > 
> > Next, the syndrome decoding is refactored based on two levels of
> > information: the EC (Event Class) bits and the BSC (Trace Buffer Status
> > Code) bits.
> > 
> > If TRBSR_EL1.EC==0b000000, the driver continues parsing TRBSR_EL1.BSC to
> > identify the specific trace buffer event.  Otherwise, any non-zero
> > TRBSR_EL1.EC is treated as an error.
> > 
> > For error cases, the driver prints an error string and dumps registers
> > for debugging.
> 
> minor nit: Please avoid describing the code, which cod does well.
> Briefly mention what you are doing, giving any additional contexts
> that may not be evident from the code.

Sure, I will note this later.

> e.g:
> 
> "Add support for decoding the syndrome for TRBE, providing a verbose
> description of the code for Fatal/unhandled events.
> While at it add the new definitions from the latest Arm ARM for
> EC and BSC"

Will do this and followed comment.  Thanks for suggestion!

Leo
