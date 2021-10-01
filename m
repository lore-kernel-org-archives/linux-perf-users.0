Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB1C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Oct 2021 01:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03C761452
	for <linux-perf-users@archiver.kernel.org>; Fri,  1 Oct 2021 01:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351140AbhJABYQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 21:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351046AbhJABYP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Sep 2021 21:24:15 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A475C06176A
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Sep 2021 18:22:32 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 66so9553150vsd.11
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Sep 2021 18:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=MfteCPxyYjPWCEGGwrykwxh7TlDuFKwMtUUSHbzx3VQ=;
        b=mQTax89o0jMuEO2TjlWDKwTQghRwmEfBmluBCfRYMSy7YTA2pJolsyUkbcGjZWlLSS
         u/sPTZR+NSCoPDiQSqzgXjW5TLXV6n2fHqBQxkecaPdF4Q7MDvOMbpfEoddvqyZZgplN
         4iUY/3SpjjU7YsLfftKfFPBmRGaUpArmnUH/kiBKrF81vilm0qvTRUlcHqmoD/dK2UlJ
         TkvbX6TZ4iaYZ7hL74GtNmKxW4+pmBvNpeAPBf/grXJgaa4qeDFxSZzjoxfhk0g6wmWs
         sjRt8DPaXKxZp3B0sYFCn8iDjDdw980r3iA9OXl+6WhLK1KXPeKE0Oa5KX6QmyG4MSl7
         nJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=MfteCPxyYjPWCEGGwrykwxh7TlDuFKwMtUUSHbzx3VQ=;
        b=zxfkB+UtBx5RVeYQitAMUH2Qt7C/ubsR+9BhnxAkrqvtomw4Eg76lcR1AAeKGYVgzZ
         j1KKGfyPmtJAK89BiZwfx265ggrfWOp+oeQy0kAp0+3eQJ+jrVgsYetX0dU93yMtNVSa
         cv82GFL3Hxe4MWuT0aGltE3YylGkxsois+ylz1I3f/xkG+CyBHmuxOJbqDyFi/GvtbkV
         f81AtOpoMXksDTEFsfUowi8WoiJAcrwcN2IJOqpLsGboGAykxHElH4MhsP/70N+L1NRh
         eN3VF8+ipSEgFmFcY5NrjO351vl9OVovampHtwBOh/cOU32w4Ff0kMQVo+4DnX8+WVoN
         WiHQ==
X-Gm-Message-State: AOAM5328OfvNNmkzii8isYg6k1YnMU+JS01bDzPxv1+14iwCykBeLCb2
        V79b2gdGVhC17CbrduURaCI=
X-Google-Smtp-Source: ABdhPJynuqqrU8JfRZXIwt9yJjKTCwZTmuOMLG06Y/xc+9rhHc/T9LPUt/CFmC/+mGugvggWT0S6aA==
X-Received: by 2002:a67:f147:: with SMTP id t7mr2309886vsm.41.1633051351309;
        Thu, 30 Sep 2021 18:22:31 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t64sm2558043vke.24.2021.09.30.18.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 18:22:30 -0700 (PDT)
Date:   Thu, 30 Sep 2021 22:20:41 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ian Rogers <irogers@google.com>,
        Tony Garnock-Jones <tonyg@leastfixedpoint.com>, acme@kernel.org
CC:     peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4] tools/perf: Use long-running addr2line per dso
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fWuxeSDa1gmHsLEJUcDXq+C-8j06ATOquE8ts0qFOuTTg@mail.gmail.com>
References: <YT+vJQFfSTE3EExF@kernel.org> <20210916120939.453536-1-tonyg@leastfixedpoint.com> <CAP-5=fWuxeSDa1gmHsLEJUcDXq+C-8j06ATOquE8ts0qFOuTTg@mail.gmail.com>
Message-ID: <3D12D1AC-C7AF-49FD-B557-33E0778702DB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On September 30, 2021 9:29:47 PM GMT-03:00, Ian Rogers <irogers@google=2Ec=
om> wrote:
>On Thu, Sep 16, 2021 at 5:09 AM Tony Garnock-Jones
><tonyg@leastfixedpoint=2Ecom> wrote:
>>
>> Invoking addr2line in a separate subprocess, one for each required
>> lookup, takes a terribly long time=2E This patch introduces a
>> long-running addr2line process for each dso, *DRAMATICALLY* speeding
>> up runs of perf=2E What used to take tens of minutes now takes tens of
>> seconds=2E
>>
>> Debian bug report about this issue:
>> https://bugs=2Edebian=2Eorg/cgi-bin/bugreport=2Ecgi?bug=3D911815
>>
>> Signed-off-by: Tony Garnock-Jones <tonyg@leastfixedpoint=2Ecom>
>> Tested-by: Ian Rogers <irogers@google=2Ecom>
>
>Hi Arnaldo,
>
>Is there anything further to do with this change?
>

I'll try and test/merge this tomorrow=2E

Thanks for the ping,

- Arnaldo

>Thanks,
>Ian
>
>> ---
>> Changes since v3:
>>  - use zfree(), plus some small code compaction edits
>>  - rebase against upstream master ff1ffd71d5f0612cf194f5705c671d6b64bf5=
f91
>>
>> Changes since v2:
>>  - remove redundant initializations to 0 and NULL
>>  - use terminology "record" instead of "stanza" for input from addr2lin=
e
>>
>> Changes since v1:
>>  - use "subcmd/run-command=2Eh" machinery instead of socketpair/fork/ex=
ec directly
>>
>>
>>  tools/perf/util/srcline=2Ec | 362 +++++++++++++++++++++++++++---------=
--
>>  1 file changed, 262 insertions(+), 100 deletions(-)
>>
>> diff --git a/tools/perf/util/srcline=2Ec b/tools/perf/util/srcline=2Ec
>> index 5b7d6c16d33f=2E=2Eaf468e3bb6fa 100644
>> --- a/tools/perf/util/srcline=2Ec
>> +++ b/tools/perf/util/srcline=2Ec
>> @@ -1,8 +1,10 @@
>>  // SPDX-License-Identifier: GPL-2=2E0
>>  #include <inttypes=2Eh>
>> +#include <signal=2Eh>
>>  #include <stdio=2Eh>
>>  #include <stdlib=2Eh>
>>  #include <string=2Eh>
>> +#include <sys/types=2Eh>
>>
>>  #include <linux/kernel=2Eh>
>>  #include <linux/string=2Eh>
>> @@ -15,6 +17,7 @@
>>  #include "srcline=2Eh"
>>  #include "string2=2Eh"
>>  #include "symbol=2Eh"
>> +#include "subcmd/run-command=2Eh"
>>
>>  bool srcline_full_filename;
>>
>> @@ -119,6 +122,8 @@ static struct symbol *new_inline_sym(struct dso *ds=
o,
>>         return inline_sym;
>>  }
>>
>> +#define MAX_INLINE_NEST 1024
>> +
>>  #ifdef HAVE_LIBBFD_SUPPORT
>>
>>  /*
>> @@ -273,8 +278,6 @@ static void addr2line_cleanup(struct a2l_data *a2l)
>>         free(a2l);
>>  }
>>
>> -#define MAX_INLINE_NEST 1024
>> -
>>  static int inline_list__append_dso_a2l(struct dso *dso,
>>                                        struct inline_node *node,
>>                                        struct symbol *sym)
>> @@ -361,26 +364,14 @@ void dso__free_a2l(struct dso *dso)
>>         dso->a2l =3D NULL;
>>  }
>>
>> -static struct inline_node *addr2inlines(const char *dso_name, u64 addr=
,
>> -                                       struct dso *dso, struct symbol =
*sym)
>> -{
>> -       struct inline_node *node;
>> -
>> -       node =3D zalloc(sizeof(*node));
>> -       if (node =3D=3D NULL) {
>> -               perror("not enough memory for the inline node");
>> -               return NULL;
>> -       }
>> -
>> -       INIT_LIST_HEAD(&node->val);
>> -       node->addr =3D addr;
>> -
>> -       addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
>> -       return node;
>> -}
>> -
>>  #else /* HAVE_LIBBFD_SUPPORT */
>>
>> +struct a2l_subprocess {
>> +       struct child_process addr2line;
>> +       FILE *to_child;
>> +       FILE *from_child;
>> +};
>> +
>>  static int filename_split(char *filename, unsigned int *line_nr)
>>  {
>>         char *sep;
>> @@ -402,114 +393,285 @@ static int filename_split(char *filename, unsig=
ned int *line_nr)
>>         return 0;
>>  }
>>
>> +static void addr2line_subprocess_cleanup(struct a2l_subprocess *a2l)
>> +{
>> +       if (a2l->addr2line=2Epid !=3D -1) {
>> +               kill(a2l->addr2line=2Epid, SIGKILL);
>> +               finish_command(&a2l->addr2line); /* ignore result, we d=
on't care */
>> +               a2l->addr2line=2Epid =3D -1;
>> +       }
>> +
>> +       if (a2l->to_child !=3D NULL) {
>> +               fclose(a2l->to_child);
>> +               a2l->to_child =3D NULL;
>> +       }
>> +
>> +       if (a2l->from_child !=3D NULL) {
>> +               fclose(a2l->from_child);
>> +               a2l->from_child =3D NULL;
>> +       }
>> +
>> +       free(a2l);
>> +}
>> +
>> +static struct a2l_subprocess *addr2line_subprocess_init(const char *pa=
th)
>> +{
>> +       const char *argv[] =3D { "addr2line", "-e", path, "-i", "-f", N=
ULL };
>> +       struct a2l_subprocess *a2l =3D zalloc(sizeof(*a2l));
>> +       int start_command_status =3D 0;
>> +
>> +       if (a2l =3D=3D NULL)
>> +               goto out;
>> +
>> +       a2l->to_child =3D NULL;
>> +       a2l->from_child =3D NULL;
>> +
>> +       a2l->addr2line=2Epid =3D -1;
>> +       a2l->addr2line=2Ein =3D -1;
>> +       a2l->addr2line=2Eout =3D -1;
>> +       a2l->addr2line=2Eno_stderr =3D 1;
>> +
>> +       a2l->addr2line=2Eargv =3D argv;
>> +       start_command_status =3D start_command(&a2l->addr2line);
>> +       a2l->addr2line=2Eargv =3D NULL; /* it's not used after start_co=
mmand; avoid dangling pointers */
>> +
>> +       if (start_command_status !=3D 0) {
>> +               pr_warning("could not start addr2line for %s: start_com=
mand return code %d\n",
>> +                          path,
>> +                          start_command_status);
>> +               goto out;
>> +       }
>> +
>> +       a2l->to_child =3D fdopen(a2l->addr2line=2Ein, "w");
>> +       if (a2l->to_child =3D=3D NULL) {
>> +               pr_warning("could not open write-stream to addr2line of=
 %s\n", path);
>> +               goto out;
>> +       }
>> +
>> +       a2l->from_child =3D fdopen(a2l->addr2line=2Eout, "r");
>> +       if (a2l->from_child =3D=3D NULL) {
>> +               pr_warning("could not open read-stream from addr2line o=
f %s\n", path);
>> +               goto out;
>> +       }
>> +
>> +       return a2l;
>> +
>> +out:
>> +       if (a2l)
>> +               addr2line_subprocess_cleanup(a2l);
>> +
>> +       return NULL;
>> +}
>> +
>> +static int read_addr2line_record(struct a2l_subprocess *a2l,
>> +                                char **function,
>> +                                char **filename,
>> +                                unsigned int *line_nr)
>> +{
>> +       /*
>> +        * Returns:
>> +        * -1 =3D=3D> error
>> +        * 0 =3D=3D> sentinel (or other ill-formed) record read
>> +        * 1 =3D=3D> a genuine record read
>> +        */
>> +       char *line =3D NULL;
>> +       size_t line_len =3D 0;
>> +       unsigned int dummy_line_nr =3D 0;
>> +       int ret =3D -1;
>> +
>> +       if (function !=3D NULL)
>> +               zfree(function);
>> +
>> +       if (filename !=3D NULL)
>> +               zfree(filename);
>> +
>> +       if (line_nr !=3D NULL)
>> +               *line_nr =3D 0;
>> +
>> +       if (getline(&line, &line_len, a2l->from_child) < 0 || !line_len=
)
>> +               goto error;
>> +
>> +       if (function !=3D NULL)
>> +               *function =3D strdup(strim(line));
>> +
>> +       zfree(&line);
>> +       line_len =3D 0;
>> +
>> +       if (getline(&line, &line_len, a2l->from_child) < 0 || !line_len=
)
>> +               goto error;
>> +
>> +       if (filename_split(line, line_nr =3D=3D NULL ? &dummy_line_nr :=
 line_nr) =3D=3D 0) {
>> +               ret =3D 0;
>> +               goto error;
>> +       }
>> +
>> +       if (filename !=3D NULL)
>> +               *filename =3D strdup(line);
>> +
>> +       zfree(&line);
>> +       line_len =3D 0;
>> +
>> +       return 1;
>> +
>> +error:
>> +       free(line);
>> +       if (function !=3D NULL)
>> +               zfree(function);
>> +       if (filename !=3D NULL)
>> +               zfree(filename);
>> +       return ret;
>> +}
>> +
>> +static int inline_list__append_record(struct dso *dso,
>> +                                     struct inline_node *node,
>> +                                     struct symbol *sym,
>> +                                     const char *function,
>> +                                     const char *filename,
>> +                                     unsigned int line_nr)
>> +{
>> +       struct symbol *inline_sym =3D new_inline_sym(dso, sym, function=
);
>> +
>> +       return inline_list__append(inline_sym, srcline_from_fileline(fi=
lename, line_nr), node);
>> +}
>> +
>>  static int addr2line(const char *dso_name, u64 addr,
>>                      char **file, unsigned int *line_nr,
>> -                    struct dso *dso __maybe_unused,
>> -                    bool unwind_inlines __maybe_unused,
>> -                    struct inline_node *node __maybe_unused,
>> +                    struct dso *dso,
>> +                    bool unwind_inlines,
>> +                    struct inline_node *node,
>>                      struct symbol *sym __maybe_unused)
>>  {
>> -       FILE *fp;
>> -       char cmd[PATH_MAX];
>> -       char *filename =3D NULL;
>> -       size_t len;
>> +       struct a2l_subprocess *a2l =3D dso->a2l;
>> +       char *record_function =3D NULL;
>> +       char *record_filename =3D NULL;
>> +       unsigned int record_line_nr =3D 0;
>> +       int record_status =3D -1;
>>         int ret =3D 0;
>> +       size_t inline_count =3D 0;
>>
>> -       scnprintf(cmd, sizeof(cmd), "addr2line -e %s %016"PRIx64,
>> -                 dso_name, addr);
>> +       if (!a2l) {
>> +               dso->a2l =3D addr2line_subprocess_init(dso_name);
>> +               a2l =3D dso->a2l;
>> +       }
>>
>> -       fp =3D popen(cmd, "r");
>> -       if (fp =3D=3D NULL) {
>> -               pr_warning("popen failed for %s\n", dso_name);
>> -               return 0;
>> +       if (a2l =3D=3D NULL) {
>> +               if (!symbol_conf=2Edisable_add2line_warn)
>> +                       pr_warning("%s %s: addr2line_subprocess_init fa=
iled\n", __func__, dso_name);
>> +               goto out;
>>         }
>>
>> -       if (getline(&filename, &len, fp) < 0 || !len) {
>> -               pr_warning("addr2line has no output for %s\n", dso_name=
);
>> +       /*
>> +        * Send our request and then *deliberately* send something that=
 can't be interpreted as
>> +        * a valid address to ask addr2line about (namely, ",")=2E This=
 causes addr2line to first
>> +        * write out the answer to our request, in an unbounded/unknown=
 number of records, and
>> +        * then to write out the lines "??" and "??:0", so that we can =
detect when it has
>> +        * finished giving us anything useful=2E We have to be careful =
about the first record,
>> +        * though, because it may be genuinely unknown, in which case w=
e'll get two sets of
>> +        * "??"/"??:0" lines=2E
>> +        */
>> +       if (fprintf(a2l->to_child, "%016"PRIx64"\n,\n", addr) < 0 || ff=
lush(a2l->to_child) !=3D 0) {
>> +               pr_warning("%s %s: could not send request\n", __func__,=
 dso_name);
>>                 goto out;
>>         }
>>
>> -       ret =3D filename_split(filename, line_nr);
>> -       if (ret !=3D 1) {
>> -               free(filename);
>> +       switch (read_addr2line_record(a2l, &record_function, &record_fi=
lename, &record_line_nr)) {
>> +       case -1:
>> +               pr_warning("%s %s: could not read first record\n", __fu=
nc__, dso_name);
>>                 goto out;
>> +       case 0:
>> +               /*
>> +                * The first record was invalid, so return failure, but=
 first read another
>> +                * record, since we asked a junk question and have to c=
lear the answer out=2E
>> +                */
>> +               switch (read_addr2line_record(a2l, NULL, NULL, NULL)) {
>> +               case -1:
>> +                       pr_warning("%s %s: could not read delimiter rec=
ord\n", __func__, dso_name);
>> +                       break;
>> +               case 0:
>> +                       /* As expected=2E */
>> +                       break;
>> +               default:
>> +                       pr_warning("%s %s: unexpected record instead of=
 sentinel",
>> +                                  __func__, dso_name);
>> +                       break;
>> +               }
>> +               goto out;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       if (file) {
>> +               *file =3D strdup(record_filename);
>> +               ret =3D 1;
>> +       }
>> +       if (line_nr)
>> +               *line_nr =3D record_line_nr;
>> +
>> +       if (unwind_inlines) {
>> +               if (node && inline_list__append_record(dso, node, sym,
>> +                                                      record_function,
>> +                                                      record_filename,
>> +                                                      record_line_nr))=
 {
>> +                       ret =3D 0;
>> +                       goto out;
>> +               }
>>         }
>>
>> -       *file =3D filename;
>> +       /* We have to read the records even if we don't care about the =
inline info=2E */
>> +       while ((record_status =3D read_addr2line_record(a2l,
>> +                                                     &record_function,
>> +                                                     &record_filename,
>> +                                                     &record_line_nr))=
 =3D=3D 1) {
>> +               if (unwind_inlines && node && inline_count++ < MAX_INLI=
NE_NEST) {
>> +                       if (inline_list__append_record(dso, node, sym,
>> +                                                      record_function,
>> +                                                      record_filename,
>> +                                                      record_line_nr))=
 {
>> +                               ret =3D 0;
>> +                               goto out;
>> +                       }
>> +                       ret =3D 1; /* found at least one inline frame *=
/
>> +               }
>> +       }
>>
>>  out:
>> -       pclose(fp);
>> +       free(record_function);
>> +       free(record_filename);
>>         return ret;
>>  }
>>
>> -void dso__free_a2l(struct dso *dso __maybe_unused)
>> +void dso__free_a2l(struct dso *dso)
>>  {
>> -}
>> +       struct a2l_subprocess *a2l =3D dso->a2l;
>>
>> -static struct inline_node *addr2inlines(const char *dso_name, u64 addr=
,
>> -                                       struct dso *dso __maybe_unused,
>> -                                       struct symbol *sym)
>> -{
>> -       FILE *fp;
>> -       char cmd[PATH_MAX];
>> -       struct inline_node *node;
>> -       char *filename =3D NULL;
>> -       char *funcname =3D NULL;
>> -       size_t filelen, funclen;
>> -       unsigned int line_nr =3D 0;
>> -
>> -       scnprintf(cmd, sizeof(cmd), "addr2line -e %s -i -f %016"PRIx64,
>> -                 dso_name, addr);
>> -
>> -       fp =3D popen(cmd, "r");
>> -       if (fp =3D=3D NULL) {
>> -               pr_err("popen failed for %s\n", dso_name);
>> -               return NULL;
>> -       }
>> -
>> -       node =3D zalloc(sizeof(*node));
>> -       if (node =3D=3D NULL) {
>> -               perror("not enough memory for the inline node");
>> -               goto out;
>> -       }
>> -
>> -       INIT_LIST_HEAD(&node->val);
>> -       node->addr =3D addr;
>> -
>> -       /* addr2line -f generates two lines for each inlined functions =
*/
>> -       while (getline(&funcname, &funclen, fp) !=3D -1) {
>> -               char *srcline;
>> -               struct symbol *inline_sym;
>> -
>> -               strim(funcname);
>> -
>> -               if (getline(&filename, &filelen, fp) =3D=3D -1)
>> -                       goto out;
>> -
>> -               if (filename_split(filename, &line_nr) !=3D 1)
>> -                       goto out;
>> -
>> -               srcline =3D srcline_from_fileline(filename, line_nr);
>> -               inline_sym =3D new_inline_sym(dso, sym, funcname);
>> -
>> -               if (inline_list__append(inline_sym, srcline, node) !=3D=
 0) {
>> -                       free(srcline);
>> -                       if (inline_sym && inline_sym->inlined)
>> -                               symbol__delete(inline_sym);
>> -                       goto out;
>> -               }
>> -       }
>> +       if (!a2l)
>> +               return;
>>
>> -out:
>> -       pclose(fp);
>> -       free(filename);
>> -       free(funcname);
>> +       addr2line_subprocess_cleanup(a2l);
>>
>> -       return node;
>> +       dso->a2l =3D NULL;
>>  }
>>
>>  #endif /* HAVE_LIBBFD_SUPPORT */
>>
>> +static struct inline_node *addr2inlines(const char *dso_name, u64 addr=
,
>> +                                       struct dso *dso, struct symbol =
*sym)
>> +{
>> +       struct inline_node *node;
>> +
>> +       node =3D zalloc(sizeof(*node));
>> +       if (node =3D=3D NULL) {
>> +               perror("not enough memory for the inline node");
>> +               return NULL;
>> +       }
>> +
>> +       INIT_LIST_HEAD(&node->val);
>> +       node->addr =3D addr;
>> +
>> +       addr2line(dso_name, addr, NULL, NULL, dso, true, node, sym);
>> +       return node;
>> +}
>> +
>>  /*
>>   * Number of addr2line failures (without success) before disabling it =
for that
>>   * dso=2E
>> --
>> 2=2E33=2E0
>>
