Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D6843D500;
	Wed,  3 Jun 2026 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485022; cv=none; b=TE7MgFoctOr49j69L9PRFCyIzpbACRGKFFeTH5n/Ur3yrKKFfqkIIMNqx6wmojg9qdDlOoxTH6Og1CcKaD6g7tsgk0NbSKCsmWfa9WzPvrWtOWXHsUaCngY1WSCBDj7TzpoTF7Um4wdPA7KbgsUwz1nDCcISTrEO+JgkN13eDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485022; c=relaxed/simple;
	bh=2keBvbqZ2Vgm/fEN+Vz4ZRoD6fUJNi1ra/DrIcA5a9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWbzndHDB+v83blWaihMnJuktc18m/DEaUtREoupJxyTZmmKjcHd2i1PG1yCHlQosUBlr1Mcfuqs0KHCH8xoF3Cy/vsY8BJkHN8QaCYf+aYdyU9FTKmU5Pqr56lzX/tcr7WV+zlurHWfqnF3Tn/as3FiPJ9/vlLZ3c9LYL6nsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bTNE+nlI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bTNE+nlI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A453032E4;
	Wed,  3 Jun 2026 04:10:15 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AC9F3F86F;
	Wed,  3 Jun 2026 04:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780485020; bh=2keBvbqZ2Vgm/fEN+Vz4ZRoD6fUJNi1ra/DrIcA5a9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTNE+nlIWBpqZieGXftMVl0SrMFpBDH2jzlGkuZKz7ZCrd5of1hw/LFUuCHqPPpfo
	 WRqmWP7H41Ws68ISRWCkjeuNvINFWtsbUXPAAWZKxnvJT33SYkRo1wterqiHLNl2pZ
	 hIWj3B5rCiNlGg/RKavlCUvtz8E5c7Z0tYJipXGw=
Date: Wed, 3 Jun 2026 12:10:18 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 04/18] perf test cs-etm: Test process attribution
Message-ID: <20260603111018.GS101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-4-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-4-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:46PM +0100, James Clark wrote:

[...]

> +check_samples() {
> +	owner_samples=$(grep -c "proc1.*context_switch_loop_proc1" "$tmpdir/script" || true)
> +	next_samples=$(grep -c "proc2.*context_switch_loop_proc2" "$tmpdir/script" || true)
> +
> +	if [ "$owner_samples" -eq 0 ] || [ "$next_samples" -eq 0 ]; then
> +		echo "No samples found"
> +		cleanup

We don't need cleanup explictly here, as trap covers exit case?

> +		exit 1
> +	fi
> +
> +	if grep "proc2.*context_switch_loop_proc1" "$tmpdir/script"; then
> +		echo "Thread1 symbol was attributed to proc2"
> +		cleanup

Ditto.

> +		exit 1
> +	fi
> +
> +	if grep "proc1.*context_switch_loop_proc2" "$tmpdir/script"; then
> +		echo "Thread2 symbol was attributed to proc1"
> +		cleanup

Ditto.

Otherwise:

Reviewed-by: Leo Yan <leo.yan@arm.com>
