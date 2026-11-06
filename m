Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000754;
	b=nWp0S82lwXD4YuhfyTLB3ojQEOKZCxsIXmUhhP1C1QhRcHpenNebrFGMFt0gfo+u4M4S
	 UNUIohpzIQKfAvgQjNn+zr8TKlIjsH/SmFiNxg1rJieWUQRtMgetjLnUNAGaV5Ay8A3Ol
	 eGcODb/5EOdum+3ytJH5IXaScyFSvMK2S7T1r9CnxS92oy/awN0PWYNYWEGLzn7iGVxb7
	 2r+ZFeb7s3RBwXUQUfd7d/dMKzsZN2ID7i7ZZEmbrPA5d0SHgDTkQPR2M1ufV80zHjVYB
	 kcHOunn0QXC5kSPL9akS6MeWoWHqFHxMxbsLBtEaWOun/yoLzFaBfNbLfqaOj2pP/cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000754;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=UBO1YKLCosQ4vsHbuZMHhER7fPDsXXqPC9c9DvGzmd4=;
	b=ZLIMu/IyGyQ5IasFK7G3ETN4pfSIc0foSnL5YqHgNW9WH/Ey4S8hct2/JEN4a84vL3s1
	 iDQ3x7gTP5ICn3q3aPo7bSREAznlcuF+6L3JTEwvtDm8sYV4CT8GVC1qENx5Bi8g3BVM6
	 9ghYZuPgpCAxd00A+0xrF/ULDK5AcHTUC/3Y3yjKABWEf0nQiw2p+TCgrXkE0y4ErK5Xi
	 lk8z6zybibVdq/+CIRfDs/2++O7WLwScksQk4X9fOIKNtas+lw4BUjKHgfRr1eobdIgXh
	 I8bEzLd4A/1/bfXuE1QABaMrbi1qbJHmy0Zy6cbLD8eM3sHULUiFE4b7SuMn1vZaj1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RG1w5szR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF30606A32E;
	Fri,  6 Nov 2026 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RG1w5szR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67AA1F008A3;
	Fri,  6 Nov 2026 21:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000754;
	bh=UBO1YKLCosQ4vsHbuZMHhER7fPDsXXqPC9c9DvGzmd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RG1w5szRWqmsQuAXORwSurVH2I28UPQyFnIPJ7hgXD/9+WkFjepM6QglHpuhawZHg
	 IoSzUYqc0I/UQWkRXWdABK/598JQRABoTTKRSQJ5RguyYHFcVw7IOyMgTRGFDOYW1e
	 jWbofU8eFVzOLlYrZLxzIw+bQ8gh9qS8JEHL/hN1gqAFQ1o8HQcP6/pOQktQxQkoI2
	 lLWdOE7VYk7w/JrxwhW6g8v6JnTY3JP+rp43U1RzedaHkf3KbVDVjQCzjDni8iPXA7
	 PnLnTh5yqG+4WttYOff0W87lD6ZHNQ24hUX2KC/YoUcYvluKQTltATtxm2KX5fHLFU
	 57X4ANEt5TpDA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Yanbo Zhao <yzhao62@ncsu.edu>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>, 
 Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261105181949.43198-1-yzhao62@ncsu.edu>
References: <20261105181949.43198-1-yzhao62@ncsu.edu>
Subject: Re: [PATCH v5 0/3] perf annotate: Data type profiling support for
 C++ classes and virtual calls
Message-Id: <179400075255.23155.12765347975568669027.b4-ty@b4>
Date: Fri, 06 Nov 2026 13:32:32 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 05 Nov 2026 13:19:46 -0500, Yanbo Zhao wrote:
> Data type profiling currently only understands C struct/union types.
> For C++ workloads, member accesses through base class subobjects
> cannot be resolved, and virtual function calls (indirect calls through
> the vtable) lose the return type of the callee: the register holding
> the returned value becomes unknown, which matters when it's used
> directly to access memory like 'p->next()->val' where no DWARF
> variable describes the temporary.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


