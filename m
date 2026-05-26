Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08482EA73D;
	Tue, 26 May 2026 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761057; cv=none; b=NSVxMuQ+U/Ua8KKxOZKtkoSHMn3JrHzMriwjHgKjabTME47upSqLiQFDt7bU/ueTp826KGH6ailIl4s6+N0l2t+XF4tMpTLAK0empW4emj/80dhZHfRHYNlcoyLy+QLG91lTdP72ud242S35FpfVXLqDs5nSUT+U8PcwnOpe3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761057; c=relaxed/simple;
	bh=Z0KPbg8Pc8y5R8/1aDDam02dcEupKxVfiS4qHjwnx44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB4sW6uR5uUngmsNQ+jhyOHtKXmNE51wSE2UNQRbzicP+Hk0YUzpS4Z7AzxXhBoAbr/hjyELS5i+n0LfnpnQ3XmwXmignHYO5DEReqKYlZEBXGibq4bnqd/bGIxkjgXMJH3iwaM1V61nJuxZb9sAN1JsR3omCZiA3Tyc8EYjOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh91ehEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh91ehEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A51D1F00A3A;
	Tue, 26 May 2026 02:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779761055;
	bh=04fe6A19Qssiav6OS3hZ/Bec4fvAqvhZxStwp+wXFJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wh91ehEJ7UhQ7K/O+PzcGoXXvlsDcrXTQQhikRoU58QGUWOwBfv2AcR3L7ycg7xnj
	 jafCX3vq+Y09Vg+PZSwKcaUOANGBZetdKxZXukk3JZbmFibGeWKJRc7NAAVZFjMrpr
	 9pHOBOk3OSDoJ8l+R6T6/jjmd9azc9rZkwsI5K4fHxIEkYcwFfSEoPWaqomAo8OKQT
	 cUVD5CyvWcEjFKomZgt+5Th4mm8jVoReogiWlew1sHzGwc9l4tChPfOR/YZtTK4S7m
	 Z9SwrnnXCVFm5wb191jRLO2eUTJ74J1OaO3hLs1vKnRMDiKPGwz9Qpl0h/QxNgiqOz
	 ysOhg8qLUAgHQ==
Date: Mon, 25 May 2026 21:04:11 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] perf: Add is_ignored_kernel_symbol() for kernel
 symbol filtering
Message-ID: <ahT_m5dG6rITpTNB@google.com>
References: <20260507071103.2772577-1-qirui.001@bytedance.com>
 <20260522082604.89447-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522082604.89447-1-qirui.001@bytedance.com>

Hello,

On Fri, May 22, 2026 at 04:26:02PM +0800, Rui Qi wrote:
> The perf tool currently has ad-hoc logic to filter out ELF mapping
> symbols scattered across multiple files. ARM, AArch64 and RISC-V each
> have their own inline checks in dso__load_sym_internal(), and kallsym
> processing has yet another check for ARM module symbols.
> 
> This patch series introduces a single is_ignored_kernel_symbol() inline
> helper in symbol.h and converts the kernel symbol handling paths to use it.
> The helper covers the existing "$" prefix used by ARM, AArch64 and RISC-V,
> and also adds the x86 local symbol prefixes so that perf stays consistent
> with the kernel's own is_mapping_symbol() logic.
> 
> Changes in v4:
>   - Rename the helper from is_mapping_symbol() to is_ignored_kernel_symbol()
>     to make its purpose clearer.
>   - Split the single patch into two logical patches:
>     - Patch 1 introduces the helper and applies it to kallsyms and ksymbol events.
>     - Patch 2 applies the helper to the ELF loading path for kernel DSOs.
> 
> Link (v3): https://lore.kernel.org/all/20260507071103.2772577-1-qirui.001@bytedance.com/
> 
> Changes in v3:
>   - Add is_mapping_symbol() check for kernel modules in dso__load_sym_internal()
>   - Add is_mapping_symbol() check in machine__process_ksymbol_unregister()
> 
> Link (v2): https://lore.kernel.org/all/20260506073820.2419087-1-qirui.001@bytedance.com/
> 
> Changes in v2:
>   - Only apply is_mapping_symbol() filtering to kernel symbols (kallsyms
>     and ksymbol events), not to user-space symbols from ELF files,
>     BFD libraries, or perf map files.  This avoids incorrectly
>     discarding valid user-space function names that start with '$',
>     which is a legal character in identifiers for many languages
>     (e.g., Java, Scala) and compilers (GCC).
>   - Move the mapping symbol check in machine__process_ksymbol_register()
>     to the beginning of the function, before any map/dso allocation
>     or insertion, to avoid leaving empty maps in the kernel map tree.
> 
> Link (v1): https://lore.kernel.org/all/20260504090609.1801880-1-qirui.001@bytedance.com/
> 
> Rui Qi (2):
>   perf: Extract is_ignored_kernel_symbol() for kernel mapping symbol
>     filtering
>   perf: Apply is_ignored_kernel_symbol() filter in ELF loading path for
>     kernel DSOs

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/util/machine.c    | 18 +++++++++++++++++-
>  tools/perf/util/symbol-elf.c | 10 ++++++++--
>  tools/perf/util/symbol.c     |  4 ++--
>  tools/perf/util/symbol.h     | 15 +++++++++++++++
>  4 files changed, 42 insertions(+), 5 deletions(-)
> 
> -- 
> 2.20.1
