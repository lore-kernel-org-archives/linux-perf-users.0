Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91617610B;
	Tue, 19 Nov 2024 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731975929; cv=none; b=NjIXThMDp6J32b1pdUucKOBwk2tI37/U9glsII/UF12MqyY9PKGt0cIST17JKUIGgZ4V+h2TQHFyEh1nkaT3WlWcyTGaWQ2+8Sj8iGmSd574ZJLEQEu6Z5hoGqh2rK6asyWTlvE7UQARtK31vB/dDv7BdRC4vzJs9zhYiRSomtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731975929; c=relaxed/simple;
	bh=kYKCwLpF/MeuPjtOT93ky6iziNGL6ZtpnKbTIBVe+CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6QdOkFIHds9mkCr3BI7q/WmjAy/xvuqUx1Y4UHnfrOKa6SlsqF7zEhQk1EzgSVETQjg+BSYGiW42TNQntkR8W/KYpdq4fuavNHNzAfWMUazi7Ud06pO4zFu6KQF6MScjq3BHmzhTFVgCX5jm+AtnuN1bBKwFAFECqMC3VpImlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLlOHrkU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLlOHrkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A53C4CECF;
	Tue, 19 Nov 2024 00:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731975929;
	bh=kYKCwLpF/MeuPjtOT93ky6iziNGL6ZtpnKbTIBVe+CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLlOHrkU2USqnJyCqyaFybPsNt/q83F8BRPvV7LBPYcLFy95krBdgtSf97teQGXUT
	 xLHrg3L2xaM9aP+XZcyZf2kNstyochBAcrgkxnp1w8Er0NLastGA6SGpQS4y1cNeP8
	 UzfngdCGaUmUXagcxkM3qKq5wbgrE9tTCf8XDoxhRP2ghSQiM3cBaGQtIv0PARcimB
	 PkutWoLUnCmGujAPaK7w5E+8Zma1gwAASXGIGwx5XxRw12g77Sib7gw613Q5cQvIA0
	 3zQLeNIGO+NOhkhsryQk4SR8p3xzBYXSdVF+3vSANh7eaku3hOwxOAs3KEGSdkEdjJ
	 FZofbtXooG5gg==
Date: Mon, 18 Nov 2024 16:25:26 -0800
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
Subject: Re: [PATCH v6 06/22] perf script: Use openat for directory iteration
Message-ID: <Zzva9rJ6lHUMD0tm@google.com>
References: <20241109061809.811922-1-irogers@google.com>
 <20241109061809.811922-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241109061809.811922-7-irogers@google.com>

On Fri, Nov 08, 2024 at 10:17:53PM -0800, Ian Rogers wrote:
> Rewrite the directory iteration to use openat so that large character
> arrays aren't needed. The arrays are warned about potential buffer
> overflows by GCC when the code exists in a single C file.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for doing this!
Namhyung

