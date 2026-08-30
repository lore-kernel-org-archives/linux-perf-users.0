Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0E2BE034;
	Sun, 30 Aug 2026 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788097037; cv=none; b=BHdJhUS13MX78czJTxw5Rf2I2LBgF4n4Cg5Z9IwCpeAfEVppil4Z1vCTlfYJV0ZUQX67tzC0zaAhrp56V9OI7RVVxGxKUd/NpR0404T0ENDiJrYuQ5z24pjo+pMCouUTTIY1f13huuQKXF+DkfrCXrbYCI1ZKJsuI6RtvCUBeY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788097037; c=relaxed/simple;
	bh=pEZ4I4RoQNrnH+CkJR0wlrnXgf3YUwAmCMvitng/gtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJWzDDNjpmHxaUnpnoENAuwcATh3EtIPe4jKbOjYqgo4GjWLnkBczpi9pw4dAG3lxNqmAHfGCRhqWcKeEGbc4ECkKg9zTaVIriejYllY1boO+WWPnTgOjYhoG/ivxrM2XG1TNGEvXvKMjRVYDLXQT3+1/67U0d3EdJhpCc1qwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8f3BVJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8f3BVJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AC41F000E9;
	Sun, 30 Aug 2026 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788097035;
	bh=mgpGzk2npaI5ha3R4186qbjjw/i4eJm+nG+Y1M8GmsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W8f3BVJ2nJtN7H9NueAd3YWSPwiMeEAz9gB/cQDzb8nLC6S7HETZEjyo7Y0NSxoKr
	 ZKUJYwzzVSIyRSr+78Q+SUYN5vPTbqxxMKzPzFcErTjwUrIitZe3aqZFOcaE7D9Qqd
	 ypYi7JPo95++Oy91u/2FFD2FmWWgNmkGt5Zh7vzWTDDlrXMf3Q7LeNwYwItutYM1RU
	 /h9vkidfBuOIxsobINQUIaG4OHTMaDZMLcn+nmSI6jQC2q/5O/IphnBCQla7r6HkME
	 SNwx1Hm7yGvxy32dlqtVAPB/hpsmLLL5Si6LcCfXyjKwRgCU1LCX+LKcyY7c51YMSU
	 aRKCddpYuJ8Vw==
Date: Sun, 30 Aug 2026 10:37:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Wang Yan <wangyan01@kylinos.cn>, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf powerpc-vpadtl: Fix raw_size of DTL samples
Message-ID: <apQyCcDl1jm5OPN0@x2>
References: <20260825094733.1031566-1-wangyan01@kylinos.cn>
 <85CF9B6A-8E46-4D5E-8AAD-A9B3B75DF6BF@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85CF9B6A-8E46-4D5E-8AAD-A9B3B75DF6BF@linux.ibm.com>

On Fri, Aug 28, 2026 at 05:29:00PM +0530, Athira Rajeev wrote:
> > On 25 Aug 2026, at 3:17 PM, Wang Yan <wangyan01@kylinos.cn> wrote:
> > 
> > In powerpc_vpadtl_sample(), raw_data of the synthetic sample points to a
> > struct powerpc_vpadtl_entry (48 bytes), but raw_size is set to
> > sizeof(record).  record is a struct powerpc_vpadtl_entry pointer, so
> > sizeof(record) is the size of the pointer (8 bytes on 64-bit) rather
> > than the size of the record itself.
> > 
> > As a result, consumers that bound their access to raw_data by raw_size
> > only see or copy the first 8 bytes of each DTL entry instead of the full
> > record.
> > 
> > Use sizeof(*record) so that raw_size reflects the actual length of the
> > raw data.
> > 
> > Fixes: 8644834a482a ("perf powerpc: Process the DTL entries in queue and deliver samples")
> > Signed-off-by: Wang Yan <wangyan01@kylinos.cn>

> Reviewed-by: Athira Rajeev <atrajeev@linux.ibm.com>

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Namhyung, I think this is v7.3 material.

- Arnaldo
