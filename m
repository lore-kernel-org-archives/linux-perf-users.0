Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626B4248AE
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386912; cv=none; b=YZ7mRh56UQP94TG0J2TpxkkgHo2VKDWtqVO0qYjBG8lu4sEif8ENEV/EZt0ttyzIY+9XlSkcSSa2vUfNjEzJC3dGX4yIcM0A1iIgDs8Cj7hTrR7SELJH1Lx1wZeyeO0BE+xdJS2giUd0Ic/k8juoREAE5J+4vhcYmJOdwPf39Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386912; c=relaxed/simple;
	bh=k96vGeBTKMRcKi73n+/lE3KAWk1JxBeZNJCtiN2Qs5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MATSWa6O4rq7ife7ZcpRyiUJSfFEg+EvfSsh+Yac0XoPVMISaRJ12TzvcrGL3lQMxqB/U9cycaMLwnW71gxoaurA8U8t/+kttacs21Mdy1U2sEk4KozeSJ8JAGv/FAPTByOos4jPCljl4xq11Oxj2N3I661cxg8UOJIqeNv6MDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8KKlFgB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8KKlFgB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBD21F00A3E;
	Mon, 10 Aug 2026 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786386910;
	bh=FJrqrQA6CSXvisyllk1hYQiKuU8XNJRMeh0ImbZ8xj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8KKlFgBcyYBTOZLX0ESEMm1qd1vT47BmfE6VVoDMWZGI38mavNMskPVCQwka0dRs
	 dNks6tjP4Ls9NbbYSuDjny7qvcPaB8Xc4A4YHU4rKjQiFRGk9vsIFQKps8b2I6/rPY
	 8Yu3LMnIJgid/7mFJly7sobpYn1/eB6QlnE24I5O7FqGcWIUqP6i0tDKNripCUt39W
	 7YEpdwGbCBvLAPFgGiW061N/odpnUlC+1Csolwml3DW8A7N7+5LlaIg3VTI4kA2JC1
	 j8ZMR5oWG4dRHHZcLRmt8VoL9e0bWOVfx+b1DyrL2NkMIW1zO6CHXd+ntK/OAG77f/
	 3lC7do4rFgepA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] perf build: install-build-deps: add RHEL family
 devel package mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260810181526.24603-8-acme@kernel.org>
References: <20260810181526.24603-1-acme@kernel.org>
 <20260810181526.24603-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 18:35:09 +0000
Message-Id: <20260810183510.3BBD21F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The script outputs a `missing_file: unbound variable` error to s=
tderr and alters the exit code to 1 upon successful completion due to `set =
-u` and local variable scope lifecycle.
--

--- Patch [7]: [PATCH 7/7] perf build: install-build-deps: add RHEL family =
devel package mapping ---
commit 5192f0f9f2879409655c946317c1f14bc8dff929
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf build: install-build-deps: add RHEL family devel package mapping

With the Fedora mapping in place, this patch extends it to the RHEL
family (RHEL, CentOS Stream, Rocky Linux, AlmaLinux, Oracle Linux),
which shares most Fedora package names and runs dnf (RHEL 8 and
later).

> diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/script=
s/install-build-deps.sh
> index 4a6f4bda49094..ef2226bd79b5f 100755
> --- a/tools/perf/scripts/install-build-deps.sh
> +++ b/tools/perf/scripts/install-build-deps.sh

[ ... ]

> @@ -377,23 +518,46 @@ main() {

[ ... ]

> +	missing_file=3D$(mktemp) || {
> +		echo "error: cannot create a temporary file (mktemp failed)" >&2
> +		exit 1
> +	}
> +	# package_set() runs in a subshell, doing dnf repoquery loops that
> +	# may be interrupted: remove the temp file on any exit and turn
> +	# SIGINT/SIGTERM into an exit, so the script terminates instead of
> +	# resuming after the interrupted command.
> +	trap 'rm -f "$missing_file"' EXIT

[Severity: Medium]
Since missing_file is declared as a local variable in main(), will this
trap trigger an unbound variable error when the script completes?

Because single quotes are used for the trap command, the missing_file
variable is evaluated when the trap fires at the very end of the script.
When the default install action succeeds, main() returns normally and its
local variables go out of scope.

Will this unbound variable evaluation cause the script to exit with code 1
on a successful run, failing the make install-build-deps target?

[ ... ]

> @@ -410,6 +574,7 @@ main() {
>  		echo "error: the install command failed, see the output above" >&2
>  		exit 1
>  	}
> +	note_missing "$missing_pkgs"
>  }
> =20
>  main "$@"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810181526.2460=
3-1-acme@kernel.org?part=3D7
