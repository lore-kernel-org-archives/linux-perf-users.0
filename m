Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99A62E414
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853104; cv=none; b=FX3+gE2h3qsZe+a71RZQ1fdRhJkTuu8FN8W0GXPoBJ0vwqU2sJNveNZKYfPgjVVOyIizqT7qHpE5jnemjmCpiIpeccU4QBPGuvUKFrcQfXRpsTEaWRlZ4dMHkNwrxa2ehHcw2P0n1i4uM1jj8SzBSzBs7msF1byoI6V/3yXN8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853104; c=relaxed/simple;
	bh=tvqbSBvbe2a/Rt2zk5esfR2gvTPpdX2tE2rZG4WOpQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm7cWrxX2aO2ajJy7okjFVPPOXZvJ+5lUKryvodxqKU0B0JJpnf40/SEi4X/u/kxdVcB57Ysmb+Q/JJp+dHfotFSZk4OllJlHQmujc5OrcunA3zj56HYqeNgmoQzbtz10IxZLqY/FXpPFbsPdueITkBlm15QhKwRxwPjf+pnl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tahfV2vt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tahfV2vt"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so4075166f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 16:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730853101; x=1731457901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bwT6sj9f92fSfbjyqUGWo/OaOQvWzzTMdBrwJO9qLQ=;
        b=tahfV2vt+E71Up5j4m+xBUfJRr4fhHctX1f4SXq5K+5BvSCVIa6SvWfbpiyObnX5jj
         X7muD47t2LmPHEYSj1ywmwuFZeSuPJjCun5kCa2kPZOD5xdRo1t7RT+vQSegN0Zwy7t2
         Ie44HML+nPcsNLDAd2yfkBB+i8iUl1vsBS+NMdq96yxyQws5boommWqn2zAmki4zsXvW
         MQj6JoMkkhoCgrIlETvbDdsWL7i/qFemJ3XWVa1qvSQhauqrhPgafLj9xF0SpqAHC8XM
         PoyQNC4rOrpqaSzqLXWgP6IsoldqBJ7xibRv8dgTVPIkEzSJ57+/mo3BqZqTHkFY+v29
         uXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853101; x=1731457901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bwT6sj9f92fSfbjyqUGWo/OaOQvWzzTMdBrwJO9qLQ=;
        b=JKqzQ6m6VRfUrtk5e9e1dxoaCHh4jN/do+3ZsWm/LE8yzw0BjcbJkgE/Habf46OpXs
         mh1Alj3wqtyxVUxfR5dKqfuDIiRSj8byJDXQyiWnoR6VwZ4fGQkE4H/j0RsWgLKP07yT
         HWTSQ/ZH3Xp57Hci9iMaKVtmZwuAA7GNrtMj8oC+aGd2Ra+1LiiO6tMOw0JK6/efAGS2
         IKEf+HX4d/Vpy7mo0a65K0NqlKppUXeTSeNKlG30Jz0nj6ko2MoEVDxTqe5X6hvaHVFV
         TLnBgtxypm1YYvw2hvQ/sFYexdYJY7br/K6SIny0o0aHVGj9XKJfgI1XxDX6qFG8GyxG
         JvKA==
X-Forwarded-Encrypted: i=1; AJvYcCWhIDyNPesuEbdZKkDYKBjLJOlBSAFnL66MHy0dnR10ZJrWfnSisBTDjng61hs9uQnwrVL0ohLeGKgf2rSdkkp8@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqRtt/CI/ZGkHbVmmLslL0eN1ZzyJSd4I6DdmNmm42p0obLDo
	gAPiAwX2FkKECuzzTV+gGWmyj82QEsUITjwO7HULvYjaqSHraoooSaVzZDq0QQzexadxj5ugCsk
	PaCkXdLqXcJa4rFL8d1fPoaFwpyrMWg+Ih8aW
X-Google-Smtp-Source: AGHT+IFFX0zQ/6/F3wqKJIs6TJpCatofV/WGLJ3DATwLu5tbxPv7XwxGrY/F+RnpB/wLYAEhH3FHmupLmvA76tThdc0=
X-Received: by 2002:a05:6000:178a:b0:37c:d227:d193 with SMTP id
 ffacd0b85a97d-381be7654bbmr18783674f8f.10.1730853100973; Tue, 05 Nov 2024
 16:31:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101211757.824743-1-ctshao@google.com> <ZylgYE2HXzGpAdKQ@google.com>
