Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1664E50A8
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168465; cv=pass; b=GEyfGpebYzrGivPUdIkMn9VTnJnQd7WKTvbz3VEUJ8ynpjS2iVZ1SLJHaB4hPcI33HlL/ncWi7Sld3qNoX8NuiKG2x4EGJjQZ78/eKeQAEP5ENp+Cch73RJ0uAldsC4XPX7r9RLDIm7KC+FGd5OXzBVsbCa3QlsCuUDNSQ72dss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168465; c=relaxed/simple;
	bh=1ukW2FLyDYlYQayz7uFmFhwg9NNaEzv3usyAgt/eaFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBU6Mel8RYVbiWW6Uvci7l10ai0iWOLrrESr01QDXcqMhlRT93VuxH/LcgB3m+SHXgoGOvZThXhMbnN9heeF3W3Kq95AqEHHSWhMLUYWeUzQCss6gkGrJz8TWdJRyhOyqDpiGbQLmi1eG3aQDqqE/X4GCqc6PPnKbb8ZMCrw4HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQAapHxm; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQAapHxm"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-535f598d126so316761cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 09:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792168461; cv=none;
        d=google.com; s=arc-20260327;
        b=W36I9Tb1q5y5bI/rXMQhYFGuBAf5hvikovLqKZrU3HXGbzNtFJgkqwRcajRHJaNVs+
         uyjukAjrK0ZdOqWhJKJRTdeh/+cbGZjaFiEQXxt+2yUvUADxvSCs9kmwJZj7Qb1GcEQ+
         BGbl8hY45UTJmINMnBe3cQpqXG2Wn43MdzngMoQHcDTxnQUSG+gF0QRLwGVArrF/hPgZ
         tkKCjh3C22XdYukg0gaiQMEH0++XlFxx5rmRnRcaXeXNKeZTNT91PxF9pQILlG9kkJUJ
         tvS8Qr8d/wji5FTQ99iDH1WrKIMRtCOojNuZQ4+Z3TfIKL0I941rBg70PV5Bxh/9RLA0
         FsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i0tzJX0pJVmFdRGe0TaVH7H1bZ1DeRR1tdfQmZKdn+g=;
        fh=8Dlt8WJU0EsB5B7OON5AWWA5Qk2zOWob+WZqh9RUG1Q=;
        b=cSYgIa4+1ER6onGNEIRNZSNEO5aNmXc0jvQ7hHC2s0IZKZOnt2vPqNDf6hVZygzM3R
         jNNaz/5nEN1iIRPolEU0A3AiaKR5jrjKSwdHusGdoYZYpl48kLoYPUM85mzALsqmfcXi
         TwCKIJI2hAJ+GD+kD5O3aqWpvTeBdRYRsMPuhXX4CDsy1r3RfwBnCvxvS1OzP+25P74f
         viofrM70UZc5rBP7QNqhAw0SjWPXZoUw5GX7AFQOqY+22G0V0f1i62XIs4mMT//sK3Qi
         oH/+dnIHfrXY7h8nA3/VbvxYTlHYpXUemlLEVwgiruAHNJMSFgfwBC3X3hy+ZRUOu7LV
         FzlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792168461; x=1792773261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0tzJX0pJVmFdRGe0TaVH7H1bZ1DeRR1tdfQmZKdn+g=;
        b=AQAapHxmd/tcNUsTeNuEaT7HvskTkTUhOGgG+GdEUSSAhkYa6RcAFfu3K7N51Z6kAp
         FE90d3uUIz4mlkX9ozcKXnU5U7CNg/a8f4AqszYs5IsTdaxvx+TMsbDC/FxS3SRG3FTx
         R0wyGElQoE8R2nr8eT1AaU3X0Rch5EDmpTWvHBexKP0JSNYk1hUlVAY95j1qL10kMz4R
         aRIqyS76GBmhBLuVw8zwr4tiRXQ2wLMCAud6lCaXRsTGYVI6K5E0DcxZ6XyYuc65DXrp
         HCapI45SVKiDt/7eoVHffBMbSL3qqqo6/CzMW/OZM9tF2X3bbSqxUQ+mzU6dlKpb1sJe
         c32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168461; x=1792773261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0tzJX0pJVmFdRGe0TaVH7H1bZ1DeRR1tdfQmZKdn+g=;
        b=IGvC01pN1+5dq2/fJwfx8ZQQr8Jp5P2U3u0FWx3oR/x8kjuXverb0ueeyj9J2gjk3a
         0S8tCoeckfWzv018urT6L1WJHEPQwwa9ybwYf7o96nf3i/5fClbKmEM78H+j2waRgCIQ
         nTfJc83mHC0FCb6c6sH0qUwXFKG1yJjK04/ZyvWRdBzAqICXVJAtfdtf/Jug8WJbfQkD
         YPcirlW5gI11W1j+KRONwlcLLw9sWlvTxAFqWxGGOyoMpCzvDwi34IxRvMIq4E5jzyz/
         g0RKGrrXLAUz+XSeAJhq64KCocf6lIqepSlKIHU92MYd9JdwXrOk875Teqg1TKlkIElo
         QIsw==
X-Forwarded-Encrypted: i=1; AKwUvBx6Zaizx/VcVNHQ2C/psJLjSXdeapHCGtPOOcN+BL4vvJa3FTq2lzfYWGFdkDpVbCSekp1cxBLSPHSEqVFd3OSN@vger.kernel.org
X-Gm-Message-State: AFq9FYKa6UKc5ngZO/nZnIMt0aluMilT5xQZRSRReVAM+uUJCTvVaDQ2
	QxNOh5zFlha8xhWRm0GtNPYHmdHut7X/jHJ9Rrf2CT17w7wlkijLKoDUptKhaOcn+I2FCVtV7gw
	qte9quEylwq02/VV08mjstoNfzPgMsldxjKZUGZIqYo90iUQUAjVvorK7
X-Gm-Gg: AYBFou2iFvHdxzNop1RUT7Cs3c0BCw0Zn3CKjDTLb/N0RlhFSxAGullKXPDvHGz4eEI
	Mi5QSmnHCmIAab2hIXclS47uBgfoPM1Wqoh0gSthfDUpF9rtqrS8nhoWsodnLq9K+P0SOll623Y
	Gpryy6l/nl4WNnKplpSpVSsrrdl8pYkGbo6E0HZ2oPqccm2B3J/L5D3VrNYfA080kexCyyq2PkK
	SB9vARAmYEUnqZUqneLQlN9ewQF1wc2GjC/DIU4bg6QVAHcr5grLbp7g59wnq0WerjzRxlgbRai
	k3lpSVI5z0C4zmgeBcJkHQj4N+Yt9WZxJ3C23Wpyy7QW9MjWPXTqlRVlcoo5yTbWrANO2LUMqH4
	+NrhzjqWXtw==
X-Received: by 2002:a05:622a:1648:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-5362b40cdc6mr19300011cf.11.1792168459420; Fri, 16 Oct 2026
 09:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016040310.482876-1-atomlin@atomlin.com> <20261016040310.482876-4-atomlin@atomlin.com>
