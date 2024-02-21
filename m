Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE036120
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486909; cv=none; b=jgcRG08h60nkV8Flne5ImFYl3Gl6U3nGQRNXdId0EXmgHdPon56hvBYaFxvXHo8UDnl+jVAPlYB0KM7U7+pb+noEfVryKqAWWerSwR/o6b5+Gnb3httfaVzIRPrnnldCxEeWegABFE8SuBWLYtDPMC+w2SlKb2hDcK2/Yt0MvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486909; c=relaxed/simple;
	bh=tOt5l2NCH7u8iBK9RZ8OWBUeD2OcCtODl4u4V8s8FE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzUe49QbU7SWuJaam29VD2vyBJJXlc7IF930uy+LwYlRIqCmi+/uqfXMbALe6kRNoFPuG3lm3Al+GD9Il1j0VHrZ7Gz4eLIAde61jjnsWBPReebJiieZjhbVjOBKy0BFfUc5QyNB+o158RRmimmUpaW4gH9QfmC7z5Uvcr1zqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwKPaQ34; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwKPaQ34"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d5ce88b51cso82095ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 19:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708486907; x=1709091707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvAqAkgbW/xelvGlrdXZTd07LuHTYtpaG825O4dE6oM=;
        b=dwKPaQ34mn2y6NdW9ZXSYY6mK38op7tG1NPrDOV55PsC6pTcDGZjMvJvEbGKTWAKqX
         GfyY7tLOfseogi1den+n9H9xEzSw1/RtgFfaczvp9KzYPBqdNhPFXv/b6E18lVCb0Gnd
         gJuIjuDODI33sHqk7XNPuOJ5xGU5DXLpxQEamkgtuafXUHSHHT6mWS9bVd4uEk1zLB71
         J6Nd+ODWZVFNCyr6v9rq2VkFV8378fw5n/iAdmAtLQPrXlUrfSaPP5uQEyLRiJ5nu1X5
         /JVaTeF8xQabaPX3OREsoDocC5ohQigaToUS1zsBKTMUo8vQWc1o9t4adZhsVZeFb/hL
         9qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486907; x=1709091707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvAqAkgbW/xelvGlrdXZTd07LuHTYtpaG825O4dE6oM=;
        b=JcWm5FrXFc+VRk3UCrmhG2RqcKJfei1RtUoq61UdRSfj2eItSTfyoKfetYKDcKAM6a
         EtWn3NC1pUgXeWBMA4YLJBKZ5Y6MtrLqTPCppeVbv+l+uLtn7un9hTgjRSKfNkic0NbC
         X/dm3dOIzPrl/SRWsKimy3UuWs9o39GanrEakutA5XRWHa50jpp37KkeUxE7kb+xbrvX
         IgWytUGVNzwFvhSIhGWQbq9LnU+KrsdKeRVR5x5z8dLdBLIl9sgYosQGnl28ubpNXPAo
         J43sEasdR2xZFgaXPtnoHJ5eo+IXCjExs27zQuU5AVmz/0i6v2kXeJENmeu97kCqHCDt
         xVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlyd4N4hEq3GraTawIfbh8x6zbPMRv7siqiz4QoSIyYQzu2IdqlD7M90U5EPU7jS485NSXo+t9HdC98l3jKCT/NU2a4B0EzPmSBJpp/9aWrw==
X-Gm-Message-State: AOJu0YypO9bo9gENtb2uLaQ6p8VQkx/m6xY5nXBcQPegfjuLElh96Irv
	zjLvGQycc+UMcV//oBhrtp0v9Ixg4GI6IVZqD4i2Wvb2gBkaFp1mFbi4SJJB9wuBlm+5XPFfl3H
	bPt4ttAlrK+VJ1g3c9GawOGFaD511QSRsmKTw
