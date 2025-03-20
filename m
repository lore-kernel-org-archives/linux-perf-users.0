Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF52222A3;
	Thu, 20 Mar 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486443; cv=none; b=q5HxgthoSPZrOKMGS02/JTEDx2brAWVslmzfr2nWSRBSZT2yl50GbWwVfecC1A4e9kEFWq9goYQxpCu2SXCZT3nOQi4Sok9AKdtEPDVKHGKZRbyiuvM24wYc/wR8iv/AwoPjjAudOz5VPJLeUDF/tDapolRED3MyB/AaAEFbM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486443; c=relaxed/simple;
	bh=Fg7vCbTVG/1rgA8NipdcysO3ubVRbwp1J1syqojzpyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jSexwDA/cuZphP+pFOcU6gtECEhy2vUgDBcguHJOW7NHmNhbzV6RToQZ5yULgYY/bV526/Hha3I+jK6XAG8HpzFvwdNsjUDy6UAkWYP4mDgIQ4tLbLVarQT1In14G1i1OFcMofaLjr3j/JUcZpMY3NpLBqIe6RcKw19L8KD3kbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhvOHhil; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhvOHhil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86905C4CEF7;
	Thu, 20 Mar 2025 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486443;
	bh=Fg7vCbTVG/1rgA8NipdcysO3ubVRbwp1J1syqojzpyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IhvOHhilm3bBwIA+j+375UieZRnMPuyKuv9QFtpBKf6uJPYcR+GdHKRZVzBPSdMH/
	 t3jHw0214foxTiX7GtlTwQr8sZprJHWjvb4gETDxn5ve4+CjWd/MgsBv93+b5ihGxz
	 rBlP5e7eNqCudEMZ2bSLPFnlowlN2Vi3HZYBmOLqD8sQwLe+qQI3EsMupcMJkleDYZ
	 PvolOwPpkgFhpS8GJp2qhm7Bk26MZ3fRTEx0lAFfz7zqZNDPInV62DuJlhh3uUwzgn
	 S9G0kRdEsHQ6wm8G2P/Q4tFw4QTJc4yg0YAWIHcqqxsfL/YaXLy64rvdGl+5hkGHpk
	 yUy5PWfiLxx5Q==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, 
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250319101614.190922-1-james.clark@linaro.org>
References: <20250319101614.190922-1-james.clark@linaro.org>
Subject: Re: [PATCH] perf: intel-tpebs: Fix incorrect usage of zfree()
Message-Id: <174248644250.3704425.14877550732142254406.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 09:00:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 19 Mar 2025 10:16:10 +0000, James Clark wrote:
> zfree() requires an address otherwise it frees what's in name, rather
> than name itself. Pass the address of name to fix it.
> 
> This was the only incorrect occurrence in Perf found using a search.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


