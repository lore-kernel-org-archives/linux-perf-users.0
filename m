Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F6DDAB;
	Tue, 19 Nov 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731975963; cv=none; b=Vx9x+2icBhPqGAjlyGBmtu7PM5fyBQ4Y+0q0VShZEH7KATgf7VCYzudzYPxiNIgvnONunlytzv+5lw8FEAJ8GaNYrnDQSYFe3wEffnQXMRNIw+cZdMSQpz1PLSAJlG3TwMMuR95zu1v8cPV7EqvXbD4zejDX8v/bb1WKjppHp78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731975963; c=relaxed/simple;
	bh=5Bim+cfyRoKmaKNJo28pShEmtGmhlbCVeW2C/1ESDOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1o8GKVQg3BVym4Cw5dm3J1ryrqW536C1kjlfa/EUDR5Pis2aPft1mkRf6nOjUBlvEtgexX5wOezMPeDgxpjtYaRxmTtm0mRN1q1cfmKoDj7CPQ5OlzllVA5DLtL0qXcTPZWXkFh+AfIFcIa5kJz1tltKtL1X4rWgV6egm/Km/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAITPclp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAITPclp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFCCC4CECC;
	Tue, 19 Nov 2024 00:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731975963;
	bh=5Bim+cfyRoKmaKNJo28pShEmtGmhlbCVeW2C/1ESDOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAITPclpbHyKjvjiWDXoPDbU7n5OUzuT0oGh5BuU004vao4zA3a64XNAdJkKqkPQW
	 MQLLwzx7t3jIPAwK5oiHVq68HQcXM5Zjh3yZ/G+xWVH3USI187B7w7INfMU1S7T3Qo
	 sk2uDrsAB0WUsllqLruD2z4N+Yc/MtTZWj3NfFsOmrSvoEezOm+0YaRnz96xq+4+CK
	 2bUZM2RjMxXYirM561DeNuMvAwg7Fr4ZLiOfXxBrQ7BHoQUpzfGUiFE1g+S9nv2vQQ
	 hOSqVWisbR0ZrgCez4FAStUTv3MRQpElyk/RKB3U6G14OEYP1HmJmEWgCMhZ7zIBNJ
	 KltIR963pXbCA==
Date: Mon, 18 Nov 2024 16:26:00 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v6 07/22] perf script: Move find_scripts to
 browser/scripts.c
Message-ID: <ZzvbGK2uOTwuibZq@google.com>
References: <20241109061809.811922-1-irogers@google.com>
 <20241109061809.811922-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241109061809.811922-8-irogers@google.com>

On Fri, Nov 08, 2024 at 10:17:54PM -0800, Ian Rogers wrote:
> The only use of find_scripts is in browser/scripts.c but the
> definition in builtin causes linking problems requiring a stub in
> python.c. Move the function to allow the stub to be removed.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-script.c      | 171 -----------------------------
>  tools/perf/builtin.h             |   6 --
>  tools/perf/ui/browsers/scripts.c | 177 ++++++++++++++++++++++++++++++-
>  tools/perf/util/python.c         |   6 --
>  4 files changed, 175 insertions(+), 185 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index e20d55b8a741..e9ec74056f71 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3521,177 +3521,6 @@ static void free_dlarg(void)
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
> -static int check_ev_match(int dir_fd, const char *scriptname, struct perf_session *session)
> -{
> -	char line[BUFSIZ];
> -	FILE *fp;
> -
> -	{
> -		char filename[FILENAME_MAX + 5];
> -		int fd;
> -
> -		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
> -		fd = openat(dir_fd, filename, O_RDONLY);
> -		if (fd == -1)
> -			return -1;
> -		fp = fdopen(fd, "r");
> -		if (!fp)
> -			return -1;
> -	}
> -
> -	while (fgets(line, sizeof(line), fp)) {
> -		char *p = skip_spaces(line);
> -
> -		if (*p == '#')
> -			continue;
> -
> -		while (strlen(p)) {
> -			int match, len;
> -			struct evsel *pos;
> -			char evname[128];
> -
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
> -	int scripts_dir_fd, lang_dir_fd;
> -	DIR *scripts_dir, *lang_dir;
> -	struct perf_session *session;
> -	struct perf_data data = {
> -		.path = input_name,
> -		.mode = PERF_DATA_MODE_READ,
> -	};
> -	char *temp;
> -	int i = 0;
> -	const char *exec_path = get_argv_exec_path();
> -
> -	session = perf_session__new(&data, NULL);
> -	if (IS_ERR(session))
> -		return PTR_ERR(session);
> -
> -	{
> -		char scripts_path[PATH_MAX];
> -
> -		snprintf(scripts_path, sizeof(scripts_path), "%s/scripts", exec_path);
> -		scripts_dir_fd = open(scripts_path, O_DIRECTORY);
> -		pr_err("Failed to open directory '%s'", scripts_path);
> -		if (scripts_dir_fd == -1) {
> -			perf_session__delete(session);
> -			return -1;
> -		}
> -	}
> -	scripts_dir = fdopendir(scripts_dir_fd);
> -	if (!scripts_dir) {
> -		close(scripts_dir_fd);
> -		perf_session__delete(session);
> -		return -1;
> -	}
> -
> -	while ((lang_dirent = readdir(scripts_dir)) != NULL) {
> -		if (lang_dirent->d_type != DT_DIR &&
> -		    (lang_dirent->d_type == DT_UNKNOWN &&
> -		     !is_directory_at(scripts_dir_fd, lang_dirent->d_name)))
> -			continue;
> -		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, ".."))
> -			continue;
> -
> -#ifndef HAVE_LIBPERL_SUPPORT
> -		if (strstr(lang_dirent->d_name, "perl"))
> -			continue;
> -#endif
> -#ifndef HAVE_LIBPYTHON_SUPPORT
> -		if (strstr(lang_dirent->d_name, "python"))
> -			continue;
> -#endif
> -
> -		lang_dir_fd = openat(scripts_dir_fd, lang_dirent->d_name, O_DIRECTORY);
> -		if (lang_dir_fd == -1)
> -			continue;
> -		lang_dir = fdopendir(lang_dir_fd);
> -		if (!lang_dir) {
> -			close(lang_dir_fd);
> -			continue;
> -		}
> -		while ((script_dirent = readdir(lang_dir)) != NULL) {
> -			if (script_dirent->d_type == DT_DIR)
> -				continue;
> -			if (script_dirent->d_type == DT_UNKNOWN &&
> -			    is_directory_at(lang_dir_fd, script_dirent->d_name))
> -				continue;
> -			/* Skip those real time scripts: xxxtop.p[yl] */
> -			if (strstr(script_dirent->d_name, "top."))
> -				continue;
> -			if (i >= num)
> -				break;
> -			scnprintf(scripts_path_array[i], pathlen, "%s/scripts/%s/%s",
> -				exec_path,
> -				lang_dirent->d_name,
> -				script_dirent->d_name);
> -			temp = strchr(script_dirent->d_name, '.');
> -			snprintf(scripts_array[i],
> -				(temp - script_dirent->d_name) + 1,
> -				"%s", script_dirent->d_name);
> -
> -			if (check_ev_match(lang_dir_fd, scripts_array[i], session))
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
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 94902652e371..eb15f3b6c4f5 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1307,12 +1307,6 @@ PyMODINIT_FUNC PyInit_perf(void)
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
> 2.47.0.277.g8800431eea-goog
> 
