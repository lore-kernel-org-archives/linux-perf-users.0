Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E061E1024
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267623; cv=none; b=T6CvE43zTX1AuoDTgziSl2NfmsiJ68PmaN3ZMAPf8RGDBtI4hnto3O6vC88g9TIYHtLioMhyn+fjfkVZZjTgR8Q4DlQ6geTYuECyZB3IxStFo1Mj/W6GFsbhTuUYota6ETITAh552lcnrtbI9eFZzQWwBr0dVmHEiCcqMmTteCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267623; c=relaxed/simple;
	bh=crVPDK7DJo1Fyip6YZS5R3+WU5S8DS9/6lU6os3QBXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m38Py7kIwyKbpyEQ/+InZNqeuidT69bE3x8i20ItQk6GRYjrWGOXW0QgMdFfVC6iUTtLBWvTqLH6xnc3YvcrP69A8vCJnSRYzCcSRrC6ha8ykTPa685VPhYsdhuZ8ui0STUsv0ym/bUr9jdNoZaSTS9boopoukqY67FfaT7P3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNrCmrt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNrCmrt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719C31F000FF;
	Sun, 13 Sep 2026 02:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267621;
	bh=uzgdnAU/wecUn99JuLluaGQsJLvxJl9NBfSxPAgZJTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jNrCmrt3J1aj1BfVlIhuBfrijGzPxpSChYGlndzXRJTTgtSz52DZgBI5PbjhZ5yX0
	 tIqqlu2o2e8cZw25dEMd+RaYCduEZMQBnxd3aSyDC4sxoHxJ4Q/WULzxU1KlzDocKe
	 kdkS05o8XNJ/rG3/utYKM+rnI9Tycl5O8YDehXPytWtOQRYBEz6yHhZbLVzW5/KpNM
	 d6yP6vutxRUr8nKu6Jib5DmASv6Q4d7Mm3ASQlevkHrPp1KKzTF+hURHgQlhkrKFYO
	 NVtBQz4Aj5T7DlyA/ibTRi/nf2umi/Sm4iKmeHnEwAQJ+hDiBcHryu+mMc37n5LMVu
	 XCpYcyzBkNs7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/8] perf debuginfo: Fetch debuginfo keyed by build
 ID using debuginfod
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913023459.112654-3-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
 <20260913023459.112654-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:47:01 +0000
Message-Id: <20260913024701.719C31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Concurrent calls to `setenv()` cause undefined behavior and Use-Af=
ter-Free crashes.
- [High] Concurrent modifications to process-global terminal settings and s=
ignal handlers cause permanent corruption.
- [Medium] Data races on static variables (`debuginfod_fetch_cancelled`, `d=
ebuginfod_signal`, `debuginfod_progress_started`) corrupt concurrent fetche=
s.
- [Medium] Intercepted signals (e.g., SIGINT) are swallowed on the success =
path, preventing graceful termination.
- [Low] Missing explicit inclusion of `<limits.h>` for `PATH_MAX`, causing =
musl libc compilation failures.
--

commit 93a135dd9f8083fd8291b38e49e5952c517a78da
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod

This commit adds support for fetching debuginfo keyed by build ID from
debuginfod servers. It integrates this into the DSO debuginfo resolution
path as a fallback when local debuginfo is missing.

> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
[ ... ]
> @@ -139,6 +148,369 @@ struct debuginfo *debuginfo__new(const char *path)
[ ... ]
> +static void debuginfod__setup_urls_env(void)
> +{
> +	char *urls =3D NULL;
> +	DIR *dir;
> +	struct dirent *dent;
> +
> +	if (getenv("DEBUGINFOD_URLS") !=3D NULL)
> +		return;
> +
> +	dir =3D opendir("/etc/debuginfod");
> +	if (dir =3D=3D NULL)
> +		return;
> +
> +	while ((dent =3D readdir(dir)) !=3D NULL) {
> +		char *content =3D NULL;
> +		char *new_urls;
> +		char path[PATH_MAX];

[Severity: Low]
Does the use of PATH_MAX without an explicit inclusion of <limits.h> cause
build failures on systems using musl libc?

> +		size_t len =3D strlen(dent->d_name), i, size;
> +		int n;
[ ... ]
> +	if (urls !=3D NULL) {
> +		setenv("DEBUGINFOD_URLS", urls, 1);

[Severity: High]
Since dso__debuginfo() explicitly drops the dso__lock before falling back to
fetch debuginfo, we can have a call chain like this executed concurrently:

Thread 1 & 2:
dso__debuginfo() -> drops lock
  debuginfo__new_build_id()
    debuginfo__find_build_id()
      debuginfod__setup_urls_env()
        setenv()

Can concurrent threads resolving DSOs call setenv() simultaneously here? Be=
cause
setenv() is thread-unsafe, this concurrent access could corrupt the process=
-global
environment array and cause a crash.

> +		pr_debug("Set DEBUGINFOD_URLS from /etc/debuginfod: %s\n", urls);
> +	}
> +	free(urls);
> +}
[ ... ]
> +int debuginfo__find_build_id(const struct build_id *bid, char **path)
> +{
> +	char sbuild_id[SBUILD_ID_SIZE];
> +	struct termios orig_termios;
> +	struct sigaction sa, orig_sigint, orig_sigterm;
> +	bool term_set =3D false, sigint_set =3D false, sigterm_set =3D false;
> +	debuginfod_client *c;
> +	int fd;
[ ... ]
> +	debuginfod_fetch_cancelled =3D false;
> +	debuginfod_signal =3D 0;

[Severity: Medium]
These static global variables are shared across all threads but modified he=
re
without synchronization. If a second thread starts a fetch, could it
unconditionally reset debuginfod_fetch_cancelled to false and cause a concu=
rrent
thread attempting to cancel its blocked fetch to hang indefinitely?

> +
> +	/*
> +	 * Make stdin deliver keypresses without waiting for a newline,
> +	 * the progress callback above polls it for the 's'/'d' keys,
[ ... ]
> +	if (isatty(STDIN_FILENO) && isatty(STDERR_FILENO) && !use_browser) {
> +		set_term_quiet_input(&orig_termios);
> +		term_set =3D true;
> +
> +		memset(&sa, 0, sizeof(sa));
> +		sa.sa_handler =3D debuginfod_signal_handler;
> +		sigemptyset(&sa.sa_mask);
> +		if (sigaction(SIGINT, &sa, &orig_sigint) =3D=3D 0)
> +			sigint_set =3D true;
> +		if (sigaction(SIGTERM, &sa, &orig_sigterm) =3D=3D 0)
> +			sigterm_set =3D true;
> +	}

[Severity: High]
Following the same concurrent execution path from dso__debuginfo(), can mul=
tiple
threads concurrently modify the process-wide terminal attributes and signal
handlers here?=20

If Thread B captures Thread A's temporary raw state into orig_termios, coul=
d it
eventually restore that state permanently and leave the process terminal br=
oken
after the fetches complete?

> +
> +	fd =3D debuginfod_find_debuginfo(c, bid->data, bid->size, path);
> +
> +	if (term_set)
> +		tcsetattr(STDIN_FILENO, TCSANOW, &orig_termios);
> +	if (sigint_set)
> +		sigaction(SIGINT, &orig_sigint, NULL);
> +	if (sigterm_set)
> +		sigaction(SIGTERM, &orig_sigterm, NULL);
> +
> +	debuginfod_end(c);
> +	if (debuginfod_progress_started) {
> +		fputc('\n', stderr);
> +		debuginfod_progress_started =3D false;
> +	}
> +	if (fd < 0) {
> +		build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
> +		if (debuginfod_fetch_cancelled || debuginfod_signal) {
> +			pr_debug("debuginfod search for build ID %s cancelled by the user\n",
> +				 sbuild_id);
> +			/*
> +			 * The terminal is restored, die as the user asked;
> +			 * the original dispositions are back in place.
> +			 */
> +			if (debuginfod_signal)
> +				raise(debuginfod_signal);
> +			return -1;
> +		}
> +		pr_debug("No debuginfo found for build ID %s in debuginfod\n",
> +			 sbuild_id);
> +		debuginfod__miss_add(bid);
> +		return -1;
> +	}
> +
> +	close(fd);
> +	return 0;
> +}

[Severity: Medium]
On the success path when fd is valid, the code returns 0 and skips evaluati=
ng
and re-raising debuginfod_signal. Does this mean user interrupt requests li=
ke
SIGINT are silently swallowed if the user presses Ctrl-C right as the fetch=
 is
concluding successfully?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913023459.1126=
54-1-acme@kernel.org?part=3D2
