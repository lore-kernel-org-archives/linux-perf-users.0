Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98822347C7;
	Thu, 31 Oct 2024 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402290; cv=none; b=jsL7TXQUcLBhz/X7wWGImCZ/mFPVV9hGcfTxWU56oldja7inuCTJtvbD1x/+QtPFSUJYsmuYlZQTYOgwsRXTwUJkraaMWVnsZ5p68qEVFzoJ7CLjhnMziigJafMzyIwIbRjOXgCUNIZfLoCIJrWCXwqjHe30+KO0zu4T0h8hW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402290; c=relaxed/simple;
	bh=QRapKp7LI+jSrloS+B0cqtakWXy2arvxR656abUf6SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6IPkdBAVeqUr372AQGQD045fUXUU4l3Lcy6BuWqo949p6nnLVPCVeMv6dZy0K98PjHHtGlY473xyxGW7Vrlr3Sh7AE1KU5DYu/FASSd9VaW+1/PqcefNqd0gAkoyx5yqULGeiQeU7vypmuAmNXZ9Bys65JUevJ4I2POldNuilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u79OR8Uv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u79OR8Uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642B6C4CEC3;
	Thu, 31 Oct 2024 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402290;
	bh=QRapKp7LI+jSrloS+B0cqtakWXy2arvxR656abUf6SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u79OR8UveFFlO3KAbk5b3rtPJwx4Ej/hBizdS5HNCgTb4+QqWg5feSWDpgaDPJOPs
	 mHm2r7gjlkqsf+oH8hjmSh2/PUIN5Nv6f5Y4hcysfLVfjYJpOCdsKhGDj7D++nhYFG
	 fJx2mgsXJIfSz/MWinHnWox173heXLDsRU/YIAFy/PHxdi4B9TLJ3OQvUKFJ4RIucZ
	 YOgbJGZ/QHxWShntA1OeftI9OeFgqmrJ0hqIE0KGr3iULjO21lSQRm79PAzy8q//54
	 o1ydOnWW38AfqpPHU4cRyvfN7zho0O4tAoExUhspm+58omMN189n8bhaR6q7KP23xl
	 4uHqN7wqWV7OQ==
Date: Thu, 31 Oct 2024 16:18:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to
 browser/scripts.c
Message-ID: <ZyPX7ayIO4teziDX@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-7-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> The only use of find_scripts is in browser/scripts.c but the
> definition in builtin causes linking problems requiring a stub in
> python.c. Move the function to allow the stub to be removed.
> 
> Rewrite the directory iteration to use openat so that large character
> arrays aren't needed. The arrays are warned about potential buffer
> overflows by GCC now that all the code exists in a single C file.

Introducing is_directory_at() should be done as a prep patch, as the
rest of the patch below could end up being reverted after some other
patch used it, making the process more difficult.

