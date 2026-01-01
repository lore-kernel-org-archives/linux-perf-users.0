Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A412F39A3
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Jan 2026 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767298085; cv=pass; b=b3k00E1TOPPjXear4eVbTNsdt4oZyP6IIzL6C3m/RYb/o/6Iyw4yhEPqzRCYWg2HBEUiF8bEkxEUp9N38AuAj7YEbdjSaDcwR3tvuWcLYuyGOSgEfqHuNndy5ZYSh0GUgCGfaD6Ruo+W3H8MnmNUjjdKjjoRydm3U8DmlD/5UwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767298085; c=relaxed/simple;
	bh=1StJURG0KQQYVF+6JJNnwJkPFRHgXicVBxTlPQFb4go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6SBY0MbOSDGcx4LVkcDPiYpcFwEh0VaolslUL+0QwFv3ncbB2YtRzWHh9W1lh53gBtvhqC40MeQy06raQcjbrVg+c9lBasOzRj6VvHN1B1hBGZYjRpv/6pKEQn0VzM0Pgwc+ExL2/3lqWehj3oJTn2vIWHA2r/wnDp+q9jbIs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iGfjBf/k; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iGfjBf/k"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0d06cfa93so228165ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jan 2026 12:08:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767298082; cv=none;
        d=google.com; s=arc-20240605;
        b=c3KS3pVFJOfZL/9yV0bAvIyi2VxspkOq9ESMQB3SXiyoBoq3bDpOhzcjAtB4z2gt6o
         Ca5WrV0YQYF9u5PCyN2xwmkbDqQMufGuyYwLbsm5hzECgw/5UIEq65TTgVugX0oAfrmI
         uPf0yOSBjPUWJAYWXmiSEgAmW3QYG/Dr7hzWiq2CUNjMvSqWx26bqN7Z09PNuijgvup0
         bceNG1modHBbDD+MVdELtadS7Y1yTlxxFvclKRLn6/EnptAh7s2uzZK/KCRfpLtu6u/k
         rZcjnCA9KyCe61pBYt8J3uHdwkLEZtGNL5K75J3J0Q1QgFA/XwiS/rtlXXMdAqkyQmJl
         knxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tgepQJD7eaDWQ7SYQQUS/6VKW/EUSLtWs2y+Y1Bw/4A=;
        fh=a+qoGMR4JkpW5ST7BRhDCJYcQO7ZF7zpheszHozGtL0=;
        b=EV38eD07wFYGrcn36Efs8u7Xl3i7ru4NckXTsWZtBggfpgrv6PQgD/ZzxH9ipoMUg2
         hZRTJ2anc79txCJDN0GNEByirkMk1QHvrmB79A265l3gMLCkV2xir1UJIYW6taRDHefy
         I8ZaeFXXf6tzEpRNQAeI4O6Z/tn5OMos0GXDBvZ4lCq6r3H+y4js28FnZagpL3v2zEFw
         68wv8YVED1X2sUnMskY0DF6kWLn4Ztdb0WMYmQc0cKP/B/tEGphoPM2zFrgRDO1MAE7U
         OG6ycLEDRW5qhpY98T29UPCFPr253tb7Mqv9uzJEGtcsa3fm8Sy30CpQ+r1ai4FacP/R
         fwBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767298082; x=1767902882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgepQJD7eaDWQ7SYQQUS/6VKW/EUSLtWs2y+Y1Bw/4A=;
        b=iGfjBf/k6Q0TEbdl7c7jFm65U7Chhv/rD6A43AkD6leIR0ioaInippZMqqoV9LFG8k
         7W18+0teKhNZY0SQ60ctmnGgQ/N+oJIrJRs22/uuXN6c5yCqwVkV//vPLVBPgRoTeEBU
         Vh74jsOe9ceuP+gY7pp2bu70hvel+lgDrcbq8orHKCPpaYko+pxTp0wa6DKy+xj4YzrP
         RK1j6Xp+q7eKTkaHCWkLfnRHgQ07zJQyd1VtO+5raNDJr8rLFWsLRF6GP0gp2tO4dOnC
         yY3Lxqb4kXjKvXx+zoBb2/8/e0QXupawMTa3BCXFwH4ixZKfcngtzHn2USwyPnFPK9Bb
         7INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767298082; x=1767902882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tgepQJD7eaDWQ7SYQQUS/6VKW/EUSLtWs2y+Y1Bw/4A=;
        b=nVtNg3xf3MUiED7CMxyO76LyGnrr1h9USN+a2tAU5X1KLCL65ikxTYIgKdez5RbnPS
         XPXhYhJKfz1sJ2URZsyQoB0rM7Z6cRQqjNa4lttXRUNJKYw7nXXU5UX24C3ryF5crgsx
         bUiP4VjeycPS4UZRXGUpve6Mwr3/0/zA1DVUx6dPa8mRMFGqwcwYZQqAuTljbh+WRPn7
         x7m0oKCHYB5x97739VMf18+E6MeHXu7BmszMZBbTLMylbj4i3T53+B+318SHq5E9bCl5
         /ubHNr7vtP61fCXWq9hKGKT9aNhUTyMgoOKqmPWp2UsBVP0Cz0W17vMwvr29KFIicdca
         VdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb9aOs977uzkTDNjJ6zs3HqDljf0zJjKk4volcWqrGBNwxpn/OwPwoRozhspGFSsscuaI0kZ8zpc+YVGuWcIzG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1CaxoolSHlBle3UUybSatruXh9bXNfkQTB9TNynGXyx+6WDY9
	ln3tRH8YTBAcJEZlp2RK//9+CTGAFzyVy+1qTkO/Pl7+RWVzTxKfaY0quqB9MrT9NR2rcR5p6Xg
	1rAPq4SqHzhyoQ9Hun6Q+Xx52hLYoDRIg4tmNPNQg
