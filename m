Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA11F3FD9;
	Tue, 25 Mar 2025 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932173; cv=none; b=NdlX4RmSRk2EyjwQqRAf35LZ1PN8hiVrXisHvQgNYYbwjk348scy4JsxXXKnjgP847PUMJSgHerwv1NE5oxKmEGsAt5QqG6SsyKert+iVKr1zmFQDt8C7dL4ir/f9U8g3D7etORLT1iduYdnzrdLyXGQZqqd51cNDbfmNiWekf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932173; c=relaxed/simple;
	bh=PBdlfqXugO2BiYFTNYFV+vhtp4+EVWOejcXfNbvjCx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Uz+joF04UJeqULK3g9z2sYPfUMTUcQipaU6ZfMzt8iFpf1nw7kNSEris1MGi3ot2GpHX2YS6iMO6uAWWLz2t8olTWr31da2o1BRMs5OmIKVaLEfuN4wtRzSEA/fDjpJ+gRGiVsijbC1S++pNCyp+M0Xzo68/CaFwEzkTudr0iB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEMT7v/u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEMT7v/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E26C4CEEF;
	Tue, 25 Mar 2025 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742932172;
	bh=PBdlfqXugO2BiYFTNYFV+vhtp4+EVWOejcXfNbvjCx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tEMT7v/ubC9X7+xm89kaiOUC2rk9SvDYlDw8IEd7l+83f2r+pEdnjinYE3wxaOfI4
	 PNrSGnONQchrnc4VAz35TSJ3wdtbwFzhR1uiDDlGy+ZfH5HJpA8isIKgs4otYvEaYM
	 8AVka+xbBaPHwe2XkbabWeu044wfsCP+oiJooEb8CJYOxLchKzkJHVbHmCMGg02jAv
	 XFI+a4G8C6RByyzYyJglK3p5DRO4wZRDAnOV1pdgrK6CtLaFJhJQiKyCT5psBWDhb2
	 vQZLJD60DjuNyjjmTLvfeQaSaF44EWlQuJqYC5M7lhaonAHQ2O/ojE0O7YFsAk0GGF
	 Lf/zGr/gPtvUg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Sally Shi <sshii@google.com>
In-Reply-To: <20250307220922.434319-1-namhyung@kernel.org>
References: <20250307220922.434319-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf bpf-filter: Fix a parsing error with comma
Message-Id: <174293217243.2401011.8039718227768171802.b4-ty@kernel.org>
Date: Tue, 25 Mar 2025 12:49:32 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 07 Mar 2025 14:09:21 -0800, Namhyung Kim wrote:
> The previous change to support cgroup filters introduced a bug that
> pathname can include commas.  It confused the lexer to treat an item and
> the trailing comma as a single token.  And it resulted in a parse error:
> 
>   $ sudo perf record -e cycles:P --filter 'period > 0, ip > 64' -- true
>   perf_bpf_filter: Error: Unexpected item: 0,
>   perf_bpf_filter: syntax error, unexpected BFT_ERROR, expecting BFT_NUM
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


