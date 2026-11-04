Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810772;
	b=b8ah0VNX3Crqawl+KsbApyD0EM7tl0wVoDOZhlnqGcDTP3HwfAJpqpQPLPj5WVw40FI0
	 c2kz9uSve55WUDGilXwIHjajQf7WVYlZ9V+11Kbaw+50QDJwSk0Xulm+lHNCBdjHMI8Vv
	 nZs0cPbAbO85ACHQyT9ZjINAS16vBGd0zUTIzz6C7wRls3o0pHZTvfGrXDe02AbYeqLE/
	 SX1zNUSM3WYE0nfMM7wtYAF37zRhna3+WkjN9RlJLK29peKnitawqFIoON9ogiLdf8Ajq
	 uhUaKSdGNTbMplc8nepp4dfoSmp6PRkiTuIS5Yp5T2q4DGwJYjItOdf+W+BEuJwzjGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810772;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=S3LMfYdxSPYX6KeF1OEfox88UMF6+xUpUY6ooLhhmV0=;
	b=rQhVjuJz1cOwoolCEGd6hSksuxTab+gQZefW352vVm930tCe7OqJ6ZLdRe7Zou+OJJFf
	 jrTo3LkMEeCyucxvuxmcNinuJw40J1+z/v1H94FyaM2wpG9WxYQFWuNz3qE13btGEvV7V
	 9nbzSGbdkDhbpy2Mm01xRtIZ7QJsrq6PSEypK3yaYyYFpTvGxsZlSIlErUNbkcxVsvPZT
	 A8A/hwOHhg01sGmo9naG3WbTtrE3FTg3cKXJ5FxZvyRTb4Pd1CgBzkraJ1GPORyTGmq16
	 dO72n2gSDP8uC7kKxi3t9OWfSZoLbI94c20FyFw554GwbbGiIR0TcVXZclLsczRpaqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="jSJW/UL5";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2E2606A326;
	Wed,  4 Nov 2026 16:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD2E2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jSJW/UL5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6CC7169C;
	Wed,  4 Nov 2026 08:46:06 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A43F73F632;
	Wed,  4 Nov 2026 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793810770; bh=X1quyvwTNcCWCSQevunm3NZQbaIAqRt2lmIUgM0IgjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSJW/UL5Rv4ZsXd6CU1n8K3Xu/B86jAObtXeK1lLDWfCRYOK7czgeZAPNGOTSIrMa
	 7ZG7Isu59V9qG4CJYscXVsmSjB1lLjaoFCOf6gEy7Nmau9kTVTEJvLVe8uxn7MXprB
	 VM9DZ3Q+SbFiyHeXepHGxwLUPaJOhxyw8YSagqms=
Date: Wed, 4 Nov 2026 16:46:07 +0000
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
Subject: Re: [PATCH v3 07/18] perf python: Expose sample instruction length
Message-ID: <20261104164607.GL9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-7-dbcb0c281b9b@linaro.org>
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
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-7-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:21PM +0000, James Clark wrote:
> Expose perf_sample::insn_len as a read-only insn_len attribute.
> 
> Trace decoders supply instruction lengths on synthesized samples to
> indicate whether an instruction was executed or not during a call or
> exception. Let scripts read this value directly.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
