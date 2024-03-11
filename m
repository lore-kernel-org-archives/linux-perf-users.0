Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18E240C14
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Mar 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192128; cv=none; b=EqTDCrDqFWo16oL0WcfMwb/1aEWoYmHHuFOJhG6Px0d9FU+Wk1DEDsoxu9JIaCNqhvY/F+Z+wDdKkZjhx7ivQBylxuLHkzbhrM719RXaA8q8PD1y4d4D2GJMc7fDvNt8iWB8L7gDQ2cqCR3SVADQXcN7DoHo+zysbXN/aIQCW7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192128; c=relaxed/simple;
	bh=rU4xSNrOkCPdgwpTy+jxPQGnVqBNHfhLebHJ/P49pf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJMd/2y3qCiiEcDsIl4WjYRx/4szwcC0iccwug+Mb6p3S5rgc+KrZ7tGQplzIsZVR9UaNwhKJ9GxJaKhfTzs1+6p//Hi1/FpZMwQM6GJULtkD6pQt7GvIhXujDpSC1ka8RIDtEQK78K3UdSp0BB/vZrIdgz90R20GCosNBSe4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA87zAlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA87zAlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A44C433C7;
	Mon, 11 Mar 2024 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710192127;
	bh=rU4xSNrOkCPdgwpTy+jxPQGnVqBNHfhLebHJ/P49pf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SA87zAlLtZ5T0c+XNsBW0Yj3E94xqtWMIW5BMkdUUvSnGhI+RZhuJd2pYD9A+K6eG
	 E8M9p0OLfiwQYhps1QAfzAS8XO7P3MvAAmNq52HW92AkXGsC5VYC55hYIJi/BSW5gG
	 s13TkuSqc+8WJsLs4N9Oj8kaDLyT9+B6OrHlGeJ+yx0bb6ZoZZmtILYvps1D86aAxl
	 outkZG18X8S02vWEXQUwGhvNvUQ/3DVX/mylXCd040bQ/WntkyfzNWME60m3qJ2yte
	 k4Ari1bJcum+pYknzGbako146cA6TL3INsZjEB+uyzgjl0w9OH1wLHDx5e+z0o5kqS
	 RziFjcKK6sJ4g==
Date: Mon, 11 Mar 2024 18:22:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Madhu patel <patelmadhu06@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: GSoC'2024: Perf: The Linux-Foundation
Message-ID: <Ze91_IjWIfNIdiko@x1>
References: <CABDzTvZMHo_ryQeZjz5t0vvGzeNZKzDW70z+rFHjmYZLfRwsEw@mail.gmail.com>
 <CAP-5=fWWs++A+qKBnnj+OSFWUF+nDitvyNn92K3L-5F2mezJQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWWs++A+qKBnnj+OSFWUF+nDitvyNn92K3L-5F2mezJQA@mail.gmail.com>

On Mon, Mar 11, 2024 at 02:15:02PM -0700, Ian Rogers wrote:
>    Sorry for not replying earlier and thank you for the interest! Helping
>    to improve the Development wiki page would be a great help! I'm not
>    sure why that guide suggests downloading the code from Arnaldo's tree

That guide is outdated, I tried fixing it a bit but I'm having trouble
with the credentials, I asked for help from a wiki admin to fix that.

- Arnaldo

>    at v6.3, the latest code is in:
>    [3]https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next
>    .git/
>    in the perf-tools-next branch.
