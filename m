Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CC38DF9
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978235; cv=none; b=F5kkdiurzdP49f/j7PUoYoH+hBpaOZNc3BQXg1tLRDxmQ2g0O4ueWqlO4goBUO5owmB/BfhTZmbpvY6DQsIWFLUqmM6f0wbPusCqFGMAL+nG40w0naTpe7hUQ2Rl4qzhNGoc0VXZIg+2swdWAxObzN7V06EK1Mznm6A+uYwNKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978235; c=relaxed/simple;
	bh=ILMThtuJukZMbaHpdp2HyhvT1aUGhnLphDv3QOandVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aniD2T+KrcfGXi3tKjnOG4TNMAopE1O8aDcDZu08kxonxgyAn38aUof19aqez7Z/VZZauUQkTqC6iV7r470yLEc5rR7Ij7aFhKs3Tbr7COZipC57QyKRw0BJpfEJ33OapYjxTeXlbYh7581UiyAqXIBS98/BMijQIZkJAxD1Ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4RIUE2J; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4RIUE2J"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so53335ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Nov 2024 17:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731978233; x=1732583033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA9rDlvHIHi7yGi+kw0V+50bIO2WwY8J/y9wwmA7KNU=;
        b=q4RIUE2Jp1mB9t8eA+fth5pm5P6tcPVp7phbcf28y8xACmB+kQjBhnM4L3GyfeRlao
         Rf1WQQtxB+43LmbRqzmH8dgPnA4zAoH9d64/07laykkXL0Wk9BE9Ru35Hyl4fs+wOX2H
         fq+grkYYvZssrheY8/EylEJSx1TutbqhDRX2vtbW9I90QA3jO/raWYb/vGYpKh9aklw7
         /A51jx+m+kodr76PCtIcaGVJ7Kcya8Ttqhb/L1It5V8M9XUCf9to8EoITDwFTedkW9YR
         DDZ+XDWLukLtIoarareXDyuy4N/iPgO361MkhBQx5YhccuETN6g1Qedh/on4AwncMAuw
         cTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731978233; x=1732583033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA9rDlvHIHi7yGi+kw0V+50bIO2WwY8J/y9wwmA7KNU=;
        b=ADvn4O7w9Ir2Jcw7XM4E324/1GpzldeCIZndWMjqjFipDMBtM9zcwSoKZfCd7UzblA
         23N0/a2EPwA0DyRMZ2Gm7u3TTHYhqyACxhjlcyKnl1Luwi8qJZC+pgmBXOVtgHXNIoEw
         I/6pl7Czkk6ZSF3RQfV8WIadBWBK4In0j+vKOTLlmxNg6X1/yhE23aeZzpBJIeyv2v+9
         NId/YQiR269pq9yRE9GsCU6lPpqjwoOGCpK1s/bp5hyEbZgT4MMWoWzQX2PfojursxvB
         8X2mQHEGQ9fJV/LCa5lQZG7IZbs8okOuAd2WLldNKIkwuLW8JVM/6k+KHy6yuEMuYlQ3
         R48Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIiEHqgUizDRAQsNJAfDKcQhPk3Sm2ATnRZSMrXoFsPrtEa4FCsUfY9oB/K6gjxMV1dGjBFTYMcT0UiEj4xSEJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc/p7T9Du4VU/43Twa2avcKvungxbCe9KmBlfj+hF9bymYMDgH
	aHv+UjR2O3u3c+zeUngAS3UpDLob+bqw1gz7101x/CkG5c+WwA3TWsT/4R+Erk9UlZflOjml5yq
	+lI1QFsPrKzRK3DPcOxEvSQoxwh+FeMupA7YL
X-Gm-Gg: ASbGncsS48e2K1xOJigzreNxlz1iIwyzTTxegPTVEwvyj4OzytIr75L5tbEC9JdLl5q
	vkwerXtLAGxKvItoZmaVnTFuNmXDSTKnj
