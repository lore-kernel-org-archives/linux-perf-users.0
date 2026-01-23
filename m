Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43810310777;
	Fri, 23 Jan 2026 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170131; cv=none; b=QVT/afYY3LfabplfvmdBq84fmBn50j34hhIlKqEm9h5KV2m5FHXj/+aTxHc+8+qmd8VPQb7X1HSk9789aYrMxrR3IEciO7yAIt1MXF3onnACTbzWsPe5T81saOnreJRIl5EWviTwLVTl28PhtUT2EBJ3a7whKRuK18khTQ7Uwao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170131; c=relaxed/simple;
	bh=+zoj49cb6cpVPoFlDnccqtcgoK5uFXx6t6R7760Z+KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7n3z8DuIeTwuMLXeN+Niry+A+c7XSzS/GU8ijMTG5inT8mGvgxAiKk4wpZWNkf4dciGCk74nJRLORyFK1SqHi49INGGzV2pfnZnA6BGKutLdKmrtAjBOa5US2+ZKPnjOMWmrGNnSsHI0wIT0tjQKODRXQY1535MlvphnOVhxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4636A1476;
	Fri, 23 Jan 2026 04:08:43 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EA533F740;
	Fri, 23 Jan 2026 04:08:49 -0800 (PST)
Date: Fri, 23 Jan 2026 12:08:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Thomas Voegtle <tv@lio96.de>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf arm_spe: Fix bitfield dependency failure
Message-ID: <20260123120847.GB40455@e132581.arm.com>
References: <20260123100218.233246-1-leo.yan@arm.com>
 <705c0889-ffb6-4758-941c-ccfdb367d9c8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705c0889-ffb6-4758-941c-ccfdb367d9c8@linaro.org>

On Fri, Jan 23, 2026 at 10:27:42AM +0000, James Clark wrote:

[...]

> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > index adf4cde320aa..8d16619cd098 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > @@ -7,6 +7,7 @@
> >   #ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
> >   #define INCLUDE__ARM_SPE_PKT_DECODER_H__
> > +#include <linux/kernel.h>
> >   #include <linux/bitfield.h>
> 
> This isn't the first time I've seen this issue. Isn't the real fix to
> include kernel.h in bitfield.h if it depends on it?

Good point!

bitfield.h is a common header so I did not change it.  I digged a bit
and found diverage between kernel's bitfield.h and tool's bitfield.h.

1) The kernel's bitfield.h includes asm/byteorder.h, and finally it
   includes linux/byteorder/generic.h, cpu_to_le{16|32|64} are defined
   in this file.

2) The tool's bitfield.h will includes asm/byteorder.h, but this hooks
   to the headers provided by the toolchain.  cpu_to_le{16|32|64} are
   not C lib API, they are defined in tool's kernel.h.

   As a result, we need to include kernel.h for perf build.

As you said, we can include kernel.h in bitfield.h, I will respin and
send a new series.

> Usually you shouldn't
> have to know what all the dependencies of a header are when you include it.
> Or is there a reason it wasn't done that way in the first place? Maybe this
> has been discussed before?

This issue is for tools only, and only Arm modules in perf folder use
this header, I don't expect this is widely spread issue.

Thanks,
Leo
