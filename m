Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E464D2ED3
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199290; cv=none; b=tuUqX84s0QgcGZShfHInsiNNUSX8OeJlp1QR17nd+K+30B3HGXENwlB+I0Ys9b1dOp+5H/lF9N2PCe5BcbttDX6Y//Gf+HjfpX4I2QvwLCFrPS3Qhf+CP8gHfNP0OC1eqtRzaDFVpHA2hHTA3QAmue0kgm3RZ8kdZZSnKTk87Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199290; c=relaxed/simple;
	bh=dWu5VtWxiZwmFE1Z4wMjRJNwkS1/S1u/87A9m5PmGcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lBdfIcFCO1sSi1esReBot5WFrk773Kxox0vNnK1pz1wNJoT8vRwtVjU0ZkeePJ7bvzk0lD30E8/db6flx5ULoKYRBK8WRiFwE4545hVkTjyv/Ienyw7z6lJPN8XaHI/b6n1F0SasxNNEzSOE8Iu8rQAk5Ze6o+JKW/iA308cIQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFVtqbWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFVtqbWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E731F00893;
	Thu, 11 Jun 2026 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199288;
	bh=4f8vKNPEOk6VxzADnqm9o9/0ZUQ8wNr12jGf+XMhemA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oFVtqbWPgg+98AsDYZ4dsONfEY+KttktixmoCzcZua4NN1JqS01OaC2egenMRmc+p
	 5ZbiC6U6Yt6DGB31EI0ck+S8t12/7C0gY55zk1RuELpnN+Sj5A5AwoTfvNGP7AwT02
	 rqI+CkdcludFAA2c1bOzg3YIbAYpY9AA10gNVHGJnpJZmTO8nlOqxDGrwp4sRwmj1+
	 G5o1P9ySE8pKmJ0t7ZPSbl0JuD5FIBUiVtkYFx8yMYWGvh0AiZF6V7hz2Q1U9epie8
	 OBJtwh6UYAaL7fu4dsfwbh6eZzoPyugqSjSRoWEfXoUywiDhbaN6e3JffwDzHvyn9K
	 tmrRcUk6RzX1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/19] perf data: Add open flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611171756.4008769-5-irogers@google.com>
References: <20260611171756.4008769-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:34:47 +0000
Message-Id: <20260611173448.C2E731F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] TOCTOU race condition in perf.data creation allows arbitrary f=
ile truncation via symlink attack.
--

commit 97b48707f7309cb3d1dba375265cb2db7146189c
Author: Ian Rogers <irogers@google.com>

perf data: Add open flag
   =20
Avoid double opens and ensure only open files are closed. This addresses so=
me
issues with python integration where the data file wants to be opened before
being given to a session.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 94dc534a73866..33fd1b82019eb 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c

[ ... ]

> @@ -457,6 +473,7 @@ int perf_data__switch(struct perf_data *data,
> =20
>  	if (!at_exit) {
>  		perf_data_file__close(&data->file);
> +		data->open =3D false;
>  		ret =3D perf_data__open(data);

[Severity: Critical]
This is a pre-existing issue, but does this sequence leave us open to a
symlink attack?

During file rotation, the existing file at data->path is renamed, and then
perf_data__open() is called:

tools/perf/util/data.c:perf_data__switch() {
    ...
    if (rename(data->path, *new_filepath))
        ...
    if (!at_exit) {
        perf_data_file__close(&data->file);
        data->open =3D false;
        ret =3D perf_data__open(data);
    ...
}

Inside perf_data__open(), the call chain eventually reaches open_file_write=
():

tools/perf/util/data.c:open_file_write() {
    int fd =3D open(data->file.path, O_CREAT|O_RDWR|O_TRUNC|O_CLOEXEC,
                  S_IRUSR|S_IWUSR);
    ...
}

Since open() is called without O_EXCL or O_NOFOLLOW, could an attacker
predict this race window and insert a malicious symlink after the rename()
but before open_file_write() creates the new file?

If this runs in a world-writable directory like /tmp, it seems it would
follow the symlink and truncate the target file.

>  		if (ret < 0)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611171756.4008=
769-1-irogers@google.com?part=3D4