In-Reply-To: <ZylgYE2HXzGpAdKQ@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 5 Nov 2024 16:31:29 -0800
Message-ID: <CAJpZYjWEr9T5z-aKAATmBsf1jgHq4c+WsV-qYriGQqbM-32uuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf evsel: Improve the evsel__open_strerror for EBUSY
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your review Namhyung! Here is the link to the v3 patch:
https://lore.kernel.org/all/20241106003007.2112584-1-ctshao@google.com/

On Mon, Nov 4, 2024 at 4:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello CT,
>
> On Fri, Nov 01, 2024 at 09:17:55PM +0000, Chun-Tse Shao wrote:
> > From: Ian Rogers <irogers@google.com>
> >
> > The existing EBUSY strerror message is:
> > ```
> > The sys_perf_event_open() syscall returned with 16 (Device or resource =
busy) for event (intel_bts//).
> > "dmesg | grep -i perf" may provide additional information.
> > ```
>
> Just a nitpick.  I'd like to avoid this github markdown style notation
> of triple backticks as it doesn't clearly separate code blocks (IMHO)
> nor protect anything like '#' sign in the beginning of a line.
>
> I prefer indenting with 2 spaces before and after a blank line.
>

Fixed in v3.

>
> > The dmesg won't be useful. What is more useful is knowing what
> > processes are potentially using the PMU, which some procfs scanning can
> > reveal. When parallel testing tests/shell/stat_all_pmu.sh this yields:
> > ```
> > Testing intel_bts//
> > Error:
> > The PMU intel_bts counters are busy and in use by another process.
> > Possible processes:
> > 2585882 perf list
> > 2585902 perf list -j -o /tmp/__perf_test.list_output.json.KF9MY
> > 2585904 perf list
> > 2585911 perf record -e task-clock --filter period > 1 -o /dev/null --qu=
iet true
> > 2585912 perf list
> > 2585915 perf list
> > 2586042 /tmp/perf/perf record -asdg -e cpu-clock -o /tmp/perftool-tests=
uite_report.dIF/perf_report/perf.data -- sleep 2
> > 2589078 perf record -g -e task-clock:u -o - perf test -w noploop
> > 2589148 /tmp/perf/perf record --control=3Dfifo:control,ack -e cpu-clock=
 -m 1 sleep 10
> > 2589379 perf --buildid-dir /tmp/perf.debug.Umx record --buildid-all -o =
/tmp/perf.data.YBm /tmp/perf.ex.MD5.ZQW
> > 2589568 perf record -o /tmp/__perf_test.program.mtcZH/perf.data --branc=
h-filter any,save_type,u -- perf test -w brstack
> > 2589649 perf record --per-thread -o /tmp/__perf_test.perf.data.5d3dc pe=
rf test -w thloop
> > 2589898 perf record -o /tmp/perf-test-script.BX2b27Dcnj/pp-perf.data --=
sample-cpu uname
> > ```
> > Which gets a little closer to finding the issue.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c | 79 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 78 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index dbf9c8cee3c56..9a5b6a6f8d2e5 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3286,6 +3286,78 @@ static bool find_process(const char *name)
> >       return ret ? false : true;
> >  }
> >
> > +static int dump_perf_event_processes(char *msg, size_t size)
> > +{
> > +     DIR *proc_dir;
> > +     struct dirent *proc_entry;
> > +     int printed =3D 0;
> > +
> > +     proc_dir =3D opendir(procfs__mountpoint());
> > +     if (!proc_dir)
> > +             return 0;
> > +
> > +     /* Walk through the /proc directory. */
> > +     while ((proc_entry =3D readdir(proc_dir)) !=3D NULL) {
> > +             char path[PATH_MAX];
>
> Can we use a much smaller buffer as it expects PIDs only?
>

It is actually used as a general purpose buffer, not only for `path`.
It is also served for parsing `fdinfo` in patch 3, which I think 256
would be safe for now.

>
> > +             DIR *fd_dir;
> > +             struct dirent *fd_entry;
> > +             int fd_dir_fd;
> > +
> > +             if ((proc_entry->d_type !=3D DT_DIR) ||
> > +                  !strcmp(".", proc_entry->d_name) ||
> > +                  !strcmp("..", proc_entry->d_name))
>
> Maybe something like this?

Fixed in v3.


>
>                 if (proc_entry->d_type !=3D DT_DIR ||
>                     !isdigit(proc_entry->d_name[0]) ||
>                     strlen(proc_entry->d_name) > sizeof(path) - 4)
>
> Thanks,
> Namhyung
>
>
> > +                     continue;
> > +
> > +             scnprintf(path, sizeof(path), "%s/fd", proc_entry->d_name=
);
> > +             fd_dir_fd =3D openat(dirfd(proc_dir), path, O_DIRECTORY);
> > +             if (fd_dir_fd =3D=3D -1)
> > +                     continue;
> > +             fd_dir =3D fdopendir(fd_dir_fd);
> > +             if (!fd_dir) {
> > +                     close(fd_dir_fd);
> > +                     continue;
> > +             }
> > +             while ((fd_entry =3D readdir(fd_dir)) !=3D NULL) {
> > +                     ssize_t link_size;
> > +
> > +                     if (fd_entry->d_type !=3D DT_LNK)
> > +                             continue;
> > +                     link_size =3D readlinkat(fd_dir_fd, fd_entry->d_n=
ame, path, sizeof(path));
> > +                     if (link_size < 0)
> > +                             continue;
> > +                     /* Take care as readlink doesn't null terminate t=
he string. */
> > +                     if (!strncmp(path, "anon_inode:[perf_event]", lin=
k_size)) {
> > +                             int cmdline_fd;
> > +                             ssize_t cmdline_size;
> > +
> > +                             scnprintf(path, sizeof(path), "%s/cmdline=
", proc_entry->d_name);
> > +                             cmdline_fd =3D openat(dirfd(proc_dir), pa=
th, O_RDONLY);
> > +                             if (cmdline_fd =3D=3D -1)
> > +                                     continue;
> > +                             cmdline_size =3D read(cmdline_fd, path, s=
izeof(path) - 1);
> > +                             close(cmdline_fd);
> > +                             if (cmdline_size < 0)
> > +                                     continue;
> > +                             path[cmdline_size] =3D '\0';
> > +                             for (ssize_t i =3D 0; i < cmdline_size; i=
++) {
> > +                                     if (path[i] =3D=3D '\0')
> > +                                             path[i] =3D ' ';
> > +                             }
> > +
> > +                             if (printed =3D=3D 0)
> > +                                     printed +=3D scnprintf(msg, size,=
 "Possible processes:\n");
> > +
> > +                             printed +=3D scnprintf(msg + printed, siz=
e - printed,
> > +                                             "%s %s\n", proc_entry->d_=
name, path);
> > +                             break;
> > +                     }
> > +             }
> > +             closedir(fd_dir);
> > +     }
> > +     closedir(proc_dir);
> > +     return printed;
> > +}
> > +
> >  int __weak arch_evsel__open_strerror(struct evsel *evsel __maybe_unuse=
d,
> >                                    char *msg __maybe_unused,
> >                                    size_t size __maybe_unused)
> > @@ -3319,7 +3391,7 @@ int evsel__open_strerror(struct evsel *evsel, str=
uct target *target,
> >                       printed +=3D scnprintf(msg, size,
> >                               "No permission to enable %s event.\n\n", =
evsel__name(evsel));
> >
> > -             return scnprintf(msg + printed, size - printed,
> > +             return printed + scnprintf(msg + printed, size - printed,
> >                "Consider adjusting /proc/sys/kernel/perf_event_paranoid=
 setting to open\n"
> >                "access to performance monitoring and observability oper=
ations for processes\n"
> >                "without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Li=
nux capability.\n"
> > @@ -3382,6 +3454,11 @@ int evsel__open_strerror(struct evsel *evsel, st=
ruct target *target,
> >                       return scnprintf(msg, size,
> >       "The PMU counters are busy/taken by another profiler.\n"
> >       "We found oprofile daemon running, please stop it and try again."=
);
> > +             printed +=3D scnprintf(
> > +                     msg, size,
> > +                     "The PMU %s counters are busy and in use by anoth=
er process.\n",
> > +                     evsel->pmu ? evsel->pmu->name : "");
> > +             return printed + dump_perf_event_processes(msg + printed,=
 size - printed);
> >               break;
> >       case EINVAL:
> >               if (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_=
SIZE && perf_missing_features.code_page_size)
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >
