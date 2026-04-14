Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B33E9588;
	Tue, 14 Apr 2026 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186721; cv=none; b=lcrF50ZlbjAZvx9/YEP3MeH6pzlaQ6Yazz2QncoCNRZUDppPbAhcB71Rb0FvDjs+Yumw1KIAKIkRrqtZ3c64WbhQ0AwoqQ58QofRU8RedNsdIurmhILi4kqqD30Fkc9nvgi805MDkfGyBhdMsLTBd51vGfa4Q3kUOvSn9vRBT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186721; c=relaxed/simple;
	bh=chtNuHEy+hRQdbmdZEoy7YXX+NHhW1beCxq7GjHM1qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S8vbtF+jaSetz0eDTkNbstK8SqUWaIsIeAjwH5/dwUdFcQCnSHbJQk2au3xfruePPOckpfxQiUmR2JABqML7bN1XMbXa4uXgaPSb8geI6KNlOitrVdhWAoICEbm9rgjBuR55ERE6bHvSU+W3R0FIqVRrizoOC0neF2UprA49PSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnyWuny3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnyWuny3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A94C2BCF5;
	Tue, 14 Apr 2026 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186721;
	bh=chtNuHEy+hRQdbmdZEoy7YXX+NHhW1beCxq7GjHM1qc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pnyWuny35X+/ruYJ+GJf19LUmaWAJk3dpPZ+900z7qCyyToLkEXFK0tO66u+9nBX7
	 0DRnDJDE2J/tkf5wM8PRt2S+MgGo6N51ExKsnnXmaIK68m6VYDHPw7xSx/eP8aFbj8
	 il+aA52qYVp6D1/yiBJJAusE8aHCcAXvdTXmNZ1X6/Un9Xg3z1NzTjwCAN9iBw1hsv
	 txSjVke1EUSoF7njGCb9kTSYumKm6NkLExO5/9Lk4u6oXU1P81nyPK+qGgefCaYILB
	 J3UlqMmqFG7IjslKmQ6y9ftwaNmCAIMQfV4YHHqwFlZw7FAKPRePhaXJTSAXXUDRms
	 3pf5zvTRUMS+A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Rong Bao <rong.bao@csmantle.top>
Cc: stable@vger.kernel.org, WANG Rui <wangrui@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260413100412.2313688-1-rong.bao@csmantle.top>
References: <20260413100412.2313688-1-rong.bao@csmantle.top>
Subject: Re: [PATCH v2] perf annotate: Use jump__delete when freeing
 LoongArch jumps
Message-Id: <177618672057.1519819.8241448088490152027.b4-ty@kernel.org>
Date: Tue, 14 Apr 2026 10:12:00 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 13 Apr 2026 18:03:55 +0800, Rong Bao wrote:
> Currently, the initialization of loongarch_jump_ops does not contain an
> assignment to its .free field. This causes disasm_line__free() to fall
> through to ins_ops__delete() for LoongArch jump instructions.
> 
> ins_ops__delete() will free ins_operands.source.raw and
> ins_operands.source.name, and these fields overlaps with
> ins_operands.jump.raw_comment and ins_operands.jump.raw_func_start.
> Since in loongarch_jump__parse(), these two fields are populated by
> strchr()-ing the same buffer, trying to free them will lead to undefined
> behavior.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


