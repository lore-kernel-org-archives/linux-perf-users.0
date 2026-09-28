Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7024F3EB6;
	Mon, 28 Sep 2026 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614485; cv=none; b=i0Tj+0FMvONsl92DGm/EGghyQZHiQ4owkRTiolBXsAKqruMhGklc52BZrNPJYCpE4IgPAKStKwk01wWzmehynxWQBGgbPhBVVCRoFsnu+2okIf/PkZbXSLFO8DLps0208GM2N3m/TQlwvUQmWUxp65f4V6gRzlufuirfAjZgRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614485; c=relaxed/simple;
	bh=V9bBm2tAwacf3h0hbhP25zW7uoULq5lWMOp+TYSjJ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OefzUoh9JHtqJa8dye+um9HL9qkdM44Yo0qNkaFIBbnysvctjRD5sZ1xStxmKhcFLZ///RumIsiKn2kgnpLn5mtX25y5cXgiq0jd7ALVwimGqtaFxfj/WAWt+4sCg/Am1CYkxT7bSuVAZeND87PPg9VNjX/kwGS2YQpq628dVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6KyJmiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6KyJmiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE271F000FF;
	Mon, 28 Sep 2026 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614484;
	bh=iOAeZ/HqzrJ63kIKcvu5IinfIbcgXDanZXD3CIh/fAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E6KyJmivojYAtUx3oyN2VDvSfZV58KD7EwCBSsF+/5vkv8sUlDQkzDp0jsO+jd8+4
	 YUgKjLGKMC2Ot0bkoyCzqm+VQEsod08pp0YkGquP+MpwZB4aMXK3nOtuNabwesNs/l
	 pcGeJiYM6G/4AsqtydV+pYx6mkgFQ7rVdh1zIYTeUL17yIgz/EwaKW1hW1IHLSSOOF
	 /S+y9nIdes49iRW9fu7j7/4ioMdXd+ECH7ETgGljyuEn/BymAQYK3z0l0GB78cuRyq
	 ufxTTT+5fpwnbPsHHBLDQ2wQB6TueFnTqcjrz4o22XG0MQgDYgpG230KtXD8SqNT3v
	 0ocn8PS0neNtQ==
Date: Mon, 28 Sep 2026 18:54:41 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf build: Clean libperf-gtk.so in 'make clean'
Message-ID: <arqb0dVg7hmdnI-r@x2>
References: <20260928163649.3463451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928163649.3463451-1-irogers@google.com>

On Mon, Sep 28, 2026 at 09:36:49AM -0700, Ian Rogers wrote:
> When GTK support was made opt-in (first via GTK2=1 and recently ported
> to GTK4=1), $(OUTPUT)libperf-gtk.so is only added to ALL_PROGRAMS when
> GTK4 is defined. As a result, running 'make clean' without GTK4=1 does
> not remove $(OUTPUT)libperf-gtk.so.
> 
> Add $(OUTPUT)libperf-gtk.so explicitly to the core-progs clean list so
> it is always removed by 'make clean'.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
