Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428284;
	b=G76otUDHD/iuROz+bMGxzqkGLZHkNGHTNtAp9KGD6XOzPAX510Rbj+XGV+3QCbAaWwMl
	 wRXDos4eMwUh5vNa97/NZ6hsxZ3Wx5GbhHFNtqMR8xZBvf+wnxeqQgE2bgHjCmeRae9j3
	 MteN+UibrY55Br8sRH+SrniJ8CbngnTm/rUoVhiTDXHLwWnEnGnHRY5L4lhEqpSiQeQ5m
	 mcOKQ8yxqCLAluqqrEKsVXeV0S/O4VcJeXk2/Ri6x1qrgsBGAy+nQiWc+tjcMW6SEQlpo
	 7jS+DyiD47BQ8k7kQwr25bf+bC5TbVUU8eby8EXYDUHHO42t/sAlMxg0j9DBnAFIjzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428284;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=G15HxNV2BInhmGFfz6B2/9xNKvQkUmZEvhfrnB2brVA=;
	b=RS1YDxKLVFiyf3QZD4bswxiqeuRLNp3PwHwRrVL0i3P8N2qWABSo6+Mgz57GS0QDxnMQ
	 SyPCIZhuaS8vXWVEsf8QFuKW0xKp69Dio9RPZwcDAeKmyCdRkk/iUoo9qzz7jXrKXH3L4
	 C0wDe6A+h71YG4OLSeeGqCz6x6R9GMVnRPMQNI94Z4HMt8Ct9QhBIYai6nRIbrDK2WXx6
	 dKIsPnc6I3ZKBJCO3ZGLljZdk9fm2nT8WCKQNKaXL5dPVrnipq91SP5jNCUjug+CxQ5LE
	 CNXXrkiL8QRiF9k1ITXdrVCvPfiX9i2A0r6HU9zB+NCVP3+x7R+vEqwz3D6Yg1sCcwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bYIrvjOC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8776606A31E;
	Mon, 23 Nov 2026 10:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8776606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bYIrvjOC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37A37143D;
	Mon, 23 Nov 2026 02:04:39 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A18E83F632;
	Mon, 23 Nov 2026 02:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795428282; bh=yQm4JEXfwJhgCAIOW0UPlZ/ox3rIB1ofbEWhNOZozx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bYIrvjOChM7XaDO+KaAGSjv8uxpYcYqRZ7E5cSY0ajl/nxwHdByNbBv46A7knLIHR
	 FavXqxFQu8/hQNfLQBS22d3xo2r8FOEfLnGmDuUj3HIsIgtfbB+JAE0QJCXTZSfah2
	 VqqNxSPoFWHIBwli+qfJmRQgcrhwU7pdaK/7jJE8=
Date: Mon, 23 Nov 2026 10:04:39 +0000
From: Leo Yan <leo.yan@arm.com>
To: Vlad Poenaru <vlad.wing@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 04/25] coresight: perf: End AUX output when an event is
 throttled
Message-ID: <20261123100439.GB9176@e132581.arm.com>
References: <b851c070-19d2-42b8-b19d-be4b02ad9715@linaro.org>
 <20261120172739.1843303-1-vlad.wing@gmail.com>
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
In-Reply-To: <20261120172739.1843303-1-vlad.wing@gmail.com>

Hi Vlad,

On Fri, Nov 20, 2026 at 09:27:39AM -0800, Vlad Poenaru wrote:
> On 16/10/2026 14:46, James Clark wrote:
> > Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Hi Suzuki, Mike, James, Leo,
> 
> Could this go in alone as a v7.4 fix, with Cc: stable@vger.kernel.org?
> It does not depend on the rest of the series and applies cleanly to
> v7.4-rc3.

I agree that this patch can be an independent fix. Since it has a stable
tag, it will be automatically backported to stable kernels once it is
merged into mainline.

@Suzuki, how about you think? I confirmed it can be applied clearly on
coresight-next branch.

Thanks,
Leo
