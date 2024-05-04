Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBA537FF;
	Sat,  4 May 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714846326; cv=none; b=jr7QWflVwNDX7UKMCoM4DGaMs+JVIW2Ps7S1zgaeCbTc5teF4Mm58wVvDHEAZNbRrqG/xGSQFz8mV5vf/IRrWnw5/q7WD9LNIaBy8proLQmltnHS2GGjZq42Knhgbt7ui/xIHNX1F7PTwAqZ4tu4YxZNk4ZnNfQCf10y1yz2sAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714846326; c=relaxed/simple;
	bh=mqAFGOz/X/GXqUlmgSBGbcIPX3kC+Fg1h3lvykx5GX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imXh2f24CcnVYAJAnjX7x7mV3Jli9Dt9w0mzYoLwaC2UHsDoK2XX4VoZM+eNLa98mwlGBuG5kxr90VGqNF2qnhU+Z9pvz3xoMjIjWe0Ib5KiR3gbnEX0eyIC85qQE+qVYMoCwYtFLD3APXyTApQZ2omIf9JiilqVo8edJCc2yDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnJmtaLv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnJmtaLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06501C072AA;
	Sat,  4 May 2024 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714846325;
	bh=mqAFGOz/X/GXqUlmgSBGbcIPX3kC+Fg1h3lvykx5GX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnJmtaLv7FZ2Vxn7UbSqp6k32jc+NKGzmSKJ5qLU9JyIUedqECalJyx4HRnuzOI8a
	 e/ARcIriMvjKxb3RsFHTAxySx7faz9zM4c4s01gPnIMP8eiCte9wSM8aeMicJ5Jdwi
	 0mmL4vGF6VPePHIEVATCdnlGijqg9T+4FbnLSIJ2UXS/NwKVechVDlzZt/8kb6Hc6I
	 R4SwZcI0TQX7UlWJ8Q3HOWewVbvko6Lj3ORC8O0tupaSdNZ0JrvfY3nwB3eN5OrdZw
	 /TB0plACLVATLth0frV2YbVqAiC2Jdw8HsvhuHkhpUJ8lN8UsQ0HxGLWY2yr94HpNa
	 lZrJ08KCotC9g==
Date: Sat, 4 May 2024 15:12:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com,
	ananth.narayan@amd.com
Subject: Re: [PATCH v2 0/4] perf vendor events amd: Add Zen 5 events and
 metrics
Message-ID: <ZjZ6csbnXZNUX1iY@x1>
References: <cover.1714717230.git.sandipan.das@amd.com>
 <CAP-5=fVqr9E_YS-V=1rnrxH3AchRy8x0wR9wSpSwLiUNuMij=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVqr9E_YS-V=1rnrxH3AchRy8x0wR9wSpSwLiUNuMij=A@mail.gmail.com>

On Fri, May 03, 2024 at 09:29:27PM -0700, Ian Rogers wrote:
> On Fri, May 3, 2024 at 12:16 AM Sandipan Das <[1]sandipan.das@amd.com> wrote:

>   Add events and metrics taken from the Performance Monitor Counters
>   for
>   AMD Family 1Ah Model 00h-0Fh Processors document available at
>   [2]https://bugzilla.kernel.org/attachment.cgi?id=305974

<SNIP>
 
>   Sandipan Das (4):
>     perf vendor events amd: Add Zen 5 core events
>     perf vendor events amd: Add Zen 5 uncore events
>     perf vendor events amd: Add Zen 5 metrics
>     perf vendor events amd: Add Zen 5 mapping

> Series:
> Reviewed-by: Ian Rogers <[4]irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
