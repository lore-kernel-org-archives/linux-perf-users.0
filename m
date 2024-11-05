Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88711D9A78
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824900; cv=none; b=TLbGciL0U2bGB/EBz4wW/Cq/rM235+HiTcCaEei8s1/9x6KkgtfVZnSUGqocItfHk3SkI8yM3OtGX4d/z4URjaqQjGogciYE/gzp9MIpNwzQlbMpE3SnNwTgD9vr94M6CL20wNPC78Fzre9vfikJCMR0Dx/vsNzHqQLGrEVDobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824900; c=relaxed/simple;
	bh=zlm3wJUoZEwaVXwacSndXAgejscEE+PEvT8R/xiVrDU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=itD6Mwn+Nl5GdjBhkzf58hhSILmovvz+l7hTOS3Gw96i6UHi3EcP4eHXkV/HOUDYSbVtzgjTyJGefyjXvzlCYP3ZPy3Xzu96JO+ILTihKpNuAejKqnuwLDvmv82s949JnsbF5ImsR0uBKZKqB0shTk04zQdvPUlvurp341NelbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLCto/tI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLCto/tI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48009C4CED2;
	Tue,  5 Nov 2024 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824900;
	bh=zlm3wJUoZEwaVXwacSndXAgejscEE+PEvT8R/xiVrDU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dLCto/tInkZFmyUB0OTfSiZWEgOqxg57QbdcMvcvd5gViEJHsPSJkaozXMBEbFQ/T
	 P5Y3I62SMdyGijH7Z6ebf1gO7SMtC6wGhvgkCn5jqpvGZStJvPBnRXTwnCp7EmaDZK
	 WGWpS6hhjeqfqxq4hwyMJ91XBe48lVFz5XjE4kmIcBICvC1Ga1rmIT1o9mvoPgXtp/
	 mpuAw+46HB2NTCbpqR3kNAMvdMsMq3akCrTBwYHfxWbKKI+Irug+Ow/1q8YK2RVekD
	 vdreuhvp7hvtMqPR8TmLACCqYJthz6zipzgP29DgrtIzw2ZQwYEDGMp5uk8FziCSt4
	 avQCUDNd1fKpg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
 linux-perf-users@vger.kernel.org, Yicong Yang <yangyicong@huawei.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, irogers@google.com, leo.yan@arm.com, amadio@gentoo.org, 
 linuxarm@huawei.com, yangyicong@hisilicon.com
In-Reply-To: <20241024133236.31016-1-yangyicong@huawei.com>
References: <20241024133236.31016-1-yangyicong@huawei.com>
Subject: Re: [PATCH] perf build: Add missing cflags when building with
 custom libtraceevent
Message-Id: <173082490025.149345.6326847612586446439.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 08:41:40 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 24 Oct 2024 21:32:36 +0800, Yicong Yang wrote:

> When building with custom libtraceevent, below errors occur:
> $ make -C tools/perf NO_LIBPYTHON=1 PKG_CONFIG_PATH=<custom libtraceevent>
> In file included from util/session.h:5,
>                  from builtin-buildid-list.c:17:
> util/trace-event.h:153:10: fatal error: traceevent/event-parse.h: No such file or directory
>   153 | #include <traceevent/event-parse.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> <snip similar errors of missing headers>
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

