Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712D202F61;
	Thu, 13 Feb 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467291; cv=none; b=gHq5KgQWRUW1JjPsNHJRqunaSXjbBZAg/brvDleHwqpUBBh6FZyB51bmZsfQFErQMZpk6q4y573FmqTtyNDK+lDFiMiQ/prqpJIKiiX4Emm4tdvFQwRESh1H8nyhwwqPxQTI44Z5QcFYSZa+4od/wUzCfwnax7JDCQzRIAbEqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467291; c=relaxed/simple;
	bh=ES5qNl+u//oMiTYl1ys/lrHvvWxQk9jWhXbo/uivOx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rrAZ5h6kMt2Tde39zKt2uOGvmPzMeuaQhEKh2AMy+/At2VW26FTgCG3+CYYehWErIHFLzCutV0duK0ysEKJ6zRStnbsd2AjmoyDLbLNahGsJ+7H49ukxdcv0VYUB2g+2SfSgI4/kxA/5pBoVFin8KxMqZbSPM7V3l1HIfxt+N7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXsZOCgF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXsZOCgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FEDC4CEE4;
	Thu, 13 Feb 2025 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739467290;
	bh=ES5qNl+u//oMiTYl1ys/lrHvvWxQk9jWhXbo/uivOx8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aXsZOCgFgYyUKrmJWUoURvG+3LoiZDf4wWrjsXYRNZdQUEDkYmNSJWkvaYDT76Qqo
	 9j3v8zVdOanGxd/tBVzz+Nk68EolAi77JhgFAuirzE77FZBRY2txvzA9MDoULkEQyz
	 t9nkk64qYxHljBQE9w/rkcvoRTFtuSJBqESA8XAL3+SPRDfrXQrUa7xs7IH/SC8xyU
	 0ua8P+EZwd2aecVEUFzniLuNpwgbtKy27fwmTbSskupt4uxNUFcYi+i+i7ElPLZ0/2
	 +a9ERDgTN0a3bHtj5hJpeAfeGdFJG1il2aMAoGywff4D9MgxlCmnqIZFCPAgXuA0l0
	 2NQU+NZ5hBeww==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Howard Chu <howardchu95@gmail.com>
In-Reply-To: <20250205205443.1986408-1-namhyung@kernel.org>
References: <20250205205443.1986408-1-namhyung@kernel.org>
Subject: Re: [PATCH v3 0/4] perf trace: Add --summary-mode option
Message-Id: <173946729036.1291083.1526445441591460312.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 09:21:30 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 05 Feb 2025 12:54:39 -0800, Namhyung Kim wrote:
> I've realized that perf trace shows system call summary at the end for
> each thread.  But sometimes users want to see the global whole system
> summary or statistics instead.
> 
> So I've added --summary-mode option like below:
> 
>     $ sudo ./perf trace -as --summary-mode=total sleep 1
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


