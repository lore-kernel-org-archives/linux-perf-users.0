Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3C199FBF;
	Mon,  9 Dec 2024 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784284; cv=none; b=Uv4QUn9FwDo/ftnrDc+msMbhU69ct5PL4dP+5P6LwQmjDS1AWtx0FvGPDTn4dDV97EonTTRIO5mE2POWqQJk3jF7CwKnc8azkHri+RAsVmwqTlHcoB4cnky2mT/0MEjD/S6t2yst77+vc/zN9HgryFTmJhea+W3nXRelvo/G6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784284; c=relaxed/simple;
	bh=610LWZ3Sksv/McKaTRY9n+RLeJxHkAjCEGBV/L2fLc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8t3gJS5Cg4YfYOw99uI44TgiP/9w9RXtubTzRAQeP6FaGRv9S5VR4xy+ZCd26fn9lzmgA9GbhvhgXysEEmoCSJto7kC5ikZZYJoysk8XgfCII67UdCOobezbh6H7C9H9qOLz5Uq2N17a4DJRle+H9KA+YraigFhQ+ePPlOKC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrOO44GO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrOO44GO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06A5C4CED1;
	Mon,  9 Dec 2024 22:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733784283;
	bh=610LWZ3Sksv/McKaTRY9n+RLeJxHkAjCEGBV/L2fLc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrOO44GOt1mbY2OQn3QCOX3GtvBatcVJuBymTLOpgezdwGovEYT1t0PCrnzv7zJux
	 jAMafpQUSa90wnVyTFpF8dDlDhzB9og6tSB0aFDq61nCPzWPpn+Bct6pXAb/A1gzlI
	 4w97Q/oCAb1699U068+at1vbz196I6sjLKoe5kpskEEBiJH7ps2hRYzE1/aZ86VrJE
	 PQbT5VEwwhSUWRgGE8MZEqcHoIdlQIVLbvPUmwbnX+uV42pEoryOvliTeM94hm/PiJ
	 qGUcWaHsOSphc78osdD7Vk/uDPuK7nS/JhOfLOxJLDA6wx86treDv1gvZHtuXQH3CP
	 kjfFzP331vMLQ==
Date: Mon, 9 Dec 2024 14:44:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 2/3] perf lock: Fix the wrong name percpu-rwsem
Message-ID: <Z1dy2Svj6gddulHf@google.com>
References: <20241209200104.870531-1-ctshao@google.com>
 <20241209200104.870531-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209200104.870531-2-ctshao@google.com>

On Mon, Dec 09, 2024 at 12:01:01PM -0800, Chun-Tse Shao wrote:
> In `perf lock --help`, the name of `percpu-rwsem` should be
> `pcpu-rwsem`. This patch fixes the naming in `lock_type_table`, and also
> replaces the mismatched name `percpu-rwsem` before parsing it for
> backward compatibility.
> 
> Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
> percpu-rwsem`
> 
> Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address")
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/builtin-lock.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 7e36bbe3cb80..264acfa648e4 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1587,8 +1587,8 @@ static const struct {
>  	{ LCB_F_RT,			"rt-mutex",	"rt-mutex" },
>  	{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R",	"rwlock-rt" },
>  	{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W",	"rwlock-rt" },
> -	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"percpu-rwsem" },
> -	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
> +	{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R",	"pcpu-sem" },
> +	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"pcpu-sem" },

It'll change the output of perf lock con -l.


>  	{ LCB_F_MUTEX,			"mutex",	"mutex" },
>  	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
>  };
> @@ -2365,7 +2365,11 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
>  		/*
>  		 * Otherwise `tok` is `name` in `lock_type_table`.
>  		 * Single lock name could contain multiple flags.
> +		 * By documentation, `percpu-rwmem` should be `pcpu-sem`.
> +		 * For backward compatibility, we replace `percpu-rwmem` with `pcpu-sem`.
>  		 */
> +		if (!strcmp(tok, "percpu-rwsem"))
> +			tok = (char *)"pcpu-sem";

I think you can do this in the other way around.

Thanks,
Namhyung


>  		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
>  			if (!strcmp(lock_type_table[i].name, tok)) {
>  				if (add_lock_type(lock_type_table[i].flags)) {
> -- 
> 2.47.0.338.g60cca15819-goog
> 
