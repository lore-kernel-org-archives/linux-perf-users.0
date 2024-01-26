Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7172E1DDC9
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jan 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279202; cv=none; b=dDxx9/UidPS1P0UpbFOLHRCN32fzCUMOIkrdrTnNHtcx+QyLpdD7MIQVWgO5vxjmiAQLLVYu/Ja2nBAMBjn9pmBKmkHIO5OruWBLuKJLk6oRC0TS0kr+/0nv8t3cBFiHVMkfOWms2wqgp9pBpscVAlGMUxrIq1JQkYkYS6bZQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279202; c=relaxed/simple;
	bh=KDjzYBuqBbsZeawvlW2Qdi1zx/tzi2/9POHY7OiGijM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQNIa8ARqcugtEEfeF6coNRZ7wFPjAfZsXqEonQ+zt/bYeO609FVmI6Y4qLkdvmwJ0MqBUSOYNNDBtqf7uPEZTu3zVd5nuV+LZZ6HD6Fg8GSsoXLlv7+mTlE2E9TO5Z6QZGfE0h/bGHPaLFdpgeUgg7imksppXmOPVjxdu5HMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYncyqA5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYncyqA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBF5C43390;
	Fri, 26 Jan 2024 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706279201;
	bh=KDjzYBuqBbsZeawvlW2Qdi1zx/tzi2/9POHY7OiGijM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYncyqA56AqhLFSjku7DOSpQfUkDJGDHyuQmGqH8lqrN8gCRqKDgzKp3qOvNOTHRh
	 rMX9zqa2XEBH+iFedo/OL1YfqKOznH3qOzLcQPETLlSYgIMQZ1quQ29iEPoXEflFaR
	 9CVYJi/pzcqrtwu5khqZSVxlNv87gzMaSvLrXRGm7UyuuRZUwvqpnxzd7pLNhRzKWj
	 UEom7vf3e3WXmCeulaTcj/485nHaMfRoAMM9H7iBF1mDunSDz9MGsahZYaJjEhxY8q
	 ZFQ4W9sDeMvi1aME+9GvuOFlnNOgttXUpmjhRmSmzrRrfq7uGkH7x3L11GekU3hhJ9
	 WmpaM8z/esK0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id F28E7405B2; Fri, 26 Jan 2024 11:26:38 -0300 (-03)
Date: Fri, 26 Jan 2024 11:26:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Yicong Yang <yangyicong@huawei.com>, namhyung@kernel.org,
	peterz@infradead.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	linux-perf-users@vger.kernel.org, yangyicong@hisilicon.com,
	hejunhao3@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH] perf build: Make minimal shellcheck version to v0.6.0
Message-ID: <ZbPBHmvKJJlprxac@kernel.org>
References: <20240122080406.28678-1-yangyicong@huawei.com>
 <CAP-5=fVzaRycRX2+NNMRp423sU5qpBa8z8p-WmF5sX+ty1Xf8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVzaRycRX2+NNMRp423sU5qpBa8z8p-WmF5sX+ty1Xf8A@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Tue, Jan 23, 2024 at 08:04:55AM -0800, Ian Rogers escreveu:
> On Mon, Jan 22, 2024 at 12:08 AM Yicong Yang <yangyicong@huawei.com> wrote:
> >
> > From: Yicong Yang <yangyicong@hisilicon.com>
> >
> > perf build failed due to the shellcheck on my machine (v0.4.6 on Ubuntu
> > 18.04.1 LTS) doesn't support -a/--check-sourced and -S/--severity option.
> > These two options are introduced in shellcheck v0.4.7 and v0.6.0
> > respectively. So restrict the minimal version of shellcheck to v0.6.0.
> >
> > Fixes: b809fc656e76 ("perf build: Shellcheck support for OUTPUT directory")
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools.

- Arnaldo

