Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181FF369203
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339165; cv=none; b=LHYvet/rPn1JVXQOOk9sNTKSe7AkPX5IlOcDT5PDd6M/pxqUb09F8K4lQwXvTqgDnlvokdswft9Y1sV0vEtvXGZeAbyPot1fa5enzWcFFKUnr9Gc4AzzQSFjriooRNhwJ2cgaYlxLAV9f1Bh8wyuF/B7DXuIJYSYWgosBia5Jlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339165; c=relaxed/simple;
	bh=B/qczFqM6x7Z691zpyhLc0XupUMq2QOgMlZ9hKFY8bk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XtJsqcSUm3klrdyA4/F2pYR+2Wbud2v7y+jJPPqgHjZwiPGENVDwHVoCKrNK4QQn4JH7t9Rh0AeupTEmBQO8jXjONAqzswkvJolNm7wMZLBrKB1RBbReFNnQC6aA3HldyXBMCsCrCCXwRlnr5ZBcncIl6RpSi6DQ5PmwgRGAxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdesBeny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdesBeny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050541F000FF;
	Sun, 13 Sep 2026 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339158;
	bh=yKo6C1FvGLQj6d+T8WLVvnmYI5iq8WVwNq4G2c7cUiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SdesBenywEaDpXMUKlsgXVmeQ1BeYSTFI5DS9XPBmUFe7WHxMMJc62SwU/Dwm5E/0
	 hPn09zeqR8LOtmAp1VgudYl3y5nfZfCMN8ae/QFFxIXEkBL/HYEy2S8NHnEkV7zrU2
	 K3lB0vPoKcmwBheq7p3+h0dWJDG3WU1Znrn6363h7AsRww8nhyYM4vs+CGpTVj0K0u
	 uoRQSTbaJe2w2bAL6bzW9Wr3qAeuBU7+LLoPEGTxtWcs/bdIkWPs5H78q3JGCCSEb+
	 +DnvbvJlKEzTLG7R9ftrEB2g5uSAx/WTJbMGC9EfIdg8U5Ze5wXwZ69qSsNmyEunc9
	 zE1WWsDjHL1bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913222821.3353-3-acme@kernel.org>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:39:17 +0000
Message-Id: <20260913223918.050541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Thread-unsafe modification of process environment via `setenv` rac=
es with concurrent `getenv` calls.
- [Medium] Over-scoping of `debuginfod__fetch_lock` neutralizes concurrent =
lookup logic and makes condition variables dead code.
--

commit 61a7d2bee4ec3dc777a819193cbb18e4e7f04543
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod

This commit adds debuginfo__find_build_id() to fetch debuginfo files via
debuginfod based on their build ID. It falls back to debuginfod servers if
local debuginfo is missing, supporting cancellation and progress reporting.

> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 84a78b30ceac1..21cdd3ec8e139 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c

[ ... ]
> @@ -139,6 +149,677 @@ struct debuginfo *debuginfo__new(const char *path)
[ ... ]
> +static void debuginfod__urls_env_setup(void)
> +{
> +	char *urls =3D NULL;
[ ... ]
> +	if (urls !=3D NULL) {
> +		setenv("DEBUGINFOD_URLS", urls, 1);

[Severity: High]
Does this thread-unsafe modification of the process environment via setenv()
race with concurrent getenv() calls?

This lazy initialization is triggered during active DSO processing in
debuginfod__fetch(). In multi-threaded commands like 'perf top', one thread
might perform a fetch while another thread simultaneously uses libdw to
process a different DSO (which calls getenv() inside elfutils). This data
race on the environ pointer could lead to memory corruption, use-after-free,
or segmentation faults.

> +		pr_debug("Set DEBUGINFOD_URLS from /etc/debuginfod: %s\n", urls);
> +	}
> +	free(urls);
> +}

[ ... ]
> +static void debuginfod__miss_add(const struct build_id *bid, bool cancel=
led)
> +{
> +	struct debuginfod_miss *miss =3D zalloc(sizeof(*miss));
> +
> +	if (miss =3D=3D NULL)
> +		return;
> +
> +	miss->bid =3D *bid;
> +	miss->cancelled =3D cancelled;
> +
> +	debuginfod__missed_lock_init();
> +	mutex_lock(&debuginfod__missed_lock);

[Severity: Medium]
Is this inner lock redundant?

Since debuginfod__miss_add() is called from debuginfod__fetch() which is in
turn called from debuginfo_lookup__find_build_id(), the execution always
happens while debuginfod__fetch_lock is already held (acquired in
debuginfo__find_build_id()).

> +	list_add(&miss->node, &debuginfod__misses);
> +	mutex_unlock(&debuginfod__missed_lock);
> +}

[ ... ]
> +static int debuginfo_lookup__find_build_id(const struct build_id *bid, c=
har **path)
> +{
[ ... ]
> +	/*
> +	 * Somebody else got here first: wait for the fetch that is in
> +	 * progress instead of starting another one, which, while that one
> +	 * is still running, would download the same file a second time.
> +	 */
> +	if (lookup->fetching) {
> +		lookup->nr_waiters++;
> +		waited =3D true;
> +
> +		while (lookup->fetching)
> +			cond_wait(&lookup->done, &debuginfod__fetch_lock);

[Severity: Medium]
Is this condition wait loop unreachable?

The outer lock (debuginfod__fetch_lock) is acquired in
debuginfo__find_build_id() before initiating any lookup or fetch,
encompassing the entire blocking network operation. This prevents any
concurrent thread from reaching this wait logic while fetching is in
progress, making the intended fine-grained condition variable logic dead
code and forcing fetches for different build IDs to unnecessarily block
each other.

> +	}

[ ... ]
> +int debuginfo__find_build_id(const struct build_id *bid, char **path)
> +{
[ ... ]
> +	/*
> +	 * The checks below have to be made with the lock held, as they look
> +	 * at the state the fetch changes: debuginfod can be turned off while
> +	 * a fetch is in progress, by the 'd' key in its progress line, and a
> +	 * build ID the fetch in progress just settled, as a miss or as a
> +	 * cancellation, is settled for whoever is waiting for the lock as
> +	 * well.  Deciding here and fetching there would repeat a fetch that
> +	 * was already made, and put the same build ID on the misses list
> +	 * twice.
> +	 */
> +	debuginfod__fetch_lock_init();
> +	mutex_lock(&debuginfod__fetch_lock);
> +
> +	if (symbol_conf.debuginfod) {
> +		bool cancelled;
> +
> +		if (debuginfod__cache_disabled()) {
> +			pr_debug("Build-id cache disabled (buildid dir is '%s'), not using de=
buginfod\n",
> +				 buildid_dir);
> +		} else if (debuginfod__missed(bid, &cancelled)) {
[ ... ]
> +		} else {
> +			err =3D debuginfo_lookup__find_build_id(bid, path);
> +		}
> +	}
> +
> +	mutex_unlock(&debuginfod__fetch_lock);
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913222821.3353=
-1-acme@kernel.org?part=3D2
