Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C83E314E
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122228; cv=none; b=Qa2Z9szb3MPtZeBilVj1c9tBnS93lkD1nLoctmBwseGU+I28msEDkJ6AzLEFJqsS8BsHCibdRXVHMrnvID4XNFKEXy+zah5onBixZ8aDf/zBFBK0PgtBpXxpetvRa/aPWnrerSYYGDlNoHiO9a/7yWm3gwmfi1OUVZXqXIAJ0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122228; c=relaxed/simple;
	bh=8vSVzM3uBAcypHMmsF/0H7pIy/VyvXpfpbGjD6PHejQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ptdNn2GLqqH7iZXeNeIrd++55Sm9hKxFO/qqcO0+wtDFHQG2Ic4xFGJjK8lpF6gpzK8Wo/WpIKRu04VIYmy3KNy0fQSxKd2sONDF4hvow19xNoi/189CDbXmxwAkeblfPHNyjIVIFXMQ71s3lcj9BkBAoDrsfcZDoFZTjoUEcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/jdRf2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/jdRf2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BD31F00893;
	Wed, 10 Jun 2026 20:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122222;
	bh=ud745uS/nm3PW7qqngn2ZtzIqNHzN7yJML2D9hz95R8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/jdRf2Z8PBDjVh9276VeCnuXgn8sLof7IH5Lak80UhPn1bAtZ5TW3lx6422aw6tI
	 yE6edEjixifb+q0zNsLV9ZEjdVP4gZ6JtIwIm4llTsW33e0gSnVOZqZnM27qZUwiFN
	 8i7LIjK1oMzZHKgHvtfNGGrn9lgigf5kdoIE1ol7nTgu5Co+LUVK4IMdl+2FbnxfIM
	 PLNHa3/X4I6zpVwInLlqs0r1aUu5vLTerf/z43KeB8rhdvrZV98i+NrpfhmsfIWnoK
	 D5XLJWdEP/36qHTuzwAJ9mfXcHxHYwP9BD8QZY1rajWCngrXJ5OTanKqwFR749Wrd8
	 KlwYFlg/u+R7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/23] perf tools: Use snprintf() in
 dso__read_running_kernel_build_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610195157.2091137-17-acme@kernel.org>
References: <20260610195157.2091137-17-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 20:10:21 +0000
Message-Id: <20260610201022.71BD31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap buffer overflow when replacing the DSO path with a decompress=
ed file path in `dso__get_filename`.
- [High] Unmitigated stack buffer overflows in sibling functions formatting=
 `PATH_MAX` paths.
- [Medium] Infinite CPU-spinning loop when reading ELF notes from a zero-fi=
lled stream.
--


commit bde010bc7aa1159e59ae6af0754c23603bd0c52a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use snprintf() in dso__read_running_kernel_build_id()

This commit replaces sprintf() with snprintf() in=20
dso__read_running_kernel_build_id() to prevent a stack buffer overflow=20
when appending /sys/kernel/notes to a root_dir that is close to PATH_MAX=20
in length.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 6a34717c9f31f..5d01797587381 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1779,7 +1779,7 @@ void dso__read_running_kernel_build_id(struct dso *=
dso, struct machine *machine)
> =20
>  	if (machine__is_default_guest(machine))
>  		return;
> -	sprintf(path, "%s/sys/kernel/notes", machine->root_dir);
> +	snprintf(path, sizeof(path), "%s/sys/kernel/notes", machine->root_dir);

[Severity: High]
This is a pre-existing issue, but while we are fixing sprintf() overflows=20
in PATH_MAX buffers, are there similar unmitigated buffer overflows in=20
sibling functions?

For instance, in tools/perf/util/machine.c:get_kernel_version():

    sprintf(version, "%s/proc/version", root_dir);

And in tools/perf/util/symbol.c:dso__load_guest_kernel_sym():

    sprintf(path, "%s/proc/kallsyms", machine->root_dir);

If the root_dir or symbol_conf.guestmount paths are close to PATH_MAX,=20
appending these suffix strings could write past the stack bounds in those=20
locations as well.

>  	sysfs__read_build_id(path, &bid);

[Severity: Medium]
This is a pre-existing issue, but does sysfs__read_build_id() contain an
infinite loop if the target stream is filled with zeros?

In tools/perf/util/symbol-elf.c:sysfs__read_build_id():

    } else {
        n =3D namesz + descsz;
    }
    if (read(fd, bf, n) !=3D (ssize_t)n)
        break;

If read(fd, &nhdr, sizeof(nhdr)) reads zeroed headers from a stream,=20
namesz and descsz evaluate to 0, making n =3D 0. The subsequent read(fd, bf=
, 0)
would succeed and return 0, bypassing the break condition and potentially
causing a CPU hang.

>  	dso__set_build_id(dso, &bid);
>  }

[Severity: High]
This is a pre-existing issue, but could there be a heap buffer overflow
in dso__get_filename() when dealing with decompressed modules?

In tools/perf/util/dso.c:dso__get_filename():

    if (newpath[0] !=3D '\0') {
        *decomp =3D true;
        strcpy(name, newpath);
    }

Earlier in the function, dso__filename_with_chroot() might allocate the name
buffer using asprintf(), making it exactly the length of the chrooted
filename.

If the module requires decompression, dso__decompress_kmodule_path()
creates a temporary file like /tmp/perf-kmod-XXXXXX.

If the original dynamically allocated name string was shorter than the
newpath string length, the strcpy() call will overwrite the heap buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610195157.2091=
137-1-acme@kernel.org?part=3D16
