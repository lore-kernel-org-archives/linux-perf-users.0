Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4320C015;
	Tue, 29 Oct 2024 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244781; cv=none; b=KOIltwgbWGOOewwD5F4csrhH3bwv2GdxXflfLUsYuZirToVD7kAJs4P+UL2cpUGmJyEJ2BPgTRBoR2U/e5OOYFDYrkmvoAzBDT44kl6knjqVUKxMv4L9UVgdYm93DxI2qgy4pQRjjrMk/b+SXj+sMkN/BvAc4OA4xDEr9JJylT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244781; c=relaxed/simple;
	bh=GyGKur8b8q4WFJWryFjCu/g5l9pGr1nbquMu4t676mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLBPZ9WnO51XH9Bp5qg1u4NdI/36L173IxBaUs5GQsURW4RpWdzgLlS3lm8GJwew7WjSPzH0mdacKXLdPlhW+OSX8AoyqlQE56sb9P6MlFukhpZEfNAFRviMXDmezjpyQfk2kqBkEaOSpsx+efzOrQoZMC/WPxKY+2QY7+at+Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3HrTm7O; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3HrTm7O"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so5091675a12.0;
        Tue, 29 Oct 2024 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730244779; x=1730849579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgziuG7baBWSEjlfcpuNQK44g3chFIpLTSbQOS6qTBo=;
        b=b3HrTm7OikoQoeMW++InH17POmyxAQSfEZZykcf94g2GX5N6BowcF9E1EVESHD+9yx
         c9M8NDCp4pq0dNtmCMNzBi7tFXhbeLn5R+f3LIuZSWc+2iKnEJxpotGrf2CBTP+OabAB
         930KEqOyhpo1McDPWWi3I+nBqnGf8fiyw4/Ove84j4E1xWW37BgFL3iLuqVHdgI0x/e/
         J4U+vUrQIq7slYbwuzBDbX2xEtryCxTzNvbKFl8WZ41xqKKBbnQ7sVJnX2CMqUnISwCA
         zVOkEJd+M80OeZPPE5Eo5AXK6/4sE3OL0gx7ExRluvGaHgUiujQec2kDkV4519R6H2KL
         oOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730244779; x=1730849579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgziuG7baBWSEjlfcpuNQK44g3chFIpLTSbQOS6qTBo=;
        b=ga7DdrbT9MhnZdAEHUsvRvgeoBEN6OJpr8D9iqVE4T+Ij6kmxc3HHlc7FofI5LLmo6
         x1R92Z/MNW1W7N4Y1uxfXs+MHUfp0JrdcgUHTHsXZseoOicG5CBkfKnMW3d+GfPQZQcf
         uw44Psk2Tv6oOYceqmoGujAxVrbeuBg34EdVFG3yytvGdnJDB4pRAmjdkx5M7foV9kzd
         JuVKm9A5Z9M/CRngTdkNIGjSkARW17NotDeCQgEj8l6cWiUAIoXqd+fvQfQ6Lhhia1xr
         pUeSJYObQo0cDaIFmT71jPq/+KkO+1PLpWrJQMS0zMY7XdxDgbkwUjFHLYgvRS2UjFQj
         PvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQMaLC6SjiOGABD0JspxsMUk6Cp27LwGQyZyQXholtehlvlRKoizhC/hEWKw24yScZHwsCM1poyB1ECZ8=@vger.kernel.org, AJvYcCX/3vdtzc8YvGLlIWNa68Vh87StwciS4G/bEE2MpuZq7ZuIKfW76NhE7r5T7VAobt6i4A0ycKOqkmKQrXVeM1a/oQ==@vger.kernel.org, AJvYcCXl3LJNukpgd7dIAv8NhvYkX2oeILQSMSZ6DQVKlVN9KtC/HtNI3WLl5JxNZ8QfjPFsrXtaX+22zQMYWedQ6CwwqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfwTtZUvSrqAMnZkw7b8ZTB5uR5gKB/YznU3jxZd/t3RSqah+
	WEi/JyszpIcPk1tpqISuNX1VpATaufcuccMsjezzUYWmJZzQIM/L8VduPumsMeKjk1GvvZamg8m
	5sQVSn4TYB8c4ghUt1bBW6h/NCyI=
X-Google-Smtp-Source: AGHT+IFIAo8I9zZos8vgSzifW1W6EbHmbURlqCr7tc6ZZ2M35TgYjInsEnhWE9maJ9UWMnG1cJQk0n3agDvpVNNwB1g=
X-Received: by 2002:a17:90a:4e0f:b0:2cb:5aaf:c12e with SMTP id
 98e67ed59e1d1-2e8f11bf86fmr15194588a91.37.1730244778788; Tue, 29 Oct 2024
 16:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
