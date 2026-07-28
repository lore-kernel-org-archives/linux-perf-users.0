Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFA381EA3;
	Tue, 28 Jul 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256901; cv=none; b=cqWciL1bFRiTUretKmgpJ6DYjbQM1qNESwZp3d19cftDkST03ysTVxz369J4imQb/vqOyCe9Y5TAd7gSdIRSAGFYTJmRVMqojxmeqZbTdmkUQp+zEySy8wuV9noiwOB2kIw5mZt/KsWTjDGqFfUO8JiVofvigM6a8wouGxrVt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256901; c=relaxed/simple;
	bh=5M/DAkNz9LTWf3/Lr8xII6EWteUpw/MQ7J1s2Q4wmu0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RwJbKxMmZ3pGUd3/raNtHdG6OKbE/LQM3B6Y18d7H+cD9jkc3ZFiyCrfQB5zUKS+ZeaT5lKhK3RCfi4J5CtZNQYegf5YMhPYbvlAJC/zf/8JhEt9OFG0lsUgWD38/O8CLeVu9hmojbXih0sZ5wPWa6Mt8YdjKqqsjKqIKWteYiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZh8y9XF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZh8y9XF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB191F00A3D;
	Tue, 28 Jul 2026 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256900;
	bh=95Tp8EyrSuQ0ayxvQpM+TOs/S7cyjHM4cu3QEkHcCH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FZh8y9XFsn994ri9oKV+5jO26tYDsHQSa02qjp2U0+AsBzSJ7p4DzsSahhMEIjpd9
	 s8YaKMRU0uyB4vbc9S9J7us9cQobkGac7XGE/SrlDRrAEkYB70mfkoc44sYqok8ivG
	 zbTLLf/oIrhpai/dx/dImCV49INH+24buxM1kxRup1Ci14I7WC7TyrabHdspYL+IG9
	 kF5/ojur2Ey84RfGshyPF5AvHDcKCZdP9NeNdxZRvPR9aVd+w4KB53yu73Fw1RGiPJ
	 U4fFDvnqoBqt1lT4XHPXLSfjfXzzotoYvasOKx3NN3Z/+8fWDNO42ExWjvjetzB6sG
	 6POT7gPsPx1rA==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
 james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
In-Reply-To: <20260723045949.988740-1-irogers@google.com>
References: <20260716072351.560311-1-irogers@google.com>
 <20260723045949.988740-1-irogers@google.com>
Subject: Re: [PATCH v7 0/6] perf ui hists / annotate: Remaining fixes for
 reference counting and annotation
Message-Id: <178525689974.3281700.8487142276785118786.b4-ty@kernel.org>
Date: Tue, 28 Jul 2026 09:41:39 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 22 Jul 2026 21:59:43 -0700, Ian Rogers wrote:
> This series contains the remaining 6 unmerged patches from our UI, hists,
> and annotate fix series. Upstream maintainer Namhyung Kim applied patches
> 1-6 (except patch 4) from the v6 series into perf-tools-next.
> 
> This v7 series includes:
>   - Fix stack use-after-return for symbol_filter_str by duplicating with
>     strdup() and freeing during evsel destruction in hists_evsel__exit().
>   - Guard against NULL hist_entry in add_script_opt() when trace is empty.
>   - Populate map_symbol thread in report UI with proper reference counting
>     (map_symbol__copy, thread__get) and memset zeroing in
>     free_popup_actions().
>   - Fix dso_filter reference leak and exit zoom cleanup.
>   - Robust cross-platform disassembly fallback when annotating without a
>     thread.
>   - Remove duplicated thread member from struct popup_action (placed at the
>     end of the series per reviewer feedback).
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


