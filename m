Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702CF36DA18
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182732; cv=none; b=q0MXoaExkUbLQE+WlFPEBCK3540WJDIOON4p1CSVUuUJJmkRCTCu5hHX0nTDLEtcNjpX4AgXCqqApCwoNWvOTjqVfw2l47S1F8F4cMd5h7rJqQe0e/fDtg/3eBFmvp3oJ/D0pQLan2RufpKA3uhbFoFaWJ1Tkb2eEKfFHzX3OR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182732; c=relaxed/simple;
	bh=ryVb4+Ug3QuWNxBtcdYI6l6Ei11yDFWP3RWYFVUedL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R2FNd8SETiJc8rMhFuGoRR7KuIbcxXd1em8WKnmIzJvAAWN0ebo91ZykhFMYkuS8x+WERtSk2P2uQdHQKJtL4MS38Ay7RD9gIHQoie1LB3FTqq9AZLoXvOrCSj9EdfxvIVD1wtXEnASiyz3D5U5JW9WeBE0G6VGJKGp1ixiSoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIBrxVBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIBrxVBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD9B1F000FF;
	Mon,  5 Oct 2026 06:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182731;
	bh=vs8dVWkqgmOd+sy/2LvShiyWvE5p7JRs+SGoGSERoAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nIBrxVBT3+k1AmuXnUxgy6E8IttX2rlSVUJZuQ5BeFhRGQTflo5XEU6ytIrZcB1V4
	 s4WXGwj/p5DcEpM9rncqBkOuJYLx/yum/AcJPcxtaDOvm68I5u4VKUrBBMop3DeiV8
	 tfAl59iGVZNHXKqsuJokEO1NtSHrlKUXq2ci60dryHJYQ12ICq4RpKa2V9cL4O3b5D
	 FnWOifnx3n4pWAHyfw5cmkrwltUnUsMMdmlHS6W2ecTJD277ESkWk/JX6OL1RQttlX
	 3xhx15WvWltavJs8kDlitNr4GM5DITXS96rcNmzPF76Z/azMCzW9jlKDIWdZPFRCTa
	 eEOSevmIcVMZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/7] perf symbol: Do not set binary type from symtab
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005063411.114244-8-namhyung@kernel.org>
References: <20261005063411.114244-1-namhyung@kernel.org>
 <20261005063411.114244-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 06:45:30 +0000
Message-Id: <20261005064531.2BD9B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: `perf annotate` and guest module data read broken by missi=
ng `binary_type`
--

commit 7196d300589913af007226f7522345f0d46a1af3
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Do not set binary type from symtab type

The commit separates DSO binary type from symtab type and removes the
logic that sets the binary type from the symtab type in dso__load.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 389dbd7e5192f..1175cb60f8206 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1956,19 +1956,6 @@ int dso__load(struct dso *dso, struct map *map)
> =20
>  		if (next_slot) {
>  			ss_pos++;
> -
> -			/*
> -			 * The binary type is used to find the file containing
> -			 * the executed instructions, so prefer the types that
> -			 * refer to the actual object over debug-only files such
> -			 * as DSO_BINARY_TYPE__DEBUGLINK.
> -			 */
> -			if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND ||
> -			    symtab_type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE ||
> -			    (symtab_type =3D=3D DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
> -			     dso__binary_type(dso) !=3D DSO_BINARY_TYPE__BUILD_ID_CACHE))
> -				dso__set_binary_type(dso, symtab_type);
> -

[Severity: Medium]
Will this removal cause perf annotate and guest module data reads to fail?

Without this logic, binary_type defaults to DSO_BINARY_TYPE__NOT_FOUND
for generic DSOs, guest kernel modules, or binaries using debuginfo/system
paths.=20

When tools/perf/util/dso.c:try_to_open_dso() is later called to read data,
it only iterates over BUILD_ID_CACHE and SYSTEM_PATH_DSO when the binary
type is NOT_FOUND, completely ignoring guest-specific paths that require
machine->root_dir:

    enum dso_binary_type binary_type_data[] =3D {
        DSO_BINARY_TYPE__BUILD_ID_CACHE,
        DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
        DSO_BINARY_TYPE__NOT_FOUND,
    };

Additionally, tools/perf/util/disasm.c:symbol__disassemble() explicitly
returns an error if binary_type remains unset:

    if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {
        return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
    }

Does this unintentionally break disassembly for binaries not in the
build-id cache, or binary data reads for guest kernel modules?

>  			if (syms_ss && runtime_ss)
>  				break;
>  		} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005063411.1142=
44-1-namhyung@kernel.org?part=3D7
