Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246724336D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 05:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872037; cv=none; b=Ss8b5wJFYZWRDC/g3cLPgpv4a5ES6uu9z53eXVU6E+mEWqfgUQNEQNVQ5kVvVQCGiomrXv3ajU2zIvwyY+1JL8zsORWP/PqEbomJMLJqX6bUvEumBDck4mn4/bF6SR6gwHrvqOvZ90WmTVZ8uI+VdgsCncWUb80LJ6jKTIdCVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872037; c=relaxed/simple;
	bh=MOIZr2bLwFuWf64HO25lkKcJA5i6HPxiyHhX+cujERY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bRXbJ5KK6G5uzrRjiEqk49eyiP9s7Tuijj3OO/aeoCd4CGhDnBjTXJZ8ICNS5Ep3i2oMoDPCPELP2PdF6VJCY4i85XrDdJEPc5Yd+zhDW97VDqOPs+cV1lgXcSvW/ongm9acfScpOb43psLdsU6duSp6zm15d58EybcM1Nw5W4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGeLqg6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGeLqg6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEB81F000E9;
	Fri, 24 Jul 2026 05:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784872036;
	bh=F+En/bNUfvq5UDKWEKTIJOS62zs7KhEQjTs+bfpIaMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LGeLqg6MBufxU8gjR/M2nLX1JSxS3eEQ1DKi6rnIr6bXLf1sGK5+FdFMZXh0y53xG
	 9wd0/kiwYdMAIc6hsLxbqmBZti0fMDm3Q2pVlncowuYG5lH25wrcSvhQsMuioiqCFi
	 e8bRrxqdnQPmmzSV2XPvXRr7l32LyYsWKSqgX7NnCeCiu3TwNMBlMKIUlCp+pRuG+b
	 vT7oqtJr5kN9kqdgA22Dq6lakHV/qEL/ToVw4v83vIhLwvV//QpeXN76FvTx186IwO
	 QVTZOPpxopuchY7OxgZ2lHqFTnnSt7ZapS1RdN5ZE5rR/7uSai5Js/9JvqNYg0e6VR
	 3uf/i5D+4d3LA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Suyash Mahar <smahar@meta.com>
In-Reply-To: <20260720-perf_cs_etm_fix_big_size-v1-1-97ded24636b1@arm.com>
References: <20260720-perf_cs_etm_fix_big_size-v1-1-97ded24636b1@arm.com>
Subject: Re: [PATCH] perf cs-etm: Avoid truncating AUX buffer sizes to int
Message-Id: <178487203590.824432.12306420213217895178.b4-ty@kernel.org>
Date: Thu, 23 Jul 2026 22:47:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 20 Jul 2026 11:01:21 +0100, Leo Yan wrote:
> cs_etm__get_trace() returns an int, but it used to return etmq->buf_len
> on success. That value comes from auxtrace_buffer::size, which is a
> size_t. For a large AUX trace block, returning the byte count through an
> int can overflow and make a valid buffer look like a negative error.
> 
> The callers do not need the actual byte count from cs_etm__get_trace().
> The buffer length is already stored in the etmq->buf_len. The callers
> only need to distinguish three states:
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


