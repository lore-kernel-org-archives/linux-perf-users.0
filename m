Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA92264C0
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608652; cv=none; b=kD8eTNp2xIKP/3VlqudRN47mRGbQBoWvJvfg7KVHqkqm0IO4Ur8qWdI4bUf3xmArX/yXJjpnurkA/Ru5ScOsvUdM0vwjQO9tQKj+qF3n31VASKdZlRXkBLQGw0iwVH3rX8Lre2VKaBojokV2f3/oJeIs649MHkjKTpurljdQQSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608652; c=relaxed/simple;
	bh=LDu0d8t3OjrlKK6wpejB0d17/kT4xZb0BKZtggNp23c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ohjk9o9BtjIhuUPgwZQKkPxJgXrq+SmY4TjIBOEZHTd41eWhf7nggwUpe9Ng98aiu/0BKVw0V73vwiu6uutcRzGGNF/QxtEvJ4rOYRvRhpOUuNpRdgKCTxuM1wOq9PtHxL8u0s64CprMPb9n3nXTAClZQ4UxbbDRmo+pw/wHa4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzM20wzO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzM20wzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6798C116C6;
	Wed,  8 Apr 2026 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775608651;
	bh=LDu0d8t3OjrlKK6wpejB0d17/kT4xZb0BKZtggNp23c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hzM20wzO+nn2UUwM2wm+JiNjQ5Q9DgpP0MHlpexAYLQDg+elcwI6BWMRlay+qNYJ/
	 Lumiuar8BizBkkS0rh+tJbDSisnRH2tZdl3Qq29+FqhRmEFa8xXqsAhiDnvZW/X4y4
	 2NamA5UVzd1PM1FHdrscaSbzGd48n7NLr4CAvY9nzOXWPZSxi6AqKz05hKkdnZbZkJ
	 QtEM2RHQfqG32iY7kDzBXUQQLWv16CQ/65yhSvcOmriz62CVvEDx+hSdqKbSO2I8aH
	 jhACReR3HqQwyTc6lpzOWAS6wxGW4Vu5OEIyLvspgZqX61CadGXqFMBnx8kXT/X2cP
	 K8iq97fpCkg6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf data: Clean up use_stdio and structures
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408001416.101493-1-irogers@google.com>
References: <20260408001416.101493-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 00:37:31 +0000
Message-Id: <20260408003731.C6798C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Uninitialized `use_stdio` flag in `perf_data__open_dir` leads to u=
ndefined behavior and potential segmentation faults.
- [High] `perf_data__seek` triggers an assertion failure when attempting to=
 switch output on a pipe.
- [High] Unchecked `fptr` in `perf_data_file__close` leads to `fclose(NULL)=
` (segmentation fault) on error paths.

--

commit ec97569bb8fdfc232fc8bacde6d26424b25c9ef5
Author: Ian Rogers <irogers@google.com>

    perf data: Clean up use_stdio and structures
   =20
    use_stdio was associated with struct perf_data and not perf_data_file
    meaning there was implicit use of fd rather than fptr that may not be
    safe. For example, in perf_data_file__write. Reorganize perf_data_file
    to better abstract use_stdio, add kernel-doc and more consistently use
    perf_data__ accessors so that use_stdio is better respected.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 90df41da1a32b..41993dfd6c2bc 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -20,18 +20,30 @@
>  #include "rlimit.h"
>  #include <internal/lib.h>
> =20
> -static void close_dir(struct perf_data_file *files, int nr)
> +static void perf_data_file__close(struct perf_data_file *file)
>  {
> -	while (--nr >=3D 0) {
> -		close(files[nr].fd);
> -		zfree(&files[nr].path);
> +	if (file->use_stdio) {
> +		fclose(file->fptr);

Does this need a check for file->fptr !=3D NULL before calling fclose()?

If a tool initializes its output with .file.use_stdio =3D true and
.file.fptr =3D NULL (such as inject.output in cmd_inject() when using
--in-place), and an error occurs before the file is fully opened, the error
path jumps to out_close_output and calls perf_data__close(). This blindly
executes fclose(NULL), which will cause a segmentation fault.

Also, since use_stdio is read here, can it contain uninitialized memory?

In perf_data__open_dir(), the files array is dynamically grown using
realloc(files, (nr + 1) * sizeof(*files)). When a new struct perf_data_file
is appended, its path, fd, and size fields are set, but the newly added
use_stdio boolean is never explicitly initialized. Because realloc() does
not zero memory, use_stdio will contain uninitialized heap garbage.

When perf_data__close_dir() iterates over the files to close them via
this function, it reads this garbage flag. If it evaluates to true, the code
incorrectly assumes the file uses stdio and calls fclose(file->fptr). Since
fptr is part of a union with fd (or also garbage), this results in an
arbitrary pointer dereference and a segmentation fault.

[ ... ]

> +off_t perf_data__seek(struct perf_data *data, off_t offset, int whence)
> +{
> +	assert(!data->is_pipe);
> +	return perf_data_file__seek(&data->file, offset, whence);
> +}
> +
>  int perf_data__switch(struct perf_data *data,
>  		      const char *postfix,
>  		      size_t pos, bool at_exit,
> @@ -420,19 +448,18 @@ int perf_data__switch(struct perf_data *data,
>  		pr_warning("Failed to rename %s to %s\n", data->path, *new_filepath);
> =20
>  	if (!at_exit) {
> -		close(data->file.fd);
> +		perf_data_file__close(&data->file);
>  		ret =3D perf_data__open(data);
>  		if (ret < 0)
>  			goto out;
> =20
> -		if (lseek(data->file.fd, pos, SEEK_SET) =3D=3D (off_t)-1) {
> +		if (perf_data__seek(data, pos, SEEK_SET) =3D=3D (off_t)-1) {

Will this assertion crash the tool if a user specifies a pipe for output and
triggers an output switch (e.g., perf record -o - --switch-output)?

When the user triggers an output switch, perf_data__switch() re-opens the
pipe (correctly setting data->is_pipe =3D true) and then unconditionally ca=
lls
perf_data__seek() to restore the offset.

Before this patch, calling lseek() on a pipe simply returned -1 with
errno =3D=3D ESPIPE and the tool handled the error gracefully. The new asse=
rtion
turns this previously handled error into a hard crash that can be reached
directly via user arguments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408001416.1014=
93-1-irogers@google.com?part=3D1