X-Google-Smtp-Source: AGHT+IFgN4C+Z0C2toxDvFv9l6ONOveg3k1sk0+6Cq8mMlVdyGi7gFZRaVJCNiNIkLHnuEogl3hm9crAjYYzEh6qLO8=
X-Received: by 2002:a05:6e02:1a65:b0:3a3:632e:efed with SMTP id
 e9e14a558f8ab-3a7782b2212mr1568695ab.26.1731978232378; Mon, 18 Nov 2024
 17:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com> <20241109061809.811922-16-irogers@google.com>
 <Zzvac4IeX9nDDitm@google.com>
In-Reply-To: <Zzvac4IeX9nDDitm@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 18 Nov 2024 17:03:41 -0800
Message-ID: <CAP-5=fUPksNCJ-NqUbJMDpfS7kkmXGsCVhvALkts8HDv42NUyg@mail.gmail.com>
Subject: Re: [PATCH v6 15/22] perf lock: Move common lock contention code to
 new file
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 4:23=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 08, 2024 at 10:18:02PM -0800, Ian Rogers wrote:
> > Avoid references from util code to builtin-lock that require python
> > stubs. Move the functions and related variables to
> > util/lock-contention.c. Add max_stack_depth parameter to
> > match_callstack_filter to avoid sharing a global variable.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-lock.c             | 137 +--------------------
> >  tools/perf/util/Build                 |   1 +
> >  tools/perf/util/bpf_lock_contention.c |   2 +-
> >  tools/perf/util/lock-contention.c     | 170 ++++++++++++++++++++++++++
> >  tools/perf/util/lock-contention.h     |  37 ++----
> >  tools/perf/util/python.c              |  17 ---
> >  6 files changed, 185 insertions(+), 179 deletions(-)
> >  create mode 100644 tools/perf/util/lock-contention.c
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 062e2b56a2ab..f66948b1fbed 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -46,15 +46,6 @@
> >  static struct perf_session *session;
> >  static struct target target;
> >
> > -/* based on kernel/lockdep.c */
> > -#define LOCKHASH_BITS                12
> > -#define LOCKHASH_SIZE                (1UL << LOCKHASH_BITS)
> > -
> > -static struct hlist_head *lockhash_table;
> > -
> > -#define __lockhashfn(key)    hash_long((unsigned long)key, LOCKHASH_BI=
TS)
> > -#define lockhashentry(key)   (lockhash_table + __lockhashfn((key)))
> > -
> >  static struct rb_root                thread_stats;
> >
> >  static bool combine_locks;
> > @@ -67,24 +58,13 @@ static unsigned long bpf_map_entries =3D MAX_ENTRIE=
S;
> >  static int max_stack_depth =3D CONTENTION_STACK_DEPTH;
> >  static int stack_skip =3D CONTENTION_STACK_SKIP;
> >  static int print_nr_entries =3D INT_MAX / 2;
> > -static LIST_HEAD(callstack_filters);
> >  static const char *output_name =3D NULL;
> >  static FILE *lock_output;
> >
> > -struct callstack_filter {
> > -     struct list_head list;
> > -     char name[];
> > -};
> > -
> >  static struct lock_filter filters;
> >
> >  static enum lock_aggr_mode aggr_mode =3D LOCK_AGGR_ADDR;
> >
> > -static bool needs_callstack(void)
> > -{
> > -     return !list_empty(&callstack_filters);
> > -}
> > -
> >  static struct thread_stat *thread_stat_find(u32 tid)
> >  {
> >       struct rb_node *node;
> > @@ -477,93 +457,6 @@ static struct lock_stat *pop_from_result(void)
> >       return container_of(node, struct lock_stat, rb);
> >  }
> >
> > -struct lock_stat *lock_stat_find(u64 addr)
> > -{
> > -     struct hlist_head *entry =3D lockhashentry(addr);
> > -     struct lock_stat *ret;
> > -
> > -     hlist_for_each_entry(ret, entry, hash_entry) {
> > -             if (ret->addr =3D=3D addr)
> > -                     return ret;
> > -     }
> > -     return NULL;
> > -}
> > -
> > -struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int fl=
ags)
> > -{
> > -     struct hlist_head *entry =3D lockhashentry(addr);
> > -     struct lock_stat *ret, *new;
> > -
> > -     hlist_for_each_entry(ret, entry, hash_entry) {
> > -             if (ret->addr =3D=3D addr)
> > -                     return ret;
> > -     }
> > -
> > -     new =3D zalloc(sizeof(struct lock_stat));
> > -     if (!new)
> > -             goto alloc_failed;
> > -
> > -     new->addr =3D addr;
> > -     new->name =3D strdup(name);
> > -     if (!new->name) {
> > -             free(new);
> > -             goto alloc_failed;
> > -     }
> > -
> > -     new->flags =3D flags;
> > -     new->wait_time_min =3D ULLONG_MAX;
> > -
> > -     hlist_add_head(&new->hash_entry, entry);
> > -     return new;
> > -
> > -alloc_failed:
> > -     pr_err("memory allocation failed\n");
> > -     return NULL;
> > -}
> > -
> > -bool match_callstack_filter(struct machine *machine, u64 *callstack)
> > -{
> > -     struct map *kmap;
> > -     struct symbol *sym;
> > -     u64 ip;
> > -     const char *arch =3D perf_env__arch(machine->env);
> > -
> > -     if (list_empty(&callstack_filters))
> > -             return true;
> > -
> > -     for (int i =3D 0; i < max_stack_depth; i++) {
> > -             struct callstack_filter *filter;
> > -
> > -             /*
> > -              * In powerpc, the callchain saved by kernel always inclu=
des
> > -              * first three entries as the NIP (next instruction point=
er),
> > -              * LR (link register), and the contents of LR save area i=
n the
> > -              * second stack frame. In certain scenarios its possible =
to have
> > -              * invalid kernel instruction addresses in either LR or t=
he second
> > -              * stack frame's LR. In that case, kernel will store that=
 address as
> > -              * zero.
> > -              *
> > -              * The below check will continue to look into callstack,
> > -              * incase first or second callstack index entry has 0
> > -              * address for powerpc.
> > -              */
> > -             if (!callstack || (!callstack[i] && (strcmp(arch, "powerp=
c") ||
> > -                                             (i !=3D 1 && i !=3D 2))))
> > -                     break;
> > -
> > -             ip =3D callstack[i];
> > -             sym =3D machine__find_kernel_symbol(machine, ip, &kmap);
> > -             if (sym =3D=3D NULL)
> > -                     continue;
> > -
> > -             list_for_each_entry(filter, &callstack_filters, list) {
> > -                     if (strstr(sym->name, filter->name))
> > -                             return true;
> > -             }
> > -     }
> > -     return false;
> > -}
> > -
> >  struct trace_lock_handler {
> >       /* it's used on CONFIG_LOCKDEP */
> >       int (*acquire_event)(struct evsel *evsel,
> > @@ -1165,7 +1058,7 @@ static int report_lock_contention_begin_event(str=
uct evsel *evsel,
> >               if (callstack =3D=3D NULL)
> >                       return -ENOMEM;
> >
> > -             if (!match_callstack_filter(machine, callstack)) {
> > +             if (!match_callstack_filter(machine, callstack, max_stack=
_depth)) {
> >                       free(callstack);
> >                       return 0;
> >               }
> > @@ -2449,34 +2342,6 @@ static int parse_lock_addr(const struct option *=
opt __maybe_unused, const char *
> >       return ret;
> >  }
> >
> > -static int parse_call_stack(const struct option *opt __maybe_unused, c=
onst char *str,
> > -                        int unset __maybe_unused)
> > -{
> > -     char *s, *tmp, *tok;
> > -     int ret =3D 0;
> > -
> > -     s =3D strdup(str);
> > -     if (s =3D=3D NULL)
> > -             return -1;
> > -
> > -     for (tok =3D strtok_r(s, ", ", &tmp); tok; tok =3D strtok_r(NULL,=
 ", ", &tmp)) {
> > -             struct callstack_filter *entry;
> > -
> > -             entry =3D malloc(sizeof(*entry) + strlen(tok) + 1);
> > -             if (entry =3D=3D NULL) {
> > -                     pr_err("Memory allocation failure\n");
> > -                     free(s);
> > -                     return -1;
> > -             }
> > -
> > -             strcpy(entry->name, tok);
> > -             list_add_tail(&entry->list, &callstack_filters);
> > -     }
> > -
> > -     free(s);
> > -     return ret;
> > -}
> > -
> >  static int parse_output(const struct option *opt __maybe_unused, const=
 char *str,
> >                       int unset __maybe_unused)
> >  {
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 340544a6f5ec..3c6cd8d81d88 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -121,6 +121,7 @@ perf-util-y +=3D topdown.o
> >  perf-util-y +=3D iostat.o
> >  perf-util-y +=3D stream.o
> >  perf-util-y +=3D kvm-stat.o
> > +perf-util-y +=3D lock-contention.o
> >  perf-util-$(CONFIG_AUXTRACE) +=3D auxtrace.o
> >  perf-util-y +=3D intel-pt-decoder/
> >  perf-util-$(CONFIG_AUXTRACE) +=3D intel-pt.o
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bp=
f_lock_contention.c
> > index 41a1ad087895..37e17c56f106 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -458,7 +458,7 @@ int lock_contention_read(struct lock_contention *co=
n)
> >               if (con->save_callstack) {
> >                       bpf_map_lookup_elem(stack, &key.stack_id, stack_t=
race);
> >
> > -                     if (!match_callstack_filter(machine, stack_trace)=
) {
> > +                     if (!match_callstack_filter(machine, stack_trace,=
 con->max_stack)) {
> >                               con->nr_filtered +=3D data.count;
> >                               goto next;
> >                       }
> > diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-c=
ontention.c
> > new file mode 100644
> > index 000000000000..841bb18b1f06
> > --- /dev/null
> > +++ b/tools/perf/util/lock-contention.c
> > @@ -0,0 +1,170 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "debug.h"
> > +#include "env.h"
> > +#include "lock-contention.h"
> > +#include "machine.h"
> > +#include "symbol.h"
> > +
> > +#include <limits.h>
> > +#include <string.h>
> > +
> > +#include <linux/hash.h>
> > +#include <linux/zalloc.h>
> > +
> > +#define __lockhashfn(key)    hash_long((unsigned long)key, LOCKHASH_BI=
TS)
> > +#define lockhashentry(key)   (lockhash_table + __lockhashfn((key)))
> > +
> > +struct callstack_filter {
> > +     struct list_head list;
> > +     char name[];
> > +};
> > +
> > +static LIST_HEAD(callstack_filters);
> > +struct hlist_head *lockhash_table;
> > +
> > +int parse_call_stack(const struct option *opt __maybe_unused, const ch=
ar *str,
> > +                  int unset __maybe_unused)
> > +{
> > +     char *s, *tmp, *tok;
> > +     int ret =3D 0;
> > +
> > +     s =3D strdup(str);
> > +     if (s =3D=3D NULL)
> > +             return -1;
> > +
> > +     for (tok =3D strtok_r(s, ", ", &tmp); tok; tok =3D strtok_r(NULL,=
 ", ", &tmp)) {
> > +             struct callstack_filter *entry;
> > +
> > +             entry =3D malloc(sizeof(*entry) + strlen(tok) + 1);
> > +             if (entry =3D=3D NULL) {
> > +                     pr_err("Memory allocation failure\n");
> > +                     free(s);
> > +                     return -1;
> > +             }
> > +
> > +             strcpy(entry->name, tok);
> > +             list_add_tail(&entry->list, &callstack_filters);
> > +     }
> > +
> > +     free(s);
> > +     return ret;
> > +}
> > +
> > +bool needs_callstack(void)
> > +{
> > +     return !list_empty(&callstack_filters);
> > +}
> > +
> > +struct lock_stat *lock_stat_find(u64 addr)
> > +{
> > +     struct hlist_head *entry =3D lockhashentry(addr);
> > +     struct lock_stat *ret;
> > +
> > +     hlist_for_each_entry(ret, entry, hash_entry) {
> > +             if (ret->addr =3D=3D addr)
> > +                     return ret;
> > +     }
> > +     return NULL;
> > +}
> > +
> > +struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int fl=
ags)
> > +{
> > +     struct hlist_head *entry =3D lockhashentry(addr);
> > +     struct lock_stat *ret, *new;
> > +
> > +     hlist_for_each_entry(ret, entry, hash_entry) {
> > +             if (ret->addr =3D=3D addr)
> > +                     return ret;
> > +     }
> > +
> > +     new =3D zalloc(sizeof(struct lock_stat));
> > +     if (!new)
> > +             goto alloc_failed;
> > +
> > +     new->addr =3D addr;
> > +     new->name =3D strdup(name);
> > +     if (!new->name) {
> > +             free(new);
> > +             goto alloc_failed;
> > +     }
> > +
> > +     new->flags =3D flags;
> > +     new->wait_time_min =3D ULLONG_MAX;
> > +
> > +     hlist_add_head(&new->hash_entry, entry);
> > +     return new;
> > +
> > +alloc_failed:
> > +     pr_err("memory allocation failed\n");
> > +     return NULL;
> > +}
> > +
> > +bool match_callstack_filter(struct machine *machine, u64 *callstack, i=
nt max_stack_depth)
> > +{
> > +     struct map *kmap;
> > +     struct symbol *sym;
> > +     u64 ip;
> > +     const char *arch =3D perf_env__arch(machine->env);
> > +
> > +     if (list_empty(&callstack_filters))
> > +             return true;
> > +
> > +     for (int i =3D 0; i < max_stack_depth; i++) {
> > +             struct callstack_filter *filter;
> > +
> > +             /*
> > +              * In powerpc, the callchain saved by kernel always inclu=
des
> > +              * first three entries as the NIP (next instruction point=
er),
> > +              * LR (link register), and the contents of LR save area i=
n the
> > +              * second stack frame. In certain scenarios its possible =
to have
> > +              * invalid kernel instruction addresses in either LR or t=
he second
> > +              * stack frame's LR. In that case, kernel will store that=
 address as
> > +              * zero.
> > +              *
> > +              * The below check will continue to look into callstack,
> > +              * incase first or second callstack index entry has 0
> > +              * address for powerpc.
> > +              */
> > +             if (!callstack || (!callstack[i] && (strcmp(arch, "powerp=
c") ||
> > +                                             (i !=3D 1 && i !=3D 2))))
> > +                     break;
> > +
> > +             ip =3D callstack[i];
> > +             sym =3D machine__find_kernel_symbol(machine, ip, &kmap);
> > +             if (sym =3D=3D NULL)
> > +                     continue;
> > +
> > +             list_for_each_entry(filter, &callstack_filters, list) {
> > +                     if (strstr(sym->name, filter->name))
> > +                             return true;
> > +             }
> > +     }
> > +     return false;
> > +}
> > +
> > +#ifndef HAVE_BPF_SKEL
> > +int lock_contention_prepare(struct lock_contention *con __maybe_unused=
)
> > +{
> > +     return 0;
> > +}
> > +
> > +int lock_contention_start(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +int lock_contention_stop(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +int lock_contention_finish(struct lock_contention *con __maybe_unused)
> > +{
> > +     return 0;
> > +}
> > +
> > +int lock_contention_read(struct lock_contention *con __maybe_unused)
> > +{
> > +     return 0;
> > +}
> > +#endif  /* !HAVE_BPF_SKEL */
>
> I still think it's the convention to have them in a header file as
> static inline functions and reduce the #ifdef in the .c file.

Shouldn't minimizing ifdefs, and associated cognitive load, in header
files be the priority given they are #included many times while the .c
file is only compiled once?
Shouldn't a goal of the header file be to abstract away things like
HAVE_BPF_SKEL?
I'm not clear what the goal of having the functions in the header
files is, performance? The code isn't going to run anyway. I feel
lock_contention.h is smaller and easier to read like this but I also
don't care enough to fight. I did this change here as
lock_contention.h was being brought into python.c for the sake of
stubbing out functions that the header file was also subbing out for
!BPF_HAVE_SKEL. A single stub felt like progress.

Thanks,
Ian

> > diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-c=
ontention.h
> > index 1a7248ff3889..bfa5c7db0a5d 100644
> > --- a/tools/perf/util/lock-contention.h
> > +++ b/tools/perf/util/lock-contention.h
> > @@ -67,10 +67,11 @@ struct lock_stat {
> >   */
> >  #define MAX_LOCK_DEPTH 48
> >
> > -struct lock_stat *lock_stat_find(u64 addr);
> > -struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int fl=
ags);
> > +/* based on kernel/lockdep.c */
> > +#define LOCKHASH_BITS                12
> > +#define LOCKHASH_SIZE                (1UL << LOCKHASH_BITS)
> >
> > -bool match_callstack_filter(struct machine *machine, u64 *callstack);
> > +extern struct hlist_head *lockhash_table;
> >
> >  /*
> >   * struct lock_seq_stat:
> > @@ -148,7 +149,14 @@ struct lock_contention {
> >       bool save_callstack;
> >  };
> >
> > -#ifdef HAVE_BPF_SKEL
> > +struct option;
> > +int parse_call_stack(const struct option *opt, const char *str, int un=
set);
> > +bool needs_callstack(void);
> > +
> > +struct lock_stat *lock_stat_find(u64 addr);
> > +struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int fl=
ags);
> > +
> > +bool match_callstack_filter(struct machine *machine, u64 *callstack, i=
nt max_stack_depth);
> >
> >  int lock_contention_prepare(struct lock_contention *con);
> >  int lock_contention_start(void);
> > @@ -156,25 +164,4 @@ int lock_contention_stop(void);
> >  int lock_contention_read(struct lock_contention *con);
> >  int lock_contention_finish(struct lock_contention *con);
> >
> > -#else  /* !HAVE_BPF_SKEL */
> > -
> > -static inline int lock_contention_prepare(struct lock_contention *con =
__maybe_unused)
> > -{
> > -     return 0;
> > -}
> > -
> > -static inline int lock_contention_start(void) { return 0; }
> > -static inline int lock_contention_stop(void) { return 0; }
> > -static inline int lock_contention_finish(struct lock_contention *con _=
_maybe_unused)
> > -{
> > -     return 0;
> > -}
> > -
> > -static inline int lock_contention_read(struct lock_contention *con __m=
aybe_unused)
> > -{
> > -     return 0;
> > -}
> > -
> > -#endif  /* HAVE_BPF_SKEL */
> > -
> >  #endif  /* PERF_LOCK_CONTENTION_H */
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 35d84a96dbec..91fd444615cd 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -18,7 +18,6 @@
> >  #include "mmap.h"
> >  #include "util/kwork.h"
> >  #include "util/sample.h"
> > -#include "util/lock-contention.h"
> >  #include <internal/lib.h>
> >  #include "../builtin.h"
> >
> > @@ -1311,22 +1310,6 @@ struct kwork_work *perf_kwork_add_work(struct pe=
rf_kwork *kwork __maybe_unused,
> >       return NULL;
> >  }
> >
> > -bool match_callstack_filter(struct machine *machine __maybe_unused, u6=
4 *callstack __maybe_unused)
> > -{
> > -     return false;
> > -}
> > -
> > -struct lock_stat *lock_stat_find(u64 addr __maybe_unused)
> > -{
> > -     return NULL;
> > -}
> > -
> > -struct lock_stat *lock_stat_findnew(u64 addr __maybe_unused, const cha=
r *name __maybe_unused,
> > -                             int flags __maybe_unused)
> > -{
> > -     return NULL;
> > -}
> > -
> >  int cmd_inject(int argc __maybe_unused, const char *argv[] __maybe_unu=
sed)
> >  {
> >       return -1;
> > --
> > 2.47.0.277.g8800431eea-goog
> >
