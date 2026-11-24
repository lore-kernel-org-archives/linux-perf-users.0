Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519609;
	b=MSneHqnrXS9KKMsqR3uUQ8GlPyx7hMLTmHXRK7eJmWQwVtBTKbdf7Vfjdqz6YB+p2GHD
	 /PRFNDCftxaOZt+wQ3M53nTPw3FPSnVZzMKhEwI7wag2Wwm48u3C37UN9tDS6ImSWFZl5
	 sRr5V9m9u2ADWM2NzrpXWlF8yP0S/EsY8Ev/5ZWc0ILnXxIipMAsOEp434bg8kSoZiVHK
	 KJcyOSMm6AMXa59jHhARDe/1LWneMuMikxySCQkYj3C6OdagT3QMMn3d9yYbM4uydZK4C
	 zVzQjzB/uwX8MqJiDNf3htc47Eq3Np8Xh5Nex8nZ1/7jKNY4ElDRUgai9JZONa+pU5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519609;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QX+bil2iOPbw8yZ3QOT5MEDkdPOtPBgyiXG/0MXCS4s=;
	b=aya3vStC0P7nGVbe1zhQbMmBpNrRljlHhmFbvOgSrlGmgt3H7n2OrQMA1peVIsIEaaIi
	 idbTKNxffdYYNYDjOhdBJWHbnDWOBRXVSMLxxR5ypHOTIhBdUjalnceoUdWXQZ9bx9R7b
	 Ob4tbcQqci8ztMM2bWIx8/AvhRKeO+It9ZaxhB1TaQdAiduWl8i8lo5txiJFoQfIPTsaa
	 Lkt3P8P35iUEo/RGQzyaS6rbPv6x9XQ4G89dq5Onv+COC2NVzqJYqypvFeQuHkzKUVuoa
	 BM32EXGLlmtD5f3/RmGPK7NGNDzH2o59fkC9jQx8xLjWwJRFOH7lrP67+3W42gT/0EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJhp0SWC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A5606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJhp0SWC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFD11F000D1;
	Tue, 24 Nov 2026 11:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795519608;
	bh=QX+bil2iOPbw8yZ3QOT5MEDkdPOtPBgyiXG/0MXCS4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BJhp0SWCa5w1sgm5siHVaRO6BBCCkppKUQVV6sI9it3rg5IxEf99WZ/Ts/1rp9tNN
	 LoJpaTVya0pJ8tZCEksaRS5cbFjByO3YD++cGsfq+facEWmUpewaXL93DEB6MG5qep
	 7ZGcyEUBk8+3XFS4QZqgL19rA7jztw8FDW0tj9dLETtPv42nWvYHRTsPJMVbS3jBmC
	 x007OD3IYuP9NEKnnvRbY8GVcRST31dqHWSU0MkkAax8kN8+ZZUY8jxP5wEJiiILXD
	 8HbS2S1UoweIcwuNfx3/gKgK9C/wNmdrfZk2LYd46hWYbWnU0sL/TzKY9xSjR3bKHL
	 c3xrbIVdKDERg==
Message-ID: <sashiko-outbox-231049@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf build: Stub out __guarded_by() on older Clang
 versions
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124-james-perf-late-parse-attr-v2-1-cb8b00d904a7@linaro.org>
References: <20261124-james-perf-late-parse-attr-v2-1-cb8b00d904a7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 11:26:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf build: check-headers.sh ignore regex misses #else lines
--

commit 0ea3202ffc7513d3010799640980ebb7d00cf374
Author: James Clark <james.clark@linaro.org>

perf build: Stub out __guarded_by() on older Clang versions

This commit stubs out __guarded_by() and __pt_guarded_by() in
tools/include/linux/compiler-context-analysis.h on Clang versions older
than 19, and updates tools/perf/check-headers.sh to ignore the difference
from the kernel header.

> diff --git a/tools/include/linux/compiler-context-analysis.h b/tools/incl=
ude/linux/compiler-context-analysis.h
> index 024e303188ad3..2806fb5f79d3a 100644
> --- a/tools/include/linux/compiler-context-analysis.h
> +++ b/tools/include/linux/compiler-context-analysis.h
> @@ -60,7 +60,11 @@
>   *		long counter __guarded_by(&lock1, &lock2);
>   *	};
>   */
> +#if defined(__clang__) && __clang_major__ < 19
> +# define __guarded_by(...)
> +#else
>  # define __guarded_by(...)		__attribute__((guarded_by(__VA_ARGS__)))
> +#endif /* __clang_major__ < 19 */
> =20
>  /**
>   * __pt_guarded_by() - struct member and globals attribute, declares poi=
nted-to
> @@ -85,7 +89,11 @@
>   *		long *counter __pt_guarded_by(&lock1, &lock2);
>   *	};
>   */
> +#if defined(__clang__) && __clang_major__ < 19
> +# define __pt_guarded_by(...)
> +#else
>  # define __pt_guarded_by(...)		__attribute__((pt_guarded_by(__VA_ARGS__)=
))
> +#endif /* __clang_major__ < 19 */
> =20
>  /**
>   * context_lock_struct() - declare or define a context lock struct
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index c6b2ecadf9b12..caa7ab26968ce 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -23,7 +23,6 @@ declare -a FILES=3D(
>    "include/linux/bits.h"
>    "include/vdso/bits.h"
>    "include/linux/cfi_types.h"
> -  "include/linux/compiler-context-analysis.h"
>    "include/linux/const.h"
>    "include/vdso/const.h"
>    "include/vdso/unaligned.h"
> @@ -193,6 +192,7 @@ check include/uapi/asm-generic/mman.h '-I "^#include =
<\(uapi/\)*asm-generic/mman
>  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman=
.h>"'
>  check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)*=
 static_assert$"'
>  check include/linux/ctype.h	      '-I "isdigit("'
> +check include/linux/compiler-context-analysis.h '-I "__clang_major__ < 1=
9" -I "^# define __\(pt_\)*guarded_by(...)$"'

[Severity: Low]
Does this diff -I filter miss the bare #else lines added in
tools/include/linux/compiler-context-analysis.h?

diff -I only ignores a difference hunk when every changed line in that
hunk matches an -I pattern.  Because the #else lines are part of the
3-line insertion hunks with #if and # define but match neither regex,
tools/perf/check-headers.sh still reports a header difference warning for
compiler-context-analysis.h.  Adding the /* __clang_major__ < 19 */
comment to the two #else lines (or matching #else in the -I filter) lets
diff ignore the hunks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-james-perf=
-late-parse-attr-v2-1-cb8b00d904a7@linaro.org?part=3D1
