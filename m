Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57851C2DB4
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407919; cv=none; b=DKkUSp4Bd4hOUdBy7VzNKh+sH6J+GnTFxh2HNvEn4d9QpKee4QflmsmyhzmlOlaqdZ45dMhYGNPA7UNfOkvSi+UCpkzLxe8I1Td+KEf4Y2gh1NtTLd8/t+9Iv6ZtVpM/a9158l2wLmnMgHc+v+QzBghfL+GK3rLdtVU1YN131ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407919; c=relaxed/simple;
	bh=lZESHEGiFlewzONfLwmnR0L4kLalHnyJemRudnPWb0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WThsSQo8izc8kSEIlmwDP086s1aOHfBh0Hi3xxvti4Yzb2vVFkZsnaxbHEQLsQzRSWkV6xjBb7Ipt58GBdOH9C9MRXVC/7nLZP7bTtjR/9NWa76sNbXYEzezAF0gvtBhPNzZS2EP6V8PFE4ttu5sHhWY5P6fWQvrA2/mUdqOY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aO2D/A//; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aO2D/A//"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso16225ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730407912; x=1731012712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j5kt1ocDA4MtclEjyfoMTiBG+3sa0dA4NxxIwxCzr8=;
        b=aO2D/A//XepwTy8Hz8r3Bnqrkc8Yja+d95yKWxbYVctGhImVhyPiD/qXywYWFoYibq
         Eew/0uT7i9a+sxiPStY7jkozKlfyHwnnXSoKuI+PTUnFkT16RMLCR/cqwNQGmfBFiCPA
         Bid3Qarxsms2hLAvIh18CwjvVEl3yfWRF2J7asjMleVu+6VadBTnI++HSbQIfMRZW0w9
         e6Hc4fcvBYQyoVCJuO6heZGHftOOIkD0kkADlx9WcVfRrZ03gzbQh+K7AeBgTV92D7Uw
         NEG+gLgW3aT2lMRBqHXqtRO9t1hvJyC0r6hOavpcAEbKYDft5s5chbdlCgYRRhBf4HVg
         FoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730407912; x=1731012712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4j5kt1ocDA4MtclEjyfoMTiBG+3sa0dA4NxxIwxCzr8=;
        b=iNalnsUUxv+c7Xw2olBxoU3pKsnhSJxMnjqpd/MO0w+wufGZupbe3JjpSBIbAHlVg4
         /RKoCn1R1vU1ECXsbArJrk7oET4HUF8kb/pzNzqs75kiQAtuXL54QucI0YhzBUgFHueO
         ZeiYUHVZ+1kL5NO94ugU5C9Lbqa3Y01rOSgoWgDaU5YgS9Wb/NG4ATyRtuTpmYrpvoN6
         Jw6efU3/kIGDLaqEllTmaW4NyudP1LVF3iL7+g7FfPMphg0T7+ANF8yA1riI0uqSj1DK
         QKhlQT0FZWk994BhYzT5xgx38K19ET64+JslQrSh99I4YPwvpqU+fYGq34x+G+THotFh
         QrFw==
X-Forwarded-Encrypted: i=1; AJvYcCVgWf+dPQQ2j/eR3cagf2R7OwH+BMra36LSWwWPBW4wHEiZwHQMYXYOirRUBq1XTIAm1e4Z+9NU1WiRyOl1UiO/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzym2wZU8fXOZy1g1gNijujLpCurU/BDI0JFh8hTvRaILSIkEde
	dR6+7O4nxC7GztrjEDvi+hWqHCKY7HhCYlWI6e6owwGpydc6FcGh0JjRF9ZLXAFjIHAriTr80x1
	z/WaD5nsMkdkCtrWv3dFdMXGU/L1g7tZMdF2v
X-Gm-Gg: ASbGnct0QUYlhll0xBna/qV0HHzfZua0+sfAH4DJfI0nh+T+kozpJq37mIlmqtbfpIe
	9mGBQ8YxMxKlX5SsQVjzTUNKhuq4SR8xfXPI+jM0Lq1zFPrUZktZ+ZXnfDx7AyFg=
X-Google-Smtp-Source: AGHT+IGs/FF6/8vovt6WmMF/T9mNZN20YKzkrv8O+rpPf3Li5Rtx4BaUuNoHWm1YaDlCIj/5TAJYuss31w0aMWqqwr0=
X-Received: by 2002:a05:6e02:2141:b0:3a0:a3cd:f23d with SMTP id
 e9e14a558f8ab-3a6a9361423mr4143115ab.5.1730407911757; Thu, 31 Oct 2024
 13:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com> <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1>