X-Gm-Gg: AY/fxX50lOaz3rMttpqQ6PlcJDIgRhk75ZoaYrFdggBZJ7xxyL6T2kwrAw3mgu4p1TT
	ajpfIV6pkCP1NlSFTb7Kq4tAewX12G3V+hMm38FNEfZ15w99NJcp1So0EVUHb1Faan6OxtMFd/k
	8wG4Wt6ZuKVYCkx53lJ75yMupvEblFEuQMRLCHOA09r+b/DrbPTUxeHqNnVYbK5tBj+9cvSO5Ox
	FhsRtjfChwYggAsCHWEPGx67N41YrEFd2cePrhy7ASppafRpF1ry3kguWlwPKzF/UMWHByo
X-Google-Smtp-Source: AGHT+IEmHGhc9iASTXI/1XZ2YzujJYN5BJoF941RNV6h8zBKbCBPtCzVY2+SVeIvZygzEroBn/qN6SKF1bcQRfFXt0k=
X-Received: by 2002:a17:902:e80b:b0:290:dd42:eb5f with SMTP id
 d9443c01a7336-2a3a3af443fmr2943705ad.12.1767298081610; Thu, 01 Jan 2026
 12:08:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218215741.2446883-1-namhyung@kernel.org>
In-Reply-To: <20251218215741.2446883-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Jan 2026 12:07:50 -0800
X-Gm-Features: AQt7F2pogOpMlfOHyeCAefxvxLD_J2xJExkpX1VR94bzUhehQjMsxYxNIxIbgEQ
Message-ID: <CAP-5=fV1zHMg++itfmCe1xCNanVsgRkDsk5WQ5wtkbaedzSaCw@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf inject: Add --convert-callchain option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 1:57=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> There are applications not built with frame pointers, so DWARF is needed
> to get the stack traces.  So `perf record --call-graph dwarf` saves the
> stack and register data for each sample to get the stacktrace offline.
> But sometimes those data may have sensitive information and we don't
> want to keep them in the file.
>
> This perf inject --convert-callchain option parses the callchains and
> discard the stack and register after that.  This will save storage space
> and processing time for the new data file.  Of course, users should
> remove the original data file. :)

