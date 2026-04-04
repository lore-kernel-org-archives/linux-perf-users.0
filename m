Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB4223DE5;
	Sat,  4 Apr 2026 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261703; cv=none; b=I6rxJ5SVNBKZ23W5IKWoVfbAonbWVdoEqMXugAqLjnu7kus/Hn2ZFOvBgHRTvnwe9kt0yIfjOthrgMIMZHoZelDswjcUk3C5X8MNhsuIq8TuE1U/eesaCtKrjqIn9K75kk2i0Dd7a+urScBp/DjoHCX44dRmE89z+KN2DPBWOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261703; c=relaxed/simple;
	bh=YW7Nv5EoaXSUqQ64vlRbl6ohaC8q/KVO3kacHboPW4k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RV6cbOJSVsAF+7yXpmpTfz9phgUAOysSmyBEpg8lfhiNumqKYX/KCKybRFmIfGQK5rHCOJ/gQWCTdhNaEfcyqu3uh0FN/WjrEI3oC2SXIDzFce8t3KXBFBlqUCHMijzWzi0GFflTAGKaAGXlABx/rQUVGqMSBkG1vBGv/LWE5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBGZE3ve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBGZE3ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F53C4CEF7;
	Sat,  4 Apr 2026 00:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261703;
	bh=YW7Nv5EoaXSUqQ64vlRbl6ohaC8q/KVO3kacHboPW4k=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=jBGZE3vecw4Uu204fkfdBnoYjmCm5Rpy43EDoz0hWqmHQvUwlBK1HansuLcCbm+7W
	 A2gqFlNcWgJDSlB/+lGZhBBobtTM7PhXbafZ1VmCsDxaXtfVy1hk+G3mTDW9R2sDzZ
	 8GRKoTbZPUpGPsoQRDOPVmQR2ZjxsbQ9IFVeLPfe2UPL4CsjWEzhe95Cirf56uVysV
	 OHlMOCHms5imuUXpBOBYABSsmhtMEPEWDDf263UaDJW0QAvNqe5zS9xGtrHLAEPPoZ
	 aa0Ftn/5zMLRzoJK1Okw+W1RL4y9aNhEojc4AtzS94iT20Q+fALfpgfY4YHCR5CMA3
	 2NQBZnbrr3tCQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Feng Yang <yangfeng@kylinos.cn>, Yang Jihong <yangjihong1@huawei.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20251209170814.2009253-1-irogers@google.com>
References: <20251209170814.2009253-1-irogers@google.com>
Subject: Re: [PATCH v1] perf tests kwork: Add basic kwork coverage tests
Message-Id: <177526170284.2123878.11696757456881836231.b4-ty@kernel.org>
Date: Fri, 03 Apr 2026 17:15:02 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 09 Dec 2025 09:08:11 -0800, Ian Rogers wrote:
> Add basic kwork coverage tests for record, report, latency, timehist
> and top.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


