Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BBF4CA764;
	Fri,  4 Sep 2026 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541939; cv=none; b=qSUvKoXFLy7vuKCY5HSeGebrE1Aabyy5NNfRzOqIil06wKQdDylPeUW5TlFMCxVemWq3zLC5MQqqLh7znMu1YGkdK68H2ab0eio84BJ5y0T7Nz9wYc1NtcPKK+509/3vBv69RBtVipvP9ffsVk0fFVWIq7cPKhD55vguWl1MRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541939; c=relaxed/simple;
	bh=2GiCH+5kI3vcsZvzncgnRg2QnDpJ16kkZKLnsW7SyNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFpDI2uqBkRlspi1JsX7LYCtzC8BpqUPiQx4EmEOj7D3DreoQW9vGaNvAblhEhUxJy4uYfsMmhNVzSPdpsuwZuAAKtD54mOaYDsGTGN7FlUZHLBbm9aQyqqbH/P5P23ugVD9OiC37bfn2rxk5EO/tpbQ8mH6+vJ37q2foQ1VbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dqi3Qirw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dqi3Qirw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D63152B;
	Fri,  4 Sep 2026 10:12:12 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B6B83F7D8;
	Fri,  4 Sep 2026 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788541936; bh=2GiCH+5kI3vcsZvzncgnRg2QnDpJ16kkZKLnsW7SyNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqi3QirwqIFSzSWM29azV4XpRbautUGyrdE7FafaXx4nRtSo2zpVX9POUvWygQO49
	 XRPYXrZeDYK30N5N9OcAafaM3yFTiABJ9NMYHBPVa6RpwjLNUp8qFkjFzuevGcYVZn
	 zshZVX9SK40rnLnbDKDSpS+4+p57MuDohxyhjsU8=
Date: Fri, 4 Sep 2026 18:12:14 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] perf cs-etm: Free partially created queues
Message-ID: <20260904171214.GA8904@e132581.arm.com>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-2-9d532ddabcc3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-2-9d532ddabcc3@linaro.org>

On Fri, Aug 21, 2026 at 10:50:30AM +0100, James Clark wrote:
> cs_etm__create_decoders() can fail half way through and the
> err_free_queues label won't free them. Call the full queue free function
> here instead. If no decoders were created it's a nop.

[...]

> @@ -3520,6 +3527,7 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
>  
>  out_free_decoder:
>  	cs_etm_decoder__free(etmq->decoder);
> +	etmq->decoder = NULL;

cs_etm__free_queue() also calls cs_etm_decoder__free() but does not
clear etmq->decoder. Should we do the same there, or drop this
unrelated change?

Otherwise, for the queues free fix:

Reviewed-by: Leo Yan <leo.yan@arm.com>