X-Google-Smtp-Source: AGHT+IE71U9ga7lRXNd370dQWe3iXrJzaLeU11JpAAhtltpe+W8eTWDaAFc2J9tJ6z9NnCK8xNTHPojdUUy7TvYn4Ws=
X-Received: by 2002:a17:903:23c4:b0:1d9:a393:4a38 with SMTP id
 o4-20020a17090323c400b001d9a3934a38mr133184plh.26.1708486906623; Tue, 20 Feb
 2024 19:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216235203.229256-1-irogers@google.com> <20240216235203.229256-7-irogers@google.com>
 <CAM9d7cgavJtfVjcESq4HRvm9mvmRL9KrfO5HsTMPrgfLvxnymQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgavJtfVjcESq4HRvm9mvmRL9KrfO5HsTMPrgfLvxnymQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Feb 2024 19:41:32 -0800
Message-ID: <CAP-5=fUOBaU=rV99_ShB3XycuePw-bndjkmLTnCoxqncPU6BkQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] perf tests: Use scandirat for shell script finding
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 16, 2024 at 3:55=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Avoid filename appending buffers by using openat, faccessat and
> > scandirat more widely. Turn the script's path back to a file name
> > using readlink from /proc/<pid>/fd/<fd>.
> >
> > Read the script's description using api/io.h to avoid fdopen
> > conversions. Whilst reading perform additional sanity checks on the
> > script's contents.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ditto.
>
>   tests/tests-scripts.c: In function 'append_scripts_in_dir':
>   tests/tests-scripts.c:200:18: error: implicit declaration of
> function 'scandirat'; did you mean 'scandir'?
> [-Werror=3Dimplicit-function-declaration]
>   200 |         n_dirs =3D scandirat(dir_fd, ".", &entlist, NULL,
> alphasort);
>   |                  ^~~~~~~~~
>   |                  scandir

Sorry, missed the workaround definition in util.h. Will fix in v6.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > ---
> >  tools/perf/tests/builtin-test.c  |  20 ++---
> >  tools/perf/tests/tests-scripts.c | 144 ++++++++++++++++++-------------
> >  tools/perf/tests/tests-scripts.h |   1 -
> >  3 files changed, 94 insertions(+), 71 deletions(-)
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index eff3c62e9b47..162f9eb090ac 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -300,22 +300,19 @@ static int test_and_print(struct test_suite *t, i=
nt subtest)
> >  }
> >
> >  struct shell_test {
> > -       const char *dir;
> >         const char *file;
> >  };
> >
> >  static int shell_test__run(struct test_suite *test, int subdir __maybe=
_unused)
> >  {
> >         int err;
> > -       char script[PATH_MAX];
> >         struct shell_test *st =3D test->priv;
> > +       char *cmd =3D NULL;
> >
> > -       path__join(script, sizeof(script) - 3, st->dir, st->file);
> > -
> > -       if (verbose > 0)
> > -               strncat(script, " -v", sizeof(script) - strlen(script) =
- 1);
> > -
> > -       err =3D system(script);
> > +       if (asprintf(&cmd, "%s%s", st->file, verbose ? " -v" : "") < 0)
> > +               return TEST_FAIL;
> > +       err =3D system(cmd);
> > +       free(cmd);
> >         if (!err)
> >                 return TEST_OK;
> >
> > @@ -331,7 +328,7 @@ static int run_shell_tests(int argc, const char *ar=
gv[], int i, int width,
> >         files =3D list_script_files();
> >         if (!files)
> >                 return 0;
> > -       for (file =3D files; file->dir; file++) {
> > +       for (file =3D files; file->file; file++) {
> >                 int curr =3D i++;
> >                 struct test_case test_cases[] =3D {
> >                         {
> > @@ -345,13 +342,12 @@ static int run_shell_tests(int argc, const char *=
argv[], int i, int width,
> >                         .test_cases =3D test_cases,
> >                         .priv =3D &st,
> >                 };
> > -               st.dir =3D file->dir;
> > +               st.file =3D file->file;
> >
> >                 if (test_suite.desc =3D=3D NULL ||
> >                     !perf_test__matches(test_suite.desc, curr, argc, ar=
gv))
> >                         continue;
> >
> > -               st.file =3D file->file;
> >                 pr_info("%3d: %-*s:", i, width, test_suite.desc);
> >
> >                 if (intlist__find(skiplist, i)) {
> > @@ -455,7 +451,7 @@ static int perf_test__list_shell(int argc, const ch=
ar **argv, int i)
> >         files =3D list_script_files();
> >         if (!files)
> >                 return 0;
> > -       for (file =3D files; file->dir; file++) {
> > +       for (file =3D files; file->file; file++) {
> >                 int curr =3D i++;
> >                 struct test_suite t =3D {
> >                         .desc =3D file->desc
> > diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-=
scripts.c
> > index 4ebd841da05b..9b3b66dd5508 100644
> > --- a/tools/perf/tests/tests-scripts.c
> > +++ b/tools/perf/tests/tests-scripts.c
> > @@ -14,6 +14,7 @@
> >  #include <subcmd/parse-options.h>
> >  #include <sys/wait.h>
> >  #include <sys/stat.h>
> > +#include <api/io.h>
> >  #include "builtin.h"
> >  #include "tests-scripts.h"
> >  #include "color.h"
> > @@ -35,55 +36,69 @@ static size_t files_num =3D 0;
> >  static struct script_file *files =3D NULL;
> >  static int files_max_width =3D 0;
> >
> > -static const char *shell_tests__dir(char *path, size_t size)
> > +static int shell_tests__dir_fd(void)
> >  {
> > -       const char *devel_dirs[] =3D { "./tools/perf/tests", "./tests",=
 };
> > -       char *exec_path;
> > -       unsigned int i;
> > +       char path[PATH_MAX], *exec_path;
> > +       static const char * const devel_dirs[] =3D { "./tools/perf/test=
s/shell", "./tests/shell", };
> >
> > -       for (i =3D 0; i < ARRAY_SIZE(devel_dirs); ++i) {
> > -               struct stat st;
> > +       for (size_t i =3D 0; i < ARRAY_SIZE(devel_dirs); ++i) {
> > +               int fd =3D open(devel_dirs[i], O_PATH);
> >
> > -               if (!lstat(devel_dirs[i], &st)) {
> > -                       scnprintf(path, size, "%s/shell", devel_dirs[i]=
);
> > -                       if (!lstat(devel_dirs[i], &st))
> > -                               return path;
> > -               }
> > +               if (fd >=3D 0)
> > +                       return fd;
> >         }
> >
> >         /* Then installed path. */
> >         exec_path =3D get_argv_exec_path();
> > -       scnprintf(path, size, "%s/tests/shell", exec_path);
> > +       scnprintf(path, sizeof(path), "%s/tests/shell", exec_path);
> >         free(exec_path);
> > -       return path;
> > +       return open(path, O_PATH);
> >  }
> >
> > -static const char *shell_test__description(char *description, size_t s=
ize,
> > -                                           const char *path, const cha=
r *name)
> > +static char *shell_test__description(int dir_fd, const char *name)
> >  {
> > -       FILE *fp;
> > -       char filename[PATH_MAX];
> > -       int ch;
> > +       struct io io;
> > +       char buf[128], desc[256];
> > +       int ch, pos =3D 0;
> >
> > -       path__join(filename, sizeof(filename), path, name);
> > -       fp =3D fopen(filename, "r");
> > -       if (!fp)
> > +       io__init(&io, openat(dir_fd, name, O_RDONLY), buf, sizeof(buf))=
;
> > +       if (io.fd < 0)
> >                 return NULL;
> >
> >         /* Skip first line - should be #!/bin/sh Shebang */
> > +       if (io__get_char(&io) !=3D '#')
> > +               goto err_out;
> > +       if (io__get_char(&io) !=3D '!')
> > +               goto err_out;
> >         do {
> > -               ch =3D fgetc(fp);
> > -       } while (ch !=3D EOF && ch !=3D '\n');
> > -
> > -       description =3D fgets(description, size, fp);
> > -       fclose(fp);
> > +               ch =3D io__get_char(&io);
> > +               if (ch < 0)
> > +                       goto err_out;
> > +       } while (ch !=3D '\n');
> >
> > -       /* Assume first char on line is omment everything after that de=
sc */
> > -       return description ? strim(description + 1) : NULL;
> > +       do {
> > +               ch =3D io__get_char(&io);
> > +               if (ch < 0)
> > +                       goto err_out;
> > +       } while (ch =3D=3D '#' || isspace(ch));
> > +       while (ch > 0 && ch !=3D '\n') {
> > +               desc[pos++] =3D ch;
> > +               if (pos >=3D (int)sizeof(desc) - 1)
> > +                       break;
> > +               ch =3D io__get_char(&io);
> > +       }
> > +       while (pos > 0 && isspace(desc[--pos]))
> > +               ;
> > +       desc[++pos] =3D '\0';
> > +       close(io.fd);
> > +       return strdup(desc);
> > +err_out:
> > +       close(io.fd);
> > +       return NULL;
> >  }
> >
> >  /* Is this full file path a shell script */
> > -static bool is_shell_script(const char *path)
> > +static bool is_shell_script(int dir_fd, const char *path)
> >  {
> >         const char *ext;
> >
> > @@ -91,20 +106,16 @@ static bool is_shell_script(const char *path)
> >         if (!ext)
> >                 return false;
> >         if (!strcmp(ext, ".sh")) { /* Has .sh extension */
> > -               if (access(path, R_OK | X_OK) =3D=3D 0) /* Is executabl=
e */
> > +               if (faccessat(dir_fd, path, R_OK | X_OK, 0) =3D=3D 0) /=
* Is executable */
> >                         return true;
> >         }
> >         return false;
> >  }
> >
> >  /* Is this file in this dir a shell script (for test purposes) */
> > -static bool is_test_script(const char *path, const char *name)
> > +static bool is_test_script(int dir_fd, const char *name)
> >  {
> > -       char filename[PATH_MAX];
> > -
> > -       path__join(filename, sizeof(filename), path, name);
> > -       if (!is_shell_script(filename)) return false;
> > -       return true;
> > +       return is_shell_script(dir_fd, name);
> >  }
> >
> >  /* Duplicate a string and fall over and die if we run out of memory */
> > @@ -120,12 +131,21 @@ static char *strdup_check(const char *str)
> >         return newstr;
> >  }
> >
> > -static void append_script(const char *dir, const char *file, const cha=
r *desc)
> > +static void append_script(int dir_fd, const char *name, char *desc)
> >  {
> > +       char filename[PATH_MAX], link[128];
> >         struct script_file *files_tmp;
> > -       size_t files_num_tmp;
> > +       size_t files_num_tmp, len;
> >         int width;
> >
> > +       snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd=
);
> > +       len =3D readlink(link, filename, sizeof(filename));
> > +       if (len < 0) {
> > +               pr_err("Failed to readlink %s", link);
> > +               return;
> > +       }
> > +       filename[len++] =3D '/';
> > +       strcpy(&filename[len], name);
> >         files_num_tmp =3D files_num + 1;
> >         if (files_num_tmp >=3D SIZE_MAX) {
> >                 pr_err("Too many script files\n");
> > @@ -142,10 +162,8 @@ static void append_script(const char *dir, const c=
har *file, const char *desc)
> >         /* Add file to end and NULL terminate the struct array */
> >         files =3D files_tmp;
> >         files_num =3D files_num_tmp;
> > -       files[files_num - 1].dir =3D strdup_check(dir);
> > -       files[files_num - 1].file =3D strdup_check(file);
> > -       files[files_num - 1].desc =3D strdup_check(desc);
> > -       files[files_num].dir =3D NULL;
> > +       files[files_num - 1].file =3D strdup_check(filename);
> > +       files[files_num - 1].desc =3D desc;
> >         files[files_num].file =3D NULL;
> >         files[files_num].desc =3D NULL;
> >
> > @@ -154,32 +172,39 @@ static void append_script(const char *dir, const =
char *file, const char *desc)
> >                 files_max_width =3D width;
> >  }
> >
> > -static void append_scripts_in_dir(const char *path)
> > +static void append_scripts_in_dir(int dir_fd)
> >  {
> >         struct dirent **entlist;
> >         struct dirent *ent;
> >         int n_dirs, i;
> > -       char filename[PATH_MAX];
> >
> >         /* List files, sorted by alpha */
> > -       n_dirs =3D scandir(path, &entlist, NULL, alphasort);
> > +       n_dirs =3D scandirat(dir_fd, ".", &entlist, NULL, alphasort);
> >         if (n_dirs =3D=3D -1)
> >                 return;
> >         for (i =3D 0; i < n_dirs && (ent =3D entlist[i]); i++) {
> > +               int fd;
> > +
> >                 if (ent->d_name[0] =3D=3D '.')
> >                         continue; /* Skip hidden files */
> > -               if (is_test_script(path, ent->d_name)) { /* It's a test=
 */
> > -                       char bf[256];
> > -                       const char *desc =3D shell_test__description
> > -                               (bf, sizeof(bf), path, ent->d_name);
> > +               if (is_test_script(dir_fd, ent->d_name)) { /* It's a te=
st */
> > +                       char *desc =3D shell_test__description(dir_fd, =
ent->d_name);
> >
> >                         if (desc) /* It has a desc line - valid script =
*/
> > -                               append_script(path, ent->d_name, desc);
> > -               } else if (is_directory(path, ent)) { /* Scan the subdi=
r */
> > -                       path__join(filename, sizeof(filename),
> > -                                  path, ent->d_name);
> > -                       append_scripts_in_dir(filename);
> > +                               append_script(dir_fd, ent->d_name, desc=
);
> > +                       continue;
> > +               }
> > +               if (ent->d_type !=3D DT_DIR) {
> > +                       struct stat st;
> > +
> > +                       if (ent->d_type !=3D DT_UNKNOWN)
> > +                               continue;
> > +                       fstatat(dir_fd, ent->d_name, &st, 0);
> > +                       if (!S_ISDIR(st.st_mode))
> > +                               continue;
> >                 }
> > +               fd =3D openat(dir_fd, ent->d_name, O_PATH);
> > +               append_scripts_in_dir(fd);
> >         }
> >         for (i =3D 0; i < n_dirs; i++) /* Clean up */
> >                 zfree(&entlist[i]);
> > @@ -188,14 +213,17 @@ static void append_scripts_in_dir(const char *pat=
h)
> >
> >  const struct script_file *list_script_files(void)
> >  {
> > -       char path_dir[PATH_MAX];
> > -       const char *path;
> > +       int dir_fd;
> >
> >         if (files)
> >                 return files; /* Singleton - we already know our list *=
/
> >
> > -       path =3D shell_tests__dir(path_dir, sizeof(path_dir)); /* Walk =
 dir */
> > -       append_scripts_in_dir(path);
> > +       dir_fd =3D shell_tests__dir_fd(); /* Walk  dir */
> > +       if (dir_fd < 0)
> > +               return NULL;
> > +
> > +       append_scripts_in_dir(dir_fd);
> > +       close(dir_fd);
> >
> >         return files;
> >  }
> > diff --git a/tools/perf/tests/tests-scripts.h b/tools/perf/tests/tests-=
scripts.h
> > index 3a3ec6191848..3508a293aaf9 100644
> > --- a/tools/perf/tests/tests-scripts.h
> > +++ b/tools/perf/tests/tests-scripts.h
> > @@ -3,7 +3,6 @@
> >  #define TESTS_SCRIPTS_H
> >
> >  struct script_file {
> > -       char *dir;
> >         char *file;
> >         char *desc;
> >  };
> > --
> > 2.44.0.rc0.258.g7320e95886-goog
> >
