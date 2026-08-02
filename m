Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887583BD659
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682710; cv=none; b=dqt0TNwL3yRXc8UZ+fSp3mgiNVM3nPuMcbylU5K6pUpdD9R8utFr2b+LyhxybHAIlbHcU80oFA7u8ocajf6rL3FNmJB823BIcwOxyBjlsU9GK2ZWye2+6Qaj9Ws+dd2doFb1fwd2gd3xMRCSfbjuYqK5goZMoLHJIkfHbQXLb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682710; c=relaxed/simple;
	bh=DmETugVpc6eOXbL7itcAMF/ApN594fH+JBiY5Fmrnfo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CAj3D+sULNzw7lmX9oaAlznSH+G536hycOF/FB0S8zcZb5Wbu9Z+0yx9QvBgYaQl53qBkc6YCtXU11nkn0GnpGNcG0qcJViq2WjFxNKcUiH3xKvEy6dOqsdx8pOU3Pn3/qbYlDrwS4uhaMDsuwZzKzuGS2uHZfLuEgdSai31R/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvPHEW9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvPHEW9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439EC1F00A3A;
	Sun,  2 Aug 2026 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785682709;
	bh=BFr5iGmOKi/4EzPxQKvSEhgoJu5I24KiHGmcOX1KvH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvPHEW9CdQKY5kj4KFU9XU3AyqoAV5hAUSMV8HjMmpsddC+uDdveSDiwYRZy4GPKG
	 3TfkdFwlKyuvFQGLYsCzLh7CXxSt4rfC5fnKkkj7BOx7VHFfQsSSxSa0De130rQHdn
	 4NO+omedXjhM0lsfUY8KbVlrn1iDZv7o4AWAm758h3hQfNl+o7o4TLqLp/ygD3KVW5
	 oDMV33RWCDj1FvgbzFeuEW6ukYQn/a9V531CRVVcLljIMrnio6oe0366jlz3oX3dQ0
	 82Q1eMPUZ71AW/x2Y6OVuwzjifK9H5r2ESI5rQ9PBukaTZ11vMhTG8l2q8rIMn8b8C
	 HPRl55s2YsdZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf dso: Guard against errno==0 when
 dso__get_filename() returns NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260802142022.154219-2-acme@kernel.org>
References: <20260802142022.154219-1-acme@kernel.org>
 <20260802142022.154219-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 14:58:28 +0000
Message-Id: <20260802145829.439EC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete fix in `__open_dso()` causes error swallowing in call=
ers by returning negative fd without setting `errno`.

Pre-existing issues:
- [Medium] Data race on adjacent `struct dso` bitfields leads to corruption=
 and a TOCTOU mount namespace leak.
--

--- Patch [1]: [PATCH 1/5] perf dso: Guard against errno=3D=3D0 when dso__g=
et_filename() returns NULL ---
commit db31953321ccfc3f2f28e5db31230d5fef57578f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Guard against errno=3D=3D0 when dso__get_filename() returns NULL

This commit updates __open_dso() to fall back to ENOENT when
dso__get_filename() returns NULL but leaves errno as 0. This ensures fd
is always negative on failure.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 2309196d8df31..e087a89066bdb 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -643,7 +643,7 @@ static int __open_dso(struct dso *dso, struct machine=
 *machine)
>  	if (name)
>  		fd =3D do_open(name);
>  	else
> -		fd =3D -errno;
> +		fd =3D errno ? -errno : -ENOENT;

[Severity: Medium]
Does this code need to explicitly set errno to ENOENT as well?

Callers of __open_dso() appear to check if the returned file descriptor is
negative, and then compute their return value using errno. For example, in
file_read():

tools/perf/util/dso.c:file_read() {
    ...
    fd =3D data_file_open(dso, machine);
    if (fd < 0)
        return -errno;
    ...
}

Since errno is left as 0, callers like file_read() will evaluate -errno
to 0, which incorrectly reports EOF instead of an open failure. Should we
update errno directly?

[Severity: Medium]
This is a pre-existing issue, but can the adjacent bitfields in struct dso
cause a data race that leaks mount namespaces?

Looking at the struct dso definition:

tools/perf/util/dso.h:struct dso {
    ...
    enum dso_binary_type symtab_type:8;
    enum dso_binary_type binary_type:8;
    ...
}

If one thread calls try_to_open_dso() and locklessly modifies binary_type,
while another concurrently modifies symtab_type holding dso__lock(dso),
the concurrent read-modify-write on the shared memory word can corrupt
binary_type.

This corruption appears to break the namespace exit check in open_dso():

tools/perf/util/dso.c:open_dso() {
    ...
    if (dso__binary_type(dso) !=3D DSO_BINARY_TYPE__BUILD_ID_CACHE) {
        mutex_lock(dso__lock(dso));
        nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
        mutex_unlock(dso__lock(dso));
    }
    fd =3D __open_dso(dso, machine);
    if (dso__binary_type(dso) !=3D DSO_BINARY_TYPE__BUILD_ID_CACHE)
        nsinfo__mountns_exit(&nsc);
    ...
}

If the bitfield gets corrupted during __open_dso(), the exit check might
fail, skipping nsinfo__mountns_exit() and permanently stranding the thread
in the wrong mount namespace. Should access to these bitfields be protected
by dso__lock, or should they be separated to avoid sharing memory bytes?

> =20
>  	if (decomp)
>  		unlink(name);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802142022.1542=
19-1-acme@kernel.org?part=3D1