In-Reply-To: <ZyPX7ayIO4teziDX@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 31 Oct 2024 13:51:36 -0700
Message-ID: <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to browser/scripts.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 12:18=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> > The only use of find_scripts is in browser/scripts.c but the
> > definition in builtin causes linking problems requiring a stub in
> > python.c. Move the function to allow the stub to be removed.
> >
> > Rewrite the directory iteration to use openat so that large character
> > arrays aren't needed. The arrays are warned about potential buffer
> > overflows by GCC now that all the code exists in a single C file.
>
> Introducing is_directory_at() should be done as a prep patch, as the
> rest of the patch below could end up being reverted after some other
> patch used it, making the process more difficult.
>
> I mentioned cases like this in the past, so doing it again just for the
> record.

This is highlighted in the commit message:
```
Rewrite the directory iteration to use openat so that large character
arrays aren't needed. The arrays are warned about potential buffer
overflows by GCC now that all the code exists in a single C file.
```
so without the change the code wouldn't build. The new is_directory_at
function is effectively 2 statements fstatat and S_ISDIR on the
result, it is put next to is_directory for consistency but could have
been a static function in the only C file to use it.

For the record, patches introducing 2 line long functions can be
excessively noisy, especially in a 21 patch series. There is always
the declared but not used build error to worry about - here things
couldn't just be simply moved due to triggering a different build
error. Given the simplicity of the function here I made a decision not
to split up the work - the commit message would likely be longer than
the function. The work never intended to introduce is_directory_at but
was forced into it through a desire not to disable compiler warnings.

Thanks,
Ian