I mentioned cases like this in the past, so doing it again just for the
record.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-script.c      | 138 ------------------------
>  tools/perf/builtin.h             |   6 --
>  tools/perf/ui/browsers/scripts.c | 177 ++++++++++++++++++++++++++++++-
>  tools/perf/util/path.c           |  10 ++
>  tools/perf/util/path.h           |   1 +
>  tools/perf/util/python.c         |   6 --
>  6 files changed, 186 insertions(+), 152 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 5d5a1a06d8c6..e9ec74056f71 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3521,144 +3521,6 @@ static void free_dlarg(void)
>  	free(dlargv);
>  }
>  
> -/*
> - * Some scripts specify the required events in their "xxx-record" file,
> - * this function will check if the events in perf.data match those
> - * mentioned in the "xxx-record".
> - *
> - * Fixme: All existing "xxx-record" are all in good formats "-e event ",
> - * which is covered well now. And new parsing code should be added to
> - * cover the future complex formats like event groups etc.
> - */
> -static int check_ev_match(char *dir_name, char *scriptname,
> -			struct perf_session *session)
> -{
> -	char filename[MAXPATHLEN], evname[128];
> -	char line[BUFSIZ], *p;
> -	struct evsel *pos;
> -	int match, len;
> -	FILE *fp;
> -
> -	scnprintf(filename, MAXPATHLEN, "%s/bin/%s-record", dir_name, scriptname);
> -
> -	fp = fopen(filename, "r");
> -	if (!fp)
> -		return -1;
> -
> -	while (fgets(line, sizeof(line), fp)) {
> -		p = skip_spaces(line);
> -		if (*p == '#')
> -			continue;
> -
> -		while (strlen(p)) {
> -			p = strstr(p, "-e");
> -			if (!p)
> -				break;
> -
> -			p += 2;
> -			p = skip_spaces(p);
> -			len = strcspn(p, " \t");
> -			if (!len)
> -				break;
> -
> -			snprintf(evname, len + 1, "%s", p);
> -
> -			match = 0;
> -			evlist__for_each_entry(session->evlist, pos) {
> -				if (evsel__name_is(pos, evname)) {
> -					match = 1;
> -					break;
> -				}
> -			}
> -
> -			if (!match) {
> -				fclose(fp);
> -				return -1;
> -			}
> -		}
> -	}
> -
> -	fclose(fp);
> -	return 0;
> -}
> -
> -/*
> - * Return -1 if none is found, otherwise the actual scripts number.
> - *
> - * Currently the only user of this function is the script browser, which
> - * will list all statically runnable scripts, select one, execute it and
> - * show the output in a perf browser.
> - */
> -int find_scripts(char **scripts_array, char **scripts_path_array, int num,
> -		 int pathlen)
> -{
> -	struct dirent *script_dirent, *lang_dirent;
> -	char scripts_path[MAXPATHLEN], lang_path[MAXPATHLEN];
> -	DIR *scripts_dir, *lang_dir;
> -	struct perf_session *session;
> -	struct perf_data data = {
> -		.path = input_name,
> -		.mode = PERF_DATA_MODE_READ,
> -	};
> -	char *temp;
> -	int i = 0;
> -
> -	session = perf_session__new(&data, NULL);
> -	if (IS_ERR(session))
> -		return PTR_ERR(session);
> -
> -	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
> -
> -	scripts_dir = opendir(scripts_path);
> -	if (!scripts_dir) {
> -		perf_session__delete(session);
> -		return -1;
> -	}
> -
> -	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
> -		scnprintf(lang_path, MAXPATHLEN, "%s/%s", scripts_path,
> -			  lang_dirent->d_name);
> -#ifndef HAVE_LIBPERL_SUPPORT
> -		if (strstr(lang_path, "perl"))
> -			continue;
> -#endif
> -#ifndef HAVE_LIBPYTHON_SUPPORT
> -		if (strstr(lang_path, "python"))
> -			continue;
> -#endif
> -
> -		lang_dir = opendir(lang_path);
> -		if (!lang_dir)
> -			continue;
> -
> -		for_each_script(lang_path, lang_dir, script_dirent) {
> -			/* Skip those real time scripts: xxxtop.p[yl] */
> -			if (strstr(script_dirent->d_name, "top."))
> -				continue;
> -			if (i >= num)
> -				break;
> -			snprintf(scripts_path_array[i], pathlen, "%s/%s",
> -				lang_path,
> -				script_dirent->d_name);
> -			temp = strchr(script_dirent->d_name, '.');
> -			snprintf(scripts_array[i],
> -				(temp - script_dirent->d_name) + 1,
> -				"%s", script_dirent->d_name);
> -
> -			if (check_ev_match(lang_path,
> -					scripts_array[i], session))
> -				continue;
> -
> -			i++;
> -		}
> -		closedir(lang_dir);
> -	}
> -
> -	closedir(scripts_dir);
> -	perf_session__delete(session);
> -	return i;
> -}
> -
>  static char *get_script_path(const char *script_root, const char *suffix)
>  {
>  	struct dirent *script_dirent, *lang_dirent;
> diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> index 94f4b3769bf7..a07e93c53848 100644
> --- a/tools/perf/builtin.h
> +++ b/tools/perf/builtin.h
> @@ -2,10 +2,6 @@
>  #ifndef BUILTIN_H
>  #define BUILTIN_H
>  
> -#include <stddef.h>
> -#include <linux/compiler.h>
> -#include <tools/config.h>
> -
>  struct feature_status {
>  	const char *name;
>  	const char *macro;
> @@ -56,6 +52,4 @@ int cmd_ftrace(int argc, const char **argv);
>  int cmd_daemon(int argc, const char **argv);
>  int cmd_kwork(int argc, const char **argv);
>  
> -int find_scripts(char **scripts_array, char **scripts_path_array, int num,
> -		 int pathlen);
>  #endif
> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> index e437d7889de6..2d04ece833aa 100644
> --- a/tools/perf/ui/browsers/scripts.c
> +++ b/tools/perf/ui/browsers/scripts.c
> @@ -1,16 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "../../builtin.h"
> -#include "../../perf.h"
>  #include "../../util/util.h" // perf_exe()
>  #include "../util.h"
> +#include "../../util/evlist.h"
>  #include "../../util/hist.h"
>  #include "../../util/debug.h"
> +#include "../../util/session.h"
>  #include "../../util/symbol.h"
>  #include "../browser.h"
>  #include "../libslang.h"
>  #include "config.h"
> +#include <linux/err.h>
>  #include <linux/string.h>
>  #include <linux/zalloc.h>
> +#include <subcmd/exec-cmd.h>
>  #include <stdlib.h>
>  
>  #define SCRIPT_NAMELEN	128
> @@ -77,6 +79,177 @@ static int scripts_config(const char *var, const char *value, void *data)
>  	return 0;
>  }
>  
> +/*
> + * Some scripts specify the required events in their "xxx-record" file,
> + * this function will check if the events in perf.data match those
> + * mentioned in the "xxx-record".
> + *
> + * Fixme: All existing "xxx-record" are all in good formats "-e event ",
> + * which is covered well now. And new parsing code should be added to
> + * cover the future complex formats like event groups etc.
> + */
> +static int check_ev_match(int dir_fd, const char *scriptname, struct perf_session *session)
> +{
> +	char line[BUFSIZ];
> +	FILE *fp;
> +
> +	{
> +		char filename[FILENAME_MAX + 5];
> +		int fd;
> +
> +		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
> +		fd = openat(dir_fd, filename, O_RDONLY);
> +		if (fd == -1)
> +			return -1;
> +		fp = fdopen(fd, "r");
> +		if (!fp)
> +			return -1;
> +	}
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		char *p = skip_spaces(line);
> +
> +		if (*p == '#')
> +			continue;
> +
> +		while (strlen(p)) {
> +			int match, len;
> +			struct evsel *pos;
> +			char evname[128];
> +
> +			p = strstr(p, "-e");
> +			if (!p)
> +				break;
> +
> +			p += 2;
> +			p = skip_spaces(p);
> +			len = strcspn(p, " \t");
> +			if (!len)
> +				break;
> +
> +			snprintf(evname, len + 1, "%s", p);
> +
> +			match = 0;
> +			evlist__for_each_entry(session->evlist, pos) {
> +				if (evsel__name_is(pos, evname)) {
> +					match = 1;
> +					break;
> +				}
> +			}
> +
> +			if (!match) {
> +				fclose(fp);
> +				return -1;
> +			}
> +		}
> +	}
> +
> +	fclose(fp);
> +	return 0;
> +}
> +
> +/*
> + * Return -1 if none is found, otherwise the actual scripts number.
> + *
> + * Currently the only user of this function is the script browser, which
> + * will list all statically runnable scripts, select one, execute it and
> + * show the output in a perf browser.
> + */
> +static int find_scripts(char **scripts_array, char **scripts_path_array, int num,
> +		 int pathlen)
> +{
> +	struct dirent *script_dirent, *lang_dirent;
> +	int scripts_dir_fd, lang_dir_fd;
> +	DIR *scripts_dir, *lang_dir;
> +	struct perf_session *session;
> +	struct perf_data data = {
> +		.path = input_name,
> +		.mode = PERF_DATA_MODE_READ,
> +	};
> +	char *temp;
> +	int i = 0;
> +	const char *exec_path = get_argv_exec_path();
> +
> +	session = perf_session__new(&data, NULL);
> +	if (IS_ERR(session))
> +		return PTR_ERR(session);
> +
> +	{
> +		char scripts_path[PATH_MAX];
> +
> +		snprintf(scripts_path, sizeof(scripts_path), "%s/scripts", exec_path);
> +		scripts_dir_fd = open(scripts_path, O_DIRECTORY);
> +		pr_err("Failed to open directory '%s'", scripts_path);
> +		if (scripts_dir_fd == -1) {
> +			perf_session__delete(session);
> +			return -1;
> +		}
> +	}
> +	scripts_dir = fdopendir(scripts_dir_fd);
> +	if (!scripts_dir) {
> +		close(scripts_dir_fd);
> +		perf_session__delete(session);
> +		return -1;
> +	}
> +
> +	while ((lang_dirent = readdir(scripts_dir)) != NULL) {
> +		if (lang_dirent->d_type != DT_DIR &&
> +		    (lang_dirent->d_type == DT_UNKNOWN &&
> +		     !is_directory_at(scripts_dir_fd, lang_dirent->d_name)))
> +			continue;
> +		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, ".."))
> +			continue;
> +
> +#ifndef HAVE_LIBPERL_SUPPORT
> +		if (strstr(lang_dirent->d_name, "perl"))
> +			continue;
> +#endif
> +#ifndef HAVE_LIBPYTHON_SUPPORT
> +		if (strstr(lang_dirent->d_name, "python"))
> +			continue;
> +#endif
> +
> +		lang_dir_fd = openat(scripts_dir_fd, lang_dirent->d_name, O_DIRECTORY);
> +		if (lang_dir_fd == -1)
> +			continue;
> +		lang_dir = fdopendir(lang_dir_fd);
> +		if (!lang_dir) {
> +			close(lang_dir_fd);
> +			continue;
> +		}
> +		while ((script_dirent = readdir(lang_dir)) != NULL) {
> +			if (script_dirent->d_type == DT_DIR)
> +				continue;
> +			if (script_dirent->d_type == DT_UNKNOWN &&
> +			    is_directory_at(lang_dir_fd, script_dirent->d_name))
> +				continue;
> +			/* Skip those real time scripts: xxxtop.p[yl] */
> +			if (strstr(script_dirent->d_name, "top."))
> +				continue;
> +			if (i >= num)
> +				break;
> +			scnprintf(scripts_path_array[i], pathlen, "%s/scripts/%s/%s",
> +				exec_path,
> +				lang_dirent->d_name,
> +				script_dirent->d_name);
> +			temp = strchr(script_dirent->d_name, '.');
> +			snprintf(scripts_array[i],
> +				(temp - script_dirent->d_name) + 1,
> +				"%s", script_dirent->d_name);
> +
> +			if (check_ev_match(lang_dir_fd, scripts_array[i], session))
> +				continue;
> +
> +			i++;
> +		}
> +		closedir(lang_dir);
> +	}
> +
> +	closedir(scripts_dir);
> +	perf_session__delete(session);
> +	return i;
> +}
> +
>  /*
>   * When success, will copy the full path of the selected script
>   * into  the buffer pointed by script_name, and return 0.
> diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> index 00adf872bf00..9712466c51e2 100644
> --- a/tools/perf/util/path.c
> +++ b/tools/perf/util/path.c
> @@ -68,6 +68,16 @@ bool is_directory(const char *base_path, const struct dirent *dent)
>  	return S_ISDIR(st.st_mode);
>  }
>  
> +bool is_directory_at(int dir_fd, const char *path)
> +{
> +	struct stat st;
> +
> +	if (fstatat(dir_fd, path, &st, /*flags=*/0))
> +		return false;
> +
> +	return S_ISDIR(st.st_mode);
> +}
> +
>  bool is_executable_file(const char *base_path, const struct dirent *dent)
>  {
>  	char path[PATH_MAX];
> diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
> index d94902c22222..fbafbe7015dd 100644
> --- a/tools/perf/util/path.h
> +++ b/tools/perf/util/path.h
> @@ -12,6 +12,7 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
>  
>  bool is_regular_file(const char *file);
>  bool is_directory(const char *base_path, const struct dirent *dent);
> +bool is_directory_at(int dir_fd, const char *path);
>  bool is_executable_file(const char *base_path, const struct dirent *dent);
>  
>  #endif /* _PERF_PATH_H */
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index ab67abf3b607..5f11ae88943d 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1306,12 +1306,6 @@ PyMODINIT_FUNC PyInit_perf(void)
>  /* The following are stubs to avoid dragging in builtin-* objects. */
>  /* TODO: move the code out of the builtin-* file into util. */
>  
> -int find_scripts(char **scripts_array  __maybe_unused, char **scripts_path_array  __maybe_unused,
> -		int num  __maybe_unused, int pathlen __maybe_unused)
> -{
> -	return -1;
> -}
> -
>  void perf_stat__set_no_csv_summary(int set __maybe_unused)
>  {
>  }
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
