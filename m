Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904835;
	b=4j0vYovhHXgL+V4KUvLC4S9XwypLHaNHwVB9nuOVAfSZl/z6sColpxQkFtOy/aGvPK/u
	 89LXEJl74f5AesTbhj616gLdTbH48dvjpDGZhA2SaaAdid+ZXG2N2bcOfSasTfTN0nQf+
	 KhyqSF+cayb2+b0AMboNyAy8pKbikyF/v0kvNhSpy9PGYmVlFegPZfyXklGoX1cMmXEbO
	 EyfGBQARHkF5D7p0/K8RtkAnqXtVXmeYZfDLpuybOrUhy+R/l/B2lhC02SCjgN58k9GUm
	 /SSqZYMq8dlYKlaxMXtdQFApbxHYinisKhi4+WTuHAu3jz78H3W+PoBqjxntbr618DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904835;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=3LWhI8Rc4SOLK5K+8/Bz0GYS7fyxcUpxRfUZFoYqn9k=;
	b=HtEiIw/PccHbr3h436QC9MFnLFp33TZvrzabW8ovjNJyTmBBbdPFQwaLOF3KKAMnoIEd
	 EZsF4lAgEFlUSTpb9ib4/gCEo/cJFUDieji3j9NWRAh/rfNDJQysDv8RGNLrhpCRuQI0R
	 8GVpB7a4v9QNqqBhSBpqO7GyKu/LOojp4J3L8dzXUMeXwDJ3VO+SqgXGwDGuwB9eePIPr
	 sJJT+TdS8i93j++ijGmrFaUlhru8HGeI2iIy6s5/HJRrhdAy/gXXLlhbvVEjznkLGy6bo
	 KyGWS+EGyF3D3IeTZWcX9u3XAUQoL+g8hf6mRDHw0V9nQTjXTs2VytH0YEy3e0vs48g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuPhmSAP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12624606A31B;
	Thu,  5 Nov 2026 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iuPhmSAP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4991F00919;
	Thu,  5 Nov 2026 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904834;
	bh=3LWhI8Rc4SOLK5K+8/Bz0GYS7fyxcUpxRfUZFoYqn9k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iuPhmSAPYRQkqf6ol1urlyYMnBqnIjPJ1lYoMlz5oZvp2nSeS4JqK9kvjNHqvJp2B
	 7w/87gmus3nvJGG0IijFjQwT3UlWetx+XpDQbASRDVmkhBdXJCpY0bNw3MyAvRXjzZ
	 Mdbv9aAiDqGR4EsuBktsgVmgXBsNALFrPOooeK1CTj6GQVujlOFUL2rRCzyxZUS597
	 oe3JhHWw7hb5lK01lD38Fbm9qkkAlUihxd6rW5pSOOwh3yV/vnSEZHlvgIjqehQ4Kz
	 VDRFXXEIyW+S6ix9cLOivydqkQU89lxNrWyEPfEGmC45j7D9Ug3JUvMfHHh7Bt1HMd
	 Wccpk8NSJUDOg==
Content-Type: multipart/mixed; boundary="===============6913404356296133904=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e875addc64c611bd8fb125f513b0c3b34af2ee69a9577d178526a18bc87d6dba@mail.kernel.org>
In-Reply-To: <20261105180923.3441359-3-irogers@google.com>
References: <20261105180923.3441359-3-irogers@google.com>
Subject: Re: [RFC PATCH v3 2/3] perf build: Prefer zlib-rs over zlib when available
From: bot+bpf-ci@kernel.org
To: irogers@google.com,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,jolsa@kernel.org,irogers@google.com,adrian.hunter@intel.com,qmo@kernel.org,ojeda@kernel.org,nathan@kernel.org,nsc@kernel.org
Cc: boqun@kernel.org,gary@garyguo.net,bjorn3_gh@protonmail.com,lossin@kernel.org,a.hindborg@kernel.org,aliceryhl@google.com,tmgross@umich.edu,dakr@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,linux-perf-users@vger.kernel.org,bpf@vger.kernel.org,rust-for-linux@vger.kernel.org,linux-kbuild@vger.kernel.org,llvm@lists.linux.dev,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 18:53:53 +0000 (UTC)

--===============6913404356296133904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> perf build: Prefer zlib-rs over zlib when available

TL;DR: install-build-deps.sh may fail entirely on Debian 13 (and possibly
Fedora) because the new zlib-rs package mapping names packages that may not
exist, with no availability check, so apt-get could install nothing.

> diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
> --- a/tools/perf/scripts/install-build-deps.sh
> +++ b/tools/perf/scripts/install-build-deps.sh

[ ... ]

> @@ -305,6 +308,9 @@ debian_pkg_for() {
>  	zlib)
>  		echo "zlib1g-dev"
>  		;;
> +	zlib-rs)
> +		echo "cargo librust-libz-rs-sys-dev"
> +		;;
>  	lzma)
>  		echo "liblzma-dev"
>  		;;

Will this break install-build-deps.sh on Debian 13 (trixie), which the
script header lists as validated?

trixie does not appear to ship librust-libz-rs-sys-dev, and unlike the RHEL
branch, the Debian/Ubuntu path in package_set() has no availability check
(pkg_available() is only used for RHEL).  The name goes straight into the
install command:

    echo "DEBIAN_FRONTEND=noninteractive apt-get update && \
          DEBIAN_FRONTEND=noninteractive apt-get install -y $*"

apt-get then fails with "E: Unable to locate package
librust-libz-rs-sys-dev" (exit 100) and installs nothing, including the
packages that are available.  main() prints "error: the install command
failed" and exits 1.

Before this patch zlib-rs had no case, so it was skipped via
[ -n "$pkg" ] || continue and the install worked.

The fedora_pkg_for() name rust-libz-rs-sys-devel is also added without a
check, so Fedora would fail the same way if it lacks that package.

Should debian_pkg_for() probe availability the way pkg_available() does for
dnf, or leave zlib-rs unmapped on distros that do not package the crate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42083491750
--===============6913404356296133904==--