>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-script.c      | 138 ------------------------
> >  tools/perf/builtin.h             |   6 --
> >  tools/perf/ui/browsers/scripts.c | 177 ++++++++++++++++++++++++++++++-
> >  tools/perf/util/path.c           |  10 ++
> >  tools/perf/util/path.h           |   1 +
> >  tools/perf/util/python.c         |   6 --
> >  6 files changed, 186 insertions(+), 152 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 5d5a1a06d8c6..e9ec74056f71 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -3521,144 +3521,6 @@ static void free_dlarg(void)
> >       free(dlargv);
> >  }
> >
> > -/*
> > - * Some scripts specify the required events in their "xxx-record" file=
,
> > - * this function will check if the events in perf.data match those
> > - * mentioned in the "xxx-record".
> > - *
> > - * Fixme: All existing "xxx-record" are all in good formats "-e event =
",
> > - * which is covered well now. And new parsing code should be added to
> > - * cover the future complex formats like event groups etc.
> > - */
> > -static int check_ev_match(char *dir_name, char *scriptname,
> > -                     struct perf_session *session)
> > -{
> > -     char filename[MAXPATHLEN], evname[128];
> > -     char line[BUFSIZ], *p;
> > -     struct evsel *pos;
> > -     int match, len;
> > -     FILE *fp;
> > -
> > -     scnprintf(filename, MAXPATHLEN, "%s/bin/%s-record", dir_name, scr=
iptname);
> > -
> > -     fp =3D fopen(filename, "r");
> > -     if (!fp)
> > -             return -1;
> > -
> > -     while (fgets(line, sizeof(line), fp)) {
> > -             p =3D skip_spaces(line);
> > -             if (*p =3D=3D '#')
> > -                     continue;
> > -
> > -             while (strlen(p)) {
> > -                     p =3D strstr(p, "-e");
> > -                     if (!p)
> > -                             break;
> > -
> > -                     p +=3D 2;
> > -                     p =3D skip_spaces(p);
> > -                     len =3D strcspn(p, " \t");
> > -                     if (!len)
> > -                             break;
> > -
> > -                     snprintf(evname, len + 1, "%s", p);
> > -
> > -                     match =3D 0;
> > -                     evlist__for_each_entry(session->evlist, pos) {
> > -                             if (evsel__name_is(pos, evname)) {
> > -                                     match =3D 1;
> > -                                     break;
> > -                             }
> > -                     }
> > -
> > -                     if (!match) {
> > -                             fclose(fp);
> > -                             return -1;
> > -                     }
> > -             }
> > -     }
> > -
> > -     fclose(fp);
> > -     return 0;
> > -}
> > -
> > -/*
> > - * Return -1 if none is found, otherwise the actual scripts number.
> > - *
> > - * Currently the only user of this function is the script browser, whi=
ch
> > - * will list all statically runnable scripts, select one, execute it a=
nd
> > - * show the output in a perf browser.
> > - */
> > -int find_scripts(char **scripts_array, char **scripts_path_array, int =
num,
> > -              int pathlen)
> > -{
> > -     struct dirent *script_dirent, *lang_dirent;
> > -     char scripts_path[MAXPATHLEN], lang_path[MAXPATHLEN];
> > -     DIR *scripts_dir, *lang_dir;
> > -     struct perf_session *session;
> > -     struct perf_data data =3D {
> > -             .path =3D input_name,
> > -             .mode =3D PERF_DATA_MODE_READ,
> > -     };
> > -     char *temp;
> > -     int i =3D 0;
> > -
> > -     session =3D perf_session__new(&data, NULL);
> > -     if (IS_ERR(session))
> > -             return PTR_ERR(session);
> > -
> > -     snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_pa=
th());
> > -
> > -     scripts_dir =3D opendir(scripts_path);
> > -     if (!scripts_dir) {
> > -             perf_session__delete(session);
> > -             return -1;
> > -     }
> > -
> > -     for_each_lang(scripts_path, scripts_dir, lang_dirent) {
> > -             scnprintf(lang_path, MAXPATHLEN, "%s/%s", scripts_path,
> > -                       lang_dirent->d_name);
> > -#ifndef HAVE_LIBPERL_SUPPORT
> > -             if (strstr(lang_path, "perl"))
> > -                     continue;
> > -#endif
> > -#ifndef HAVE_LIBPYTHON_SUPPORT
> > -             if (strstr(lang_path, "python"))
> > -                     continue;
> > -#endif
> > -
> > -             lang_dir =3D opendir(lang_path);
> > -             if (!lang_dir)
> > -                     continue;
> > -
> > -             for_each_script(lang_path, lang_dir, script_dirent) {
> > -                     /* Skip those real time scripts: xxxtop.p[yl] */
> > -                     if (strstr(script_dirent->d_name, "top."))
> > -                             continue;
> > -                     if (i >=3D num)
> > -                             break;
> > -                     snprintf(scripts_path_array[i], pathlen, "%s/%s",
> > -                             lang_path,
> > -                             script_dirent->d_name);
> > -                     temp =3D strchr(script_dirent->d_name, '.');
> > -                     snprintf(scripts_array[i],
> > -                             (temp - script_dirent->d_name) + 1,
> > -                             "%s", script_dirent->d_name);
> > -
> > -                     if (check_ev_match(lang_path,
> > -                                     scripts_array[i], session))
> > -                             continue;
> > -
> > -                     i++;
> > -             }
> > -             closedir(lang_dir);
> > -     }
> > -
> > -     closedir(scripts_dir);
> > -     perf_session__delete(session);
> > -     return i;
> > -}
> > -
> >  static char *get_script_path(const char *script_root, const char *suff=
ix)
> >  {
> >       struct dirent *script_dirent, *lang_dirent;
> > diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> > index 94f4b3769bf7..a07e93c53848 100644
> > --- a/tools/perf/builtin.h
> > +++ b/tools/perf/builtin.h
> > @@ -2,10 +2,6 @@
> >  #ifndef BUILTIN_H
> >  #define BUILTIN_H
> >
> > -#include <stddef.h>
> > -#include <linux/compiler.h>
> > -#include <tools/config.h>
> > -
> >  struct feature_status {
> >       const char *name;
> >       const char *macro;
> > @@ -56,6 +52,4 @@ int cmd_ftrace(int argc, const char **argv);
> >  int cmd_daemon(int argc, const char **argv);
> >  int cmd_kwork(int argc, const char **argv);
> >
> > -int find_scripts(char **scripts_array, char **scripts_path_array, int =
num,
> > -              int pathlen);
> >  #endif
> > diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/=
scripts.c
> > index e437d7889de6..2d04ece833aa 100644
> > --- a/tools/perf/ui/browsers/scripts.c
> > +++ b/tools/perf/ui/browsers/scripts.c
> > @@ -1,16 +1,18 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include "../../builtin.h"
> > -#include "../../perf.h"
> >  #include "../../util/util.h" // perf_exe()
> >  #include "../util.h"
> > +#include "../../util/evlist.h"
> >  #include "../../util/hist.h"
> >  #include "../../util/debug.h"
> > +#include "../../util/session.h"
> >  #include "../../util/symbol.h"
> >  #include "../browser.h"
> >  #include "../libslang.h"
> >  #include "config.h"
> > +#include <linux/err.h>
> >  #include <linux/string.h>
> >  #include <linux/zalloc.h>
> > +#include <subcmd/exec-cmd.h>
> >  #include <stdlib.h>
> >
> >  #define SCRIPT_NAMELEN       128
> > @@ -77,6 +79,177 @@ static int scripts_config(const char *var, const ch=
ar *value, void *data)
> >       return 0;
> >  }
> >
> > +/*
> > + * Some scripts specify the required events in their "xxx-record" file=
,
> > + * this function will check if the events in perf.data match those
> > + * mentioned in the "xxx-record".
> > + *
> > + * Fixme: All existing "xxx-record" are all in good formats "-e event =
",
> > + * which is covered well now. And new parsing code should be added to
> > + * cover the future complex formats like event groups etc.
> > + */
> > +static int check_ev_match(int dir_fd, const char *scriptname, struct p=
erf_session *session)
> > +{
> > +     char line[BUFSIZ];
> > +     FILE *fp;
> > +
> > +     {
> > +             char filename[FILENAME_MAX + 5];
> > +             int fd;
> > +
> > +             scnprintf(filename, sizeof(filename), "bin/%s-record", sc=
riptname);
> > +             fd =3D openat(dir_fd, filename, O_RDONLY);
> > +             if (fd =3D=3D -1)
> > +                     return -1;
> > +             fp =3D fdopen(fd, "r");
> > +             if (!fp)
> > +                     return -1;
> > +     }
> > +
> > +     while (fgets(line, sizeof(line), fp)) {
> > +             char *p =3D skip_spaces(line);
> > +
> > +             if (*p =3D=3D '#')
> > +                     continue;
> > +
> > +             while (strlen(p)) {
> > +                     int match, len;
> > +                     struct evsel *pos;
> > +                     char evname[128];
> > +
> > +                     p =3D strstr(p, "-e");
> > +                     if (!p)
> > +                             break;
> > +
> > +                     p +=3D 2;
> > +                     p =3D skip_spaces(p);
> > +                     len =3D strcspn(p, " \t");
> > +                     if (!len)
> > +                             break;
> > +
> > +                     snprintf(evname, len + 1, "%s", p);
> > +
> > +                     match =3D 0;
> > +                     evlist__for_each_entry(session->evlist, pos) {
> > +                             if (evsel__name_is(pos, evname)) {
> > +                                     match =3D 1;
> > +                                     break;
> > +                             }
> > +                     }
> > +
> > +                     if (!match) {
> > +                             fclose(fp);
> > +                             return -1;
> > +                     }
> > +             }
> > +     }
> > +
> > +     fclose(fp);
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Return -1 if none is found, otherwise the actual scripts number.
> > + *
> > + * Currently the only user of this function is the script browser, whi=
ch
> > + * will list all statically runnable scripts, select one, execute it a=
nd
> > + * show the output in a perf browser.
> > + */
> > +static int find_scripts(char **scripts_array, char **scripts_path_arra=
y, int num,
> > +              int pathlen)
> > +{
> > +     struct dirent *script_dirent, *lang_dirent;
> > +     int scripts_dir_fd, lang_dir_fd;
> > +     DIR *scripts_dir, *lang_dir;
> > +     struct perf_session *session;
> > +     struct perf_data data =3D {
> > +             .path =3D input_name,
> > +             .mode =3D PERF_DATA_MODE_READ,
> > +     };
> > +     char *temp;
> > +     int i =3D 0;
> > +     const char *exec_path =3D get_argv_exec_path();
> > +
> > +     session =3D perf_session__new(&data, NULL);
> > +     if (IS_ERR(session))
> > +             return PTR_ERR(session);
> > +
> > +     {
> > +             char scripts_path[PATH_MAX];
> > +
> > +             snprintf(scripts_path, sizeof(scripts_path), "%s/scripts"=
, exec_path);
> > +             scripts_dir_fd =3D open(scripts_path, O_DIRECTORY);
> > +             pr_err("Failed to open directory '%s'", scripts_path);
> > +             if (scripts_dir_fd =3D=3D -1) {
> > +                     perf_session__delete(session);
> > +                     return -1;
> > +             }
> > +     }
> > +     scripts_dir =3D fdopendir(scripts_dir_fd);
> > +     if (!scripts_dir) {
> > +             close(scripts_dir_fd);
> > +             perf_session__delete(session);
> > +             return -1;
> > +     }
> > +
> > +     while ((lang_dirent =3D readdir(scripts_dir)) !=3D NULL) {
> > +             if (lang_dirent->d_type !=3D DT_DIR &&
> > +                 (lang_dirent->d_type =3D=3D DT_UNKNOWN &&
> > +                  !is_directory_at(scripts_dir_fd, lang_dirent->d_name=
)))
> > +                     continue;
> > +             if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dir=
ent->d_name, ".."))
> > +                     continue;
> > +
> > +#ifndef HAVE_LIBPERL_SUPPORT
> > +             if (strstr(lang_dirent->d_name, "perl"))
> > +                     continue;
> > +#endif
> > +#ifndef HAVE_LIBPYTHON_SUPPORT
> > +             if (strstr(lang_dirent->d_name, "python"))
> > +                     continue;
> > +#endif
> > +
> > +             lang_dir_fd =3D openat(scripts_dir_fd, lang_dirent->d_nam=
e, O_DIRECTORY);
> > +             if (lang_dir_fd =3D=3D -1)
> > +                     continue;
> > +             lang_dir =3D fdopendir(lang_dir_fd);
> > +             if (!lang_dir) {
> > +                     close(lang_dir_fd);
> > +                     continue;
> > +             }
> > +             while ((script_dirent =3D readdir(lang_dir)) !=3D NULL) {
> > +                     if (script_dirent->d_type =3D=3D DT_DIR)
> > +                             continue;
> > +                     if (script_dirent->d_type =3D=3D DT_UNKNOWN &&
> > +                         is_directory_at(lang_dir_fd, script_dirent->d=
_name))
> > +                             continue;
> > +                     /* Skip those real time scripts: xxxtop.p[yl] */
> > +                     if (strstr(script_dirent->d_name, "top."))
> > +                             continue;
> > +                     if (i >=3D num)
> > +                             break;
> > +                     scnprintf(scripts_path_array[i], pathlen, "%s/scr=
ipts/%s/%s",
> > +                             exec_path,
> > +                             lang_dirent->d_name,
> > +                             script_dirent->d_name);
> > +                     temp =3D strchr(script_dirent->d_name, '.');
> > +                     snprintf(scripts_array[i],
> > +                             (temp - script_dirent->d_name) + 1,
> > +                             "%s", script_dirent->d_name);
> > +
> > +                     if (check_ev_match(lang_dir_fd, scripts_array[i],=
 session))
> > +                             continue;
> > +
> > +                     i++;
> > +             }
> > +             closedir(lang_dir);
> > +     }
> > +
> > +     closedir(scripts_dir);
> > +     perf_session__delete(session);
> > +     return i;
> > +}
> > +
> >  /*
> >   * When success, will copy the full path of the selected script
> >   * into  the buffer pointed by script_name, and return 0.
> > diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> > index 00adf872bf00..9712466c51e2 100644
> > --- a/tools/perf/util/path.c
> > +++ b/tools/perf/util/path.c
> > @@ -68,6 +68,16 @@ bool is_directory(const char *base_path, const struc=
t dirent *dent)
> >       return S_ISDIR(st.st_mode);
> >  }
> >
> > +bool is_directory_at(int dir_fd, const char *path)
> > +{
> > +     struct stat st;
> > +
> > +     if (fstatat(dir_fd, path, &st, /*flags=3D*/0))
> > +             return false;
> > +
> > +     return S_ISDIR(st.st_mode);
> > +}
> > +
> >  bool is_executable_file(const char *base_path, const struct dirent *de=
nt)
> >  {
> >       char path[PATH_MAX];
> > diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
> > index d94902c22222..fbafbe7015dd 100644
> > --- a/tools/perf/util/path.h
> > +++ b/tools/perf/util/path.h
> > @@ -12,6 +12,7 @@ int path__join3(char *bf, size_t size, const char *pa=
th1, const char *path2, con
> >
> >  bool is_regular_file(const char *file);
> >  bool is_directory(const char *base_path, const struct dirent *dent);
> > +bool is_directory_at(int dir_fd, const char *path);
> >  bool is_executable_file(const char *base_path, const struct dirent *de=
nt);
> >
> >  #endif /* _PERF_PATH_H */
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index ab67abf3b607..5f11ae88943d 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1306,12 +1306,6 @@ PyMODINIT_FUNC PyInit_perf(void)
> >  /* The following are stubs to avoid dragging in builtin-* objects. */
> >  /* TODO: move the code out of the builtin-* file into util. */
> >
> > -int find_scripts(char **scripts_array  __maybe_unused, char **scripts_=
path_array  __maybe_unused,
> > -             int num  __maybe_unused, int pathlen __maybe_unused)
> > -{
> > -     return -1;
> > -}
> > -
> >  void perf_stat__set_no_csv_summary(int set __maybe_unused)
> >  {
> >  }
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >
