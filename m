Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B333ECBF0
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775085339; cv=none; b=WBxhTc6RrP1ACHbmlB2sZV2DTaxtx1P2ym+VhaYO8a2KADkxvE4nnSgimRX314AXMtP1+f2DG3nsQibzEk691nIqzb744S/sl1y/1Q1MgP6SMZt93kh/Xrt9MBxh7QtsgZCyiwQvrCkwOnwqBaSUSE1NRyEjWdOEoSE90FrzqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775085339; c=relaxed/simple;
	bh=TtVUOQKaY0t8W0yZrnUwobyNL8lgb9t8Ykx/Zy5kcmI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=opB9xfH98Rgo+N50Sp8sG/ubLPsu2VCT8iXjhn61tTx9Wxlq1DBwgeY5T4KHmqVWemCYfSSuTg4I3DMUQf4ftPnkzwsPfJs7ebIUWfRdD2epW1SQxGm+suD+Ja6f+c0lywvpcQLP7hemOxSfStrbdE0YiqNMzi/X6f+Drd2nSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCh00cq2; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCh00cq2"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba895adfeaso431756eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775085331; x=1775690131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1+pynA/jIIMTrQMOeUKFIb/jQRHATP0571zgo6RaCK0=;
        b=JCh00cq2FtQhiUjymXC8wLSel3Mc5rssHhGXeZaNaZqt0J0n11wRbTUs/7jysgjToD
         KwXm0Yr6R418ceImgxdQOWBYV7X7Kj+TPsCqI0G7+Fj3JkmBv5/7nKywnkx5viu4yq+I
         1jmHirx+uS+eGX5RhxVAq/7yM6K4ZH/xWON0wXhirSnDav0OgLpDRmnkte3EAYWCZwaU
         vXXccnGbnDBFj4AxrMAL2PfeuFNz+nKZvGFvokSCqSOGInMX2XgUBAKLuhnLBofkeFS9
         49oyZNjPS/U+OAv+aXPHIWP0XIexWB7y4qDNiVvmapS0yHIUHiHu19YC8cmFRhqfy+6m
         ZqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775085331; x=1775690131;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+pynA/jIIMTrQMOeUKFIb/jQRHATP0571zgo6RaCK0=;
        b=MYFH4PVQPMNb45UGIok6xQjOtgsiR7b4Xahh3qs+UNnZWofs5XD2gGYhrLkvIRmmah
         2XeytVyPXIYvcRIlUmwSZBgR5BvSudSYDyqJvPEvfaIYJ98ZeBCZCSH10EIg3yjxr+6/
         evXFM6UGvRUeQq6F+LAzDytm34r8NxbdxU34/UBM2DfJhABphJRSsDWekG8Wwm1Reovp
         uZJVnhVdSXsKkrSiBeQBqCfQNv+P4HHc+oCg9XW9imQWntur1TWp7G4eyCThydVUoRTw
         T04k5AZgafnLg7cWD3ghkxApLf1lALKsbH6xdSF3wLtN8UFbMOIPZSQOCsQy6WU+VWae
         YYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjdrdJCUgpS6LrLjOykE+IFlprs/As6ktS/z1n3lmzW9vXWs+RCFHh1GrVnCPik0ACSg0Y6dVrhqgGR2N01Eft@vger.kernel.org
X-Gm-Message-State: AOJu0YxRqnEvh0xjz8uv/4CfWSPyN+JjEd3eZ8S8ZUq9P8zfGkkbASxX
	OPn06Sbs/qLHw6D2g/FM9nsRnheC2WZaT1Z89xgwg0wejQkTENPF2fHk
X-Gm-Gg: ATEYQzxwkv5C1hemVUh3IS19xPU9hkrmjq62TC958vR1qgXzmKwfhPU8Zc2p3MTfDKS
	v75xoYpkF4MtlGTpHnOgJzhy9qxsdDCYV6TPidoZYzKf+1kwI65VAqIE5vD7GCUgDwY42aEWXnN
	kbEO+q+rFDP2TWrl+yExgnTzNovUzUqn1Me/8TN2dnHVLaZy7WFMJqHVoBRX9OUt26alw+2xDYk
	qpAD8F0T+kS8v7SQ9xwHvar81V4cNzEq/UUGjtkILqouIMPN9H1TYTIBgo/fXYu9SFe/nywUf9b
	oz/i9T8t7kI78S6H/s1heABXhfWeSLiZUgmea8/7n/HEWws+qKUT8dmQVw2eU8/j62AdznMF/ae
	ZCM88qPK5CC0ngB0nWbIwxxfSVNi/j43CJ/rEDmPlwiJsplDS9JMMpAcbHWd746f7k9YsVfC609
	2klU3yvSF1ILb+2DFv8o2rdljT/FrFxtKA2GdZVw3CtYWa
X-Received: by 2002:a05:7300:a287:b0:2c5:3b87:2ffc with SMTP id 5a478bee46e88-2c930b800a4mr2894501eec.7.1775085330988;
        Wed, 01 Apr 2026 16:15:30 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:389:4040:540f:0:45:d2d7:5601])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf126c9sm960991eec.27.2026.04.01.16.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 16:15:30 -0700 (PDT)
Date: Wed, 01 Apr 2026 20:15:25 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 3/4] perf tools: Use calloc() were applicable
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fWsC-aCphP2XJuJHSFhjEvg9T+1y+BTGQLU3AM2jcwUUw@mail.gmail.com>
References: <20260401215306.2152898-1-acme@kernel.org> <20260401215306.2152898-4-acme@kernel.org> <CAP-5=fWsC-aCphP2XJuJHSFhjEvg9T+1y+BTGQLU3AM2jcwUUw@mail.gmail.com>
Message-ID: <DEE862AB-0E14-4DFC-946B-334E05AC0B4D@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 1, 2026 7:14:40 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom> w=
rote:
>On Wed, Apr 1, 2026 at 2:53=E2=80=AFPM Arnaldo Carvalho de Melo <acme@ker=
nel=2Eorg> wrote:
>>
>> From: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>>
>> Instead of using zalloc(nr_entries * sizeof_entry) that is what calloc(=
)
>> does=2E
>>
>> In some places where linux/zalloc=2Eh isn't needed, remove it, add when
>> needed and was getting it indirectly=2E
>>
>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat=2Ecom>
>> ---

>>
>> +++ b/tools/perf/builtin-script=2Ec
>> @@ -3667,7 +3667,7 @@ static int list_available_scripts(const struct op=
tion *opt __maybe_unused,
>>         struct script_desc *desc;
>>         char *script_root;
>>
>> -       buf =3D malloc(3 * MAXPATHLEN + BUFSIZ);
>> +       buf =3D calloc(3, MAXPATHLEN + BUFSIZ);
>
>Sashiko caught this one, although I'd probably just keep it as a malloc/z=
alloc=2E
>
>Does this unintentionally over-allocate memory?
>
>The original malloc requested 3 * MAXPATHLEN + BUFSIZ bytes=2E The update=
d
>calloc requests 3 elements of size MAXPATHLEN + BUFSIZ, which evaluates t=
o
>3 * MAXPATHLEN + 3 * BUFSIZ bytes=2E
>
>Should this be calloc(1, 3 * MAXPATHLEN + BUFSIZ) to maintain the origina=
l
>allocation size?

I think we should just leave it as a malloc, will send a V3=2E

Eagle eyes, sashiko! :-)

- Arnaldo


>Thanks,
>Ian
>
>>         if (!buf) {
>>                 pr_err("malloc failed\n");
>>                 exit(-1);
>> @@ -3819,7 +3819,7 @@ static int has_required_arg(char *script_path)
>>
>>  static int have_cmd(int argc, const char **argv)
>>  {
>> -       char **__argv =3D malloc(sizeof(const char *) * argc);
>> +       char **__argv =3D calloc(argc, sizeof(const char *));
>>
>>         if (!__argv) {
>>                 pr_err("malloc failed\n");
>> @@ -4317,7 +4317,7 @@ int cmd_script(int argc, const char **argv)
>>                                 }
>>                         }
>>
>> -                       __argv =3D malloc((argc + 6) * sizeof(const cha=
r *));
>> +                       __argv =3D calloc(argc + 6, sizeof(const char *=
));
>>                         if (!__argv) {
>>                                 pr_err("malloc failed\n");
>>                                 err =3D -ENOMEM;
>> @@ -4343,7 +4343,7 @@ int cmd_script(int argc, const char **argv)
>>                 dup2(live_pipe[0], 0);
>>                 close(live_pipe[1]);
>>
>> -               __argv =3D malloc((argc + 4) * sizeof(const char *));
>> +               __argv =3D calloc(argc + 4, sizeof(const char *));
>>                 if (!__argv) {
>>                         pr_err("malloc failed\n");
>>                         err =3D -ENOMEM;
>> @@ -4381,7 +4381,7 @@ int cmd_script(int argc, const char **argv)
>>                         }
>>                 }
>>
>> -               __argv =3D malloc((argc + 2) * sizeof(const char *));
>> +               __argv =3D calloc(argc + 2, sizeof(const char *));
>>                 if (!__argv) {
>>                         pr_err("malloc failed\n");
>>                         err =3D -ENOMEM;
>> diff --git a/tools/perf/builtin-stat=2Ec b/tools/perf/builtin-stat=2Ec
>> index a24326c44297c534=2E=2E94b753d25550324f 100644
>> --- a/tools/perf/builtin-stat=2Ec
>> +++ b/tools/perf/builtin-stat=2Ec
>> @@ -2766,7 +2766,7 @@ int cmd_stat(int argc, const char **argv)
>>         }
>>
>>         if (stat_config=2Ewalltime_run_table) {
>> -               stat_config=2Ewalltime_run =3D zalloc(stat_config=2Erun=
_count * sizeof(stat_config=2Ewalltime_run[0]));
>> +               stat_config=2Ewalltime_run =3D calloc(stat_config=2Erun=
_count, sizeof(stat_config=2Ewalltime_run[0]));
>>                 if (!stat_config=2Ewalltime_run) {
>>                         pr_err("failed to setup -r option");
>>                         goto out;
>> diff --git a/tools/perf/builtin-trace=2Ec b/tools/perf/builtin-trace=2E=
c
>> index f487fbaa0ad60028=2E=2E8cdfd126115e1b69 100644
>> --- a/tools/perf/builtin-trace=2Ec
>> +++ b/tools/perf/builtin-trace=2Ec
>> @@ -2265,9 +2265,7 @@ static int trace__validate_ev_qualifier(struct tr=
ace *trace)
>>         struct str_node *pos;
>>         size_t nr_used =3D 0, nr_allocated =3D strlist__nr_entries(trac=
e->ev_qualifier);
>>
>> -       trace->ev_qualifier_ids=2Eentries =3D malloc(nr_allocated *
>> -                                                sizeof(trace->ev_quali=
fier_ids=2Eentries[0]));
>> -
>> +       trace->ev_qualifier_ids=2Eentries =3D calloc(nr_allocated, size=
of(trace->ev_qualifier_ids=2Eentries[0]));
>>         if (trace->ev_qualifier_ids=2Eentries =3D=3D NULL) {
>>                 fputs("Error:\tNot enough memory for allocating events =
qualifier ids\n",
>>                        trace->output);
>> diff --git a/tools/perf/jvmti/libjvmti=2Ec b/tools/perf/jvmti/libjvmti=
=2Ec
>> index 87bfd4781003a331=2E=2Ed3dc53010e768669 100644
>> --- a/tools/perf/jvmti/libjvmti=2Ec
>> +++ b/tools/perf/jvmti/libjvmti=2Ec
>> @@ -98,7 +98,7 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile=
_info, jvmti_line_info_t **
>>         /*
>>          * Phase 2 -- allocate big enough line table
>>          */
>> -       *tab =3D malloc(nr_total * sizeof(**tab));
>> +       *tab =3D calloc(nr_total, sizeof(**tab));
>>         if (!*tab)
>>                 return JVMTI_ERROR_OUT_OF_MEMORY;
>>
>> @@ -262,11 +262,10 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
>>                         }
>>                         nr_lines =3D 0;
>>                 } else if (nr_lines > 0) {
>> -                       line_file_names =3D malloc(sizeof(char*) * nr_l=
ines);
>> +                       line_file_names =3D calloc(nr_lines, sizeof(cha=
r *));
>>                         if (!line_file_names) {
>>                                 warnx("jvmti: cannot allocate space for=
 line table method names");
>>                         } else {
>> -                               memset(line_file_names, 0, sizeof(char*=
) * nr_lines);
>>                                 ret =3D fill_source_filenames(jvmti, nr=
_lines, line_tab, line_file_names);
>>                                 if (ret !=3D JVMTI_ERROR_NONE) {
>>                                         warnx("jvmti: fill_source_filen=
ames failed");
>> diff --git a/tools/perf/tests/code-reading=2Ec b/tools/perf/tests/code-=
reading=2Ec
>> index 5927d1ea20e22331=2E=2E47043a3a2fb4f833 100644
>> --- a/tools/perf/tests/code-reading=2Ec
>> +++ b/tools/perf/tests/code-reading=2Ec
>> @@ -4,6 +4,7 @@
>>  #include <linux/kernel=2Eh>
>>  #include <linux/rbtree=2Eh>
>>  #include <linux/types=2Eh>
>> +#include <linux/zalloc=2Eh>
>>  #include <inttypes=2Eh>
>>  #include <stdlib=2Eh>
>>  #include <unistd=2Eh>
>> diff --git a/tools/perf/tests/thread-map=2Ec b/tools/perf/tests/thread-=
map=2Ec
>> index 54209592168d8aaf=2E=2E877868107455e87e 100644
>> --- a/tools/perf/tests/thread-map=2Ec
>> +++ b/tools/perf/tests/thread-map=2Ec
>> @@ -9,7 +9,6 @@
>>  #include "debug=2Eh"
>>  #include "event=2Eh"
>>  #include "util/synthetic-events=2Eh"
>> -#include <linux/zalloc=2Eh>
>>  #include <perf/event=2Eh>
>>  #include <internal/threadmap=2Eh>
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-x86=2Ec b/tools/per=
f/util/annotate-arch/annotate-x86=2Ec
>> index c77aabd48ebab693=2E=2E7e61365363938728 100644
>> --- a/tools/perf/util/annotate-arch/annotate-x86=2Ec
>> +++ b/tools/perf/util/annotate-arch/annotate-x86=2Ec
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2=2E0
>>  #include <string=2Eh>
>>  #include <linux/compiler=2Eh>
>> +#include <linux/zalloc=2Eh>
>>  #include <assert=2Eh>
>>  #include <inttypes=2Eh>
>>  #include "=2E=2E/annotate-data=2Eh"
>> diff --git a/tools/perf/util/bpf-event=2Ec b/tools/perf/util/bpf-event=
=2Ec
>> index 67e7786bb878b396=2E=2Ea27945c279efb779 100644
>> --- a/tools/perf/util/bpf-event=2Ec
>> +++ b/tools/perf/util/bpf-event=2Ec
>> @@ -349,7 +349,7 @@ static struct bpf_metadata *bpf_metadata_alloc(__u3=
2 nr_prog_tags,
>>         if (!metadata)
>>                 return NULL;
>>
>> -       metadata->prog_names =3D zalloc(nr_prog_tags * sizeof(char *));
>> +       metadata->prog_names =3D calloc(nr_prog_tags, sizeof(char *));
>>         if (!metadata->prog_names) {
>>                 bpf_metadata_free(metadata);
>>                 return NULL;
>> diff --git a/tools/perf/util/bpf_counter_cgroup=2Ec b/tools/perf/util/b=
pf_counter_cgroup=2Ec
>> index 5572ceccf86092ff=2E=2E519fee3dc3d03685 100644
>> --- a/tools/perf/util/bpf_counter_cgroup=2Ec
>> +++ b/tools/perf/util/bpf_counter_cgroup=2Ec
>> @@ -11,7 +11,6 @@
>>  #include <sys/time=2Eh>
>>  #include <sys/resource=2Eh>
>>  #include <linux/err=2Eh>
>> -#include <linux/zalloc=2Eh>
>>  #include <linux/perf_event=2Eh>
>>  #include <api/fs/fs=2Eh>
>>  #include <bpf/bpf=2Eh>
>> diff --git a/tools/perf/util/data-convert-bt=2Ec b/tools/perf/util/data=
-convert-bt=2Ec
>> index ba1c8e48d4952e4a=2E=2Ed4927d31a7a3a8d9 100644
>> --- a/tools/perf/util/data-convert-bt=2Ec
>> +++ b/tools/perf/util/data-convert-bt=2Ec
>> @@ -1360,7 +1360,7 @@ static int setup_streams(struct ctf_writer *cw, s=
truct perf_session *session)
>>          */
>>         ncpus =3D env->nr_cpus_avail ?: MAX_CPUS;
>>
>> -       stream =3D zalloc(sizeof(*stream) * ncpus);
>> +       stream =3D calloc(ncpus, sizeof(*stream));
>>         if (!stream) {
>>                 pr_err("Failed to allocate streams=2E\n");
>>                 return -ENOMEM;
>> diff --git a/tools/perf/util/data=2Ec b/tools/perf/util/data=2Ec
>> index 90df41da1a32b315=2E=2E14fa83dae71a8b80 100644
>> --- a/tools/perf/util/data=2Ec
>> +++ b/tools/perf/util/data=2Ec
>> @@ -43,7 +43,7 @@ int perf_data__create_dir(struct perf_data *data, int=
 nr)
>>         if (WARN_ON(!data->is_dir))
>>                 return -EINVAL;
>>
>> -       files =3D zalloc(nr * sizeof(*files));
>> +       files =3D calloc(nr, sizeof(*files));
>>         if (!files)
>>                 return -ENOMEM;
>>
>> diff --git a/tools/perf/util/db-export=2Ec b/tools/perf/util/db-export=
=2Ec
>> index ae9a9065aab76c63=2E=2Ecc2bb1af4243446c 100644
>> --- a/tools/perf/util/db-export=2Ec
>> +++ b/tools/perf/util/db-export=2Ec
>> @@ -19,7 +19,6 @@
>>  #include "callchain=2Eh"
>>  #include "call-path=2Eh"
>>  #include "db-export=2Eh"
>> -#include <linux/zalloc=2Eh>
>>
>>  int db_export__init(struct db_export *dbe)
>>  {
>> diff --git a/tools/perf/util/disasm=2Ec b/tools/perf/util/disasm=2Ec
>> index 40fcaed5d0b1a3b8=2E=2E4f5bd915355242ec 100644
>> --- a/tools/perf/util/disasm=2Ec
>> +++ b/tools/perf/util/disasm=2Ec
>> @@ -13,6 +13,7 @@
>>  #include <unistd=2Eh>
>>
>>  #include <linux/string=2Eh>
>> +#include <linux/zalloc=2Eh>
>>  #include <subcmd/run-command=2Eh>
>>
>>  #include "annotate=2Eh"
>> diff --git a/tools/perf/util/event=2Ec b/tools/perf/util/event=2Ec
>> index bc045fddf7d57569=2E=2E66f4843bb235df53 100644
>> --- a/tools/perf/util/event=2Ec
>> +++ b/tools/perf/util/event=2Ec
>> @@ -12,7 +12,6 @@
>>  #include <unistd=2Eh>
>>  #include <uapi/linux/mman=2Eh> /* To get things like MAP_HUGETLB even =
on older libc headers */
>>  #include <linux/perf_event=2Eh>
>> -#include <linux/zalloc=2Eh>
>>  #include "cpumap=2Eh"
>>  #include "dso=2Eh"
>>  #include "event=2Eh"
>> diff --git a/tools/perf/util/evlist=2Ec b/tools/perf/util/evlist=2Ec
>> index c702741a917380b9=2E=2E73ea382d826364dd 100644
>> --- a/tools/perf/util/evlist=2Ec
>> +++ b/tools/perf/util/evlist=2Ec
>> @@ -825,9 +825,8 @@ static struct mmap *evlist__alloc_mmap(struct evlis=
t *evlist,
>>                                        bool overwrite)
>>  {
>>         int i;
>> -       struct mmap *map;
>> +       struct mmap *map =3D calloc(evlist->core=2Enr_mmaps, sizeof(str=
uct mmap));
>>
>> -       map =3D zalloc(evlist->core=2Enr_mmaps * sizeof(struct mmap));
>>         if (!map)
>>                 return NULL;
>>
>> diff --git a/tools/perf/util/header=2Ec b/tools/perf/util/header=2Ec
>> index 9142a8ba401957c6=2E=2Ea0a5c96288af2674 100644
>> --- a/tools/perf/util/header=2Ec
>> +++ b/tools/perf/util/header=2Ec
>> @@ -2761,7 +2761,7 @@ static int process_cmdline(struct feat_fd *ff, vo=
id *data __maybe_unused)
>>         if (!cmdline)
>>                 return -1;
>>
>> -       argv =3D zalloc(sizeof(char *) * (nr + 1));
>> +       argv =3D calloc(nr + 1, sizeof(char *));
>>         if (!argv)
>>                 goto error;
>>
>> @@ -2915,7 +2915,7 @@ static int process_numa_topology(struct feat_fd *=
ff, void *data __maybe_unused)
>>         if (do_read_u32(ff, &nr))
>>                 return -1;
>>
>> -       nodes =3D zalloc(sizeof(*nodes) * nr);
>> +       nodes =3D calloc(nr, sizeof(*nodes));
>>         if (!nodes)
>>                 return -ENOMEM;
>>
>> @@ -3113,7 +3113,7 @@ static int process_cache(struct feat_fd *ff, void=
 *data __maybe_unused)
>>         if (do_read_u32(ff, &cnt))
>>                 return -1;
>>
>> -       caches =3D zalloc(sizeof(*caches) * cnt);
>> +       caches =3D calloc(cnt, sizeof(*caches));
>>         if (!caches)
>>                 return -1;
>>
>> @@ -3195,7 +3195,7 @@ static int process_mem_topology(struct feat_fd *f=
f,
>>         if (do_read_u64(ff, &nr))
>>                 return -1;
>>
>> -       nodes =3D zalloc(sizeof(*nodes) * nr);
>> +       nodes =3D calloc(nr, sizeof(*nodes));
>>         if (!nodes)
>>                 return -1;
>>
>> @@ -3285,7 +3285,7 @@ static int process_hybrid_topology(struct feat_fd=
 *ff,
>>         if (do_read_u32(ff, &nr))
>>                 return -1;
>>
>> -       nodes =3D zalloc(sizeof(*nodes) * nr);
>> +       nodes =3D calloc(nr, sizeof(*nodes));
>>         if (!nodes)
>>                 return -ENOMEM;
>>
>> @@ -3492,7 +3492,7 @@ static int __process_pmu_caps(struct feat_fd *ff,=
 int *nr_caps,
>>         if (!nr_pmu_caps)
>>                 return 0;
>>
>> -       *caps =3D zalloc(sizeof(char *) * nr_pmu_caps);
>> +       *caps =3D calloc(nr_pmu_caps, sizeof(char *));
>>         if (!*caps)
>>                 return -1;
>>
>> @@ -3569,7 +3569,7 @@ static int process_pmu_caps(struct feat_fd *ff, v=
oid *data __maybe_unused)
>>                 return 0;
>>         }
>>
>> -       pmu_caps =3D zalloc(sizeof(*pmu_caps) * nr_pmu);
>> +       pmu_caps =3D calloc(nr_pmu, sizeof(*pmu_caps));
>>         if (!pmu_caps)
>>                 return -ENOMEM;
>>
>> @@ -3622,7 +3622,7 @@ static int process_cpu_domain_info(struct feat_fd=
 *ff, void *data __maybe_unused
>>         nra =3D env->nr_cpus_avail;
>>         nr =3D env->nr_cpus_online;
>>
>> -       cd_map =3D zalloc(sizeof(*cd_map) * nra);
>> +       cd_map =3D calloc(nra, sizeof(*cd_map));
>>         if (!cd_map)
>>                 return -1;
>>
>> @@ -3655,7 +3655,7 @@ static int process_cpu_domain_info(struct feat_fd=
 *ff, void *data __maybe_unused
>>
>>                 cd_map[cpu]->nr_domains =3D nr_domains;
>>
>> -               cd_map[cpu]->domains =3D zalloc(sizeof(*d_info) * max_s=
ched_domains);
>> +               cd_map[cpu]->domains =3D calloc(max_sched_domains, size=
of(*d_info));
>>                 if (!cd_map[cpu]->domains)
>>                         return -1;
>>
>> diff --git a/tools/perf/util/hist=2Ec b/tools/perf/util/hist=2Ec
>> index fc737a0a8e4d7acd=2E=2E747fdc455c80ec0f 100644
>> --- a/tools/perf/util/hist=2Ec
>> +++ b/tools/perf/util/hist=2Ec
>> @@ -1151,7 +1151,7 @@ iter_prepare_cumulative_entry(struct hist_entry_i=
ter *iter,
>>          * cumulated only one time to prevent entries more than 100%
>>          * overhead=2E
>>          */
>> -       he_cache =3D malloc(sizeof(*he_cache) * (cursor->nr + 1));
>> +       he_cache =3D calloc(cursor->nr + 1, sizeof(*he_cache));
>>         if (he_cache =3D=3D NULL)
>>                 return -ENOMEM;
>>
>> diff --git a/tools/perf/util/mem2node=2Ec b/tools/perf/util/mem2node=2E=
c
>> index 03a7d7b2773774a0=2E=2E51a2292cbf7ef44f 100644
>> --- a/tools/perf/util/mem2node=2Ec
>> +++ b/tools/perf/util/mem2node=2Ec
>> @@ -59,7 +59,7 @@ int mem2node__init(struct mem2node *map, struct perf_=
env *env)
>>                 max +=3D bitmap_weight(n->set, n->size);
>>         }
>>
>> -       entries =3D zalloc(sizeof(*entries) * max);
>> +       entries =3D calloc(max, sizeof(*entries));
>>         if (!entries)
>>                 return -ENOMEM;
>>
>> diff --git a/tools/perf/util/pmus=2Ec b/tools/perf/util/pmus=2Ec
>> index 98be2eb8f1f03923=2E=2E9a2023ceeefd933a 100644
>> --- a/tools/perf/util/pmus=2Ec
>> +++ b/tools/perf/util/pmus=2Ec
>> @@ -621,7 +621,7 @@ void perf_pmus__print_pmu_events(const struct print=
_callbacks *print_cb, void *p
>>         while ((pmu =3D scan_fn(pmu)) !=3D NULL)
>>                 len +=3D perf_pmu__num_events(pmu);
>>
>> -       aliases =3D zalloc(sizeof(struct sevent) * len);
>> +       aliases =3D calloc(len, sizeof(struct sevent));
>>         if (!aliases) {
>>                 pr_err("FATAL: not enough memory to print PMU events\n"=
);
>>                 return;
>> diff --git a/tools/perf/util/powerpc-vpadtl=2Ec b/tools/perf/util/power=
pc-vpadtl=2Ec
>> index d1c3396f182fdd83=2E=2E5884ae2ff5fff218 100644
>> --- a/tools/perf/util/powerpc-vpadtl=2Ec
>> +++ b/tools/perf/util/powerpc-vpadtl=2Ec
>> @@ -4,6 +4,7 @@
>>   */
>>
>>  #include <linux/string=2Eh>
>> +#include <linux/zalloc=2Eh>
>>  #include <errno=2Eh>
>>  #include <inttypes=2Eh>
>>  #include "color=2Eh"
>> diff --git a/tools/perf/util/probe-event=2Ec b/tools/perf/util/probe-ev=
ent=2Ec
>> index 710e4620923ea8b2=2E=2Ef37a783ea7723197 100644
>> --- a/tools/perf/util/probe-event=2Ec
>> +++ b/tools/perf/util/probe-event=2Ec
>> @@ -1850,7 +1850,7 @@ int parse_perf_probe_command(const char *cmd, str=
uct perf_probe_event *pev)
>>
>>         /* Copy arguments and ensure return probe has no C argument */
>>         pev->nargs =3D argc - 1;
>> -       pev->args =3D zalloc(sizeof(struct perf_probe_arg) * pev->nargs=
);
>> +       pev->args =3D calloc(pev->nargs, sizeof(struct perf_probe_arg))=
;
>>         if (pev->args =3D=3D NULL) {
>>                 ret =3D -ENOMEM;
>>                 goto out;
>> @@ -2000,7 +2000,7 @@ int parse_probe_trace_command(const char *cmd, st=
ruct probe_trace_event *tev)
>>         }
>>
>>         tev->nargs =3D argc - 2;
>> -       tev->args =3D zalloc(sizeof(struct probe_trace_arg) * tev->narg=
s);
>> +       tev->args =3D calloc(tev->nargs, sizeof(struct probe_trace_arg)=
);
>>         if (tev->args =3D=3D NULL) {
>>                 ret =3D -ENOMEM;
>>                 goto out;
>> @@ -2373,7 +2373,7 @@ static int convert_to_perf_probe_event(struct pro=
be_trace_event *tev,
>>
>>         /* Convert trace_arg to probe_arg */
>>         pev->nargs =3D tev->nargs;
>> -       pev->args =3D zalloc(sizeof(struct perf_probe_arg) * pev->nargs=
);
>> +       pev->args =3D calloc(pev->nargs, sizeof(struct perf_probe_arg))=
;
>>         if (pev->args =3D=3D NULL)
>>                 return -ENOMEM;
>>         for (i =3D 0; i < tev->nargs && ret >=3D 0; i++) {
>> @@ -2480,7 +2480,7 @@ int perf_probe_event__copy(struct perf_probe_even=
t *dst,
>>         if (perf_probe_point__copy(&dst->point, &src->point) < 0)
>>                 goto out_err;
>>
>> -       dst->args =3D zalloc(sizeof(struct perf_probe_arg) * src->nargs=
);
>> +       dst->args =3D calloc(src->nargs, sizeof(struct perf_probe_arg))=
;
>>         if (!dst->args)
>>                 goto out_err;
>>         dst->nargs =3D src->nargs;
>> @@ -3179,7 +3179,7 @@ static int find_probe_trace_events_from_map(struc=
t perf_probe_event *pev,
>>         }
>>
>>         /* Setup result trace-probe-events */
>> -       *tevs =3D zalloc(sizeof(*tev) * num_matched_functions);
>> +       *tevs =3D calloc(num_matched_functions, sizeof(*tev));
>>         if (!*tevs) {
>>                 ret =3D -ENOMEM;
>>                 goto out;
>> @@ -3251,8 +3251,7 @@ static int find_probe_trace_events_from_map(struc=
t perf_probe_event *pev,
>>                 tev->uprobes =3D pev->uprobes;
>>                 tev->nargs =3D pev->nargs;
>>                 if (tev->nargs) {
>> -                       tev->args =3D zalloc(sizeof(struct probe_trace_=
arg) *
>> -                                          tev->nargs);
>> +                       tev->args =3D calloc(tev->nargs, sizeof(struct =
probe_trace_arg));
>>                         if (tev->args =3D=3D NULL)
>>                                 goto nomem_out;
>>                 }
>> @@ -3363,7 +3362,7 @@ static int try_to_find_absolute_address(struct pe=
rf_probe_event *pev,
>>         }
>>
>>         tev->nargs =3D pev->nargs;
>> -       tev->args =3D zalloc(sizeof(struct probe_trace_arg) * tev->narg=
s);
>> +       tev->args =3D calloc(tev->nargs, sizeof(struct probe_trace_arg)=
);
>>         if (!tev->args)
>>                 goto errout;
>>
>> @@ -3549,7 +3548,7 @@ static int find_probe_trace_events_from_cache(str=
uct perf_probe_event *pev,
>>                 goto out;
>>         }
>>
>> -       *tevs =3D zalloc(ret * sizeof(*tev));
>> +       *tevs =3D calloc(ret, sizeof(*tev));
>>         if (!*tevs) {
>>                 ret =3D -ENOMEM;
>>                 goto out;
>> diff --git a/tools/perf/util/probe-file=2Ec b/tools/perf/util/probe-fil=
e=2Ec
>> index f78c3bc3d601ea95=2E=2E4032572cbf55df12 100644
>> --- a/tools/perf/util/probe-file=2Ec
>> +++ b/tools/perf/util/probe-file=2Ec
>> @@ -414,7 +414,7 @@ int probe_cache_entry__get_event(struct probe_cache=
_entry *entry,
>>         if (ret > probe_conf=2Emax_probes)
>>                 return -E2BIG;
>>
>> -       *tevs =3D zalloc(ret * sizeof(*tev));
>> +       *tevs =3D calloc(ret, sizeof(*tev));
>>         if (!*tevs)
>>                 return -ENOMEM;
>>
>> diff --git a/tools/perf/util/probe-finder=2Ec b/tools/perf/util/probe-f=
inder=2Ec
>> index 5ffd97ee4898e51e=2E=2E64328abeef8b2427 100644
>> --- a/tools/perf/util/probe-finder=2Ec
>> +++ b/tools/perf/util/probe-finder=2Ec
>> @@ -1305,7 +1305,7 @@ static int add_probe_trace_event(Dwarf_Die *sc_di=
e, struct probe_finder *pf)
>>                  tev->point=2Eoffset);
>>
>>         /* Expand special probe argument if exist */
>> -       args =3D zalloc(sizeof(struct perf_probe_arg) * MAX_PROBE_ARGS)=
;
>> +       args =3D calloc(MAX_PROBE_ARGS, sizeof(struct perf_probe_arg));
>>         if (args =3D=3D NULL) {
>>                 ret =3D -ENOMEM;
>>                 goto end;
>> @@ -1316,7 +1316,7 @@ static int add_probe_trace_event(Dwarf_Die *sc_di=
e, struct probe_finder *pf)
>>                 goto end;
>>
>>         tev->nargs =3D ret;
>> -       tev->args =3D zalloc(sizeof(struct probe_trace_arg) * tev->narg=
s);
>> +       tev->args =3D calloc(tev->nargs, sizeof(struct probe_trace_arg)=
);
>>         if (tev->args =3D=3D NULL) {
>>                 ret =3D -ENOMEM;
>>                 goto end;
>> @@ -1393,7 +1393,7 @@ int debuginfo__find_trace_events(struct debuginfo=
 *dbg,
>>         int ret, i;
>>
>>         /* Allocate result tevs array */
>> -       *tevs =3D zalloc(sizeof(struct probe_trace_event) * tf=2Emax_te=
vs);
>> +       *tevs =3D calloc(tf=2Emax_tevs, sizeof(struct probe_trace_event=
));
>>         if (*tevs =3D=3D NULL)
>>                 return -ENOMEM;
>>
>> @@ -1566,7 +1566,7 @@ int debuginfo__find_available_vars_at(struct debu=
ginfo *dbg,
>>         int ret;
>>
>>         /* Allocate result vls array */
>> -       *vls =3D zalloc(sizeof(struct variable_list) * af=2Emax_vls);
>> +       *vls =3D calloc(af=2Emax_vls, sizeof(struct variable_list));
>>         if (*vls =3D=3D NULL)
>>                 return -ENOMEM;
>>
>> diff --git a/tools/perf/util/session=2Ec b/tools/perf/util/session=2Ec
>> index 09de5288f9e15bb0=2E=2E7996c4c654b0f5b7 100644
>> --- a/tools/perf/util/session=2Ec
>> +++ b/tools/perf/util/session=2Ec
>> @@ -2533,7 +2533,7 @@ static int __perf_session__process_dir_events(str=
uct perf_session *session)
>>                         nr_readers++;
>>         }
>>
>> -       rd =3D zalloc(nr_readers * sizeof(struct reader));
>> +       rd =3D calloc(nr_readers, sizeof(struct reader));
>>         if (!rd)
>>                 return -ENOMEM;
>>
>> diff --git a/tools/perf/util/srcline=2Ec b/tools/perf/util/srcline=2Ec
>> index 9be42f3984405f9e=2E=2Eb58710624eadfe1b 100644
>> --- a/tools/perf/util/srcline=2Ec
>> +++ b/tools/perf/util/srcline=2Ec
>> @@ -12,6 +12,7 @@
>>  #include <inttypes=2Eh>
>>  #include <string=2Eh>
>>  #include <linux/string=2Eh>
>> +#include <linux/zalloc=2Eh>
>>
>>  bool srcline_full_filename;
>>
>> diff --git a/tools/perf/util/stat-shadow=2Ec b/tools/perf/util/stat-sha=
dow=2Ec
>> index 59d2cd4f2188de72=2E=2Ebc2d44df7bafa4d5 100644
>> --- a/tools/perf/util/stat-shadow=2Ec
>> +++ b/tools/perf/util/stat-shadow=2Ec
>> @@ -13,7 +13,6 @@
>>  #include "metricgroup=2Eh"
>>  #include "cgroup=2Eh"
>>  #include "units=2Eh"
>> -#include <linux/zalloc=2Eh>
>>  #include "iostat=2Eh"
>>  #include "util/hashmap=2Eh"
>>  #include "tool_pmu=2Eh"
>> diff --git a/tools/perf/util/unwind-libunwind-local=2Ec b/tools/perf/ut=
il/unwind-libunwind-local=2Ec
>> index 5b39ce21e33351f8=2E=2E87d496e9dfa6669c 100644
>> --- a/tools/perf/util/unwind-libunwind-local=2Ec
>> +++ b/tools/perf/util/unwind-libunwind-local=2Ec
>> @@ -25,7 +25,6 @@
>>  #include <unistd=2Eh>
>>  #include <sys/mman=2Eh>
>>  #include <linux/list=2Eh>
>> -#include <linux/zalloc=2Eh>
>>  #ifndef REMOTE_UNWIND_LIBUNWIND
>>  #include <libunwind=2Eh>
>>  #include <libunwind-ptrace=2Eh>
>> diff --git a/tools/perf/util/values=2Ec b/tools/perf/util/values=2Ec
>> index ec72d29f3d586d47=2E=2E6eaddfcf833e52a2 100644
>> --- a/tools/perf/util/values=2Ec
>> +++ b/tools/perf/util/values=2Ec
>> @@ -13,9 +13,9 @@
>>  int perf_read_values_init(struct perf_read_values *values)
>>  {
>>         values->threads_max =3D 16;
>> -       values->pid =3D malloc(values->threads_max * sizeof(*values->pi=
d));
>> -       values->tid =3D malloc(values->threads_max * sizeof(*values->ti=
d));
>> -       values->value =3D zalloc(values->threads_max * sizeof(*values->=
value));
>> +       values->pid =3D calloc(values->threads_max, sizeof(*values->pid=
));
>> +       values->tid =3D calloc(values->threads_max, sizeof(*values->tid=
));
>> +       values->value =3D calloc(values->threads_max, sizeof(*values->v=
alue));
>>         if (!values->pid || !values->tid || !values->value) {
>>                 pr_debug("failed to allocate read_values threads arrays=
");
>>                 goto out_free_pid;
>> @@ -96,7 +96,7 @@ static int perf_read_values__findnew_thread(struct pe=
rf_read_values *values,
>>
>>         i =3D values->threads;
>>
>> -       values->value[i] =3D zalloc(values->counters_max * sizeof(**val=
ues->value));
>> +       values->value[i] =3D calloc(values->counters_max, sizeof(**valu=
es->value));
>>         if (!values->value[i]) {
>>                 pr_debug("failed to allocate read_values counters array=
");
>>                 return -ENOMEM;
>> --
>> 2=2E53=2E0
>>
>

- Arnaldo 
