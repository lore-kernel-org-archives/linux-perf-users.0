Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862E1AA783;
	Fri, 24 Jan 2025 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737741592; cv=none; b=FHPSilI0ZK7RC9HpQRD3ISQG0G3XAsCLV208c/BDXNXIYwgXFT+Nd+2tWV/26+TQhwAFX0+vOeR8lxqMh3OzDn12BxhzGokk5b8GVCWYAziHRoxlYkXnb4ATCTXzuMCJVP8SeVhZaVBWPzxmsjA3U8ejyNZwxXPrrXA8vl3Hm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737741592; c=relaxed/simple;
	bh=fE1ezwRyOO8zloPjA6YZiK614cbMF88TOz1WWKa7beQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2Hp/B2zz3GKE3sUMbZYOLZ+Z1cNkZ1I62P66Sam94yt7T4LO368B4thzdEM0V9W2mbRlv4K10Wtfuane66S5eydFNZx3fUrRm/D3PGwaDAlWtVj1iJoTWxY4z2/Kzke1Vni0Sj5by4kD2/qxV1po5K3Q3jURIt18EstbO5rLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjexpxpA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjexpxpA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165cb60719so43214275ad.0;
        Fri, 24 Jan 2025 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737741590; x=1738346390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxwPX+AIkxhIAp91WnKfR9e4p2dTDXnOb6tEY8/qdHw=;
        b=JjexpxpAKFp+iGFZxUmgZD/h0xUzQOtDcyWSUnKho4cCgCFCogluJoPJ1sqhERSdVV
         D8+kT7T85HFLPPaVVz7lar1FK0Ky6wNpsvSeR5E3q9KjkLL9Wo8I1S+ZQEXAbDEczzI8
         UoafH/RPtFQYVBPr+Z8jJaK/661Q1G//1w2Z7B0JNg4UetphX0z/bVtk84kYpU+l62l3
         Izwo6u9/vZiISf91GfCp/crUGHmjee/MpjXqnvIWmLR56dSMsYf+9LcKC7VatZ+9Zi7t
         FF6dlVlWNM7BYVPdJJdJEGxFZGNRPdIJrGVBi/3jhVdWjZvX8B4/1Z2c5GB2wdvTQdKW
         hJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737741590; x=1738346390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxwPX+AIkxhIAp91WnKfR9e4p2dTDXnOb6tEY8/qdHw=;
        b=thtQxwdQ+NsnugsXEOVjIlqGLZbXK8Jt7VRu0LyKXqOmdR8N0TPTI9ucniB72ZdcSN
         QkR4UzjcEdtwQWOdPQ1dDOeai4k4CKX/ofoYTJBgdzM/Dki6pi82CGDDNJ8rIyKwx9/Q
         taJAdbxO9sDKVR+u2j6ik8F0RqWHWvz3W0GgZVk5avXMXrbZ8xkXs4Q68UmBSpYdEyQS
         nNIJDysS73aBE09aJxMoyjInsVLL5VgBAyg8vn7x/Z7ufPXq076IviK3VH1k72PEUdbX
         xM7hDXx/Tr45LCEI8vEdBP0HBcb6bZkp84eM4EgTbJIQFwNjx4IuRsK6E4SjqvCMeA6k
         LgwA==
X-Forwarded-Encrypted: i=1; AJvYcCW5QbcN0I01zdCJsn12ML5dqQkwygivraBxE7KZ/fxmJBQ0Zrum+ZcqPNe0cRyrw+kGbPeeMyVKwEBdkAguhZ/7Bw==@vger.kernel.org, AJvYcCWjCLyQB+otCjmBySTo/JFs0sWK6xzOFE5Hie9XcgaioBYoxxwaz6/MvagLQ/KGBy4g8WadeXFOYm6vColHZdAjmAza@vger.kernel.org, AJvYcCWzuK9HY30d++fYu3YsbRUPkcWclKTXi5YpVE6Pq9OgQwIntJybkWrnTFa2J7zYev7ky+G0BdVQ1BLBzSB42e47lw==@vger.kernel.org, AJvYcCXekmmLSa1CjnAH4rsg0CyQxL9PylRqCUsBoelybG1hKarK2W8FTzArZT+uC04iuDZuxxIfCtbu+FbLdhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3AYvWaGgINL8xcqm0sWyjbH1ys7kqsTdpTW/DNv0ejtI9hD0R
	wDKIqj7CFCq6P/r+RyOOJxyGrwFhAiGmv5RqDA5TvkQORNPnP75RddR9A3upp1wolQBwToD6dvQ
	OeDGn28ziueInkDmaRicE9gUgUfY=
X-Gm-Gg: ASbGncviz4PjsaSXzlSDagHOQbc/CZIBDjLnOczbRbRKx0az1a8nu+sW9VNOwC3KM78
	D7CLiGxOPVJkUfCZqE9+4ZzykhTnFbD2MiT58HDCMKvBMCTwli02iSvZXpeSO5llmFxHySeM6ot
	QO5w==
X-Google-Smtp-Source: AGHT+IFAgC0nFQZWXbC7zCRVk1ElOzm2+Nzsm1y/hFbtMngNwkfjzX0Y5y4UT/VAodvRV2ClbdlAYZXngLfhrUQeiGg=
X-Received: by 2002:a05:6a00:6c99:b0:725:f097:ed21 with SMTP id
 d2e1a72fcca58-72dafb55a4dmr40545987b3a.15.1737741589765; Fri, 24 Jan 2025
 09:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <10b92f2fd065b67e6e3fd473ca145c34ea74b73a.1737511963.git.jpoimboe@kernel.org>
In-Reply-To: <10b92f2fd065b67e6e3fd473ca145c34ea74b73a.1737511963.git.jpoimboe@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 24 Jan 2025 09:59:37 -0800
X-Gm-Features: AWEUYZmhD9HKSgHLG_jTkfvr4UGLLxL1-4bQ50IoelJ2bbXy3o36re7ErBepFbw
Message-ID: <CAEf4BzaQr1ruCh1beyhJ_i+aGuw4rGSftF_Zr5ZB=8Jim1jyyQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/39] unwind_user: Add frame pointer support
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
> Add optional support for user space frame pointer unwinding.  If
> supported, the arch needs to enable CONFIG_HAVE_UNWIND_USER_FP and
> define ARCH_INIT_USER_FP_FRAME.
>
> By encoding the frame offsets in struct unwind_user_frame, much of this
> code can also be reused for future unwinder implementations like sframe.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/Kconfig                      |  4 +++
>  include/asm-generic/unwind_user.h |  9 ++++++
>  include/linux/unwind_user_types.h |  1 +
>  kernel/unwind/user.c              | 49 +++++++++++++++++++++++++++++--
>  4 files changed, 60 insertions(+), 3 deletions(-)
>  create mode 100644 include/asm-generic/unwind_user.h
>

Do you plan to reuse this logic for stack unwinding done by perf
subsystem in perf_callchain_user()? See is_uprobe_at_func_entry()
parts and also fixup_uretprobe_trampoline_entries() for some of the
quirks that have to be taken into account when doing frame
pointer-based unwinding. It would be great not to lose those in this
new reimplementation.

Not sure what's the best way to avoid duplicating the logic, but I
thought I'd bring that up.

> diff --git a/arch/Kconfig b/arch/Kconfig
> index c6fa2b3ecbc6..cf996cbb8142 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -438,6 +438,10 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
>  config UNWIND_USER
>         bool
>
> +config HAVE_UNWIND_USER_FP
> +       bool
> +       select UNWIND_USER
> +
>  config AS_SFRAME
>         def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_e=
ndproc)
>

[...]