In-Reply-To: <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Oct 2024 16:32:46 -0700
Message-ID: <CAEf4BzY3xJ=W2qPD8i6UbSB=zNqpiA1gSd+SC3wKxQAJWjeHhA@mail.gmail.com>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 2:48=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> Add unwind_user_deferred() which allows callers to schedule task work to
> unwind the user space stack before returning to user space.  This solves
> several problems for its callers:
>
>   - Ensure the unwind happens in task context even if the caller may
>     running in interrupt context.
>
>   - Only do the unwind once, even if called multiple times either by the
>     same caller or multiple callers.
>
>   - Create a "context context" cookie which allows trace post-processing
>     to correlate kernel unwinds/traces with the user unwind.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  include/linux/entry-common.h |   3 +
>  include/linux/sched.h        |   5 +
>  include/linux/unwind_user.h  |  56 ++++++++++
>  kernel/fork.c                |   4 +
>  kernel/unwind/user.c         | 199 +++++++++++++++++++++++++++++++++++
>  5 files changed, 267 insertions(+)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 1e50cdb83ae5..efbe8f964f31 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -12,6 +12,7 @@
>  #include <linux/resume_user_mode.h>
>  #include <linux/tick.h>
>  #include <linux/kmsan.h>
> +#include <linux/unwind_user.h>
>
>  #include <asm/entry-common.h>
>
> @@ -111,6 +112,8 @@ static __always_inline void enter_from_user_mode(stru=
ct pt_regs *regs)
>         CT_WARN_ON(__ct_state() !=3D CT_STATE_USER);
>         user_exit_irqoff();
>
> +       unwind_enter_from_user_mode();
> +
>         instrumentation_begin();
>         kmsan_unpoison_entry_regs(regs);
>         trace_hardirqs_off_finish();
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5007a8e2d640..31b6f1d763ef 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -47,6 +47,7 @@
>  #include <linux/livepatch_sched.h>
>  #include <linux/uidgid_types.h>
>  #include <asm/kmap_size.h>
> +#include <linux/unwind_user.h>
>
>  /* task_struct member predeclarations (sorted alphabetically): */
>  struct audit_context;
> @@ -1592,6 +1593,10 @@ struct task_struct {
>         struct user_event_mm            *user_event_mm;
>  #endif
>
> +#ifdef CONFIG_UNWIND_USER
> +       struct unwind_task_info         unwind_task_info;

this is quite a lot of memory to pay on each task, a lot of which a)
might not have sframe and b) might not need stack unwinding during
their lifetime.

It can be a pointer and allocated in copy_process(), no? Though
ideally this should be initialized lazily, if possible.

> +#endif
> +
>         /*
>          * New fields for task_struct should be added above here, so that
>          * they are included in the randomized portion of task_struct.

[...]

> +static void unwind_user_task_work(struct callback_head *head)
> +{
> +       struct unwind_task_info *info =3D container_of(head, struct unwin=
d_task_info, work);
> +       struct task_struct *task =3D container_of(info, struct task_struc=
t, unwind_task_info);
> +       void *privs[UNWIND_MAX_CALLBACKS];
> +       struct unwind_stacktrace trace;
> +       unsigned long pending;
> +       u64 cookie =3D 0;
> +       int i;
> +
> +       BUILD_BUG_ON(UNWIND_MAX_CALLBACKS > 32);
> +
> +       if (WARN_ON_ONCE(task !=3D current))
> +               return;
> +
> +       if (WARN_ON_ONCE(!info->ctx_cookie || !info->pending_callbacks))
> +               return;
> +
> +       scoped_guard(irqsave) {
> +               pending =3D info->pending_callbacks;
> +               cookie =3D info->ctx_cookie;
> +
> +               info->pending_callbacks =3D 0;
> +               info->ctx_cookie =3D 0;
> +               memcpy(privs, info->privs, sizeof(void *) * UNWIND_MAX_CA=
LLBACKS);
> +       }
> +
> +       if (!info->entries) {
> +               info->entries =3D kmalloc(UNWIND_MAX_ENTRIES * sizeof(lon=
g),
> +                                       GFP_KERNEL);
> +               if (!info->entries)
> +                       return;

uhm... can we notify callbacks that stack capture failed? otherwise
we'd need some extra timeouts and other complications if we are
*waiting* for this callback to be called

> +       }
> +
> +       trace.entries =3D info->entries;
> +       trace.nr =3D 0;
> +       unwind_user(&trace, UNWIND_MAX_ENTRIES);
> +

[...]
