Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70243603C9;
	Wed,  3 Jun 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483206; cv=none; b=aO/10gZ32oASHcql0c2EkhfXnpuBYLyFFuvpmGFoGErBW96u7OIaHrjXtmzMCfStGqCk1zf44fg7B9+k6x+O26hgAYFkGjqEpwPHHs/g3bgGHxQBatDl6OWOPtEOv62VBsRiYQpXc36Nf16Nt3hJrqhP+ty8XGrOv1Kjy3gtTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483206; c=relaxed/simple;
	bh=SihwoOqvLN2dVrxDnZW1V1LhzIclRCGS0N10tzHH5zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKeNY0NjXIJv7EzsMVlK7mNqbYMjOqatjL/qlMgXWV4U6gT6xT4ukgiCo0f9ZSAC24Ep9fWtFe1UBSxIbzwIs/xjI1afKosh/3nKE94y7dxCiOTnZOxmAm+18yvbSleng2TKk2t6FjOjZOONRlIF1XTGPttLBrvpIO7ciJcKqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Jc/ZgyWf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Jc/ZgyWf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A97749DB;
	Wed,  3 Jun 2026 03:39:59 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A63DF3F632;
	Wed,  3 Jun 2026 03:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780483204; bh=SihwoOqvLN2dVrxDnZW1V1LhzIclRCGS0N10tzHH5zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jc/ZgyWfolNqDI2XS9Gn1c2rmXZo5tXB+CFB82fdYviaZ2httz4yRLRHq3NwUGJGG
	 zAxaldhaf0IPYhz3/8cqGLynBYVMCuxLV6n0AvQw0Ag4SyExrfBx3PO7doXlz4tl6d
	 ABdVyvChPTlgyXgwNWeLjsencnjgTPNipq3MA1Ig=
Date: Wed, 3 Jun 2026 11:40:01 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 02/18] perf test: Add workload-ctl option
Message-ID: <20260603104001.GP101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-2-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-2-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:44PM +0100, James Clark wrote:

[...]

> --- a/tools/perf/Documentation/perf-test.txt
> +++ b/tools/perf/Documentation/perf-test.txt
> @@ -69,3 +69,9 @@ OPTIONS
>  
>  --list-workloads::
>  	List the available workloads to use with -w/--workload.
> +
> +--workload-ctl=fifo:ctl-fifo[,ack-fifo]::
> +	Write 'enable' to ctl-fifo before running the workload and 'disable'
> +	before returning. If ack-fifo is provided, the workload runner waits for
> +	an 'ack' response after each command. This scopes the recording to only
> +	the workload if used with 'perf record -D 1 --control ...'.

This new option doesn't work on its own. I would spell out in explicit
words that it needs to communicate with perf record session:

  "This option is used to communicate with a perf record session in
  order to control the recording scope. When specifying this option,
  the same FIFO path must be specified in the record session via:

    perf record -D 1 --control=fifo:ctl-fifo[,ack-fifo] ...

  The perf test sends 'enable' and 'disable' commands through ctl-fifo to
  control event recording. If 'ack-fifo' is provided, the workload runner
  waits for an 'ack' response after each command."

BTW, I'd say the naming "--record-ctl" might be more close to the
purpose.

Thanks,
Leo
