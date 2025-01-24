Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62F1AA783;
	Fri, 24 Jan 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737741585; cv=none; b=YGNPLh+Bp6UQxuc/hlF6se/FlGCJAt/5BAglvuOA/EU9eOgjFc72iA98ofx2JsyvfoPd82lP4OMW7MB95xCoVSOaxhEHIPydlXgg9qwi5E6o/uYhD9K33SrBhLOrv2uMJ4SsPG/E1oYG3eg2BD7gSmw9W9aMB9JG0IoDleHgLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737741585; c=relaxed/simple;
	bh=e4WDXPl3h3R0U11/6lCmm6R86JTR4Oeyn6rTYoW6t6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePpynzPX4dbz2E0qKNysUahLMxhZtlrCGF8nv9vWA6nYdJCUWKB+Rukinj4Q20s8tKMiitB2QUMagoF0b6Gv1CZyWwUg8fLAx045AAxijMuYXMz3U05JjQETkaymGO3JauYBrLGSL3PRKUmJz5zF1BIz75JhzLqRBJkLvLLKDLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxgZgtmT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxgZgtmT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21649a7bcdcso42175205ad.1;
        Fri, 24 Jan 2025 09:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737741582; x=1738346382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlSV3k9D2Ratrq++0GTszR4kd+ZXjx5Kd0itP8lOaHM=;
        b=KxgZgtmTlOtm7XWU7dT23o1hGFRlUt1HZRyVyNryMmLg2KA34J07KQm5b4PT5okH2q
         p+f3nM5Mgp8rY4AZhr/F8CLcqdzSu30kmCRVwB/cXSOksVITL/aNgvMr/rWskNXxabbK
         JCTqtvNEIIbH8cJEafiJFq2wDnO8AERFV4zFgdKLiLZ+dDcH9r2+XULNuAiNKbYeWHJH
         cqfum+37lfBjJ8CuFhhCbMFmIoaIHO97zBIzL8Y6UuyLmqKz1HKcqX1rp49z75KF6lUk
         1OCEkGe82ndPMz+OI5EI0ktBAcWUE1rZCzsAnllnCR+OaFyv5sVkjZ6ZA6MsjLD+4tWd
         4xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737741582; x=1738346382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlSV3k9D2Ratrq++0GTszR4kd+ZXjx5Kd0itP8lOaHM=;
        b=ieqF1t16orYFrZKjuAWiEuDuIKFDuWZRbL8g6gnbuNJwip1RaWBhxHKVbVoMstuog4
         PAcHHr7Iuu5IuWyBuJwkIH3l3bl46jrcP+hQi4Okk87rt5jbIRIULNLPpaReAWBZpWjB
         31C9UzWWNyk5ybeIUbZraEv6o3TuwNQHwuM7jjAY1oHKCWQnl7n10CmOq+3w8CPkExt0
         Y+YQo4as8T1wFhm5Zi0qdKExvSCRZg19juo+5Eisaq9waAjGkSnH/RlVHLSrE0wuf/8T
         a8WSmg9ZOFGZrcoijCVblXWJsxi3+779ReRtBxuVfvJdAMFDpAEyqJssyFedCy2w0vAF
         39Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUfqc8oBAoMQDxLQkeVLfOk9R/gn2cENGzYaYvhmLlwydgg4mEVd8xndjGhhj6FLqV5leGjmX5YXVNyxVk=@vger.kernel.org, AJvYcCVGc4mJwcZe7FM08NA4QeLQbdLS3/EFHlQrl21ZxXpCPpChxOR7sn1nWnJBO6MdPPUz/YPFUWAy013F2oyETlwkTD+q@vger.kernel.org, AJvYcCXmCfJi4A4bI8mtmP7uQhLZGE/0Lbh3Ca5UVEv0joYqNNZ6XXSn7uER+EnMy/eX4leOhazz67xoSXrggxeg69eqeQ==@vger.kernel.org, AJvYcCXn3UmUHzDOXxSJo85r2jwn894UrPYh4whHXsjbhFLlZUUTkz2RqnX/8ujbF7KyyuROmzAdUikDAo0ANtdeiagkvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaO/a6oDUNtP1vmZdqn1pfVWE6T+VKiei0dy9oFdt3ENgcL51z
	nhlBqeJw/m/p3GhSrXidh7B9dSXQnq3ZJ9v5HWRTU5RABpDhrB37fKPEiRw/Iuaw1JtMVuHnogY
	V54QuJQIDcgi6Ze6XDGRZy2A+gjQ=
X-Gm-Gg: ASbGncs7fWWtZ6YxRtInrQZK09zs26FW9/phJyP6bc0LDFBiBrN3ILLqxlWAmx84qjw
	JyttvDz+oJ0UBw9wIk+j1r0pkhO7UT+P0ZT8bLU0K+3SUWSkcdnRKqrWlJhwBKEPp713i6oL19P
	jChA==
X-Google-Smtp-Source: AGHT+IGMGScTckapwKdk9LPwqjxALnV4IVF8Ypu36jP32RvPs/EkkwVSrK0Ftx+Zt769/yk0iq1mNHKhBc9zr50xl6M=
X-Received: by 2002:a05:6a00:17a3:b0:725:90f9:daf9 with SMTP id
 d2e1a72fcca58-72dafa7c0c9mr40618378b3a.15.1737741582520; Fri, 24 Jan 2025
 09:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <cd54347d26967427bc831f473d76e424ba3eba95.1737511963.git.jpoimboe@kernel.org>
In-Reply-To: <cd54347d26967427bc831f473d76e424ba3eba95.1737511963.git.jpoimboe@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 09:59:28 -0800
X-Gm-Features: AWEUYZmb7i0VJt00azGUaAV70-NR2FHe0BxsqnnVpZ7ss3EDS1pJXbo4-7y8p28
Message-ID: <CAEf4BzbG3C5=8bB0DKrVdMHDxADbZxnAwku46QAqt8qLW6ngOA@mail.gmail.com>
Subject: Re: [PATCH v4 11/39] unwind_user: Add user space unwinding API
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:32=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Introduce a generic API for unwinding user stacks.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/Kconfig                      |  3 ++
>  include/linux/unwind_user.h       | 15 ++++++++
>  include/linux/unwind_user_types.h | 31 ++++++++++++++++
>  kernel/Makefile                   |  1 +
>  kernel/unwind/Makefile            |  1 +
>  kernel/unwind/user.c              | 59 +++++++++++++++++++++++++++++++
>  6 files changed, 110 insertions(+)
>  create mode 100644 include/linux/unwind_user.h
>  create mode 100644 include/linux/unwind_user_types.h
>  create mode 100644 kernel/unwind/Makefile
>  create mode 100644 kernel/unwind/user.c
>

[...]

> --- /dev/null
> +++ b/kernel/unwind/user.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> +* Generic interfaces for unwinding user space
> +*/
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
> +#include <linux/unwind_user.h>
> +
> +int unwind_user_next(struct unwind_user_state *state)
> +{
> +       struct unwind_user_frame _frame;
> +       struct unwind_user_frame *frame =3D &_frame;
> +       unsigned long cfa =3D 0, fp, ra =3D 0;

wouldn't all the above generate compilation warnings about unused
variables, potentially breaking bisection?

> +
> +       /* no implementation yet */
> +       -EINVAL;

return missing?

> +}

[...]
