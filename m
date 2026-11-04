Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810343;
	b=UxXrQRgCTBsIvB33OZPJ13/wE5ewAbSrQ6nMSvcwZCBYWUd1vX+nnma9zpbEJ9m+RzbL
	 nxCsZqz7rbjIEwQZpIvTbAaz5HdN65gXDpS+QokmeAlEaIQBhIdf3SoiThDc6csfT7Wch
	 S81O0F2vzwSkktTwbhvjOuzSJ4nZCyWN1oPBbVNh337yP0kX2yaoCD1nyacHpp6bJoNDV
	 cB1BNw4iXFBKUQU3yQmwhJ4VOmE0pIcIKIj9NM80hMUCOzng2CiP83+sUmHmwzYWUthR8
	 Sr+P0tnYzly60VMz8Nqov9osbeGOLY44ixf8XX/t8qVHTT5hJPYPDQ8T6FWhnfe3c+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810343;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+vNGczHMw6FkUVcnbhV7x1VPiBIGfUMOUBD2hJJTm1k=;
	b=ZVg7G+xMgwKVZ2tlfSmmsJqDBnT/sIS10aqx5Ni7B1aUqeOdKzViLhiK1keYiX7FYfeQ
	 hogwJolZtAXuUiGt8RvN3t0g6hQlR3LXMOFE3nXusBaEjdXLPCVK8oQhBLgm4vENfmcyy
	 aQ9kN9yfY9IL2UNWL+1IM8K3Nk4G7Iwcvlo76xty81hJ0AHuR7XXw3tn9vK9+5o/ioGGw
	 ONj/XP+acEGH3Sx6i2GdS3XFfxz4jNYSBW+cQiMs75ofmgx6lbgsTCpGrwqf62nhnwoD0
	 dSwlxuX6rs4560Z5m1Yv8Uyj3X0VtePlKn0/qJ7PcZCrdSQ1MgoFcM70QGhjJ3+T0oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=s3GrBJOl;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7855F606A328;
	Wed,  4 Nov 2026 16:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7855F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=s3GrBJOl
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B20B0169C;
	Wed,  4 Nov 2026 08:38:58 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 729103F632;
	Wed,  4 Nov 2026 08:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793810341; bh=H3gLXSBeer+KOTYX0U8MNDqI+dszeoRWQK+rfNP4N3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3GrBJOlaKBDpmlHDKGW96IzubpnPtY8t5ctXlsyAV4MK+ONTKqPQTkHivad2c5tx
	 O4lZXz2Bz4NoJowwdj09EEllgdkMcLLdoAKvPlptuWB+3j/9Ls5mi98fTNuF6cVYQx
	 8cFJFaCFWdliJyzZR0XDmvCJOo2xkUs3lw/TECxM=
Date: Wed, 4 Nov 2026 16:38:59 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3 06/18] perf cs-etm: Don't drop previous target for
 kernel samples
Message-ID: <20261104163859.GK9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-6-dbcb0c281b9b@linaro.org>
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
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-6-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:20PM +0000, James Clark wrote:
> The branch target of the previous sample is used as the start of the
> range to disassemble, but if that sample's DSO is "[unknown]" then we'll
> drop it even though it's useful information. This happens when recording
> userspace only. Save the address earlier for "Trace On" samples, before
> we get to the early exit condition for unknown DSOs.
> 
> In a later commit to change the default timestamp interval, trace will
> be collected that triggers this issue, so fix it now.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