This is a really cool feature!

> The down side is that it cannot handle inlined callchain entries as they
> all have the same IPs.  Maybe we can add an option to perf report to
> look up inlined functions using DWARF - IIUC it won't requires stack and
> register data.
>
> This is an example.
>
>   $ perf record --call-graph dwarf -- perf test -w noploop
>
>   $ perf report --stdio --no-children --percent-limit=3D0 > output-prev
>
>   $ perf inject -i perf.data --convert-callchain -o perf.data.out
>
>   $ perf report --stdio --no-children --percent-limit=3D0 -i perf.data.ou=
t > output-next
>
>   $ diff -u output-prev output-next
>   ...
>         0.23%  perf          ld-linux-x86-64.so.2  [.] _dl_relocate_objec=
t_no_relro
>                |
>   -            ---elf_dynamic_do_Rela (inlined)
>   -               _dl_relocate_object_no_relro
>   +            ---_dl_relocate_object_no_relro
>                   _dl_relocate_object
>                   dl_main
>                   _dl_sysdep_start
>   -               _dl_start_final (inlined)
>                   _dl_start
>                   _start
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-inject.txt |   5 +
>  tools/perf/builtin-inject.c              | 128 +++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Docume=
ntation/perf-inject.txt
> index c972032f4ca0d248..95dfdf39666efe89 100644
> --- a/tools/perf/Documentation/perf-inject.txt
> +++ b/tools/perf/Documentation/perf-inject.txt
> @@ -109,6 +109,11 @@ include::itrace.txt[]
>         should be used, and also --buildid-all and --switch-events may be
>         useful.
>
> +--convert-callchain::
> +       Parse DWARF callchains and convert them to usual callchains.  Thi=
s also
> +       discards stack and register data from the samples.  This will los=
e
> +       inlined callchain entries.
> +
>  :GMEXAMPLECMD: inject
>  :GMEXAMPLESUBCMD:
>  include::guestmount.txt[]
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6080afec537d2178..2a2fcc8e3e9e5fe5 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -122,6 +122,7 @@ struct perf_inject {
>         bool                    in_place_update;
>         bool                    in_place_update_dry_run;
>         bool                    copy_kcore_dir;
> +       bool                    convert_callchain;
>         const char              *input_name;
>         struct perf_data        output;
>         u64                     bytes_written;
> @@ -133,6 +134,7 @@ struct perf_inject {
>         struct guest_session    guest_session;
>         struct strlist          *known_build_ids;
>         const struct evsel      *mmap_evsel;
> +       struct ip_callchain     *raw_callchain;
>  };
>
>  struct event_entry {
> @@ -383,6 +385,89 @@ static int perf_event__repipe_sample(const struct pe=
rf_tool *tool,
>         return perf_event__repipe_synth(tool, event);
>  }
>
> +static int perf_event__convert_sample_callchain(const struct perf_tool *=
tool,
> +                                               union perf_event *event,
> +                                               struct perf_sample *sampl=
e,
> +                                               struct evsel *evsel,
> +                                               struct machine *machine)
> +{
> +       struct perf_inject *inject =3D container_of(tool, struct perf_inj=
ect, tool);
> +       struct callchain_cursor *cursor =3D get_tls_callchain_cursor();
> +       union perf_event *event_copy =3D (void *)inject->event_copy;
> +       struct callchain_cursor_node *node;
> +       struct thread *thread;
> +       u64 sample_type =3D evsel->core.attr.sample_type;
> +       u32 sample_size =3D event->header.size;
> +       u64 i, k;
> +       int ret;
> +
> +       if (event_copy =3D=3D NULL) {
> +               inject->event_copy =3D malloc(PERF_SAMPLE_MAX_SIZE);
> +               if (!inject->event_copy)
> +                       return -ENOMEM;
> +
> +               event_copy =3D (void *)inject->event_copy;
> +       }
> +
> +       if (cursor =3D=3D NULL)
> +               return perf_event__repipe_synth(tool, event);
> +
> +       callchain_cursor_reset(cursor);
> +
> +       thread =3D machine__find_thread(machine, -1, sample->pid);
> +       if (thread =3D=3D NULL)
> +               return perf_event__repipe_synth(tool, event);
> +
> +       /* this will parse DWARF using stack and register data */
> +       ret =3D thread__resolve_callchain(thread, cursor, evsel, sample,
> +                                       /*parent=3D*/NULL, /*root_al=3D*/=
NULL,
> +                                       PERF_MAX_STACK_DEPTH);
> +       thread__put(thread);
> +       if (ret !=3D 0)
> +               return perf_event__repipe_synth(tool, event);
> +
> +       /* copy kernel callchain and context entries */
> +       for (i =3D 0; i < sample->callchain->nr; i++) {
> +               inject->raw_callchain->ips[i] =3D sample->callchain->ips[=
i];
> +               if (sample->callchain->ips[i] =3D=3D PERF_CONTEXT_USER) {
> +                       i++;
> +                       break;
> +               }
> +       }
> +       if (i =3D=3D 0 || inject->raw_callchain->ips[i - 1] !=3D PERF_CON=
TEXT_USER)
> +               inject->raw_callchain->ips[i++] =3D PERF_CONTEXT_USER;
> +
> +       node =3D cursor->first;
> +       for (k =3D 0; k < cursor->nr && i < PERF_MAX_STACK_DEPTH; k++) {
> +               if (node->ms.map && __map__is_kernel(node->ms.map))
> +                       /* kernel IPs were added already */;
> +               else if (node->ms.sym && node->ms.sym->inlined)
> +                       /* we don't handle inlined symbols */;
> +               else
> +                       inject->raw_callchain->ips[i++] =3D node->ip;
> +
> +               node =3D node->next;
> +       }
> +
> +       inject->raw_callchain->nr =3D i;
> +       sample->callchain =3D inject->raw_callchain;
> +
> +       memcpy(event_copy, event, sizeof(event->header));
> +
> +       /* adjust sample size for stack and regs */
> +       sample_size -=3D sample->user_stack.size;
> +       sample_size -=3D (hweight64(evsel->core.attr.sample_regs_user) + =
1) * sizeof(u64);
> +       sample_size +=3D (sample->callchain->nr + 1) * sizeof(u64);
> +       event_copy->header.size =3D sample_size;
> +
> +       /* remove sample_type {STACK,REGS}_USER for synthesize */
> +       sample_type &=3D ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER=
);
> +
> +       perf_event__synthesize_sample(event_copy, sample_type,
> +                                     evsel->core.attr.read_format, sampl=
e);
> +       return perf_event__repipe_synth(tool, event_copy);
> +}
> +
>  static struct dso *findnew_dso(int pid, int tid, const char *filename,
>                                const struct dso_id *id, struct machine *m=
achine)
>  {
> @@ -2270,6 +2355,13 @@ static int __cmd_inject(struct perf_inject *inject=
)
>                 /* Allow space in the header for guest attributes */
>                 output_data_offset +=3D gs->session->header.data_offset;
>                 output_data_offset =3D roundup(output_data_offset, 4096);
> +       } else if (inject->convert_callchain) {

The "else" here is a problem as you may want to do build ID injection,
for example, while also rewriting the callchains. A solution to this
is the delegate tool:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/tool.h?h=3Dperf-tools-next#n107
where you rewrite samples in the delegate tool and then pass
everything through to the regular inject tool.

> +               inject->tool.sample     =3D perf_event__convert_sample_ca=
llchain;
> +               inject->tool.fork       =3D perf_event__repipe_fork;
> +               inject->tool.comm       =3D perf_event__repipe_comm;
> +               inject->tool.exit       =3D perf_event__repipe_exit;
> +               inject->tool.mmap       =3D perf_event__repipe_mmap;
> +               inject->tool.mmap2      =3D perf_event__repipe_mmap2;
>         }
>
>         if (!inject->itrace_synth_opts.set)
> @@ -2322,6 +2414,23 @@ static int __cmd_inject(struct perf_inject *inject=
)
>                                 perf_header__set_feat(&session->header,
>                                                       HEADER_BRANCH_STACK=
);
>                 }
> +
> +               /*
> +                * The converted data file won't have stack and registers=
.
> +                * Update the perf_event_attr to remove them before writi=
ng.
> +                */
> +               if (inject->convert_callchain) {
> +                       struct evsel *evsel;
> +
> +                       evlist__for_each_entry(session->evlist, evsel) {
> +                               evsel__reset_sample_bit(evsel, REGS_USER)=
;
> +                               evsel__reset_sample_bit(evsel, STACK_USER=
);
> +                               evsel->core.attr.sample_regs_user =3D 0;
> +                               evsel->core.attr.sample_stack_user =3D 0;
> +                               evsel->core.attr.exclude_callchain_user =
=3D 0;
> +                       }

I think the delegate tool also makes these cleaner as potentially
things can break if the struct perf_sample data is out of sync with
the evlist. With a delegate tool you can have a notion of incoming and
outgoing state, and match the incoming and outgoing evlists.

I'm not sure how serious this feedback should be taken, the whole good
vs perfect argument. I think the only other thing missing is a test,
and turning the commit message into one doesn't appear too difficult.

Thanks,
Ian

> +               }
> +
>                 session->header.data_offset =3D output_data_offset;
>                 session->header.data_size =3D inject->bytes_written;
>                 perf_session__inject_header(session, session->evlist, fd,=
 &inj_fc.fc,
> @@ -2414,6 +2523,8 @@ int cmd_inject(int argc, const char **argv)
>                 OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "dir=
ectory",
>                            "guest mount directory under which every guest=
 os"
>                            " instance has a subdir"),
> +               OPT_BOOLEAN(0, "convert-callchain", &inject.convert_callc=
hain,
> +                           "Generate callchains using DWARF and drop reg=
ister/stack data"),
>                 OPT_END()
>         };
>         const char * const inject_usage[] =3D {
> @@ -2429,6 +2540,9 @@ int cmd_inject(int argc, const char **argv)
>
>  #ifndef HAVE_JITDUMP
>         set_option_nobuild(options, 'j', "jit", "NO_LIBELF=3D1", true);
> +#endif
> +#ifndef HAVE_LIBDW_SUPPORT
> +       set_option_nobuild(options, 0, "convert-callchain", "NO_LIBDW=3D1=
", true);
>  #endif
>         argc =3D parse_options(argc, argv, options, inject_usage, 0);
>
> @@ -2588,6 +2702,19 @@ int cmd_inject(int argc, const char **argv)
>                 }
>         }
>
> +       if (inject.convert_callchain) {
> +               if (inject->output.is_pipe || inject->session->data->is_p=
ipe) {
> +                       pr_err("--convert-callchain cannot work with pipe=
\n");
> +                       goto out_delete;
> +               }
> +
> +               inject.raw_callchain =3D calloc(PERF_MAX_STACK_DEPTH, siz=
eof(u64));
> +               if (inject.raw_callchain =3D=3D NULL) {
> +                       pr_err("callchain allocation failed\n");
> +                       goto out_delete;
> +               }
> +       }
> +
>  #ifdef HAVE_JITDUMP
>         if (inject.jit_mode) {
>                 inject.tool.mmap2          =3D perf_event__repipe_mmap2;
> @@ -2618,5 +2745,6 @@ int cmd_inject(int argc, const char **argv)
>         free(inject.itrace_synth_opts.vm_tm_corr_args);
>         free(inject.event_copy);
>         free(inject.guest_session.ev.event_buf);
> +       free(inject.raw_callchain);
>         return ret;
>  }
> --
> 2.52.0.322.g1dd061c0dc-goog
>