> ---
>  tools/perf/builtin-script.c | 87 +++++++++++++++++++++++++------------
>  tools/perf/util/path.c      | 10 +++++
>  tools/perf/util/path.h      |  1 +
>  3 files changed, 71 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 5d5a1a06d8c6..e20d55b8a741 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3530,27 +3530,35 @@ static void free_dlarg(void)
>   * which is covered well now. And new parsing code should be added to
>   * cover the future complex formats like event groups etc.
>   */
> -static int check_ev_match(char *dir_name, char *scriptname,
> -			struct perf_session *session)
> +static int check_ev_match(int dir_fd, const char *scriptname, struct perf_session *session)
>  {
> -	char filename[MAXPATHLEN], evname[128];
> -	char line[BUFSIZ], *p;
> -	struct evsel *pos;
> -	int match, len;
> +	char line[BUFSIZ];
>  	FILE *fp;
>  
> -	scnprintf(filename, MAXPATHLEN, "%s/bin/%s-record", dir_name, scriptname);
> +	{
> +		char filename[FILENAME_MAX + 5];
> +		int fd;
>  
> -	fp = fopen(filename, "r");
> -	if (!fp)
> -		return -1;
> +		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
> +		fd = openat(dir_fd, filename, O_RDONLY);
> +		if (fd == -1)
> +			return -1;
> +		fp = fdopen(fd, "r");
> +		if (!fp)
> +			return -1;
> +	}
>  
>  	while (fgets(line, sizeof(line), fp)) {
> -		p = skip_spaces(line);
> +		char *p = skip_spaces(line);
> +
>  		if (*p == '#')
>  			continue;
>  
>  		while (strlen(p)) {
> +			int match, len;
> +			struct evsel *pos;
> +			char evname[128];
> +
>  			p = strstr(p, "-e");
>  			if (!p)
>  				break;
> @@ -3593,7 +3601,7 @@ int find_scripts(char **scripts_array, char **scripts_path_array, int num,
>  		 int pathlen)
>  {
>  	struct dirent *script_dirent, *lang_dirent;
> -	char scripts_path[MAXPATHLEN], lang_path[MAXPATHLEN];
> +	int scripts_dir_fd, lang_dir_fd;
>  	DIR *scripts_dir, *lang_dir;
>  	struct perf_session *session;
>  	struct perf_data data = {
> @@ -3602,51 +3610,76 @@ int find_scripts(char **scripts_array, char **scripts_path_array, int num,
>  	};
>  	char *temp;
>  	int i = 0;
> +	const char *exec_path = get_argv_exec_path();
>  
>  	session = perf_session__new(&data, NULL);
>  	if (IS_ERR(session))
>  		return PTR_ERR(session);
>  
> -	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
> +	{
> +		char scripts_path[PATH_MAX];
>  
> -	scripts_dir = opendir(scripts_path);
> +		snprintf(scripts_path, sizeof(scripts_path), "%s/scripts", exec_path);
> +		scripts_dir_fd = open(scripts_path, O_DIRECTORY);
> +		pr_err("Failed to open directory '%s'", scripts_path);
> +		if (scripts_dir_fd == -1) {
> +			perf_session__delete(session);
> +			return -1;
> +		}
> +	}
> +	scripts_dir = fdopendir(scripts_dir_fd);
>  	if (!scripts_dir) {
> +		close(scripts_dir_fd);
>  		perf_session__delete(session);
>  		return -1;
>  	}
>  
> -	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
> -		scnprintf(lang_path, MAXPATHLEN, "%s/%s", scripts_path,
> -			  lang_dirent->d_name);
> +	while ((lang_dirent = readdir(scripts_dir)) != NULL) {
> +		if (lang_dirent->d_type != DT_DIR &&
> +		    (lang_dirent->d_type == DT_UNKNOWN &&
> +		     !is_directory_at(scripts_dir_fd, lang_dirent->d_name)))
> +			continue;
> +		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, ".."))
> +			continue;
> +
>  #ifndef HAVE_LIBPERL_SUPPORT
> -		if (strstr(lang_path, "perl"))
> +		if (strstr(lang_dirent->d_name, "perl"))
>  			continue;
>  #endif
>  #ifndef HAVE_LIBPYTHON_SUPPORT
> -		if (strstr(lang_path, "python"))
> +		if (strstr(lang_dirent->d_name, "python"))
>  			continue;
>  #endif
>  
> -		lang_dir = opendir(lang_path);
> -		if (!lang_dir)
> +		lang_dir_fd = openat(scripts_dir_fd, lang_dirent->d_name, O_DIRECTORY);
> +		if (lang_dir_fd == -1)
>  			continue;
> -
> -		for_each_script(lang_path, lang_dir, script_dirent) {
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
>  			/* Skip those real time scripts: xxxtop.p[yl] */
>  			if (strstr(script_dirent->d_name, "top."))
>  				continue;
>  			if (i >= num)
>  				break;
> -			snprintf(scripts_path_array[i], pathlen, "%s/%s",
> -				lang_path,
> +			scnprintf(scripts_path_array[i], pathlen, "%s/scripts/%s/%s",
> +				exec_path,
> +				lang_dirent->d_name,
>  				script_dirent->d_name);
>  			temp = strchr(script_dirent->d_name, '.');
>  			snprintf(scripts_array[i],
>  				(temp - script_dirent->d_name) + 1,
>  				"%s", script_dirent->d_name);
>  
> -			if (check_ev_match(lang_path,
> -					scripts_array[i], session))
> +			if (check_ev_match(lang_dir_fd, scripts_array[i], session))
>  				continue;
>  
>  			i++;
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
> -- 
> 2.47.0.277.g8800431eea-goog
> 
