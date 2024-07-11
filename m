Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC838F83;
	Thu, 11 Jul 2024 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720734603; cv=none; b=Dl0seTeTTkFfoaYHaFCcKbCTs1XwOR00jkCtRBrirKnIc2fPU6cuCiNvAFZ8+Fy7aZzjikkrE/2xRMotL8uI3I5A1SrjNx2JwAneS9k3Mejnw6KivXnQ1FNnXTj29wS9pwB/FqqZjGpLMJIIjEreIrK5wlje0Z8jBMNH7zWNc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720734603; c=relaxed/simple;
	bh=56VbWDhIlJqg4fKP/UNCfHVDmc0Ha2CjITd7SZCEANs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBCSATyFo247v2JCha60DJbjLdqGewZUpKQcBlY9rFYa90qFB/uHIHlzVwGl76OTa8Vi3iPYe176Hj6JBIFfaydv4dCjG659gG7/hAXFlt38ufZNwQT9trycJPaSmK2qagQFrjir2yGPMj9kcf8RLy06t66XyAAn45M3pjnuVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JsKjBGiC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JsKjBGiC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1dIGLbp4CPIss7m39veGPiDOOd4wVtXHQdT3ujDbmLE=; b=JsKjBGiCipNaDdpNP5kCisEiHJ
	6+NrmKms//7LgSYvDrQeSEGzvKgznYy1mnofQSFAAKbWDBY6mEQ3xnCb5HOc6bpYnKIHyRRpjw8zn
	AianwAGPIlfG1WZGOwbXctW1nf7tOOFp3+dHkBEW0hrZpx6kY2k5P+FJF8j++NvtMEgx3uuORk+vH
	soSuef6WwlYiAyn8e5rG2eHzc1NkuGm7nFR0mH71e7NySFMiIDF2grFt4buNOdjCbJCVtvtQUx+qs
	ZjOT0Pgq55g+dPQBTgt+590xyMvoqt1KArwN1zdk+YFQhZpaAaG4EhLkEffPcGyGYkIvTiLjpTtK1
	pH+f09pw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS1fU-00000001APq-31GE;
	Thu, 11 Jul 2024 21:49:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 31C8D30050D; Thu, 11 Jul 2024 23:49:36 +0200 (CEST)
Date: Thu, 11 Jul 2024 23:49:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, rostedt@goodmis.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, yangjihong1@huawei.com,
	zegao2021@gmail.com, leo.yan@linux.dev, asmadeus@codewreck.org,
	siyanteng@loongson.cn, sunhaiyong@loongson.cn,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com
Subject: Re: [PATCH RFC 1/3] perf/core: add logic to collect off-cpu sample
Message-ID: <20240711214936.GH27299@noisy.programming.kicks-ass.net>
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
 <1720700179-22839-2-git-send-email-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720700179-22839-2-git-send-email-ajay.kaher@broadcom.com>

On Thu, Jul 11, 2024 at 05:46:17PM +0530, Ajay Kaher wrote:
> following logics has been added to collect the off-cpu sample:
> 
> - 'task_pt_regs(current)' has been used to capture registers
>   status off-cpu sample.
> 
> - off-cpu time represent the time period for which the target
>   process not occupying the cpu cycles. And calculate as:
> 
>   off-cpu time = swap-in time - swap-out time
> 

I have absolutely no idea what you're trying to do :/ The above does not
constitute a comprehensible Changelog.