In-Reply-To: <20261016040310.482876-4-atomlin@atomlin.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Oct 2026 09:34:07 -0700
X-Gm-Features: AclHuK8_oAeRwWzEylCE7cN4yRjf74HQqXFicGPzYL3fOTGFxNrntvpPgoeEToA
Message-ID: <CAP-5=fVcd0KRWFtfTj2BS=A7m-V_EsxmDRGca41qiT7H1B8zgw@mail.gmail.com>
Subject: Re: [PATCH perf-tools-next v6 3/5] perf ftrace: Support display of
 inlined functions in function graph tracer
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 9:03=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> The Linux kernel's function graph tracer operates at the machine
> instruction level via compiler instrumentation
> (-fpatchable-function-entry), recording entry and return events for
> physical function calls. Consequently, functions inlined by the compiler
> are invisible in the resulting call graph, as no discrete call or return
> instructions are emitted for them. While technically expected, this
> omission frequently obscures the logical execution flow when analysing
> kernel subsystems heavily reliant upon inlining.
>
> Address this by introducing the --inline option to perf ftrace for the
> function_graph tracer.
>
> When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=3Dy, the
> funcgraph-retaddr trace option records the caller's return address on
> each function entry, manifested in the trace stream as a comment
> (e.g. /* <-irq_work_queue_on+0x81/0xa0 */). By interrogating DWARF debug
> information from the kernel image (vmlinux) utilising libdw, perf ftrace
> resolves this return address to its inlined callchain and synthesises the
> intermediate inlined frames directly into the streamed call graph.
>
> Key aspects of this implementation:
>
>     1.  Inlined frame presentation
>
>         Synthesised inlined functions are rendered with an explicit
>         /* (inline) */ annotation at both entry and exit:
>
>             # CPU  DURATION                  FUNCTION CALLS
>             # |     |   |                     |   |   |   |
>              0)               |  wake_up_new_task() {
>              0)               |    activate_task() { /* (inline) */
>              0)   1.234 us    |      enqueue_task();
>              0)               |    } /* activate_task (inline) */
>              0)   2.567 us    |  }
>
>         This affords immediate visual clarity to the reader upon
>         entering an inlined scope, without necessitating a search for
>         the closing delimiter.
>
>     2.  Call graph reconstruction and dynamic stack tracking
>
>         Maintains a per-CPU stack tracking real and inlined frames,
>         synthesising entry and exit delimiters to accurately reconstruct
>         the execution hierarchy. Inlined frames are structured strictly
>         root-to-leaf and validated against the active stack to prevent
>         un-traced callers from attaching orphan inlines. Bare closing
>         braces without trailing function names (the default when
>         funcgraph-tail is disabled) are correctly matched against
>         preceding frames on the stack. Context column alignment, includin=
g
>         task comm-pid delimiters in verbose mode, is preserved when
>         generating prefixes for synthesised inline frames. Furthermore,
>         stack depth saturation guards ensure that inlined frame depth
>         tracking remains clamped and indentation cannot drift even under
>         deep call trees exceeding FTRACE_MAX_STACK.
>
>     3.  Option handling and diagnostics
>
>         Adds -k or --vmlinux to designate an explicit debug image, and
>         provides clear diagnostic guidance should --inline be invoked on
>         a kernel lacking CONFIG_FUNCTION_GRAPH_RETADDR. Automatically
>         enables return address comment filtering unless explicitly
>         requested.
>
>     4.  Automated verification
>
>         Expands the unit test suite in tools/perf/tests/ftrace.c to
>         validate DWARF inline symbol resolution, comment filtering
>         toggles, bare closing braces handling, and stack saturation
>         recovery.
>
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/Documentation/perf-ftrace.txt |  17 +-
>  tools/perf/builtin-ftrace.c              |  58 +-
>  tools/perf/tests/ftrace.c                | 384 ++++++++++++-
>  tools/perf/util/ftrace.c                 | 650 ++++++++++++++++++++++-
>  tools/perf/util/ftrace.h                 |  11 +
>  5 files changed, 1102 insertions(+), 18 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Docume=
ntation/perf-ftrace.txt
> index e8105083e67c..445c8ccc22d2 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -134,9 +134,24 @@ OPTIONS for 'perf ftrace trace'
>           - depth=3D<n>    - Set max depth for function graph tracer to f=
ollow.
>           - tail         - Print function name at the end.
>
> +--inline::
> +       Show inlined functions in function_graph tracer. This requires
> +       kernel support for the funcgraph-retaddr option and a vmlinux wit=
h
> +       debug symbols. Inlined functions are displayed in the call graph
> +       hierarchy, and their inlined status is indicated with `/* (inline=
) */`
> +       on entry and exit, e.g. `func() { /* (inline) */` and `} /* func =
(inline) */`.
> +       By default, raw return address comments (`/* <-caller+offset */`)
> +       are hidden in the output; specify `--graph-opts retaddr` to show =
them.
> +
>  --filter-retaddr::
>         Filter out function return address comments (`/* <-caller+offset =
*/`)
> -       from function_graph output.
> +       from function_graph output. This is enabled by default when `--in=
line`
> +       is used; use `--no-filter-retaddr` to disable it.
> +
> +-k::
> +--vmlinux=3D::
> +       Path to the vmlinux file containing debug symbols for resolving
> +       inlined functions.
>
>
>  OPTIONS for 'perf ftrace latency'
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index c715cbebaabe..cdacf5af14a6 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -575,9 +575,14 @@ static int set_tracing_funcgraph_retval(struct perf_=
ftrace *ftrace)
>
>  static int set_tracing_funcgraph_retaddr(struct perf_ftrace *ftrace)
>  {
> -       if (ftrace->graph_retaddr) {
> -               if (write_tracing_option_file("funcgraph-retaddr", "1") <=
 0)
> +       if (ftrace->graph_retaddr || ftrace->use_inline) {
> +               if (write_tracing_option_file("funcgraph-retaddr", "1") <=
 0) {
> +                       if (ftrace->use_inline) {
> +                               pr_err("failed to set funcgraph-retaddr o=
ption in tracing\n");
> +                               pr_err("Hint: ensure kernel is compiled w=
ith CONFIG_FUNCTION_GRAPH_RETADDR=3Dy\n");
> +                       }
>                         return -1;
> +               }
>         }
>
>         return 0;
> @@ -770,6 +775,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>                 goto out_reset;
>         }
>
> +       if (perf_ftrace__setup_inlines(ftrace) < 0)
> +               goto out_reset;
> +
>         setup_pager();
>
>         buf =3D malloc(TRACE_BUF_SIZE);
> @@ -837,9 +845,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>                                 break;
>                         for (int i =3D 0; i < n; i++) {
>                                 if (buf[i] =3D=3D '\n') {
> -                                       if (ftrace->filter_retaddr)
> -                                               ftrace_filter_retaddr(lin=
ebuf.buf);
> -                                       if (fprintf(stdout, "%s\n", lineb=
uf.buf) < 0)
> +                                       if (ftrace_process_fgraph_line(ft=
race,
> +                                                                      li=
nebuf.buf,
> +                                                                      st=
dout) < 0)
> +                                               goto out_close_fd;
> +                                       if (ferror(stdout))
>                                                 break;
>                                         strbuf_setlen(&linebuf, 0);
>                                 } else {
> @@ -876,9 +886,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>                         break;
>                 for (int i =3D 0; i < n; i++) {
>                         if (buf[i] =3D=3D '\n') {
> -                               if (ftrace->filter_retaddr)
> -                                       ftrace_filter_retaddr(linebuf.buf=
);
> -                               if (fprintf(stdout, "%s\n", linebuf.buf) =
< 0)
> +                               if (ftrace_process_fgraph_line(ftrace,
> +                                                              linebuf.bu=
f,
> +                                                              stdout) < =
0)
> +                                       goto out_close_fd;
> +                               if (ferror(stdout))
>                                         break;
>                                 strbuf_setlen(&linebuf, 0);
>                         } else {
> @@ -889,9 +901,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>         }
>
>         if (!ferror(stdout) && linebuf.len > 0) {
> -               if (ftrace->filter_retaddr)
> -                       ftrace_filter_retaddr(linebuf.buf);
> -               fprintf(stdout, "%s\n", linebuf.buf);
> +               if (ftrace_process_fgraph_line(ftrace, linebuf.buf,
> +                                              stdout) < 0)
> +                       goto out_close_fd;
>                 strbuf_setlen(&linebuf, 0);
>         }
>
> @@ -901,6 +913,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
>         free(buf);
>         strbuf_release(&linebuf);
>  out_reset:
> +       perf_ftrace__cleanup_inlines(ftrace);
>         exit_tracing_instance();
>  out:
>         return (done && !workload_exec_errno) ? 0 : -1;
> @@ -1856,8 +1869,13 @@ int cmd_ftrace(int argc, const char **argv)
>                      "Size of per cpu buffer, needs to use a B, K, M or G=
 suffix.", parse_buffer_size),
>         OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
>                     "Trace children processes"),
> -       OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr, &ftr=
ace.filter_retaddr_set,
> -                       "Filter out funcgraph return address comments"),
> +       OPT_BOOLEAN(0, "inline", &ftrace.use_inline,
> +                   "Show inlined functions in function_graph tracer"),
> +       OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr,
> +                       &ftrace.filter_retaddr_set,
> +                       "Filter out funcgraph return address comments (de=
fault with --inline)"),
> +       OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name, "file",
> +                  "vmlinux pathname"),
>         OPT_INTEGER('D', "delay", &ftrace.target.initial_delay,
>                     "Number of milliseconds to wait before starting traci=
ng after program start"),
>         OPT_PARENT(common_options),
> @@ -1973,6 +1991,20 @@ int cmd_ftrace(int argc, const char **argv)
>
>         switch (subcmd) {
>         case PERF_FTRACE_TRACE:
> +               if (ftrace.use_inline) {
> +                       if (ftrace.tracer && strcmp(ftrace.tracer, "funct=
ion_graph") !=3D 0) {
> +                               pr_err("Error: --inline option is only su=
pported with function_graph tracer\n");
> +                               ret =3D -EINVAL;
> +                               goto out_delete_filters;
> +                       }
> +                       ftrace.tracer =3D "function_graph";
> +               }
> +               if (!ftrace.filter_retaddr_set) {
> +                       if (ftrace.use_inline && !ftrace.graph_retaddr)
> +                               ftrace.filter_retaddr =3D true;
> +                       else
> +                               ftrace.filter_retaddr =3D false;
> +               }
>                 cmd_func =3D __cmd_ftrace;
>                 break;
>         case PERF_FTRACE_LATENCY:
> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> index 596cecee844e..ece7f4b73f44 100644
> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c
> @@ -7,6 +7,10 @@
>  #include <unistd.h>
>  #include "tests.h"
>  #include "debug.h"
> +#include "dso.h"
> +#include "machine.h"
> +#include "map.h"
> +#include "symbol.h"
>  #include "util/ftrace.h"
>
>  static int test_parse_retaddr(void)
> @@ -62,6 +66,372 @@ static int test_filter_retaddr(void)
>         return TEST_OK;
>  }
>
> +#define TEST_CHECK(text, cond)                                 \
> +do {                                                           \
> +       if (!(cond)) {                                          \
> +               pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); =
\
> +               ret =3D TEST_FAIL;                                \
> +               goto out_cleanup;                               \
> +       }                                                       \
> +} while (0)
> +
> +static int test_inline_processing(void)
> +{
> +       static const char line_entry[] =3D " 0)               |  wake_up_=
new_task() {";
> +       static const char line_enqueue[] =3D
> +               " 0)               |    enqueue_task() { /* <-wake_up_new=
_task+0x1d1/0x3e0 */";
> +       static const char line_exit_enqueue[] =3D " 0) + 10.000 us   |   =
 } /* enqueue_task */";
> +       static const char line_exit_task[] =3D " 0) + 20.000 us   |  } /*=
 wake_up_new_task */";
> +       static const char line_bare_enqueue[] =3D " 0) + 10.000 us   |   =
 }";
> +       static const char line_bare_task[] =3D " 0) + 20.000 us   |  }";
> +       static const char line_unmatched[] =3D " 0) +  5.000 us   |    } =
/* unrelated_func */";
> +       static const char line_verbose_entry[] =3D
> +               " 1234.567890 |   0)   bash-1234    |               |  wa=
ke_up_new_task() {";
> +       static const char line_verbose_enqueue[] =3D
> +               " 1234.567890 |   0)   bash-1234    |               |    =
enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
> +       static const char line_verbose_exit_enqueue[] =3D
> +               " 1234.567890 |   0)   bash-1234    |   1.234 us    |    =
} /* enqueue_task */";
> +       static const char line_verbose_exit_task[] =3D
> +               " 1234.567890 |   0)   bash-1234    |   2.567 us    |  } =
/* wake_up_new_task */";
> +       static const char line_verbose_inline_entry[] =3D
> +               " 1234.567890 |   0)   bash-1234    |               |    =
activate_task() { /* (inline) */";
> +       static const char line_verbose_inline_exit[] =3D
> +               " 1234.567890 |   0)   bash-1234    |               |    =
} /* activate_task (inline) */";
> +       struct perf_ftrace ftrace;
> +       char *out_buf =3D NULL;
> +       size_t out_len =3D 0;
> +       FILE *out;
> +       const char *unmatched_pos;
> +       const char *inline_exit_pos;
> +       int ret =3D TEST_OK;
> +
> +       memset(&ftrace, 0, sizeof(ftrace));
> +       ftrace.use_inline =3D true;
> +       ftrace.filter_retaddr =3D 1; /* Default when --graph-opts retaddr=
 is not specified */
> +       ftrace.tracer =3D "function_graph";
> +
> +       /* If vmlinux is present, test resolving symbols */
> +       if (access("vmlinux", R_OK) =3D=3D 0) {

This series is great and I'm spotting nits. Could we try other vmlinux
paths here similar to the symbol code? It also seems an early return
could avoid indentation.

Thanks,
Ian

> +               symbol_conf.vmlinux_name =3D "vmlinux";
> +               symbol_conf.ignore_vmlinux_buildid =3D true;
> +               ret =3D perf_ftrace__setup_inlines(&ftrace);
> +               if (ret < 0 || !ftrace.machine) {
> +                       ret =3D TEST_SKIP;
> +                       goto out_cleanup;
> +               }
> +
> +               out =3D open_memstream(&out_buf, &out_len);
> +               if (!out) {
> +                       ret =3D TEST_FAIL;
> +                       goto out_cleanup;
> +               }
> +
> +               /* Feed simulated function graph trace lines */
> +               ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +               ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +               ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, ou=
t);
> +               ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +               fclose(out);
> +               ftrace_cpu_states__clear();
> +
> +               pr_debug("Processed output:\n%s\n", out_buf);
> +
> +               /* Verify activate_task entry with inline hint */
> +               TEST_CHECK("contains activate_task entry with inline hint=
",
> +                          strstr(out_buf, "activate_task() { /* (inline)=
 */") !=3D NULL);
> +
> +               /* Verify activate_task exit with inline hint */
> +               TEST_CHECK("contains activate_task exit with inline hint"=
,
> +                          strstr(out_buf, "} /* activate_task (inline) *=
/") !=3D NULL);
> +
> +               /* Verify return address comment was filtered out by defa=
ult */
> +               TEST_CHECK("retaddr comment filtered out",
> +                          strstr(out_buf, "/* <-wake_up_new_task") =3D=
=3D NULL);
> +
> +               free(out_buf);
> +               out_buf =3D NULL;
> +
> +               /* Now test with filter_retaddr =3D 0 (user specified --g=
raph-opts retaddr) */
> +               ftrace.filter_retaddr =3D 0;
> +               out =3D open_memstream(&out_buf, &out_len);
> +               if (!out) {
> +                       ret =3D TEST_FAIL;
> +                       goto out_cleanup;
> +               }
> +
> +               ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +               ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +               ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, ou=
t);
> +               ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +               fclose(out);
> +               ftrace_cpu_states__clear();
> +
> +               /* Verify return address comment IS preserved when filter=
_retaddr =3D 0 */
> +               TEST_CHECK("retaddr comment preserved when requested",
> +                          strstr(out_buf, "/* <-wake_up_new_task") !=3D =
NULL);
> +
> +               free(out_buf);
> +               out_buf =3D NULL;
> +
> +               /* Test with bare closing braces (funcgraph-tail disabled=
 by default) */
> +               ftrace.filter_retaddr =3D 1;
> +               out =3D open_memstream(&out_buf, &out_len);
> +               if (!out) {
> +                       ret =3D TEST_FAIL;
> +                       goto out_cleanup;
> +               }
> +
> +               ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +               ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +               ftrace_process_fgraph_line(&ftrace, line_bare_enqueue, ou=
t);
> +               ftrace_process_fgraph_line(&ftrace, line_bare_task, out);
> +
> +               fclose(out);
> +
> +               TEST_CHECK("bare braces inline entry",
> +                          strstr(out_buf, "activate_task() { /* (inline)=
 */") !=3D NULL);
> +               TEST_CHECK("bare braces inline exit",
> +                          strstr(out_buf, "} /* activate_task (inline) *=
/") !=3D NULL);
> +
> +               free(out_buf);
> +               out_buf =3D NULL;
> +
> +               /* Test that unmatched exit events do not pop active inli=
ned frames */
> +               out =3D open_memstream(&out_buf, &out_len);
> +               if (!out) {
> +                       ret =3D TEST_FAIL;
> +                       goto out_cleanup;
> +               }
> +
> +               ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +               ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +               ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, ou=
t);
> +               /* Unmatched exit event while activate_task is still acti=
ve */
> +               ftrace_process_fgraph_line(&ftrace, line_unmatched, out);
> +               ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +               fclose(out);
> +
> +               unmatched_pos =3D strstr(out_buf, "} /* unrelated_func */=
");
> +               inline_exit_pos =3D strstr(out_buf, "} /* activate_task (=
inline) */");
> +
> +               TEST_CHECK("unmatched exit present", unmatched_pos !=3D N=
ULL);
> +               TEST_CHECK("inline exit present", inline_exit_pos !=3D NU=
LL);
> +               TEST_CHECK("inline exit not prematurely popped before unm=
atched exit",
> +                          inline_exit_pos > unmatched_pos);
> +
> +               free(out_buf);
> +               out_buf =3D NULL;
> +
> +               /* Test recovery when an intermediate real function exit =
event is dropped */
> +               out =3D open_memstream(&out_buf, &out_len);
> +               if (!out) {
> +                       ret =3D TEST_FAIL;
> +                       goto out_cleanup;
> +               }
> +
> +               ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +               ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +               /* line_exit_enqueue is dropped; outer wake_up_new_task e=
xits directly */
> +               ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +               fclose(out);
> +
> +               TEST_CHECK("inline exit synthesized despite dropped calle=
e exit",
> +                          strstr(out_buf, "} /* activate_task (inline) *=
/") !=3D NULL);
> +
> +               free(out_buf);
> +               out_buf =3D NULL;
> +
> +               /* Test recovery when intermediate callee exit is dropped=
 before sibling call */
> +               out =3D open_memstream(&out_buf, &out_len);
> +               if (!out) {
> +                       ret =3D TEST_FAIL;
> +                       goto out_cleanup;
> +               }
> +
> +               ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +               ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +               /* line_exit_enqueue dropped; caller makes sibling call w=
ithout inlines */
> +               ftrace_process_fgraph_line(&ftrace,
> +                       " 0)               |    check_preempt_curr(); /* =
<-wake_up_new_task+0x0/0x3e0 */",
> +                       out);
> +               ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +               fclose(out);
> +
> +               TEST_CHECK("inline exit synthesized when callee exit drop=
ped before sibling call",
> +                          strstr(out_buf, "} /* activate_task (inline) *=
/") !=3D NULL);
> +
> +               free(out_buf);
> +               out_buf =3D NULL;
> +
> +               /* Test that callers not on active stack do not synthesis=
e inlines */
> +               out =3D open_memstream(&out_buf, &out_len);
> +               if (!out) {
> +                       ret =3D TEST_FAIL;
> +                       goto out_cleanup;
> +               }
> +
> +               ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +               /* housekeeping_any_cpu called by untraced ring_buffer_un=
lock_commit */
> +               ftrace_process_fgraph_line(&ftrace,
> +                       " 0)               |    housekeeping_any_cpu(); /=
* <-ring_buffer_unlock_commit+0x1a0/0x1f0 */",
> +                       out);
> +               ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +               fclose(out);
> +
> +               TEST_CHECK("untraced caller inlines not synthesised",
> +                          strstr(out_buf, "rb_wakeups") =3D=3D NULL &&
> +                          strstr(out_buf, "rb_irq_work_queue") =3D=3D NU=
LL);
> +
> +               free(out_buf);
> +               out_buf =3D NULL;
> +
> +               /* Test verbose mode prefix formatting for synthesised in=
lines */
> +               ftrace.graph_verbose =3D true;
> +               out =3D open_memstream(&out_buf, &out_len);
> +               if (!out) {
> +                       ret =3D TEST_FAIL;
> +                       goto out_cleanup;
> +               }
> +
> +               ftrace_process_fgraph_line(&ftrace, line_verbose_entry, o=
ut);
> +               ftrace_process_fgraph_line(&ftrace, line_verbose_enqueue,=
 out);
> +               ftrace_process_fgraph_line(&ftrace, line_verbose_exit_enq=
ueue, out);
> +               ftrace_process_fgraph_line(&ftrace, line_verbose_exit_tas=
k, out);
> +
> +               fclose(out);
> +               ftrace_cpu_states__clear();
> +
> +               TEST_CHECK("verbose inline entry preserves comm-pid",
> +                          strstr(out_buf, line_verbose_inline_entry) !=
=3D NULL);
> +               TEST_CHECK("verbose inline exit preserves comm-pid",
> +                          strstr(out_buf, line_verbose_inline_exit) !=3D=
 NULL);
> +
> +               free(out_buf);
> +               out_buf =3D NULL;
> +               ftrace.graph_verbose =3D false;
> +       }
> +
> +out_cleanup:
> +       free(out_buf);
> +       perf_ftrace__cleanup_inlines(&ftrace);
> +       return ret;
> +}
> +#undef TEST_CHECK
> +
> +static int test_stack_saturation(void)
> +{
> +       struct perf_ftrace ftrace;
> +       char *out_buf =3D NULL;
> +       size_t out_len =3D 0;
> +       FILE *out;
> +       int i;
> +
> +       memset(&ftrace, 0, sizeof(ftrace));
> +       ftrace.use_inline =3D true;
> +       ftrace_cpu_states__clear();
> +
> +       out =3D open_memstream(&out_buf, &out_len);
> +       if (!out)
> +               return TEST_FAIL;
> +
> +       /* Push root frame at depth 0 */
> +       ftrace_process_fgraph_line(&ftrace, " 0)               |  root_fu=
nc() {", out);
> +
> +       /* Push 255 more frames to fill FTRACE_MAX_STACK (256) */
> +       for (i =3D 1; i < 256; i++)
> +               ftrace_process_fgraph_line(&ftrace, " 0)               | =
 sub_func() {", out);
> +
> +       /* Push 44 overflow frames beyond FTRACE_MAX_STACK */
> +       for (i =3D 0; i < 44; i++)
> +               ftrace_process_fgraph_line(&ftrace, " 0)               | =
 overflow_func() {", out);
> +
> +       /* Pop the 44 overflow frames with bare closing braces */
> +       for (i =3D 0; i < 44; i++)
> +               ftrace_process_fgraph_line(&ftrace, " 0)               | =
 }", out);
> +
> +       /* Pop 255 tracked sub_func frames */
> +       for (i =3D 1; i < 256; i++)
> +               ftrace_process_fgraph_line(&ftrace, " 0)               | =
 }", out);
> +
> +       /* Pop root frame - must cleanly match root_func on stack, not po=
pped prematurely */
> +       ftrace_process_fgraph_line(&ftrace, " 0)               |  } /* ro=
ot_func */", out);
> +
> +       /* Feed one more function entry - it must have base indentation (=
no indentation drift) */
> +       ftrace_process_fgraph_line(&ftrace, " 0)               |  base_fu=
nc() {", out);
> +
> +       fclose(out);
> +       ftrace_cpu_states__clear();
> +
> +       /* Verify base_func starts at standard 2 spaces indentation witho=
ut drift */
> +       if (!strstr(out_buf, "|  base_func() {")) {
> +               pr_debug("FAILED %s:%d no indentation drift after stack s=
aturation\n",
> +                        __FILE__, __LINE__);
> +               free(out_buf);
> +               return TEST_FAIL;
> +       }
> +
> +       free(out_buf);
> +       return TEST_OK;
> +}
> +
> +static int test_column_layouts(void)
> +{
> +       static const struct {
> +               const char *desc;
> +                               bool verbose;
> +               const char *in;
> +               const char *expected;
> +       } cases[] =3D {
> +               {
> +                       "default layout", false,
> +                       " 7)               |  wake_up_new_task() { /* <-k=
ernel_clone+0x160/0x510 */",
> +                       " 7)               |  wake_up_new_task() {\n",
> +               },
> +               {
> +                       "verbose layout", true,
> +                       " 1234.567890 |   7)   bash-1234    |            =
   |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
> +                       " 1234.567890 |   7)   bash-1234    |            =
   |  wake_up_new_task() {\n",
> +               },
> +       };
> +       struct perf_ftrace ftrace;
> +       char *out_buf =3D NULL;
> +       size_t out_len =3D 0;
> +       FILE *out;
> +       size_t i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(cases); i++) {
> +               memset(&ftrace, 0, sizeof(ftrace));
> +               ftrace.use_inline =3D true;
> +               ftrace.filter_retaddr =3D true;
> +                               ftrace.graph_verbose =3D cases[i].verbose=
;
> +
> +               out =3D open_memstream(&out_buf, &out_len);
> +               if (!out)
> +                       return TEST_FAIL;
> +
> +               ftrace_process_fgraph_line(&ftrace, cases[i].in, out);
> +               fclose(out);
> +               ftrace_cpu_states__clear();
> +
> +               if (strcmp(out_buf, cases[i].expected)) {
> +                       pr_debug("%s: expected '%s', got '%s'\n",
> +                                cases[i].desc, cases[i].expected, out_bu=
f);
> +                       free(out_buf);
> +                       return TEST_FAIL;
> +               }
> +               free(out_buf);
> +               out_buf =3D NULL;
> +       }
> +
> +       return TEST_OK;
> +}
> +
>  static int test__ftrace(struct test_suite *test __maybe_unused, int subt=
est __maybe_unused)
>  {
>         int ret;
> @@ -74,7 +444,19 @@ static int test__ftrace(struct test_suite *test __may=
be_unused, int subtest __ma
>         if (ret !=3D TEST_OK)
>                 return ret;
>
> +       ret =3D test_stack_saturation();
> +       if (ret !=3D TEST_OK)
> +               return ret;
> +
> +       ret =3D test_column_layouts();
> +       if (ret !=3D TEST_OK)
> +               return ret;
> +
> +       ret =3D test_inline_processing();
> +       if (ret !=3D TEST_OK)
> +               return ret;
> +
>         return TEST_OK;
>  }
>
> -DEFINE_SUITE("Ftrace return address processing", ftrace);
> +DEFINE_SUITE("Ftrace inline processing", ftrace);
> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index aaf108369c36..96d612d2f1a1 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
> @@ -1,13 +1,84 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/compiler.h>
> -#include <linux/kernel.h>
> -#include <linux/string.h>
> +/*
> + * ftrace.c - Ftrace utilities and inlined function processing
> + *
> + * Copyright (C) 2026 Aaron Tomlin <atomlin@atomlin.com>
> + */
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <errno.h>
>  #include <string.h>
>  #include <ctype.h>
> +#include <stdbool.h>
> +#include <linux/kernel.h>
> +#include <linux/zalloc.h>
> +#include <linux/string.h>
> +#include "debug.h"
> +#include "dso.h"
> +#include "machine.h"
> +#include "map.h"
> +#include "srcline.h"
> +#include "symbol.h"
>  #include "util/ftrace.h"
>
> +#define FTRACE_MAX_CPUS 4096
> +#define FTRACE_MAX_STACK 256
> +#define FTRACE_MAX_INLINES 32
> +
> +struct ftrace_stack_frame {
> +       char *name;
> +       bool inlined;
> +       int indent;
> +};
> +
> +struct ftrace_cpu_state {
> +       struct ftrace_stack_frame stack[FTRACE_MAX_STACK];
> +       int depth;
> +       int inlined_depth;
> +       int overflow_depth;
> +};
> +
> +static struct ftrace_cpu_state *ftrace_cpu_states[FTRACE_MAX_CPUS];
> +
> +/**
> + * ftrace_cpu_states__clear - Free allocated CPU stack states
> + *
> + * Free all memory associated with the per-CPU stack tracking states
> + * used for inlined function resolution, including the strings
> + * allocated for stack frames.
> + */
> +void ftrace_cpu_states__clear(void)
> +{
> +       int i, j;
> +
> +       for (i =3D 0; i < FTRACE_MAX_CPUS; i++) {
> +               if (ftrace_cpu_states[i]) {
> +                       for (j =3D 0; j < ftrace_cpu_states[i]->depth; j+=
+)
> +                               free(ftrace_cpu_states[i]->stack[j].name)=
;
> +                       free(ftrace_cpu_states[i]);
> +                       ftrace_cpu_states[i] =3D NULL;
> +               }
> +       }
> +}
> +
> +/**
> + * get_cpu_state - Get or allocate stack state for a given CPU
> + * @cpu: The CPU number
> + *
> + * Return: A pointer to the CPU's stack state, or NULL on error or
> + * out-of-bounds CPU index.
> + */
> +static struct ftrace_cpu_state *get_cpu_state(int cpu)
> +{
> +       if (cpu < 0 || cpu >=3D FTRACE_MAX_CPUS)
> +               return NULL;
> +
> +       if (!ftrace_cpu_states[cpu])
> +               ftrace_cpu_states[cpu] =3D zalloc(sizeof(struct ftrace_cp=
u_state));
> +
> +       return ftrace_cpu_states[cpu];
> +}
> +
>  /**
>   * ftrace_parse_retaddr - Parse return address comment from trace line
>   * @str: The trace line containing the comment
> @@ -84,3 +155,576 @@ void ftrace_filter_retaddr(char *str)
>
>         memmove(start, end, strlen(end) + 1);
>  }
> +
> +/**
> + * ftrace_resolve_inlines - Resolve inlined functions for a return addre=
ss
> + * @machine: Perf machine context
> + * @sym_name: Name of the caller function
> + * @offset: Instruction offset within the caller function
> + * @inlined_names: Array to store the resolved inline function names
> + * @max_inlines: Maximum number of inline frames to resolve
> + *
> + * Use DWARF debug information from the kernel image to resolve a caller=
's
> + * return address to its inlined callchain.
> + *
> + * Return: The number of inline functions successfully resolved.
> + */
> +int ftrace_resolve_inlines(struct machine *machine,
> +                          const char *sym_name, u64 offset,
> +                          const char **inlined_names, int max_inlines)
> +{
> +       struct map *map =3D NULL;
> +       struct symbol *sym;
> +       struct dso *dso;
> +       struct inline_node *node;
> +       struct inline_list *ilist;
> +       u64 ip, addr;
> +       int count =3D 0;
> +
> +       if (!machine)
> +               return 0;
> +
> +       sym =3D machine__find_kernel_symbol_by_name(machine, sym_name, &m=
ap);
> +       if (!sym || !map)
> +               return 0;
> +
> +       dso =3D map__dso(map);
> +       if (!dso) {
> +               map__put(map);
> +               return 0;
> +       }
> +
> +       ip =3D sym->start + offset;
> +       addr =3D map__rip_2objdump(map, ip);
> +
> +       node =3D inlines__tree_find(dso__inlined_nodes(dso), addr);
> +       if (!node) {
> +               node =3D dso__parse_addr_inlines(dso, addr, sym);
> +               if (node)
> +                       inlines__tree_insert(dso__inlined_nodes(dso), nod=
e);
> +       }
> +
> +       if (!node) {
> +               map__put(map);
> +               return 0;
> +       }
> +
> +       list_for_each_entry_reverse(ilist, &node->val, list) {
> +               if (ilist->symbol && symbol__inlined(ilist->symbol)) {
> +                       if (count < max_inlines) {
> +                               char *name =3D strdup(ilist->symbol->name=
);
> +
> +                               if (name)
> +                                       inlined_names[count++] =3D name;
> +                       }
> +               }
> +       }
> +
> +       map__put(map);
> +       return count;
> +}
> +
> +/**
> + * extract_entry_func_name - Extract the function name from an entry rec=
ord
> + * @str: The trace line's function column string
> + * @buf: Buffer to store the extracted name
> + * @size: Size of the @buf
> + *
> + * Parse the function name out of an entry trace record by stripping awa=
y
> + * parentheses or braces.
> + */
> +static void extract_entry_func_name(const char *str, char *buf, size_t s=
ize)
> +{
> +       size_t i =3D 0;
> +
> +       while (*str && *str !=3D '(' && *str !=3D '{' && !isspace(*str) &=
& i < size - 1)
> +               buf[i++] =3D *str++;
> +       buf[i] =3D '\0';
> +}
> +
> +/**
> + * extract_exit_func_name - Extract the function name from an exit recor=
d
> + * @str: The trace line's function column string
> + * @buf: Buffer to store the extracted name
> + * @size: Size of the @buf
> + *
> + * Parse the original function name out of the trailing comment in an
> + * exit trace record.
> + */
> +static void extract_exit_func_name(const char *str, char *buf, size_t si=
ze)
> +{
> +       const char *p =3D strchr(str, '}');
> +       size_t i =3D 0;
> +
> +       buf[0] =3D '\0';
> +       if (!p)
> +               return;
> +
> +       p =3D strstr(p, "/*");
> +       if (!p)
> +               return;
> +
> +       p =3D skip_spaces(p + 2);
> +       while (*p && !isspace(*p) && *p !=3D '*' && *p !=3D '/' && i < si=
ze - 1)
> +               buf[i++] =3D *p++;
> +       buf[i] =3D '\0';
> +}
> +
> +/**
> + * make_blank_prefix - Create a blank prefix mirroring a trace record's =
context
> + * @line: The original trace record
> + * @pipe_char: Pointer to the final delimiter character of the context c=
olumns
> + * @buf: Buffer to store the blank prefix
> + * @size: Size of the @buf
> + *
> + * Generate a prefix matching the context columns of @line (e.g. CPU, du=
ration)
> + * but with the duration field replaced by spaces.
> + */
> +static void make_blank_prefix(const struct perf_ftrace *ftrace, const ch=
ar *line,
> +                             const char *pipe_char, char *buf, size_t si=
ze)
> +{
> +       size_t len =3D pipe_char - line + 1;
> +       const char *start_delim =3D NULL;
> +       char *c;
> +
> +       if (!size)
> +               return;
> +
> +       if (len >=3D size)
> +               len =3D size - 1;
> +
> +       memcpy(buf, line, len);
> +       buf[len] =3D '\0';
> +
> +       if (*pipe_char =3D=3D '|') {
> +               if (ftrace->graph_verbose) {
> +                       /* In verbose mode, duration starts after the com=
m-pid '|' */
> +                       for (const char *p =3D pipe_char - 1; p >=3D line=
; p--) {
> +                               if (*p =3D=3D '|') {
> +                                       start_delim =3D p;
> +                                       break;
> +                               }
> +                       }
> +               } else {
> +                       /* In default mode, duration starts after CPU ')'=
 */
> +                       start_delim =3D strchr(line, ')');
> +               }
> +
> +               if (start_delim && start_delim < pipe_char && start_delim=
 < line + len) {
> +                       char *end =3D buf + (pipe_char - line);
> +
> +                       if (end > buf + len)
> +                               end =3D buf + len;
> +                       for (c =3D buf + (start_delim - line) + 1; c < en=
d; c++)
> +                               *c =3D ' ';
> +               }
> +       }
> +}
> +
> +/**
> + * find_func_column - Locate the function call column in a trace record
> + * @ftrace: Perf ftrace context
> + * @line: The trace record to parse
> + * @cpu: Pointer to store the CPU number
> + *
> + * Locate the context columns that precede the function call column of a
> + * function_graph trace record. Depending on the funcgraph-* options set
> + * up by perf, a record looks like:
> + *
> + *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
> + *
> + * The abstime and comm-pid columns are only present with --graph-opts
> + * verbose.
> + *
> + * Return: A pointer to the last character of the context columns (the f=
inal
> + * '|' delimiter). Returns NULL if @line is not a trace record.
> + */
> +static const char *find_func_column(const struct perf_ftrace *ftrace,
> +                                   const char *line, int *cpu)
> +{
> +       const char *p =3D line;
> +       char *endptr;
> +       long val;
> +
> +       if (ftrace->graph_verbose) {
> +               p =3D strchr(p, '|');
> +               if (!p)
> +                       return NULL;
> +               p++;
> +       }
> +
> +       p =3D skip_spaces(p);
> +       val =3D strtol(p, &endptr, 10);
> +       if (endptr =3D=3D p || *endptr !=3D ')')
> +               return NULL;
> +       p =3D endptr;
> +
> +       if (ftrace->graph_verbose) {
> +               p =3D strchr(p, '|');
> +               if (!p)
> +                       return NULL;
> +       }
> +
> +       p =3D strchr(p + 1, '|');
> +       if (!p)
> +               return NULL;
> +
> +       *cpu =3D (int)val;
> +       return p;
> +}
> +
> +/**
> + * print_line - Output a trace line verbatim, filtering return addresses=
 if needed
> + * @ftrace: Perf ftrace context
> + * @line: The trace line to output
> + * @out: File stream to output to
> + *
> + * Output @line to @out. If ftrace->filter_retaddr is set, return addres=
s
> + * comments are filtered out first.
> + *
> + * Return: 0 on success, or a negative error code (e.g. -ENOMEM) on fail=
ure.
> + */
> +static int print_line(struct perf_ftrace *ftrace, const char *line, FILE=
 *out)
> +{
> +       char *filtered;
> +
> +       if (!ftrace->filter_retaddr) {
> +               fprintf(out, "%s\n", line);
> +               return 0;
> +       }
> +
> +       filtered =3D strdup(line);
> +       if (!filtered) {
> +               pr_err("Not enough memory\n");
> +               return -ENOMEM;
> +       }
> +
> +       ftrace_filter_retaddr(filtered);
> +       fprintf(out, "%s\n", filtered);
> +       free(filtered);
> +       return 0;
> +}
> +
> +/**
> + * ftrace_process_fgraph_line - Process and output a function graph trac=
e line
> + * @ftrace: Perf ftrace context
> + * @line: The trace line to process
> + * @out: File stream to output to
> + *
> + * Process a trace line from the function_graph tracer. If --inline is s=
et,
> + * this function parses the return address comment, resolves it to its
> + * inlined callchain, and synthesises intermediate frames into the strea=
med
> + * call graph.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *l=
ine, FILE *out)
> +{
> +       char caller_sym[128];
> +       char blank_prefix[128];
> +       const char *inlined_names[FTRACE_MAX_INLINES];
> +       const char *pipe_char;
> +       const char *after_pipe;
> +       const char *func_start;
> +       struct ftrace_cpu_state *cs;
> +       u64 caller_offset =3D 0;
> +       int num_inlines =3D 0;
> +       int cpu =3D -1;
> +       int leading_spaces;
> +       int extra_indent;
> +       int caller_idx;
> +       int active_inlines;
> +       int common;
> +       int match_idx;
> +       int i;
> +       bool is_exit;
> +       bool has_open_brace;
> +       bool has_semicolon;
> +       bool has_retaddr =3D false;
> +
> +       if (!ftrace->use_inline)
> +               return print_line(ftrace, line, out);
> +
> +       pipe_char =3D find_func_column(ftrace, line, &cpu);
> +       if (!pipe_char)
> +               return print_line(ftrace, line, out);
> +
> +       cs =3D get_cpu_state(cpu);
> +       if (!cs)
> +               return print_line(ftrace, line, out);
> +
> +       make_blank_prefix(ftrace, line, pipe_char, blank_prefix, sizeof(b=
lank_prefix));
> +
> +       after_pipe =3D pipe_char + 1;
> +       func_start =3D skip_spaces(after_pipe);
> +       leading_spaces =3D func_start - after_pipe;
> +
> +       if (*func_start =3D=3D '\0')
> +               return print_line(ftrace, line, out);
> +
> +       is_exit =3D (*func_start =3D=3D '}');
> +
> +       if (is_exit) {
> +               char exit_name[128];
> +
> +               if (cs->overflow_depth > 0) {
> +                       cs->overflow_depth--;
> +                       extra_indent =3D cs->inlined_depth * 2;
> +                       fprintf(out, "%.*s%*s%s\n",
> +                               (int)(pipe_char - line + 1), line,
> +                               leading_spaces + extra_indent, "", func_s=
tart);
> +                       return 0;
> +               }
> +
> +               extract_exit_func_name(func_start, exit_name, sizeof(exit=
_name));
> +
> +               /* Find matching frame on stack */
> +               match_idx =3D -1;
> +               for (i =3D cs->depth - 1; i >=3D 0; i--) {
> +                       if (!cs->stack[i].inlined) {
> +                               if (exit_name[0] =3D=3D '\0' ||
> +                                   (cs->stack[i].name &&
> +                                    strcmp(cs->stack[i].name, exit_name)=
 =3D=3D 0)) {
> +                                       match_idx =3D i;
> +                                       break;
> +                               }
> +                       }
> +               }
> +
> +               if (match_idx >=3D 0) {
> +                       /* Close all inlined and orphaned frames above ma=
tch_idx */
> +                       while (cs->depth > 0 && cs->depth - 1 > match_idx=
) {
> +                               struct ftrace_stack_frame *top =3D &cs->s=
tack[cs->depth - 1];
> +
> +                               if (top->inlined) {
> +                                       int exit_indent =3D top->indent;
> +
> +                                       if (cs->inlined_depth > 0)
> +                                               cs->inlined_depth--;
> +                                       fprintf(out, "%s%*s} /* %s (inlin=
e) */\n",
> +                                               blank_prefix, exit_indent=
, "", top->name);
> +                               }
> +                               free(top->name);
> +                               cs->depth--;
> +                       }
> +
> +                       /* Pop the matched real frame */
> +                       if (cs->depth > 0 && match_idx =3D=3D cs->depth -=
 1 &&
> +                           !cs->stack[cs->depth - 1].inlined) {
> +                               free(cs->stack[cs->depth - 1].name);
> +                               cs->depth--;
> +                       }
> +
> +                       extra_indent =3D cs->inlined_depth * 2;
> +               } else {
> +                       extra_indent =3D 0;
> +               }
> +
> +               fprintf(out, "%.*s%*s%s\n",
> +                       (int)(pipe_char - line + 1), line,
> +                       leading_spaces + extra_indent, "", func_start);
> +               return 0;
> +       }
> +
> +       /* It's an entry or a leaf call */
> +       has_open_brace =3D (strchr(func_start, '{') !=3D NULL);
> +       has_semicolon =3D (strchr(func_start, ';') !=3D NULL);
> +
> +       if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sy=
m), &caller_offset)) {
> +               has_retaddr =3D true;
> +               num_inlines =3D ftrace_resolve_inlines(ftrace->machine, c=
aller_sym,
> +                                                     caller_offset, inli=
ned_names,
> +                                                     FTRACE_MAX_INLINES)=
;
> +       }
> +
> +       /* Determine which inlined frames are currently open above the ca=
ller */
> +       caller_idx =3D -1;
> +       if (has_retaddr) {
> +               for (i =3D cs->depth - 1; i >=3D 0; i--) {
> +                       if (!cs->stack[i].inlined && cs->stack[i].name &&
> +                           strcmp(cs->stack[i].name, caller_sym) =3D=3D =
0) {
> +                               caller_idx =3D i;
> +                               break;
> +                       }
> +               }
> +
> +               /* If caller is not on the tracked stack, do not synthesi=
se inlines */
> +               if (caller_idx < 0) {
> +                       for (i =3D 0; i < num_inlines; i++)
> +                               free((void *)inlined_names[i]);
> +                       num_inlines =3D 0;
> +               }
> +       }
> +
> +       active_inlines =3D 0;
> +       if (caller_idx >=3D 0) {
> +               for (i =3D caller_idx + 1; i < cs->depth; i++) {
> +                       if (cs->stack[i].inlined)
> +                               active_inlines++;
> +                       else
> +                               break;
> +               }
> +       }
> +
> +       /* Find common prefix of inlined functions */
> +       common =3D 0;
> +       if (caller_idx >=3D 0) {
> +               while (common < active_inlines && common < num_inlines &&
> +                      cs->stack[caller_idx + 1 + common].name &&
> +                      !strcmp(cs->stack[caller_idx + 1 + common].name,
> +                              inlined_names[common])) {
> +                       common++;
> +               }
> +       }
> +
> +       /* Close stale callee frames and inactive inlined frames above ca=
ller */
> +       while (caller_idx >=3D 0 && cs->depth > caller_idx + 1 + common) =
{
> +               struct ftrace_stack_frame *top =3D &cs->stack[cs->depth -=
 1];
> +
> +               if (top->inlined) {
> +                       int exit_indent =3D top->indent;
> +
> +                       if (cs->inlined_depth > 0)
> +                               cs->inlined_depth--;
> +                       fprintf(out, "%s%*s} /* %s (inline) */\n",
> +                               blank_prefix, exit_indent, "", top->name)=
;
> +               }
> +               free(top->name);
> +               cs->depth--;
> +       }
> +
> +       /* Open new inlined frames */
> +       for (i =3D common; i < num_inlines; i++) {
> +               int entry_indent =3D leading_spaces + cs->inlined_depth *=
 2;
> +
> +               if (!inlined_names[i]) {
> +                       pr_err("Not enough memory\n");
> +                       for (int j =3D 0; j < num_inlines; j++)
> +                               free((void *)inlined_names[j]);
> +                       return -ENOMEM;
> +               }
> +               if (cs->depth >=3D FTRACE_MAX_STACK)
> +                       break;
> +
> +               fprintf(out, "%s%*s%s() { /* (inline) */\n",
> +                       blank_prefix, entry_indent, "", inlined_names[i])=
;
> +               cs->stack[cs->depth].name =3D strdup(inlined_names[i]);
> +               if (!cs->stack[cs->depth].name) {
> +                       pr_err("Not enough memory\n");
> +                       for (int j =3D 0; j < num_inlines; j++)
> +                               free((void *)inlined_names[j]);
> +                       return -ENOMEM;
> +               }
> +               cs->stack[cs->depth].inlined =3D true;
> +               cs->stack[cs->depth].indent =3D entry_indent;
> +               cs->depth++;
> +               cs->inlined_depth++;
> +       }
> +
> +       /* Print current line with updated indentation */
> +       extra_indent =3D cs->inlined_depth * 2;
> +
> +       if (ftrace->filter_retaddr) {
> +               char *filtered =3D strdup(func_start);
> +
> +               if (filtered) {
> +                       ftrace_filter_retaddr(filtered);
> +                       fprintf(out, "%.*s%*s%s\n",
> +                               (int)(pipe_char - line + 1), line,
> +                               leading_spaces + extra_indent, "", filter=
ed);
> +                       free(filtered);
> +               } else {
> +                       pr_err("Not enough memory\n");
> +                       for (i =3D 0; i < num_inlines; i++)
> +                               free((void *)inlined_names[i]);
> +                       return -ENOMEM;
> +               }
> +       } else {
> +               fprintf(out, "%.*s%*s%s\n",
> +                       (int)(pipe_char - line + 1), line,
> +                       leading_spaces + extra_indent, "", func_start);
> +       }
> +
> +       /* If non-leaf entry, push onto stack */
> +       if (has_open_brace && !has_semicolon) {
> +               char entry_name[128];
> +
> +               extract_entry_func_name(func_start, entry_name, sizeof(en=
try_name));
> +               if (cs->depth < FTRACE_MAX_STACK) {
> +                       cs->stack[cs->depth].name =3D strdup(entry_name);
> +                       if (!cs->stack[cs->depth].name) {
> +                               pr_err("Not enough memory\n");
> +                               for (i =3D 0; i < num_inlines; i++)
> +                                       free((void *)inlined_names[i]);
> +                               return -ENOMEM;
> +                       }
> +                       cs->stack[cs->depth].inlined =3D false;
> +                       cs->stack[cs->depth].indent =3D leading_spaces + =
extra_indent;
> +                       cs->depth++;
> +               } else {
> +                       cs->overflow_depth++;
> +               }
> +       }
> +
> +       for (i =3D 0; i < num_inlines; i++)
> +               free((void *)inlined_names[i]);
> +       return 0;
> +}
> +
> +/**
> + * perf_ftrace__setup_inlines - Initialise symbol resolution for inlines
> + * @ftrace: Perf ftrace context
> + *
> + * Initialise symbol tracking and load the kernel image (vmlinux) for
> + * DWARF debug information parsing.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace)
> +{
> +       struct map *kmap;
> +
> +       if (!ftrace->use_inline)
> +               return 0;
> +
> +       symbol_conf.try_vmlinux_path =3D (symbol_conf.vmlinux_name =3D=3D=
 NULL);
> +       symbol_conf.inline_name =3D true;
> +       if (symbol_conf.vmlinux_name)
> +               symbol_conf.ignore_vmlinux_buildid =3D true;
> +
> +       if (symbol__init(NULL) < 0) {
> +               pr_warning("Failed to initialize symbols for inlined func=
tions\n");
> +               return -1;
> +       }
> +
> +       ftrace->machine =3D machine__new_host(NULL);
> +       if (!ftrace->machine) {
> +               pr_warning("Failed to create host machine for symbols\n")=
;
> +               return -1;
> +       }
> +
> +       if (symbol_conf.vmlinux_name) {
> +               kmap =3D machine__kernel_map(ftrace->machine);
> +               if (kmap)
> +                       dso__load_vmlinux(map__dso(kmap), kmap, symbol_co=
nf.vmlinux_name, false);
> +       } else {
> +               machine__load_vmlinux_path(ftrace->machine);
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * perf_ftrace__cleanup_inlines - Clean up resources used for inline res=
olution
> + * @ftrace: Perf ftrace context
> + *
> + * Free the machine context and the CPU stack tracking states.
> + */
> +void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace)
> +{
> +       if (ftrace->machine) {
> +               machine__delete(ftrace->machine);
> +               ftrace->machine =3D NULL;
> +       }
> +       ftrace_cpu_states__clear();
> +}
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> index 50216d3fef64..4140902d9de6 100644
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h
> @@ -41,6 +41,8 @@ struct perf_ftrace {
>         int                     graph_tail;
>         bool                    filter_retaddr;
>         bool                    filter_retaddr_set;
> +       bool                    use_inline;
> +       struct machine          *machine;
>  };
>
>  struct filter_entry {
> @@ -95,7 +97,16 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *f=
trace __maybe_unused)
>
>  #endif  /* HAVE_BPF_SKEL */
>
> +struct machine;
> +
>  bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_le=
n, u64 *offset);
>  void ftrace_filter_retaddr(char *str);
> +int ftrace_resolve_inlines(struct machine *machine,
> +                          const char *sym_name, u64 offset,
> +                          const char **inlined_names, int max_inlines);
> +int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *l=
ine, FILE *out);
> +void ftrace_cpu_states__clear(void);
> +int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace);
> +void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace);
>
>  #endif  /* __PERF_FTRACE_H__ */
> --
> 2.55.0
>
